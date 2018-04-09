GM.Tribes = GM.Tribes or {}
GM.Tribes.tblTribes = {}

if !file.Exists( "SGStranded/Tribes", "DATA" ) then
	file.CreateDir( "SGStranded/Tribes" )
end

--Server to Client
util.AddNetworkString("tribes_sv_network")
util.AddNetworkString("tribes_sv_openmenu")
util.AddNetworkString("tribes_sv_networkpart")
--Client to Server
util.AddNetworkString("tribes_cl_createtribe")
util.AddNetworkString("tribes_cl_jointribe")
util.AddNetworkString("tribes_cl_admindisband")
util.AddNetworkString("tribes_cl_sendinvitation")
util.AddNetworkString("tribes_cl_kickplayer")




function GM.Tribes:GetFirstAvailable()
	for i=1, 9999, 1 do
		if self.tblTribes[i] == nil then
			return i
		end
	end
end

function GM.Tribes:CreateTribe( tbl, ply )
	local teamIndex	= self:GetFirstAvailable()
	self:InsertTribe( teamIndex, tbl )
	if IsValid(ply) then
		self:PlaceInTribe( ply, teamIndex )
	end
	self:NetworkTribe( nil, teamIndex )
end

function GM.Tribes:InsertTribe( t_id, tribe_table )
	team.SetUp( t_id, tribe_table.tr_name, tribe_table.color )
	self.tblTribes[t_id] = tribe_table
	self.tblTribes[t_id].index = self.tblTribes[t_id].index or t_id
	self.tblTribes[t_id].members = self.tblTribes[t_id].members or {}
	self.tblTribes[t_id].level = self.tblTribes[t_id].level or 0
	self.tblTribes[t_id].perma = self.tblTribes[t_id].perma or false
	
	if self.tblTribes[t_id].admins == nil then
		self.tblTribes[t_id].admins = {}
		self.tblTribes[t_id].admins[ self.tblTribes[t_id].pl_id ] = self.tblTribes[t_id].pl_name
	end
end

function GM.Tribes:DeleteTribe( tr_id )
	if not self:IsValid( tr_id ) then return end
	self.tblTribes[tr_id] = nil
	self:NetworkTribe( nil, tr_id, true )
end

net.Receive( "tribes_cl_createtribe", function( l, ply )
	if GAMEMODE.Tribes:GetOwnedTribes( ply ) then
		ply:SendMessage("You can't create a tribe while you already lead a tribe", 60, Color(255, 50, 50, 255))
		return
	end
	local tbl = net.ReadTable()
	if string.len(tbl.tr_name) >= 25 then
		ply:SendMessage("Tribe names must be under 25 characters in length.", 60, Color(255, 50, 50, 255))
		return
	end
	tbl.pl_id = ply:SteamID()
	tbl.pl_name = ply:Nick()
	GAMEMODE.Tribes:CreateTribe( tbl, ply )
	
end )

net.Receive( "tribes_cl_admindisband", function( l, ply )
	if not ply:IsAdmin() then return end
	local t_id = net.ReadInt( 16 )
	SGS.Log("**" .. ply:Nick() .. " disbanded the tribe: " .. GAMEMODE.Tribes.tblTribes[t_id].tr_name)
	GAMEMODE.Tribes:DisbandTribeID( t_id )
end )

net.Receive( "tribes_cl_jointribe", function( l, ply )
	local t_id = net.ReadInt( 16 )
	local pass = net.ReadString()
	if t_id == 10000 then
		GAMEMODE.Tribes:LeaveTribe( ply )
		return
	end
	if t_id == 10001 then
		GAMEMODE.Tribes:DisbandTribe( ply )
		return
	end
	if not GAMEMODE.Tribes:IsValid( t_id ) then return end
	GAMEMODE.Tribes:JoinTribe( ply, t_id, pass )
end )

function GM.Tribes:PlaceInTribe( ply, t_id )
	if not self:IsValid( t_id ) then return end
	self.tblTribes[ t_id ].members[ ply:SteamID() ] = ply:Nick()
	ply:SetTeam( t_id )
	ply.tribe = t_id
	ply:SendLua("RunConsoleCommand('sgs_refreshspells')")
end

function GM.Tribes:JoinTribe( ply, t_id, pass )
	if not self:IsValid( t_id ) then return end
	if self:GetPermissionType( t_id ) == 1 then
		if not ( self.tblTribes[t_id].perms.password == pass ) then
			ply:SendMessage("Your password to join this tribe is incorrect.", 60, Color(255, 50, 50, 255))
			return
		end
	end
	if self:GetPermissionType( t_id ) == 2 then
		if not self:RequestJoinTribe( ply, t_id ) then 
			ply:SendMessage("You need to be invited to join this tribe.", 60, Color(255, 50, 50, 255))
			return 
		end		
	end
	local current_tribe = self:GetPlayersTribe( ply )
	if current_tribe == t_id then
		ply:SendMessage("You are already in this tribe.", 60, Color(255, 50, 50, 255))
		return
	end
	if current_tribe then
		if self.tblTribes[ current_tribe ].pl_id == ply:SteamID() then
			ply:SendMessage("You cannot leave a tribe you are the leader of.", 60, Color(255, 50, 50, 255))
			return
		end
	end
	if not ply.tribe_lastjoin then ply.tribe_lastjoin = CurTime() - 130 end
	if CurTime() < ply.tribe_lastjoin + 120 then
		ply:SendMessage("You can only join a tribe once every 2 minutes.", 60, Color(255, 50, 50, 255))
		return
	end
	ply.tribe_lastjoin = CurTime()
	if current_tribe then
		self.tblTribes[ current_tribe ].members[ ply:SteamID() ] = nil
		self:NetworkTribe( nil, current_tribe )
	end
	ply:SendMessage("You are joining tribe: " .. self.tblTribes[ t_id ].tr_name, 60, Color(50, 255, 50, 255))
	for k, v in pairs( self:GetOnlinePlayers( t_id ) ) do
		v:SendMessage(ply:Nick() .. " has joined your tribe", 60, Color(50, 255, 50, 255))
	end
	self:PlaceInTribe( ply, t_id )
	self:NetworkTribe( nil, t_id )
end

function GM.Tribes:RequestJoinTribe( ply, t_id )
	if not self:IsValid( t_id ) then return end
	ply.tribe_invites = ply.tribe_invites or {}
	if table.HasValue( ply.tribe_invites, t_id ) then return true end
	return false
end

net.Receive( "tribes_cl_sendinvitation", function( l, ply )
	local t_id = net.ReadInt( 16 )
	local inv_ply = net.ReadEntity()
	GAMEMODE.Tribes:SendTribeInvitation( ply, inv_ply, t_id )
end )

net.Receive( "tribes_cl_kickplayer", function( l, ply )
	local tbl = net.ReadTable()
	local t_id = tbl.t_id
	local p_id = tbl.p_id
	if not GAMEMODE.Tribes:PlayerOwnsTribe( ply ) then return end
	if not ( GAMEMODE.Tribes:GetPlayersTribe( ply ) == t_id ) then return end
	local ply = GAMEMODE.Tribes:ReversePlayerLookup( p_id )
	if IsValid( ply ) then
		GAMEMODE.Tribes:LeaveTribe( ply )
		if ply.tribes then
			table.RemoveByValue( ply.tribe_invites, t_id )
		end
	else
		if not GAMEMODE.Tribes:IsValid( t_id ) then return end
		GAMEMODE.Tribes.tblTribes[ t_id ].members[ p_id ] = nil
		GAMEMODE.Tribes:NetworkTribe( nil, t_id )
	end
end )

function GM.Tribes:SendTribeInvitation( ply, inv_ply, t_id )
	if not IsValid( ply ) then return end
	if not IsValid( inv_ply ) then return end
	if not self:IsValid( t_id ) then return end
	if self:RequestJoinTribe( inv_ply, t_id ) then return end
	if not ( self:GetPlayersTribe( ply ) == t_id ) then return end
	table.insert( inv_ply.tribe_invites, t_id )
	inv_ply:SendMessage("To accept, join through the Tribes Menu (F3)", 60, Color(50, 255, 50, 255))
	inv_ply:SendMessage("you have been invited to a tribe by " .. ply:Nick(), 60, Color(50, 255, 50, 255))
	ply:SendMessage("You have sent a tribe invite to: " .. inv_ply:Nick(), 60, Color(50, 255, 50, 255))
end

function GM.Tribes:LeaveTribe( ply )
	local current_tribe = self:GetPlayersTribe( ply )
	if current_tribe then
		if self.tblTribes[ current_tribe ].pl_id == ply:SteamID() then
			ply:SendMessage("You cannot leave a tribe you are the leader of.", 60, Color(255, 50, 50, 255))
			return
		end
	end
	if current_tribe then
		self.tblTribes[ current_tribe ].members[ ply:SteamID() ] = nil
		self:NetworkTribe( nil, current_tribe )
		ply:SendLua("RunConsoleCommand('sgs_refreshspells')")
		
		for k, v in pairs( self:GetOnlinePlayers( current_tribe ) ) do
			v:SendMessage(ply:Nick() .. " has left your tribe", 60, Color(50, 255, 50, 255))
		end
	end
	ply:SetTeam( 10000 )
	ply.tribe = nil
end

function GM.Tribes:DisbandTribe( ply )
	if not self:PlayerOwnsTribe( ply ) then return end
	local current_tribe = self:GetPlayersTribe( ply )
	if current_tribe then
		local online_players = self:GetOnlinePlayersInTribe( current_tribe )
		for k, v in pairs( online_players ) do
			v:SetTeam( 10000 )
			v:SendMessage("Your tribe is disbanding.", 60, Color(255, 50, 50, 255))
			v:SendLua("RunConsoleCommand('sgs_refreshspells')")
		end
		self:DeleteTribe( current_tribe )
	end
end

function GM.Tribes:DisbandTribeID( t_id )
	local current_tribe = t_id
	if not self:IsValid( current_tribe ) then return end
	if current_tribe then
		local online_players = self:GetOnlinePlayersInTribe( current_tribe )
		for k, v in pairs( online_players ) do
			v:SetTeam( 10000 )
			v:SendMessage("Your tribe is disbanding.", 60, Color(255, 50, 50, 255))
		end
		self:DeleteTribe( current_tribe )
	end
end

function GM.Tribes:GetOnlinePlayersInTribe( t_id )
	local tbl = {}
	for k, v in pairs( self.tblTribes[ t_id ].members ) do
		for _, p in pairs( player.GetAll() ) do
			if p:SteamID() == k then
				table.insert( tbl, p )
				break
			end
		end
	end
	return tbl
end

function GM.Tribes:NetworkTribe( ply, t_id, delete )
	if t_id == 0 then
		local tbl = table.Copy( GAMEMODE.Tribes.tblTribes )
		for k, v in pairs( tbl ) do
			tbl[k].perms.password = "**HIDDEN**"
			tbl[k].cachecontents = nil
		end

		net.Start("tribes_sv_network")
			net.WriteBit( true )
			net.WriteTable( tbl )
		if IsValid(ply) then 
			net.Send( ply )
		else
			net.Broadcast()
			self:SaveTribes()
		end
	else
		if not delete then
			local tbl = table.Copy( GAMEMODE.Tribes.tblTribes )
			for k, v in pairs( tbl ) do
				tbl[k].perms.password = "**HIDDEN**"
			end
			net.Start("tribes_sv_network")
				net.WriteBit( false )
				net.WriteInt( t_id, 16 )
				net.WriteTable( tbl[t_id] )
			if IsValid(ply) then 
				net.Send( ply )
			else
				net.Broadcast()
				self:SaveTribes()
			end
		else
			net.Start("tribes_sv_network")
				net.WriteBit( false )
				net.WriteInt( t_id, 16 )
				net.WriteTable( { delete = true } )
			if IsValid(ply) then 
				net.Send( ply )
			else
				net.Broadcast()
				self:SaveTribes()
			end
		end
	end
end

function GM.Tribes:UpgradeTribe( ply )
	local t_id = self:GetPlayersTribe( ply )
	if not self:IsValid( t_id ) then return end
	
	self.tblTribes[ t_id ].perma = true
	self.tblTribes[ t_id ].level = self.tblTribes[ t_id ].level + 1
	self:NetworkTribe( nil, t_id )
	
	local online_players = self:GetOnlinePlayersInTribe( t_id )
	for k, v in pairs( online_players ) do
		v:SendMessage("Your tribe has been upgraded!", 60, Color(50, 255, 100, 255))
	end
	self:SaveTribes()
end

function GM.Tribes:AddExp( t_id, amt )
	if self.tblTribes[ t_id ].level >= 10 then return end
	if not self.tblTribes[ t_id ].exp then self.tblTribes[ t_id ].exp = 0 end
	self.tblTribes[ t_id ].exp = self.tblTribes[ t_id ].exp + amt
	self:CheckNextLevel( t_id )
	self:NetworkTribeExp( t_id, self.tblTribes[ t_id ].exp )
end

function GM.Tribes:NetworkTribeExp( t_id, exp )
	net.Start("tribes_sv_networkpart")
		net.WriteUInt( t_id, 8 )
		net.WriteUInt( 0, 8 )
		net.WriteUInt( exp, 32 )
	net.Broadcast()
end

function GM.Tribes:NetworkContribution( t_id, ply, exp )
	net.Start("tribes_sv_networkpart")
		net.WriteUInt( t_id, 8 )
		net.WriteUInt( 1, 8 )
		net.WriteUInt( exp, 32 )
		net.WriteEntity( ply )
	net.Broadcast()
end

function GM.Tribes:CheckNextLevel( t_id )
	local clvl = self:GetTribeIDLevel( t_id )
	local nlvl = clvl + 1
	local expreq = self.ExpList[nlvl]
	
	local cexp = self:GetExp( t_id )
	
	if cexp >= expreq then
		self:SetLevel( t_id, nlvl )
	end
end

function GM.Tribes:SetLevel( t_id, lvl )
	self.tblTribes[ t_id ].level = lvl
	self:NetworkTribe( nil, t_id )
	
	local online_players = self:GetOnlinePlayersInTribe( t_id )
	for k, v in pairs( online_players ) do
		v:SendMessage("Your tribe has leveled up!", 60, Color(50, 255, 100, 255))
		v:SendLua("RunConsoleCommand('sgs_refreshspells')")
	end
	self:SaveTribes()
end

timer.Create( "saveTribesTimer", 1800, 0, function()
	ServerLog("Stranded: Tribes Saved\n")
	GAMEMODE.Tribes:SaveTribes()
end )

function GM.Tribes:SaveTribes()
	local tbl = self:GetPermaTribes()
	file.Write("SGStranded/Tribes/tribes.txt",util.TableToJSON(tbl, true))
	ServerLog("Stranded: Tribes Saved\n")
end

function GM.Tribes:LoadTribes()
	local tbl_tribes = {}
	if file.Exists("SGStranded/Tribes/tribes.txt", "DATA") then
		local tbl = file.Read("SGStranded/Tribes/tribes.txt", "DATA")
		tbl_tribes = util.JSONToTable( tbl )
		
		for k, v in pairs( tbl_tribes ) do
			self:InsertTribe( v.index, v )
		end
		self:NetworkTribe( nil, 0 )
	end
	
end
hook.Add( "Initialize", "Load Tribes", function( ... ) GAMEMODE.Tribes:LoadTribes( ... ) end )

function GM.Tribes:PlayerSpawn( ply )
	timer.Simple( 1, function()
		if not IsValid( ply ) then return end
		ply:SetTeam(10000)
		self:NetworkTribe( ply, 0 )
		local p_tribe = self:GetPlayersTribe( ply )
		if p_tribe then self:PlaceInTribe( ply, p_tribe ) end
	end )
end
hook.Add("PlayerInitialSpawn", "InitialSpawnSetTribe", function( ... ) GAMEMODE.Tribes:PlayerSpawn( ... ) end )

function AutoSaveTribes()
	GAMEMODE.Tribes:SaveTribes()
end
timer.Create( 'Auto Save Tribes', 300, 0, AutoSaveTribes )

function CheckExperienceResetTime()
	if os.date("%H") + 0 == 22 and os.date("%M") + 0 == 0 then
		GAMEMODE.Tribes.ExpCaps = {}
		for k, v in pairs( player.GetAll() ) do
			if GAMEMODE.Tribes:IsTribePersistent( v ) then
				v:SendMessage("Daily tribe experience contribution cap reset!", 60, Color(50, 255, 100, 255))
			end
		end
	end
end
timer.Create( 'CheckExperienceResetTime', 60, 0, CheckExperienceResetTime )






function TribesChangePassword( ply, com, args )
	if not GAMEMODE.Tribes:PlayerOwnsTribe( ply ) then return end
	local newpassword = args[1]
	
	local t_id = GAMEMODE.Tribes:GetPlayersTribe( ply )
	GAMEMODE.Tribes.tblTribes[ t_id ].perms.password = newpassword
	GAMEMODE.Tribes.tblTribes[ t_id ].perms.ptype = 1
	GAMEMODE.Tribes:NetworkTribe( nil, t_id )
end
concommand.Add( "tribe_changepassword", TribesChangePassword )

function SetTribeInviteOnly( ply, com, args )
	if not GAMEMODE.Tribes:PlayerOwnsTribe( ply ) then return end

	local t_id = GAMEMODE.Tribes:GetPlayersTribe( ply )
	GAMEMODE.Tribes.tblTribes[ t_id ].perms.password = ""
	GAMEMODE.Tribes.tblTribes[ t_id ].perms.ptype = 2
	GAMEMODE.Tribes:NetworkTribe( nil, t_id )
end
concommand.Add( "tribe_makeinvite", SetTribeInviteOnly )

function SetTribePublic( ply, com, args )
	if not GAMEMODE.Tribes:PlayerOwnsTribe( ply ) then return end

	local t_id = GAMEMODE.Tribes:GetPlayersTribe( ply )
	GAMEMODE.Tribes.tblTribes[ t_id ].perms.password = ""
	GAMEMODE.Tribes.tblTribes[ t_id ].perms.ptype = 0
	GAMEMODE.Tribes:NetworkTribe( nil, t_id )
end
concommand.Add( "tribe_makeopen", SetTribePublic )

function SetNewTribeOwner( ply, com, args )
	if not GAMEMODE.Tribes:PlayerOwnsTribe( ply ) then 
		ply:SendMessage("You are not the owner of this tribe.", 60, Color(255, 100, 100, 255))
		return 
	end
	local t_id = GAMEMODE.Tribes:GetPlayersTribe( ply )
	
	local new_owner = GAMEMODE.getUser( args[1] )
	
	if not new_owner then
		ply:SendMessage("No player found by that name!", 60, Color(255, 100, 100, 255))
		return
	end
	
	if GAMEMODE.Tribes:GetPlayersTribe( new_owner ) ~= t_id then
		ply:SendMessage("This player needs to be in your tribe first!", 60, Color(255, 100, 100, 255))
		return
	end
	
	GAMEMODE.Tribes.tblTribes[ t_id ].admins = {}
	GAMEMODE.Tribes.tblTribes[ t_id ].admins[ new_owner:SteamID() ] = new_owner:Nick()
	GAMEMODE.Tribes.tblTribes[ t_id ].pl_id = new_owner:SteamID()
	GAMEMODE.Tribes.tblTribes[ t_id ].pl_name = new_owner:Nick()
	SGS.Log("**" .. ply:Nick() .. "(" .. ply:SteamID() .. ") transfered the tribe: (" .. GAMEMODE.Tribes.tblTribes[t_id].tr_name .. ") to " .. new_owner:Nick() )
	ply:SendMessage("You have transfered ownership of your tribe!", 60, Color(50, 255, 100, 255))
	new_owner:SendMessage("You are now the leader of " .. GAMEMODE.Tribes.tblTribes[t_id].tr_name, 60, Color(50, 255, 100, 255))
end
concommand.Add( "tribe_transferowner", SetNewTribeOwner )