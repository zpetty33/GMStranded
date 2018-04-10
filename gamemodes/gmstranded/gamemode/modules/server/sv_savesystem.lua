local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")

if !file.Exists( "sgstranded/newsaves", "DATA" ) then
	file.CreateDir( "sgstranded/newsaves" )
end

net.Receive( "sgs_readytoload", function( len, ply )
	if ply:GetInitialized() == INITSTATE_OK then return end
	
	ply:SetInitialized( INITSTATE_OK )
	
	ply:SetDefaultValues()
	ply:LoadCharacter()
	ply:SetSurvivalLevel()
	ply:CalcMaxPets()
	
	ply:CreateDerma()
	SGS_SetUpTeams(ply)
	
	ply:ClaimFruit()
	
	ply:SetSettings()			--Applies loaded settings to the character. Things such as their health, player model, player model color, etc etc.
	
	ply:SetPlayTimes()
	
	ply:RequestUpdatedVCList()	--HAS NET MESSAGE
	ply:SetSurvivalLevelStats()	--HAS NET MESSAGE
	
	Halo_NetworkTable( ply )
	
	ply:Spawn()

	if ply.settings["health"] == nil then
	else
		if ply.settings["health"] == 0 then
			ply:SetHealth(ply:GetMaxHealth())
		else
			ply:SetHealth(ply.settings["health"])
		end
	end
	
	timer.Simple( 5, function() SGS_BroadcastTreeTable( ply ) end )
	timer.Simple( 4, function() SGS_BroadcastLockedPropsTable( ply ) end )
	
	ply:SendLua("SGS_LoadHotBar()")
	timer.Simple( 180, function() if IsValid(ply) then ply:AutoSaveCharacter() end end )
	
	
	for _, v in pairs( player.GetAll() ) do
		if ( ply:IsAdmin() and v:IsAdmin() ) or ( not ply:IsAdmin() ) then
			v:SendMessage("" .. ply:Nick() .. " has joined the server.", 60, Color(0, 255, 255, 255))
		end
	end
	
	timer.Simple(  1, function() SGS_PlaySound(ply) end )
	timer.Simple( 20, function() SGS_RandomSay(ply) end )
	timer.Simple( 10, function() SGS_ReclaimPets( ply ) end )
	timer.Simple( 3, function() SGS_SetZombiesNeutral( ply ) end )
	timer.Simple( 5, function() if IsValid(ply) then ply:CheckForAchievements("all") end end )
	timer.Simple( 3, function() if IsValid(ply) then ply:SendPropCount() ply:SendStructureCount() end end )
	
	timer.Simple( 1, function()
		for _, ent in pairs( ents.FindByClass("gms_radio") ) do
			if ent.stationid ~= "" then
				if ent.on == true then
					ServerLog("Rerunning This Radio\n")
					ent:SetupSong( ent.stationid, ply )
				end
			end
		end
		
		for _, ent in ipairs( ents.GetAll() ) do
			if ent.StartEffects then
				ent:StartEffects( ply )
			end
		end
	end )

end )

function PlayerMeta:SetDefaultValues()

	self.inprocess = false
	self.sleeping = false
	self.sheltered = false
	self.nextunstuck = CurTime()
	self.usepress = 0
	self.processtype = "none"
	self.tplants = 0
	self.maxplants = 15
	self.maxpets = 5
	self.foragetoggle = false
	self.nexttog = CurTime()
	self.allowedmodels = {}
	self.botangle = self:GetAngles()
	self.botpos = self:GetPos()
	self.bpx = self.botpos.x
	self.bpy = self.botpos.y
	self.botcount = 0
	self.peffect = false
	self.elixir = "NONE"
	self.elixirval = 1
	self.elixent = nil
	self.passedout = false
	self.tosaccept = false
	self.perspective = "third"
	self.tpmode = true
	self.isgrab = false
	self.loaded = true
	self.afk = false
	self.lastafk = CurTime() - 60
	self.deadcounter = 0
	self.maxneeds = 1000
	self.smithcheck = true
	self.burntoggle = false
	self.ps = false
	self.lastvorttalk = CurTime() - 120
	self.inpvp = false
	self.lastpvp = CurTime()
	self.voiceid = "A"
	self.resource = {}
	self.curinv = 0
	self.gtokens = { tokens = 0 }
	self.lastrain = CurTime()
	self.timechange = CurTime()
	
	self:SetNWString("voicechannel", tostring(self.voiceid))
end

function PlayerMeta:SetPlayTimes()
	self.sessiontime = self:GetStat("time1")
	self.afktime = self:GetStat("time2")
	
	timer.Simple( 60, function() self:TimeCountUp() end )
end


function PlayerMeta:SaveCharacter()

	if not self.exp then return end --Don't save a character that isn't fully loaded yet.
	if self.settings == nil then self.settings = {} end
	
	self.settings["health"] = self:Health()
	
	local tbl = {}
	
	tbl.date = os.date("%A %m/%d/%y")
	
	tbl.experience = {}
	for k,v in pairs(self.exp) do
		tbl.experience[k] = v
	end
	
	tbl.achievements = {}
	for k,v in pairs(self.ach) do
		tbl.achievements[k] = v
	end
	
	tbl.stats = {}
	for k,v in pairs(self.stats) do
		tbl.stats[k] = v
	end
	
	tbl.settings = {}
	for k,v in pairs(self.settings) do
		tbl.settings[k] = v
	end
	tbl.settings["health"] = self:Health()
	
	tbl.inventory = {}
	
	tbl.inventory.resources = self.resource
	tbl.inventory.tools = {}
	for k, v in pairs(self.inventory) do
		local found = false
		for k2, v2 in pairs(SGS.startinginventory) do
			if v == v2 then
				found = true
				break
			end
		end
		if not found then
			table.insert(tbl.inventory.tools, v)
		end
	end
	
	if self.equippedtool == "NONE" then
	else
		local found = false
		for k, v in pairs(SGS.startinginventory) do
			if v == self.equippedtool then
				found = true
				break
			end
		end
		if not found then
			table.insert(tbl.inventory.tools, self.equippedtool)
		end
	end
	
	SGS_CleanInventories( self )
	
	tbl.inventory.pcache = self.pcontents
	tbl.inventory.pcache2 = self.p2contents
	tbl.inventory.pcache3 = self.p3contents
	tbl.inventory.pcache4 = self.p4contents
	tbl.inventory.pcacheboss = self.pbosscontents
	tbl.inventory.ptcache = self.ptcontents
	
	tbl.inventory.pethouse = self.pethouse
	
	tbl.gtokens = self.gtokens
	
	file.Write( "sgstranded/newsaves/" ..self:GetPlayerID().. ".txt", util.TableToJSON( tbl, true ) )
	self:SendMessage("Character Saved!", 60, Color(255, 255, 255, 255))
	
	tbl = nil

end

function SGS_AutoSaveAllCharacters()

	for k,v in pairs(player.GetAll()) do
		if v.loaded == true then
			v:SendMessage("Autosaving..",3,Color(255,255,255,255))
			v:SaveCharacter()
		end
	end

end

function PlayerMeta:AutoSaveCharacter()

	if IsValid( self ) then
		self:SaveCharacter()
	end
	timer.Simple( 180, function() self:AutoSaveCharacter() end )
end

function SGS_ConSaveAllCharacters( ply, com, args )
	if not IsValid( ply ) or ply:IsAdmin() then
		if IsValid( ply ) then
			ply:SendMessage("Autosaving all players..",3,Color(255,255,255,255))
		else
			Msg( "Autosaving all players.." )
		end
		SGS_AutoSaveAllCharacters()
		SGS_CrashGenerateReport()
		GAMEMODE.Tribes:SaveTribes()
	end
end
concommand.Add("sgs_saveall", SGS_ConSaveAllCharacters)

function PlayerMeta:LoadCharacter()
	if file.Exists( "sgstranded/newsaves/" .. self:GetPlayerID() .. ".txt", "DATA" ) then
		SGS_LoadPlayer( self )
	else
		self:SetLevels()
		self:SetExpBase()
		self:SetInventory()
		
		self.ach = {}
		self.stats = {}
		self.settings = {}
		self.pethouse = {}
		self:SendMessage("This is your first time here, Welcome!.",3,Color(255,255,255,255))
		net.Start("SGS_OpenTOS")
			net.WriteString("new")
		net.Send( self )
		
		self:AddStat("time3")
	end
end

function SGS_LoadPlayer( ply )
	if not IsValid( ply ) then return end
	
	local tbl = util.JSONToTable( file.Read( "sgstranded/newsaves/" .. ply:GetPlayerID() .. ".txt", "DATA" ) )

	ply.level = {}
	ply.exp = {}
	ply.ach = {}
	ply.stats = {}
	ply.settings = {}
	ply.pethouse = {}
	
	ply:SetLevels()
	ply:SetExpBase()
	ply:SetInventory()
	
	if tbl.experience then
		for k, v in pairs( tbl.experience ) do
			ply:SetExp( k, v )
			local sl = SGS_CheckEXPforLVL( v )
			ply:SetLevel( k, sl )
		end
	end
	
	if tbl.achievements then
		for k,v in pairs( tbl.achievements ) do
			ply.ach[ k ] = v
		end
		ply:SyncAch()
	end
	
	if tbl.settings then
		for k,v in pairs( tbl.settings ) do
			ply.settings[ k ] = v
		end
	end
	ply:SetHealth( ply.settings[ "health" ] )
	
	if tbl.stats then
		for k,v in pairs( tbl.stats ) do
			ply.stats[ k ] = v
		end
	end
	
	ply.resource = tbl.inventory.resources
	ply:SynchResources()
	
	ply.pcontents = tbl.inventory.pcache
	ply.p2contents = tbl.inventory.pcache2
	ply.p3contents = tbl.inventory.pcache3
	ply.p4contents = tbl.inventory.pcache4
	ply.pbosscontents = tbl.inventory.pcacheboss
	
	ply.ptcontents = tbl.inventory.ptcache
	
	ply.pethouse = tbl.inventory.pethouse
	
	ply.gtokens = tbl.gtokens
	ply:SetGTokens( ply.gtokens["tokens"] or 0)
	
	if tbl.inventory.tools ~= nil then
		ply:SynchTools( tbl.inventory.tools )
	end
	
	
	if ply.settings["melonaids"] == nil then ply.settings["melonaids"] = 0 end
	if ply.settings["melonaids"] > 0 then
		ply:SetSick( tonumber(ply.settings["melonaids"]) )
	end
	ply:AddStat("time3")

	ply:SendMessage("Loaded character successfully.",3,Color(255,255,255,255))
	ply:SendMessage("Last visited on "..tbl.date..". Welcome Back!",10,Color(255,255,255,255))
	
	if not ply:IsDonator() then
		net.Start("SGS_OpenTOS")
			net.WriteString("old")
		net.Send( ply )
	else
		ply:SendLua("SGS_AcceptTOS()")
	end

	if not ply:IsDonator() then
		if ply:GetAch("time5") and ( ply:IsUserGroup( "member" ) or ply:IsUserGroup( "user" ) ) then
			SGS_SetUpTeams(ply)
		end
	end
	
	ply:SaveCharacter()

end

function GM:PlayerDisconnected(ply)
	if not (ply:GetInitialized() == INITSTATE_OK) then return end
	
	
	if not ply:Alive() and not ply:GetNWBool("displaydeathnotice", false) then
		ply:DeathTwo()
	end
	
	ply:SaveCharacter()
	for _, v in pairs( player.GetAll() ) do
		v:SendMessage("" .. ply:Nick() .. " has left the server.", 60, Color(0, 255, 255, 255))
	end
end


function SGS_CleanInventories( ply )
	if ply.pcontents then
		for k, v in pairs( ply.pcontents ) do
			if v <= 0 then ply.pcontents[k] = nil end
		end
	end
	if ply.p2contents then
		for k, v in pairs( ply.p2contents ) do
			if v <= 0 then ply.p2contents[k] = nil end
		end
	end
	if ply.p3contents then
		for k, v in pairs( ply.p3contents ) do
			if v <= 0 then ply.p3contents[k] = nil end
		end
	end
	if ply.p4contents then
		for k, v in pairs( ply.p4contents ) do
			if v <= 0 then ply.p4contents[k] = nil end
		end
	end
	if ply.pbosscontents then
		for k, v in pairs( ply.pbosscontents ) do
			if v <= 0 then ply.pbosscontents[k] = nil end
		end
	end
end