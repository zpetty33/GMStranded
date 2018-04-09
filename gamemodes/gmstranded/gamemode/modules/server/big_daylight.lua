if DayLight == nil then
	DayLight = {}
end

-- Times in minutes
DayLight.TimeTable = {
	Length = 1440,
	Start = 300,
	End = 1290,

	Dawn = 390,
	Dawn_Start = 300,
	Dawn_End = 450,

	Noon = 720,

	Dusk = 1260,
	Dusk_Start = 1200,
	Dusk_End = 1290,

	Low = string.byte("a"),
	High = string.byte("z")
}

-- Days of the week
DayLight.DaysOfTheWeek = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" }

DL = {}

DL.tries = 0


DL.tcolor = {}
DL.tcolor.r = 0.2
DL.tcolor.g = 0.3
DL.tcolor.b = 1

DL.bcolor = {}
DL.bcolor.r = 0.6
DL.bcolor.g = 0.8
DL.bcolor.b = 1

--CreateConVar( "DayLight_MinLength", "1", {FCVAR_REPLICATED,FCVAR_ARCHIVE,FCVAR_NOTIFY} )
local REALTIME = CreateConVar( "DayLight_RealTime", "0", {FCVAR_REPLICATED,FCVAR_ARCHIVE,FCVAR_NOTIFY} )
--CreateConVar( "DayLight_DynamicShadows", "0", {FCVAR_REPLICATED,FCVAR_ARCHIVE,FCVAR_NOTIFY} )

if DayLight.LightTable == nil then
	-- Run Variables
	DayLight.LightTable = {}
	DayLight.Minute = 360
	DayLight.MinuteIndex = 360
	DayLight.NextTick = 0
	DayLight.LastThink = 0
	DayLight.NextThink = 0
	DayLight.Sun = {}
	DayLight.RemoteSuns = {}
	DayLight.Sun_FX = nil
	DayLight.Sun_Angle = 0
	DayLight.Overlays = {}
	DayLight.WaterOverlays = {}
	DayLight.ShadowControl = nil
	DayLight.NightLights = {}
	DayLight.Day = math.random( 1, 7 )
end

function DayLight:Init()
	DayLight:SetTime()
	

-- Find ALL Entities
	for _,v in ipairs(ents.GetAll()) do
		if v.GetClass and v.GetName then
			-- Sun
			if v:GetClass() == "light_environment" then
				table.insert( DayLight.Sun, v )
			end
			-- Sun_FX
			if v:GetClass() == "env_sun" then
				DayLight.Sun_FX = v
			end
			--ENV SkyPaint
			if v:GetClass() == "env_skypaint" then
				DL.SPEnt = v
				DL.SPEnt:SetKeyValue("starscale", "1")
			end
		end
	end

-- Sun
	if #DayLight.Sun == 0 then
		DayLight:Kill( "NO SUN" )
		return
	else
		for k, v in pairs( DayLight.Sun ) do
			v:Fire( "FadeToPattern", string.char( DayLight.TimeTable.Low ), 0 )
			v:Activate()
		end
	end

-- Remote Suns
	if #DayLight.RemoteSuns > 0 then
		for _,v in ipairs(DayLight.RemoteSuns) do
			v:Fire( "FadeToPattern", string.char( DayLight.TimeTable.Low ), 0 )
			v:Activate()
		end
	end

-- Sun FX
	if DayLight.Sun_FX == nil then
		DayLight:Kill( "NO SUN FX" )
		return
	else
		DayLight.Sun_FX:SetKeyValue( "material" , "sprites/light_glow02_add_noz.vmt" )
		DayLight.Sun_FX:SetKeyValue( "overlaymaterial" , "sprites/light_glow02_add_noz.vmt" )
	end
	
-- Skypaint Kill
	if DL.SPEnt == nil then
		DayLight:Kill( "NO SKYPAINT" )
		return
	end

-- Overlays
	if #DayLight.Overlays > 0 then
		for _,v in ipairs(DayLight.Overlays) do
			v:Fire( "Enable", "", 0 )
			v:Fire( "Color", "0 0 0", 0.01 )
		end
	end
	if #DayLight.WaterOverlays > 0 then
		for _,v in ipairs(DayLight.WaterOverlays) do
			v:Fire( "Enable", "", 0 )
			v:Fire( "Color", "0 0 0", 0.01 )
		end
	end

	DayLight:BuildLightTable()

	if REALTIME:GetBool() then
		DayLight.Minute = tonumber((os.date("%H")))*60+tonumber((os.date("%M")))
		if GetConVarNumber( "DayLight_RealTime" ) == 1 then
			DayLight.Day = tonumber( os.date( "%w" ) )
		end
	end

	DayLight.NextThink = 0
end
hook.Add( "InitPostEntity", "DayLight_Init", DayLight.Init )

function DayLight:FindSkypaintEntity()
	for _,v in ipairs(ents.GetAll()) do
		if v:GetClass() == "env_skypaint" then
			DL.SPEnt = v
			DL.SPEnt:SetKeyValue("starscale", "1")
		end
	end
end

function DayLight:ScaleSBColor( val )

	if DL == nil then return end
	
	if DL.tries >= 5 then return end
	if DL.SPEnt == nil then 
		DayLight:FindSkypaintEntity()
		DL.tries = DL.tries + 1
		return
	end

	DL.SPEnt:SetKeyValue("topcolor", tostring(DL.tcolor.r * val) .. " " .. tostring(DL.tcolor.g * val) .. " " .. tostring(math.Clamp( (DL.bcolor.b * val), 0.01, 1)))
	DL.SPEnt:SetKeyValue("bottomcolor", tostring(DL.bcolor.r * val) .. " " .. tostring(DL.bcolor.g * val) .. " " .. tostring(math.Clamp( (DL.bcolor.b * val), 0.005, 1)))
	DL.SPEnt:SetKeyValue("suncolor", "0 0 0")
	
	if val > 0.5 then
		DL.SPEnt:SetKeyValue("duskintensity", "0")
	elseif val <= 0.5 and val > 0.05 then
		DL.SPEnt:SetKeyValue("duskintensity", tostring( ( 1 * val ) + 0.3 ) )
	else
		DL.SPEnt:SetKeyValue("duskintensity", "0")
	end
	
	if DayLight.Minute < 300 or DayLight.Minute > 1290 then
		DL.SPEnt:SetKeyValue("starfade", "1")
	else
		DL.SPEnt:SetKeyValue("starfade", "0")
	end
end

function DayLight:Kill( ec )
	hook.Remove( "InitPostEntity", "DayLight_Init" )
	hook.Remove( "Think", "DayLight_Think" )
end

function DayLight:BuildLightTable()
	DayLight.LightTable = {}
	
	for i=1, DayLight.TimeTable.Length do
		local letter = string.char( DayLight.TimeTable.Low )
		local color = Color( 0, 0, 0, 0 )
		
		-- calculate which letter to use in the light pattern.
		if i >= DayLight.TimeTable.Dawn_Start and i < DayLight.TimeTable.Dawn_End then
			local progress = ( DayLight.TimeTable.Dawn_End - i ) / ( DayLight.TimeTable.Dawn_End - DayLight.TimeTable.Dawn_Start )
			local letter_progress = 1 - math.EaseInOut( progress , 0 , 1 )
						
			letter = ( ( DayLight.TimeTable.High - DayLight.TimeTable.Low ) * letter_progress ) + DayLight.TimeTable.Low
			letter = math.ceil( letter )
			letter = string.char( letter )
		elseif i >= DayLight.TimeTable.Dusk_Start and i < DayLight.TimeTable.Dusk_End then
			local progress = ( i - DayLight.TimeTable.Dusk_Start ) / ( DayLight.TimeTable.Dusk_End - DayLight.TimeTable.Dusk_Start )
			local letter_progress = 1 - math.EaseInOut( progress , 0 , 1 )
						
			letter = ( ( DayLight.TimeTable.High - DayLight.TimeTable.Low ) * letter_progress ) + DayLight.TimeTable.Low
			letter = math.ceil( letter )
			letter = string.char( letter )
		elseif (i > 0 and i < DayLight.TimeTable.Dawn_Start) or (i >= DayLight.TimeTable.Dusk_End and i <= 1440) then
			letter = string.char( DayLight.TimeTable.Low )
		else
			letter = string.char( DayLight.TimeTable.High )
		end
		
		-- calculate colors.
		if i >= DayLight.TimeTable.Dawn_Start and i <= DayLight.TimeTable.Dawn_End then
			-- golden dawn.
			local frac = ( i - DayLight.TimeTable.Dawn_Start ) / ( DayLight.TimeTable.Dawn_End - DayLight.TimeTable.Dawn_Start )
			if i < DayLight.TimeTable.Dawn then
				color.r = 100 * frac
				color.g = 64 * frac
			else
				color.r = 100 - ( 100 * frac )
				color.g = 64 - ( 64 * frac )
			end
		elseif i >= DayLight.TimeTable.Dusk_Start and i <= DayLight.TimeTable.Dusk_End then
			-- red dusk.
			local frac = ( i - DayLight.TimeTable.Dusk_Start ) / ( DayLight.TimeTable.Dusk_End - DayLight.TimeTable.Dusk_Start )
			if i < DayLight.TimeTable.Dusk then
				color.r = 40 * frac
			else
				color.r = 40 - ( 40 * frac )
			end
		elseif i >= DayLight.TimeTable.Dusk_End or i <= DayLight.TimeTable.Dawn_Start then
			-- blue hinted night sky.
			if i > DayLight.TimeTable.Dusk_End then
				local frac = ( i - DayLight.TimeTable.Dusk_End ) / ( DayLight.TimeTable.Length - DayLight.TimeTable.Dusk_End )
				color.r = 1 * frac
				color.g = 1 * frac
				color.b = 2 * frac
			else
				local frac = i / DayLight.TimeTable.Dawn_Start
				color.r = 1 - ( 1 * frac )
				color.g = 1 - ( 1 * frac )
				color.b = 2 - ( 2 * frac )
			end
		end

		DayLight.LightTable[i] = {}

		DayLight.LightTable[i].Alpha = 0
		if i >= DayLight.TimeTable.Dawn_Start and i <= DayLight.TimeTable.Dawn_End then
			local progress = ( DayLight.TimeTable.Dawn_End - i ) / ( DayLight.TimeTable.Dawn_End - DayLight.TimeTable.Dawn_Start )
			DayLight.LightTable[i].Alpha = math.floor( 250 * progress )
		elseif i >= DayLight.TimeTable.Dusk_Start and i <= DayLight.TimeTable.Dusk_End then
			local progress = ( i - DayLight.TimeTable.Dusk_Start ) / ( DayLight.TimeTable.Dusk_End - DayLight.TimeTable.Dusk_Start )
			DayLight.LightTable[i].Alpha = math.floor( 250 * progress )
		elseif (i >= 0 and i <= DayLight.TimeTable.Dawn_Start) or (i >= DayLight.TimeTable.Dusk_End and i <= 1440) then
			DayLight.LightTable[i].Alpha = 250
		end
	
		DayLight.LightTable[i].Pattern = letter;
		DayLight.LightTable[i].Color = math.floor( color.r ).." "..math.floor( color.g ).." "..math.floor( color.b )
	end
end

function DayLight:Think()
	local curtime = CurTime()
	if curtime < DayLight.NextThink then return end
	DayLight.NextThink = curtime + 0.05
	DayLight.Minute = DayLight.Minute + 0.05
	
	
	
	if SGS.inedit then DayLight.Minute = 720 end

	local SunFX_Angle = 720
	if DayLight.Minute < 300 or DayLight.Minute >= 1290 then
		SunFX_Angle = 270
	else
		if DayLight.Minute < 720 then
			SunFX_Angle = 360 - ( ( ( DayLight.Minute - 300 ) / 419 ) * 89 )
		elseif DayLight.Minute == 720 then
			SunFX_Angle = 269
		elseif DayLight.Minute > 720 then
			SunFX_Angle = 360 - ( 180 - ( ( 1289 - DayLight.Minute ) / 568 ) * 89 )
		end
	end
	
	
	
	if DayLight.Sun_FX then
		DayLight.Sun_FX:Fire( "AddOutput", "pitch "..SunFX_Angle, 0 )
		DayLight.Sun_FX:Activate()
	end

	if math.floor(DayLight.Minute) ~= (DayLight.LastMinute or 0) then
		if math.floor(DayLight.Minute) >= DayLight.TimeTable.Length then
			DayLight.Minute = 0
			DayLight.Day = DayLight.Day + 1
			if DayLight.Day > 7 then DayLight.Day = 1 end
			hook.Call( "DayLightChangeDay", GAMEMODE, DayLight.Day )
		end
		DayLight.LastThink = curtime
		DayLight.LastMinute = math.floor(DayLight.Minute)
		DayLight:SetTime()
		DayLight:ChangeTime()
	end
	


	DayLight.MinuteIndex = math.Clamp( math.Round(DayLight.Minute), 1, DayLight.TimeTable.Length )
	
	local pattern = DayLight.LightTable[DayLight.MinuteIndex].Pattern
	if #DayLight.Sun > 0 then
		for k, v in pairs( DayLight.Sun ) do
			v:Fire( "FadeToPattern", pattern, 0 )
			v:Activate()
		end
	end

	if #DayLight.RemoteSuns > 0 then
		for _,v in ipairs(DayLight.RemoteSuns) do
			v:Fire( "FadeToPattern", pattern, 0 )
			v:Activate()
		end
	end
	
	
	if DayLight.Minute < 300 then --Night Time After Midnight
		DayLight:ScaleSBColor(0)
	elseif DayLight.Minute >= 300 and DayLight.Minute < 315 then--Dawn Start to Dawn End	(0 to 0.1)
		DayLight:ScaleSBColor( ( ( DayLight.Minute - 300 ) / 14 ) * 0.1 )
	elseif DayLight.Minute >= 315 and DayLight.Minute < 450 then--Dawn Start to Dawn End	(0.1 to 0.3)
		DayLight:ScaleSBColor( ( ( ( DayLight.Minute - 315 ) / 134 ) * 0.2 ) + 0.1  )
	elseif DayLight.Minute >= 450 and DayLight.Minute < 660 then --Morning					(0.3 to 1)
		DayLight:ScaleSBColor( ( ( ( DayLight.Minute - 450 ) / 209 ) * 0.7 ) + 0.3  )
	elseif DayLight.Minute >= 660 and DayLight.Minute < 980 then --MIDDAY
		DayLight:ScaleSBColor(1)
	elseif DayLight.Minute >= 980 and DayLight.Minute < 1200 then --AfterNoon				(1 to 0.3)
		DayLight:ScaleSBColor(( ( ( ( ( DayLight.Minute - 1199 ) / 219 ) * 0.7 ) * -1 ) + 0.3  ) )
	elseif DayLight.Minute >= 1200 and DayLight.Minute < 1290 then --Dusk Start to Dusk End		(0.3 to 0.1)
		DayLight:ScaleSBColor( ( ( ( ( DayLight.Minute - 1289 ) / 89 ) * 0.2 ) * -1 ) + 0.1  )
	elseif DayLight.Minute >= 1290 and DayLight.Minute < 1305 then --Dusk Start to Dusk End		(0.1 to 0)
		DayLight:ScaleSBColor( ( ( ( DayLight.Minute - 1304 ) / 15 ) * 0.1 ) * -1 )
	elseif DayLight.Minute >= 1305 and DayLight.Minute <= 1440 then --Dusk End to Midnight
		DayLight:ScaleSBColor(0)
	else
		DayLight:ScaleSBColor(0)
	end

	hook.Call( "DayLightMinute", GAMEMODE, DayLight.MinuteIndex )
end
hook.Add( "Think", "DayLight_Think", DayLight.Think )

function DayLight:ChangeTime()
	hook.Call( "DayLightChangeTime", GAMEMODE, math.Round(DayLight.Minute) )
end


function DayLight:GetFade( i )
	local first = string.Explode( " ", DayLight.LightTable[DayLight.MinuteIndex].Color )
	local second_min = DayLight.MinuteIndex
	if second_min > DayLight.TimeTable.Length then second_min = 1 end
	local second = string.Explode( " ", DayLight.LightTable[second_min].Color )

	first[1] = math.Round(first[1]*((i-1)*-1))
	first[2] = math.Round(first[2]*((i-1)*-1))
	first[3] = math.Round(first[3]*((i-1)*-1))
	second[1] = math.Round(second[1] * i)
	second[2] = math.Round(second[2] * i)
	second[3] = math.Round(second[3] * i)

	local col = { first[1]+second[1], first[2]+second[2], first[3]+second[3] }
	col = string.Implode( " ", col )
	return col
end

function DayLight:SetTime()

	local min = DayLight.MinuteIndex
	local hour = math.floor(min/60)
	local min = math.floor(min%60)

	SetGlobalInt( "DayLightMinute", min )

	if min < 10 then min = "0"..tostring(min) end
	local pm = false
	if hour >= 12 then
		hour = hour - 12
		pm = true
	end
	if hour == 0 then hour = 12 end
	if pm then
		SetGlobalString( "DayLightTime", DayLight.DaysOfTheWeek[DayLight.Day].." "..hour..":"..min.." PM" )
	else
		SetGlobalString( "DayLightTime", DayLight.DaysOfTheWeek[DayLight.Day].." "..hour..":"..min.." AM" )
	end
	

end

function DayLight:LightsOn()
	local pattern = ""
	local delay = 0
	for _,v in ipairs(DayLight.NightLights) do
		-- Flicker Function
		if math.random() >= 0.50 then
			pattern = "az"
		else
			pattern = "za"
		end

		delay = math.random() * 3

		v:Fire( "SetPattern", pattern, delay )
		v:Fire( "TurnOn", "", delay )

		timer.Simple( delay, function() v:EmitSound("buttons/button1.wav",math.random()*10+70,math.random()*10+95) end )

		delay = delay + math.random()*0.40
		v:Fire( "SetPattern", "z", delay )
		v:Fire( "FireUser1", "", delay )
	end

	DayLight.LightsAreOn = true
end

function DayLight:LightsOff()
	for _,v in ipairs(DayLight.NightLights) do
		v:Fire( "TurnOff", "", 0 )
		v:Fire( "FireUser2", "", 0 )
	end

	DayLight.LightsAreOn = false
end

function DayLight_SetTime( ply, cmd, args )
	if ply:IsAdmin() then
		if table.Count(args) >= 1 and tonumber(args[1]) then
			DayLight.Minute = math.Clamp(math.Round(tonumber(args[1])),1,DayLight.TimeTable.Length)
		end
	end
end
concommand.Add( "DayLight_SetTime", DayLight_SetTime )