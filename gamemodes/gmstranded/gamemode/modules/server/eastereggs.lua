if true then return end

SGS.eggtable = {}

SGS.maxeggs = 25
SGS.eggrespawn = 30
SGS.iseaster = false


concommand.Add( "sgs_createegglist", function( ply )
	if IsValid( ply ) and not ply:IsAdmin() then return end
	SGS.eggtable = {}
	for k, v in pairs( ents.FindByClass("gms_easteregg") ) do
		local entry = {}
		local pos = v:GetPos()
		local ang = v:GetAngles()
		
		entry["pos"] = pos.x.." "..pos.y.." "..pos.z
		entry["ang"] = ang.p.." "..ang.y.." "..ang.r
		
		SGS.eggtable[#SGS.eggtable + 1] = entry
	end
	
	
	file.Write("SGStranded/egglist.txt",util.TableToJSON(SGS.eggtable, true))
end)

function SGS_LoadEggList()

	if not file.Exists("SGStranded/egglist.txt", "DATA") then return end
	ServerLog("Loading Egg List\n")
	SGS.eggtable = util.JSONToTable(file.Read("SGStranded/egglist.txt", “DATA”))

end
timer.Simple( 1, SGS_LoadEggList )

function SGS_SpawnEgg()
	if SGS.iseaster == false then return end
	if #ents.FindByClass("gms_easteregg") >= SGS.maxeggs then
		return
	end
	
	local e = math.random( #SGS.eggtable )
	local pos = string.Explode( " ", SGS.eggtable[e]["pos"] )
	
	pos = Vector(tonumber(pos[1]),tonumber(pos[2]),tonumber(pos[3]))
	
	local ang = string.Explode( " ", SGS.eggtable[e]["ang"] )
	ang = Angle(tonumber(ang[1]),tonumber(ang[2]),tonumber(ang[3]))
	
	for k, v in pairs( ents.FindInSphere( pos, 400 ) ) do
		if v:GetClass() == "gms_easteregg" then
			ServerLog("Can't place egg here: Near another egg\n")
			SGS_SpawnEgg()
			return
		end
		
		if v:IsPlayer() then
			ServerLog("Can't place egg here: Near Player\n")
			SGS_SpawnEgg()
			return		
		end
	end
	
	local egg = ents.Create( "gms_easteregg" )
	egg:SetPos(pos)
	egg:SetAngles(ang)
	egg:Spawn()
	egg:SetNetworkedString("Owner", "World")
	ServerLog("Placing egg at location: " .. tostring(egg:GetPos()) .. "\n")
	SafeRemoveEntityDelayed( egg, 300 )

end

function SGS_EasterEggSpawning()
	if SGS.iseaster == false then return end
	SGS_SpawnEgg()
end
timer.Create( "SGS_EasterEggSpawning", SGS.eggrespawn, 0, SGS_EasterEggSpawning )

function SGS_OpenEasterEgg( ply )
	if ply:GetResource("easter_egg") <= 0 then return end
	
	local tier = math.random(1,100)
	if tier <= 55 then
		SGS_AwardEasterTier( ply, 0 )
	elseif tier > 55 and tier <= 78 then
		SGS_AwardEasterTier( ply, 1 )
	elseif tier > 78 and tier <= 86 then
		SGS_AwardEasterTier( ply, 2 )
	elseif tier > 86 and tier <= 91 then
		SGS_AwardEasterTier( ply, 3 )
	elseif tier > 91 and tier <= 99 then
		SGS_AwardEasterTier( ply, 4 )
	else
		SGS_AwardEasterTier( ply, 5 )
	end
	ply:SubResource( "easter_egg", 1 )
end

function SGS_AwardEasterTier( ply, tier )

	if tier == 0 then
		local t = { "marshmallow_peeps", "gummy_bears" }
		ply:AddResource( t[math.random(#t)], 1 )
	
	elseif tier == 1 then
		local m = math.random(5)
		if m == 1 then
			ply:GiveGTokens(math.random(2, 10))
		elseif m == 2 then
			ply:AddResource( "sapphire", 1 )
		elseif m == 3 then
			ply:AddResource( "emerald", 1 )
		elseif m == 4 then
			local s = SGS.skills[math.random(#SGS.skills)] .. "_relic_1"
			ply:AddResource( s, 1 )
		elseif m == 5 then
			local t = { "wind", "water", "earth", "fire" }
			local s = t[math.random(#t)] .. "_stone"
			ply:AddResource( s, math.random(5) )
		end
	
	elseif tier == 2 then
		local m = math.random(5)
		if m == 1 then
			ply:GiveGTokens(math.random(15, 75))
		elseif m == 2 then
			local t = { "white", "yellow", "black", "orange", "green", "blue", "brown", "gray" }
			local s = t[math.random(#t)] .. "_pet_egg"
			ply:AddResource( s, 1 )
		elseif m == 3 then
			ply:AddResource( "ruby", 1 )
		elseif m == 4 then
			local s = SGS.skills[math.random(#SGS.skills)] .. "_relic_2"
			ply:AddResource( s, 1 )
		elseif m == 5 then
			local t = { "chaos", "nature", "cosmic" }
			local s = t[math.random(#t)] .. "_stone"
			ply:AddResource( s, math.random(5) )
		end	
	
	elseif tier == 3 then
		local m = math.random(7)
		if m == 1 then
			ply:GiveGTokens(math.random(75, 150))
		elseif m == 2 then
			local t = { "red" }
			local s = t[math.random(#t)] .. "_pet_egg"
			ply:AddResource( s, 1 )
		elseif m == 3 then
			ply:AddResource( "diamond", 1 )
		elseif m == 4 then
			ply:AddResource( "unidentified_artifact", 1 )
		elseif m == 5 then
			local t = { "inert" }
			local s = t[math.random(#t)] .. "_stone"
			ply:AddResource( s, math.random(5, 10) )
		elseif m == 6 then
			ply:AddResource( "void_cache", 1 )
		elseif m == 7 then
			local s = SGS.skills[math.random(#SGS.skills)] .. "_relic_3"
			ply:AddResource( s, 1 )
		end	
	
	elseif tier == 4 then
		if not ply:GetAch("bunnyears") then
			ply:SetAch("bunnyears")
		else
			SGS_AwardEasterTier( ply, 3 )
		end
	
	elseif tier == 5 then
		local m = math.random(6)
		if m == 1 then
			ply:GiveGTokens(1000)
		elseif m == 2 then
			local t = { "pink" }
			local s = t[math.random(#t)] .. "_pet_egg"
			ply:AddResource( s, 1 )
		elseif m == 3 then
			ply:AddResource( "enchanted_wood", 1 )
		elseif m == 4 then
			ply:AddResource( "enchanted_metal", 1 )
		elseif m == 5 then
			ply:AddResource( "hat_token", 1 )
		elseif m == 6 then
			ply:AddResource( "bugbait", 1 )
		end	
		
	end
end

concommand.Add( "sgs_starteaster", function( ply )
	if IsValid( ply ) and not ply:IsAdmin() then return end
	SGS.iseaster = true
	for i=1, SGS.maxeggs - #ents.FindByClass("gms_easteregg") do
		SGS_SpawnEgg()
	end
end)

concommand.Add( "sgs_stopeaster", function( ply )
	if IsValid( ply ) and not ply:IsAdmin() then return end
	SGS.iseaster = false
	for k, v in pairs( ents.FindByClass( "gms_easteregg" ) ) do
		v:Remove()
	end
end)

concommand.Add( "spawnegg", function( ply )
	if IsValid( ply ) and not ply:IsAdmin() then return end
	local tr = ply:TraceFromEyes(140)
	
	local egg = ents.Create("gms_easteregg")
	egg:SetPos( tr.HitPos )
	egg:Spawn()
	
end)

