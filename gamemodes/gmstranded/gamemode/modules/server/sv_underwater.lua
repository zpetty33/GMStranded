local PlayerMeta = FindMetaTable("Player")

function SGS_CheckUnderWater()
	if SGS.nextwatercheck == nil then SGS.nextwatercheck = CurTime() end
	if CurTime() < SGS.nextwatercheck then return end

	-- ========================================================
	-- MAP DEPTH, TIME & WEATHER SETTINGS
	-- ========================================================
	local mapWaterSurfaceZ = -2093   -- Sea Level
	local mapOceanFloorZ = -4473     -- Deepest Ravine Floor
	
	local timeToMaxWaves = 30        -- Base scale time
	local maxTimeMultiplier = 2.0    -- Base multiplier scale
	
	local stormMultiplierValue = 1.8 -- Storm severity
	
	local maxExpectedGap = 2400      -- Roughly the distance from surface to ravine floor
	local maxAbyssMultiplier = 2.0   -- At max gap, waves are 2x stronger

	for k, v in pairs(player.GetAll()) do
		if not IsValid(v) then continue end
		if not v:IsConnected() then continue end
		if not v:Alive() then continue end
		if not v.tosaccept then continue end
		
		-- ========================================================
		-- ROUGH SEAS: Depth, Time, Trace & Weather-Scaled Currents
		-- ========================================================
		if v:WaterLevel() >= 2 then
			
			if not v.waterEntryTime then
				v.waterEntryTime = CurTime()
			end
			local timeInWater = CurTime() - v.waterEntryTime
			local timeFraction = timeInWater / timeToMaxWaves
			local timeMultiplier = 1.0 + (timeFraction * (maxTimeMultiplier - 1.0))
			
			local plyZ = v:GetPos().z
			local depthFraction = (plyZ - mapOceanFloorZ) / (mapWaterSurfaceZ - mapOceanFloorZ)
			local depthMultiplier = math.max(0.1 + (0.9 * depthFraction), 0.1) 

			local traceStart = v:GetPos()
			local tr = util.TraceLine({
				start = traceStart,
				endpos = traceStart - Vector(0, 0, 10000), 
				filter = v,
				mask = MASK_SOLID_BRUSHONLY 
			})
			
			local distanceToFloor = traceStart.z - tr.HitPos.z
			local gapFraction = distanceToFloor / maxExpectedGap
			local abyssMultiplier = 1.0 + math.max(gapFraction * (maxAbyssMultiplier - 1.0), 0)

			local stormMultiplier = 1.0
			if SGS and SGS.weather == "rain" then
				stormMultiplier = stormMultiplierValue
			end

			-- ========================================================
			-- THE FIX: CAPPING THE HORIZONTAL THRASH
			-- ========================================================
			-- 1. Upward Bounce (Capped by map depth and storms only)
			local waveMultiplier = depthMultiplier * stormMultiplier
			
			-- 2. Downward Pull (Completely UNCAPPED for AFKers)
			local undertowMultiplier = depthMultiplier * timeMultiplier * abyssMultiplier * stormMultiplier
			
			-- 3. Sideways Thrash (CAPPED to prevent glitching through map walls)
			-- math.min ensures it NEVER goes higher than 4.0x force, even if undertowMultiplier is 50x.
			local maxHorizontalScale = 4.0 
			local horizontalMultiplier = math.min(undertowMultiplier, maxHorizontalScale)

			local time = CurTime()
			local offset = v:EntIndex()
			
			-- Horizontal forces use the safely CAPPED multiplier
			local forceXY = math.random(30, 80) * horizontalMultiplier
			local pushX = math.sin(time * 0.8 + offset) * forceXY
			local pushY = math.cos(time * 0.6 + offset) * forceXY
			
			-- Upward bounce uses the stable wave multiplier
			local waveCycle = math.sin(time * 1.5 + offset) 
			local verticalSwell = math.random(35, 55) * waveMultiplier 
			
			-- Downward gravity uses the infinitely scaling UNCAPPED multiplier
			local baseZ = -30 * undertowMultiplier 
			
			-- Combine vertical forces
			local pushZ = baseZ + (waveCycle * verticalSwell)
			
			v:SetVelocity(Vector(pushX, pushY, pushZ))
			
		else
			if v.waterEntryTime then
				v.waterEntryTime = nil
			end
		end
		-- ========================================================

		-- ORIGINAL OXYGEN LOGIC
		if v:WaterLevel() == 3 then
			if v.underwater == false then
				v.underwater = true
			end
			if v.elixir == "waterbreathing" then
				v.o2 = math.Clamp((v.o2 + 20), 0, v.maxneeds)
			else
				v.o2 = math.Clamp((v.o2 - 10), 0, v.maxneeds)
			end
			
			if v.o2 <= 0 then v.o2 = 0 end
			
			net.Start("sgs_sendo2")
				net.WriteInt( v.o2, 32 )
				net.WriteString( "yes" )
			net.Send( v )
			continue
		end
		
		if v:WaterLevel() < 3 and v.underwater == true then
			if v.o2 < v.maxneeds then
				v.o2 = math.Clamp((v.o2 + 20), 0, v.maxneeds)
				net.Start("sgs_sendo2")
					net.WriteInt( v.o2, 32 )
					net.WriteString( "yes" )
				net.Send( v )
			else
				v.underwater = false
				v.o2 = v.maxneeds
				net.Start("sgs_sendo2")
					net.WriteInt( v.o2, 32 )
					net.WriteString( "no" )
				net.Send( v )
			end
			continue
		end
	end
	
	SGS.nextwatercheck = CurTime() + 0.2
end
hook.Add("Think", "CheckUnderWater", SGS_CheckUnderWater)