-- Global wind vector so other scripts can access it if needed
SGS.WindVector = Vector(0, 0, 0)

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
	
	-- (Removed the func_water_analog loop here to prevent the water from breaking horizontally)
	
	-- ========================================================
	-- MEGA WAVE SPAWNER (20% chance every 30 seconds)
	-- ========================================================
	timer.Create( "megawave_timer", 30, 0, function()
		if math.random(1, 5) == 1 then -- 1 in 5 chance = 20%
			RunConsoleCommand("ent_fire", "spawner_mega", "forcespawn")
			print("[SGS Weather] A MEGA WAVE has been spawned!") 
		end
	end )
	-- ========================================================

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
	
	-- Destroy the mega wave timer so they stop spawning
	timer.Remove("megawave_timer")
	
	timer.Simple( 10, function()
		for k, v in pairs( ents.FindByClass("npc_antlion") ) do
			if v.ispet then continue end
			timer.Simple( math.random(2, 5), function() if IsValid(v) then v:SetNWBool("isburrowed", false) v:Fire("Unburrow") end end )
			v:SetColor( Color( 255, 255, 255, 255 ) )
		end
	end )
	
	-- (Removed the func_water_analog reset loop here to prevent map breaking)

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
-- Uncomment the line below if you want storms to start naturally every 5 minutes
--timer.Create( "rain_timer", 300, 0, function() SGS_TimerStartRain() end )


-- ========================================================
-- 1. WIND DIRECTION & INTENSITY GENERATOR
-- ========================================================
local function SGS_UpdateWind()
	if SGS.weather == "rain" then
		-- STORM WIND: Howling, chaotic, and changes direction often
		local stormForce = math.random(800, 1800) 
		SGS.WindVector = Vector(math.random(-stormForce, stormForce), math.random(-stormForce, stormForce), 0)
	else
		-- CLEAR WEATHER: Gentle breeze
		local breezeForce = math.random(50, 150)
		SGS.WindVector = Vector(math.random(-breezeForce, breezeForce), math.random(-breezeForce, breezeForce), 0)
	end
end
timer.Create("SGS_WindDirectionTimer", 15, 0, SGS_UpdateWind)


-- ========================================================
-- 2. APPLYING WIND TO SHIPS & FLOATING PROPS
-- ========================================================
local function SGS_ApplyWindPhysics()
	if SGS.WindVector:Length() < 10 then return end

	for _, ent in ipairs(ents.FindByClass("prop_physics")) do
		if not IsValid(ent) then continue end
		
		if ent:WaterLevel() > 0 and ent:WaterLevel() < 3 then
			local phys = ent:GetPhysicsObject()
			
			if IsValid(phys) and phys:IsMoveable() then
				local mass = phys:GetMass()
				local appliedForce = SGS.WindVector * (mass * 0.6)
				appliedForce = appliedForce + Vector(math.random(-50, 50), math.random(-50, 50), 0) * mass
				
				phys:ApplyForceCenter(appliedForce)
			end
		end
	end
end
timer.Create("SGS_WindPhysicsTimer", 0.2, 0, SGS_ApplyWindPhysics)


-- ========================================================
-- 3. ADMIN WEATHER COMMANDS FOR EASY TESTING
-- ========================================================
concommand.Add("sgs_forcestorm", function(ply, cmd, args)
	if IsValid(ply) and not ply:IsAdmin() then return end
	SGS_StartRain()
	print("Storm started manually by an admin.")
end)

concommand.Add("sgs_stopstorm", function(ply, cmd, args)
	if IsValid(ply) and not ply:IsAdmin() then return end
	SGS_StopRain()
	print("Storm stopped manually by an admin.")
end)
