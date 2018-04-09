--[[
	Name: WHM (Weather Manager)
	File: cl_whm_snow.lua
	For:
	By: Ultra
]]--

local Snow = {}
Snow.ID = 4
Snow.Name = "Light Snow"

Snow.m_intIndoorFadeTime = 3
Snow.m_intVolumeOutside = 0.5
Snow.m_intVolumeInside = 0.1
Snow.m_intPitchOutside = 100
Snow.m_intPitchInside = 40

Snow.m_intMaxSnowParts = 48
Snow.m_intPartUpdateRate = 0.1
Snow.m_strSnowWindLoop = "whm/csgo_dust_wind_lp_01.wav"
Snow.m_tblTraceVectors = {
	Vector( 15, 15, 0 ),
	Vector( 15, -15, 0 ),
	Vector( -15, 15, 0 ),
	Vector( -15, -15, 0 ),
}

function Snow:Start( intDuration, intTimeOffset )
	self.m_intStartTime = CurTime()
	self.m_intStartOffset = intTimeOffset or 0
	self.m_intDuration = intDuration

	self.m_intOutdoorFadeStart = nil
	self.m_intIndoorFadeStart = nil
	self.m_bFadingIn = false
	self.m_bFadingOut = false
	self.m_intFadeInOffset = nil
	self.m_intFadeOffset = nil
	self.m_intStartSnowFadeTime = nil
	self.m_intStopTime = nil
	self.m_intSnowScaler = nil

	self.m_intFadeInSnowTime = 10
	self.m_intFadeOutSnowTime = 10
	self.m_intFadeInTime = 5 +self.m_intFadeInSnowTime
	self.m_intFadeOutTime = 5 +self.m_intFadeOutSnowTime
	self.m_intDurationToFadeOut = intDuration -self.m_intFadeOutTime

	self.m_pSnowSound = CreateSound( LocalPlayer(), self.m_strSnowWindLoop )
	self.m_pEmitter = ParticleEmitter( LocalPlayer():GetPos() )
end

function Snow:Stop()
	self.m_pSnowSound:Stop()
	self.m_pEmitter:Finish()
end

function Snow:Indoors()
	local bIndoors, plyPos, tr = 0, LocalPlayer():GetPos(), nil

	for _, vec in pairs( self.m_tblTraceVectors ) do
		tr = util.TraceLine{
			start = plyPos +vec, 
			endpos = plyPos +vec +(vector_up *1e9),
			filter = LocalPlayer()
		}

		if not tr.HitSky then
			bIndoors = bIndoors +1
		end
	end

	return bIndoors == 4
end

function Snow:Think()
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

function Snow:FadeIn()
	self.m_bFadingIn = true

	if self.m_intStartOffset > self.m_intFadeInSnowTime then
		self.m_intFadeInOffset = self.m_intStartOffset -self.m_intFadeInSnowTime
	end
end

function Snow:FadeOut()
	self.m_bFadingOut = true
	self.m_intStopTime = CurTime()

	if self.m_intStartOffset > self.m_intDurationToFadeOut then
		self.m_intFadeOffset = self.m_intStartOffset -self.m_intDurationToFadeOut
	end
end


function Snow:UpdateFadeIn()
	local time = CurTime() +(self.m_intFadeInOffset or 0)

	if time +self.m_intStartOffset <= self.m_intStartTime +self.m_intFadeInSnowTime then
		return
	end

	if not self.m_intStartSnowFadeTime then
		self.m_intStartSnowFadeTime = CurTime()
	end

	local snowScaler = (time -self.m_intStartSnowFadeTime) /self.m_intFadeInSnowTime
	self:UpdateWindSounds( Lerp(snowScaler, 0, 1) )
	self:UpdateParticles( Lerp(snowScaler, 0, 1) )
end

function Snow:UpdateFadeOut()
	local time = CurTime() +(self.m_intFadeOffset or 0)

	if time < self.m_intStopTime +self.m_intFadeOutSnowTime then
		local snowScaler = (time -self.m_intStopTime) /self.m_intFadeOutSnowTime
		self:UpdateWindSounds( Lerp(snowScaler, 1, 0) )
		self:UpdateParticles( Lerp(snowScaler, 1, 0) )

		return
	end

	if self.m_pSnowSound:IsPlaying() then
		self.m_pSnowSound:FadeOut( 1 )
	end

	if time > self.m_intStopTime +self.m_intFadeOutTime then
		 WHM:ForceStop( self.ID )
	end
end

function Snow:UpdateWindSounds( intScaler )
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

	if not self.m_pSnowSound:IsPlaying() then
		self.m_pSnowSound:PlayEx( 0, 100 )
	else
		self.m_pSnowSound:ChangeVolume( self.m_intCurVolume, 0 )
		self.m_pSnowSound:ChangePitch( self.m_intCurPitch, 0 )
	end
end

function Snow:UpdateParticles( intScaler )
	self.m_intSnowScaler = intScaler

	if not self.m_intLastPartUpdate then
		self.m_intLastPartUpdate = CurTime()
	end

	if CurTime() < self.m_intLastPartUpdate +self.m_intPartUpdateRate then
		return
	else
		self.m_intLastPartUpdate = nil
	end

	local zPos = GAMEMODE.Worlds:GetEntityWorldSpace( LocalPlayer() )
	if zPos then zPos = zPos.SkyPos end
	zPos = zPos or LocalPlayer():GetPos().z +950

	for i = 1, math.Round(self.m_intMaxSnowParts *intScaler) do
		local part = self.m_pEmitter:Add(
			"sprites/glow04_noz", 
			Vector( 
				LocalPlayer():GetPos().x +math.random( -2048, 2048 ), 
				LocalPlayer():GetPos().y +math.random( -2048, 2048 ), 
				zPos
			)
		)
		
		if part then
			local Size = math.random( 4, 7 )
			
			part:SetColor( 255, 255, 255, 255 )
			part:SetVelocity( Vector( 40, 25, -math.random(300, 400) ) )
			part:SetDieTime( 4.5 )
			part:SetGravity( Vector(40, 0, -250) )
			part:SetLifeTime( 0 )
			part:SetStartSize( Size /2 )
			part:SetEndSize( Size )
			part:SetCollide( true )
			part:SetCollideCallback( function( part, hitpos )
				part = nil
			end )
		end
	end
end

function Snow:RenderScreenspaceEffects()
	DrawBloom( Lerp((self.m_intSnowScaler or 0), 1, 0.8) or 0, 0.35, 2.5, 2.5, 1, 0, 240 /255, 240 /255, 240 /255 )
end

function Snow:PostDrawTranslucentRenderables()
end

WHM:Register( Snow )