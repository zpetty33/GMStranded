--[[
	Name: WHM (Weather Manager)
	File: cl_whm_duststorm.lua
	For:
	By: Ultra
]]--

local Dust = {}
Dust.ID = 5
Dust.Name = "Dust Storm"

Dust.m_intIndoorFadeTime = 6
Dust.m_intVolumeOutside = 0.5
Dust.m_intVolumeInside = 0.1
Dust.m_intPitchOutside = 100
Dust.m_intPitchInside = 66

Dust.m_intMaxDustParts = 32
Dust.m_intPartUpdateRate = 0.1
Dust.m_strDustWindLoop = "whm/heavywind2.wav"
Dust.m_strDustWindLoop2 = "whm/wind_bass.wav"
Dust.m_tblTraceVectors = {
	Vector( 1, 1, 0 ),
	Vector( 1, -1, 0 ),
	Vector( -1, 1, 0 ),
	Vector( -1, -1, 0 ),
}
Dust.m_tblTraceHullVectors = {
	Vector( 1, 1, 0 ),
	Vector( 1, -1, 0 ),
	Vector( -1, 1, 0 ),
	Vector( -1, -1, 0 ),
	Vector( 1, 1, 1 ),
	Vector( 1, -1, 1 ),
	Vector( -1, 1, 1 ),
	Vector( -1, -1, 1 ),
	Vector( 0, 0, 0 )
}

function Dust:Start( intDuration, intTimeOffset )
	self.m_intStartTime = CurTime()
	self.m_intStartOffset = intTimeOffset or 0
	self.m_intDuration = intDuration

	self.m_intOutdoorFadeStart = nil
	self.m_intIndoorFadeStart = nil
	self.m_bFadingIn = false
	self.m_bFadingOut = false
	self.m_intFadeInOffset = nil
	self.m_intFadeOffset = nil
	self.m_intStartDustFadeTime = nil
	self.m_intStopTime = nil
	self.m_intDustScaler = nil

	self.m_intFadeInDustTime = 5
	self.m_intFadeOutDustTime = 45
	self.m_intFadeInTime = 45 +self.m_intFadeInDustTime
	self.m_intFadeOutTime = 5 +self.m_intFadeOutDustTime
	self.m_intDurationToFadeOut = intDuration -self.m_intFadeOutTime

	self.m_pDustSound = CreateSound( LocalPlayer(), self.m_strDustWindLoop )
	self.m_pDustSound2 = CreateSound( LocalPlayer(), self.m_strDustWindLoop2, LocalPlayer():EntIndex() +1 )
	
	self.m_pEmitter = ParticleEmitter( LocalPlayer():GetPos() )

	hook.Add( "GetMotionBlurValues", tostring(self), function() return self:GetMotionBlurValues() end )
end

function Dust:Stop()
	self.m_pDustSound:Stop()
	self.m_pDustSound2:Stop()
	self.m_pEmitter:Finish()

	hook.Remove( "GetMotionBlurValues", tostring(self) )
end

function Dust:Indoors()
	local bIndoors, plyPos, tr = 0, LocalPlayer():GetPos(), nil

	for _, vec in pairs( self.m_tblTraceVectors ) do
		local hull = vec *15
		tr = util.TraceLine{
			start = plyPos +hull, 
			endpos = plyPos +hull +(vector_up *1e9),
			filter = LocalPlayer()
		}

		if not tr.HitSky then
			bIndoors = bIndoors +1
		end
	end

	return bIndoors == 4
end

function Dust:TracePartHull( vecPos, intSize )
	local bIndoors, tr = 0, nil

	for _, vec in pairs( self.m_tblTraceHullVectors ) do
		local hull = vec *(intSize *2)
		tr = util.TraceLine{
			start = vecPos +hull, 
			endpos = vecPos +hull +(vector_up *1e9),
			filter = LocalPlayer(),
			mask = MASK_SOLID_BRUSHONLY,
		}

		if tr.HitSky then
			bIndoors = bIndoors +1
		end
	end

	return bIndoors == 9
end

function Dust:Think()
	local time = CurTime() +self.m_intStartOffset

	if self.m_bFadingOut or time > self.m_intStartTime +self.m_intDurationToFadeOut then
		if not self.m_intStopTime then
			self:FadeOut()
		end
		
		self:UpdateFadeOut()
	elseif time <= self.m_intStartTime +self.m_intFadeInTime then
		if not self.m_bFadingIn then
			self:FadeIn()
		end
		
		self:UpdateFadeIn()
	else
		self.m_bFadingIn = false
		self.m_bFadingOut = false

		self:UpdateWindSounds( 1 )
		self:UpdateParticles( 1 )
	end
end

function Dust:FadeIn()
	self.m_bFadingIn = true

	if self.m_intStartOffset > self.m_intFadeInDustTime then
		self.m_intFadeInOffset = self.m_intStartOffset -self.m_intFadeInDustTime
	end
end

function Dust:FadeOut()
	self.m_bFadingOut = true
	self.m_intStopTime = CurTime()

	if self.m_intStartOffset > self.m_intDurationToFadeOut then
		self.m_intFadeOffset = self.m_intStartOffset -self.m_intDurationToFadeOut
	end
end


function Dust:UpdateFadeIn()
	local time = CurTime() +(self.m_intFadeInOffset or 0)

	if time +self.m_intStartOffset <= self.m_intStartTime +self.m_intFadeInDustTime then
		return
	end

	if not self.m_intStartDustFadeTime then
		self.m_intStartDustFadeTime = CurTime()
	end

	local DustScaler = (time -self.m_intStartDustFadeTime) /self.m_intFadeInDustTime
	self:UpdateWindSounds( Lerp(DustScaler, 0, 1) )
	self:UpdateParticles( Lerp(DustScaler, 0, 1) )
end

function Dust:UpdateFadeOut()
	local time = CurTime() +(self.m_intFadeOffset or 0)

	if time < self.m_intStopTime +self.m_intFadeOutDustTime then
		local DustScaler = (time -self.m_intStopTime) /self.m_intFadeOutDustTime
		self:UpdateWindSounds( Lerp(DustScaler, 1, 0) )
		self:UpdateParticles( Lerp(DustScaler, 1, 0) )

		return
	end

	if self.m_pDustSound:IsPlaying() then
		self.m_pDustSound:FadeOut( 1 )
	end

	if self.m_pDustSound2:IsPlaying() then
		self.m_pDustSound2:FadeOut( 1 )
	end

	if time > self.m_intStopTime +self.m_intFadeOutTime then
		 WHM:ForceStop( self.ID )
	end
end

function Dust:UpdateWindSounds( intScaler )
	if not self.m_intCurVolume then
		self.m_intCurVolume = self.m_intVolumeOutside
		self.m_intCurPitch = self.m_intPitchOutside
	end

	if self:Indoors() then
		if not self.m_intIndoorFadeStart then
			self.m_intIndoorFadeStart = CurTime()
			self.m_intOutdoorFadeStart = nil
		end

		local fadeScaler = math.min( (CurTime() -self.m_intIndoorFadeStart) /self.m_intIndoorFadeTime, 1 )
		self.m_intCurVolume = Lerp( fadeScaler, self.m_intCurVolume, self.m_intVolumeInside )
		self.m_intCurPitch = Lerp( fadeScaler, self.m_intCurPitch, self.m_intPitchInside )
	else
		if not self.m_intOutdoorFadeStart then
			self.m_intOutdoorFadeStart = CurTime()
			self.m_intIndoorFadeStart = nil
		end

		local fadeScaler = math.min( (CurTime() -self.m_intOutdoorFadeStart) /self.m_intIndoorFadeTime, 1 )
		self.m_intCurVolume = Lerp( fadeScaler, self.m_intCurVolume, self.m_intVolumeOutside )
		self.m_intCurPitch = Lerp( fadeScaler, self.m_intCurPitch, self.m_intPitchOutside )
	end

	self.m_intCurVolume = self.m_intCurVolume *intScaler

	if not self.m_pDustSound:IsPlaying() then
		self.m_pDustSound:PlayEx( 0, 100 )
	else
		self.m_pDustSound:ChangeVolume( self.m_intCurVolume, 0 )
		self.m_pDustSound:ChangePitch( self.m_intCurPitch, 0 )
	end

	if not self.m_pDustSound2:IsPlaying() then
		self.m_pDustSound2:PlayEx( 0, 100 )
	else
		self.m_pDustSound2:ChangeVolume( self.m_intCurVolume, 0 )
		self.m_pDustSound2:ChangePitch( self.m_intCurPitch, 0 )		
	end
end

function Dust:UpdateParticles( intScaler )
	self.m_intDustScaler = intScaler

	if not self.m_intLastPartUpdate then
		self.m_intLastPartUpdate = CurTime()
	end

	if CurTime() < self.m_intLastPartUpdate +self.m_intPartUpdateRate then
		return
	else
		self.m_intLastPartUpdate = nil
	end

	for i = 1, math.Round(self.m_intMaxDustParts *intScaler) do
		local Size = math.random( 256, 512 )
		local pos = Vector( 
				LocalPlayer():GetPos().x +math.random( -2048, 3072 ),
				LocalPlayer():GetPos().y +math.random( -2048, 3072 ),
				2164 +math.random( -550, 650 )
			)

		if not self:TracePartHull( pos, Size ) then
			continue
		end
		
		local part = self.m_pEmitter:Add(
			"particles/smokey", 
			pos
		)

		if part then			
			part:SetColor( 210, 200, 150, 50 )
			part:SetVelocity( Vector(0, -math.random(200, 300), 0 ) )
			part:SetDieTime( 3 )
			part:SetGravity( Vector(0, -100, math.random(-70, 50)) )
			part:SetStartSize( Size )
			part:SetEndSize( Size )
			part:SetCollide( true )
			part:SetBounce( 0.5 )
			part:SetCollideCallback( function( part, hitpos )
				part:SetDieTime( 0 )
			end )
			part:SetThinkFunction( function( p )
				if not self:TracePartHull( p:GetPos(), Size ) then
					p:SetDieTime( 0 )
				end

				p:SetNextThink( CurTime() +0.1 )
			end )
		end
	end
end

function Dust:RenderScreenspaceEffects()
	local scaler
	if self.m_bFadingOut then
		local time = CurTime() +(self.m_intFadeOffset or 0)
		local stop = self.m_intStopTime +self.m_intFadeOutTime
		scaler = (time -stop) /self.m_intFadeOutTime
	end

	DrawColorModify{
		["$pp_colour_addr"] = Lerp( self.m_intDustScaler or 0, 0, 0.1 ),
		["$pp_colour_addg"] = Lerp( self.m_intDustScaler or 0, 0, 0.08 ),
		["$pp_colour_addb"] = Lerp( self.m_intDustScaler or 0, 0, 0.05 ),
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}
	DrawBloom( Lerp((self.m_intDustScaler or 0), 1, 0.66) or 0, 0.35, 2.5, 2.5, 1, 0.1, 255 /255, 200 /255, 200 /255 )
end

function Dust:PostDrawTranslucentRenderables()
end

function Dust:GetMotionBlurValues( x, y, fwd, spin )
	if not self:Indoors() then
		if EyePos().z <= 3300 then
			return 0, 0, Lerp((self.m_intDustScaler or 0), 0, 0.05), 0
		else
			return 0, 0, 0, 0
		end
	else
		return 0, 0, 0, 0
	end
end

WHM:Register( Dust )