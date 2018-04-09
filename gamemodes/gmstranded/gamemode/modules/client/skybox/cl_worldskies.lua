GM.Sky = {}
GM.Sky.m_tblCurrentSky = {}

include "gmstranded/gamemode/modules/client/skybox/sh_class.lua"
include "gmstranded/gamemode/modules/client/skybox/CBaseStellarObject.lua"
include "gmstranded/gamemode/modules/client/skybox/CStellarObjects.lua"
include "gmstranded/gamemode/modules/client/skybox/CSolarCamera.lua"

function GM.Sky:Initialize()
	hook.Add( "SGSPlayerChangedWorld", "WorldSkies", function( pPlayer, tblWorld )
		if pPlayer ~= LocalPlayer() then return end
		self:WorldChanged( tblWorld )
	end )
	hook.Add( "RenderScreenspaceEffects", "WorldSkies", function()
		self:RenderScreenspaceEffects()
	end )
	hook.Add( "DayLightUpdateTime", "WorldSkies", function( intMin )
		self.m_intMin = intMin
	end )
	hook.Add( "sgs_updatebloodmoon", "WorldSkies", function( bBloodmoon )
		if bBloodmoon then self:OnBloodMoonStart() else self:OnBloodMoonStop() end
	end )

	self.m_pCamera = SkyObj.CSolarCamera:New()
end

function GM.Sky:FindObject( strName )
	return self.m_pCamera:FindObject( strName )
end

function GM.Sky:AddObject( insStellarObject )
	self.m_pCamera:AddObject( insStellarObject )
end

function GM.Sky:ParseAddObject( tblSkyObject )
	local object = SkyObj[tblSkyObject.ClassName]:New()
	self:AddObject( object )
	object:ParseWorldPreset( tblSkyObject )
end

function GM.Sky:WorldChanged( tblNewWorld )
	if self.m_bInBloodMoon then return end
	self.m_pCamera:ClearSky()
	if not tblNewWorld.SkyObjects then return end
	
	for k, v in ipairs( tblNewWorld.SkyObjects ) do
		self:ParseAddObject( v )
	end
end

function GM.Sky:OnBloodMoonStart()
	self.m_pCamera:ClearSky()
	self:InjectBloodMoon()
	self.m_bInBloodMoon = true
end

function GM.Sky:OnBloodMoonStop()
	self.m_bInBloodMoon = false
	self:WorldChanged( GAMEMODE.Worlds:GetEntityWorldSpace(LocalPlayer()) )
end

function GM.Sky:InjectDeathStar()
	self:ParseAddObject{
		ClassName = "CSprite", --Class name, this one is a sprite
		BodyName = "DeathStar", --Name of the planet
		SurfaceTexture = "planets/death_star", --Texture of the planet surface
		Radius = 0.09, --Radius of the planet
		Color = Color( 255, 255, 255, 255 ), --Color of the object
		AxisTilt = Angle( 0, 0, 0 ),

		Orbit = { --Table of data about the planet's orbit in the sky
			Radius = 2, --Distance from the planet to the world center
			Inclination = -1.746, --Tilt of the orbit in the sky : radians
			RotationR = 245, -- : angles
			RotationY = 0, -- : angles
			ParentName = "Moon1", --String of the parent body name to orbit around, nil for 0 0 0
			ChildOrbitDuration = 0,
			Retrograde = false,
			ElevationOffset = 0,
			Elevation = 0,
		},
		Lighting = { --Table of data about the lighting the planet has
			Origin = Vector( 0 ), --Where the light is in the sky
			ParentIsLight = false, --Should the light origin be the parent pos?
			Color = Color( 240, 220, 110, 255 ),  --The color of the light cast on the planet
		},
	}
end

function GM.Sky:InjectBloodMoon()
	self:ParseAddObject{
		ClassName = "CPlanet", --Class name, this one is a planet
		BodyName = "BloodMoon2", --Name of the planet
		SurfaceTexture = "planets/blood_moon", --Texture of the planet surface
		Radius = 0.9, --Radius of the planet
		Color = Color( 255, 255, 255, 255 ), --Color of the object
		AxisTilt = Angle( 22.5, -90, 0 ),
	
		--Clouds & Atmo
		CloudTexture = "planets/planet_clouds01", --Texture of the cloud layer
		HasAtmosphere = true, --Draws the glow effect (cheap atmo)
		AtmoColor = Color( 255, 0, 0, 255 ), --Color of the atmo glow
		AtmoScale = 2.33, --Scale of the glow effect
	
		HasClouds = false, --Draws the cloud layer
		CloudScale = 1.005, --Scale of the cloud layer
		CloudColor = Color( 255, 255, 255, 255 ), --Color of the cloud layer
		CloudRotation = Angle( 0, 0, 0 ), --Rotation speed of the cloud layer
	
		Orbit = { --Table of data about the planet's orbit in the sky
			Radius = 10, --Distance from the planet to the world center
			Inclination = -1.746, --Tilt of the orbit in the sky : radians
			RotationR = 245, -- : angles
			RotationY = 0, -- : angles
			ParentName = "BloodMoon", --String of the parent body name to orbit around, nil for 0 0 0
			ChildOrbitDuration = 45,
		},
		Lighting = { --Table of data about the lighting the planet has
			Origin = Vector( 0 ), --Where the light is in the sky
			ParentIsLight = false, --Should the light origin be the parent pos?
			Color = Color( 240, 220, 110, 255 ),  --The color of the light cast on the planet
		},
	}
end

function GM.Sky:RenderScreenspaceEffects()
	if not self.m_bInBloodMoon or not self.m_intMin then return end

	local startFade, stopFade = 1320, 1440
	local startFadeOut, stopFadeOut = 180, 300
	local scaler = 1

	if self.m_intMin >startFade then
		scaler = math.Clamp( math.abs((self.m_intMin -startFade) /(startFade -stopFade)), 0, 1 )
	elseif self.m_intMin >startFadeOut then
		scaler = math.Clamp( math.abs((self.m_intMin -startFadeOut) /(startFadeOut -stopFadeOut)), 0, 1 )
		scaler = Lerp( scaler, 1, 0 )
	end

	DrawColorModify{
		["$pp_colour_addr"] = Lerp( scaler, 0, 0.1 ),
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = Lerp( scaler, 1, 0.8 ),
		["$pp_colour_colour"] = 1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}	
end

GM.Sky:Initialize()