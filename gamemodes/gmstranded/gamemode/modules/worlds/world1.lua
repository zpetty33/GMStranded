local world = {}
world.Name		= "Spawn World"
world.SkyPos 	= 3000
world.Bounds	= {
	[1] = {
		Min = Vector( -11248, -11248, -500 ),
		Max = Vector( 11248, 11248, 3465 )
	},
}
world.Gravity		= 1.0
world.ZombieSpawns	= true
world.Entities	= {
}
world.expmod = 1.0
--[[ World Skybox ]]--
world.SkyObjects = {
	{
		ClassName = "CPlanet", --Class name, this one is a planet
		BodyName = "Moon1", --Name of the planet
		SurfaceTexture = "planets/rocky_1", --Texture of the planet surface
		Radius = 0.9, --Radius of the planet
		Color = Color( 255, 255, 255, 255 ), --Color of the object
		AxisTilt = Angle( 22.5, -33, 0 ),
	
		--Clouds & Atmo
		CloudTexture = "planets/planet_clouds01", --Texture of the cloud layer
		HasAtmosphere = true, --Draws the glow effect (cheap atmo)
		AtmoColor = Color( 200, 200, 255, 255 ), --Color of the atmo glow
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
			ParentName = nil, --String of the parent body name to orbit around, nil for 0 0 0
		},
		Day = { --Table of data about the planet's day cycle (rotation)
			Duration = 1440 *2,
			RetrogradeRotation = false, --Does the planet spin backwards?
		},
		Lighting = { --Table of data about the lighting the planet has
			Origin = Vector( 0 ), --Where the light is in the sky
			ParentIsLight = false, --Should the light origin be the parent pos?
			Color = Color( 240, 220, 110, 255 ),  --The color of the light cast on the planet
		},
	},
}

--[[ World Weather ]]--
world.Weather = {
	Current = nil,
	RandWeatherTime = { min = 120, max = 420 },
	WeatherChangeChance = 10,

	Types = { 1, 1, 1, 3, 3 },
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