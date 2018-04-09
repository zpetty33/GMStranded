local world = {}
world.Name		= "Pyramid World"
world.SkyPos 	= 5245
world.Bounds	= {
	[1] = {
		Min = Vector( -2095, -15405, 1463 ),
		Max = Vector( 14544, -2946, 5283 )
	},
	[2] = {
		Min = Vector( 2050, -3226, 1463 ),
		Max = Vector( 14321, 1135, 5283 )
	},
}
world.Gravity		= 1.0
world.ZombieSpawns	= true
world.Entities	= {
}
world.expmod = 1.1
world.SkyObjects = {
	{
		ClassName = "CPlanet", --Class name, this one is a planet
		BodyName = "GasGiant", --Name of the planet
		SurfaceTexture = "planets/gas_red", --Texture of the planet surface
		Radius = 2.5, --Radius of the planet
		Color = Color( 255, 255, 255, 255 ), --Color of the object
		AxisTilt = Angle( 22.5, 72, 0 ),

		--Clouds & Atmo
		CloudTexture = "gamey/planets/planet_clouds01", --Texture of the cloud layer
		HasAtmosphere = true, --Draws the glow effect (cheap atmo)
		AtmoColor = Color( 255, 100, 0, 255 ), --Color of the atmo glow
		AtmoScale = 2.5, --Scale of the glow effect

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
			RiseAng = 90,
			SetAng = -270,
		},
		Day = { --Table of data about the planet's day cycle (rotation)
			Duration = 1440 *0.33,
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
	WeatherChangeChance = 8,

	Types = { 5 },
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