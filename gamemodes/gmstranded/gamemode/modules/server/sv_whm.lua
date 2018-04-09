function SGS_StartRain()


	for k, v in pairs( player.GetAll() ) do
		v:SendLua( "WHM:Start( 1, -1 )" )
	end
	SGS.weather = "rain"
	--SGS.weather = "snow"
	

	for k, v in pairs( ents.FindByClass("npc_antlion") ) do
		if v.ispet then continue end
		if not IsValid(v) then continue end
		timer.Simple( math.random(2, 5), function() if IsValid(v) then v:SetNWBool("isburrowed", true) v:Fire("Burrow") end end )
	end

	
	timer.Simple(10, function()
		for k, v in pairs(ents.FindByClass("func_water_analog")) do
			rval = math.random(20,40)
			v:Fire("SetPosition", rval / 100)
		end
	end )
	
	timer.Simple( math.random(120, 420), function() SGS_StopRain() end )
	
end

function SGS_KeepBurrowed()
	
	if SGS.weather == "rain" then
		for k, v in pairs( ents.FindByClass("npc_antlion") ) do
			if v.ispet then continue end
			if not IsValid(v) then continue end
			if IsValid(v) then 
				v:SetNWBool("isburrowed", true) 
				v:Fire("Burrow")
			end
		end
	end
	
end
timer.Create( "burrowtimer", 5, 0, function() SGS_KeepBurrowed() end )

function SGS_StopRain()


	for k, v in pairs( player.GetAll() ) do
		v:SendLua( "WHM:Stop( 1, 1 )" )
	end
	SGS.weather = "clear"
	
	timer.Simple( 10, function()
		for k, v in pairs( ents.FindByClass("npc_antlion") ) do
			if v.ispet then continue end
			timer.Simple( math.random(2, 5), function() if IsValid(v) then v:SetNWBool("isburrowed", false) v:Fire("Unburrow") end end )
			v:SetColor( Color( 255, 255, 255, 255 ) )
		end
	end )
	
	timer.Simple(5, function()
		for k, v in pairs(ents.FindByClass("func_water_analog")) do
			v:Fire("SetPosition", 0)
		end
	end )

end

function SGS_CheckWeather( ply )

	if SGS.weather == "rain" then
		ply:SendLua( "WHM:Start( 1, -1 )" )
	elseif SGS.weather == "snow" then
		ply:SendLua( "WHM:Start( 2, -1 )" )
	end
	
end



function SGS_TimerStartRain()

	if SGS.weather == "clear" then
		if math.random(1,10) == 1 then
			SGS_StartRain()
		end
	end

end
--timer.Create( "rain_timer", 5, 0, function() SGS_TimerStartRain() end )
--timer.Create( "rain_timer", 300, 0, function() SGS_TimerStartRain() end )