------------------------------------
--	Simple Prop Protection
--	By Spacetech
-- 	http://code.google.com/p/simplepropprotection
------------------------------------

SPropProtection.Props = SPropProtection.Props or {}
SPropProtection.WeirdTraces = {
	"wire_winch",
	"wire_hydraulic",
	"slider",
	"hydraulic",
	"winch",
	"muscle"
}

function SPropProtection.SetupSettings()
	if(!sql.TableExists("spropprotection")) then
		sql.Query("CREATE TABLE IF NOT EXISTS spropprotection(toggle INTEGER NOT NULL, admin INTEGER NOT NULL, use INTEGER NOT NULL, edmg INTEGER NOT NULL, pgr INTEGER NOT NULL, awp INTEGER NOT NULL, dpd INTEGER NOT NULL, dae INTEGER NOT NULL, delay INTEGER NOT NULL);")
		sql.Query("CREATE TABLE IF NOT EXISTS spropprotectionfriends(steamid TEXT NOT NULL PRIMARY KEY, bsteamid TEXT);")
		sql.Query("INSERT INTO spropprotection(toggle, admin, use, edmg, pgr, awp, dpd, dae, delay) VALUES(1, 0, 1, 0, 1, 0, 1, 1, 600)")
	end
	return sql.QueryRow("SELECT * FROM spropprotection LIMIT 1")
end

SPropProtection.Config = SPropProtection.SetupSettings()

-- Thanks at Seth for the heads up
function SPropProtection.EscapeNotify(Text)
	local Text = string.Replace(Text, ")", "")
	Text = string.Replace(Text, "(", "")
	Text = string.Replace(Text, "'", "")
	Text = string.Replace(Text, '"', "")
	Text = string.Replace(Text, [[\]], "")
	return Text
end

function SPropProtection.NofityAll(Text)
	for k,v in pairs(player.GetAll()) do
		SPropProtection.Nofity(v, Text)
	end
end

function SPropProtection.Nofity(ply, Text)
	ply:SendMessage(SPropProtection.EscapeNotify(Text), 60, Color(255, 100, 255, 255))
	ply:PrintMessage(HUD_PRINTCONSOLE, Text)
end

function SPropProtection.AdminReloadPlayer(ply)
	if(!ply or !ply:IsValid()) then
		return
	end
	for k,v in pairs(SPropProtection.Config) do
		local stuff = k
		if(stuff == "toggle") then
			stuff = "check"
		end
		ply:ConCommand("spp_"..stuff.." "..v.."\n")
	end
end

function SPropProtection.AdminReload()
	if(ply) then
		SPropProtection.AdminReloadPlayer(ply)
	else
		for k,v in pairs(player.GetAll()) do
			SPropProtection.AdminReloadPlayer(v)
		end
	end
end

function SPropProtection.LoadFriends(ply)
	local PData = ply:GetPData("SPPFriends", "")
	if(PData != "") then
		for k,v in pairs(string.Explode(";", PData)) do
			local String = string.Trim(v)
			if(String != "") then
				table.insert(SPropProtection[ply:SteamID()], String)
			end
		end
	end
end

function SPropProtection.PlayerMakePropOwner(ply, ent)
	if(ent:IsPlayer()) then
		return false
	end
	SPropProtection.Props[ent:EntIndex()] = {
		Ent = ent,
		Owner = ply,
		SteamID = ply:SteamID(),
		SteamID64 = ply:GetPlayerID(),
		Name = ply:Nick()
	}
	ent:SetNetworkedString("Owner", ply:Nick())
	ent:SetNetworkedEntity("OwnerObj", ply)
	gamemode.Call("CPPIAssignOwnership", ply, ent)
	ply:SendPropCount()
	ply:SendStructureCount()
	return true
end

hook.Add( "PlayerInitialSpawn", "PropProtectReclaim", function( ply )
	for k, v in pairs( ents.GetAll() ) do
		if SPropProtection.Props[v:EntIndex()] and SPropProtection.Props[v:EntIndex()].SteamID64 == ply:GetPlayerID() then
			SPropProtection.PlayerMakePropOwner(ply, v)
		end
	end
end )

if(cleanup) then
	local Clean = cleanup.Add
	function cleanup.Add(Player, Type, Entity)
		if(Entity) then
			local Check = Player:IsPlayer()
			local Valid = Entity:IsValid()
		    if(Check and Valid) then
		        SPropProtection.PlayerMakePropOwner(Player, Entity)
		    end
		end
	    Clean(Player, Type, Entity)
	end
end

local Meta = FindMetaTable("Player")
if(Meta.AddCount) then
	local Backup = Meta.AddCount
	function Meta:AddCount(Type, Entity)
		SPropProtection.PlayerMakePropOwner(self, Entity)
		Backup(self, Type, Entity)
	end
end

function SPropProtection.CheckConstraints(ply, ent)
	for k,v in pairs(constraint.GetAllConstrainedEntities(ent) or {}) do
		if(v and v:IsValid()) then
			if(!SPropProtection.PlayerCanTouch(ply, v)) then
				return false
			end
		end
	end
	return true
end

function SPropProtection.IsFriend(ply, ent)
	for k,v in pairs(player.GetAll()) do
		if(v and v:IsValid() and v != ply) then
	        if(SPropProtection.Props[ent:EntIndex()].SteamID == v:SteamID()) then
                if(table.HasValue(SPropProtection[v:SteamID()], ply:SteamID())) then
					return true
				else
					return false
				end
            end
		end
	end	
end

function SPropProtection.PlayerCanTouch(ply, ent)
	if(tonumber(SPropProtection.Config["toggle"]) == 0 or ent:GetClass() == "worldspawn" or ent.SPPOwnerless) then
		return true
	end
	
	if(string.find(ent:GetClass(), "stone_") == 1 or string.find(ent:GetClass(), "rock_") == 1 or string.find(ent:GetClass(), "stargate_") == 0 or string.find(ent:GetClass(), "dhd_") == 0 or ent:GetClass() == "flag" or ent:GetClass() == "item") then
		if(!ent:GetNetworkedString("Owner") or ent:GetNetworkedString("Owner") == "") then
			ent:SetNetworkedString("Owner", "World")
		end
		if(ply:GetActiveWeapon():GetClass() != "weapon_physgun" and ply:GetActiveWeapon():GetClass() != "gmod_tool") then
			return true
		end
	end
	
	-- DarkRPer
	if(string.lower(ent:GetNetworkedString("Owner", "")) == "shared" or ent:GetNWEntity("owning_ent") == ply) then
		return true
	end

	if(!ent:GetNetworkedString("Owner", "") or ent:GetNetworkedString("Owner", "") == "" and !ent:IsPlayer()) then
		if ( IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() ~= "weapon_physcannon" ) or not IsValid(ply:GetActiveWeapon()) then
			SPropProtection.PlayerMakePropOwner(ply, ent)
			SPropProtection.Nofity(ply, "You now own this prop")
			return true
		end
	end
	
	if(ent:GetNetworkedString("Owner") == "World") then
		if(ply:IsAdmin() and tonumber(SPropProtection.Config["awp"]) == 1 and tonumber(SPropProtection.Config["admin"]) == 1) then
			return true
		end
	elseif(ply:IsAdmin() and tonumber(SPropProtection.Config["admin"]) == 1) then
		return true
	end
	
	if(SPropProtection.Props[ent:EntIndex()]) then
		if(SPropProtection.Props[ent:EntIndex()].SteamID == ply:SteamID() or SPropProtection.IsFriend(ply, ent)) then
			return true
		end
	end
	return false
end

dontRemove = { "gms_pan" }

function SPropProtection.DRemove(SteamID, PlayerName)
	for k,v in pairs(SPropProtection.Props) do
		if(v.SteamID == SteamID and v.Ent:IsValid()) then
			if not table.HasValue(dontRemove, v.Ent:GetClass()) then
				SGS.Log("**" .. v.Ent:GetClass() .. " owned by " .. PlayerName .. " was deleted by PropProtect!")
				v.Ent:Remove()
				SPropProtection.Props[k] = nil
			end
		end
	end
	SPropProtection.NofityAll(tostring(PlayerName).."'s props have been cleaned up")
end

function SPropProtection.PlayerInitialSpawn(ply)
	ply:SetNWString("SPPSteamID", string.gsub(ply:SteamID(), ":", "_"))
	SPropProtection[ply:SteamID()] = {}
	SPropProtection.LoadFriends(ply)
	SPropProtection.AdminReload(ply)
	local TimerName = "SPropProtection.DRemove: "..ply:SteamID()
	if(timer.Exists(TimerName)) then
		timer.Remove(TimerName)
	end
end
hook.Add("PlayerInitialSpawn", "SPropProtection.PlayerInitialSpawn", SPropProtection.PlayerInitialSpawn)

function SPropProtection.Disconnect(ply)
	if not ply:IsPlayer() then return end
	if not ply:IsValid() then return end
	
	local sid = ply:SteamID()
	local sname = ply:Nick()
	
	if(tonumber(SPropProtection.Config["dpd"]) == 1) then
		if(ply:IsAdmin() and tonumber(SPropProtection.Config["dae"]) == 0) then
			if ply:IsUserGroup("moderator") then
				timer.Create("SPropProtection.DRemove: "..sid, 43200, 1, function() SPropProtection.DRemove( sid, sname ) end )
			else
				return
			end
		end
		if ply:IsMember() then
			if ply:IsDonator() then
				timer.Create("SPropProtection.DRemove: "..sid, 43200, 1, function() SPropProtection.DRemove( sid, sname ) end )
			else
				timer.Create("SPropProtection.DRemove: "..sid, 1800, 1, function() SPropProtection.DRemove( sid, sname ) end )
			end
		else
			timer.Create("SPropProtection.DRemove: "..sid, tonumber(SPropProtection.Config["delay"]), 1, function() SPropProtection.DRemove( sid, sname ) end )
		end
	end
end
hook.Add("PlayerDisconnected", "SPropProtection.Disconnect", SPropProtection.Disconnect)

function SPropProtection.PhysGravGunPickup(ply, ent)
	if(!ent or !ent:IsValid()) then
		return
	end
	if not SPropProtection.KVcanuse[ent:EntIndex()] then SPropProtection.KVcanuse[ent:EntIndex()] = -1 end
	if SPropProtection.KVcantouch[ent:EntIndex()] == 0 then
		return false
	end
	if SPropProtection.KVcantouch[ent:EntIndex()] == 2 or (SPropProtection.KVcantouch[ent:EntIndex()] == 1 and ply:IsAdmin()) then
		return
	end
	if(ent:IsPlayer() and ply:IsAdmin() and tonumber(SPropProtection.Config["admin"]) == 1) then
		return
	end
	if(!SPropProtection.PlayerCanTouch(ply, ent)) then
		return false
	end
end
hook.Add("GravGunPunt", "SPropProtection.GravGunPunt", SPropProtection.PhysGravGunPickup)
hook.Add("GravGunPickupAllowed", "SPropProtection.GravGunPickupAllowed", SPropProtection.PhysGravGunPickup)
hook.Add("PhysgunPickup", "SPropProtection.PhysgunPickup", SPropProtection.PhysGravGunPickup)

function SPropProtection.CanTool(ply, tr, mode)
	if(tr.HitWorld) then
		return
	end
	local ent = tr.Entity
	if(!ent:IsValid() or ent:IsPlayer()) then
		return false
	end
	
	if not SPropProtection.KVcanuse[ent:EntIndex()] then SPropProtection.KVcanuse[ent:EntIndex()] = -1 end
	if(!SPropProtection.PlayerCanTouch(ply, ent) or SPropProtection.KVcantool[ent:EntIndex()] == 0 or (SPropProtection.KVcantool[ent:EntIndex()] == 1 and !ply:IsAdmin())) then
		return false
	elseif(mode == "nail") then
		local Trace = {}
		Trace.start = tr.HitPos
		Trace.endpos = tr.HitPos + (ply:GetAimVector() * 16.0)
		Trace.filter = {ply, tr.Entity}
		local tr2 = util.TraceLine(Trace)
		if not SPropProtection.KVcanuse[tr2.Entity:EntIndex()] then SPropProtection.KVcanuse[tr2.Entity:EntIndex()] = -1 end
		if(tr2.Hit and IsValid(tr2.Entity) and !tr2.Entity:IsPlayer()) then
			if(!SPropProtection.PlayerCanTouch(ply, tr2.Entity) or SPropProtection.KVcantool[tr2.Entity:EntIndex()] == 0 or (SPropProtection.KVcantool[tr2.Entity:EntIndex()] == 1 and !ply:IsAdmin())) then
				return false
			end
		end
	elseif(table.HasValue(SPropProtection.WeirdTraces, mode)) then
		local Trace = {}
		Trace.start = tr.HitPos
		Trace.endpos = Trace.start + (tr.HitNormal * 16384)
		Trace.filter = {ply}
		local tr2 = util.TraceLine(Trace)
		if not SPropProtection.KVcanuse[tr2.Entity:EntIndex()] then SPropProtection.KVcanuse[tr2.Entity:EntIndex()] = -1 end
		if(tr2.Hit and IsValid(tr2.Entity) and !tr2.Entity:IsPlayer()) then
			if(!SPropProtection.PlayerCanTouch(ply, tr2.Entity) or SPropProtection.KVcantool[tr2.Entity:EntIndex()] == 0 or (SPropProtection.KVcantool[tr2.Entity:EntIndex()] == 1 and !ply:IsAdmin())) then
				return false
			end
		end
	elseif(mode == "remover") then
		if(ply:KeyDown(IN_ATTACK2) or ply:KeyDownLast(IN_ATTACK2)) then
			if(!SPropProtection.CheckConstraints(ply, ent)) then
				return false
			end
		end
	end
end
hook.Add("CanTool", "SPropProtection.CanTool", SPropProtection.CanTool)

function SPropProtection.EntityTakeDamageFireCheck(ent)
    if(!ent or !ent:IsValid()) then
		return
	end
	if(ent:IsOnFire()) then
		ent:Extinguish()
	end
end

function SPropProtection.EntityTakeDamage(ent, inflictor, attacker, amount, dmginfo)
	if(tonumber(SPropProtection.Config["edmg"]) == 0) then
		return
	end
    if(!ent:IsValid() or ent:IsPlayer() or !attacker:IsPlayer()) then
		return
	end
	if(!SPropProtection.PlayerCanTouch(attacker, ent)) then
		dmginfo:SetDamage(0)
		timer.Simple(0.1, function() SPropProtection.EntityTakeDamageFireCheck(ent) end)
	end
end
hook.Add("EntityTakeDamage", "SPropProtection.EntityTakeDamage", SPropProtection.EntityTakeDamage)

function SPropProtection.PlayerUse(ply, ent)

	if ent:GetNWBool("shared") == true then
		return
	end
	
	if ( ent:GetNWBool("tribeshared") == true ) and ply:Team() == ent.sharedtribe then
		return
	end

	if not SPropProtection.KVcanuse[ent:EntIndex()] then SPropProtection.KVcanuse[ent:EntIndex()] = -1 end
	if SPropProtection.KVcanuse[ent:EntIndex()] == 0  or (SPropProtection.KVcantouch[ent:EntIndex()] == 1 and !ply:IsAdmin()) then
		return false
	end
	if SPropProtection.KVcanuse[ent:EntIndex()] == 2 then
		return
	end
	if(ent:IsValid() and tonumber(SPropProtection.Config["use"]) == 1) then
		if(!SPropProtection.PlayerCanTouch(ply, ent) and ent:GetNetworkedString("Owner") != "World") then
			return false
		end
	end
end
hook.Add("PlayerUse", "SPropProtection.PlayerUse", SPropProtection.PlayerUse)

function SPropProtection.OnPhysgunReload(weapon, ply)
	if(tonumber(SPropProtection.Config["pgr"]) == 0) then
		return
	end
	local tr = util.TraceLine(util.GetPlayerTrace(ply))
	if(!tr.HitNonWorld or !tr.Entity:IsValid() or tr.Entity:IsPlayer()) then
		return
	end
	if(!SPropProtection.PlayerCanTouch(ply, tr.Entity)) then
		return false
	end
end
hook.Add("OnPhysgunReload", "SPropProtection.OnPhysgunReload", SPropProtection.OnPhysgunReload)

function SPropProtection.EntityRemoved(ent)
	SPropProtection.Props[ent:EntIndex()] = nil
end
hook.Add("EntityRemoved", "SPropProtection.EntityRemoved", SPropProtection.EntityRemoved)

function SPropProtection.PlayerSpawnedSENT(ply, ent)
	SPropProtection.PlayerMakePropOwner(ply, ent)
end
hook.Add("PlayerSpawnedSENT", "SPropProtection.PlayerSpawnedSENT", SPropProtection.PlayerSpawnedSENT)

function SPropProtection.PlayerSpawnedVehicle(ply, ent) 
	SPropProtection.PlayerMakePropOwner(ply, ent)
end
hook.Add("PlayerSpawnedVehicle", "SPropProtection.PlayerSpawnedVehicle", SPropProtection.PlayerSpawnedVehicle)

function SPropProtection.CDP(ply, cmd, args)
	if( IsValid(ply) and !ply:IsAdmin() ) then
		ply:PrintMessage( HUD_PRINTCONSOLE, "You are not an admin!" )
		return
	end
	for k,v in pairs(SPropProtection.Props) do
		local Found = false
		for k2,v2 in pairs(player.GetAll()) do
			if(v.SteamID == v2:SteamID()) then
				Found = true
			end
		end
		if(!Found) then
			local Ent = v.Ent
			if(Ent and Ent:IsValid()) then
				SGS.Log("**" .. Ent:GetClass() .. " owned by " .. v.SteamID .. " was deleted by PropProtect!")
				Ent:Remove()
			end
			SPropProtection.Props[k] = nil
		end
	end
	SPropProtection.NofityAll("Disconnected players props have been cleaned up")
	SGS.Log("**Disconnected player's props were removed by: " .. ply:Nick())
end
concommand.Add("spp_cdp", SPropProtection.CDP)

function SPropProtection.CleanupPlayerProps(ply)
	for k,v in pairs(SPropProtection.Props) do
		if(v.SteamID == ply:SteamID()) then
			local Ent = v.Ent
			if(Ent and Ent:IsValid()) then
				SGS.Log("**" .. Ent:GetClass() .. " owned by " .. ply:Nick() .. " was deleted by PropProtect!")
				Ent:Remove()
			end
			SPropProtection.Props[k] = nil
		end
	end
end

function SPropProtection.CleanupProps(ply, cmd, args)
	local EntIndex = args[1]
	if(!EntIndex or EntIndex == "") then
		if !IsValid(ply) then
			MsgN("usage: spp_cleanupprops <entity_id>")
			return
		end
		ply:SendLua("SGS_ConfirmPropCleanup()")
	elseif( !IsValid(ply) or ply:IsAdmin()) then
		for k,v in pairs(player.GetAll()) do
			if(tonumber(EntIndex) == v:EntIndex()) then
				SPropProtection.CleanupPlayerProps(v)
				SPropProtection.NofityAll(v:Nick().."'s props have been cleaned up")
				SGS.Log("**" .. v:Nick() .. "'s props were removed by: " .. ply:Nick())
			end
		end
	else
		ply:PrintMessage( HUD_PRINTCONSOLE, "You are not an admin!" )
	end
end
concommand.Add("spp_cleanupprops", SPropProtection.CleanupProps)

function SGS_ConfirmedCleanUpProps( ply, com, args )

		SPropProtection.CleanupPlayerProps(ply)
		SPropProtection.Nofity(ply, "Your props have been cleaned up")

end
concommand.Add("sgs_cleanupmyprops", SGS_ConfirmedCleanUpProps )

function SPropProtection.ApplyFriends(ply, cmd, args)
	if !IsValid(ply) then
		MsgN("This command can only be run in-game!")
	end
	local Players = player.GetAll()
	if(table.Count(Players) > 1) then
		local ChangedFriends = false
		for k,v in pairs(Players) do
			local PlayersSteamID = v:SteamID()
			local PData = ply:GetPData("SPPFriends", "")
			if(tonumber(ply:GetInfo("spp_friend_"..v:GetNWString("SPPSteamID", ""))) == 1) then
				if(!table.HasValue(SPropProtection[ply:SteamID()], PlayersSteamID)) then
					ChangedFriends = true
					table.insert(SPropProtection[ply:SteamID()], PlayersSteamID)
					if(PData == "") then
						ply:SetPData("SPPFriends", PlayersSteamID..";")
					else
						ply:SetPData("SPPFriends", PData..PlayersSteamID..";")
					end
				end
			else
				if(table.HasValue(SPropProtection[ply:SteamID()], PlayersSteamID)) then
					for k2,v2 in pairs(SPropProtection[ply:SteamID()]) do
						if(v2 == PlayersSteamID) then
							ChangedFriends = true
							table.remove(SPropProtection[ply:SteamID()], k2)
							ply:SetPData("SPPFriends", string.gsub(PData, PlayersSteamID..";", ""))
						end
					end
				end
			end
		end
		if(ChangedFriends) then
			local Table = {}
			for k,v in pairs(SPropProtection[ply:SteamID()]) do
				for k2,v2 in pairs(player.GetAll()) do
					if(v == v2:SteamID()) then
						table.insert(Table, v2)
					end
				end
			end
			gamemode.Call("CPPIFriendsChanged", ply, Table)
		end
	end
	SPropProtection.Nofity(ply, "Your friends have been updated")
end
concommand.Add("spp_applyfriends", SPropProtection.ApplyFriends)

function SPropProtection.ClearFriends(ply, cmd, args)
	if !ply then
		MsgN("This command can only be run in-game!")
	end
	local PData = ply:GetPData("SPPFriends", "")
	if(PData != "") then
		for k,v in pairs(string.Explode(";", PData)) do
			local String = string.Trim(v)
			if(String != "") then
				ply:ConCommand("spp_friend_"..string.gsub(String, ":", "_").." 0\n")
			end
		end
		ply:SetPData("SPPFriends", "")
	end
	for k,v in pairs(SPropProtection[ply:SteamID()]) do
		ply:ConCommand("spp_friend_"..string.gsub(v, ":", "_").." 0\n")
	end
	SPropProtection[ply:SteamID()] = {}
	SPropProtection.Nofity(ply, "Your friends have been cleared")
end
concommand.Add("spp_clearfriends", SPropProtection.ClearFriends)

function SPropProtection.ApplySettings(ply, cmd, args)
	if !ply then
		MsgN("This command can only be run in-game!")
	end
	if(!ply:IsAdmin()) then
		return
	end
	
	local toggle = tonumber(ply:GetInfo("spp_check") or 1)
	local admin = tonumber(ply:GetInfo("spp_admin") or 1)
	local use = tonumber(ply:GetInfo("spp_use") or 1)
	local edmg = tonumber(ply:GetInfo("spp_edmg") or 1)
	local pgr = tonumber(ply:GetInfo("spp_pgr") or 1)
	local awp = tonumber(ply:GetInfo("spp_awp") or 1)
	local dpd = tonumber(ply:GetInfo("spp_dpd") or 1)
	local dae = tonumber(ply:GetInfo("spp_dae") or 1)
	local delay = math.Clamp(tonumber(ply:GetInfo("spp_delay") or 120), 1, 500)
	
	sql.Query("UPDATE spropprotection SET toggle = "..toggle..", admin = "..admin..", use = "..use..", edmg = "..edmg..", pgr = "..pgr..", awp = "..awp..", dpd = "..dpd..", dae = "..dae..", delay = "..delay)
	
	SPropProtection.Config = sql.QueryRow("SELECT * FROM spropprotection LIMIT 1")
	
	timer.Simple(2, SPropProtection.AdminReload)
	
	SPropProtection.Nofity(ply, "Admin settings have been updated")
	SGS.Log("** " .. ply:Nick() .. " updated the SPP Admin options! Admins can do everything set to: " .. tostring(ply:GetInfo("spp_admin")), true)
end
concommand.Add("spp_apply", SPropProtection.ApplySettings)




// Modification allowing mappers to add keyvalues to entites that will override settings of spp
// so setting spp_canuse to 2 in some entity would make it possible for everyone to use it.
//
// Author: Sebi

SPropProtection.KVcantouch = {}
SPropProtection.KVcanuse = {}
SPropProtection.KVcantool = {}

function SPropProtection.CheckKeyvalue( ent, key, val )
	if !ent or !IsValid(ent) then return end
	if val == nil then return end
	
	if key == "spp_cantouch" then
		SPropProtection.KVcantouch[ ent:EntIndex() ] = tonumber(val)
	elseif key == "spp_canuse" then
		SPropProtection.KVcanuse[ ent:EntIndex() ] = tonumber(val)
	elseif key == "spp_cantool" then
		SPropProtection.KVcantool[ ent:EntIndex() ] = tonumber(val)
	end
end

hook.Add( 'EntityKeyValue', 'SPropProtection.CheckKeyvalue', SPropProtection.CheckKeyvalue )

function SPropProtection.WorldOwner()
	local WorldEnts = 0
	for k,v in pairs(ents.FindByClass("*")) do
		if(!v:IsPlayer() and !v:GetNetworkedString("Owner", false)) then
			v:SetNetworkedString("Owner", "World")
			WorldEnts = WorldEnts + 1
		end
	end
	Msg("=================================================\n")
	Msg("Simple Prop Protection: "..tostring(WorldEnts).." props belong to world\n")
	Msg("=================================================\n")
end
timer.Simple(6, SPropProtection.WorldOwner)