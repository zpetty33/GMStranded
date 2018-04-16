AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local files, dirs = file.Find("gmstranded/gamemode/modules/client/*.lua", "LUA")
for k, v in pairs( files ) do
	ServerLog("Stranded: Loading module (" .. v .. ")\n")
	AddCSLuaFile( "gmstranded/gamemode/modules/client/" .. v )
end

local files, dirs = file.Find("gmstranded/gamemode/modules/client/skybox/*.lua", "LUA")
for k, v in pairs( files ) do
	ServerLog("Stranded: Loading module (" .. v .. ")\n")
	AddCSLuaFile( "gmstranded/gamemode/modules/client/skybox/" .. v )
end

local files, dirs = file.Find("gmstranded/gamemode/modules/server/*.lua", "LUA")
for k, v in pairs( files ) do
	ServerLog("Stranded: Loading module (" .. v .. ")\n")
	include( "gmstranded/gamemode/modules/server/" .. v )
end

resource.AddWorkshop( "194010712" ) --Content Pack 1
resource.AddWorkshop( "484763066" ) --Content Pack 2
resource.AddWorkshop( "842705900" ) --Content Pack 3
resource.AddWorkshop( "249121668" ) --Hat Pack

resource.AddSingleFile( "particles/thw_river.pcf" )

local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")

if !file.Exists( "sgstranded", "DATA" ) then
	file.CreateDir( "sgstranded" )
end

if !file.Exists( "sgstranded/saves", "DATA" ) then
	file.CreateDir( "sgstranded/saves" )
end

if !file.Exists( "sgstranded/saves/inventory", "DATA" ) then
	file.CreateDir( "sgstranded/saves/inventory" )
end

if !file.Exists( "sgstranded/saves/inventory/PCacheBoss", "DATA" ) then
	file.CreateDir( "sgstranded/saves/inventory/PCacheBoss" )
end

if !file.Exists( "sgstranded/saves/inventory/PCache", "DATA" ) then
	file.CreateDir( "sgstranded/saves/inventory/PCache" )
end

if !file.Exists( "sgstranded/saves/inventory/PCache2", "DATA" ) then
	file.CreateDir( "sgstranded/saves/inventory/PCache2" )
end

if !file.Exists( "sgstranded/saves/inventory/PCache3", "DATA" ) then
	file.CreateDir( "sgstranded/saves/inventory/PCache3" )
end

if !file.Exists( "sgstranded/saves/inventory/PCache4", "DATA" ) then
	file.CreateDir( "sgstranded/saves/inventory/PCache4" )
end

if !file.Exists( "sgstranded/saves/inventory/PTCache", "DATA" ) then
	file.CreateDir( "sgstranded/saves/inventory/PTCache" )
end

if !file.Exists( "sgstranded/saves/pets", "DATA" ) then
	file.CreateDir( "sgstranded/saves/pets" )
end

if !file.Exists( "sgstranded/crashrecovery", "DATA" ) then
	file.CreateDir( "sgstranded/crashrecovery" )
end

if !file.Exists( "sgstranded/saves/tools", "DATA" ) then
	file.CreateDir( "sgstranded/saves/tools" )
end

if !file.Exists( "g4p/gtokens", "DATA" ) then
	file.CreateDir( "g4p/gtokens" )
end

for k, v in pairs(SGS.pma) do
	player_manager.TranslatePlayerModel( v )
end

function Init_Gamemode()


	SGS.gminit = true
	SGS.inedit = false
	SGS.noneeds = false
	SGS.time = 1
	SGS.weather = "clear"
	SGS.gamemodeinit = true
	SGS.lastvorttalk = CurTime()
	SGS.rgnext = CurTime()
	SGS.lastphase = "night"
	SGS.totallions = 30
	SGS.lockedprops = {}

	SGS_PreCacheMessage()

	timer.Simple(1, function() SGS_LoadCrashFile() end)
	timer.Destroy("sgs_makesuregamemodeinit")

end
hook.Add( "Initialize", "initializing", Init_Gamemode )


function GM:InitPostEntity()
	SGS_LoadWorlds()
	for k, v in pairs( ents.FindByName("part_waterfall_main*") ) do
		v:SetNWBool("waterfall", true)
	end
	for k, v in pairs( ents.FindByName("part_waterfall_top*") ) do
		v:SetNWBool("waterfalltop", true)
	end
	for k, v in pairs( ents.FindByName("part_waterfall_base*") ) do
		v:SetNWBool("waterfallbase", true)
	end
end

function SGS_PreCacheMessage()
	util.AddNetworkString("UpdateShadow")
	util.AddNetworkString("UpdateGrowth")
	util.AddNetworkString("ReceivePethouse")
	util.AddNetworkString("UpdateCacheTable")
	util.AddNetworkString("UpdateTCacheTable")
	util.AddNetworkString("UpdateResourceCrate")
	util.AddNetworkString("SGS_OpenTOS")
	util.AddNetworkString("sgs_updateresource")
	util.AddNetworkString("sgs_receivegtoken")
	util.AddNetworkString("sgs_updatelevel")
	util.AddNetworkString("sgs_updateexp")
	util.AddNetworkString("sgs_updateneeds")
	util.AddNetworkString("sgs_updatetime")
	util.AddNetworkString("sgs_updateplayermodels")
	util.AddNetworkString("sgs_updateadtext")
	util.AddNetworkString("sgs_starttimer")
	util.AddNetworkString("sgs_addtool")
	util.AddNetworkString("sgs_remtool")
	util.AddNetworkString("gms_sendmessage")
	util.AddNetworkString("gms_sendxpmessage")
	util.AddNetworkString("sgs_openrcache")
	util.AddNetworkString("sgs_opentcache")
	util.AddNetworkString("sgs_sendo2")
	util.AddNetworkString("UpdateVoiceChannels")
	util.AddNetworkString("SendStats")
	util.AddNetworkString("SendStatsOther")
	util.AddNetworkString("sgs_updateplantcount")
	util.AddNetworkString("sgs_syncachievements")
	util.AddNetworkString("sgs_treetable")
	util.AddNetworkString("sgs_lockedprops")
	util.AddNetworkString("sgs_lockedpropstable")
	util.AddNetworkString("client_opentotemmenu")
	util.AddNetworkString("sgs_sendresourcestable")
	util.AddNetworkString("sgs_sendtoolsstable")
	util.AddNetworkString("sgs_settimeupdate")
	util.AddNetworkString("sgs_updatebloodmoon")
	util.AddNetworkString("sgs_sendpropcount")
	util.AddNetworkString("sgs_sendstructurecount")
	util.AddNetworkString("sgs_deathreport")
	util.AddNetworkString("sgs_skillunlock")
	util.AddNetworkString("GAT_ColorMessage")

	--Client to Server
	util.AddNetworkString("sgs_readytoload")
	util.AddNetworkString("sgs_updateresourcebox")
	util.AddNetworkString("cl_fromrcache")
	util.AddNetworkString("cl_frompcache1")
	util.AddNetworkString("cl_frompcache2")
	util.AddNetworkString("cl_frompcache3")
	util.AddNetworkString("cl_frompcache4")
	util.AddNetworkString("cl_frompcacheboss")
	util.AddNetworkString("cl_fromtcache")
	util.AddNetworkString("cl_fromptcache")
	util.AddNetworkString("cl_fromtribecache")

	util.AddNetworkString("cl_torcache")
	util.AddNetworkString("cl_topcache1")
	util.AddNetworkString("cl_topcache2")
	util.AddNetworkString("cl_topcache3")
	util.AddNetworkString("cl_topcache4")
	util.AddNetworkString("cl_topcacheboss")
	util.AddNetworkString("cl_totcache")
	util.AddNetworkString("cl_toptcache")
	util.AddNetworkString("cl_totribecache")

end

function MakeSureInit()
	if SGS.gminit == nil then
		Init_Gamemode()
	end
end
timer.Create("sgs_makesuregamemodeinit", 10, 0, MakeSureInit)

function SGS_SetNeeds( ply )

	ply.needs = {}
	ply.needs["hunger"] = ply.maxneeds
	ply.needs["thirst"] = ply.maxneeds
	ply.needs["fatigue"] = ply.maxneeds
	ply:SendNeeds()

end

function PlayerMeta:RandomFindChance()

	chance = 100
	if self.luck then
		local luck = 40
		luck = luck * self.luck
		chance = chance - luck
	end
	if math.random(1,chance) == 1 then
		rnd = math.random(1,10)
		self:GiveGTokens( rnd )
		if rnd == 1 then
			self:SendMessage( "1x GToken Found!", 60, Color(0, 255, 0, 255))
		else
			self:SendMessage( tostring(rnd) .. "x GTokens Found!", 60, Color(0, 255, 0, 255))
		end
		self:AddStat( "general13", rnd )
		self:CheckForAchievements("presshat")
	end


	chance = 600
	if self.luck then
		local luck = 100
		luck = luck * self.luck
		chance = chance - luck
	end
	if math.random(1,chance) == 1 then
		self:FindFirework()
	end


	chance = 120
	if self.luck then
		local luck = 60
		luck = luck * self.luck
		chance = chance - luck
	end
	if math.random(1, chance) == 1 then
		self:FindMagicStone()
	end


	chance = 2500
	if self.luck then
		local luck = 400
		luck = luck * self.luck
		chance = chance - luck
	end
	if math.random(1,chance) == 856 then
		for _, v in pairs( player.GetAll() ) do
			v:SendMessage( self:Nick() .. " found a Void Cache.", 60, Color(0, 255, 0, 255))
		end
		self:AddResource( "void_cache", 1 )
		self:CheckForAchievements("voidcache1")
		self:AddStat( "general17", 1 )
		SGS.Log("** " .. self:Nick() .. " found a Void Cache!")
	end


	chance = 100
	if self.luck then
		local luck = 50
		luck = luck * self.luck
		chance = chance - luck
	end
	if SGS_IsChristmasEvent() then
		if math.random(1,chance) == 25 then
			if not self:GetAch("santahat") then
				self:SetAch("santahat")
			end
		end
	end
end

function PlayerMeta:FindFirework()
	local fwtable = {"gms_firework_red", "gms_firework_green", "gms_firework_blue", "gms_firework_purple", "gms_firework_cyan", "gms_firework_yellow", "gms_firework_white", "gms_firework_rainbow" }
	local fwnames = {"red_firework", "green_firework", "blue_firework", "purple_firework", "cyan_firework", "yellow_firework", "white_firework", "rainbow_firework"}
	local chance = math.random(1,10)
	if chance <= 7 then
		fwtype = fwtable[chance]
	else
		fwtype = fwtable[8]
		chance = 8
	end

	self:SendMessage("You found a " ..CapAll(string.gsub(fwnames[chance], "_", " ")).. "!", 60, Color(0, 255, 0, 255))
	self:AddResource( fwtype, 1 )

end

function PlayerMeta:FindMagicStone()

	local stype = math.random(1,10)

	if stype <= 5 then
		local nstype = math.random(1,10)
		if nstype <=4 then
			self:SendMessage("You found a Wind Stone!", 60, Color(0, 255, 0, 255))
			self:AddResource( "wind_stone", math.random(1,3) )
		elseif nstype <=7 and nstype > 5 then
			self:SendMessage("You found a Water Stone!", 60, Color(0, 255, 0, 255))
			self:AddResource( "water_stone", math.random(1,3) )
		elseif nstype <=9 and nstype > 7 then
			self:SendMessage("You found a Earth Stone!", 60, Color(0, 255, 0, 255))
			self:AddResource( "earth_stone", math.random(1,3) )
		else
			self:SendMessage("You found a Fire Stone!", 60, Color(0, 255, 0, 255))
			self:AddResource( "fire_stone", math.random(1,3) )
		end
	elseif stype < 9 and stype > 5 then
		self:SendMessage("You found a Chaos Stone!", 60, Color(0, 255, 0, 255))
		self:AddResource( "chaos_stone", math.random(1,2) )
	else
		if math.random(1,3) == 1 then
			self:SendMessage("You found a Nature Stone!", 60, Color(0, 255, 0, 255))
			self:AddResource( "nature_stone", 1 )
		else
			self:SendMessage("You found a Cosmic Stone!", 60, Color(0, 255, 0, 255))
			self:AddResource( "cosmic_stone", 1 )
		end
	end

end



function PlayerMeta:FindSkillBook()

        local rnd = math.random(1,10)
        local skills = {"woodcutting", "mining", "construction", "smithing", "farming", "fishing", "cooking", "combat", "alchemy", "arcane"}
        --Testing shows that this vvv selects the same number each time, but this is likely just interpreter error.
        local bookType = skills[math.random(#skills)]

        if rnd <= 6 then
                self:SendMessage("You found a level 1 " .. bookType .. " skill book!", 60, Color(0, 255, 0, 255))
                self:AddResource( booktype .. "_skillbook_1", 1)
        elseif rnd <= 9 and rnd > 6 then
                self:SendMessage("You found a level 2 " .. bookType .. " skill book!", 60, Color(0, 255, 0, 255))
                self:AddResource( booktype .. "_skillbook_2", 1)
        else
                self:SendMessage("You found a level 3 " .. bookType .. " skill book!", 60, Color(0, 255, 0, 255))
                self:AddResource( booktype .. "_skillbook_3", 1)
        end

end

function SGS_SynchPethouse( ply )

	if ply.pethouse then
		net.Start("ReceivePethouse")
			net.WriteTable( ply.pethouse )
		net.Send( ply )
	end

end

function PlayerMeta:SetSick( val )
	self.sick = val
	self.settings["melonaids"] = val
	self:SendMessage("You've been infected with Melonaids!", 60, Color(255, 0, 0, 255))
	self:SendLua("LocalPlayer().melonaids = true")
end

--DEFAULT GAMEMODE FUNCTIONS--


function PlayerMeta:ClaimFruit()

	for k, v in pairs(ents.FindByClass("gms_plant")) do
		if v.oid == self:GetPlayerID() then
			v.owner = self
			self.tplants = self.tplants + 1
		end
	end

	for k, v in pairs(ents.FindByClass("gms_wheat")) do
		if v.oid == self:GetPlayerID() then
			v.owner = self
			self.tplants = self.tplants + 1
		end
	end

	for k, v in pairs(ents.FindByClass("gms_liferoot")) do
		if v.oid == self:GetPlayerID() then
			v.owner = self
			self.tplants = self.tplants + 1
		end
	end

	for k, v in pairs(ents.FindByClass("gms_tree*")) do
		if v.oid == self:GetPlayerID() then
			v.owner = self
			self.tplants = self.tplants + 1
		end
	end

	for k, v in pairs(ents.FindByClass("gms_*seed")) do
		if v.oid == self:GetPlayerID() then
			v.owner = self
			self.tplants = self.tplants + 1
		end
	end

	self:UpdatePlantCount()

end

function PlayerMeta:UpdatePlantCount()
	net.Start("sgs_updateplantcount")
		net.WriteInt( self.tplants, 32 )
	net.Send( self )
end

function PlayerMeta:CreateDerma()
	self:SendLua("SGS_CreateDerma()")
end

function SGS_SetUpTeams(ply)
	if ply:IsUserGroup("superadmin") then
		ply.allowedmodels = SGS.pma
		net.Start("sgs_updateplayermodels")
			net.WriteString( "a" )
		net.Send( ply )
		return
	end
	if ply:IsUserGroup("admin") then
		ply.allowedmodels = SGS.pma
		net.Start("sgs_updateplayermodels")
			net.WriteString( "a" )
		net.Send( ply )
		return
	end
	if ply:IsUserGroup("moderator") then
		ply.allowedmodels = SGS.pmm
		net.Start("sgs_updateplayermodels")
			net.WriteString( "m" )
		net.Send( ply )
		return
	end
	if ply:IsUserGroup("sponsor2") then
		ply.allowedmodels = SGS.pmd
		net.Start("sgs_updateplayermodels")
			net.WriteString( "d" )
		net.Send( ply )
		return
	end
	if ply:IsUserGroup("sponsor") then
		ply.allowedmodels = SGS.pmd
		net.Start("sgs_updateplayermodels")
			net.WriteString( "d" )
		net.Send( ply )
		return
	end
	if ply:IsUserGroup("donator") then
		ply.allowedmodels = SGS.pmd
		net.Start("sgs_updateplayermodels")
			net.WriteString( "d" )
		net.Send( ply )
		return
	end
	if ply:IsUserGroup("veteran") then
		timer.Simple(1, function() SetMemberModels( ply ) end )
		return
	end
	if ply:IsUserGroup("supporter") then
		timer.Simple(1, function() SetMemberModels( ply ) end )
		return
	end
	if ply:IsUserGroup("member") then
		timer.Simple(1, function() SetMemberModels( ply ) end )
		return
	end
	if ply:IsUserGroup("usera") then
		ply.allowedmodels = SGS.pma
		net.Start("sgs_updateplayermodels")
			net.WriteString( "a" )
		net.Send( ply )
		return
	end
	timer.Simple(1, function() SetMemberModels( ply ) end )
end

function SetMemberModels( ply )
	if not IsValid( ply ) then return end
	if ply:GetLevel("survival") < 10 then
		ply.allowedmodels = SGS.pm1
		net.Start("sgs_updateplayermodels")
			net.WriteString( "1" )
		net.Send( ply )
	elseif ply:GetLevel("survival") >= 10 and ply:GetLevel("survival") < 20 then
		ply.allowedmodels = SGS.pm2
		net.Start("sgs_updateplayermodels")
			net.WriteString( "2" )
		net.Send( ply )
	elseif ply:GetLevel("survival") >= 20 and ply:GetLevel("survival") < 30 then
		ply.allowedmodels = SGS.pm3
		net.Start("sgs_updateplayermodels")
			net.WriteString( "3" )
		net.Send( ply )
	else
		ply.allowedmodels = SGS.pm4
		net.Start("sgs_updateplayermodels")
			net.WriteString( "4" )
		net.Send( ply )
	end
end

function GM:PlayerSpawn( ply )

	if not (ply:GetInitialized() == INITSTATE_OK) then
		GAMEMODE:PlayerSpawnAsSpectator( ply )
	else
		--player_manager.SetPlayerClass( ply, "player_stranded" )

		-- Stop observer mode
		ply:UnSpectate()

		player_manager.OnPlayerSpawn( ply )
		player_manager.RunClass( ply, "Spawn" )

		-- Call item loadout function
		hook.Call( "PlayerLoadout", GAMEMODE, ply )
		-- Set player model
		hook.Call( "PlayerSetModel", GAMEMODE, ply )

		SGS_SetNeeds(ply)

		ply.equippedtool = "NONE"
		ply.spawnloc = ply:GetPos()

		ply:CheckDefaultTools()

		ply.lastuse = CurTime()
		ply:SetHealth(ply:GetMaxHealth())

		ply:SetEyeAngles( Angle(ply:EyeAngles().p, ply:EyeAngles().y, 0) )

		ply.underwater = false
		ply.o2 = ply.maxneeds
		if ply.o2 == nil then ply.o2 = 1000 end
		net.Start("sgs_sendo2")
			net.WriteInt( ply.o2, 32 )
			net.WriteString( "no" )
		net.Send( ply )

		if ply.inpvp then
			ply.lastpvp = CurTime() - 300
		end

		ply:StripWeapon("weapon_fists")

		ply.bleeding = false
		ply.bleedamt = 0
		ply:SendLua("LocalPlayer().bleeding = false")

		ply:SetupHands()
		ply:SetCanZoom(false)

		if ply.brokenleg then
			ply:UnbreakLeg( true )
		end

		ply.has_spawned = true

		ply:SetWalkSpeed( 200 )
		ply:SetRunSpeed( 320 )
		
		if GAMEMODE.Tribes:GetTribeLevel( ply ) >= 6 then
			ply:SetWalkSpeed( 240 )
			ply:SetRunSpeed( 384 )
		end
		
		
		ply.basewalk = ply:GetWalkSpeed()
		ply.baserun = ply:GetRunSpeed()
	end

end

function SGS_PlayerDies( ply, weapon, killer )

	ply.inprocess = false
	ply:Freeze( false )
	SGS_StopTimer( ply )
	ply:AddTool( ply.equippedtool )
	ply.sick = 0
	
	ply:SendLua("LocalPlayer().melonaids = false")
	ply.equippedtool = "NONE"
	SGS_CancelProcess(ply, _, _)
	ply:AddStat( "general5", 1 )

	local killerstring = "NO REFERENCE"
	if killer:IsNPC() then
		local npctable = SGS_ReverseNPCLookup(killer:GetClass())

		if killer.special == "worker" then
			npctable = SGS_ReverseNPCLookup("npc_antlion_w")
		end

		if npctable == nil then npctable = {} end

		local kstring = ""
		if npctable.killstring == nil then
			kstring = killer:GetClass()
		else
			kstring = npctable.killstring
		end
		killerstring = kstring

		for _, v in pairs( player.GetAll() ) do
			v:SendMessage(ply:Nick() .. " was slaughtered by " .. kstring .. ".", 60, Color(255, 0, 100, 255))
		end
		SGS_Log( ply:Nick() .. " was killed by " .. kstring )

		if killer:GetClass() == "npc_antlion" then ply:AddStat( "combat2", 1 ) end
		if killer:GetClass() == "npc_antlionguard" then ply:AddStat( "combat4", 1 ) end
		if killer:GetClass() == "npc_zombie" and killer.bloodmoon_spawned then ply:AddStat( "bloodmoon3", 1 ) end

	end

	if killer:IsPlayer() and not ( killer == ply ) then
		for _, v in pairs( player.GetAll() ) do
			v:SendMessage(ply:Nick() .. " was slaughtered by " .. killer:Nick() .. ".", 60, Color(255, 0, 100, 255))
		end
		killer:AddStat( "combat5", 1 )
		ply:AddStat( "combat6", 1 )

		if ply:SteamID() == "STEAM_0:1:5488513" then
			killer:AddStat( "combat7", 1 )
			killer:CheckForAchievements( "goggleshat" )
		end

		killerstring = killer:Nick()

		SGS_Log( ply:Nick() .. " was killed by " .. killer:Nick() )
	end

	if killer:GetClass() == "worldspawn" then
		if ply.bleeding then
			for _, v in pairs( player.GetAll() ) do
				v:SendMessage(ply:Nick() .. " bled to death.", 60, Color(255, 0, 0, 255))
			end
			SGS_Log( ply:Nick() .. " bled out." )
			ply:AddStat( "bloodmoon4", 1 )
			ply.bleeding = false
			ply.bleedamt = 0
			ply:SendLua("LocalPlayer().bleeding = false")

			killerstring = "Bleeding Out"
		end
	end
	if not ply.killstring then
		ply.killstring = killerstring
	end
	if ply.bleeding then
		ply.bleeding = false
		ply.bleedamt = 0
		ply:SendLua("LocalPlayer().bleeding = false")
	end

end
hook.Add( "PlayerDeath", "SGS_PlayerDies", SGS_PlayerDies )

--[[---------------------------------------------------------
   Name: gamemode:DoPlayerDeath( )
   Desc: Carries out actions when the player dies
-----------------------------------------------------------]]
function GM:DoPlayerDeath( ply, attacker, dmginfo )

	ply:CreateRagdoll()

	ply:AddDeaths( 1 )

end

function GM:PlayerSelectSpawn( ply )

	--[[
	if not (ply:GetInitialized() == INITSTATE_OK) then
		myspawns = ents.FindByClass( "info_teleport_destination" )
		local random_entry = math.random(#myspawns)
		return myspawns[random_entry]
		return false
	end
	]]

    local spawns = ents.FindByClass( "gms_spawnpoint" )
	local myspawns = {}
	if #spawns == 0 then
		myspawns = ents.FindByClass( "info_player_start" )
	else
		for k, v in pairs(spawns) do
			if v.POwner64 == ply:GetPlayerID() then
				if v.on then
					table.insert(myspawns, v)
				end
			end
		end
	end

	if #myspawns == 0 then
		myspawns = ents.FindByClass( "info_player_start" )
	end

    local random_entry = math.random(#myspawns)

    return myspawns[random_entry]

end

function SGS_Spawn( ply, com, args )
	local pid = args[ 1 ]
	local can = true

	local item = SGS_ReverseLookup( pid )

	--[[
	if item.xp == 0 then
		if not ply:GetAch( "betaprogram" ) then
			ply:SendMessage("You must be a part of the beta program to spawn this!", 60, Color(255, 0, 0, 255))
			return
		end
	end
	]]

	for k, v in pairs( item.cost ) do
		local amtInInv = ply.resource[ k ] or 0
		if amtInInv < v then
			can = false
		end
	end
	for k, v in pairs( item.reqlvl ) do
		if ply:GetLevel( k ) < v then
			can = false
		end
	end
	if can then
		if ply.inprocess == true then
			ply:SendMessage("You are already doing something!", 60, Color(255, 0, 0, 255))
			return
		end
		SGS_BuildProp_Start(ply, 2, item)
	end
end
concommand.Add( "SGS_Spawn", SGS_Spawn )

function SGS_ForcePropSpawn( steamid64, pid, pos, ang )

	local item = SGS_ReverseLookup( pid )

	if item == nil then return end

	local ent = ents.Create("gms_prop")
	ent:SetPos( pos )
	ent:SetModel( item.model )
	ent:SetAngles( ang )
	if item.color then
		ent:SetColor( item.color )
	else
		ent:SetColor( Color(255,255,255,255) )
	end
	ent:Spawn()
	ent.spawning = false
	local phys = ent:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false) -- Freezes the object in place.
	end
	ent.uid = item.uid

	--SPP MAKE PLAYER OWNER--
	--ent:CPPISetOwner(ply)
	-------------------------

	return ent
end

function SGS_ForceStructureSpawn( steamid64, pEnt, pos, ang, sharetype )
	local ent = ents.Create(pEnt)
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:SetColor(Color(255,255,255,255))
	ent.ToTime = 0
	ent.POwner = nil
	ent.POwner64 = steamid64
	ent:Spawn()
	ent.spawning = false
	local phys = ent:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false) -- Freezes the object in place.
	end

	--SPP MAKE PLAYER OWNER--
	--ent:CPPISetOwner(ply)
	-------------------------

	return ent
end

function SGS_ReturnRes( ply, uid )

	if uid == nil then return end


	local item = SGS_ReverseLookup( uid )
	for k, v in pairs( item.cost ) do
		if v == 1 then
			if math.random(1,2) == 1 then
				ply:AddResource( k, 1 )
			else
				ply:SendMessage("The prop broke.", 60, Color(255, 0, 0, 255))
			end
		else
			local half = math.floor(v / 2)
			ply:AddResource( k, math.ceil( math.random(half, v) ) )
		end
	end

end


function SGS_ReverseLookup( pEnt )

	for k, v in pairs( SGS.props ) do
		for k2, v2 in pairs( SGS.props[ k ] ) do
			if v2.uid == pEnt then
				return v2
			end
		end
	end

	return nil

end

function SGS_SpawnStructure( ply, com, args )
	local pEnt = args[ 1 ]
	local can = true

	if SGS_CheckUnique( ply, pEnt ) then
		ply:SendMessage("You are only allowed one of these on the map!", 60, Color(255, 0, 0, 255))
		return
	end

	local item = SGS_StructureReverseLookup( pEnt )

	for k, v in pairs( item.cost ) do
		local amtInInv = ply.resource[ k ] or 0
		if amtInInv < v then
			can = false
		end
	end
	for k, v in pairs( item.reqlvl ) do
		if ply:GetLevel( k ) < v then
			can = false
		end
	end
	if can then
		if ply.inprocess == true then
			ply:SendMessage("You are already doing something!", 60, Color(255, 0, 0, 255))
			return
		end
		SGS_BuildStructure_Start(ply, item.spawntime, item)
	end
end
concommand.Add( "SGS_SpawnStructure", SGS_SpawnStructure )

local unique_entities = { "gms_radio" }
function SGS_CheckUnique( ply, ent )
	return false
end

function SGS_SpawnStructurePackaged( ply, com, args )
	local pEnt = args[ 1 ]
	local can = true

	local item = SGS_StructureReverseLookup( pEnt )

	for k, v in pairs( item.cost ) do
		local iinv = ply.resource[ k ] or 0
		if iinv < v then
			can = false
		end
	end
	for k, v in pairs( item.reqlvl ) do
		if ply:GetLevel( k ) < v then
			can = false
		end
	end
	if can then
		if ply.inprocess == true then
			ply:SendMessage("You are already doing something!", 60, Color(255, 0, 0, 255))
			return
		end
		SGS_BuildStructure_Start(ply, item.spawntime, item, true)
	end
end
concommand.Add( "SGS_SpawnStructurePackaged", SGS_SpawnStructurePackaged )

function SGS_StructureReverseLookup( pEnt )

	for k, v in pairs( SGS.structures ) do
		for k2, v2 in pairs( SGS.structures[ k ] ) do
			if v2.ent == pEnt then
				return v2
			end
		end
	end

	return nil

end

local propmovement = { "stargate_sg1", "dhd_sg1", "gms_prop", "prop_vehicle_prisoner_pod", "gms_gardengnome", "gms_incubator", "gms_pethouse", "gms_egg", "gms_gardenblock", "gms_radio", "gms_rcache", "gms_sink", "gms_bed", "gms_pcache", "gms_pcache2", "gms_pcache3", "gms_pcache4", "gms_pcacheboss", "gms_tribecache", "gms_tcache", "gms_ptcache", "gms_stove", "gms_alchlab", "gms_furnace", "gms_workbench", "gms_workbench2", "gms_arcaneforge", "gms_gemtable", "gms_zpgm", "gms_resourcedrop", "gms_sign", "gms_door1", "gms_door2", "gms_door3", "gms_door4", "gms_door5", "gms_doorbeta", "gms_totem_woodcutting", "gms_totem_farming", "gms_totem_fishing", "gms_totem_smithing", "gms_totem_cooking", "gms_totem_combat", "gms_totem_alchemy", "gms_totem_arcane", "gms_totem_mining", "gms_totem_construction", "gms_antlionheadtrophy", "gms_firebrazier", "gms_firelamp", "gms_lamp", "gms_lamp2", "gms_lamp3", "gms_lamp4", "gms_beacon", "gms_beacon2", "gms_beacon3", "gms_beacon4", "gms_walllantern", "gms_aidbench" }
local freezeondrop = { "stargate_sg1", "dhd_sg1", "gms_prop", "prop_vehicle_prisoner_pod", "gms_gardengnome", "gms_incubator", "gms_pethouse", "gms_egg", "gms_gardenblock", "gms_radio", "gms_rcache", "gms_sink", "gms_bed", "gms_pcache", "gms_pcache2", "gms_pcache3", "gms_pcache4", "gms_pcacheboss", "gms_tribecache", "gms_tcache", "gms_ptcache", "gms_stove", "gms_alchlab", "gms_furnace", "gms_workbench", "gms_workbench2", "gms_arcaneforge", "gms_gemtable", "gms_zpgm", "gms_sign", "gms_door1", "gms_door2", "gms_door3", "gms_door4", "gms_door5", "gms_doorbeta", "gms_totem_woodcutting", "gms_totem_farming", "gms_totem_fishing", "gms_totem_smithing", "gms_totem_cooking", "gms_totem_combat", "gms_totem_alchemy", "gms_totem_arcane", "gms_totem_mining", "gms_totem_construction", "gms_antlionheadtrophy", "gms_firebrazier", "gms_firelamp", "gms_lamp", "gms_lamp2", "gms_lamp3", "gms_lamp4", "gms_beacon", "gms_beacon2", "gms_beacon3", "gms_beacon4", "gms_walllantern", "gms_aidbench" }
function SGS_CanPhysgun( ply, ent )
	if ent.destroyed then return false end

	if ply:GetInfoNum('gm_snapgrid', 0) > 100 then
		if ply.logtimer == nil then ply.logtimer = CurTime() - 10 end
		if CurTime() > ply.logtimer + 3 then
			SGS_Log( "** CRASHER REPORT: " .. ply:Nick() .. " attempted to physgun with snapgrid set to " .. tostring(ply:GetInfoNum('gm_snapgrid', 0)) .. "! **" )
			ply.logtimer = CurTime()
		end
		return false
	end

	if table.HasValue( SGS.lockedprops, ent ) then
		return false
	end

	if ent:CPPICanPhysgun(ply) == false then return end

	if SGS.inedit == false then
		for _, v in pairs( SGS.restrictedphysgun ) do
			if ent:GetClass() == v then
				return false
			end
		end
	end

	if ent.enabled then
		if ent:GetClass() == "gms_totem_woodcutting" or ent:GetClass() == "gms_totem_farming" or ent:GetClass() == "gms_totem_fishing" or ent:GetClass() == "gms_totem_smithing" or ent:GetClass() == "gms_totem_cooking" or ent:GetClass() == "gms_totem_combat" or ent:GetClass() == "gms_totem_alchemy" or ent:GetClass() == "gms_totem_arcane" or ent:GetClass() == "gms_totem_mining" or ent:GetClass() == "gms_totem_construction" then
			return false
		end
	end

	if ent:GetClass() == "gms_gardenblock" then
		if ent.locked == nil then
			ent.locked = false
		end
		if ent.locked == true then
			return false
		end
	end

	if ent:IsVehicle() then
		if ent:GetDriver() ~= NULL then
			return false
		end
	end

	ply.isgrab = true

	if table.HasValue( propmovement, ent:GetClass() ) then
		ent:SetSolid( SOLID_NONE )
	end

end
hook.Add("PhysgunPickup", "SGS_CanPhysgun", SGS_CanPhysgun)

function SGS_PropMovementStop( ply, ent)
	local phys = ent:GetPhysicsObject()
	ply.isgrab = false


	if table.HasValue( freezeondrop, ent:GetClass() ) then
		if phys and phys:IsValid() then
			phys:EnableMotion(false) -- Freezes the object in place.
		end
	end
	ent:SetSolid( SOLID_VPHYSICS )
end
hook.Add("PhysgunDrop", "SGS_PropMovementStop", SGS_PropMovementStop)


--MESSAGE FUNCTIONS--
function PlayerMeta:SendMessage(text,duration,color)
	local duration = duration or 3
	local color = color or Color(255,255,255,255)

	net.Start("gms_sendmessage")
		net.WriteString( text )
		net.WriteInt( duration, 32 )
		net.WriteString( color.r..","..color.g..","..color.b..","..color.a )
	net.Send( self )
end

function PlayerMeta:SendXPMessage(text,duration,color)
	local duration = duration or 3
	local color = color or Color(255,255,255,255)

	net.Start("gms_sendxpmessage")
		net.WriteString( text )
		net.WriteInt( duration, 32 )
		net.WriteString( color.r..","..color.g..","..color.b..","..color.a )
	net.Send( self )
end

function SGS_RemoveAResource(res)
	if res.respawn == true then
		local rPos = res:GetPos()
		local rAng = res:GetAngles()
		local rEnt = res:GetClass()

		if res.respawntime == nil then
			res.respawntime = math.random(60, 180)
		end
		timer.Simple(res.respawntime, function() SGS_BuildAResource(rPos, rAng, rEnt) end)
		res:Remove()
	else
		res:Remove()
	end
end

function SGS_BuildAResource( rPos, rAng, rEnt )
	GAMEMODE.Worlds:CheckEmptyWorlds()
	if GAMEMODE.Worlds:GetVectorWorldSpace( rPos ).occupied == false then return end
	local ent = ents.Create( rEnt )
	ent:SetPos( rPos )
	ent:SetAngles( rAng )
	ent:Spawn()
	ent:SetNetworkedString("Owner", "World")
	ent.w_id = GAMEMODE.Worlds:GetVectorWorldSpaceID( rPos )

	if rEnt == "gms_tree" or rEnt == "gms_tree2" or rEnt == "gms_tree3" or rEnt == "gms_tree4" or rEnt == "gms_tree5" or rEnt == "gms_tree6" or rEnt == "gms_tree7" then
		ent.growth = 0.1
		ent:SetModelScale(ent.growth, 0)
		ent.issap = true
	end
end

function PhysgunPickupMapEdit(ply, ent)
	if SGS.inedit == true then
		ent:SetSolid( SOLID_NONE )
	end
end
hook.Add("PhysgunPickup", "PhysgunPickupMapEdit", PhysgunPickupMapEdit)

function PhysgunDropMapEdit(ply, ent)
	if SGS.inedit == true then
		ent:SetSolid( SOLID_VPHYSICS )
	end
end
hook.Add("PhysgunDrop", "PhysgunDropMapEdit", PhysgunDropMapEdit)


function SGS_UseKey( ply, key )
	ply.lastuse = ply.lastuse or CurTime()
	if CurTime() < ply.lastuse + 0.5 then return end

	if key != IN_USE then return end
	if ply:KeyDown(1) then return end

	if !ply.usepress then return end
	if ply.usepress == 1 then return end

	local mattype = "WUT?"
	if ply:CheckMat(300) then
		mattype = ply:CheckMat(300)
	end

	if ply:WaterLevel() >= 1 or ply:CheckWater(140) then
		ply:DrinkWater(300)
		return
	end

	local tr = ply:TraceFromEyes(140)
	if tr.HitWorld then
		if mattype == MAT_DIRT or mattype == MAT_SAND or mattype == MAT_GRASS or mattype == MAT_SNOW then --Checks to see if user presses use on a sand or dirt or grass texture
			for k, v in pairs(ents.FindInSphere( tr.HitPos, 50 )) do
				if v:GetClass() == "gms_wheat" or v:GetClass() == "gms_liferoot" then
					SGS_Harvest_Start(ply, 3, v)
					return
				end
			end
			if ply.foragetoggle then return end
			SGS_Forage_Start(ply, 3, 1)
			ply.lastuse = CurTime()
			return
		else
			ply.lastuse = CurTime()
			return
		end
	else
		if IsValid(tr.Entity) and tr.Entity == SGS.shopent then
			tr.Entity:EmitSound(table.Random(SGS.VortSounds), 60, 100)
			ply:SendLua("SGS_ShopMenu()")
			return
		end
		if IsValid(tr.Entity) and tr.Entity == SGS.shopent2 then
			tr.Entity:EmitSound(table.Random(SGS.BreenSounds), 60, 100)
			ply:SendLua("SGS_ShopMenu2()")
			return
		end
		if IsValid(tr.Entity) and tr.Entity == SGS.xmasnpc then
			tr.Entity:EmitSound(table.Random(SGS.BreenSounds), 60, 100)
			ply:SendLua("SGS_XMasQuestMenu()")
			return
		end
		if IsValid(tr.Entity) and tr.Entity == SGS.shopent3 then
			tr.Entity:EmitSound(table.Random(SGS.KleinerSounds), 60, 100)
			ply:SendLua("SGS_HatShopMenu()")
			return
		end

		if IsValid(tr.Entity) and tr.Entity:GetClass() == "gms_gardenblock" then
			for k, v in pairs(ents.FindInSphere( tr.HitPos, 50 )) do
				if v:GetClass() == "gms_wheat" or v:GetClass() == "gms_liferoot" then
					SGS_Harvest_Start(ply, 3, v)
					return
				end
			end
		end
	end


end
hook.Add("KeyPress","SGS_UseKey", SGS_UseKey)

function PlayerMeta:BottleWater()
	if self:WaterLevel() >= 1 or self:CheckWater(140) then
		SGS_BottleWater_Start( self, 2 )
		return
	else
		self:SendMessage("You must be standing in water to bottle it.", 60, Color(255, 0, 0, 255))
	end
end

function PlayerMeta:DrinkBottleWater()

	if not self.resource[ "bottled_water" ] or self.resource[ "bottled_water" ] <= 0 then
		self:SendMessage("You do not have any water bottles.", 60, Color(255, 0, 0, 255))
		return
	end

	SGS_DrinkBottleWater_Start( self, 1 )
end

function PlayerMeta:DrinkWater( val )
	if self.needs["thirst"] < self.maxneeds and self.needs["thirst"] > (self.maxneeds - val) then
		self.needs["thirst"] = self.maxneeds
	elseif self.needs["thirst"] < (self.maxneeds - val) then
		self.needs["thirst"] = self.needs["thirst"] + val
	end
	self:AddStat( "general1", 1 )
	self:EmitSound(Sound("npc/barnacle/barnacle_gulp"..math.random(1,2)..".wav"), 60, math.random(70, 130))
	self:SendNeeds()
	self.lastuse = CurTime()
end

function PlayerMeta:TraceFromEyes(dist)
	local trace = {}
	trace.start = self:GetShootPos()
	trace.endpos = trace.start + (self:GetAimVector() * dist)
	trace.filter = self

	return util.TraceLine(trace)
end

function PlayerMeta:Sleep(len, bed, heal)
	if not self:Alive() then
		self:SendMessage("One does not sleep whilst one is dead!",3,Color(255,0,0,255))
		return
	end
	SGS_Sleep_Start(self, len, bed, heal)
end


function SGS_ChatSleep( ply, text, public )

  if (string.sub(string.lower(text), 1, 6) == "!sleep") then
		if ply.needs["fatigue"] <= ( math.floor(ply.maxneeds / 2) ) then
			ply:Sleep(10, false, true)
			return false
		else
			ply:SendMessage("You are not tired",3,Color(255,0,0,255))
			return false
		end
  end

end
hook.Add( "PlayerSay", "SGS_ChatSleep", SGS_ChatSleep )

function SGS_ConSleep( ply, com, args )

	if ply.needs["fatigue"] <= ( math.floor( ply.maxneeds / 2 ) ) then
		ply:Sleep(10, false, true)
		return
	else
		ply:SendMessage("You are not tired",3,Color(255,0,0,255))
		return
	end

end
concommand.Add( "sgs_sleep", SGS_ConSleep )

function SGS_ChatSave( ply, text, public )

  if (string.sub(string.lower(text), 1, 5) == "!save") then
    ply:SaveCharacter()
    return false
  end

end
hook.Add( "PlayerSay", "SGS_ChatSave", SGS_ChatSave )

function SGS_ConSave( ply, com, args )

  ply:SaveCharacter()
	return

end
concommand.Add( "sgs_save", SGS_ConSave )

function SGS_ConBottleWater( ply, com, args )

	ply:BottleWater()
	return

end
concommand.Add( "sgs_bottlewater", SGS_ConBottleWater )

function SGS_ConDrinkBottle( ply, com, args )

	ply:DrinkBottleWater()
	return

end
concommand.Add( "sgs_drinkbottle", SGS_ConDrinkBottle )

function SGS_ConTogglePerspective( ply, com, args )

	if ply.perspective == "third" then
		ply:SendLua( "SGS.person = \"first\"" )
		ply.perspective = "first"
		ply:SetSetting( "person", "first" )
		return false
	else
		ply:SendLua( "SGS.person = \"third\"" )
		ply.perspective = "third"
		ply:SetSetting( "person", "third" )
		return false
	end

end
concommand.Add( "sgs_toggleperson", SGS_ConTogglePerspective )

function SGS_ConToggleParticles( ply, com, args )

	if ply.showparticles == true then
		ply:SendLua( "SGS.showparticles = false" )
		ply.showparticles = false
		ply:SetSetting( "showparticles", "false" )
		return false
	else
		ply:SendLua( "SGS.showparticles = true" )
		ply.showparticles = true
		ply:SetSetting( "showparticles", "true" )
		return false
	end

end
concommand.Add( "sgs_toggleparticles", SGS_ConToggleParticles )

function SGS_ConToggleLighting( ply, com, args )

	if ply.showlights == true then
		ply:SendLua( "SGS.showlights = false" )
		ply.showlights = false
		ply:SetSetting( "showlights", "false" )
		return false
	else
		ply:SendLua( "SGS.showlights = true" )
		ply.showlights = true
		ply:SetSetting( "showlights", "true" )
		return false
	end

end
concommand.Add( "sgs_togglelighting", SGS_ConToggleLighting )

function SGS_ConToggleDrawDistance( ply, com, args )

	if ply.showfar == true then
		ply:SendLua( "SGS.drawdistance = 36000000" )
		ply.showfar = false
		ply:SetSetting( "showfar", "false" )
		return false
	else
		ply:SendLua( "SGS.drawdistance = 360000000" )
		ply.showfar = true
		ply:SetSetting( "showfar", "true" )
		return false
	end

end
concommand.Add( "sgs_toggleviewdistance", SGS_ConToggleDrawDistance )

function SGS_ConToggleGrindmode( ply, com, args )

	if ply.grindmode == "on" then
		ply.grindmode = "off"
		ply:SetSetting( "grindmode", "off" )
		ply:SendMessage( "Grinding Mode is now off.",3,Color(0,255,0,255))
		return false
	else
		ply.grindmode = "on"
		ply:SetSetting( "grindmode", "on" )
		ply:SendMessage( "Grinding Mode is now on.",3,Color(0,255,0,255))
		return false
	end

end
concommand.Add( "sgs_togglegrindmode", SGS_ConToggleGrindmode )

function SGS_ConToggleHideFromTeam( ply, com, args )

	if ply.hidefromteam == "on" then
		ply.hidefromteam = "off"
		ply:SetSetting( "hidefromteam", "off" )
		ply:SetNWBool("hidefromteam", false)
		ply:SendMessage( "Showing name tag to teammates while in PVP",3,Color(0,255,0,255))
		return false
	else
		ply.hidefromteam = "on"
		ply:SetSetting( "hidefromteam", "on" )
		ply:SetNWBool("hidefromteam", true)
		ply:SendMessage( "Not showing name tag to teammates while in PVP",3,Color(0,255,0,255))
		return false
	end

end
concommand.Add( "sgs_togglehidefromteam", SGS_ConToggleHideFromTeam )

function PlayerMeta:InGrindMode()
	if self.grindmode == "on" then return true end
	return false
end

function SGS_ConSetTime( ply, com, args )

	if SGS_IsRootAdmin( ply ) then
		DayLight.Minute = tonumber(args[1])
		DayLight:ChangeTime()
		net.Start("sgs_settimeupdate")
			net.WriteInt( tonumber(args[1]), 16 )
		net.Broadcast()
	else
		ply:SendMessage("This is a developer command.",3,Color(255,0,0,255))
	end

end
concommand.Add( "sgs_settime", SGS_ConSetTime )

function PlayerMeta:PlantSeed( sType )

	if ( self.resource[ sType ] or 0 ) >= 1 then
		local mattype = "WUT?"
		if self:CheckMat(300) then mattype = self:CheckMat(300) end
		local tr = self:TraceFromEyes(140)

		if IsValid(tr.Entity) and tr.Entity:GetClass() == "gms_gardenblock" then

			for _, v in pairs( ents.FindInSphere( tr.Entity:LocalToWorld(Vector(0,0,6)), 10 ) )  do
				if v:GetClass() == "gms_treeseed" or v:GetClass() == "gms_seed" or v:GetClass() == "gms_plant" or v:GetClass() == "gms_foodseed" or v:GetClass() == "gms_wheat" or v:GetClass() == "gms_liferoot" then
					self:SendMessage("You cannot plant a seed so close to another plant/seed!",3,Color(255,0,0,255))
					return
				end
			end

			if self.tplants >= self.maxplants then
				self:SendMessage("You are only allowed (" .. self.maxplants .. ") plants at a time.",3,Color(255,0,0,255))
				return
			end

			local angle = tr.Entity:GetAngles()
			if angle.r < -90 or angle.r > 90 then
				self:SendMessage("You can not plant on a farming slab that is upside down.",3,Color(255,0,0,255))
				return
			end

			for _, v in pairs( SGS.Seeds[ "fruit" ] ) do
				if v.resource == sType then
					local ent = ents.Create("gms_seed")
					ent:SetPos( tr.Entity:LocalToWorld(Vector(0,0,6) ) )
					ent.pType = sType
					ent.GrowTime = math.random( v.growtime * 0.8, v.growtime * 1.2 )
					if SGS_DayPhase() == "day" then
						ent.GrowTime = ent.GrowTime * 0.6
					else
						ent.GrowTime = ent.GrowTime * 1.2
					end
					ent.fColor = v.color
					ent.fMaterial = v.material
					ent.fEatHeal = v.eatheal
					ent.lvl = v.lvl
					ent.model = v.model
					ent.owner = self
					ent.oid = self:GetPlayerID()
					ent:Spawn()
					self:AddStat( "farming1", 1 )
					self:CheckForAchievements("farmingmaster")
					tr.Entity.locked = true
					ent.parent = tr.Entity
					--ent:SetParent(ent.parent)
					self.tplants = self.tplants + 1
					self:UpdatePlantCount()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(self)
					-------------------------
					self:SendMessage("Seed planted!",3,Color(0,255,0,255))
					self:SubResource( sType, 1 )
					self:AddExp( "farming", math.ceil( v.experience * 3 ) )
					break
				end
			end

			return

		end

		if tr.HitWorld then
			if mattype == MAT_DIRT or mattype == MAT_SAND or mattype == MAT_GRASS or mattype == MAT_SNOW then --Checks to see if user presses use on a sand or dirt or grass texture
				for _, v in pairs( ents.FindInSphere( tr.HitPos, 50 ) ) do
				if v:GetClass() == "gms_treeseed" or v:GetClass() == "gms_seed" or v:GetClass() == "gms_plant" or v:GetClass() == "gms_foodseed" or v:GetClass() == "gms_wheat" or v:GetClass() == "gms_liferoot" then
						self:SendMessage("You cannot plant a seed so close to another plant/seed!",3,Color(255,0,0,255))
						return
					end
				end
				if self.tplants >= self.maxplants then
					self:SendMessage("You are only allowed (" .. self.maxplants .. ") plants at a time.",3,Color(255,0,0,255))
					return
				end
				for _, v in pairs( SGS.Seeds[ "fruit" ] ) do
					if v.resource == sType then
						local ent = ents.Create("gms_seed")
						ent:SetPos( self:TraceFromEyes(140).HitPos )
						ent.pType = sType
						ent.GrowTime = math.random( v.growtime * 0.8, v.growtime * 1.2 )
						if SGS_DayPhase() == "day" then
							ent.GrowTime = ent.GrowTime * 0.6
						else
							ent.GrowTime = ent.GrowTime * 1.2
						end
						ent.fColor = v.color
						ent.fMaterial = v.material
						ent.fEatHeal = v.eatheal
						ent.lvl = v.lvl
						ent.model = v.model
						ent.owner = self
						ent.oid = self:GetPlayerID()
						ent:Spawn()
						self:AddStat( "farming1", 1 )
						self:CheckForAchievements("farmingmaster")
						ent.parent = worldspawn
						self.tplants = self.tplants + 1
						self:UpdatePlantCount()
						--SPP MAKE PLAYER OWNER--
						ent:CPPISetOwner(self)
						-------------------------
						self:SendMessage("Seed planted!",3,Color(0,255,0,255))
						self:SubResource( sType, 1 )
						self:AddExp( "farming", math.ceil( v.experience * 3 ) )
						break
					end
				end
			else
				self:SendMessage("You can not plant a seed on this type of surface!",3,Color(255,0,0,255))
			end
		else
			self:SendMessage("You must be pointing at the ground to plant a seed!",3,Color(255,0,0,255))
		end
	else
		self:SendMessage("You do not currently have any seeds of that type!",3,Color(255,0,0,255))
	end


end

function SGS_ConCommandPlant( ply, com, args )

	local sType = args[ 1 ]

	for _, v in pairs( SGS.Seeds[ "fruit" ] ) do
		if sType == v.resource then
			if v.reqlvl["farming"] > ply:GetLevel("farming")then
				ply:SendMessage("This seed requires a farming level of " .. v.reqlvl["farming"] .. " or better.",3,Color(255,0,0,255))
				return
			end
			ply:PlantSeed( sType )
			ply:ConCommand("sgs_refreshfarming")
			return
		end
	end
	ply:SendMessage("Something went wrong! This seed is not valid.",3,Color(255,0,0,255))

end
concommand.Add( "SGS_Plant", SGS_ConCommandPlant )

function PlayerMeta:PlantTreeSeed( sType )

	if ( self.resource[ sType ] or 0 ) >= 1 then
		local mattype = "WUT?"
		if self:CheckMat(300) then mattype = self:CheckMat(300)	end
		local tr = self:TraceFromEyes(140)
		if tr.HitWorld then
			if mattype == MAT_DIRT or mattype == MAT_SAND or mattype == MAT_GRASS or mattype == MAT_SNOW then --Checks to see if user presses use on a sand or dirt or grass texture
				for _, v in pairs( ents.FindInSphere( tr.HitPos, 100 ) ) do
				if v:GetClass() == "gms_treeseed" or v:GetClass() == "gms_seed" or v:GetClass() == "gms_plant" or v:GetClass() == "gms_foodseed" or v:GetClass() == "gms_wheat" or v:GetClass() == "gms_liferoot" then
						self:SendMessage("You cannot plant a tree so close to another!",3,Color(255,0,0,255))
						return
					end
				end

				if self.tplants >= self.maxplants then
					self:SendMessage("You are only allowed (" .. self.maxplants .. ") plants at a time.",3,Color(255,0,0,255))
					return
				end

				for _, v in pairs( SGS.Seeds[ "trees" ] ) do
					if v.resource == sType then
						local ent = ents.Create("gms_treeseed")
						ent:SetPos( self:TraceFromEyes(140).HitPos )
						ent.pType = sType
						ent.GrowTime = math.random( v.growtime * 0.8, v.growtime * 1.2 )
						if SGS_DayPhase() == "day" then
							ent.GrowTime = ent.GrowTime * 0.6
						else
							ent.GrowTime = ent.GrowTime * 1.2
						end
						ent.lvl = v.lvl
						ent.owner = self
						ent.oid = self:GetPlayerID()
						ent.ownerStr = self:Nick()
						ent.tree = v.entity
						ent:Spawn()
						self:AddStat( "farming1", 1 )
						self:CheckForAchievements("farmingmaster")
						self.tplants = self.tplants + 1
						self:UpdatePlantCount()
						--SPP MAKE PLAYER OWNER--
						ent:CPPISetOwner(self)
						-------------------------
						self:SendMessage("Tree Planted!",3,Color(0,255,0,255))
						self:SubResource( sType, 1 )
						self:AddExp( "farming", math.ceil( v.experience * 3 ) )
						break
					end
				end
			else
				self:SendMessage("You can not plant a seed on this type of surface!",3,Color(255,0,0,255))
			end
		else
			self:SendMessage("you must be pointing at the ground to plant a seed!",3,Color(255,0,0,255))
		end
	else
		self:SendMessage("You do not currently have any seeds of that type!",3,Color(255,0,0,255))
	end


end

function SGS_ConCommandPlantTree( ply, com, args )

	local sType = args[ 1 ]

	for _, v in pairs( SGS.Seeds[ "trees" ] ) do
		if sType == v.resource then
			if v.reqlvl["farming"] > ply:GetLevel("farming")then
				ply:SendMessage("This seed requires a farming level of " .. v.reqlvl["farming"] .. " or better.",3,Color(255,0,0,255))
				return
			end
			ply:PlantTreeSeed( sType )
			ply:ConCommand("sgs_refreshfarming")
			return
		end
	end
	ply:SendMessage("Something went wrong! This seed is not valid.",3,Color(255,0,0,255))

end
concommand.Add( "sgs_planttree", SGS_ConCommandPlantTree )


function PlayerMeta:PlantFoodSeed( sType )

	if ( self.resource[ sType ] or 0 ) >= 1 then
		local mattype = "WUT?"
		if self:CheckMat(300) then mattype = self:CheckMat(300)	end
		local tr = self:TraceFromEyes(140)

		if IsValid(tr.Entity) and tr.Entity:GetClass() == "gms_gardenblock" then

			for _, v in pairs( ents.FindInSphere( tr.Entity:LocalToWorld(Vector(0,0,6)), 10 ) )  do
				if v:GetClass() == "gms_treeseed" or v:GetClass() == "gms_seed" or v:GetClass() == "gms_plant" or v:GetClass() == "gms_foodseed" or v:GetClass() == "gms_wheat" or v:GetClass() == "gms_liferoot" then
					self:SendMessage("You cannot plant a seed so close to another plant/seed!",3,Color(255,0,0,255))
					return
				end
			end

			if self.tplants >= self.maxplants then
				self:SendMessage("You are only allowed (" .. self.maxplants .. ") plants at a time.",3,Color(255,0,0,255))
				return
			end

			local angle = tr.Entity:GetAngles()
			if angle.r < -90 or angle.r > 90 then
				self:SendMessage("You can not plant on a farming slab that is upside down.",3,Color(255,0,0,255))
				return
			end

			for _, v in pairs( SGS.Seeds[ "food" ] ) do
				if v.resource == sType then
					local ent = ents.Create("gms_foodseed")
					ent:SetPos( tr.Entity:LocalToWorld(Vector(0,0,6) ) )
					ent.pType = sType
					ent.GrowTime = math.random( v.growtime * 0.8, v.growtime * 1.2 )
					if SGS_DayPhase() == "day" then
						ent.GrowTime = ent.GrowTime * 0.6
					else
						ent.GrowTime = ent.GrowTime * 1.2
					end
					ent.owner = self
					ent.oid = self:GetPlayerID()
					ent.entity = v.entity
					ent.harvest = v.harvest
					ent.seed = v.resource
					ent:Spawn()
					self:AddStat( "farming1", 1 )
					self:CheckForAchievements("farmingmaster")
					tr.Entity.locked = true
					ent.parent = tr.Entity
					--ent:SetParent(ent.parent)
					self.tplants = self.tplants + 1
					self:UpdatePlantCount()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(self)
					-------------------------
					self:SendMessage("Seed planted!",3,Color(0,255,0,255))
					self:SubResource( sType, 1 )
					self:AddExp( "farming", math.ceil( v.experience * 3 ) )
					break
				end
			end
			for _, v in pairs( SGS.Seeds[ "alchemy" ] ) do
				if v.resource == sType then
					local ent = ents.Create("gms_foodseed")
					ent:SetPos( tr.Entity:LocalToWorld(Vector(0,0,6) ) )
					ent.pType = sType
					ent.GrowTime = math.random( v.growtime * 0.8, v.growtime * 1.2 )
					if SGS_DayPhase() == "day" then
						ent.GrowTime = ent.GrowTime * 0.6
					else
						ent.GrowTime = ent.GrowTime * 1.2
					end
					ent.owner = self
					ent.oid = self:GetPlayerID()
					ent.entity = v.entity
					ent.harvest = v.harvest
					ent.seed = v.resource
					ent:Spawn()
					self:AddStat( "farming1", 1 )
					self:CheckForAchievements("farmingmaster")
					tr.Entity.locked = true
					ent.parent = tr.Entity
					--ent:SetParent(ent.parent)
					self.tplants = self.tplants + 1
					self:UpdatePlantCount()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(self)
					-------------------------
					self:SendMessage("Seed Planted!",3,Color(0,255,0,255))
					self:SubResource( sType, 1 )
					self:AddExp( "farming", math.ceil( v.experience * 3 ) )
					break
				end
			end

			return

		end

		if tr.HitWorld then
			if mattype == MAT_DIRT or mattype == MAT_SAND or mattype == MAT_GRASS or mattype == MAT_SNOW then --Checks to see if user presses use on a sand or dirt or grass texture
				for _, v in pairs( ents.FindInSphere( tr.HitPos, 50 ) ) do
				if v:GetClass() == "gms_treeseed" or v:GetClass() == "gms_seed" or v:GetClass() == "gms_plant" or v:GetClass() == "gms_foodseed" or v:GetClass() == "gms_wheat" or v:GetClass() == "gms_liferoot" then
						self:SendMessage("You cannot plant so close to another seed!",3,Color(255,0,0,255))
						return
					end
				end
				if self.tplants >= self.maxplants then
					self:SendMessage("You are only allowed (" .. self.maxplants .. ") plants at a time.",3,Color(255,0,0,255))
					return
				end
				for _, v in pairs( SGS.Seeds[ "food" ] ) do
					if v.resource == sType then
						local ent = ents.Create("gms_foodseed")
						ent:SetPos( self:TraceFromEyes(140).HitPos )
						ent.pType = sType
						ent.GrowTime = math.random( v.growtime * 0.8, v.growtime * 1.2 )
						if SGS_DayPhase() == "day" then
							ent.GrowTime = ent.GrowTime * 0.6
						else
							ent.GrowTime = ent.GrowTime * 1.2
						end
						ent.owner = self
						ent.oid = self:GetPlayerID()
						ent.entity = v.entity
						ent.harvest = v.harvest
						ent.seed = v.resource
						ent:Spawn()
						self:AddStat( "farming1", 1 )
						self:CheckForAchievements("farmingmaster")
						ent.parent = worldspawn
						--ent:SetParent(ent.parent)
						self.tplants = self.tplants + 1
						self:UpdatePlantCount()
						--SPP MAKE PLAYER OWNER--
						ent:CPPISetOwner(self)
						-------------------------
						self:SendMessage("Seed Planted!",3,Color(0,255,0,255))
						self:SubResource( sType, 1 )
						self:AddExp( "farming", math.ceil( v.experience * 3 ) )
						break
					end
				end
				for _, v in pairs( SGS.Seeds[ "alchemy" ] ) do
					if v.resource == sType then
						local ent = ents.Create("gms_foodseed")
						ent:SetPos( self:TraceFromEyes(140).HitPos )
						ent.pType = sType
						ent.GrowTime = math.random( v.growtime * 0.8, v.growtime * 1.2 )
						if SGS_DayPhase() == "day" then
							ent.GrowTime = ent.GrowTime * 0.6
						else
							ent.GrowTime = ent.GrowTime * 1.2
						end
						ent.owner = self
						ent.oid = self:GetPlayerID()
						ent.entity = v.entity
						ent.harvest = v.harvest
						ent.seed = v.resource
						ent:Spawn()
						self:AddStat( "farming1", 1 )
						self:CheckForAchievements("farmingmaster")
						ent.parent = worldspawn
						--ent:SetParent(ent.parent)
						self.tplants = self.tplants + 1
						self:UpdatePlantCount()
						--SPP MAKE PLAYER OWNER--
						ent:CPPISetOwner(self)
						-------------------------
						self:SendMessage("Seed Planted!",3,Color(0,255,0,255))
						self:SubResource( sType, 1 )
						self:AddExp( "farming", math.ceil( v.experience * 3 ) )
						break
					end
				end
			else
				self:SendMessage("You can not plant a seed on this type of surface!",3,Color(255,0,0,255))
			end
		else
			self:SendMessage("You must be pointing at the ground to plant a seed!",3,Color(255,0,0,255))
		end
	else
		self:SendMessage("You do not currently have any seeds of that type!",3,Color(255,0,0,255))
	end


end


function SGS_ConCommandPlantFood( ply, com, args )

	local sType = args[ 1 ]

	for _, v in pairs( SGS.Seeds[ "food" ] ) do
		if sType == v.resource then
			if v.reqlvl["farming"] > ply:GetLevel("farming")then
				ply:SendMessage("This seed requires a farming level of " .. v.reqlvl["farming"] .. " or better.",3,Color(255,0,0,255))
				return
			end
			ply:PlantFoodSeed( sType )
			ply:ConCommand("sgs_refreshfarming")
			return
		end
	end
	for _, v in pairs( SGS.Seeds[ "alchemy" ] ) do
		if sType == v.resource then
			if v.reqlvl["farming"] > ply:GetLevel("farming")then
				ply:SendMessage("This seed requires a farming level of " .. v.reqlvl["farming"] .. " or better.",3,Color(255,0,0,255))
				return
			end
			ply:PlantFoodSeed( sType )
			ply:ConCommand("sgs_refreshfarming")
			return
		end
	end
	ply:SendMessage("Something went wrong! This seed is not valid.",3,Color(255,0,0,255))

end
concommand.Add( "sgs_plantfood", SGS_ConCommandPlantFood )


function PlayerMeta:EatFruit( lvl, size )

	SGS_EatFruit_Start(self, 1.5, lvl, size)

end

function PlayerMeta:Eat( food )

	if food.sname == "relic" then
		SGS_ConsumeRelic(self, food)
	elseif food.sname == "artifact" then
		SGS_ConsumeArtifact(self, food)
	elseif food.sname == "easteregg" then
		SGS_OpenEasterEgg(self)
	else
		SGS_Eat_Start(self, 2, food)
	end

end

function SGS_OpenVoidCache( ply, com, args )

	SGS_OpenVoidCache(ply)

end
concommand.Add( "sgs_openvoidcache", SGS_OpenVoidCache )

function SGS_OpenVoidCache( ply )
	if ply:GetResource("void_cache") <= 0 then
		ply:SendMessage("You don't have any Void Caches.",3,Color(255,0,0,255))
		return
	end
	if ply:GetResource("void_crystal") <= 0 then
		ply:SendMessage("To open this Void Cache, you need a Void Crystal from Vorty.",3,Color(255,0,0,255))
		return
	end

	local chance = math.random(1,100)
	ply:SendMessage("Opening Void Cache...",3,Color(255,0,0,255))
	ply:AddStat( "general18", 1 )
	ply:CheckForAchievements( "voidcache2" )
	for _, v in pairs( player.GetAll() ) do
		if v != ply then
			v:SendMessage( ply:Nick() .. " is opening a Void Cache.", 60, Color(0, 255, 255, 255))
		end
	end
	ply:SubResource( "void_cache", 1 )
	ply:SubResource( "void_crystal", 1 )
	SGS_AwardVoidTier( ply, chance )

end

function SGS_AwardVoidTier( ply, tier )
	if tier <= 5 then  -- Most valuable drops
		local tt = math.random(12)
		if tt <= 4 then
			ply:AddResource( "void_hatchet_head", 1 )
		elseif tt > 4 and tt <= 8 then
			ply:AddResource( "void_pickaxe_head", 1 )
		elseif tt > 8 and tt <= 10 then
			ply:AddResource( "void_fishing_reel", 1 )
		elseif tt > 10 and tt <= 12 then
			ply:AddResource( "void_hoe_blade", 1 )
		end
		return
	elseif tier > 5 and tier <= 15 then  --Achievement Hat
		if not ply:GetAch("robotbuddy") then
			ply:SetAch("robotbuddy")
		else
			SGS_AwardVoidTier( ply, math.random(20,100) )
		end
	elseif tier > 15 and tier <= 30 then
		local m = math.random(4)
		if m == 1 then
			ply:GiveGTokens(1000)
		elseif m == 2 then
			ply:AddResource( "pink_pet_egg", 1 )
		elseif m == 3 then
			ply:AddResource( "enchanted_wood", 1 )
		elseif m == 4 then
			ply:AddResource( "enchanted_metal", 1 )
		end
	elseif tier > 30 and tier <= 40 then
		local m = math.random(5)
		if m == 1 then
			ply:GiveGTokens(math.random(100, 500))
		elseif m == 2 then
			ply:AddResource( "red_pet_egg", math.random(1,2) )
		elseif m == 3 then
			ply:AddResource( "diamond", math.random(1,5) )
		elseif m == 4 then
			ply:AddResource( "unidentified_artifact", math.random(2,10) )
		elseif m == 5 then
			ply:AddResource( "inert_stone", math.random(10, 100) )
		end
	elseif tier > 40 and tier <= 50 then
		local m = math.random(5)
		if m == 1 then
			ply:GiveGTokens(math.random(50, 100))
		elseif m == 2 then
			local t = { "white", "yellow", "black", "orange", "green", "blue", "brown", "gray" }
			local s = t[math.random(#t)] .. "_pet_egg"
			ply:AddResource( s, 1 )
		elseif m == 3 then
			ply:AddResource( "ruby", math.random(1,5) )
		elseif m == 4 then
			local s = SGS.skills[math.random(#SGS.skills)] .. "_relic_2"
			ply:AddResource( s, math.random(1,3) )
		elseif m == 5 then
			local t = { "chaos", "nature", "cosmic" }
			local s = t[math.random(#t)] .. "_stone"
			ply:AddResource( s, math.random(1,10) )
		end
	elseif tier > 50 and tier <= 60 then
		local m = math.random(5)
		if m == 1 then
			ply:GiveGTokens(math.random(10, 50))
		elseif m == 2 then
			ply:AddResource( "sapphire", math.random(3) )
		elseif m == 3 then
			ply:AddResource( "emerald", math.random(3) )
		elseif m == 4 then
			local s = SGS.skills[math.random(#SGS.skills)] .. "_relic_1"
			ply:AddResource( s, math.random(3) )
		elseif m == 5 then
			local t = { "wind", "water", "earth", "fire" }
			local s = t[math.random(#t)] .. "_stone"
			ply:AddResource( s, math.random(10) )
		end
	elseif tier > 60 and tier <= 70 then
		ply:AddResource("hat_token", 1)
	elseif tier > 70 and tier <= 80 then
		ply:AddResource("cooked_shark", math.random(10))
	elseif tier > 80 and tier <= 95 then
		ply:AddResource( SGS.AllowedPackage[math.random(#SGS.AllowedPackage)], 1 )
	elseif tier > 95 then
		ply:SendMessage("The cache was empty. Sorry.",3,Color(255,0,0,255))
	end
end

function PlayerMeta:DrinkPotion( potion )

	SGS_DrinkPotion_Start(self, 2, potion)

end

function SGS_ConsumeRelic(ply, food)

	if ply.level[food.skill] >= 50 then
		ply:SendMessage("Relics can only be used on skills lower than level 50.",3,Color(255,0,0,255))
		return
	end

	ply:SendMessage("You consumed a " ..CapAll(string.gsub(food.name, "_", " ")) .."!",3,Color(0,255,0,255))
	ply:AddExp(food.skill, food.xp)
	ply:SubResource( food.name, 1 )
	ply:AddStat( "general11", 1 )

end

function SGS_ConsumeArtifact(ply, food)

	if ply.level[food.skill] < 50 then
		ply:SendMessage("Artifacts can only be used on skills level 50 and higher.",3,Color(255,0,0,255))
		return
	end

	if ply.level[food.skill] >= SGS.maxlevel then
		ply:SendMessage("Why would you eat an artifact at max level?",3,Color(255,0,0,255))
		return
	end


	ply:SendMessage("You consumed a " ..CapAll(string.gsub(food.name, "_", " ")) .."!",3,Color(0,255,0,255))
	ply:AddExp(food.skill, food.xp)
	ply:SubResource( food.name, 1 )
	ply:AddStat( "general12", 1 )

end

function PlayerMeta:CheckForGem( multi )
	self:CheckForStone()

	if math.random(1,200) > multi then return end

	local gtype = math.random(1,10)
	local gem = "none"
	if gtype <= 4 then
		gem = "sapphire"
		xpm = 1
	elseif gtype > 4 and gtype <= 7 then
		gem = "emerald"
		xpm = 2
	elseif gtype > 7 and gtype <= 9 then
		gem = "ruby"
		xpm = 3
	elseif gtype == 10 then
		gem = "diamond"
		xpm = 4
	end

	self:SendMessage("You found a " ..Cap(gem).. "!", 60, Color(0, 255, 0, 255))
	self:AddExp( "mining", 100 * xpm )
	self:AddResource( gem, 1 )
	self:AddStat( "mining8", 1 )
	self:CheckForAchievements( "mininghat" )


end

function PlayerMeta:CheckForStone( always )
	local chance = 35
	if always then chance = 1 end
	if math.random( 1, chance ) == 1 then
		self:SendMessage("You found an inert stone!", 60, Color(0, 255, 0, 255))
		if always then
			self:AddResource( "inert_stone", math.random(7,12) )
		else
			self:AddResource( "inert_stone", math.random(1,3) )
		end
	end
end


function PlayerMeta:LevelUpEffect(skill)

	local ent = ents.Create("gms_levelup")
		ent.self = self
		ent.ply = self
		ent.skillcolor = SGS.colors[skill]
		ent:SetPos(self:GetPos())
		ent:Spawn()
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(self)
		-------------------------
		ent:Activate()

end

function PlayerMeta:LevelUpSurvivalEffect()

	local ent = ents.Create("gms_levelupsurvival")
		ent.self = self
		ent.ply = self
		ent:SetPos(self:GetPos())
		ent:Spawn()
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(self)
		-------------------------
		ent:Activate()

end

function PlayerMeta:ShowOffSkill(skill)


	if IsValid( self.sskillent ) then
		self.sskillent:Remove()
	end

	local ent = ents.Create("gms_mldisplay")
		ent.self = self
		ent.ply = self
		ent.skillcolor = SGS.colors[skill]
		ent:SetColor(SGS.colors[skill])
		ent:SetPos(self:GetPos() + Vector(0,0,70))
		ent:Spawn()
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(self)
		-------------------------
		ent:Activate()

	self.sskillent = ent

end

function PlayerMeta:ShowOffSkillAll()

	if IsValid( self.sskillent ) then
		self.sskillent:Remove()
	end

	local ent = ents.Create("gms_mldisplayall")
		ent.self = self
		ent.ply = self
		ent.skillcolor = Color(255,255,255,255)
		ent:SetColor(Color(255,255,255,255))
		ent:SetPos(self:GetPos() + Vector(0,0,70))
		ent:Spawn()
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(self)
		-------------------------
		ent:Activate()

	self.sskillent = ent

end

function PlayerMeta:ElixirEffect(skill)

	if IsValid( self.elixent ) then
		self.elixent:Remove()
	end
	if IsValid( self.trail1 ) then
		self.trail1:Remove()
	end
	if IsValid( self.trail2 ) then
		self.trail2:Remove()
	end

	if skill == "speed" then
		self.trail1 = util.SpriteTrail(self, 7, Color(255,255,255,255), false, 5, 1, 1, 1/(15+1)*0.5, "trails/smoke.vmt")
		self.trail2 = util.SpriteTrail(self, 6, Color(255,255,255,255), false, 5, 1, 1, 1/(15+1)*0.5, "trails/smoke.vmt")
	elseif skill == "waterbreathing" then
	elseif skill == "gravity" then
	elseif skill == "luck" then
	else
		local ent = ents.Create("gms_elixorb")
			ent.self = self
			ent.ply = self
			if skill == "all" then
				ent.skillcolor = Color(255,255,255,255)
				ent.flash = true
			else
				ent.skillcolor = SGS.colors[statboost]
				ent.flash = false
			end
			ent:SetColor(SGS.colors[skill])
			ent:SetPos(self:GetPos() + Vector(0,0,12))
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(self)
			-------------------------
			ent:Activate()

		self.elixent = ent
	end

end

function PlayerMeta:Heal( amt )

	if self:Health() + amt <= self:GetMaxHealth() then
		self:SetHealth(self:Health() + amt)
	else
		self:SetHealth(self:GetMaxHealth())
		if self.bleeding then
			self.bleedamt = 0
			self.bleeding = false
			self:SendMessage("The bleeding has stopped.", 60, Color(255, 255, 0, 255))
			self:SendLua("LocalPlayer().bleeding = false")
		end
	end

end

function Cap(str)
	local len = string.len(str)
	local fl = string.Left(str, 1)
	local fr = string.Right(str, len - 1)
	return string.upper(fl) .. fr
end

function CapAll(str)
	estr = string.Explode( " ", str )
	for k, v in ipairs( estr ) do
		local len = string.len(estr[k])
		local fl = string.Left(estr[k], 1)
		local fr = ""
		if len > 1 then
			fr = string.Right(estr[k], len - 1)
		end
		estr[k] = string.upper(fl) .. fr
	end
	return string.Implode( " ", estr )
end


function PlayerMeta:CheckWater(dis)

	local trace = {}
	trace.start = self:GetShootPos()
	trace.endpos = trace.start + (self:GetAimVector() * dis)
	trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
	trace.filter = self

	local tr = util.TraceLine(trace)
	if !tr.Hit then return false end
	if tr.MatType ~= MAT_SLOSH then return false end

	return true

end

function PlayerMeta:CheckMat(dis)

	local trace = {}
	trace.start = self:GetShootPos()
	trace.endpos = trace.start + (self:GetAimVector() * dis)
	trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
	trace.filter = self

	local tr = util.TraceLine(trace)
	if !tr.Hit then return false end

	return tr.MatType

end

function SGS_ConEat( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments. The correct command is: 'sgs_eat <food>'.", 60, Color(0, 255, 0, 255))
			return
		end

		if not ply.resource[ args[1] ] or ply.resource[ args[1] ] <= 0 then
			ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
			return
		end
		--[[
		if ply.resource[ args[1] ] <= 0 then
			ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
			return
		end
    ]]

		if SGS_ReverseFoodLookup( args[1] ) then
			local food = SGS_ReverseFoodLookup( args[1] )
			ply:Eat( food )
		end


end
concommand.Add( "sgs_eat", SGS_ConEat )

function SGS_ConDrink( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments. The correct command is: 'sgs_pdrink <potion>'.", 60, Color(0, 255, 0, 255))
			return
		end

		if not ply.resource[ args[1] ] then
			ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
			return
		end

		if ply.resource[ args[1] ] <= 0 then
			ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
			return
		end

		if SGS_ReversePotionLookup( args[1] ) then
			local potion = SGS_ReversePotionLookup( args[1] )
			ply:DrinkPotion( potion )
		end


end
concommand.Add( "sgs_pdrink", SGS_ConDrink )

function SGS_ReversePotionLookup( tEnt )

	for k, v in pairs( SGS.Brewing ) do
		for k2, v2 in pairs( SGS.Brewing[k] ) do
			if v2.mname == tEnt then
				return v2
			end
		end
	end

	return nil

end

function SGS_ConCook( ply, com, args )

	if #args > 1 then
		ply:SendMessage("Too many arguments.", 60, Color(0, 255, 0, 255))
		return
	end

	if not SGS_ReverseFoodLookup( args[1] ) then
		ply:SendMessage("Invalid food item!", 60, Color(0, 255, 0, 255))
		return
	end

	ply:Cook( SGS_ReverseFoodLookup( args[1] ) )


end
concommand.Add( "sgs_cook", SGS_ConCook )

function PlayerMeta:Cook( food )

	local can = true
	local modi = 1

	for k, v in pairs( food.cost ) do
		local iinv = self.resource[ k ] or 0
		if iinv < v then
			can = false
			self:SendMessage("You do not have the required resources.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	for k, v in pairs( food.reqlvl ) do
		if self:GetLevel( k ) < v then
			can = false
			self:SendMessage("You do not have the required level.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	local trace = self:TraceFromEyes(100)
	if not IsValid(trace.Entity) then
		self:SendMessage("You need to be at a stove to cook!", 60, Color(255, 0, 0, 255))
		return
	end
	local stove = trace.Entity

	if(SPropProtection.PlayerUse(self, stove) == false) then return end

	if can then
		if stove:GetClass() == "gms_stove" then
			if stove.pans < 6 then
				local slot = 0

				for i=1, 6 do
					if not stove.pArray[i] then
						slot = i
						break
					end
				end
				if slot == 0 then return end

				local pan = ents.Create("gms_pan")
				pan:SetPos(stove:LocalToWorld(SGS.PanVectors[slot].pos))
				pan:SetAngles( stove:GetAngles() + Angle(0, SGS.PanVectors[slot].yaw, 0) )
				pan:Spawn()
				pan:CPPISetOwner(self)
				pan.owner = self

				pan:SetParent( stove )

				pan.parentent = stove
				pan.slot = slot

				stove.pans = stove.pans + 1
				stove.pArray[slot] = true

				pan.food = food
				pan.endtime = math.random( math.Clamp( food.reqlvl["cooking"], 10, 45 ) - 2, math.Clamp( food.reqlvl["cooking"], 10, 45 ) + 2 )
				pan.burntime = 6 - (food.reqlvl["cooking"] / 20)

				if IsValid(self:GetActiveWeapon()) and self:GetActiveWeapon():GetClass() == "gms_fryingpan" then
					pan.endtime = pan.endtime / 2
					pan.burntime = pan.burntime * 1.5
				end

				for k, v in pairs( food.cost ) do
					self:SubResource( k, v )
				end
			else
				self:SendMessage("Stove is full.", 60, Color(255, 0, 0, 255))
			end
		elseif stove:GetClass() == "gms_campfire" then
			self:SendMessage("You can only cook at a stove.", 60, Color(255, 0, 0, 255))
		end
	end

end

function SGS_ReverseFoodLookup( tEnt )

	for k, v in pairs( SGS.Food ) do
		for k2, v2 in pairs( SGS.Food[k] ) do
			if v2.name == tEnt then
				return v2
			end
		end
	end

	return nil

end


function SGS_ConBuy( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(0, 255, 0, 255))
			return
		end

		if not SGS_ReverseShopLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(0, 255, 0, 255))
			return
		end

        ply:Buy( SGS_ReverseShopLookup( args[1] ) )


end
concommand.Add( "sgs_buy", SGS_ConBuy )

function PlayerMeta:Buy( item )

	local can = true
	local cost = item.cost
	if GAMEMODE.Tribes:GetTribeLevel( self ) >= 10 then
		cost = math.ceil(cost * 0.9)
	end
	if self:GTokens() < cost then
		can = false
		self:SendMessage("You do not have enough GTokens.", 60, Color(255, 0, 0, 255))
		return
	end

	if can then
		self:RemoveGToken( cost )
		self:AddStat( "general14", cost )

		for k, v in pairs(item.gives) do
			self:AddResource( k, v )
		end
	end

end

function SGS_ReverseShopLookup( tEnt )

	for k, v in pairs( SGS.Shop ) do
		for k2, v2 in pairs( SGS.Shop[k] ) do
			if v2.uid == tEnt then
				return v2
			end
		end
	end

	return nil

end

function SGS_ConBuy2( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(0, 255, 0, 255))
			return
		end

		if not SGS_ReverseShopLookup2( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(0, 255, 0, 255))
			return
		end

        ply:Buy2( SGS_ReverseShopLookup2( args[1] ) )


end
concommand.Add( "sgs_buy2", SGS_ConBuy2 )

function PlayerMeta:Buy2( item )

	local can = true

	if (self.resource[ "candy_cane" ] or 0) < item.cost then
		can = false
		self:SendMessage("You do not have enough Candy Canes.", 60, Color(255, 0, 0, 255))
		return
	end

	if can then
		self:SubResource( "candy_cane", item.cost )

		for k, v in pairs(item.gives) do
			self:AddResource( k, v )
		end
	end

end

function SGS_ReverseShopLookup2( tEnt )

	for k, v in pairs( SGS.SpecialShop ) do
		for k2, v2 in pairs( SGS.SpecialShop[k] ) do
			if v2.uid == tEnt then
				return v2
			end
		end
	end

	return nil

end

function SGS_ConBurnToggle( ply, com, args )

		if ply.burntoggle == true then
			ply.burntoggle = false
			ply:SendMessage("You will no longer purposefully overcook food.", 60, Color(255, 255, 128, 255))
		else
			ply.burntoggle = true
			ply:SendMessage("You will now purposefully overcook food.", 60, Color(255, 255, 128, 255))
		end

end
concommand.Add( "sgs_burncheck", SGS_ConBurnToggle )

function SGS_ChatBurnToggle( ply, text, public )

    if (string.sub(string.lower(text), 1, 11) == "!burntoggle") then
		SGS_ConBurnToggle(ply, _, _)
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatBurnToggle", SGS_ChatBurnToggle)




function SGS_ConSmelt( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(0, 255, 0, 255))
			return
		end

		if not SGS_ReverseOreLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(0, 255, 0, 255))
			return
		end

        ply:Smelt( SGS_ReverseOreLookup( args[1] ) )


end
concommand.Add( "sgs_smelt", SGS_ConSmelt )

function PlayerMeta:Smelt( ore )

	local can = true
	local modi = 1

	for k, v in pairs( ore.cost ) do
		local iinv = self.resource[ k ] or 0
		if iinv < v then
			can = false
			self:SendMessage("You do not have the required resources.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	for k, v in pairs( ore.reqlvl ) do
		if self:GetLevel( k ) < v then
			can = false
			self:SendMessage("You do not have the required level.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	if can then
		SGS_Smelt_Start(self, 2, ore, modi)
	end

end

function SGS_ReverseOreLookup( tEnt )

	for k, v in pairs( SGS.Smelting ) do
		for k2, v2 in pairs( SGS.Smelting[k] ) do
			if v2.uid == tEnt then
				return v2
			end
		end
	end

	return nil

end

function SGS_ConArcaneForge( ply, com, args )

		if not #args == 1 then
			ply:SendMessage("Wrong Number of Arguments.", 60, Color(0, 255, 0, 255))
			return
		end

		if not SGS_ReverseStoneLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(0, 255, 0, 255))
			return
		end

        ply:ArcaneForge( SGS_ReverseStoneLookup( args[1] ) )


end
concommand.Add( "sgs_arcaneforge", SGS_ConArcaneForge )

function PlayerMeta:ArcaneForge( stone )

	local can = true
	local modi = 1

	for k, v in pairs( stone.cost ) do
		local iinv = self.resource[ k ] or 0
		if iinv < v then
			can = false
			self:SendMessage("You do not have the required resources.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	for k, v in pairs( stone.reqlvl ) do
		if self:GetLevel( k ) < v then
			can = false
			self:SendMessage("You do not have the required level.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	if can then
		SGS_ArcaneForge_Start(self, 2, stone, modi)
	end

end

function SGS_ReverseStoneLookup( tEnt )

	for k, v in pairs( SGS.MagicForge ) do
		for k2, v2 in pairs( SGS.MagicForge[k] ) do
			if v2.uid == tEnt then
				return v2
			end
		end
	end

	return nil

end

function SGS_ConBrew( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(0, 255, 0, 255))
			return
		end

		if not SGS_ReversePotionLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(0, 255, 0, 255))
			return
		end

        ply:Brew( SGS_ReversePotionLookup( args[1] ) )


end
concommand.Add( "sgs_brew", SGS_ConBrew )

function PlayerMeta:Brew( potion )

	local can = true
	local modi = 1

	for k, v in pairs( potion.cost ) do
		local iinv = self.resource[ k ] or 0
		if iinv < v then
			can = false
			self:SendMessage("You do not have the required resources.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	for k, v in pairs( potion.reqlvl ) do
		if self:GetLevel( k ) < v then
			can = false
			self:SendMessage("You do not have the required level.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	if can then
		SGS_Brew_Start(self, 3, potion, modi)
	end

end

function SGS_ConAidCraft( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(0, 255, 0, 255))
			return
		end

		if not SGS_ReversePotionLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(0, 255, 0, 255))
			return
		end

        ply:AidCraft( SGS_ReversePotionLookup( args[1] ) )


end
concommand.Add( "sgs_aidcraft", SGS_ConAidCraft )

function PlayerMeta:AidCraft( recipee )

	local can = true
	local modi = 1

	for k, v in pairs( recipee.cost ) do
		local iinv = self.resource[ k ] or 0
		if iinv < v then
			can = false
			self:SendMessage("You do not have the required resources.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	for k, v in pairs( recipee.reqlvl ) do
		if self:GetLevel( k ) < v then
			can = false
			self:SendMessage("You do not have the required level.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	if can then
		SGS_AidCraft_Start(self, 3, recipee, modi)
	end

end




function SGS_ConXMute( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(0, 255, 0, 255))
			return
		end

		if not SGS_ReverseXMuteLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(0, 255, 0, 255))
			return
		end

        ply:XMute( SGS_ReverseXMuteLookup( args[1] ) )


end
concommand.Add( "sgs_xmute", SGS_ConXMute )

function PlayerMeta:XMute( recipee )

	local can = true
	local modi = 1

	for k, v in pairs( recipee.cost ) do
		local iinv = self.resource[ k ] or 0
		if iinv < v then
			can = false
			self:SendMessage("You do not have the required resources.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	for k, v in pairs( recipee.reqlvl ) do
		if self:GetLevel( k ) < v then
			can = false
			self:SendMessage("You do not have the required level.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	if can then
		SGS_XMute_Start(self, 2, recipee, modi)
	end

end

function SGS_ReverseXMuteLookup( tEnt )

	for k, v in pairs( SGS.Alch ) do
		for k2, v2 in pairs( SGS.Alch[k] ) do
			if v2.uid == tEnt then
				return v2
			end
		end
	end

	return nil

end


function SGS_ConGrind( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(0, 255, 0, 255))
			return
		end

		if not SGS_ReverseGrindLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(0, 255, 0, 255))
			return
		end

        ply:Grind( SGS_ReverseGrindLookup( args[1] ) )


end
concommand.Add( "sgs_grind", SGS_ConGrind )

function PlayerMeta:Grind( recipee )

	local can = true
	local modi = 1

	for k, v in pairs( recipee.cost ) do
		local iinv = self.resource[ k ] or 0
		if iinv < v then
			can = false
			self:SendMessage("You do not have the required resources.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	for k, v in pairs( recipee.reqlvl ) do
		if self:GetLevel( k ) < v then
			can = false
			self:SendMessage("You do not have the required level.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	if can then
		SGS_Grind_Start(self, 2, recipee, modi)
	end

end

function SGS_ReverseGrindLookup( tEnt )

	for k, v in pairs( SGS.Grind ) do
		for k2, v2 in pairs( SGS.Grind[k] ) do
			if v2.uid == tEnt then
				return v2
			end
		end
	end

	return nil

end

function SGS_ConSmith( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(255, 0, 0, 255))
			return
		end

		if not SGS_ReverseToolLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(255, 0, 0, 255))
			return
		end

        ply:Smith( SGS_ReverseToolLookup( args[1] ) )


end
concommand.Add( "sgs_smith", SGS_ConSmith )




function SGS_ConSmithCheck( ply, com, args )

		if ply.smithcheck then
			ply.smithcheck = false
			ply:SetSetting( "smithcheck", false )
			ply:SendMessage("Smithing check is now disabled.", 60, Color(255, 255, 128, 255))
		else
			ply.smithcheck = true
			ply:SetSetting( "smithcheck", true )
			ply:SendMessage("Smithing check is now enabled.", 60, Color(255, 255, 128, 255))
		end

end
concommand.Add( "sgs_checksmith", SGS_ConSmithCheck )

function SGS_ChatSmithCheck( ply, text, public )

    if (string.sub(string.lower(text), 1, 11) == "!checksmith") then
		SGS_ConSmithCheck(ply, _, _)
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatSmithCheck", SGS_ChatSmithCheck)

function PlayerMeta:Smith( tool )

	local can = true
	local modi = 1

	if not tool.nosmith then
		tool.nosmith = false
	end

	if tool.nosmith == true then
		self:SendMessage("ERROR: You are trying to make a gemmed tool at a regular workbench!", 60, Color(255, 0, 0, 255))
		return
	end

	for k, v in pairs( tool.cost ) do
		local iinv = self.resource[ k ] or 0
		if iinv < v then
			can = false
			self:SendMessage("You do not have the required resources.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	for k, v in pairs( tool.reqlvl ) do
		if self:GetLevel( k ) < v then
			can = false
			self:SendMessage("You do not have the required level.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	if can then
		SGS_Smith_Start(self, 4, tool, modi)
	end

end


function SGS_ConGemTool( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(255, 0, 0, 255))
			return
		end

		if not SGS_ReverseToolLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(255, 0, 0, 255))
			return
		end

		if ply.smithcheck == true then
			if SGS_CheckOwnership( ply, args[1] ) == true or ply.equippedtool == args[1] then
				ply:SendMessage("You are already carrying this tool. The created tool will be lost.", 60, Color(255, 0, 0, 255))
				ply:SendMessage("Type !checksmith in chat to disable this check.", 60, Color(255, 0, 0, 255))
				return
			end
		end

        ply:GemTool( SGS_ReverseToolLookup( args[1] ) )


end
concommand.Add( "sgs_gemtool", SGS_ConGemTool )

function PlayerMeta:GemTool( tool )

	local can = true
	local modi = 1

	for k, v in pairs( tool.cost ) do
		local iinv = self.resource[ k ] or 0
		if iinv < v then
			can = false
			self:SendMessage("You do not have the required resources.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	for k, v in pairs( tool.reqlvl ) do
		if self:GetLevel( k ) < v then
			can = false
			self:SendMessage("You do not have the required level.", 60, Color(255, 0, 0, 255))
			return
		end
	end

	if IsValid(self:GetActiveWeapon()) and self:GetActiveWeapon():GetClass() == tool.entity2 then
		can = false
		self:SendMessage("You must unequip this tool before you gem it.", 60, Color(255, 0, 0, 255))
		return
	end

	if not self:HasTool( tool.entity2 ) then
		can = false
		self:SendMessage("If it's equipped make sure to unequip it first", 60, Color(255, 0, 0, 255))
		self:SendMessage("You need a " .. SGS_ReverseToolLookup( tool.entity2 ).title .. " in your inventory.", 60, Color(255, 0, 0, 255))
		return
	end

	if can then
		SGS_GemTool_Start(self, 4, tool, modi)
	end

end


function SGS_ChatResetSkill( ply, text, public )

    if ( string.sub( string.lower(text), 1, 6 ) == "!reset" ) then
		local args = string.Explode(" ", text)
		if #args > 2 then
			ply:SendMessage("Too many arguments. The correct command is: '!reset <skill>'.", 60, Color(0, 255, 0, 255))
			return false
		end

		local skill = ""
		for k, v in pairs(SGS.skills) do
			if string.lower(args[2]) == v then
				skill = v
				break
			end
		end
		if skill == "" then
			ply:SendMessage("Not a valid skill. The correct command is: '!reset <skill>'.", 60, Color(0, 255, 0, 255))
			return false
		end

		ply:SetExp( skill, 0 )
		ply:SetLevel( skill, 1 )
		ply:SendMessage("Your " .. Cap(skill) .. " skill has been reset!", 60, Color(0, 255, 0, 255))
		ply:LevelUpEffect(skill)
		ply:SetSurvivalLevel()
		ply:SetSurvivalLevelStats()
		ply:SaveCharacter()

		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatResetSkill", SGS_ChatResetSkill )

function SGS_ConCommandResetSkill( ply, com, args )

	if SGS_IsRootAdmin(ply) or ply:IsUserGroup("admin") then

		if #args != 2 then
			SGS_SendMessage(ply, "Wrong number of arguments! The correct command is: 'sgs_resetallskills <player> <skill>'.")
			return
		end

		local target_ply = GAMEMODE.getUser(args[1])
		local skill = string.lower(tostring(args[2]))

		local valid_skill = false
		for k, v in pairs (SGS.skills) do
			if skill == v then
				valid_skill = true
				break
			end
		end

		if valid_skill == false then
			SGS_SendMessage(ply, "Invalid Skill Name!")
			return
		end

		if not IsValid(target_ply) or not target_ply:IsPlayer() or not target_ply:IsConnected() then
			SGS_SendMessage(ply, "Invalid Player!")
			return
		end

		target_ply:SetExp( skill, 0 )
		target_ply:SetLevel( skill, 1 )
		target_ply:SendMessage("The " .. Cap(skill) .. "skill of " .. target_ply:Nick() .. " has been reset!", 60, Color(255, 80, 80, 255))
		target_ply:SetSurvivalLevel()
		target_ply:SetSurvivalLevelStats()
		target_ply:SaveCharacter()


	else
		SGS_SendMessage(ply, "This command is reserved for Administrators only!")
		return
	end


end
concommand.Add( "sgs_resetskill", SGS_ConCommandResetSkill )

function SGS_ConCommandResetAllSkills( ply, com, args )

	if SGS_IsRootAdmin( ply ) or ply:IsUserGroup("admin") then

		if #args != 1 then
			SGS_SendMessage(ply, "Wrong number of arguments! The correct command is: 'sgs_resetallskills <player>'.")
			return
		end

		local target_ply = GAMEMODE.getUser(args[1])

		if not IsValid(target_ply) or not target_ply:IsPlayer() or not target_ply:IsConnected() then
			SGS_SendMessage(ply, "Invalid Player!")
			return
		end

		for k, v in pairs (SGS.skills) do
			target_ply:SetExp( v, 0 )
			target_ply:SetLevel( v, 1 )
		end
		target_ply:SetSurvivalLevel()
		target_ply:SetSurvivalLevelStats()
		target_ply:SaveCharacter()
		target_ply:SendMessage("All skills for " .. target_ply:Nick() .. " have been reset!", 60, Color(255, 80, 80, 255))

	else
		SGS_SendMessage(ply, "This command is reserved for Administrators only!")
		return
	end


end
concommand.Add( "sgs_resetallskills", SGS_ConCommandResetAllSkills )


local valid_cache_entities = { "gms_rcache", "gms_pcache", "gms_pcache2", "gms_pcache3", "gms_pcache4", "gms_pcacheboss", "gms_tribecache",  }
function SGS_CacheValidCheck(ply, amt)
	if tostring(amt) == tostring(tonumber("nan")) then
		SGS_Log( "!!!!!!!!!!!" .. ply:Nick() .. " is trying to 'nan' dupe an item.")
		ply:SendMessage("This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
		return false
	end

	if amt <= 0 then
		ply:SendMessage("You can not deposit a value of 0 or less.", 60, Color(255, 255, 80, 255))
		return false
	end

	local trace = ply:TraceFromEyes(100)
    if not IsValid(trace.Entity) then
		return false
    end

	if not table.HasValue( valid_cache_entities, trace.Entity:GetClass() ) then
		return false
	end

	return trace.Entity
end


function SGS_CacheAmtCheck(ply, res, amt, ent)
	if not IsValid( ent ) then return end

	local newAmt = amt

	if ply.resource[res] < amt then
		ply:SendMessage("You don't have that many. Changing amount to your current total.", 60, Color(255, 255, 80, 255))
		newAmt = ply.resource[res]
	end

	if ent:GetFreeSpace() < newAmt then
		ply:SendMessage("The cache can only hold " ..ent:GetFreeSpace().." more resources. Depositing max.", 60, Color(255, 255, 80, 255))
		newAmt = ent:GetFreeSpace()
	end

	return newAmt

end


net.Receive( "cl_torcache", function( l, ply )
	local res = net.ReadString()
	local amt = net.ReadInt( 16 )
	local ent = SGS_CacheValidCheck(ply, amt)

	if not ent then return end

	amt = SGS_CacheAmtCheck(ply, res, amt, ent)

	ent:SetResourceDropInfo( res, amt )
	ply:SubResource( res, amt )


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.contents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_topcache1", function( l, ply )
	local res = net.ReadString()
	local amt = net.ReadInt( 16 )
	local ent = SGS_CacheValidCheck(ply, amt)

	if not ent or not ent.enabled then return end

	amt = SGS_CacheAmtCheck(ply, res, amt, ent)

	ent:SetResourceDropInfo( res, amt )
	ply:SubResource( res, amt )


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.POwner.pcontents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_topcache2", function( l, ply )
	local res = net.ReadString()
	local amt = net.ReadInt( 16 )
  local ent = SGS_CacheValidCheck(ply, amt)

	if not ent or not ent.enabled then return end

	amt = SGS_CacheAmtCheck(ply, res, amt, ent)

	ent:SetResourceDropInfo( res, amt )
	ply:SubResource( res, amt )


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.POwner.p2contents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_topcache3", function( l, ply )
	local res = net.ReadString()
  local amt = net.ReadInt( 16 )
  local ent = SGS_CacheValidCheck(ply, amt)

  if not ent or not ent.enabled then return end

  amt = SGS_CacheAmtCheck(ply, res, amt, ent)

  ent:SetResourceDropInfo( res, amt )
  ply:SubResource( res, amt )


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.POwner.p3contents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_topcache4", function( l, ply )
	local res = net.ReadString()
  local amt = net.ReadInt( 16 )
  local ent = SGS_CacheValidCheck(ply, amt)

  if not ent or not ent.enabled then return end

  amt = SGS_CacheAmtCheck(ply, res, amt, ent)

  ent:SetResourceDropInfo( res, amt )
  ply:SubResource( res, amt )


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.POwner.p4contents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_topcacheboss", function( l, ply )
	local res = net.ReadString()
  local amt = net.ReadInt( 16 )
  local ent = SGS_CacheValidCheck(ply, amt)

  if not ent or not ent.enabled then return end

  amt = SGS_CacheAmtCheck(ply, res, amt, ent)

  ent:SetResourceDropInfo( res, amt )
  ply:SubResource( res, amt )


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.POwner.pbosscontents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )


net.Receive( "cl_totribecache", function( l, ply )
	local res = net.ReadString()
	local amt = net.ReadInt( 16 )
	local ent = SGS_CacheValidCheck(ply, amt)

	if not ent or not ent.enabled then return end

	amt = SGS_CacheAmtCheck(ply, res, amt, ent)

	ent:SetResourceDropInfo( res, amt )
	ply:SubResource( res, amt )


	net.Start("UpdateCacheTable")
		net.WriteTable( GAMEMODE.Tribes.tblTribes[ ent.tribeid ].cachecontents or {} )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_fromtribecache", function( l, ply )
	local res = net.ReadString()
	local amt = net.ReadInt( 16 )
	local ent = SGS_CacheValidCheck(ply, amt)

	if not ent or not ent:GetClass() == "gms_tribecache" then return end

	if(SPropProtection.PlayerUse(ply, ent) == false) then return end

	if not GAMEMODE.Tribes.tblTribes[ ent.tribeid ].cachecontents[res] then
		ply:SendMessage("The cache doesn't have any of that.", 60, Color(255, 255, 80, 255))
		return
	end

	if GAMEMODE.Tribes.tblTribes[ ent.tribeid ].cachecontents[res] < amt then
		ply:SendMessage("Cache doesn't have that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = GAMEMODE.Tribes.tblTribes[ ent.tribeid ].cachecontents[res]
	end

	if ( ply.maxinv - ply.curinv ) < amt then
		ply:SendMessage("You can't withdraw that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ply.maxinv - ply.curinv
	end

	if amt <= 0 then return end

	ent:SetResourceDropInfo( string.lower(res), amt * -1 )
	ply:AddResource( string.lower(res), amt )

	net.Start("UpdateCacheTable")
		net.WriteTable( GAMEMODE.Tribes.tblTribes[ ent.tribeid ].cachecontents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_fromrcache", function( l, ply )
	local res = net.ReadString()
	local amt = net.ReadInt( 16 )
	local ent = SGS_CacheValidCheck(ply, amt)

	if not ent or not ent:GetClass() == "gms_rcache" then return end
	if not ent.contents then return end

	if(SPropProtection.PlayerUse(ply, ent) == false) then return end

	if not ent.contents[res] then
		ply:SendMessage("The cache doesn't have any of that.", 60, Color(255, 255, 80, 255))
		return
	end

	if ent.contents[res] < amt then
		ply:SendMessage("Cache doesn't have that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ent.contents[res]
	end

	if ( ply.maxinv - ply.curinv ) < amt then
		ply:SendMessage("You can't withdraw that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ply.maxinv - ply.curinv
	end

  if amt <= 0 then return end

	ent:SetResourceDropInfo( string.lower(res), amt * -1 )
	ply:AddResource( string.lower(res), amt )


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.contents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_frompcache1", function( l, ply )
	local res = net.ReadString()
	local amt = net.ReadInt( 16 )
	local ent = SGS_CacheValidCheck(ply, amt)

	if not ent or not ent:GetClass() == "gms_pcache" then return end
	if not ent.POwner.pcontents then return end

	if(SPropProtection.PlayerUse(ply, ent) == false) then return end

	if not IsValid( ent.POwner ) then return end

	if not ent.POwner.pcontents[res] then
		ply:SendMessage("The cache doesn't have any of that.", 60, Color(255, 255, 80, 255))
		return
	end

	if ent.POwner.pcontents[res] < amt then
		ply:SendMessage("Cache doesn't have that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ent.POwner.pcontents[res]
	end

	if ( ply.maxinv - ply.curinv ) < amt then
		ply:SendMessage("You can't withdraw that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ply.maxinv - ply.curinv
	end

	if amt <= 0 then return end

	ent:SetResourceDropInfo( string.lower(res), amt * -1 )
	ply:AddResource( string.lower(res), amt )

	if not ( SPropProtection.Props[ent:EntIndex()].SteamID64 == ply:GetPlayerID() ) then
		SGS.Log("** " .. ply:Nick() .. " (" .. ply:GetPlayerID() .. ") removed " .. amt .. "x of item " .. res .. " from the pcache owned by: " .. SPropProtection.Props[ent:EntIndex()].Name .. " (" .. SPropProtection.Props[ent:EntIndex()].SteamID64 .. ")**" )
	end


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.POwner.pcontents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_frompcache2", function( l, ply )
	local res = net.ReadString()
	local amt = net.ReadInt( 16 )
	local ent = SGS_CacheValidCheck(ply, amt)

	if not ent or not ent:GetClass() == "gms_pcache2" then return end
	if not ent.POwner.p2contents then return end

	if(SPropProtection.PlayerUse(ply, ent) == false) then return end

	if not IsValid( ent.POwner ) then return end

	if not ent.POwner.p2contents[res] then
		ply:SendMessage("The cache doesn't have any of that.", 60, Color(255, 255, 80, 255))
		return
	end

	if ent.POwner.p2contents[res] < amt then
		ply:SendMessage("Cache doesn't have that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ent.POwner.p2contents[res]
	end

	if ( ply.maxinv - ply.curinv ) < amt then
		ply:SendMessage("You can't withdraw that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ply.maxinv - ply.curinv
	end

	if amt <= 0 then return end

	ent:SetResourceDropInfo( string.lower(res), amt * -1 )
	ply:AddResource( string.lower(res), amt )

	if not ( SPropProtection.Props[ent:EntIndex()].SteamID64 == ply:GetPlayerID() ) then
		SGS.Log("** " .. ply:Nick() .. " (" .. ply:GetPlayerID() .. ") removed " .. amt .. "x of item " .. res .. " from the pcache2 owned by: " .. SPropProtection.Props[ent:EntIndex()].Name .. " (" .. SPropProtection.Props[ent:EntIndex()].SteamID64 .. ")**" )
	end


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.POwner.p2contents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_frompcache3", function( l, ply )
	local res = net.ReadString()
	local amt = net.ReadInt( 16 )
	local ent = SGS_CacheValidCheck(ply, amt)

	if not ent or not ent:GetClass() == "gms_pcache3" then return end
	if not ent.POwner.p3contents then return end

	if(SPropProtection.PlayerUse(ply, ent) == false) then return end

	if not IsValid( ent.POwner ) then return end

	if not ent.POwner.p3contents[res] then
		ply:SendMessage("The cache doesn't have any of that.", 60, Color(255, 255, 80, 255))
		return
	end

	if ent.POwner.p3contents[res] < amt then
		ply:SendMessage("Cache doesn't have that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ent.POwner.p3contents[res]
	end

	if ( ply.maxinv - ply.curinv ) < amt then
		ply:SendMessage("You can't withdraw that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ply.maxinv - ply.curinv
	end

	if amt <= 0 then return end

	ent:SetResourceDropInfo( string.lower(res), amt * -1 )
	ply:AddResource( string.lower(res), amt )

	if not ( SPropProtection.Props[ent:EntIndex()].SteamID64 == ply:GetPlayerID() ) then
		SGS.Log("** " .. ply:Nick() .. " (" .. ply:GetPlayerID() .. ") removed " .. amt .. "x of item " .. res .. " from the pcache3 owned by: " .. SPropProtection.Props[ent:EntIndex()].Name .. " (" .. SPropProtection.Props[ent:EntIndex()].SteamID64 .. ")**" )
	end


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.POwner.p3contents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_frompcache4", function( l, ply )
	local res = net.ReadString()
  local amt = net.ReadInt( 16 )
  local ent = SGS_CacheValidCheck(ply, amt)

  if not ent or not ent:GetClass() == "gms_pcache4" then return end
	if not ent.POwner.p4contents then return end

  if(SPropProtection.PlayerUse(ply, ent) == false) then return end

  if not IsValid( ent.POwner ) then return end

	if not ent.POwner.p4contents[res] then
		ply:SendMessage("The cache doesn't have any of that.", 60, Color(255, 255, 80, 255))
		return
	end

	if ent.POwner.p4contents[res] < amt then
		ply:SendMessage("Cache doesn't have that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ent.POwner.p4contents[res]
	end

	if ( ply.maxinv - ply.curinv ) < amt then
		ply:SendMessage("You can't withdraw that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ply.maxinv - ply.curinv
	end

	if amt <= 0 then return end

	ent:SetResourceDropInfo( string.lower(res), amt * -1 )
	ply:AddResource( string.lower(res), amt )

	if not ( SPropProtection.Props[ent:EntIndex()].SteamID64 == ply:GetPlayerID() ) then
		SGS.Log("** " .. ply:Nick() .. " (" .. ply:GetPlayerID() .. ") removed " .. amt .. "x of item " .. res .. " from the pcache4 owned by: " .. SPropProtection.Props[ent:EntIndex()].Name .. " (" .. SPropProtection.Props[ent:EntIndex()].SteamID64 .. ")**" )
	end


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.POwner.p4contents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_frompcacheboss", function( l, ply )
	local res = net.ReadString()
	local amt = net.ReadInt( 16 )
	local ent = SGS_CacheValidCheck(ply, amt)

	if not ent or not ent:GetClass() == "gms_pcacheboss" then return end
	if not ent.POwner.pbosscontents then return end

	if(SPropProtection.PlayerUse(ply, ent) == false) then return end

	if not IsValid( ent.POwner ) then return end

	if not ent.POwner.pbosscontents[res] then
		ply:SendMessage("The cache doesn't have any of that.", 60, Color(255, 255, 80, 255))
		return
	end

	if ent.POwner.pbosscontents[res] < amt then
		ply:SendMessage("Cache doesn't have that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ent.POwner.pbosscontents[res]
	end

	if ( ply.maxinv - ply.curinv ) < amt then
		ply:SendMessage("You can't withdraw that many, taking max.", 60, Color(255, 255, 80, 255))
		amt = ply.maxinv - ply.curinv
	end

	if amt <= 0 then return end

	ent:SetResourceDropInfo( string.lower(res), amt * -1 )
	ply:AddResource( string.lower(res), amt )

	if not ( SPropProtection.Props[ent:EntIndex()].SteamID64 == ply:GetPlayerID() ) then
		SGS.Log("** " .. ply:Nick() .. " (" .. ply:GetPlayerID() .. ") removed " .. amt .. "x of item " .. res .. " from the pcacheboss owned by: " .. SPropProtection.Props[ent:EntIndex()].Name .. " (" .. SPropProtection.Props[ent:EntIndex()].SteamID64 .. ")**" )
	end


	net.Start("UpdateCacheTable")
		net.WriteTable( ent.POwner.pbosscontents )
	net.Send( ply )

	timer.Simple( 0.2, function() ply:ConCommand("sgs_refreshrcachelist") end )
end )

net.Receive( "cl_fromtcache", function( l, ply )
	local tool = net.ReadString()
	local trace = ply:TraceFromEyes(100)

	if not IsValid(trace.Entity) then
		return
	end

	if not (trace.Entity:GetClass() == "gms_tcache") then
		return
	end

	local ent = trace.Entity
	if(SPropProtection.PlayerUse(ply, ent) == false) then return end


	if not ent.contents[ tool ] then
		ply:SendMessage("The cache doesn't have any: " .. CapAll(string.gsub(tool, "_", " ")) ..".", 60, Color(0, 255, 0, 255))
		return
	end

	if ent.contents[ tool ] <= 0 then
		ply:SendMessage("The cache doesn't have any: " .. CapAll(string.gsub(tool, "_", " ")) ..".", 60, Color(0, 255, 0, 255))
		return
	end

	ent:SetResourceDropInfo( string.lower(tool),  -1 )
	ply:AddTool( string.lower(tool) )

	if not ( SPropProtection.Props[ent:EntIndex()].SteamID64 == ply:GetPlayerID() ) then
		SGS.Log("** " .. ply:Nick() .. " (" .. ply:GetPlayerID() .. ") removed a " .. string.lower(tool) .. " from the tcache owned by: " .. SPropProtection.Props[ent:EntIndex()].Name .. " (" .. SPropProtection.Props[ent:EntIndex()].SteamID64 .. ")**" )
	end
end )

net.Receive( "cl_fromptcache", function( l, ply )
	local tool = net.ReadString()
	local trace = ply:TraceFromEyes(100)

	if not IsValid(trace.Entity) then
		return
	end

	if not (trace.Entity:GetClass() == "gms_ptcache") then
		return
	end

	local ent = trace.Entity
	if(SPropProtection.PlayerUse(ply, ent) == false) then return end

	if not IsValid( ent.POwner ) then return end


	if not ent.POwner.ptcontents[ tool ] then
		ply:SendMessage("The cache doesn't have any: " .. CapAll(string.gsub(tool, "_", " ")) ..".", 60, Color(0, 255, 0, 255))
		return
	end

	if ent.POwner.ptcontents[ tool ] <= 0 then
		ply:SendMessage("The cache doesn't have any: " .. CapAll(string.gsub(tool, "_", " ")) ..".", 60, Color(0, 255, 0, 255))
		return
	end

	ent:SetResourceDropInfo( string.lower(tool),  -1 )
	ply:AddTool( string.lower(tool) )

	if not ( SPropProtection.Props[ent:EntIndex()].SteamID64 == ply:GetPlayerID() ) then
		SGS.Log("** " .. ply:Nick() .. " (" .. ply:GetPlayerID() .. ") removed a " .. string.lower(tool) .. " from the ptcache owned by: " .. SPropProtection.Props[ent:EntIndex()].Name .. " (" .. SPropProtection.Props[ent:EntIndex()].SteamID64 .. ")**" )
	end
end )


hook.Add( "DayLightChangeTime", "DayChange", function( time )
	net.Start("sgs_updatetime")
		net.WriteInt( DayLight.Minute, 32 )
		net.WriteInt( DayLight.Day, 32 )
	net.Broadcast()
end)

function SGS_SickTick()

	for _, ply in pairs( player.GetAll() ) do

		if not (ply:GetInitialized() == INITSTATE_OK) then
			continue
		end

		if ply.sick == nil then
			continue
		end

		if ply.sick == 0 then
			continue
		end

		if ply.sick > 0 then
			ply:SetHealth(ply:Health() - math.random(8,10))
			ply:EmitSound(Sound("player/pl_drown3.wav"), 65, math.random(70, 130))
			ply:SendMessage("The sickness is taking its toll on your health.", 60, Color(255, 0, 0, 255))
			ply.sick = ply.sick - 1
			ply.settings["melonaids"] = ply.sick
			if ply.sick == 0 then
				ply:SendMessage("You are feeling better.", 60, Color(0, 255, 0, 255))
				ply.settings["melonaids"] = -1
				
				ply:SendLua("LocalPlayer().melonaids = false")
			end
			if ply:Health() <= 0 then
				ply.killstring = "Melonaids"
				ply:Kill()
				SGS_Log( ply:Nick() .. " died of Melonaids." )
				ply.sick = 0
				ply:AddStat( "general9", 1 )
				ply.settings["melonaids"] = -1
				ply:SendLua("LocalPlayer().melonaids = false")
				for _, v in pairs( player.GetAll() ) do
					v:SendMessage("" .. ply:Nick() .. " died of Melonaids... :(", 60, Color(255, 0, 255, 255))
				end
			end
		end
	end
end
timer.Create( "SGS_SickTick", 45, 0, SGS_SickTick )

function SGS_UpdateAdText()

	local adtext = {
		"To report bugs or make suggestions, please visit our site at www.g4p.org",
		"Report players or bugs using our !report feature!",
		"Register for membership by entering your SteamID on our website's main page. Members have some gameplay benefits.",
		"Please consider donating. For information on how to donate and donator perks please press F9 and click on donate!",
		"The servers will restart every WEDNESDAY/SATURDAY at 10PM Pacific Standard Time (GMT-8)",
		"Check out the leaderboard on our website, or by pressing F9",
		"Our new Restart/Update day is SATURDAY at 10pm PST. Don't miss it!",
		"Report griefers or rulebreakers on our Forums. (www.g4p.org)"
		}

	net.Start("sgs_updateadtext")
		net.WriteString( table.Random(adtext) )
	net.Broadcast()

end
timer.Create( "SGS_UpdateAdText", 60, 0, SGS_UpdateAdText )

function SGS_ChatOpenSPP( ply, text, public )

    if (string.sub(string.lower(text), 1, 9) == "!sppadmin") then
        if ply:IsAdmin() then
			ply:SendLua( "SGS_SPP_Admin()" )
			return false
		else
			ply:SendMessage("You are not an admin!", 60, Color(255, 0, 0, 255))
		end
    end

    if (string.sub(string.lower(text), 1, 4) == "!spp") then
        ply:SendMessage("SPP is now located in the Q menu!", 60, Color(255, 0, 255, 255))
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatOpenSPP", SGS_ChatOpenSPP )

function SGS_ChatOpenPBM( ply, text, public )
    if (string.sub(string.lower(text), 1, 4) == "!pbm") then
		ply:SendLua( "vgui.Create('pbm_newmenu')" )
		return false
    end
end
hook.Add( "PlayerSay", "SGS_ChatOpenPBM", SGS_ChatOpenPBM )

function SGS_Con_OpenPBM( ply, con, args )
	ply:SendLua( "vgui.Create('pbm_newmenu')" )
end
concommand.Add("sgs_pbm_menu", SGS_Con_OpenPBM)

function big_gms_combineresource( ent_a, ent_b )
	local ent_a_owner = ent_a:GetNetworkedString("Owner")
	local ent_b_owner = ent_b:GetNetworkedString("Owner")

	local ply = ent_a:CPPIGetOwner()



	if ent_a_owner != nil and ent_b_owner != nil and ply != nil then
		if ent_a_owner == ent_b_owner or SPropProtection.PlayerCanTouch(ply, ent_b) then

			local ent = ents.Create("gms_resourcedrop")
			ent:SetPos(ent_a:GetPos())
			ent:SetAngles(ent_a:GetAngles())
			ent:Spawn()
			ent:GetPhysicsObject():Wake()


			ent.rType = ent_a.rType
			ent.rAmt = ent_a.rAmt+ent_b.rAmt

			ent:SetResourceDropInfo( ent_a.rType, ent_a.rAmt + ent_b.rAmt )
			ent_a:Remove()
			ent_b:Remove()
			ent:CPPISetOwner(ply)
			SGS_SetupDrop( ent, ent.rType, ent.rAmt )


		end

	else
		local ent = ents.Create("gms_resourcedrop")
		ent:SetPos(ent_a:GetPos())
		ent:SetAngles(ent_a:GetAngles())
		ent:Spawn()
		ent:GetPhysicsObject():Wake()

		ent.rType = ent_a.rType
		ent.rAmt = ent_a.rAmt+ent_b.rAmt

		ent:SetResourceDropInfo(ent_a.rType,ent_a.rAmt+ent_b.rAmt)
		ent_a:Remove()
		ent_b:Remove()
		SGS_SetupDrop( ent, ent.rType, ent.rAmt )

	end
end




function GM:PlayerSetModel( self )

	local cl_playermodel = self:GetInfo( "cl_playermodel" )
	if self.allowedmodels == nil then self.allowedmodels = {} end

	for _, v in pairs(self.allowedmodels) do
		if cl_playermodel == v then
			local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
			util.PrecacheModel( modelname )
			self:SetModel( modelname )
			self:EquipHat( self:GetEquippedHat() )
			return
		end
	end

	local rm = math.random( 1, table.Count(SGS.pm1) )
	local modelname = player_manager.TranslatePlayerModel( SGS.pm1[rm] )
	util.PrecacheModel( modelname )
	self:SetModel( modelname )
	self:EquipHat( self:GetEquippedHat() )
	self:ConCommand("cl_playermodel " .. SGS.pm1[rm])

	if self.amode then
		self:SetModel("models/Crow.mdl")
	end

end

function SGS_ChangePlayerModel( ply, _, args )

	if not #args == 1 then
		args[1] = "male01"
	end

	for _, v in pairs(ply.allowedmodels) do
		if args[1] == v then
			local modelname = player_manager.TranslatePlayerModel( args[1] )
			util.PrecacheModel( modelname )
			ply:SetModel( modelname )
			ply:EquipHat( ply:GetEquippedHat() )
			ply:ConCommand("sgs_refreshmodelpanel")
			ply:ConCommand("cl_playermodel " .. args[1])
			if ply.amode then
				ply:SetModel("models/Crow.mdl")
				--ply:EquipHat( nil )
			end
			return
		end
	end

	local modelname = player_manager.TranslatePlayerModel( "male01" )
	util.PrecacheModel( modelname )
	ply:SetModel( modelname )
	ply:EquipHat( ply:GetEquippedHat() )
	ply:ConCommand("sgs_refreshmodelpanel")
	ply:ConCommand("cl_playermodel " .. args[1])

	if ply.amode then
		ply:SetModel("models/Crow.mdl")
		--ply:EquipHat( nil )
	end

end
concommand.Add( "sgs_changepmodel", SGS_ChangePlayerModel )

function GM:PlayerDeathSound()
	return true
end

function SGS_ChatFirstPerson( ply, text, public )

    if (string.sub(string.lower(text), 1, 12) == "!firstperson") then
		ply:SendLua( "SGS.person = \"first\"" )
		ply.perspective = "first"
		ply:SetSetting( "person", "first" )
		return false
    end
	if (string.sub(string.lower(text), 1, 6) == "!first") then
		ply:SendLua( "SGS.person = \"first\"" )
		ply.perspective = "first"
		ply:SetSetting( "person", "first" )
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatFirstPerson", SGS_ChatFirstPerson )

function SGS_ChatThirdPerson( ply, text, public )

    if (string.sub(string.lower(text), 1, 12) == "!thirdperson") then
		ply:SendLua( "SGS.person = \"third\"" )
		ply.perspective = "third"
		ply:SetSetting( "person", "third" )
		return false
    end
    if (string.sub(string.lower(text), 1, 6) == "!third") then
		ply:SendLua( "SGS.person = \"third\"" )
		ply.perspective = "third"
		ply:SetSetting( "person", "third" )
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatThirdPerson", SGS_ChatThirdPerson )

function SGS_CombatDamageHandling( ent, dmginfo )
 	local infl = dmginfo:GetInflictor()
	local att = dmginfo:GetAttacker()
	local amount = dmginfo:GetDamage()
	
	if ent:IsPlayer() then
		if ent == infl then return end
		if ent.amode and not ( infl:GetClass() == "trigger_hurt" ) then
			dmginfo:ScaleDamage(0)
			return
		end

		if infl:IsPlayer() then
			if infl.inpvp and ent.inpvp then
				if ent.inprocess == true then
					SGS_CancelProcess(ent, _, _)
				end
			end
		else
			if ent.inprocess == true then
				if not ( dmginfo:GetDamageType() == DMG_PHYSGUN ) then
					SGS_CancelProcess(ent, _, _)
				end
			end
		end

		if infl:GetClass() == "worldspawn" then
			if dmginfo:GetDamageType() == DMG_PHYSGUN then
				dmginfo:SetDamage(dmginfo:GetDamage())
			else
				if dmginfo:IsFallDamage() then
				else
					if dmginfo:GetDamageType() == 67108864 then
					
					else
						if math.random(1,30) == 1 then
							local dmg = dmginfo:GetDamage() * 2
							dmginfo:SetDamage(math.floor(dmg - ( ( (ent:GetLevel("combat") - 1) * 0.0064) * dmg)) )
						else
							local dmg = dmginfo:GetDamage()
							dmginfo:SetDamage(math.floor(dmg - ( ( (ent:GetLevel("combat") - 1) * 0.0064) * dmg)) )
						end
					end
				end
			end
		elseif infl:GetClass() == "trigger_hurt" then
			dmginfo:SetDamage(1000000)
			dmginfo:SetDamageType(67108864)
		elseif infl:GetClass() == "hunter_flechette" then
			if not IsValid(att) then return end
			if ent.levitate then
				SGS_BossUnLevitatePlayer( ent )
			end
			local dmg_low = 8
			local dmg_high = 18
			if att:GetNWBool("enraged", false) then
				local dmg_low = 16
				local dmg_high = 32
			end
			if math.random(1,20) == 1 then
				dmginfo:SetDamage(math.random(dmg_low,dmg_high) * 3)
			else
				dmginfo:SetDamage(math.random(dmg_low,dmg_high))
			end
			return
		elseif infl:GetClass() == "grenade_spit" then
			if not IsValid(att) then return end
			if math.random(1,20) == 1 then
				dmginfo:SetDamage(math.random(5,10) * 3)
				dmginfo:SetDamageType(1048576)
			else
				dmginfo:SetDamage(math.random(5,10))
				dmginfo:SetDamageType(1048576)
			end
			return
		elseif infl:IsPlayer() then
			infl.lastpvp = CurTime()
			if infl.inpvp then
				if ent.inpvp == false then
					dmginfo:ScaleDamage(0)
					infl:SendMessage("This player currently has PvP disabled.", 60, Color(255, 0, 0, 255))
					infl:SendLua( "SGS_PlayErrorSound(false)" )
				else
					if math.random(1,20) == 1 then
						local dmg = amount * 2
						dmginfo:SetDamage(math.floor(dmg - ( ( (ent:GetLevel("combat") - 1) * 0.01) * dmg)) )
					else
						local dmg = amount
						dmginfo:SetDamage(math.floor(dmg - ( ( (ent:GetLevel("combat") - 1) * 0.01) * dmg)) )
					end
				end
			else
				dmginfo:ScaleDamage(0)
				infl:SendMessage("Enable PvP to attack other players.", 60, Color(255, 0, 0, 255))
				infl:SendLua( "SGS_PlayErrorSound(false)" )
			end
		elseif infl:IsNPC() then
			if infl:GetClass() == "npc_antlion" and dmginfo:GetDamageType() == 134348800 then
				dmginfo:ScaleDamage(0.5)
				ent:Heal(10)
				return
			end
			if infl.ispet then
				dmginfo:ScaleDamage(0)
			end
			if infl.dmg == nil then
				dmginfo:SetDamage(dmginfo:GetDamage())
			else
				if math.random(1,20) == 1 then
					local dmg = infl.dmg * 2
					if att:GetNWBool("enraged", false) then dmg = dmg * 2 end
					dmginfo:SetDamage(math.floor(dmg - ( ( (ent:GetLevel("combat") - 1) * 0.01) * dmg)) )
				else
					local dmg = infl.dmg
					if att:GetNWBool("enraged", false) then dmg = dmg * 2 end
					dmginfo:SetDamage(math.floor(dmg - ( ( (ent:GetLevel("combat") - 1) * 0.01) * dmg)) )
				end
				local dmg = infl.dmg
				
				
				if dmginfo:GetDamageType() == 0 and infl:GetClass() == "npc_strider" then
					dmginfo:SetDamage(80)
					dmginfo:SetDamageType(67108864)
				end
				if GAMEMODE.Worlds.BloodMoon and infl:GetClass() == "npc_zombie" then
					if math.random( 3 ) == 1 then
						SGS_Bleed( ent, dmginfo:GetDamage() * 2 )
					end
				end
				if infl:GetClass() == "npc_sniper" and SGS.shopent3.attacking ~= ent then
					dmginfo:ScaleDamage(0)
				end
			end
		else
			dmginfo:ScaleDamage(0)
		end
	end

end
hook.Add("EntityTakeDamage", "SGS_CombatDamageHandling", SGS_CombatDamageHandling)

function SGS_Bleed( ply, amt )
	if not IsValid(ply) then return end
	if not ply.bleedamt then ply.bleedamt = 0 end
	ply.bleedamt = ply.bleedamt + amt
	if not ply.bleeding then
		ply:SendMessage("You are bleeding!", 60, Color(255, 0, 0, 255))
	end
	ply.bleeding = true
	ply:SendLua("LocalPlayer().bleeding = true")
end

function SGS_BleedTick()
	for k, v in pairs( player.GetAll() ) do
		if not v:Alive() then continue end
		if v.bleeding then
			if v.bleedamt > 5 then
				d = DamageInfo()
				d:SetDamageType( DMG_PHYSGUN )
				d:SetDamage( 5 )
				d:SetAttacker(Entity(0))
				d:SetInflictor(Entity(0))
				v:TakeDamageInfo(d)
				v.bleedamt = v.bleedamt - 5
			else
				d = DamageInfo()
				d:SetDamageType( DMG_PHYSGUN )
				d:SetDamage( v.bleedamt )
				d:SetAttacker(Entity(0))
				d:SetInflictor(Entity(0))
				v:TakeDamageInfo(d)
				v:StopBleeding()
			end
			local ED = EffectData()
			ED:SetOrigin( v:GetAttachment(v:LookupAttachment("eyes")).Pos )
			local effect = util.Effect( 'BloodImpact', ED, true, true )
		end
	end
end
timer.Create( "sgs_bleedtick", 2, 0, SGS_BleedTick )

function PlayerMeta:StopBleeding()
	self.bleedamt = 0
	self.bleeding = false
	self:SendMessage("The bleeding has stopped.", 60, Color(255, 255, 0, 255))
	self:SendLua("LocalPlayer().bleeding = false")
end

function SGS_PropDamageHandling( ent, dmginfo )
	if not IsValid( ent ) then return end
 	local infl = dmginfo:GetInflictor()
	local att = dmginfo:GetAttacker()
	local amount = dmginfo:GetDamage()

	if att:GetClass() == "kawoosh_hurt" then return end

	if not GAMEMODE.Worlds:GetEntityWorldSpace( ent )then return end

	if GAMEMODE.Worlds:GetEntityWorldSpace( ent ).BreakableStructures then
		if not table.HasValue( GAMEMODE.Worlds:GetEntityWorldSpace( ent ).BreakableStructuresTbl, ent:GetClass() ) then return end
		if not ent.health and ent:GetClass() == "gms_prop" then SGS_CalcPropHealth( ent ) end
		if not ent.health then ent.health = 100 ent.maxhealth = 100 end
		ent.health = ent.health - amount
		if not ent.healthycolor then ent.healthycolor = ent:GetColor() end
		local hp_percent = math.Clamp(ent.health / ent.maxhealth, 0, 100)
		ent:SetColor( Color( ent.healthycolor.r * hp_percent, ent.healthycolor.g * hp_percent, ent.healthycolor.b * hp_percent, 255 ) )
		if ent.health <= 0 then
			SGS_DestroyEntity( ent, infl )
		end
	end
end
hook.Add("EntityTakeDamage", "SGS_PropDamageHandling", SGS_PropDamageHandling)

function SGS_DestroyEntity( ent, ply )

	if ent:GetClass() == "gms_rcache" then
		ent:PrecacheGibs()
		ent:GibBreakClient( VectorRand() * 15 )
		if table.Count( ent.contents ) > 0 then
			for k, v in pairs( ent.contents ) do
				SGS_MakeResourceDrop( k, v, ent:GetPos() + Vector( 0, 0, 20 ) )
			end
		end
		ent:Remove()
	else
		ent:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		local phys = ent:GetPhysicsObject()
		if phys and phys:IsValid() then
			phys:EnableMotion(true) -- Freezes the object in place.
			phys:Wake()
			if not ply then
				phys:AddVelocity( Vector(math.random(-100,100), math.random(-100,100), math.random(-100,100)) * 5)
			else
				phys:AddVelocity( ply:GetAimVector() * 400)
			end
		end
		ent.destroyed = true
		SafeRemoveEntityDelayed( ent, 1 )
	end
end

function SGS_EmitHitSound( mat, pos )
	if mat == MAT_WOOD then
		sound.Play( "physics/wood/wood_crate_impact_hard4.wav", pos, 80, math.random(80,120) )
	elseif mat == MAT_METAL then
		sound.Play( "physics/metal/metal_canister_impact_hard3.wav", pos, 80, math.random(80,120) )
	elseif mat == MAT_GLASS then
		sound.Play( "physics/glass/glass_impact_bullet1.wav", pos, 80, math.random(80,120) )
	elseif mat == MAT_CONCRETE then
		sound.Play( "physics/concrete/concrete_impact_hard2.wav", pos, 80, math.random(80,120) )
	elseif mat == MAT_FLESH then
		sound.Play( "physics/flesh/flesh_squishy_impact_hard4.wav", pos, 80, math.random(80,120) )
	else
		sound.Play( "weapons/crossbow/hitbod" .. tostring(math.random(1,2)) .. ".wav", pos, 80, math.random(80,120) )
	end
end

function SGS_CalcPropHealth( ent )
	local maxvol = 147456
	local maxhp = 300

	local vol = ent:GetPhysicsObject():GetVolume()
	local hp
	hp = math.floor((vol / maxvol) * maxhp)
	if ent:GetMaterialType() == MAT_CONCRETE then hp = math.floor(hp * 1.5) end
	if ent:GetMaterialType() == MAT_METAL then hp = math.floor(hp * 2) end

	ent.health = hp
	ent.maxhealth = hp
end

function SGS_UnStick(ply, _, args)
	if ply.unstuck_lastpos then
		ply:SendMessage("You are already waiting to teleport.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply:InVehicle() then
		ply:SendMessage("You can't use this command while in a chair.", 60, Color(255, 0, 0, 255))
		return
	end
	if CurTime() < ply.nextunstuck then
		if math.floor((ply.nextunstuck - CurTime()) / 60) > 0 then
			ply:SendMessage("You must wait " .. math.floor((ply.nextunstuck - CurTime()) / 60) .. " more minutes.", 60, Color(255, 0, 0, 255))
		else
			ply:SendMessage("You must wait " .. math.floor( ply.nextunstuck - CurTime() ) .. " more seconds.", 60, Color(255, 0, 0, 255))
		end
		return
	end
	ply.unstuck_lastpos = ply:GetPos()
	ply:SendMessage("Don't move, you'll be teleported to spawn in 5 seconds!", 60, Color(255, 255, 0, 255))
	timer.Simple( 5, function() SGS_UnstuckMove( ply ) end )
end
concommand.Add( "sgs_unstuck", SGS_UnStick )

function SGS_UnstuckMove( ply )
	--if ply.unstuck_lastpos == ply:GetPos() then
	if ply:GetPos():Distance( ply.unstuck_lastpos ) <= 5 then
		local spawnarea = ents.FindByClass( "info_player_start" )
		local random_entry = math.random(#spawnarea)
		local newpos = spawnarea[random_entry]:GetPos()

		ply:SetPos(newpos + Vector(0,0,10))
		ply.nextunstuck = CurTime() + 300
		ply:SendMessage("You have been returned to the spawn area.", 60, Color(255, 255, 0, 255))
		SGS_Log( ply:Nick() .. " used the unstuck command." )
	else
		ply:SendMessage("You moved, unstuck teleportation cancelled.", 60, Color(255, 100, 0, 255))
	end
	ply.unstuck_lastpos = nil
end

function SGS_SetSign(ply, _, args)
	local line1 = args[1]
	local line2 = args[2]
	local line3 = args[3]
	local line4 = args[4]
	local line5 = args[5]
	local eid = args[6]

	local ent = ents.GetByIndex(eid)

	ent:SetNWString("line1", args[1])
	ent:SetNWString("line2", args[2])
	ent:SetNWString("line3", args[3])
	ent:SetNWString("line4", args[4])
	ent:SetNWString("line5", args[5])
end
concommand.Add( "sgs_setsign", SGS_SetSign )

function SGS_ChatUnStick( ply, text, public )

    if (string.sub(string.lower(text), 1, 8) == "!unstuck") then
		ply:ConCommand("sgs_unstuck")
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatUnStick", SGS_ChatUnStick )

function GM:CanPlayerSuicide( ply )
	ply:SendMessage("Suicide is not allowed. Use !unstuck instead.", 60, Color(255, 0, 0, 255))
	return false
end

function GM:PlayerSwitchFlashlight(ply, SwitchOn)

	if ply:GetEquippedHat() == "mininghat" then
		if SwitchOn then
			return true
		else
			return false
		end
	else
		if not SwitchOn then
			return true
		else
			return false
		end
	end

end

function GM:PlayerSpray(ply)
	return true
end

function SGS_PlaySound(ply)

	if ply.ps == true then
		ply:EmitSound(ply.stable[math.random(#ply.stable)], 30, 90)

	end
	timer.Simple(1, function() SGS_PlaySound(ply) end)

end

function SGS_ConAFK( ply, _, _ )

	if ply.inprocess == true and ply.afk == false then
		ply:SendMessage("Can't go AFK while performing a task.", 60, Color(255, 0, 0, 255))
		return
	end

	if ply.afk then
		if CurTime() < ply.lastafk + 10 then
			ply:SendMessage("You must wait " .. math.floor((ply.lastafk - CurTime())+10) .. " second(s) before coming out of AFK.", 60, Color(255, 0, 0, 255))
			return
		end
		ply.afk = false
		ply.botcount = 0
		ply:SetNWString("action", "Idle")
		ply:SetNWBool( "afk", false )
		ply.inprocess = false
		ply:Freeze( false )
		for _, v in pairs( player.GetAll() ) do
			v:SendMessage("" .. ply:Nick() .. " is no longer AFK", 60, Color(0, 255, 255, 255))
		end
		ply:SendLua("SGS_DisplayAFK(false)")
		SGS_Log( ply:Nick() .. " is back from being AFK." )
		ply:SetFrags( ply:GetLevel( "survival" ) )


		ply:SetMoveType( MOVETYPE_WALK )
		return
	else
		if ply.inprocess == true then
			ply:SendMessage("Can't go AFK while performing a task.", 60, Color(255, 0, 0, 255))
			return
		end
		if CurTime() < ply.lastafk + 60 then
			ply:SendMessage("You must wait " .. math.floor((ply.lastafk - CurTime())+60) .. " second(s) before going afk again.", 60, Color(255, 0, 0, 255))
			return
		end
		SGS_SetAFK(ply)

		return
	end

end
concommand.Add( "sgs_afk", SGS_ConAFK )

function PlayerMeta:TogglePVP()

	if self.inpvp then
		if GAMEMODE.Worlds:GetEntityWorldSpace( self ).pvp then
			self:SendMessage("You can't toggle off PVP while on this world.", 60, Color(255, 0, 0, 255))
			return
		end
		if ( self.lastpvp + 300 ) > CurTime() then
			if math.floor( ( ( self.lastpvp + 300 ) - CurTime() ) / 60 ) > 0 then
				self:SendMessage("You must wait " .. math.floor( ( ( self.lastpvp + 300 ) - CurTime() ) / 60) .. " more minutes before coming out of PvP.", 60, Color(255, 0, 0, 255))
			else
				self:SendMessage("You must wait " .. math.floor( ( self.lastpvp + 300 ) - CurTime() ) .. " more seconds before coming out of PvP.", 60, Color(255, 0, 0, 255))
			end
			return
		end
		self.inpvp = false
		self:SetNWBool("inpvp", false)
		self:SendMessage("You are no longer flagged for PvP.", 60, Color(255, 255, 0, 255))
	else
		self.inpvp = true
		self:SetNWBool("inpvp", true)
		self:SendMessage("You are now flagged for PvP.", 60, Color(255, 255, 0, 255))
		self.lastpvp = CurTime()
	end

end

function SGS_TogglePvP( ply, _, _ )

	ply:TogglePVP()

end
concommand.Add( "sgs_togglepvp", SGS_TogglePvP )

hook.Add("SGSPlayerChangedWorld", "EnterPvPWorld", function( ply, world )
	if not world.pvp then
		if timer.Exists("pvpworld_" .. tostring(ply:GetPlayerID())) then timer.Remove("pvpworld_" .. tostring(ply:GetPlayerID())) end
		return
	end
	if ply.inpvp then ply.lastpvp = CurTime() return end
	if not ply.inpvp then
		ply:SendMessage("You will be placed in PVP in 30 seconds.", 60, Color(255, 0, 0, 255))
		ply:SendMessage("You have entered a PVP world..", 60, Color(255, 0, 0, 255))
		if timer.Exists("pvpworld_" .. tostring(ply:GetPlayerID())) then timer.Remove("pvpworld_" .. tostring(ply:GetPlayerID())) end
		timer.Create( "pvpworld_" .. tostring(ply:GetPlayerID()), 30, 1, function() SGS_FlagPVPWorld( ply ) end )
	end
end )

hook.Add( "SGSPlayerChangedWorld", "ChangeWorldNegateFallDamage", function( ply, world )
	if IsValid( ply ) then
		ply.last_world_change = CurTime()
	end
end )

hook.Add( "SGSPlayerChangedWorld", "StopTheDamnStargateFromThrowingYou", function( ply, world )
	--if ply:GetMoveType() == MOVETYPE_NOCLIP then return end
	ply:SetVelocity( ply:GetVelocity() * -0.9 )
	timer.Simple( 0.1, function() if IsValid(ply) then ply:SetPos( ply:GetPos() + Vector(0,0,10) ) end end )
end )

function SGS_FlagPVPWorld( ply )
	if not IsValid(ply) then return end
	if not GAMEMODE.Worlds:GetEntityWorldSpace( ply ) then return end
	if not GAMEMODE.Worlds:GetEntityWorldSpace( ply ).pvp then return end
	if ply.inpvp then return end

	ply:TogglePVP()
end

function SGS_ChatTogglePvP( ply, text, public )

    if (string.sub(string.lower(text), 1, 4) == "!pvp") then
		ply:TogglePVP()
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatTogglePvP", SGS_ChatTogglePvP )

function SGS_SetAFK(ply)

	if ply:GetGroundEntity() == NULL and not ply:InVehicle() then
		ply:SendMessage("You can't go afk while falling/flying.", 60, Color(255, 0, 0, 255))
		return
	end

	ply.afk = true
	ply:SetNWString("action", "AFK")
	ply:SetNWBool("afk", true)
	ply.inprocess = true
	ply:Freeze( true )
	ply.lastafk = CurTime()
	for _, v in pairs( player.GetAll() ) do
		v:SendMessage("" .. ply:Nick() .. " is now AFK", 60, Color(0, 255, 255, 255))
	end
	ply:SendMessage("Max AFK time is 10 minutes if the server is full.", 60, Color(255, 0, 0, 255))
	SGS_Log( ply:Nick() .. " went AFK." )

	ply:SetFrags( -1 )

	ply:SetMoveType( MOVETYPE_NOCLIP )


	ply:SendLua("SGS_AFKTime(1)")
	ply:SendLua("SGS_DisplayAFK(true)")
end

function SGS_TriggerBotting( ply )

	ply.afk = true
	ply:SetNWString("action", "AFK")
	ply:SetNWBool("afk", true)
	ply.inprocess = true
	ply.lastafk = CurTime()
	for _, v in pairs( player.GetAll() ) do
		v:SendMessage("" .. ply:Nick() .. " was flagged for botting.", 60, Color(0, 255, 255, 255))
	end
	SGS_Log( ply:Nick() .. " was flagged for botting." )
	ply:SetFrags( -1 )
	ply:SetMoveType( MOVETYPE_NOCLIP )

	ply:SendLua("SGS_AFKTime(1)")
	ply:SendLua("SGS_DisplayAFK(true)")
end

function GM:Move( ply, mv, cmd )
	if ply:GetNWBool("afk", false) then
		return true
	end
end

function PlayerMeta:IsAFK()
	return self.afk
end

function SGS_AFKLength(ply)
	if !ply.afk then return end

	return math.ceil(( CurTime() - ply.lastafk ) / 60)
end

function SGS_CheckAFKKick()
	if #player.GetAll() < game.MaxPlayers() then
		for k, v in pairs(player.GetAll()) do
			if v.afk then
				v:SendLua("SGS_AFKTime(" .. SGS_AFKLength(v) .. ")")
				if SGS_AFKLength(v) >= 10 then
					v:SendMessage("You will be kicked if the server fills up.", 60, Color(255, 0, 0, 255))
					v:SendMessage("You have been afk for " .. SGS_AFKLength(v) .. " minutes.", 60, Color(255, 0, 0, 255))
				end
			end
		end
		return
	end


	for k, v in pairs(player.GetAll()) do
		if v.afk then
			v:SendLua("SGS_AFKTime(" .. SGS_AFKLength(v) .. ")")
			if SGS_AFKLength(v) >= 10 then
				v:SaveCharacter()
				v:Kick("AFK only allowed for 10 minutes when server is full")
			end
		end
	end
end
timer.Create( "SGS_CheckAFKKick", 60, 0, SGS_CheckAFKKick )

function SGS_CheckDeadAFK()

	for k, v in pairs(player.GetAll()) do
		if v.afk then continue end
		if v:Alive() then
			v.deadcounter = 0
		else
			v.deadcounter = v.deadcounter + 1
		end

		if v.deadcounter >= 3 then
			SGS_SetAFK(v)
			SGS_Log( v:Nick() .. " was set AFK for being dead." )
			v.deadcounter = 0
		end
	end

end
timer.Create( "SGS_CheckDeadAFK", 60, 0, SGS_CheckDeadAFK )

function SGS_ChatAFK( ply, text, public )

    if (string.sub(string.lower(text), 1, 4) == "!afk") then
		SGS_ConAFK( ply, _, _ )
		return false
    end

    if (string.sub(string.lower(text), 1, 4) == "!afl") then
		SGS_ConAFK( ply, _, _ )
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatAFK", SGS_ChatAFK )

function SGS_PhysUnfreeze( ply, ent, phys )
		ply:SendMessage("You are not allowed to activate physics on this object.", 60, Color(0, 255, 255, 255))
		return false --don't let them unfreeze it
end
hook.Add( "CanPlayerUnfreeze", "SGS_PhysUnfreeze", SGS_PhysUnfreeze )

function SGS_CancelProcess( ply, _, _ )
	if not ply.inprocess then return end
	if ply.passedout then return end
	if ply.afk then return true end

	ply.inprocess = false
	ply:SetNWString("action", "Idle")
	ply:Freeze( false )
	SGS_StopTimer( ply )
	ply.sleeping = false
	ply.ps = false
	if ply.sound then
		ply.sound:Stop()
	end
	timer.Destroy(ply:UniqueID() .. "processtimer")

	ply:ScreenFade( SCREENFADE.PURGE, Color(0,0,0), 0, 0 )
	RDRemoveRagdollEntity( ply )
	ply:SetNoDraw( false )

	if ply.processtype == "build" then
		if IsValid(ply.buildent) then ply.buildent:Remove() end
	end
	ply:SendMessage("Action Cancelled.", 60, Color(255, 255, 128, 255))
	
	timer.Simple(0.5, function()
	ply:SendPropCount()
	ply:SendStructureCount()
	end )

end
concommand.Add( "sgs_cancel", SGS_CancelProcess )

hook.Add("SGSPlayerChangedWorld", "LogWorldChanges", function( ply, world )
	SGS_Log( ply:Nick() .. " entered world: " .. world.Name )
end )

function SGS_PlayerDisconnected( ply )
	if IsValid( ply.buildent ) then ply.buildent:Remove() end

	timer.Simple( 1, function()
		GAMEMODE.Worlds:CheckEmptyWorlds()
		for k, v in pairs(GAMEMODE.Worlds.tblWorlds) do
			if v.loaded and not v.occupied then
				SGS_ClearWorld( k )
			end
		end
	end )
end
hook.Add( "PlayerDisconnected", "SGS_PlayerDisconnected", SGS_PlayerDisconnected )

function SGS_ChatCancel( ply, text, public )

    if (string.sub(string.lower(text), 1, 7) == "!cancel") then
		SGS_CancelProcess(ply, _, _)
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatCancel", SGS_ChatCancel )

function SGS_ForageToggle( ply, _, _ )

	if ply.foragetoggle then
		ply:SendMessage("Use Key Gathering is now: ON.", 60, Color(255, 255, 128, 255))
		ply.foragetoggle = false
		ply:SetSetting( "foragetoggle", false )
	else
		ply:SendMessage("Use Key Gathering is now: OFF.", 60, Color(255, 255, 128, 255))
		ply.foragetoggle = true
		ply:SetSetting( "foragetoggle", true )
	end

end
concommand.Add( "sgs_foragetoggle", SGS_ForageToggle )

function SGS_ChatForageToggle( ply, text, public )

    if (string.sub(string.lower(text), 1, 13) == "!foragetoggle") then
		SGS_ForageToggle(ply, _, _)
		return false
    end

    if (string.sub(string.lower(text), 1, 3) == "!ft") then
		SGS_ForageToggle(ply, _, _)
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatForageToggle", SGS_ChatForageToggle)

function SGS_ChatSlashBlock( ply, text, public )

    if (string.sub(string.lower(text), 1, 1) == "/") then
		ply:SendMessage("Press F7 for a list of available commands.", 60, Color(255, 255, 128, 255))
		ply:SendMessage("There are no commands in Stranded that start with /.", 60, Color(255, 255, 128, 255))
		ply:SendLua( "SGS_PlayErrorSound(false)" )
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatSlashBlock", SGS_ChatSlashBlock)


function GM:ShowSpare1(ply) --Open Tribes Menu

	if not (ply:GetInitialized() == INITSTATE_OK) then return end
	if CurTime() <= ply.nexttog then return end
	net.Start( "tribes_sv_openmenu" )
	net.Send( ply )

	ply.nexttog = CurTime() + 0.25

end

function GM:ShowTeam( ply )  --Toggle HotBar

	if not (ply:GetInitialized() == INITSTATE_OK) then return end
	if CurTime() <= ply.nexttog then return end

	ply:SendLua("SGS_OpenHotBar()")
	ply.nexttog = CurTime() + 0.25

end

function GM:ShowHelp( ply )  --Toggle Levels

	if not (ply:GetInitialized() == INITSTATE_OK) then return end
	if CurTime() <= ply.nexttog then return end

	ply:SendLua("SGS_ToggleLevelsCL()")
	ply.nexttog = CurTime() + 0.25

end

function GM:ShowSpare2( ply )  --Toggle Side Inventory

	if not (ply:GetInitialized() == INITSTATE_OK) then return end
	if CurTime() <= ply.nexttog then return end

	ply:SendLua("SGS_OpenSideInventory()")
	ply.nexttog = CurTime() + 0.25

end

function PlayerMeta:FoundRelic()

	local rlvl = "1"
	local rlvlchance = math.random(1,10)

	if rlvlchance > 6 and rlvlchance <= 9 then
		rlvl = "2"
	elseif rlvlchance > 9 then
		rlvl = "3"
	end

	local rtypenum = math.random(1,10)

	local rtype = SGS.skills[rtypenum]

	local rname = rtype .. "_relic_" ..rlvl

	self:SendMessage("You found a Level " .. rlvl .. " " .. Cap(rtype) .. " relic!!", 60, Color(0, 255, 100, 255))
	self:AddResource( rname, 1 )

end

function PlayerMeta:FoundArtifact()

	self:SendMessage("You found an Unidentified Artifact!!", 60, Color(0, 255, 100, 255))
	self:AddResource( "unidentified_artifact", 1 )

end

function PlayerMeta:IdentifyArtifact()

	local alvl = "1"
	local alvlchance = math.random(1,10)

	if alvlchance > 8 then
		alvl = "2"
	end

	local atypenum = math.random(1,10)

	local atype = SGS.skills[atypenum]

	local aname = atype .. "_artifact_" ..alvl

	self:SendMessage("You found a Level " .. alvl .. " " .. Cap(atype) .. " artifact!!", 60, Color(0, 255, 100, 255))
	self:AddResource( aname, 1 )

end

function PlayerMeta:FoundEgg()

	local chance = math.random(1,100)

	if chance > 75 and chance <= 95 then
		EggType = "orange"
	elseif chance > 95 then
		EggType = "blue"
	else
		EggType = "brown"
	end

	self:SendMessage("You found a " .. Cap(EggType) .. " Egg!!", 60, Color(0, 255, 100, 255))
	self:AddResource( EggType .. "_pet_egg", 1 )

	self:AddStat( "general15", 1 )

end

function PlayerMeta:FoundGrayEgg()

	self:SendMessage("You found a Gray Egg!!", 60, Color(0, 255, 100, 255))
	self:AddResource( "gray_pet_egg", 1 )
	self:AddStat( "general15", 1 )

end

function PlayerMeta:FoundRedEgg()

	self:SendMessage("You found a Red Egg!!", 60, Color(0, 255, 100, 255))
	self:AddResource( "red_pet_egg", 1 )
	self:AddStat( "general15", 1 )

end

function PlayerMeta:FoundBirdEgg()

	local chance = math.random(1,100)

	if chance > 55 and chance <= 85 then
		EggType = "black"
	elseif chance > 85 then
		EggType = "yellow"
	else
		EggType = "white"
	end

	self:SendMessage("You found a " .. Cap(EggType) .. " Egg!!", 60, Color(0, 255, 100, 255))
	self:AddResource( EggType .. "_pet_egg", 1 )
	self:AddStat( "general15", 1 )

end

function PlayerMeta:FoundGreenEgg()

	self:SendMessage("You found a Green Egg!!", 60, Color(0, 255, 100, 255))
	self:AddResource( "green_pet_egg", 1 )
	self:AddStat( "general15", 1 )

end


/*
ANTI BOTTING
ANTI AFK
SCRIPT
*/

function PlayerMeta:CheckBot()
	--Legacy Function, Don't remove
	return
end

function SGS_CheckBot( ply )
	if not ply.checkbottimethreshold then ply.checkbottimethreshold = 0 end
	if IsValid( ply:GetActiveWeapon() ) and ( string.sub(string.lower( ply:GetActiveWeapon():GetClass() ), 1, 12) == "weapon_melee" ) then
		return
	end

	if IsValid( ply:GetActiveWeapon() ) and not ( ply:GetActiveWeapon():GetClass() == "weapon_physgun" ) then
		ply:ConCommand("-attack")
	end

	ply:ConCommand("-jump")
	ply:ConCommand("-left")
	ply:ConCommand("-right")
	ply:ConCommand("-movedown")
	ply:ConCommand("-moveup")

	local botthreshold = 20

	if (ply:EyeAngles().p == ply.botangle) then
		ply.botcount = ply.botcount + 1
	else
		ply.botcount = 0
		ply.botwarningcount = 0
		ply.botangle = ply:EyeAngles().p
		ply.checkbottimethreshold = CurTime()
		return
	end
	
	if CurTime() < ply.checkbottimethreshold + 8 then
		return
	end
	
	if ply.botcount > botthreshold then
		if ply.botwarningcount == 0 then
			ply:SendMessage("Please move to avoid being flagged.", 60, Color(255, 0, 0, 255))
			ply:SendMessage("Anti-Botting Measure Activated.", 60, Color(255, 0, 0, 255))
			ply:SendLua( "SGS_PlayErrorSound(true)" )
		elseif ply.botwarningcount == 3 then
			ply:SendMessage("SECOND WARNING: Please move to avoid being flagged.", 60, Color(255, 0, 0, 255))
			ply:SendMessage("Anti-Botting Measure Activated.", 60, Color(255, 0, 0, 255))
			ply:SendLua( "SGS_PlayErrorSound(true)" )
		elseif ply.botwarningcount == 6 then
			ply:SendMessage("FINAL WARNING: Please move to avoid being flagged.", 60, Color(255, 0, 0, 255))
			ply:SendMessage("Anti-Botting Measure Activated.", 60, Color(255, 0, 0, 255))
			ply:SendLua( "SGS_PlayErrorSound(true)" )
		elseif ply.botwarningcount >= 9 then
			SGS_TriggerBotting( ply )
		end
		ply.botwarningcount = ply.botwarningcount + 1
	end
end

function SGS_PotionDrink( ply, potion )

	if potion == nil then return end

	/* Health Potions */
	if potion.ptype == "healing" then
		ply:Heal( potion.value )
		ply:SendMessage("The potion heals you for: " .. tostring(potion.value) .. "hp!", 60, Color(0, 255, 0, 255))
		SGS_Potion_HealEffect( ply )
		return
	end

	/* Cure Potions */
	if potion.ptype == "curing" then
		if potion.value == "illness" then
			ply:SendMessage("You are feeling better.", 60, Color(0, 255, 0, 255))
			ply.sick = 0
			ply.settings["melonaids"] = -1
			ply:SendLua("LocalPlayer().melonaids = false")
			return
		end
	end

	/* XP Elixir Potions */
	if potion.ptype == "elixir" then
		ply:SendMessage("You are under the effects of a " .. potion.title .. "!", 60, Color(0, 255, 0, 255))
		ply:UseElixir( potion )
		return
	end

	/* Achievement Potion */
	if potion.ptype == "achievement" then
		ply:DrinkAchievement( potion )
		return
	end

	/* Upgrades Potion */
	if potion.ptype == "upgrade" then
		if potion.uid == "mut" then
			ply:UseMUT()
			return
		end

		if potion.uid == "tribe_upgrade" then
			GAMEMODE.Tribes:UpgradeTribe( ply )
			return
		end
	end

	/* Aid Potions */
	if potion.ptype == "firstaid" then
		if potion.uid == "aid1" then
			ply:Heal( math.floor( ply:GetMaxHealth() * 0.2 ) )
			return
		elseif potion.uid == "aid2" then
			ply:Heal( math.floor( ply:GetMaxHealth() * 0.5 ) )
			return
		elseif potion.uid == "aid3" then
			ply:StopBleeding()
			return
		elseif potion.uid == "aid4" then
			if ply.brokenleg then
				ply:UnbreakLeg()
			else
				ply:SendMessage("The splint had no effect.", 60, Color(0,255,255,255))
			end
			return
		end
	end

end

function PlayerMeta:DrinkAchievement( potion )

	self:SetAch( potion.achievement )

end

function PlayerMeta:UseElixir( potion )
	if potion.value == "speed" and self.brokenleg then
		self:SendMessage("This elixir has no effect with a broken leg.", 60, Color(255,0,0,255))
		return
	end

	if self.peffect == true then
		SGS_StopElixirEffect( self )
	end

	local statboost = potion.value
	local boosttime = potion.time
	local statmod = potion.mod

	self.peffect = true
	self.elixir = statboost
	self.elixirval = statmod

	self:ElixirEffect(statboost)

	if statboost == "speed" then
		self:SetWalkSpeed( self.basewalk * statmod )
		self:SetRunSpeed( self.baserun * statmod )
	end

	if statboost == "gravity" then
		self:SetGravity(0.2)
	end

	if statboost == "luck" then
		self.luck = statmod
	end

	self:SetNWBool( "potionshow", true )
	self:SetNWString( "potiontype", potion.title )
	self:SetNWInt( "potiontime", potion.time )
	self:SetNWInt( "potionendtime", CurTime() + potion.time )
	timer.Create( self:UniqueID() .. "elixirtimer", boosttime, 1, function() SGS_StopElixirEffect( self ) end )

end

function SGS_StopElixirEffect( ply )

	if not IsValid( ply ) then return end
	if not ply:IsConnected() then return end

	ply:SetNWBool( "potionshow", false )

	if ply.peffect == true then
		if ply.elixir == "speed" then
			if ply.brokenleg then
				ply:SetWalkSpeed( 75 )
				ply:SetRunSpeed( 140 )
			else
				ply:SetWalkSpeed( ply.basewalk )
				ply:SetRunSpeed( ply.baserun )
			end
		end
		if ply.elixir == "gravity" then
			ply:SetGravity(1)
		end
		if ply.elixir == "luck" then
			ply.luck = nil
		end

		ply.peffect = false
		ply:SendMessage("The effects of the " .. Cap(ply.elixir) .. " elixir has worn off!", 60, Color(255, 255, 0, 255))
		ply.elixir = "NONE"
		ply.elixirval = 1
		timer.Destroy(ply:UniqueID() .. "elixirtimer")
	end


	if IsValid(ply.trail1) then
		ply.trail1:Remove()
	end
	if IsValid(ply.trail2) then
		ply.trail2:Remove()
	end
	if IsValid(ply.elixent) then
		ply.elixent:Blast()
	end

end


function SGS_ConUnpack( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments. The corrent command is: 'gms_unpack <structure>'.", 60, Color(0, 255, 0, 255))
			return
		end

		if not ply.resource[ args[1] ] then
			ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
			return
		end

		if ply.resource[ args[1] ] <= 0 then
			ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
			return
		end

		for k, v in pairs(SGS.AllowedPackage) do
			if v == args[1] then
				SGS_UnpackStructure_Start(ply, 2, v)
				return
			end
		end
		ply:SendMessage("Something went wrong. You could not unpack that!", 60, Color(255, 0, 0, 255))

end
concommand.Add( "sgs_unpack", SGS_ConUnpack )

birds = { "models/crow.mdl", "models/seagull.mdl", "models/pigeon.mdl" }
function SGS_AdminMode( ply, _, args )
		local birdtype = 1
		if tonumber(args[1]) == 2 then
			birdtype = 2
		elseif tonumber(args[1]) == 3 then
			birdtype = 3
		end

		if !ply:IsAdmin() then
			ply:SendMessage("This command is reserved for administrators!", 60, Color(255, 0, 0, 255))
			return
		end
		if ply.amode then
			ply.amode = false
			ply:SendMessage("Admin Mode Disabled!", 60, Color(255, 0, 0, 255))
			ply:SendLua("SGS.amode = false")
			ply:SetNWBool("adminmode", false)
			ply:SetCrowMode( false )
			GAMEMODE:PlayerSetModel( ply )
			ply:SetWalkSpeed( ply.basewalk )
			ply:SetRunSpeed( ply.baserun )
			ply:SetNoTarget( false )
		else
			if ply:GetGroundEntity() == NULL then
				ply:SendMessage("You can't enter admin mode while falling/flying.", 60, Color(255, 0, 0, 255))
				return
			end
			ply.amode = true
			ply:SendMessage("Admin Mode Enabled!", 60, Color(255, 0, 0, 255))
			ply:ConCommand("SGS_UnEquipTool")
			ply:SendLua("SGS.amode = true")
			ply:SetNWBool("adminmode", true)
			ply:SetCrowMode( true, birds[birdtype] )

			ply:SetWalkSpeed(75)
			ply:SetRunSpeed(140)
			ply:SetNoTarget( true )
		end
end
concommand.Add( "sgs_adminmode", SGS_AdminMode )

function SGS_TOSAccept( ply, _, _ )

	ply.tosaccept = true

end
concommand.Add( "sgs_tosaccept", SGS_TOSAccept )

function SGS_ChatAdminMode( ply, text, _ )

    if (string.sub(string.lower(text), 1, 10) == "!adminmode") then
		SGS_AdminMode(ply)
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatAdminMode", SGS_ChatAdminMode )

function GM:OnPlayerHitGround( ply, bInWater, bOnFloater, flFallSpeed )
	if ply.amode then return end

	if CurTime() < ply.last_world_change + 1 then return end

	
	if flFallSpeed >= 380 and flFallSpeed <= 1000 then
		local dmg = math.abs(( flFallSpeed - 200 ) / 300)
		dmg = math.floor( 30 * dmg )
		local randomizer = math.random(0, 5)
		dmg = dmg + randomizer
		dmg = math.floor(ply:GetMaxHealth() * ( dmg / 100 ))

		if dmg >= ply:Health() then
			ply:AddStat( "general8", 1 )
			for _, v in pairs( player.GetAll() ) do
				v:SendMessage("" .. ply:Nick() .. " took a leap of faith... and died.", 60, Color(255, 0, 0, 255))
			end
			SGS_Log( ply:Nick() .. " fell and died." )
			ply.killstring = "Falling"
			ply:TakeDamage( 10000, game.GetWorld(), game.GetWorld() )
			ply:EmitSound( "physics/body/body_medium_impact_hard" .. math.random(6) .. ".wav", 100, 100, 1, CHAN_BODY )
		else
			ply:ChanceBreakLeg( flFallSpeed )
			local d = DamageInfo()
			d:SetDamage( dmg )
			d:SetAttacker( game.GetWorld() )
			d:SetInflictor( game.GetWorld() )
			d:IsFallDamage( true )
			d:SetDamageType( DMG_FALL ) 
			ply:TakeDamageInfo( d )
			ply:ViewPunch( Angle( -10, 0, 0 ) )
			ply:EmitSound( "physics/body/body_medium_impact_hard" .. math.random(6) .. ".wav", 100, 100, 1, CHAN_BODY )
		end

		return true
	elseif flFallSpeed > 1000 then
		ply.killstring = "Falling"
		ply:TakeDamage( 10000, game.GetWorld(), game.GetWorld() )
		ply:ViewPunch( Angle( -10, 0, 0 ) )
		ply:EmitSound( "physics/body/body_medium_impact_hard" .. math.random(6) .. ".wav", 100, 100, 1, CHAN_BODY )
		ply:ProcessFallDeath()
		return true
	end

end

function PlayerMeta:ProcessFallDeath()
	self:AddStat( "general8", 1 )
	for _, v in pairs( player.GetAll() ) do
		v:SendMessage("" .. self:Nick() .. " took a leap of faith... and died.", 60, Color(255, 0, 0, 255))
	end
	SGS_Log( self:Nick() .. " fell and died." )
end

function PlayerMeta:ChanceBreakLeg( speed )
	if speed < 470 then return end
	if self.brokenleg then return end

	local speed_adj = speed - 470
	local mod = math.floor( ( speed_adj / 170 ) * 5 )
	if mod == 0 then mod = 1 end
	local chance = 10 - mod

	local rnd = math.random( chance )
	if rnd == 1 then
		self:BreakLeg()
	end
end

function PlayerMeta:BreakLeg()
	self:SendMessage("You have broken a leg.", 60, Color(255, 0, 0, 255))
	self:SetWalkSpeed( 75 )
	self:SetRunSpeed( 140 )
	self:SetJumpPower( 80 )
	self.brokenleg = true
	self:SendLua( "LocalPlayer().brokenleg = true" )
end

function PlayerMeta:UnbreakLeg( silent )
	if not silent then
		self:SendMessage("Your broken leg is healed.", 60, Color(0, 200, 0, 255))
	end
	self:SetWalkSpeed( self.basewalk )
	self:SetRunSpeed( self.baserun )
	self:SetJumpPower( 160 )
	self.brokenleg = nil
	self:SendLua( "LocalPlayer().brokenleg = false" )
end

function PlayerMeta:Burn( amt )
	if self.amode then return end
	if amt >= self:Health() then
		for _, v in pairs( player.GetAll() ) do
			v:SendMessage("" .. self:Nick() .. " burned to death.", 60, Color(255, 0, 0, 255))
		end
		SGS_Log( self:Nick() .. " burned to death." )
		self.killstring = "Burned To Death"
		self:SetModel( "models/player/charple.mdl" )
		self:TakeDamage( 10000, game.GetWorld(), game.GetWorld() )
		self:EmitSound( "player/pl_burnpain" .. math.random(3) .. ".wav", 100, 100, 1, CHAN_AUTO )
	else
		self:TakeDamage( amt , game.GetWorld(), game.GetWorld() )
		self:EmitSound( "player/pl_burnpain" .. math.random(3) .. ".wav", 100, 100, 1, CHAN_AUTO )
	end
end

function PlayerMeta:LaserBurn( amt, infl )
	if self.amode then return end
	if amt >= self:Health() then
		for _, v in pairs( player.GetAll() ) do
			v:SendMessage( self:Nick() .. " was vaporized.", 60, Color(255, 0, 0, 255))
		end
		SGS_Log( self:Nick() .. " vaporized to death." )
		self.killstring = "Vaporized by the Hunter"
	end
	
	local dmg = DamageInfo()
	dmg:SetDamageType( DMG_DISSOLVE )
	dmg:SetDamage( amt )
	
	dmg:SetAttacker(game.GetWorld())
	dmg:SetInflictor(game.GetWorld())
	self:TakeDamageInfo(dmg)
end

function SGS_ChatOpenHelp( ply, text, _ )

    if (string.sub(string.lower(text), 1, 5) == "!help") then
		ply:SendLua("SGS_OpenHelp()")
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatOpenHelp", SGS_ChatOpenHelp )

function SGS_ChatOpenWiki( ply, text, _ )

    if (string.sub(string.lower(text), 1, 5) == "!wiki") then
		ply:SendLua("SGS_OpenWiki()")
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatOpenWiki", SGS_ChatOpenWiki )

function SGS_SendMessage(ply, message)

	if IsValid(ply) then
		ply:PrintMessage(HUD_PRINTCONSOLE, message)
	else
		ServerLog(message .. "\n")
	end

end

function PlayerMeta:SetAch( ach )

	for k, v in pairs(SGS.Ach) do

		if v.short == ach then

			self.ach[ach] = true
			self:SaveCharacter()
			self:SyncAch()

			GAMEMODE.colorSay(_, { team.GetColor(self:Team()), self:Nick(), Color(255,255,255), " earned the achievement ", Color(255,255,0), v.long } )

			if v.cc then
				self:ConCommand(v.cc)
			end

			if v.at then
				GAMEMODE.colorSay(self, { Color(255,255,255), v.at } )
			end

		end

	end

end

function PlayerMeta:RemoveAch( ach )
	for k, v in pairs(SGS.Ach) do
		if v.short == ach then
			self.ach[ach] = nil
			self:SaveCharacter()
			self:SyncAch()
		end
	end
end

function PlayerMeta:SetAchSilent( ach )

	self.ach[ach] = true
	self:SaveCharacter()
	self:SyncAch()

end

function PlayerMeta:SyncAch()
	net.Start("sgs_syncachievements")
		net.WriteTable( self.ach )
	net.Send( self )
end

function PlayerMeta:GetAch( ach )
	
	if self.ach[ ach ] == nil then return false end
	return self.ach[ ach ]

end

function PlayerMeta:CheckForAchievements( ach )

	if ach == "mininghat" or ach == "all" then
		if not self:GetAch("mininghat") then
			if self:GetStat("mining8") >= 500 then
				self:SetAch("mininghat")
			end
		end
	end
	if ach == "voidcache1" or ach == "all" then
		if not self:GetAch("voidcache1") then
			if self:GetStat("general17") >= 100 then
				self:SetAch("voidcache1")
			end
		end
	end
	if ach == "voidcache2" or ach == "all" then
		if not self:GetAch("voidcache2") then
			if self:GetStat("general18") >= 50 then
				self:SetAch("voidcache2")
			end
		end
	end
	if ach == "zombieslayer" or ach == "all" then
		if not self:GetAch("zombieslayer") then
			if self:GetStat("combat8") >= 1000 then
				self:SetAch("zombieslayer")
			end
		end
	end
	if ach == "bloodchampion" or ach == "all" then
		if not self:GetAch("bloodchampion") then
			if self:GetStat("bloodmoon1") >= 100 then
				self:SetAch("bloodchampion")
			end
		end
	end
	if ach == "fishmaster" or ach == "all" then
		if not self:GetAch("fishmaster") then
			if self:GetStat("fishing1") >= 10000 then
				self:SetAch("fishmaster")
			end
		end
	end
	if ach == "woodcuttingmaster" or ach == "all" then
		if not self:GetAch("woodcuttingmaster") then
			if self:GetStat("woodcutting2") >= 10000 then
				self:SetAch("woodcuttingmaster")
			end
		end
	end
	if ach == "miningmaster" or ach == "all" then
		if not self:GetAch("miningmaster") then
			if self:GetStat("mining7") >= 10000 then
				self:SetAch("miningmaster")
			end
		end
	end
	if ach == "constructionmaster" or ach == "all" then
		if not self:GetAch("constructionmaster") then
			if self:GetStat("construction1") >= 10000 then
				self:SetAch("constructionmaster")
			end
		end
	end
	if ach == "farmingmaster" or ach == "all" then
		if not self:GetAch("farmingmaster") then
			if self:GetStat("farming1") >= 10000 then
				self:SetAch("farmingmaster")
			end
		end
	end
	if ach == "smithingmaster" or ach == "all" then
		if not self:GetAch("smithingmaster") then
			if self:GetStat("smithing2") >= 10000 then
				self:SetAch("smithingmaster")
			end
		end
	end
	if ach == "arcanemaster" or ach == "all" then
		if not self:GetAch("arcanemaster") then
			if self:GetStat("arcane1") >= 10000 then
				self:SetAch("arcanemaster")
			end
		end
	end
	if ach == "alchemymaster" or ach == "all" then
		if not self:GetAch("alchemymaster") then
			if self:GetStat("alchemy4") >= 10000 then
				self:SetAch("alchemymaster")
			end
		end
	end
	if ach == "cookingmaster" or ach == "all" then
		if not self:GetAch("cookingmaster") then
			if self:GetStat("cooking9") >= 10000 then
				self:SetAch("cookingmaster")
			end
		end
	end
	if ach == "farminghat" or ach == "all" then
		if not self:GetAch("farminghat") then
			if self:GetStat("farming3") >= 25 then
				self:SetAch("farminghat")
			end
		end
	end
	if ach == "chefhat" or ach == "all" then
		if not self:GetAch("chefhat") then
			if ( self:GetStat("cooking1") + self:GetStat("cooking2") + self:GetStat("cooking3") + self:GetStat("cooking4") ) >= 2000 then
				self:SetAch("chefhat")
			end
		end
	end
	if ach == "presshat" or ach == "all" then
		if not self:GetAch("presshat") then
			if self:GetStat("general13") >= 10000 then
				self:SetAch("presshat")
			end
		end
	end
	if ach == "wizardhat" or ach == "all" then
		if not self:GetAch("wizardhat") then
			if self:GetStat("arcane3") >= 2500 then
				self:SetAch("wizardhat")
			end
		end
	end
	if ach == "goggleshat" or ach == "all" then
		if not self:GetAch("goggleshat") then
			if self:GetStat("combat7") >= 1 then
				self:SetAch("goggleshat")
			end
		end
	end
	if ach == "squirrelhat" or ach == "all" then
		if not self:GetAch("squirrelhat") then
			if self:GetStat("pets11") >= 30 then
				self:SetAch("squirrelhat")
			end
		end
	end
	if ach == "headcrabhat" or ach == "all" then
		if not self:GetAch("headcrabhat") then
			if self:GetStat("pets1") >= 1 and self:GetStat("pets2") >= 1 and self:GetStat("pets3") >= 1 and self:GetStat("pets4") >= 1 and self:GetStat("pets5") >= 1 and self:GetStat("pets6") >= 1 and self:GetStat("pets7") >= 1 and self:GetStat("pets8") >= 1 and self:GetStat("pets9") >= 1 and self:GetStat("pets10") >= 1 then
				self:SetAch("headcrabhat")
			end
		end
	end
	if ach == "time" or ach == "all" then
		if not self:GetAch("time1") then
			if self:GetStat("time1") >= 60 then
				self:SetAch("time1")
			end
		end
	end
	if ach == "time" or ach == "all" then
		if not self:GetAch("time2") then
			if self:GetStat("time1") >= 600 then
				self:SetAch("time2")
			end
		end
	end
	if ach == "time" or ach == "all" then
		if not self:GetAch("time3") then
			if self:GetStat("time1") >= 3000 then
				self:SetAch("time3")
			end
		end
	end
	if ach == "time" or ach == "all" then
		if not self:GetAch("time4") then
			if self:GetStat("time1") >= 6000 then
				self:SetAch("time4")
			end
		end
	end
	if ach == "time" or ach == "all" then
		if not self:GetAch("time5") then
			if self:GetStat("time1") >= 9000 then
				self:SetAch("time5")
				if not self:IsDonator() then
					if self:GetAch("time5") and ( self:IsUserGroup( "member" ) or self:IsUserGroup( "user" ) ) then
						SGS_SetUpTeams(self)
					end
				end
			end
		end
	end
end

hook.Add( "communityAPIInGroup", "communityAPICheckGroup", function( ply, inGroup)
	if not IsValid( ply ) then return end
	if ply:GetAch("steamgroup") then
		if not inGroup then
			ply:RemoveAch("steamgroup")
			ply:RemoveGToken( 2500, true )
		end
		return
	end
	if inGroup and ply:GetLevel("survival") >= 5 then
		ply:SetAch("steamgroup")
		ply:GiveGTokens( 2500 )
	end
end )

function PlayerMeta:SetSetting( set, val )

	self.settings[ set ] = val

end

function PlayerMeta:GetSetting( set )

	if self.settings[ set ] == nil then return nil end
	return self.settings[ set ]

end

function PlayerMeta:SetSettings()

	local person = self:GetSetting("person")
	local pcolor = self:GetSetting("playercolor")
	local ftoggle = self:GetSetting("foragetoggle")
	local scheck = self:GetSetting("smithcheck")
	local gmcheck = self:GetSetting("grindmode")
	local particles = self:GetSetting("showparticles")
	local lighting = self:GetSetting("showlights")
	local hidefromteam = self:GetSetting("hidefromteam")
	local drawdistance = self:GetSetting("showfar")

	if person then
		self:SendLua( "SGS.person = \"" .. person .. "\"" )
		self.perspective = person
	end

	if pcolor then
		self:SetPlayerColor(pcolor)
	end

	if ftoggle then
		self.foragetoggle = ftoggle
	end

	if scheck then
		self.smithcheck = scheck
	end

	if gmcheck then
		self.grindmode = gmcheck
	end

	if particles then
		self.showparticles = tobool(particles)
		self:SendLua( "SGS.showparticles = " .. particles )
	else
		self.showparticles = true
		self:SendLua( "SGS.showparticles = true" )
	end

	if lighting then
		self.showlights = tobool(lighting)
		self:SendLua( "SGS.showlights = " .. lighting )
	else
		self.showlights = true
		self:SendLua( "SGS.showlights = true" )
	end

	if drawdistance then
		if drawdistance == "true" then
			self:SendLua( "SGS.drawdistance = 360000000" )
			self.showfar = true
		else
			self.showfar = false
		end
	else
		self.showfar = false
	end
		
	if hidefromteam then
		if hidefromteam == "on" then
			self.hidefromteam = "on"
			self:SetSetting( "hidefromteam", "on" )
			self:SetNWBool("hidefromteam", true)
		else
			self.hidefromteam = "off"
			self:SetSetting( "hidefromteam", "off" )
			self:SetNWBool("hidefromteam", false)
		end
	end

end

function PlayerMeta:SetStat( stat, val )

	self.stats[stat] = val

	net.Start("SendStats")
		net.WriteTable( self.stats )
	net.Send( self )

end

function PlayerMeta:GetStat( stat )

	if self.stats[stat] == nil then return 0 end
	return self.stats[stat]

end

function PlayerMeta:AddStat( stat, val )

	if self.stats[stat] == nil then
		self.stats[stat] = 0
	end

	if not val then val = 1 end

	local cv = self.stats[stat]

	self:SetStat( stat,  cv + val )
	--self:CheckForAchievements()

end

function SGS_ConViewOthersStats( ply, com, args )

	if not #args == 1 then return end

	if not GAMEMODE.getUser( args[1] ) then
		ply:SendMessage("No player found with that name.", 60, Color(255, 0, 0, 255))
		return
	end

	local other = GAMEMODE.getUser( args[1] )
	if not other.stats then return end

	net.Start("SendStatsOther")
		net.WriteString( other:Nick() )
		net.WriteTable( other.stats )
	net.Send( ply )

end
concommand.Add( "sgs_viewplayerstats", SGS_ConViewOthersStats )

function ConEquipHat( ply, _, args )

	if not #args == 1 then return end
	if ply:GetAch(args[1]) then
		ply:EquipHat(args[1])
	end

end
concommand.Add("sgs_equiphat", ConEquipHat)

function ConUnequipHat( ply, _, args )

		ply:EquipHat(nil)

end
concommand.Add("sgs_unequiphat", ConUnequipHat)

function SGS_ConSetPlayerColor(ply, _, args)

	if not #args == 3 then return end

	if tonumber(args[1]) == nil then return end
	if tonumber(args[2]) == nil then return end
	if tonumber(args[3]) == nil then return end

	local color = {}
	local r = tonumber(args[1])
	color.r = r / 255
	local g = tonumber(args[2])
	color.g = g / 255
	local b = tonumber(args[3])
	color.b = b / 255

	ply:SetPlayerColor( Vector( math.Clamp(color.r, 0, 1), math.Clamp(color.g, 0, 1), math.Clamp(color.b, 0, 1) ) )
	ply:SetSetting( "playercolor", Vector( math.Clamp(color.r, 0, 1), math.Clamp(color.g, 0, 1), math.Clamp(color.b, 0, 1) ) )


	ply:ConCommand("sgs_refreshmodelpanel")

end
concommand.Add("sgs_setplayercolor", SGS_ConSetPlayerColor)


function SGS_DisownAllItems( ply, _, args )

	for k, v in pairs(ents.GetAll()) do
		if SPropProtection.Props[v:EntIndex()] then
			if SPropProtection.Props[v:EntIndex()].SteamID == ply:SteamID() then
			--if v:CPPIGetOwner() == ply then
				v:CPPISetOwnerless(true)
				v.ownerless = true
				timer.Simple( 180, function() SGS_MarkForDeletionOwnerless( v ) end )
			end
		end
	end
	ply:SendMessage("You have disowned all of your items on the map.", 60, Color(255, 0, 255, 255))

end
concommand.Add("sgs_disownall", SGS_DisownAllItems)

function SGS_DayPhase()

	local minute = math.floor(DayLight.Minute)

	if minute < 300 then
		return "night"
	elseif minute >= 300 and minute < 450 then
		return "dawn"
	elseif minute >= 450 and minute < 1200 then
		return "day"
	elseif minute >= 1200 and minute < 1290 then
		return "dusk"
	else
		return "night"
	end

end

function PlayerMeta:HasTool( tool )

	if not self.inventory then return false end

	for k, v in pairs(self.inventory) do
		if v == tool then
			return true
		end
	end

	if self:GetActiveWeapon() ~= NULL then
		if self:GetActiveWeapon():GetClass() == tool then
			return true
		end
	end

	return false
end

function PlayerMeta:HasToolInventory( tool )

	if not self.inventory then return false end

	for k, v in pairs(self.inventory) do
		if v == tool then
			return true
		end
	end

	return false
end

function GM:PlayerSwitchWeapon( self, oldwep, newwep )
	return false
end

function SGS_FireworkShow( ply, _, args )

	if not ply:IsAdmin() then return end

	local fwtable = {"gms_firework_red", "gms_firework_green", "gms_firework_blue", "gms_firework_purple", "gms_firework_cyan", "gms_firework_yellow", "gms_firework_white", "gms_firework_rainbow" }
	local ft = 2

	for k, v in pairs(ents.FindInSphere(ply:GetPos(), 1000)) do
		local fw = v:GetClass()
		for k2, v2 in pairs(fwtable) do
			if v2 == fw then
				ft = ft + math.random(0.2, 1.4)
				v.FuseTime = (ft)
				v:StartFuse()
			end
		end
	end


end
concommand.Add("sgs_fireworkshow", SGS_FireworkShow)

function SGS_FireworkShow2( ply, _, args )

    if not ply:IsAdmin() then return end

    local fwtable = {"gms_firework_red", "gms_firework_green", "gms_firework_blue", "gms_firework_purple", "gms_firework_cyan", "gms_firework_yellow", "gms_firework_white", "gms_firework_rainbow" }
    local ft = 2
    local count = tonumber(args[1]) or 20
    local radius = tonumber(args[2]) or 450

    for i=1, count do
        local firework = ents.Create(table.Random(fwtable))

        local ang, dist = math.Rand(0, math.pi * 2), math.Rand(0, 1)
        local pos = ply:GetPos() + Vector(
            math.sqrt(dist) * math.cos(ang) * radius,
            math.sqrt(dist) * math.sin(ang) * radius,
            100
        )

        local trace = util.TraceLine({
            start=pos,
            endpos=pos - Vector(0, 0, 16384),
            filter=ply
        })

        firework:SetPos(trace.HitPos + Vector(0, 0, 20))
        firework:Spawn()
        firework:Activate()

        ft = ft + math.random(0.2, 1.4)
        firework.FuseTime = ft
        firework:StartFuse()
    end


end
concommand.Add("sgs_fireworkshow2", SGS_FireworkShow2)

function SGS_Roll( ply, text, public )
	if ( string.sub( string.lower(text), 1, 5 ) == "!roll" ) then
		if ply:Team() == 10000 then
			ply:SendMessage("This is only available to tribes.", 60, Color(255, 0, 0, 255))
			return false
		end

		local args = string.Explode(" ", text)
		local roll_num = 100
		if not tonumber( args[2] ) then
			roll_num = 100
		else
			roll_num = tonumber( args[2] )
		end

		local roll_return = math.random( roll_num )
		ply:PrintMessage( HUD_PRINTTALK, "You rolled: " .. roll_return .. " (" .. roll_num .. ")" )
		SGS_Log( ply:Nick() .. " has used the roll command. (" .. roll_return .. "/" .. roll_num .. ")" )
		for k, v in pairs( GAMEMODE.Tribes:GetOnlineClanMates( ply ) ) do
			v:PrintMessage( HUD_PRINTTALK, ply:Nick() .. " rolled: " .. roll_return .. " (" .. roll_num .. ")" )
		end
		return false
	end
end
hook.Add( "PlayerSay", "SGS_Roll", SGS_Roll )

function SGS_GiveGToken( ply, com, args )

	if not IsValid( ply ) then
		SGS_ConsoleGiveTokens( args )
		return
	end

	if not #args == 2 then
		ply:SendMessage("Not enough parameters.", 60, Color(255, 0, 0, 255))
		return
	end

	if tonumber(args[2]) == nil then
		ply:SendMessage("Invalid value.", 60, Color(255, 0, 0, 255))
		return
	end

	local amt = math.ceil(tonumber(args[2]))

	if amt == nil then
		ply:SendMessage("The value parameter must be a positive number.", 60, Color(255, 0, 0, 255))
		return
	end

	if amt <= 0 then
		ply:SendMessage("The value parameter must be a positive number.", 60, Color(255, 0, 0, 255))
		return
	end

	if not GAMEMODE.getUser( args[1] ) then
		ply:SendMessage("No player found with that name.", 60, Color(255, 0, 0, 255))
		return
	end

	local ply2 = GAMEMODE.getUser( args[1] )

	if ply:GTokens() < amt then
		ply:SendMessage("You do not have enough GTokens.", 60, Color(255, 0, 0, 255))
		return
	end

	if ply == ply2 then
		ply:SendMessage("You can't give GTokens to yourself!", 60, Color(255, 0, 0, 255))
		return
	end

	if tostring(tonumber(amt)) == tostring(tonumber("nan")) then
		SGS_Log( "!!!!!!!!!!!" .. ply:Nick() .. " is trying to 'nan' dupe an item.")
		ply:SendMessage("This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
		return false
	end

	ply:SendMessage("You gave (" .. tostring(amt) .. ") GTokens to " .. ply2:Nick() .. "!", 60, Color(255, 0, 0, 255))
	ply2:SendMessage("You received (" .. tostring(amt) .. ") GTokens from " .. ply:Nick() .. "!", 60, Color(255, 0, 0, 255))

	SGS.Log("** " .. ply:Nick() .. " gave " .. amt .. "x GTokens to " .. ply2:Nick() .. "!")

	ply:RemoveGToken( amt )
	ply2:GiveGTokens( amt )

	ply:SaveCharacter()
	ply2:SaveCharacter()

end
concommand.Add("sgs_givegtoken", SGS_GiveGToken )

function SGS_ConsoleGiveTokens( args )


	if not #args == 2 then
		SGS_SendMessage(_, "Not enough parameters.")
		return
	end

	local amt = math.ceil(tonumber(args[2]))

	if amt == nil then
		SGS_SendMessage(_, "The value parameter must be a positive number.")
		return
	end

	if amt <= 0 then
		SGS_SendMessage(_, "The value parameter must be a positive number.")
		return
	end

	if not GAMEMODE.getUser( args[1] ) then
		SGS_SendMessage(_, "No player found with that name.")
		return
	end

	local ply = GAMEMODE.getUser( args[1] )

	if tostring(tonumber(amt)) == tostring(tonumber("nan")) then
		return false
	end



	ply:SendMessage("You received (" .. tostring(amt) .. ") GTokens from the Server!", 60, Color(255, 0, 0, 255))
	SGS.Log("** " .. ply:Nick() .. " was given " .. amt .. "x GTokens from the console!")

	ply:GiveGTokens( amt )
	ply:SaveCharacter()

end

function SGS_ChatGiveGToken( ply, text, public )

    if ( string.sub( string.lower(text), 1, 10 ) == "!givetoken" ) then
		local args = string.Explode(" ", text)
		if args[2] == nil or args[3] == nil then
			ply:SendMessage("Wrong number of arguments. !givetoken <player> <amount>.", 60, Color(0, 255, 0, 255))
			return false
		end

		if tostring(tonumber(args[3])) == tostring(tonumber("nan")) then
			SGS_Log( "!!!!!!!!!!!" .. ply:Nick() .. " is trying to 'nan' dupe an item.")
			ply:SendMessage("This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
			return false
		end

        SGS_GiveGToken( ply, _, { args[2], args[3] } )
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatGiveGToken", SGS_ChatGiveGToken )

function SGS_IsRootAdmin( ply )

	if not IsValid( ply ) then return true end

	if ply:IsSuperAdmin() then return true end

	return false

end

function SGS_Log( txt )
	ServerLog( "****SGS**** " .. txt .. "\n" )
end

function SGS_GrowUpPlant( plant )

	if not IsValid( plant ) then return end

	newsize = plant.size + 0.02
	plant.size = newsize
	plant:SetModelScale( newsize, 0 )

	if newsize < 1 then
	else
		timer.Destroy( tostring(plant:EntIndex()) .. "_growthtimer" )
		plant:SpawnFruit()
	end

end

function SGS_ConBuyHat( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(0, 255, 0, 255))
			return
		end

		if not SGS_ReverseHatLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(0, 255, 0, 255))
			return
		end

        ply:BuyHat( SGS_ReverseHatLookup( args[1] ) )


end
concommand.Add( "sgs_buyhat", SGS_ConBuyHat )

function SGS_ConBuyHat2( ply, com, args )

		if #args > 1 then
			ply:SendMessage("Too many arguments.", 60, Color(0, 255, 0, 255))
			return
		end

		if not SGS_ReverseHatLookup( args[1] ) then
			ply:SendMessage("Invalid item!", 60, Color(0, 255, 0, 255))
			return
		end

		if ply:GetResource( "hat_token" ) <= 0 then
			ply:SendMessage("You don't have any Hat Tokens.", 60, Color(0, 255, 0, 255))
			return
		end

		if SGS_ReverseHatLookup( args[1] ).price > 1500 then
			ply:SendMessage("Hat tokens can only be used on hats worth 1500 or less.", 60, Color(0, 255, 0, 255))
			return
		end


        ply:BuyHat2( SGS_ReverseHatLookup( args[1] ) )


end
concommand.Add( "sgs_buyhattoken", SGS_ConBuyHat2 )

function PlayerMeta:BuyHat( item )

	local can = true

	if (self:GTokens() or 0) < item.price then
		can = false
		self:SendMessage("Insufficient GTokens.", 60, Color(255, 0, 0, 255))
		return
	end

	if self:GetAch( item.ach ) then
		can = false
		self:SendMessage("You already own this hat.", 60, Color(255, 0, 0, 255))
		return
	end

	if can then
		self:RemoveGToken( item.price )
		self:SetAchSilent( item.ach )
		self:EquipHat( item.ach )
		self:SendMessage("You bought the " .. item.name .. ".", 60, Color(0, 255, 0, 255))
	end

end

function PlayerMeta:BuyHat2( item )

	local can = true

	if self:GetAch( item.ach ) then
		can = false
		self:SendMessage("You already own this hat.", 60, Color(255, 0, 0, 255))
		return
	end

	if can then
		self:SubResource( "hat_token", 1 )
		self:SetAchSilent( item.ach )
		self:EquipHat( item.ach )
		self:SendMessage("You bought the " .. item.name .. ".", 60, Color(0, 255, 0, 255))
	end

end

function SGS_ReverseHatLookup( tEnt )

	for k, v in pairs( SGS.HatShop ) do
		for k2, v2 in pairs( SGS.HatShop[k] ) do
			if v2.ach == tEnt then
				return v2
			end
		end
	end

	return nil

end

function SGS_MarkForDeletionOwnerless( ent )

	if not IsValid( ent ) then return end
	if not ent.ownerless then return end

	if ent.ownerless == true then
		SGS.Log("**" .. ent:GetClass() .. " was deleted for being unowned for 3 minutes!")
		SafeRemoveEntity( ent )
	end

end

function SGS_BroadcastTreeTable( ply )

	for k, v in pairs( SGS.trees ) do
		if not IsValid(k) then k = nil end
	end

	net.Start( "sgs_treetable" )
		net.WriteTable( SGS.trees )
	if ply then
		net.Send( ply )
	else
		net.Broadcast()
	end

end

function SGS_BroadcastLockedPropsTable( ply )

	net.Start( "sgs_lockedpropstable" )
		net.WriteTable( SGS.lockedprops )
	if ply then
		net.Send( ply )
	else
		net.Broadcast()
	end

end

hook.Add( "PlayerInitialSpawn", "sendeffects", function( ply )
	for _, ent in ipairs( ents.GetAll() ) do
		if ent.StartEffects then
			ent:StartEffects( ply )
		end
	end
end )

hook.Add( "PlayerInitialSpawn", "claimcaches", function( ply )
	for _, ent in pairs( ents.GetAll() ) do
		if ent.pcache then
			if ply:GetPlayerID() == ent.POwner64 then
				ent:CacheEnable( ply )
			end
		end
		if ent:GetClass() == "gms_tribecache" then
			if ply:GetPlayerID() == ent.POwner64 then
				ent.owner = ply
				ply.tribecacheent = ent
			end
		end
	end
end )

concommand.Add('uptime', function(ply)
    local str = string.format(
        '%d:%02d:%02d',
        math.floor(CurTime() / 3600),
        math.floor(CurTime() % 3600 / 60),
        math.floor(CurTime() % 3600 % 60)
    )

    if IsValid( ply ) then
        -- TODO
    else
        print('Uptime: '..str)
    end
end)

concommand.Add('ent_report', function(ply)
    if IsValid(ply) and not ply:IsAdmin() then return end

    local keyed = {}
    local sorted = {}

    for _, ent in ipairs(ents.GetAll()) do
        local c = ent:GetClass()

        local tbl = keyed[c]
        if not tbl then
            tbl = {class=c, count=0}
            keyed[c] = tbl
            table.insert(sorted, tbl)
        end

        keyed[c].count = keyed[c].count + 1
    end

    table.sort(sorted, function(a,b)
        if a.count == b.count then
            return a.class < b.class
        end
        return a.count > b.count
    end)

    for _, v in ipairs(sorted) do
        print(string.format('%-30s = %d', v.class, v.count))
    end
end)

function SGS_IsChristmasEvent()
	if tonumber(os.date("%m")) == 12 and tonumber(os.date("%d")) >= 24 and tonumber(os.date("%d")) <= 26 then return true end
	return false
end

function PlayerMeta:TimeCountUp()
	if not self:IsValid() then return end

	if self.tosaccept then
		if not self.sessiontime then self.sessiontime = 0 end
		if not self.afktime then self.afktime = 0 end

		if self:IsAFK() then
			self.afktime = self.afktime + 1
			self:AddStat("time2")
		else
			self.sessiontime = self.sessiontime + 1
			self:AddStat("time1")
			self:CheckForAchievements( "time" )
		end
	end

	timer.Simple( 60, function() self:TimeCountUp() end )

end

--[[---------------------------------------------------------
   Name: gamemode:PlayerCanSeePlayersChat()
		Can this player see the other player's chat?
-----------------------------------------------------------]]
function GM:PlayerCanSeePlayersChat( strText, bTeamOnly, pListener, pSpeaker )

	if ( bTeamOnly ) then
		local p1_tribe = pListener.tribe or 0
		local p2_tribe = pSpeaker.tribe or 0

		if ( !IsValid( pSpeaker ) || !IsValid( pListener ) ) then return false end
		if ( p1_tribe != p2_tribe ) then return false end
	end

	return true

end


local oldCommandRun = _G.concommand.Run
function _G.concommand.Run( pPlayer, strCmd, tblArgs, ... )
    for _, v in pairs( tblArgs ) do
        if tostring( v ):lower() == "nan" then
            SGS_Log( "!!!!!!!!!!!" .. pPlayer:Nick() .. " is trying to 'nan' dupe an item.")
			pPlayer:SendMessage("(Minge) This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
            return false
        end
    end

    return oldCommandRun( pPlayer, strCmd, tblArgs, ... )
end

function PlayerMeta:CurrentPropCount()
	local c = 0
	for k, v in pairs( SPropProtection.Props ) do
		if v.SteamID64 == self:GetPlayerID() and ( v.Ent:GetClass() == "gms_prop" or v.Ent:GetClass() == "prop_vehicle_prisoner_pod" ) then
			c = c + 1
		end
	end
	return c
end

function PlayerMeta:CurrentStructureCount()
	local c = 0
	for k, v in pairs( SPropProtection.Props ) do
		if v.SteamID64 == self:GetPlayerID() then
			if table.HasValue( SGS.AllowedPackage, v.Ent:GetClass() ) then
				c = c + 1
			end
		end
	end
	return c
end

function PlayerMeta:SendPropCount()
	net.Start("sgs_sendpropcount")
	net.WriteInt( self:CurrentPropCount(), 16 )
	net.Send( self )
end

function PlayerMeta:SendStructureCount()
	net.Start("sgs_sendstructurecount")
	net.WriteInt( self:CurrentStructureCount(), 16 )
	net.Send( self )
end

function PlayerMeta:CurrentEntityCount()
	local c = 0
	for k, v in pairs( SPropProtection.Props ) do
		if v.SteamID64 == self:GetPlayerID() and v.Ent:GetClass() ~= "gms_prop" then
			c = c + 1
		end
	end
	return c
end

function PlayerMeta:CanBuildProp()
	local curP = self:CurrentPropCount()
	local maxP = self:GetMaxProps()

	if curP >= maxP then return false end
	return true
end

function PlayerMeta:CanBuildStructure()
	local curS = self:CurrentStructureCount()
	local maxS = self:GetMaxStructures()

	if curS >= maxS then return false end
	return true
end

function PlayerMeta:GetMaxProps()
	local maxP = SGS.maxguestprops
	if self:IsMember() then maxP = SGS.maxmemberprops end
	if self:IsDonator() then maxP = SGS.maxdonatorprops end
	return maxP
end

function PlayerMeta:GetMaxStructures()
	local maxS = SGS.maxgueststructures
	if self:IsMember() then maxS = SGS.maxmemberstructures end
	if self:IsDonator() then maxS = SGS.maxdonatorstructures end
	return maxS
end

function SGS_PropCount( sid )
	local c = 0
	for k, v in pairs( SPropProtection.Props ) do
		if v.SteamID64 == sid and v.Ent:GetClass() == "gms_prop" then
			c = c + 1
		end
	end
	return c
end

function SGS_EntityCount( sid )
	local c = 0
	for k, v in pairs( SPropProtection.Props ) do
		if v.SteamID64 == sid and v.Ent:GetClass() ~= "gms_prop" then
			c = c + 1
		end
	end
	return c
end

function SGS_SpawnMeteor()
	for k, v in pairs( ents.FindByClass( "gms_meteornode" ) ) do
		v:Remove()
	end

	local world = ChooseWorld()
	local coords = FindGoodSpot( world )

	if not coords then
		SGS_SpawnMeteor()
		return
	end

	local meteor = ents.Create( "gms_meteornode" )
	meteor:SetPos( coords )
	meteor:Spawn()
	meteor:SetNetworkedString("Owner", "World")
	meteor:EmitSound( "ambient/explosions/exp1.wav", 300, 90, 1, CHAN_AUTO )

	local meteor_world = GAMEMODE.Worlds:GetEntityWorldSpace( meteor )

	local filter = RecipientFilter()

	for k, v in pairs( player.GetAll() ) do
		if GAMEMODE.Worlds:GetEntityWorldSpace( v ) == meteor_world then
			filter:AddPlayer( v )
			util.ScreenShake( v:GetPos(), 100, 100, 5, 100 )
			v:SendMessage( "A Meteorite has landed somewhere near you.", 60, Color(255, 255, 0, 255))
		else
			v:SendMessage( "A Meteorite has landed on a distant world.", 60, Color(255, 255, 0, 255))
		end
	end
	local sound = CreateSound( game.GetWorld(), "ambient/explosions/exp1.wav", filter )
	if sound then
		sound:SetSoundLevel( 0 )
		sound:Play()
	end
	SGS_Log( "Meteorite Spawned on World: " .. world.Name )
end

function FindGoodSpot( world )
	local tries = 50

	for i=1, 50 do
		local rndPosX = math.random( world.Bounds[1].Min.x + 100, world.Bounds[1].Max.x - 100)
		local rndPosY = math.random( world.Bounds[1].Min.y + 100, world.Bounds[1].Max.y - 100)

		local pos = Vector( rndPosX, rndPosY, world.SkyPos - 400 )
		local tr = util.TraceLine({
            start=pos,
            endpos=pos - Vector(0, 0, 16384),
			mask=bit.bor(MASK_WATER , MASK_SOLID),
            filter=ply
        })

		if tr.Hit then
			if not (tr.MatType == MAT_SLOSH) then
				if tr.MatType == MAT_DIRT or tr.MatType == MAT_SAND or tr.MatType == MAT_GRASS or tr.MatType == MAT_SNOW then
					if tr.HitWorld then
						if #ents.FindInSphere( tr.HitPos, 500 ) <= 0 then
							return tr.HitPos
						end
					end
				end
			end
		end
	end

	--Entity(1):SetPos( Vector(rndPosX, rndPosY, world.SkyPos - 400) )
end

function ChooseWorld()
	local tblWorlds = { "1" }
	local rndWorld = tblWorlds[ math.random( #tblWorlds ) ]
	local world = GAMEMODE.Worlds.tblWorlds[ tonumber(rndWorld) ]
	return world
end

hook.Add( "Think", "SpawnMeteorCheck", function()
	if not SGS.lastmeteorcheck then SGS.lastmeteorcheck = CurTime() end
	if CurTime() < SGS.lastmeteorcheck + 60 then return end
	SGS.lastmeteorcheck = CurTime()
	MeteorCheck()
end )

function MeteorCheck()
	if not SGS.nextmeteor then SGS.nextmeteor = 0 end
	if CurTime() < SGS.nextmeteor then return end
	if math.random(1,1000) <= 25 then
		SGS_SpawnMeteor()
		SGS.nextmeteor = CurTime() + ( 60 * 60 * 3 ) //1 Hour Cooldown between meteor chances
	end
end

function GM:PlayerShouldTaunt( ply )
	if not ply.nexttaunt then ply.nexttaunt = CurTime() - 100 end

	if CurTime() < ply.nexttaunt then
		ply:SendMessage( "You need to wait " .. math.floor(ply.nexttaunt - CurTime()) .. " more seconds before doing another gesture.", 60, Color(255, 0, 0, 255))
		return false
	else
		ply.nexttaunt = CurTime() + 60
		return true
	end
end




function SGS_ChatAddons( ply, text, public )
	if (string.sub(string.lower(text), 1, 7) == "!addons") then
		ply:SendLua("gui.OpenURL('http://steamcommunity.com/workshop/filedetails/?id=488250410')")
		return false
	end
end
hook.Add( "PlayerSay", "SGS_ChatAddons", SGS_ChatAddons )

function SGS_ChatDonate( ply, text, public )
	if (string.sub(string.lower(text), 1, 7) == "!donate") then
		ply:SendLua("gui.OpenURL('https://g4p.org/donate')")
		return false
	end
end
hook.Add( "PlayerSay", "SGS_ChatDonate", SGS_ChatDonate )

function SGS_ChatMOTD( ply, text, public )
	if (string.sub(string.lower(text), 1, 5) == "!motd") then
		ply:SendLua("SGS_OpenTOS()")
		return false
	end
end
hook.Add( "PlayerSay", "SGS_ChatMOTD", SGS_ChatMOTD )


function SGS_SteamGroupPage( ply, text, public )
	if (string.sub(string.lower(text), 1, 6) == "!steam") then
		ply:SendLua("gui.OpenURL('http://steamcommunity.com/groups/gman4president')")
		return false
	end

	if (string.sub(string.lower(text), 1, 6) == "!group") then
		ply:SendLua("gui.OpenURL('http://steamcommunity.com/groups/gman4president')")
		return false
	end
end
hook.Add( "PlayerSay", "SGS_SteamGroupPage", SGS_SteamGroupPage )

function PlayerMeta:Sheltered()
	--Check for shelter
	local trace = {}
	trace.start = self:GetShootPos()
	trace.endpos = trace.start + Vector(0,0,300)
	trace.filter = self

	local tr = util.TraceLine(trace)

	if !tr.HitWorld and !tr.HitNonWorld then
		return false
	else
		return true
	end
end


function PlayerMeta:Resurrect()
	if not IsValid( self ) then return end
	if self:Alive() then return end
	if self.beingresurrected then return end
	if not IsValid( self.m_hRagdollEntity ) then return end
	if not self.res_sickness then self.res_sickness = 0 end

	if self.afk then
		return
	end

	if self.res_sickness >= CurTime() then
		self:SendMessage( "You are under the effects of resurrection sickness.", 60, Color(255, 0, 0, 255))
		return
	end

	local rag = self.m_hRagdollEntity
	local pos = rag:GetPos()
	self.beingresurrected = true

	self.orb = ents.Create("gms_resurrect")
	self.orb:SetColor(Color(255,255,255,255))
	self.orb:SetPos( pos )
	self.orb.opos = pos
	self.orb.parent = rag
	self.orb:Spawn()

	local iNumPhysObjects = rag:GetPhysicsObjectCount()
	for Bone = 0, iNumPhysObjects-1 do

		local PhysObj = rag:GetPhysicsObjectNum( Bone )
		if ( PhysObj:IsValid() ) then
			PhysObj:EnableGravity( false )
			PhysObj:AddVelocity( Vector(math.random(-20,20),2,20) )

		end

	end

	rag:EmitSound( "sounds/resurrect.mp3", 125, 100, 1 )

	timer.Simple( 3, function()
		if rag == NULL then return end
		self.res_sickness = CurTime() + 180
		self:SendMessage( "You are now under the effects of resurrection sickness.", 60, Color(180, 180, 0, 255))
		rag:Remove()
		self:Spawn()
		self.beingresurrected = nil
		self:SetPos( pos )

		if not ( GAMEMODE.Tribes:GetTribeLevel( self ) >= 7 ) then
			self:SetHealth(self:GetMaxHealth() * 0.5)
			self.needs["hunger"] = self.maxneeds * 0.2
			self.needs["thirst"] = self.maxneeds * 0.2
			self.needs["fatigue"] = self.maxneeds * 0.2
			self.res_sickness = CurTime() + 300
			self:SendNeeds()
		else
			self:SetHealth(self:GetMaxHealth() * 0.75)
			self.needs["hunger"] = self.maxneeds * 0.5
			self.needs["thirst"] = self.maxneeds * 0.5
			self.needs["fatigue"] = self.maxneeds * 0.5
			self.res_sickness = CurTime() + 180
			self:SendNeeds()
		end

		timer.Simple( self.res_sickness - CurTime(), function()
			if IsValid( self ) then
				self:SendMessage( "The effects of your resurrection sickness have worn off.", 60, Color(180, 180, 0, 255))
			end
		end )
	end )
end

function GM:PlayerDeathThink( ply )
	ply.ressable = true
	if ( math.floor( CurTime() ) - ply:GetNWInt("lastdeathtime") >= ply:GetNWInt("deathtotaltime", 60) ) and not ply:GetNWBool("displaydeathnotice", false) then
		ply:DeathTwo()
	end
	return false
end

function PlayerMeta:DeathTwo()
	if self.beingresurrected then return end
	if IsValid( self.m_hRagdollEntity ) then
		self:SetPos( self.m_hRagdollEntity:GetPos() + Vector(0,0,10) )
	end

	local tbl_drop, tbl_destroy = self:DeathDropResources()
	local tbl_droptools = self:LoseTools()
	self.equippedtool = "NONE"
	self:RefreshMenus()

	net.Start("sgs_deathreport")
		net.WriteTable( tbl_drop )
		net.WriteTable( tbl_destroy )
		net.WriteTable( tbl_droptools )
		net.WriteString( self.killstring )
	net.Send( self )
	self.killstring = nil

	self:SetNWBool("displaydeathnotice", true)
	SGS_StopElixirEffect( self )
end

function SGS_RespawnKeyPress( ply, key )
	--if ply:Alive() then return end
	if ply.beingresurrected then return end
	if not ply:GetNWBool("displaydeathnotice", false) then return end
	if not ( key == IN_JUMP ) then return end
	ply:SetNWBool("displaydeathnotice", false)
	if not ply:Alive() then ply:Spawn() end
end
hook.Add( "KeyPress", "RespawnKeyPress", SGS_RespawnKeyPress )

function SGS_BypassTimerKeyPress( ply, key )
	if ply:Alive() then return end
	if ply:GetNWBool("displaydeathnotice", false) then return end
	if not ( key == IN_RELOAD ) then return end

	ply:DeathTwo()
end
hook.Add( "KeyPress", "SGS_BypassTimerKeyPress", SGS_BypassTimerKeyPress )

function SGS_ShowDeathScreen( ply, text, public )

	if ( string.sub( string.lower( text ), 1, 6 ) == "!death" ) or ( string.sub( string.lower( text ), 1, 10 ) == "!lastdeath" ) then
		if ply:Alive() then
			ply:SetNWBool("displaydeathnotice", true )
		else

		end
		return false
	end

end
hook.Add( "PlayerSay", "SGS_ShowDeathScreen", SGS_ShowDeathScreen )


local function RDPlayerDeath( ply, attacker, dmginfo )

	if ( ply.m_hRagdollEntity && ply.m_hRagdollEntity:IsValid() ) then

		ply:Spectate( OBS_MODE_CHASE )
		ply:SpectateEntity( ply.m_hRagdollEntity )
		ply.m_hRagdollEntity.ply = ply
		ply.m_hRagdollEntity.deathrag = true
		ply:SetNWBool("displaydeathnotice", false )
		ply:SetNWInt("lastdeathtime", math.floor( CurTime() ) )
		if GAMEMODE.Tribes:GetTribeLevel( ply ) >= 7 then
			ply:SetNWInt("deathtotaltime", 90)
		else
			ply:SetNWInt("deathtotaltime", 60)
		end


		ply:SetPos( ply.m_hRagdollEntity:GetPos() + Vector(0,0,10) )
		timer.Simple( 2, function()
			if IsValid( ply.m_hRagdollEntity ) then
				ply:SetPos( ply.m_hRagdollEntity:GetPos() + Vector(0,0,10) )
			end
		end )

	end

end
hook.Add( "PlayerDeath", "RDPlayerDeath", RDPlayerDeath )

function RDRemoveRagdollEntity( ply )

	if ( ply.m_hRagdollEntity && ply.m_hRagdollEntity:IsValid() ) then
		ply.m_hRagdollEntity:Remove()
		ply.m_hRagdollEntity = nil
	end

end
hook.Add( "PlayerSpawn", "RDRemoveRagdollEntity", RDRemoveRagdollEntity )
hook.Add( "PlayerDisconnected", "RDRemoveRagdollEntity", RDRemoveRagdollEntity )

function PlayerMeta:CreateRagdoll()

	local Ent = self:GetRagdollEntity()
	if ( Ent && Ent:IsValid() ) then Ent:Remove() end

	RDRemoveRagdollEntity( self )

	local Data = duplicator.CopyEntTable( self )

	Ent = ents.Create( "prop_ragdoll" )
		duplicator.DoGeneric( Ent, Data )
	Ent:Spawn()
	Ent:SetCollisionGroup( COLLISION_GROUP_WEAPON )

	Ent:SetNetworkedString("Owner", "World")

	Ent.CanConstrain	= false
	Ent.CanTool			= false
	Ent.GravGunPunt		= false
	Ent.PhysgunDisabled	= false

	local Vel = self:GetVelocity()

	local iNumPhysObjects = Ent:GetPhysicsObjectCount()
	for Bone = 0, iNumPhysObjects-1 do

		local PhysObj = Ent:GetPhysicsObjectNum( Bone )
		if ( PhysObj:IsValid() ) then

			local Pos, Ang = self:GetBonePosition( Ent:TranslatePhysBoneToBone( Bone ) )
			PhysObj:SetPos( Pos )
			PhysObj:AddVelocity( Vel )

		end

	end

	self:SetNetworkedEntity( "m_hRagdollEntity", Ent )
	self.m_hRagdollEntity = Ent
	
	hook.Call( "CreatePlayerRagdoll", GAMEMODE, self, Ent )
	return

end

function PlayerMeta:GetRagdollEntity()

	return self:GetNetworkedEntity( "m_hRagdollEntity" )

end


function GM:CanPlayerEnterVehicle( ply, vehicle, sRole )
	ply.preseatposition = ply:GetPos()
	ply.preseatangle = ply:GetAngles()
	return true
end


function GM:PlayerLeaveVehicle( ply, vehicle )
	ply:SetPos( ply.preseatposition )
	ply:SetEyeAngles( ply.preseatangle )
end

local bad_words = { "nigger", "nigga" }
function SGS_ChatFilter( ply, text, public )
	for k, v in pairs( bad_words ) do
		if string.find( string.lower(text), v ) then
			ply:ChatPrint("That kind of language is not permitted on this server. Circumventing the filter will result in a ban!")
			return false
		end
	end
end
hook.Add( "PlayerSay", "SGS_ChatFilter", SGS_ChatFilter )

function EnterVehicleNoTarget( ply, veh, num )
	ply:SetNoTarget( true )
end
hook.Add( "PlayerEnteredVehicle", "EnterVehicleNoTarget", EnterVehicleNoTarget )

function ExitVehicleNoTarget( ply, veh, num )
	ply:SetNoTarget( false )
end
hook.Add( "PlayerLeaveVehicle", "ExitVehicleNoTarget", ExitVehicleNoTarget )


function GM.colorSay( target_ply, mTbl )

	if IsValid(target_ply) then
		net.Start("GAT_ColorMessage")
			net.WriteTable( mTbl )
		net.Send( target_ply )
	else
		net.Start("GAT_ColorMessage")
			net.WriteTable( mTbl )
		net.Broadcast()
	end

end

function PlayerMeta:GetPlayerID()
	if game.SinglePlayer() then return "localplayer" end
	return self:SteamID64()
end

--Credits go to Megiddo and the ULX team for this command.
function GM.getUser( target )
	if not target then return false end
	local players = player.GetAll()
	target = target:lower()
	local plyMatch

	for _, player in ipairs( players ) do
		if target == player:Nick():lower() then
			if not plyMatch then
				return player
			else
				return false
			end
		end
	end

	for _, player in ipairs( players ) do
		local nameMatch
		if player:Nick():lower():find( target, 1, true ) then -- No patterns
			nameMatch = player
		end
		if plyMatch and nameMatch then -- Already have one
			return false
		end
		if nameMatch then
			plyMatch = nameMatch
		end
	end

	if not plyMatch then
		return false
	end

	return plyMatch
end