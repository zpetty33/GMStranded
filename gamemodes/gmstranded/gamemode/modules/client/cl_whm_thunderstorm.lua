--[[
	Name: WHM (Weather Manager)
	File: cl_whm_thunderstorm.lua
	For:
	By: Ultra
]]--

CreateClientConVar( "sgs_rain_volume", "1", true, false )
local vector_up, vector_down = Vector( 0, 0, 1 ), Vector( 0, 0, -1 )

local Rain = {}
Rain.ID = 3
Rain.Name = "Thunder Storm"
Rain.m_tblThunderTime = { min = 8, max = 30 }
Rain.m_bHasLightning = true

Rain.m_intIndoorFadeTime = 3
Rain.m_intVolumeOutside = 0.8
Rain.m_intVolumeInside = 0.35
Rain.m_intPitchOutside = 100
Rain.m_intPitchInside = 50

Rain.m_intMaxRainParts = 32
Rain.m_intPartUpdateRate = 0.15

Rain.m_tblTraceVectors = {
	Vector( 15, 15, 0 ),
	Vector( 15, -15, 0 ),
	Vector( -15, 15, 0 ),
	Vector( -15, -15, 0 ),
}
Rain.m_tblSounds = {
	Lightning = {
		"whm/lightning_strike_1.mp3",
		"whm/lightning_strike_2.mp3",
		"whm/lightning_strike_3.mp3",
		"whm/lightning_strike_4.mp3",
	},
	Thunder = {
		[1] = {	--Close
			"whm/thunder_close01.mp3",
			"whm/thunder_close02.mp3",
			"whm/thunder_close03.mp3",
			"whm/thunder_close04.mp3",
		}, 
		[2] = {	--Kinda Close
			"whm/thunder_1.mp3",
			"whm/thunder_2.mp3",
			"whm/thunder_3.mp3",
			"whm/thunder_distant01.mp3",
			"whm/thunder_distant02.mp3",
			"whm/thunder_distant03.mp3",
		}, 
		[3] = {	--Distant
			"whm/thunder_far_away_1.mp3",
			"whm/thunder_far_away_2.mp3",
		}, 
	},
	RainLoop = "whm/crucial_surfacerain_med_loop.wav",
}

function Rain:Start( intDuration, intTimeOffset )
	self.m_intStartTime = CurTime()
	self.m_intStartOffset = intTimeOffset or 0
	self.m_intDuration = intDuration
	self.m_intOutdoorFadeStart = nil
	self.m_intIndoorFadeStart = nil

	--these were random, but lets hard code them so we don't have to network it lol
	self.m_intFadeInRainTime = 25 --math.random( self.m_tblRainTime.min, self.m_tblRainTime.max )
	self.m_intFadeOutRainTime = 30 --math.random( self.m_tblRainTime.min, self.m_tblRainTime.max )
	self.m_intFadeInTime = 25 +self.m_intFadeInRainTime --math.random( self.m_tblFadeInTime.min, self.m_tblFadeInTime.max ) +self.m_intFadeInRainTime
	self.m_intFadeOutTime = 30 +self.m_intFadeOutRainTime --math.random( self.m_tblFadeOutTime.min, self.m_tblFadeOutTime.max ) +self.m_intFadeOutRainTime

	self.m_intDurationToFadeOut = intDuration -self.m_intFadeOutTime

	--reset som stuff
	self.m_bFadingIn = false
	self.m_bFadingOut = false
	self.m_intRainScaler = 0
	self.m_intStopTime = nil
	self.m_intStartRainFadeTime = nil
	self.m_intFadeOffset = nil
	self.m_intFadeInOffset = nil

	self.m_intRainMat = Material( "whm/rain_bunch" )
	self.m_tblRainParts	= {}

	self.m_pEmitter = ParticleEmitter( Vector(0) )
	self.m_pEmitter3D = ParticleEmitter( Vector(0), true )
	self.m_angAngleUp = Angle( -90, 0, 0 )

	self.m_pRainSound = CreateSound( LocalPlayer(), self.m_tblSounds.RainLoop )
end

function Rain:Stop()
	self.m_pRainSound:Stop()
end

function Rain:Indoors()
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

function Rain:Think()
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

		self:UpdateRainFX( 1 )
		self:UpdateRainSounds( 1 )
		self:PlayThunderFX()
	end
end

function Rain:FadeIn()
	self.m_bFadingIn = true

	if self.m_intStartOffset > self.m_intFadeInRainTime then
		self.m_intFadeInOffset = self.m_intStartOffset -self.m_intFadeInRainTime
	end
end

function Rain:FadeOut()
	self.m_bFadingOut = true
	self.m_intStopTime = CurTime()

	if self.m_intStartOffset > self.m_intDurationToFadeOut then
		self.m_intFadeOffset = self.m_intStartOffset -self.m_intDurationToFadeOut
	end
end

function Rain:UpdateFadeIn()
	local time = CurTime() +(self.m_intFadeInOffset or 0)

	self:PlayThunderFX()

	if time +self.m_intStartOffset <= self.m_intStartTime +self.m_intFadeInRainTime then
		return
	end

	if not self.m_intStartRainFadeTime then
		self.m_intStartRainFadeTime = CurTime()
	end

	local rainScaler = (time -self.m_intStartRainFadeTime) /self.m_intFadeInRainTime
	self:UpdateRainFX( Lerp(rainScaler, 0, 1) )
	self:UpdateRainSounds( Lerp(rainScaler, 0, 1) )
end

function Rain:UpdateFadeOut()
	local time = CurTime() +(self.m_intFadeOffset or 0)

	self:PlayThunderFX()

	if time < self.m_intStopTime +self.m_intFadeOutRainTime then --During rain particle fade out
		local rainScaler = (time -self.m_intStopTime) /self.m_intFadeOutRainTime
		self:UpdateRainFX( Lerp(rainScaler, 1, 0) )
		self:UpdateRainSounds( Lerp(rainScaler, 1, 0) )

		return
	end

	if self.m_pRainSound:IsPlaying() then
		self.m_pRainSound:FadeOut( 1 )
	end

	if time > self.m_intStopTime +self.m_intFadeOutTime then
		 WHM:ForceStop( self.ID )
	end
end

--FX
function Rain:PlayThunderFX()
	if not self.m_intLastThunderTime then
		self.m_intLastThunderTime = math.random( self.m_tblThunderTime.min, self.m_tblThunderTime.max ) +CurTime()
		return
	end

	if CurTime() >= self.m_intLastThunderTime then
		if self.m_bHasLightning and math.random( 1, 2 ) == 1 and (not self.m_bFadingIn and not self.m_bFadingOut) then
			sound.Play( table.Random(self.m_tblSounds.Lightning), LocalPlayer():GetPos(), 140, math.random(70, 120), math.Rand(0.4, 1) )
			self.m_intLastLightFX = CurTime()
			return
		end

		local pos = LocalPlayer():GetPos() +Vector( math.random(-100, 100), math.random(-100, 100), 50 )
		local volume = self.m_intRainScaler <= 0.3 and math.Rand( 0.6, 0.8 ) or math.Rand( 0.8, 0.9 )
		if self.m_bFadingIn then --during fadein
			sound.Play( table.Random(self.m_tblSounds.Thunder[3]), pos, 120, math.random(70, 120), volume )
		elseif self.m_bFadingOut then--fadeout
			sound.Play( table.Random(self.m_tblSounds.Thunder[3]), pos, 120, math.random(70, 120), volume )
		else --otherwise
			sound.Play( table.Random(self.m_tblSounds.Thunder[2]), pos, 150, math.random(80, 130), 1 )
		end

		self.m_intLastThunderTime = nil
	end
end

function Rain:UpdateRainFX( intRainScaler )
	if not self.m_intLastPartUpdate then
		self.m_intLastPartUpdate = CurTime()
	end

	if CurTime() < self.m_intLastPartUpdate +self.m_intPartUpdateRate then
		return
	else
		self.m_intLastPartUpdate = nil
	end

	--rain stuff
	self:AddRainParts( math.Round(self.m_intMaxRainParts *intRainScaler))
	self.m_intRainScaler = intRainScaler
end

function Rain:UpdateRainSounds( intScaler )
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

	if not self.m_pRainSound:IsPlaying() then
		self.m_pRainSound:PlayEx( 0, 100 )
	else
		self.m_pRainSound:ChangeVolume( self.m_intCurVolume *GetConVarNumber("sgs_rain_volume"), 0 )
		self.m_pRainSound:ChangePitch( self.m_intCurPitch, 0 )
	end
end

--Render stuff
function Rain:AddRainParts( intAmount )
	local zPos = GAMEMODE.Worlds:GetEntityWorldSpace( LocalPlayer() )
	if zPos then
		zPos = zPos.SkyPos
	else
		local vecPlayerPos = LocalPlayer():GetPos()
		local zPos = util.TraceLine{
			start = vecPlayerPos, 
			endpos = vecPlayerPos +(vector_up *1024),
			filter = LocalPlayer()
		}

		zPos = zPos.HitSky and zPos.HitPos.z or (vecPlayerPos +Vector(0, 0, 1024)).z
	end
	
	local time = CurTime()
	for i = 1, intAmount do
		table.insert( self.m_tblRainParts, {
			relpos = Vector( math.Rand(-250, 250), math.Rand(-250, 250), zPos ),
			pos = Vector( 0, 0, zPos ),
			vel = Vector( 0, 0, -math.Rand(1500, 2000) ),
			start = time
		} )
	end
end

local sw, sh = ScrW(), ScrH()
local time, ftime, tr, temp
local plyPos, faceAng
function Rain:UpdateRenderRain()
	local time, ftime, tr, temp = CurTime(), FrameTime(), nil, nil
	local plyPos, faceAng = LocalPlayer():GetPos(), Angle(0, EyeAngles().y, 0):Forward() *-1
	plyPos = plyPos +(faceAng *-200)

	render.SetMaterial( self.m_intRainMat )
	render.SuppressEngineLighting( true )
	for k, v in pairs( self.m_tblRainParts ) do
		if time >= v.start +6 then
			self.m_tblRainParts[k] = nil
			continue
		end


		tr = util.TraceLine{ start = v.pos, endpos = v.pos +(vector_down *64), mask = bit.bor(MASK_WATER, MASK_SOLID) }
		temp = plyPos +v.relpos
		v.pos.x = temp.x
		v.pos.y = temp.y
		v.pos = v.pos +(v.vel *ftime)

		if tr and tr.Hit then
			self.m_tblRainParts[k] = nil
			
			render.DrawQuadEasy(
				tr.HitPos +tr.HitNormal *32,
				faceAng,
				16, 32,
				color_white,
				180
			)

			self:FX_RainHit( tr.HitPos, tr.MatType == MAT_SLOSH )
		else
			if math.abs(v.pos.z -plyPos.z) > 1024 then continue end
			temp = v.pos:ToScreen()
			if temp.x > sw or temp.x <= 0 then continue end
			if temp.y > sh or temp.y <= 0 then continue end

			render.DrawQuadEasy(
				v.pos,
				faceAng,
				16, 32,
				color_white,
				180
			)
		end

		tr = nil
	end
	render.SuppressEngineLighting( false )
end

function Rain:FX_RainHit( vecHitPos, bHitWater )
	if bHitWater then
		bHitWater = self.m_pEmitter3D:Add( "whm/warp_ripple", vecHitPos )
		bHitWater:SetColor( 255, 255, 255, 255 )
		bHitWater:SetDieTime( 0.6 )
		bHitWater:SetStartSize( math.Rand(4, 8) )
		bHitWater:SetEndSize( 0 )
		bHitWater:SetAngles( self.m_angAngleUp )
		return
	end

	bHitWater = self.m_pEmitter:Add( "whm/warp_ripple", vecHitPos )
	bHitWater:SetColor( 255, 255, 255, 255 )
	bHitWater:SetDieTime( 0.15 )
	bHitWater:SetStartSize( math.Rand(2, 3) )
	bHitWater:SetEndSize( 1 )
	bHitWater = self.m_pEmitter:Add( "particle/water/waterdrop_001a", vecHitPos )
	bHitWater:SetColor( 255, 255, 255, 255 )
	bHitWater:SetDieTime( 0.15 )
	bHitWater:SetStartSize( math.Rand(0.25, 0.5) )
	bHitWater:SetEndSize( 0 )
end

function Rain:RenderScreenspaceEffects()
	if self.m_intLastLightFX and util.IsSkyboxVisibleFromPoint( EyePos() ) then
		local time = CurTime()

		if time <= (self.m_intLastLightFX +0.2) then
			local scaler = Lerp((time -self.m_intLastLightFX) /0.2, 0.75, 1)
			DrawBloom( scaler, math.Rand(1.75, 2.75), 9, 9, 2, 1, 0.1, 0.1, 0.1 )
			DrawColorModify{
				["$pp_colour_addr"] = 0,
				["$pp_colour_addg"] = 0,
				["$pp_colour_addb"] = 0.02,
				["$pp_colour_brightness"] = Lerp((time -self.m_intLastLightFX) /0.2, 0.33, 0),
				["$pp_colour_contrast"] = 1,
				["$pp_colour_colour"] = Lerp((time -self.m_intLastLightFX) /0.2, 0.2, 1),
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0.02
			}
		else
			self.m_intLastLightFX = nil
		end
	else
		DrawColorModify{
			["$pp_colour_addr"] = 0,
			["$pp_colour_addg"] = 0,
			["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = Lerp( self.m_intRainScaler, 1, 0.5 ),
			["$pp_colour_colour"] = Lerp( self.m_intRainScaler, 1, 0.9 ),
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		}
	end
end

function Rain:PostDrawTranslucentRenderables()
	self:UpdateRenderRain()
end

WHM:Register( Rain )