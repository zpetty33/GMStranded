GM.Name		= "Garry's Mod Stranded"
GM.Author	= "Zach Petty - Mr.President"
GM.Email	= "mrp@g4p.org"
GM.Website	= "http://www.g4p.org"
GM.Version 	= "18.01.24"

SGS = SGS or {}

SPropProtection = SPropProtection or {}
SPropProtection.Version = 1.51 -- "SVN"

CPPI = CPPI or {}
CPPI_NOTIMPLEMENTED = 26
CPPI_DEFER = 16

GM.GroupData = {}
GM.GroupData = {
	["superadmin"] 	= { name = "Developer", 	color = Color( 0, 255, 55, 255 ) },
	["admin"]		= { name = "Administrator", color = Color( 255, 128, 0, 255 ) },
	["moderator"] 	= { name = "Moderator", 	color = Color( 255, 50, 50, 255 ) },
	["sponsor2"] 	= { name = "Void Sponsor", 	color = Color( 171, 0, 255, 255 ) },
	["sponsor"] 	= { name = "Sponsor", 		color = Color( 236, 236, 236, 255 ) },
	["donator"]		= { name = "Donator", 		color = Color( 255, 200, 0, 255 ) },
	["supporter"]	= { name = "Supporter", 	color = Color( 128, 255, 255, 255 ) },
	["veteran"] 	= { name = "Veteran", 		color = Color( 0, 0, 150, 255 ) },
	["member"] 		= { name = "Member", 		color = Color( 0, 0, 255, 255 ) },
	["usera"] 		= { name = "Guest", 		color = Color( 255, 75, 255, 255 ) },
	["user"] 		= { name = "Guest", 		color = Color( 255, 75, 255, 255 ) }
}

SGS.maxguestprops = 50
SGS.maxmemberprops = 90
SGS.maxdonatorprops = 115

SGS.maxgueststructures = 25
SGS.maxmemberstructures = 50
SGS.maxdonatorstructures = 75

team.SetUp (10000, "Survivors", Color (0, 0, 255, 255))

game.AddParticles("particles/thw_river.pcf")
PrecacheParticleSystem( "thw_waterfall_01" )
PrecacheParticleSystem( "waterfall_topsplash" )
PrecacheParticleSystem( "waterfall_base_01" )


SGS.version = "Stargate Stranded: v" .. GM.Version

local files, dirs = file.Find("gmstranded/gamemode/modules/*.lua", "LUA")
for k, v in pairs( files ) do
	print("Stranded: Loading module (" .. v .. ")")
	include( "gmstranded/gamemode/modules/" .. v )
	AddCSLuaFile( "gmstranded/gamemode/modules/" .. v )
end


include( "player_class/player_stranded.lua" )

local meta = FindMetaTable( "Entity" )
local PlayerMeta = FindMetaTable("Player")
INITSTATE_ASKING, INITSTATE_WAITING, INITSTATE_OK = 0, 1, 2
SGS_SetUpTablesShared()

function PlayerMeta:IsDonator()

	if self:IsUserGroup("donator") then
		return true
	end
	
	if self:IsUserGroup("sponsor") then
		return true
	end
	
	if self:IsUserGroup("sponsor2") then
		return true
	end
	
	if self:IsAdmin() then
		return true
	end
	
	return false
	
end

function PlayerMeta:IsMember()

	if self:IsUserGroup("member") then
		return true
	end
	
	if self:IsUserGroup("veteran") then
		return true
	end
	
	if self:IsUserGroup("supporter") then
		return true
	end
	
	if self:IsDonator() then
		return true
	end

end

function meta:IsNextBot()
	if self.Base == "base_nextbot" then return true end
	return false
end

function SGS_DateStep()
	
	local d = os.date("%d")
	local m = tonumber(os.date("%m"))
	local y = tonumber(os.date("%Y"))
	
	if m == 12 then
		m = 1
		y = y + 1
	else
		m = m + 1
	end
	
	if m < 10 then
		m = tostring(m)
		m = "0" .. m
	end
	
	local newdtg = tostring(m) .. "/" .. tostring(d) .. "/" .. tostring(y)
	
	return newdtg

end

function SGS_ReturnSortedTable( tbl )

	table.sort( tbl, function(a,b)
		local a_cat, a_info = SGS_FindTool( a )
		local b_cat, b_info = SGS_FindTool( b )
		
		if a_cat == b_cat then
			return a_info.title < b_info.title
		end
		
		return string.lower(a_cat) < string.lower(b_cat)
	end )
	
	return tbl

end

function SGS_ReverseToolLookup( tEnt )

	for k, v in pairs( SGS.Tools ) do
		for k2, v2 in pairs( SGS.Tools[ k ] ) do
			if v2.entity == tEnt then
				return v2
			end
		end
	end
	
end

function SGS_ReverseSpellLookup( spell )
	for k, v in pairs( SGS.SpellList ) do
		if v.spell == spell then
			return v
		end
	end
	return nil
end

function SGS_ReverseEggLookup( egg )
	for k, v in pairs( SGS.Eggs ) do
		if v.resource == egg then
			return v
		end
	end
	return nil
end

function SGS_ReverseFoodLookup( item )

	for k, v in pairs( SGS.Food ) do
		for k2, v2 in pairs( SGS.Food[ k ] ) do
			if v2.name == item then
				return v2
			end
		end
	end
	
end

function SGS_ReversePotionLookup( item )
	print( item )

	for k, v in pairs( SGS.Brewing ) do
		for k2, v2 in pairs( SGS.Brewing[ k ] ) do
			if v2.mname == item then
				return v2
			end
		end
	end
	
end

function SGS_FindTool( class )
	for cat, tools in pairs(SGS.Tools) do
		for _, info in pairs(tools) do
			if info.entity == class then
				return cat, info
			end
		end
	end
	return nil, nil
end


function SGS_CheckTimeForDay( time )

	if not time then return "Sunday" end

	local day = time
	
	if day == 1 then day = "Sunday" end
	if day == 2 then day = "Monday" end
	if day == 3 then day = "Tuesday" end
	if day == 4 then day = "Wednesday" end
	if day == 5 then day = "Thursday" end
	if day == 6 then day = "Friday" end
	if day == 7 then day = "Saturday" end
	
	return day
	

end

function SGS_CheckTimeForHour( time )

	if not time then return "00" end

	local hour = math.floor( time / 60 )
	
	if hour == 0 then hour = "00" end
	if hour == 1 then hour = "01" end
	if hour == 2 then hour = "02" end
	if hour == 3 then hour = "03" end
	if hour == 4 then hour = "04" end
	if hour == 5 then hour = "05" end
	if hour == 6 then hour = "06" end
	if hour == 7 then hour = "07" end
	if hour == 8 then hour = "08" end
	if hour == 9 then hour = "09" end
	
	return hour
	
end

function SGS_CheckTimeForMinute( time )

	if not time then return "00" end

	local min= math.floor( time % 60 )
	
	if min == 0 then min = "00" end
	if min == 1 then min = "01" end
	if min == 2 then min = "02" end
	if min == 3 then min = "03" end
	if min == 4 then min = "04" end
	if min == 5 then min = "05" end
	if min == 6 then min = "06" end
	if min == 7 then min = "07" end
	if min == 8 then min = "08" end
	if min == 9 then min = "09" end
	
	
	return min
	
end



------------------------------------
--	Simple Prop Protection
--	By Spacetech
-- 	http://code.google.com/p/simplepropprotection
------------------------------------

Msg("==========================================================\n")
Msg("Simple Prop Protection Version "..SPropProtection.Version.." by Spacetech has loaded\n")
Msg("==========================================================\n")

function GM:CalcMainActivity( ply, velocity )	

	ply.CalcIdeal = ACT_MP_STAND_IDLE
	ply.CalcSeqOverride = -1

	self:HandlePlayerLanding( ply, velocity, ply.m_bWasOnGround );
	
	if ( self:HandlePlayerNoClipping( ply, velocity ) ||
		self:HandlePlayerDriving( ply ) ||
		self:HandlePlayerVaulting( ply, velocity ) ||
		self:HandlePlayerJumping( ply, velocity ) ||
		self:HandlePlayerDucking( ply, velocity ) ||
		self:HandlePlayerSwimming( ply, velocity ) ) then
		
	else

		local len2d = velocity:Length2D()
		if ( len2d > 150 ) then ply.CalcIdeal = ACT_MP_RUN elseif ( len2d > 0.5 ) then ply.CalcIdeal = ACT_MP_WALK end

	end
	
	-- a bit of a hack because we're missing ACTs for a couple holdtypes
	local weapon = ply:GetActiveWeapon()
	local ht = "pistol"

	--if ( IsValid( weapon ) ) then ht = weapon:GetHoldType() end
	
	if ( ply.CalcIdeal == ACT_MP_CROUCH_IDLE &&	( ht == "knife" || ht == "melee2" ) ) then
		ply.CalcSeqOverride = ply:LookupSequence("cidle_" .. ht)
	end

	ply.m_bWasOnGround = ply:IsOnGround()
	ply.m_bWasNoclipping = (ply:GetMoveType() == MOVETYPE_NOCLIP)

	return ply.CalcIdeal, ply.CalcSeqOverride

end

function SGS_PhysgunLimitation( ply, ent )
	if SERVER then return end
	for _, v in pairs( SGS.restrictedphysgun ) do
		if ent:GetClass() == v then
			return false
		end
	end
	LocalPlayer().isgrab = true
end
hook.Add("PhysgunPickup", "SGS_PhysgunLimitation", SGS_PhysgunLimitation)

function SGS_PhysgunLimitation( ply, ent )
	if SERVER then return end
	LocalPlayer().isgrab = false
end
hook.Add("PhysgunDrop", "SGS_PhysgunLimitation", SGS_PhysgunLimitation)

function SGS_LockedPropsPhysgun( ply, ent )
	if table.HasValue( SGS.lockedprops, ent ) then
		return false
	end
end
hook.Add("PhysgunPickup", "SGS_LockedPropsPhysgun", SGS_LockedPropsPhysgun)

function meta:IsTree()
	
	local class = self:GetClass()
	if (string.sub(string.lower(class), 1, 8) == "gms_tree") then
		return true
	end
	return false

end

function SGS_AddLockedProp( ent )
	if not table.HasValue( SGS.lockedprops, ent ) then
		table.insert( SGS.lockedprops, ent )
	end
	if SERVER then
		net.Start("sgs_lockedprops")
			net.WriteString( "lock" )
			net.WriteEntity( ent )
		net.Broadcast()
	end
end

function SGS_RemoveLockedProp( ent )
	if table.HasValue( SGS.lockedprops, ent ) then
		table.remove( SGS.lockedprops, table.KeyFromValue( SGS.lockedprops, ent ) )
	end
	if SERVER then
		net.Start("sgs_lockedprops")
			net.WriteString( "unlock" )
			net.WriteEntity( ent )
		net.Broadcast()
	end
end