GM.Tribes = GM.Tribes or {}
GM.Tribes.tblTribes = GM.Tribes.tblTribes or {}

TRIBES_PERM_OPEN 		= 0
TRIBES_PERM_PASSWORD 	= 1
TRIBES_PERM_INVITEONLY	= 2

function GM.Tribes:IsValid( t_id )
	if self.tblTribes[ tonumber(t_id) ] then return true end
	return false
end

function GM.Tribes:GetPermissionType( t_id )
	if not self:IsValid( t_id ) then return nil end
	return self.tblTribes[ t_id ].perms.ptype
end

function GM.Tribes:GetPlayersTribe( ply )
	for t_id, _ in pairs( self.tblTribes ) do
		for k, v in pairs( self.tblTribes[ t_id ].members ) do
			if ply:SteamID() == k then
				return t_id
			end
		end
	end
	return nil
end

function GM.Tribes:GetOwnedTribes( ply )
	for t_id, _ in pairs( self.tblTribes ) do
		if self.tblTribes[ t_id ].pl_id == ply:SteamID() then
			return t_id
		end
	end
	return nil
end

function GM.Tribes:PlayerOwnsTribe( ply )
	for t_id, _ in pairs( self.tblTribes ) do
		if self.tblTribes[ t_id ].pl_id == ply:SteamID() then
			return true
		end
	end
	return false
end

function GM.Tribes:IsTribePersistent( ply )
	local t_id = self:GetPlayersTribe( ply )
	if not self:IsValid( t_id ) then return end
	
	return self.tblTribes[ t_id ].perma
end

function GM.Tribes:GetOnlineClanMates( ply )
	local tbl = team.GetPlayers( ply:Team() )
	table.RemoveByValue( tbl, ply )
	return tbl
end

function GM.Tribes:GetTribeLevel( ply )
	local t_id = self:GetPlayersTribe( ply )
	if not self:IsValid( t_id ) then return 0 end
	
	return self.tblTribes[ t_id ].level
end

function GM.Tribes:GetTribeIDLevel( t_id )
	if not self:IsValid( t_id ) then return 0 end
	
	return self.tblTribes[ t_id ].level
end

function GM.Tribes:PlayerInTribe( ply )
	for t_id, _ in pairs( self.tblTribes ) do
		for k, v in pairs( self.tblTribes[ t_id ].members ) do
			if ply:SteamID() == k then
				return true
			end
		end
	end
	return false
end

function GM.Tribes:ReversePlayerLookup( p_id )
	for k, v in pairs( player.GetAll() ) do
		if p_id == v:SteamID() then
			return v
		end
	end
	return nil
end

function GM.Tribes:GetOnlinePlayers( t_id )
	local tbl = {}
	for k, v in pairs( self.tblTribes[ t_id ].members ) do
		local ply =  self:ReversePlayerLookup( k )
		if ply then table.insert( tbl, ply ) end
	end
	return tbl
end

function GM.Tribes:GetPermaTribes()
	local tbl = {}
	for k, v in pairs( self.tblTribes ) do
		if v.perma == true then
			table.insert( tbl, v )
		end
	end
	return tbl
end

function GM.Tribes:GetExp( t_id )
	return self.tblTribes[ t_id ].exp or 0
end

GM.Tribes.ExpList = {
	0,					-- Level 1
	10000,				-- Level 2
	22000,				-- Level 3
	48400,				-- Level 4
	106480,				-- Level 5
	234256,				-- Level 6
	515363,				-- Level 7
	1133799,			-- Level 8
	2494357,			-- Level 9
	5487587,			-- Level 10
	12072692,			-- Level 11
}

GM.Tribes.PlayerExpCap = 10000

GM.Tribes.LevelPerks = {
	[1] = {
		name 	= 	"Experience Share 1",
		desc 	= 	"Chance for nearby tribe members to gain 5% of the experience you earn.",
	},
	[2] = {
		name 	= 	"Experience Boost 1",
		desc 	= 	"Permanent incease of total experience earned by 10%.",
	},
	[3] = {
		name 	= 	"Experience Share 2",
		desc 	= 	"Chance for nearby tribe members to gain 10% of the experience you earn.",
	},
	[4] = {
		name 	= 	"Death Item Protection",
		desc 	= 	"Lower chance to drop tools on death.",
	},
	[5] = {
		name 	= 	"Tribe Cache",
		desc 	= 	"Ability to summon a Tribal Cache.",
	},
	[6] = {
		name 	= 	"Fast Runner",
		desc 	= 	"Increased run and sprint speeds.",
	},
	[7] = {
		name 	= 	"Tribe Resurrection Bonus",
		desc 	= 	"Reduced resurrection sickness cooldown and increased resurrection time before death.",
	},
	[8] = {
		name 	= 	"Experience Boost 2",
		desc 	= 	"Permanent incease of total experience earned by 20%.",
	},
	[9] = {
		name 	= 	"Mass Resurrection",
		desc 	= 	"Ability to cast a spell that will resurrect any dead tribe members near you.",
	},
	[10] = {
		name 	= 	"Bartering",
		desc 	= 	"Vorty will sell you items for 10% cheaper.",
	},
}
	