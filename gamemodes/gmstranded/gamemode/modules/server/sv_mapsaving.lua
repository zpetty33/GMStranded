function SGS_LoadWorlds()
	SGS.WorldEntities = {}
	for w_id, _ in pairs( GAMEMODE.Worlds.tblWorlds ) do
		if file.Exists("sgstranded/mapsaves/" .. game.GetMap() .. "_world_" .. tostring(w_id) .. ".txt", "DATA") then 
			SGS.WorldEntities[w_id] = util.JSONToTable( file.Read("sgstranded/mapsaves/" .. game.GetMap() .. "_world_" .. tostring(w_id) .. ".txt", "DATA") )
		end
	end
	--[[
	for w_id, world in pairs( GAMEMODE.Worlds.tblWorlds ) do
		SGS_LoadWorld( w_id )
	end
	]]
end

function SGS_LoadWorld( w_id )
	if GAMEMODE.Worlds.tblWorlds[w_id].loaded then return end
	SGS_ClearWorld( w_id )
	local num = table.Count( SGS.WorldEntities[w_id] )
	
	if num == 0 then
		return 
	end
	
	GAMEMODE.Worlds.tblWorlds[w_id].loaded = true
	print("Loading World: " .. GAMEMODE.Worlds.tblWorlds[w_id].Name)
	SGS_LoadMapEntity( SGS.WorldEntities[w_id], num, 1, w_id )
end

function SGS_ClearWorld( w_id )
	if not GAMEMODE.Worlds.tblWorlds[w_id].loaded then return end
	for _, ent in pairs( ents.GetAll() ) do
		if ent.w_id and ent.w_id == w_id then
			ent:Remove()
		end
	end
	GAMEMODE.Worlds.tblWorlds[w_id].loaded = false
	
	if w_id == 1 then timer.Remove( "checkShop" ) end
	print("Clearing World: " .. GAMEMODE.Worlds.tblWorlds[w_id].Name)
end

--Don't load it all at once
function SGS_LoadMapEntity( tbl, max, cur, w_id)
	local item = tbl[cur]
	local ent = ents.Create(item.class)
	local pos = item.pos
	local ang = item.angles
	
	local doIt = true
	
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:Spawn()
	ent:SetNetworkedString("Owner", "World")
	ent.w_id = w_id

	if cur >= max then
		print("MAP LOADING COMPLELTE")
		if w_id == 1 then SGS_ClaimShopNPC() end
		if w_id == 7 then SGS_ClaimHatNPC() end
	else
		timer.Simple(0.01, function() SGS_LoadMapEntity( tbl, max, cur + 1, w_id ) end)
	end
end

function SGS_BuildEntityList()
	SGS.tosave = {}
	for w_id, world in pairs( GAMEMODE.Worlds.tblWorlds ) do
		SGS.tosave[w_id] = {}
		for _, ent in pairs( ents.GetAll() ) do
			for _, v in pairs( SGS.savedentities ) do
				if ent:GetClass() == v then
					if GAMEMODE.Worlds:GetEntityWorldSpace( ent ) == world then
						table.insert(SGS.tosave[w_id], ent)
						break
					end
				end
			end
		end
	end
	SGS_SaveMap()
end

function SGS_SaveMap()
		local savegame
		
		local w_count = table.Count( SGS.tosave )
		
		for i=1, w_count do
			savegame = {}
			for k, ent in pairs( SGS.tosave[i] ) do
				if ent and ent != NULL and ent:IsValid() then
					local entry = {}
					entry["class"] = ent:GetClass()
					entry["pos"] = ent:GetPos()
					entry["angles"] = ent:GetAngles()
					savegame[k] = entry
				end
			end
			file.Write("sgstranded/mapsaves/" .. game.GetMap() .. "_world_" .. tostring(i) .. ".txt",util.TableToJSON(savegame, true))
		end
end

hook.Add("SGSPlayerChangedWorld", "UnloadEmptyWorlds", function()
	GAMEMODE.Worlds:CheckEmptyWorlds()
	for k, v in pairs(GAMEMODE.Worlds.tblWorlds) do
		if v.loaded and not v.occupied then
			SGS_ClearWorld( k )
		end
		
		if not v.loaded and v.occupied then
			SGS_LoadWorld( k )
		end
	end
end )