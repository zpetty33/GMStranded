local world = {}
world.Name		= "PVP World"
world.SkyPos 	= 8190
world.pvp		= true
world.Bounds	= {
	[1] = {
		Min = Vector( 1962, -10322, 6155 ),
		Max = Vector( 13338, 1121, 8253 )
	},
}
world.Gravity		= 1.0
world.expmod = 1.25
world.ZombieSpawns	= true
world.BreakableStructures = true
world.BreakableStructuresTbl = {
		"gms_prop",
		"gms_furnace",
		"gms_stove",
		"gms_workbench",
		"gms_workbench2",
		"gms_gemtable",
		"gms_grindingstone",
		"gms_rcache",
		"gms_tcache",
		"gms_ptcache",
		"gms_resourcedrop",
		"gms_spawnpoint",
		"gms_torch",
		"gms_firebrazier",
		"gms_walllantern",
		"gms_firelamp",
		"gms_lamp",
		"gms_lamp2",
		"gms_lamp3",
		"gms_lamp4",
		"gms_beacon",
		"gms_beacon2",
		"gms_beacon3",
		"gms_door1",
		"gms_door2",
		"gms_door3",
		"gms_door4",
		"gms_door5",
		"gms_doorbeta",
		"gms_pcache",
		"gms_pcache2",
		"gms_pcache3",
		"gms_pcache4",
		"gms_pcacheboss",
		"gms_alchlab",
		"prop_vehicle_prisoner_pod",
		"gms_sign",
		"gms_sink",
		"gms_bed",
		"gms_radio",
		"gms_tv",
		"gms_gardenblock",
		"gms_gardengnome",
		"gms_pethouse",
		"gms_incubator",
		"gms_firework_red",
		"gms_firework_green",
		"gms_firework_blue",
		"gms_firework_yellow",
		"gms_firework_cyan",
		"gms_firework_purple",
		"gms_firework_white",
		"gms_firework_rainbow",
		"gms_bossspawner",
		"gms_bossspawner_hunter",
		"gms_arcaneforge",
		"gms_totem_mining",
		"gms_totem_woodcutting",
		"gms_totem_farming",
		"gms_totem_fishing",
		"gms_totem_smithing",
		"gms_totem_cooking",
		"gms_totem_construction",
		"gms_totem_combat",
		"gms_totem_alchemy",
		"gms_totem_arcane",
		"gms_antlionheadtrophy", 
		"gms_aidbench"
	}
world.Entities	= {
}
world.SkyObjects = {
	{
		ClassName = "CPlanet", --Class name, this one is a planet
		BodyName = "GasGiant", --Name of the planet
		SurfaceTexture = "planets/gas_green", --Texture of the planet surface
		Radius = 768, --Radius of the planet
		Color = Color( 200, 200, 200, 255 ), --Color of the object
		AxisTilt = Angle( 22.5, -43, 0 ),

		--Clouds & Atmo
		CloudTexture = "gamey/planets/planet_clouds01", --Texture of the cloud layer
		HasAtmosphere = false, --Draws the glow effect (cheap atmo)
		AtmoColor = Color( 200, 255, 200, 255 ), --Color of the atmo glow
		AtmoScale = 2.5, --Scale of the glow effect

		HasClouds = false, --Draws the cloud layer
		CloudScale = 1.005, --Scale of the cloud layer
		CloudColor = Color( 255, 255, 255, 255 ), --Color of the cloud layer
		CloudRotation = Angle( 0, 0, 0 ), --Rotation speed of the cloud layer

		Orbit = { --Table of data about the planet's orbit in the sky
			Radius = 3100, --Distance from the planet to the world center
			Inclination = -1.746, --Tilt of the orbit in the sky : radians
			RotationR = 245, -- : angles
			RotationY = 0, -- : angles
			RiseAng = 90,
			SetAng = -270,
			ParentName = nil, --String of the parent body name to orbit around, nil for 0 0 0
		},
		Day = { --Table of data about the planet's day cycle (rotation)
			Duration = 1440,
			RetrogradeRotation = true, --Does the planet spin backwards?
		},
		Lighting = { --Table of data about the lighting the planet has
			Origin = Vector( 0 ), --Where the light is in the sky
			ParentIsLight = false, --Should the light origin be the parent pos?
			Color = Color( 240, 220, 110, 255 ),  --The color of the light cast on the planet
		},
		Rings = {
			RingScale = 5000,
			RingTexture = "planets/rings_1",
			RingNorm = Angle( 43, 22.5, 0 ):Up(),
			Color = Color( 0, 255, 0, 255 )
		}
	},
}

--[[ World Weather ]]--
world.Weather = {
	Current = nil,
	RandWeatherTime = { min = 120, max = 420 },
	WeatherChangeChance = 8,

	Types = { 1, 1, 3, 3, 3 },
}

function world:Think()
	if SERVER then
		if not self.Weather.StopTime then
			self.Weather.StopTime = CurTime() +math.random( self.Weather.RandWeatherTime.min, self.Weather.RandWeatherTime.max )
		end

		if CurTime() > self.Weather.StopTime then --weather status update
			if self.Weather.Current ~= nil then --stop this status
				self.Weather.Current = nil
			elseif math.random( 1, self.Weather.WeatherChangeChance ) == 1 then --pick a type and start it
				self.Weather.Current = table.Random( self.Weather.Types )
			end

			self.Weather.StartTime = CurTime()
			self.Weather.Duration = math.random( self.Weather.RandWeatherTime.min, self.Weather.RandWeatherTime.max )
			self.Weather.StopTime = self.Weather.StartTime +self.Weather.Duration

			GAMEMODE.Worlds:BroadcastWeatherStatus( nil, self.Name, self.Weather.Current, self.Weather.StartTime, self.Weather.StopTime )
			hook.Call( "SGS_WorldWeatherChanged", GAMEMODE, self, self.Weather.Current )
		end
	end
end

GM.Worlds:RegisterWorld( world )