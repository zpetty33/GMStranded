local world = {}
world.Name		= "Cave World"
world.SkyPos 	= 6140
world.Bounds	= {
	[1] = {
		Min = Vector( -16335, -16335, 169 ),
		Max = Vector( -2602, -2968, 6662 )
	},
}
world.Gravity		= 1.0
world.ZombieSpawns	= true
world.Entities	= {
}
--[[ World Skybox ]]--
world.SkyObjects = {
	{
		ClassName = "CPlanet", --Class name, this one is a planet
		BodyName = "GasGiant", --Name of the planet
		SurfaceTexture = "planets/gas_blue", --Texture of the planet surface
		Radius = 512, --Radius of the planet
		Color = Color( 255, 255, 255, 255 ), --Color of the object
		AxisTilt = Angle( 22.5, -84, 0 ),

		--Clouds & Atmo
		CloudTexture = "gamey/planets/planet_clouds01", --Texture of the cloud layer
		HasAtmosphere = false, --Draws the glow effect (cheap atmo)
		AtmoColor = Color( 255, 255, 255, 255 ), --Color of the atmo glow
		AtmoScale = 2.5, --Scale of the glow effect

		HasClouds = false, --Draws the cloud layer
		CloudScale = 1.005, --Scale of the cloud layer
		CloudColor = Color( 255, 255, 255, 255 ), --Color of the cloud layer
		CloudRotation = Angle( 0, 0, 0 ), --Rotation speed of the cloud layer

		Orbit = { --Table of data about the planet's orbit in the sky
			Radius = 2100, --Distance from the planet to the world center
			Inclination = -1.746, --Tilt of the orbit in the sky : radians
			RotationR = 245, -- : angles
			RotationY = 0, -- : angles
			RiseAng = 80,
			SetAng = -260,
			ParentName = nil, --String of the parent body name to orbit around, nil for 0 0 0
		},
		Day = { --Table of data about the planet's day cycle (rotation)
			Duration = 1440 *0.5,
			RetrogradeRotation = false, --Does the planet spin backwards?
		},
		Lighting = { --Table of data about the lighting the planet has
			Origin = Vector( 0 ), --Where the light is in the sky
			ParentIsLight = false, --Should the light origin be the parent pos?
			Color = Color( 240, 220, 110, 255 ),  --The color of the light cast on the planet
		},
	},
	{
		ClassName = "CPlanet", --Class name, this one is a planet
		BodyName = "EarthLike", --Name of the planet
		SurfaceTexture = "planets/earthlike_1", --Texture of the planet surface
		Radius = 24, --Radius of the planet
		Color = Color( 255, 255, 255, 255 ), --Color of the object
		AxisTilt = Angle( 22.5, -90, 0 ),

		--Clouds & Atmo
		CloudTexture = "planets/planet_clouds01", --Texture of the cloud layer
		HasAtmosphere = false, --Draws the glow effect (cheap atmo)
		AtmoColor = Color( 255, 255, 255, 255 ), --Color of the atmo glow
		AtmoScale = 2.5, --Scale of the glow effect

		HasClouds = true, --Draws the cloud layer
		CloudScale = 1.025, --Scale of the cloud layer
		CloudColor = Color( 255, 255, 255, 150 ), --Color of the cloud layer
		CloudRotation = Angle( 0, 0.25, 0 ), --Rotation speed of the cloud layer

		Orbit = { --Table of data about the planet's orbit in the sky
			Radius = 1300, --Distance from the planet to the world center
			Inclination = -1.746, --Tilt of the orbit in the sky : radians
			RotationR = 245, -- : angles
			RotationY = 0, -- : angles
			ParentName = "GasGiant", --String of the parent body name to orbit around, nil for 0 0 0
			ChildOrbitDuration = 1440 *7,
			Retrograde = true,
			ElevationOffset = math.pi,
		},
		Day = { --Table of data about the planet's day cycle (rotation)
			Duration = 1440 *0.5,
			RetrogradeRotation = false, --Does the planet spin backwards?
		},
		Lighting = { --Table of data about the lighting the planet has
			Origin = Vector( 0 ), --Where the light is in the sky
			ParentIsLight = false, --Should the light origin be the parent pos?
			Color = Color( 240, 220, 110, 255 ),  --The color of the light cast on the planet
		},
	},
	{
		ClassName = "CPlanet", --Class name, this one is a planet
		BodyName = "Moon1", --Name of the planet
		SurfaceTexture = "planets/rocky_3", --Texture of the planet surface
		Radius = 18, --Radius of the planet
		Color = Color( 255, 255, 255, 255 ), --Color of the object
		AxisTilt = Angle( 33, -90, 0 ),

		--Clouds & Atmo
		CloudTexture = "gamey/planets/planet_clouds01", --Texture of the cloud layer
		HasAtmosphere = false, --Draws the glow effect (cheap atmo)
		AtmoColor = Color( 255, 255, 255, 255 ), --Color of the atmo glow
		AtmoScale = 2.5, --Scale of the glow effect

		HasClouds = false, --Draws the cloud layer
		CloudScale = 1.005, --Scale of the cloud layer
		CloudColor = Color( 255, 255, 255, 255 ), --Color of the cloud layer
		CloudRotation = Angle( 0, 0, 0 ), --Rotation speed of the cloud layer

		Orbit = { --Table of data about the planet's orbit in the sky
			Radius = 1100, --Distance from the planet to the world center
			Inclination = -1.71, --Tilt of the orbit in the sky : radians
			RotationR = 245, -- : angles
			RotationY = 0, -- : angles
			ParentName = "GasGiant", --String of the parent body name to orbit around, nil for 0 0 0
			ChildOrbitDuration = 1440 *6.5,
			Retrograde = true,
			ElevationOffset = math.pi *0.7,
		},
		Day = { --Table of data about the planet's day cycle (rotation)
			Duration = 1440 *0.15,
			RetrogradeRotation = false, --Does the planet spin backwards?
		},
		Lighting = { --Table of data about the lighting the planet has
			Origin = Vector( 0 ), --Where the light is in the sky
			ParentIsLight = false, --Should the light origin be the parent pos?
			Color = Color( 240, 220, 110, 255 ),  --The color of the light cast on the planet
		},
	},
	{
		ClassName = "CPlanet", --Class name, this one is a planet
		BodyName = "Moon2", --Name of the planet
		SurfaceTexture = "planets/rocky_4", --Texture of the planet surface
		Radius = 21, --Radius of the planet
		Color = Color( 255, 255, 255, 255 ), --Color of the object
		AxisTilt = Angle( -27, -90, 0 ),

		--Clouds & Atmo
		CloudTexture = "gamey/planets/planet_clouds01", --Texture of the cloud layer
		HasAtmosphere = false, --Draws the glow effect (cheap atmo)
		AtmoColor = Color( 255, 255, 255, 255 ), --Color of the atmo glow
		AtmoScale = 2.5, --Scale of the glow effect

		HasClouds = false, --Draws the cloud layer
		CloudScale = 1.005, --Scale of the cloud layer
		CloudColor = Color( 255, 255, 255, 255 ), --Color of the cloud layer
		CloudRotation = Angle( 0, 0, 0 ), --Rotation speed of the cloud layer

		Orbit = { --Table of data about the planet's orbit in the sky
			Radius = 1000, --Distance from the planet to the world center
			Inclination = -1.8, --Tilt of the orbit in the sky : radians
			RotationR = 245, -- : angles
			RotationY = 0, -- : angles
			ParentName = "GasGiant", --String of the parent body name to orbit around, nil for 0 0 0
			ChildOrbitDuration = 1440 *6,
			Retrograde = true,
			ElevationOffset = 0,
		},
		Day = { --Table of data about the planet's day cycle (rotation)
			Duration = 1440 *2.5,
			RetrogradeRotation = true, --Does the planet spin backwards?
		},
		Lighting = { --Table of data about the lighting the planet has
			Origin = Vector( 0 ), --Where the light is in the sky
			ParentIsLight = false, --Should the light origin be the parent pos?
			Color = Color( 240, 220, 110, 255 ),  --The color of the light cast on the planet
		},
	},
	{
		ClassName = "CPlanet", --Class name, this one is a planet
		BodyName = "Moon3", --Name of the planet
		SurfaceTexture = "planets/rocky_5", --Texture of the planet surface
		Radius = 14, --Radius of the planet
		Color = Color( 255, 255, 255, 255 ), --Color of the object
		AxisTilt = Angle( -16, -90, 0 ),

		--Clouds & Atmo
		CloudTexture = "gamey/planets/planet_clouds01", --Texture of the cloud layer
		HasAtmosphere = false, --Draws the glow effect (cheap atmo)
		AtmoColor = Color( 255, 255, 255, 255 ), --Color of the atmo glow
		AtmoScale = 2.5, --Scale of the glow effect

		HasClouds = false, --Draws the cloud layer
		CloudScale = 1.005, --Scale of the cloud layer
		CloudColor = Color( 255, 255, 255, 255 ), --Color of the cloud layer
		CloudRotation = Angle( 0, 0, 0 ), --Rotation speed of the cloud layer

		Orbit = { --Table of data about the planet's orbit in the sky
			Radius = 850, --Distance from the planet to the world center
			Inclination = -1.95, --Tilt of the orbit in the sky : radians
			RotationR = 245, -- : angles
			RotationY = 0, -- : angles
			ParentName = "GasGiant", --String of the parent body name to orbit around, nil for 0 0 0
			ChildOrbitDuration = 1440 *4,
			Retrograde = true,
			ElevationOffset = math.pi *-0.5,
		},
		Day = { --Table of data about the planet's day cycle (rotation)
			Duration = 1440 *1.25,
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