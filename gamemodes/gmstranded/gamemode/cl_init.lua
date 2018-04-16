include( "shared.lua" )

local PlayerMeta = FindMetaTable( "Player" )

local files, dirs = file.Find("gmstranded/gamemode/modules/client/*.lua", "LUA")
for k, v in pairs( files ) do
	print("Stranded: Loading module (" .. v .. ")")
	include( "gmstranded/gamemode/modules/client/" .. v )
end

include( "gmstranded/gamemode/modules/client/skybox/cl_worldskies.lua" )

SGS.resources = SGS.resources or {}
SGS.levels = SGS.levels or {}
SGS.exp = SGS.exp or {}
SGS.propmenucats = SGS.propmenucats or {}
SGS.hudtimer = SGS.hudtimer or {}
SGS.inventory = SGS.inventory or {}
SGS.needs = SGS.needs or {}
SGS.pmodels = SGS.pmodels or {}
SGS.drawdistance = 36000000
SGS.tier = "1"
SGS.drawlights = 640000
SGS.voicechannels = SGS.voicechannels or {}
SGS.plantcount = 0
SGS.maxplants = 0
SGS.ach = SGS.ach or {}
SGS.sideinventoryposx = ScrW() - 260
SGS.sideinventoryposy = 145
SGS.hotbarscrollitems = SGS.hotbarscrollitems or {}
SGS.scrollitem = 1
SGS.propcount = 0
SGS.structurecount = 0

SGS.killerstring = ""
SGS.itemsdropped = ""
SGS.itemsdestroyed = ""
SGS.toolsdropped = ""
LocalPlayer().achievementstart = -10


--[[
SGS.HotBarcontents[1] = nil
SGS.HotBarcontents[2] = nil
SGS.HotBarcontents[3] = nil
SGS.HotBarcontents[4] = nil
SGS.HotBarcontents[5] = nil
SGS.HotBarcontents[6] = nil
SGS.HotBarcontents[7] = nil
SGS.HotBarcontents[8] = nil
SGS.HotBarcontents[9] = nil
SGS.HotBarcontents[10] = nil
]]

function GM:Think()
	--self.World:Think()
end

function GM:HUDPaint()
	--self.World:HUDPaint()
end

function GM:AddNotify( str, type, duration )
	LocalPlayer():PrintMessage( HUD_PRINTTALK, str )
end

function GM:InitPostEntity()
	--self.World:InitPostEntity()
	timer.Create(
		"sgs_readyforinfo",
		5,
		0,
		function()
			if LocalPlayer():GetInitialized() == INITSTATE_ASKING then
				net.Start( "sgs_readytoload" )
				net.SendToServer()
			else
				timer.Remove( "sgs_readyforinfo" )
				for k, v in pairs( ents.GetAll() ) do
					if v:GetNWBool("waterfall") then
						ParticleEffectAttach( "thw_waterfall_01", PATTACH_ABSORIGIN, v, 0 )
					end
					if v:GetNWBool("waterfalltop") then
						ParticleEffectAttach( "waterfall_topsplash", PATTACH_ABSORIGIN, v, 0 )
					end
					if v:GetNWBool("waterfallbase") then
						ParticleEffectAttach( "waterfall_base_01", PATTACH_ABSORIGIN, v, 0 )
					end
				end
			end
		end
	)
end


hook.Add("InitPostEntity", "draw_waterfalls", function()
	timer.Simple( 1, function()
		for k, v in pairs( ents.GetAll() ) do
			if v:GetNWBool("waterfall") then
				ParticleEffectAttach( "thw_waterfall_01", PATTACH_ABSORIGIN, v, 0 )
			end
			if v:GetNWBool("waterfalltop") then
				ParticleEffectAttach( "waterfall_topsplash", PATTACH_ABSORIGIN, v, 0 )
			end
			if v:GetNWBool("waterfallbase") then
				ParticleEffectAttach( "waterfall_base_01", PATTACH_ABSORIGIN, v, 0 )
			end
		end
	end )
end )

//--ALL CREDIT FOR THE MATERIAL FUNCTIONS BELOW TO AVON FROM THE STARGATE ADDON PACK--//
function SGS.MaterialFromVMT(name,VMT)
	if(type(VMT) ~= "string" or type(name) ~= "string") then return Material("") end; -- Return a dummy Material
	local t = util.KeyValuesToTable("\"material\"{"..VMT.."}");
	for shader,params in pairs(t) do
		return CreateMaterial(name,shader,params);
	end
end

//--ALL CREDIT FOR THE MATERIAL FUNCTIONS BELOW TO AVON FROM THE STARGATE ADDON PACK--//
function SGS.MaterialCopy(name,filename)
	if(type(filename) ~= "string" or type(name) ~= "string") then return Material("") end; -- Return a dummy Material
	filename = "../materials/"..filename:Trim():gsub(".vmt$","")..".vmt";
	return SGS.MaterialFromVMT(name,file.Read(filename));
end

function PlayerInit()
	--surface.CreateFont( "tahoma", 20, 600, true, false, "resource" )
	surface.CreateFont( "resource", {
		font	=	"tahoma",
		size	=	20,
		weight	=	600
		}
	)
	--surface.CreateFont( "tahoma", 20, 600, true, false, "resource" )
	surface.CreateFont( "sign", {
		font	=	"tahoma",
		size	=	22,
		weight	=	800
		}
	)
	--surface.CreateFont( "tahoma", 12, 600, true, false, "resource2" )
	surface.CreateFont( "resource2", {
		font	=	"tahoma",
		size	=	12,
		weight	=	600
		}
	)
	--surface.CreateFont( "tahoma", 8, 400, true, false, "proplisticons" )
	surface.CreateFont( "proplisticons", {
		font	=	"tahoma",
		size	=	8,
		weight	=	400
		}
	)
	--surface.CreateFont( "tahoma", 8, 400, true, false, "proplisticons" )
	surface.CreateFont( "HotBarnumbers", {
		font	=	"tahoma",
		size	=	14,
		weight	=	600
		}
	)
	--surface.CreateFont( "tahoma", 8, 400, true, false, "proplisticons" )
	surface.CreateFont( "farmingoverlayicons", {
		font	=	"tahoma",
		size	=	10,
		weight	=	800
		}
	)
	--surface.CreateFont( "arial", 14, 600, true, false, "SGS_HUD2" )
	surface.CreateFont( "SGS_HUD2", {
		font	=	"arial",
		size	=	14,
		weight	=	600
		}
	)
	--surface.CreateFont( "arial", 14, 600, true, false, "SGS_HUD2" )
	surface.CreateFont( "SGS_NotAvailable2", {
		font	=	"tahoma",
		size	=	12,
		weight	=	600
		}
	)
	--surface.CreateFont( "tahoma", 14, 600, true, false, "SGS_HUD3" )
	surface.CreateFont( "SGS_HUD3", {
		font	=	"tahoma",
		size	=	14,
		weight	=	600
		}
	)
	--surface.CreateFont( "tahoma", 12, 600, true, false, "SGS_FarmText" )
	surface.CreateFont( "SGS_FarmText", {
		font	=	"tahoma",
		size	=	12,
		weight	=	600
		}
	)
	--surface.CreateFont( "tahoma", 12, 600, true, false, "SGS_RCacheMenuText" )
		surface.CreateFont( "SGS_RCacheMenuText", {
		font	=	"tahoma",
		size	=	12,
		weight	=	600
		}
	)
	--surface.CreateFont( "tahoma", 12, 600, true, false, "SGS_RCacheMenuText" )
		surface.CreateFont( "SGS_TCacheMenuText", {
		font	=	"tahoma",
		size	=	12,
		weight	=	600
		}
	)
	--surface.CreateFont( "tahoma", 12, 600, true, false, "SGS_RCacheMenuText" )
		surface.CreateFont( "SGS_RCacheTitles", {
		font	=	"tahoma",
		size	=	18,
		weight	=	600
		}
	)
	surface.CreateFont( "SGS_SideInventoryFont2", {
		font	=	"courier",
		size	=	10,
		weight	=	600
		}
	)

	for k, v in pairs( SGS.props ) do
		SGS.propmenucats[ k ] = true
	end

	SGS.inventory = { "weapon_physgun", "weapon_physcannon", "gms_remover", "gms_sppshare", "gms_proplocker", "gms_packager", "gmod_camera" }

	SGS.dropmenu = ""



	SGS.fps = 0
	SGS.fnum = 0
	SGS.fnumcheck = CurTime()

	SGS.maxinv = 120
	SGS.maxneeds = 1000
	SGS.curinv = 0
	SGS.gtokens = 0

	SGS.showafk = false
	SGS.afktime = 0

	SGS.tostime = 0

	SGS.mstate = "hidden"

	SGS.person = "first"
	SGS.camhit = false

	SGS.showhudmain = true

	SGS.accepttos = false

	SGS.amode = false

	SGS.o2 = 1000
	SGS.o2show = false

	SGS.day = 1
	SGS.time = 1
	SGS.chp_next = CurTime()
	SGS.chp_dir = "up"
	SGS.chp = 5

	SGS.rcache = SGS.rcache or {}
	SGS.pethouse = SGS.pethouse or {}
	SGS.lockedprops = SGS.lockedprops or {}

	SGS.hudtimer[ "display" ] = false
	SGS.hudtimer[ "etime" ] = 0
	SGS.hudtimer[ "len" ] = 0
	SGS.hudtimer[ "text" ] = ""

	SGS.inchat = false
	SGS.skillmenuopen = false
	SGS.inventoryopen = false
	SGS.commandsmenuopen = false
	SGS.adcolor = SGS.adcolors[math.random(#SGS.adcolors)]

	LoadCustomParticles()

	--GAMEMODE.World:Initialize()
end
hook.Add( "Initialize", "PlayerInit", PlayerInit )

local custom_particles = { "antlion_gib_01", "antlion_gib_02", "antlion_worker", "hunter_flechette", "hunter_projectile" }
function LoadCustomParticles()
	for k, v in pairs( custom_particles ) do
		game.AddParticles( "particles/" .. v .. ".pcf" )
	end
end

function SGS_StopBind( ply, bind, pressed )

	if string.find( bind, "impulse 201" ) then return true end

end
hook.Add( "PlayerPressBind", "SGS_StopBind", SGS_StopBind )

net.Receive("UpdateShadow", function(length )

	local ent = net.ReadEntity()


	if not IsValid(ent) then return end

	ent:DestroyShadow()
	ent:CreateShadow()

end)

net.Receive("sgs_sendpropcount", function( len )
	SGS.propcount = net.ReadInt( 16 )
end )

net.Receive("sgs_sendstructurecount", function( len )
	SGS.structurecount = net.ReadInt( 16 )
end )

net.Receive("sgs_deathreport", function( len )
	local tbl_dropped = net.ReadTable()
	local tbl_destroyed = net.ReadTable()
	local tbl_droppedtools = net.ReadTable()
	local killstring = net.ReadString()

	SGS.itemsdropped = ""
	SGS.itemsdestroyed = ""
	SGS.toolsdropped = ""

	if #tbl_dropped > 0 then SGS.itemsdropped = "" end
	if #tbl_destroyed > 0 then SGS.itemsdestroyed = "" end
	if #tbl_droppedtools > 0 then SGS.toolsdropped = "" end

	SGS.killerstring = killstring
	local c = 0
	for k, v in pairs( tbl_dropped ) do
		if v > 0 then
			SGS.itemsdropped = SGS.itemsdropped .. CapAll(string.gsub(k, "_", " ")) .. ": " .. v .. "\n"
			c = c + 1
		end
	end
	if c == 0 then SGS.itemsdropped = "NONE" end
	local c = 0
	for k, v in pairs( tbl_destroyed ) do
		if v > 0 then
			SGS.itemsdestroyed = SGS.itemsdestroyed .. CapAll(string.gsub(k, "_", " ")) .. ": " .. v .. "\n"
			c = c + 1
		end
	end
	if c == 0 then SGS.itemsdestroyed = "NONE" end
	local c = 0
	for k, v in pairs( tbl_droppedtools ) do
		SGS.toolsdropped = SGS.toolsdropped .. v .. "\n"
		c = c + 1
	end
	if c == 0 then SGS.toolsdropped = "NONE" end
end )


net.Receive("sgs_skillunlock", function( len )
	local skill	= net.ReadString()
	local level	= net.ReadString()
	local text	= net.ReadString()
	local text2	= net.ReadString()
	LocalPlayer().skillunlocktbl = { skill, level, text, text2 }
	LocalPlayer().achievementstart = CurTime()
	EmitSound( Sound( "sounds/unlock.mp3" ), LocalPlayer():GetPos(), 1, CHAN_AUTO, 0.7, 75, 0, 120 )
end )

net.Receive("UpdateGrowth", function(length )

	local ent = net.ReadEntity()
	local scale = net.ReadFloat()

	if not IsValid(ent) then
		print("INVALID..RETURNING")
		return
	end

	ent:SetModelScale( scale, 0 )

end)

net.Receive("sgs_lockedprops", function(length )

	local lock = net.ReadString()
	local ent = net.ReadEntity()


	if lock == "lock" then
		SGS_AddLockedProp( ent )
	else
		SGS_RemoveLockedProp( ent )
	end

end)

net.Receive("sgs_lockedpropstable", function(length )
	local tbl = net.ReadTable()
	SGS.lockedprops = tbl
end)

net.Receive("sgs_sendo2", function(length )

	local o2 = net.ReadInt(32)
	local o2show = net.ReadString()

	if o2 == nil then return end
	if o2show == nil then return end

	SGS.o2 = o2

	if o2show == "no" then SGS.o2show = false end
	if o2show == "yes" then SGS.o2show = true end

end)

net.Receive("ReceivePethouse", function(length )

	SGS.pethouse = net.ReadTable()

end)


net.Receive("sgs_settimeupdate", function(length )

	local newtime = net.ReadInt( 16 )
	hook.Call( "sgs_timeupdate", GAMEMODE, newtime )

end)

net.Receive("UpdateVoiceChannels", function(length )

	SGS.voicechannels = net.ReadTable()
	RunConsoleCommand("sgs_refreshvc")

end)

net.Receive("SendStats", function(length )

	SGS.mystats = net.ReadTable()

end)


function SGS_GetStat( stat )
	if SGS.mystats == nil then SGS.mystats = {} end

	if SGS.mystats[stat] == nil then return 0 end
	return SGS.mystats[stat]

end

net.Receive("SendStatsOther", function(length )

	SGS.theirname = net.ReadString()
	SGS.theirstats = net.ReadTable()
	SGS_StatsPanel( "them" )

end)

net.Receive("UpdateCacheTable", function(length )

	SGS.rcache = {}
	SGS.rcache = net.ReadTable()

end)

net.Receive("UpdateTCacheTable", function(length )

	SGS.tcache = {}
	SGS.tcache = net.ReadTable()

end)

SGS.PendingRDrops = SGS.PendingRDrops or {}

net.Receive("UpdateResourceCrate", function(length )

	local tbl = net.ReadTable()

	local ent = tbl[1]
	local rType = tbl[2]
	local rAmt = tbl[3]

	if ent == NULL or !ent then
		local tbl = {}
		tbl.rType = rType
		tbl.rAmt = rAmt
		tbl.ent = ent
		table.insert(SGS.PendingRDrops, tbl)
	else
		ent.res = rType
		ent.amt = rAmt
	end

end)

net.Receive("sgs_syncachievements", function(length )

	local tbl = net.ReadTable()
	SGS.ach = tbl
	RunConsoleCommand("sgs_refreshoptions")

end)

function SGS_AssignHotBar( slot, tool, refresh )

	if SGS_CheckOwnership( tool ) then

		SGS.HotBarcontents[slot] = tool
		LocalPlayer():SetPData("sgs13HotBar_slot" .. tostring(slot), tool)

		if refresh then
			if SGS.hotbarinit then
				RunConsoleCommand("sgs_refreshhotbar")
			end
		end

		SGS_CalcHotbarScrollItems()

	end

end

function SGS_AssignHotBarConsumable( slot, item, refresh )


	if SGS_CheckInventory( item ) then

		SGS.HotBarcontents[slot] = item
		LocalPlayer():SetPData("sgs13HotBar_slot" .. tostring(slot), item)

		if refresh then
			if SGS.hotbarinit then
				RunConsoleCommand("sgs_refreshhotbar")
			end
		end

		SGS_CalcHotbarScrollItems()

	end

end

function SGS_AssignHotBarSpell( slot, spell, refresh )

	SGS.HotBarcontents[slot] = spell
	LocalPlayer():SetPData("sgs13HotBar_slot" .. tostring(slot), spell)

	if refresh then
		if SGS.hotbarinit then
			RunConsoleCommand("sgs_refreshhotbar")
		end
	end

	SGS_CalcHotbarScrollItems()

end

function SGS_CalcHotbarScrollItems()
	SGS.hotbarscrollitems = {}
	SGS.scrollitem = 1

	for k, v in pairs( SGS.HotBarcontents ) do
		if SGS_HotBarReturnType( v ) == "tool" then
			table.insert( SGS.hotbarscrollitems, v )
		end
	end
end

function SGS_HotBarReturnType( item )

	for k, v in pairs( SGS.inventory ) do
		if item == v then
			return "tool"
		end

		if IsValid( LocalPlayer():GetActiveWeapon() ) then
			if item == LocalPlayer():GetActiveWeapon():GetClass() then
				return "tool"
			end
		end
	end

	for k, v in pairs( SGS.SpellList ) do
		if v.spell == item then
			return "spell"
		end
	end

	for k, v in pairs( SGS.menuedible ) do
		if item == v then
			return "edible"
		end
	end

	for k, v in pairs( SGS.menupotions ) do
		if item == v then
			return "potion"
		end
	end

end

function SGS_LoadHotBar()
	SGS.HotBarcontents = SGS.HotBarcontents or {}
	for i = 1, 10 do
		local item = LocalPlayer():GetPData("sgs13HotBar_slot" .. tostring(i), "NONE")
		if item == "NONE" then
		else
			if SGS_HotBarReturnType( item ) == "tool" then
				SGS_AssignHotBar( i, item, false )
			elseif SGS_HotBarReturnType( item ) == "edible" then
				SGS_AssignHotBarConsumable( i, item, false )
			elseif SGS_HotBarReturnType( item ) == "spell" then
				SGS_AssignHotBarSpell( i, item, false )
			elseif SGS_HotBarReturnType( item ) == "potion" then
				SGS_AssignHotBarSpell( i, item, false )
			end
		end
	end
	if SGS.hotbarinit then
		RunConsoleCommand("sgs_refreshhotbar")
	end
end

function SGS_RemoveFromHotBar( slot )

	SGS.HotBarcontents[slot] = nil
	LocalPlayer():SetPData("sgs13HotBar_slot" .. tostring(slot), "NONE")
	if SGS.hotbarinit then
		RunConsoleCommand("sgs_refreshhotbar")
	end

end

function SGS_CheckOwnership( tEnt )

	for k, v in pairs( SGS.inventory ) do
		if tEnt == v then
			return true
		end
	end

	if LocalPlayer():GetActiveWeapon():GetClass() == tEnt then
		return true
	end

	return false

end

function SGS_CheckInventory( item )

	for k, v in pairs( SGS.menuedible ) do
		if item == v then
			if SGS.resources[item] == nil then return false end
			if SGS.resources[item] >= 1 then
				return true
			end
		end
	end

	for k, v in pairs( SGS.menupotions ) do
		if item == v then
			if SGS.resources[item] == nil then return false end
			if SGS.resources[item] >= 1 then
				return true
			end
		end
	end

	return false

end

function SGS_GetAch( ach )

	if ach == "none" then return true end
	if SGS.ach[ ach ] == nil then return false end
	return SGS.ach[ ach ]

end

function SGS_CheckForPendingRDrops()

	for k,tbl in pairs(SGS.PendingRDrops) do
		local ent = tbl.ent
		if ent != NULL then
            ent.res = tbl.rType
            ent.amt = tbl.rAmt
			table.remove(SGS.PendingRDrops,k)
        end
    end
end
hook.Add("Think","SGS_CheckForPendingRDrops",SGS_CheckForPendingRDrops)

function SGS_AddTool( tEnt )

	table.insert( SGS.inventory, tEnt )
	if (LocalPlayer():GetInitialized() == INITSTATE_OK) then
		RunConsoleCommand("sgs_refreshtools")
	end

end

function SGS_RemTool( tEnt )

	local found = false
	for k, v in pairs( SGS.inventory ) do
		if tEnt == v then
			found = true
			table.remove( SGS.inventory, k )
			if (LocalPlayer():GetInitialized() == INITSTATE_OK) then
				RunConsoleCommand("sgs_refreshtools")
			end
			return
		end
	end

	if found == false then
		SGS_RemTool( tEnt )
	end

end

function SGS_CheckTool( tEnt )

	for _, v in pairs( SGS.inventory ) do
		if v == tEnt then
			return true
		end
	end
	return false

end

function SGS_CountTools( tEnt )
	local count = 0
	for k, v in pairs( SGS.inventory ) do
		if v == tEnt then
			count = count + 1
		end
	end
	return count
end



net.Receive("SGS_OpenTOS", function(length )

	local val = net.ReadString()

	if val == "old" then
		SGS.tostime = 0
	else
		SGS.tostime = 10
	end

	SGS_OpenTOSTimed()
	SGS.tostime = 0


end)

function SGS_OpenTOSMenu()
	if input.IsKeyDown(97) then
		SGS.nextpress = SGS.nextpress or ( CurTime() - 3 )
		if SGS.nextpress then
			if CurTime() > SGS.nextpress then
				SGS.tostime = 0
				SGS_OpenTOS()
				SGS.nextpress = CurTime() + 3
			end
		else
			SGS.nextpress = CurTime()
		end
	end
end
hook.Add( "Think", "SGS_OpenTOSMenu", SGS_OpenTOSMenu )

function SGS_DisplayAFK(toggle)
	SGS.showafk = toggle
end

function SGS_AFKTime( tval )
	SGS.afktime = tval
end

function SGS_OpenTOS()

	SGS.TOS = vgui.Create("new_menu")
	SGS.TOS:SetVisible(true)
	SGS.TOS:MakePopup()

end
concommand.Add( "sgs_opentos", SGS_OpenTOS )

function SGS_OpenTOSTimed()

	SGS.TOS = vgui.Create("sgs_tospanel")
	SGS.TOS:SetVisible(true)
	SGS.TOS:MakePopup()

end

function SGS_AcceptTOS()
	SGS.accepttos = true
	RunConsoleCommand("sgs_refreshmodelpanel")
	RunConsoleCommand("sgs_tosaccept")
end
concommand.Add( "sgs_accepttos", SGS_AcceptTOS )

function CalculateCurrentInventory()
	local curinv = 0
	for k, v in pairs(SGS.resources) do
		curinv = curinv + tonumber(v)
	end
	SGS.curinv = curinv
end


function SGS_ChangeLightDistance( _, _, args)

	if #args == 1 then
		local dist = tonumber( args[ 1 ] )

		SGS.drawlights = dist
	end

end
concommand.Add( "sgs_lightdistance", SGS_ChangeLightDistance )

function SGS_OpenHelp()

	SGS.TOS = vgui.Create("new_menu")
	SGS.TOS:SetVisible(true)
	SGS.TOS:MakePopup()
	GAMEMODE.NewMenu.btn_option3:OnMousePressed()

end
concommand.Add( "sgs_help", SGS_OpenHelp )

function SGS_OpenWiki()

	SGS.TOS = vgui.Create("new_menu")
	SGS.TOS:SetVisible(true)
	SGS.TOS:MakePopup()
	GAMEMODE.NewMenu.btn_option2:OnMousePressed()
end
concommand.Add( "sgs_wiki", SGS_OpenWiki )

function SGS_OpenNewScoreboard()

	SGS.ScoreBoard = vgui.Create("sgs_newscoreboard")
	SGS.ScoreBoard:SetVisible(true)
	SGS.ScoreBoard:MakePopup()

end
concommand.Add( "sgs_opennewscoreboard", SGS_OpenNewScoreboard )

net.Receive( "sgs_updateresource", function(length )

	local res = net.ReadString()
	local amt = net.ReadInt( 32 )

	SGS.resources[ res ] = amt

	if (LocalPlayer():GetInitialized() == INITSTATE_OK) then
		RunConsoleCommand("sgs_refreshresources")
		if SGS.sideinventory then RunConsoleCommand( "sgs_refreshsideinventory" ) end
	end

end )

net.Receive( "sgs_sendresourcestable", function( length )
	SGS_ClearResources()
	SGS.resources = net.ReadTable()

	if (LocalPlayer():GetInitialized() == INITSTATE_OK) then
		RunConsoleCommand("sgs_refreshresources")
		if SGS.sideinventory then RunConsoleCommand( "sgs_refreshsideinventory" ) end
	end

end )

net.Receive( "sgs_receivegtoken", function( length )

	local amt = net.ReadInt( 32 )

	SGS.gtokens = amt
	if (LocalPlayer():GetInitialized() == INITSTATE_OK) then
		RunConsoleCommand("sgs_refreshresources")
		if SGS.sideinventory then RunConsoleCommand( "sgs_refreshsideinventory" ) end
	end

end )

function SGS_ClearResources()
	SGS.resources = {}
end

function SGS_ClearResource()

	SGS.resources = {}
	if (LocalPlayer():GetInitialized() == INITSTATE_OK) then
		RunConsoleCommand("sgs_refreshresources")
	end

end


net.Receive( "sgs_updatelevel", function( length )

	local skill = net.ReadString()
	local amt = net.ReadInt( 32 )

	SGS.levels[skill] = amt

	if skill == "survival" then
		if (LocalPlayer():GetInitialized() == INITSTATE_OK) then
			RunConsoleCommand("sgs_refreshresources")
		end
	end

	if skill == "arcane" then
		if (LocalPlayer():GetInitialized() == INITSTATE_OK) then
			RunConsoleCommand("sgs_refreshspells")
		end
	end


end )


net.Receive( "sgs_updateexp", function( length )

	local skill = net.ReadString()
	local amt = net.ReadInt( 32 )

	SGS.exp[ skill ] = amt

end )

net.Receive( "sgs_receiveexpmessage", function( len )
	local skill = net.ReadString()
	local nexp = net.ReadInt( 32 )
	local amt = net.ReadInt( 32 )
	local message = net.ReadString()
	
	SGS.last_skill_exp = skill
	
	SGS.skillFade = 1
	SGS.skillFadeTime = CurTime() + 15
	SGS.last_skill_message = message
	SGS.last_skill_amt = amt
end )

hook.Add("Think", "SkillBarFade", function()
	if not SGS.skillFade then SGS.skillFade = 0 end
	if not SGS.skillFadeTime then SGS.skillFadeTime = CurTime() - 10 end
	
	if SGS.skillFade <= 0 then return end
	
	if CurTime() < SGS.skillFadeTime then return end
	SGS.skillFade = SGS.skillFade - 0.01
end )

net.Receive( "sgs_updateneeds", function( length )

	SGS.needs["fatigue"] = net.ReadInt( 32 )
	SGS.needs["hunger"] = net.ReadInt( 32 )
	SGS.needs["thirst"] = net.ReadInt( 32 )

end )

net.Receive( "sgs_updatetime", function( length )

	SGS.time = net.ReadInt( 32 )
	SGS.day = net.ReadInt( 32 )

	hook.Call( "DayLightUpdateTime", GAMEMODE, SGS.time )

end )



net.Receive( "sgs_updateplayermodels", function( length )

	local tier = net.ReadString()

	if tier == "a" then SGS.pmodels = SGS.pma end
	if tier == "m" then SGS.pmodels = SGS.pmm end
	if tier == "d" then SGS.pmodels = SGS.pmd end
	if tier == "4" then SGS.pmodels = SGS.pm4 end
	if tier == "3" then SGS.pmodels = SGS.pm3 end
	if tier == "2" then SGS.pmodels = SGS.pm2 end
	if tier == "1" then SGS.pmodels = SGS.pm1 end

	SGS.tier = tier

	RunConsoleCommand("sgs_refreshpmodels")

end )


net.Receive( "sgs_updateadtext", function( length )

	SGS.adtext = net.ReadString()
	SGS.adcolor = SGS.adcolors[math.random(#SGS.adcolors)]

end )

net.Receive( "sgs_updateplantcount", function( length )

	SGS.plantcount = net.ReadInt( 32 )
	RunConsoleCommand("sgs_refreshfarming")

end )


net.Receive( "sgs_starttimer", function( length )

	local txt = net.ReadString()
	local len = net.ReadInt( 32 )
	local skill = net.ReadString()

	SGS.hudtimer[ "etime" ] = CurTime() + len
	SGS.hudtimer[ "text" ] = txt
	SGS.hudtimer[ "len" ] = len
	SGS.hudtimer[ "display" ] = true
	SGS.hudtimer[ "skill" ] = skill

end )


function SGS_StopTimer()

	SGS.hudtimer[ "etime" ] = 0
	SGS.hudtimer[ "text" ] = ""
	SGS.hudtimer[ "display" ] = false

end


net.Receive( "sgs_addtool", function( length )

	local txt = net.ReadString()
	SGS_AddTool( txt )

end )

net.Receive( "sgs_sendtoolsstable", function( length )
	SGS.inventory = {}
	SGS.inventory = net.ReadTable()
	if (LocalPlayer():GetInitialized() == INITSTATE_OK) then
		RunConsoleCommand("sgs_refreshtools")
	end
end )



net.Receive( "sgs_remtool", function( length )

	local txt = net.ReadString()
	if txt == nil or txt == NULL or txt == "" then
		LocalPlayer():ConCommand("SGS_ResendLastRemove")
		return
	end
	SGS_RemTool( txt )

end )


function SGS_ToggleLevelsCL()

	SGS.skillmenuopen = !SGS.skillmenuopen

end

function SGS_ToggleInventoryCL()

	if SGS.sideinventory then return end
	if SGS.skillmenuopen then
		SGS.skillmenuopen = !SGS.skillmenuopen
	end
	SGS.inventoryopen = !SGS.inventoryopen

end


function SGS_StartChat( teamchat )

	SGS.inchat = true

end
hook.Add( "StartChat", "SGS_StartChat", SGS_StartChat )

function SGS_FinishChat()

	SGS.inchat = false

end
hook.Add( "FinishChat", "SGS_FinishChat", SGS_FinishChat )


function GM:OnPlayerChat( player, strText, bTeamOnly, bPlayerIsDead )

	--if not IsValid( player ) then return end
	local tab = {}

	if IsValid( player ) then
		if player.ismuted then return true end
	end


	if ( bPlayerIsDead ) then
		table.insert( tab, Color( 255, 30, 40 ) )
		table.insert( tab, "*DEAD* " )
	end

	if ( bTeamOnly ) then
		table.insert( tab, Color( 30, 160, 40 ) )
		table.insert( tab, "(Tribe) " )
	end

	if ( IsValid( player ) ) then
		local p_group = self.GroupData[ player:GetUserGroup() ]
		table.insert( tab, Color( 0, 0, 0 ) )
		table.insert( tab, "(" )
		table.insert( tab, p_group.color )
		table.insert( tab, p_group.name )
		table.insert( tab, Color( 0, 0, 0 ) )
		table.insert( tab, ") " )
		table.insert( tab, player )
		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": "..strText )
	else
		table.insert( tab, Color( 0, 0, 0 ) )
		table.insert( tab, ">>" )
		table.insert( tab, Color( 180, 180, 180 ) )
		table.insert( tab, "Console" )
		table.insert( tab, Color( 0, 0, 0 ) )
		table.insert( tab, "<< " )
		table.insert( tab, Color( 0, 255, 55 ) )

		local strText2_name, strText2_msg = "Console", strText
		local sep = string.find( strText, "|", 1, true )
		if sep then
			strText2_name = string.sub( strText, 1, sep-1 )
			strText2_msg = string.sub( strText, sep+1 )
		end

		table.insert( tab, strText2_name )
		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": "..strText2_msg )
	end

	chat.AddText( unpack( tab ) )

	return true

end









/*---------------------------------------------------------
  Stranded-Like info messages
---------------------------------------------------------*/
GM.InfoMessages = {}
GM.InfoMessageLine = 0

function SGS_PrintMessageMiniConsole( message, color )
	if LocalPlayer().PrintMessage then

		local text = message
		local dur = 1
		local col = color

		for k,v in pairs(GAMEMODE.InfoMessages) do
			v.drawline = v.drawline + 1
		end

		local message = {}
		message.Text = text
		message.Col = col
		message.Tab = 5
		message.drawline = 1

		GAMEMODE.InfoMessages[#GAMEMODE.InfoMessages + 1] = message
		GAMEMODE.InfoMessageLine = GAMEMODE.InfoMessageLine + 1

		--LocalPlayer():PrintMessage(2, text .. "\n")
		MsgC( col, text .. "\n" )
	end
end

net.Receive( "gms_sendmessage", function( length )
	if LocalPlayer().PrintMessage then

		local text = net.ReadString()
		local dur = net.ReadInt( 32 )
		local col = net.ReadString()
		local str = string.Explode(",",col)
		local col = Color(tonumber(str[1]),tonumber(str[2]),tonumber(str[3]),tonumber(str[4]))

		for k,v in pairs(GAMEMODE.InfoMessages) do
			v.drawline = v.drawline + 1
		end

		local message = {}
		message.Text = text
		message.Col = col
		message.Tab = 5
		message.drawline = 1

		GAMEMODE.InfoMessages[#GAMEMODE.InfoMessages + 1] = message
		GAMEMODE.InfoMessageLine = GAMEMODE.InfoMessageLine + 1

		--LocalPlayer():PrintMessage(2, text .. "\n")
		MsgC( col, text .. "\n" )
	end

end )


function GM.DrawMessages()
	if SGS.accepttos == false then return true end
end
hook.Add("HUDPaint","gms_drawmessages",GM.DrawMessages)



function GM.CheckTotalMessages()
	if #GAMEMODE.InfoMessages > 6 then
		GAMEMODE.InfoMessages[1] = nil
		GAMEMODE.InfoMessageLine = GAMEMODE.InfoMessageLine - 1
		table.remove(GAMEMODE.InfoMessages,1)
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

function GM:DrawDeathNotice(x, y)
	return
end

function GM:HUDDrawTargetID()
     return false
end

function GM:HUDWeaponPickedUp( wep )
 	return
end

function GM:HUDAmmoPickedUp( ItemName, Amount )
	return
end

net.Receive( "sgs_openrcache", function( length )

	SGS.ctype = net.ReadString()
	SGS_RCacheMenu()

end )

net.Receive( "sgs_opentcache", function( length )

	SGS.ctype = net.ReadString()
	SGS_TCacheMenu()

end )

net.Receive( "sgs_treetable", function( length )

	SGS.trees = net.ReadTable()

end )


function SGS_ToolTip(item)

	local tt = ""

	tt = tt .. item.title
	tt = tt .. "\n"
	tt = tt .. item.description
	tt = tt .. "\n\n"
	tt = tt .. "Item Requirements\n-----------------\n"

	for k, v in pairs(item.cost) do
		tt = tt .. CapAll(string.gsub(k, "_", " ")) .. ": " .. tostring(v) .. "\n"
	end
	tt = tt .. "\n"

	tt = tt .. "Level Requirements\n------------------\n"

	for k, v in pairs(item.reqlvl) do
		tt = tt .. CapAll(string.gsub(k, "_", " ")) .. ": " .. tostring(v) .. "\n"
	end



	return tt

end

function SGS_SpellToolTip(item)

	local tt = ""

	tt = tt .. item.name
	tt = tt .. "\n"
	tt = tt .. item.description
	tt = tt .. "\n\n"
	tt = tt .. "Spell Requirements\n-----------------\n"

	for k, v in pairs(item.cost) do
		tt = tt .. CapAll(string.gsub(k, "_", " ")) .. ": " .. tostring(v) .. "\n"
	end
	tt = tt .. "\n"

	tt = tt .. "Level Requirements\n------------------\n"
	tt = tt .. "Arcane: " .. tostring(item.reqlvl) .. "\n"

	return tt

end

function SGS_ToolTipShop(item)
	local cost = item.cost
	if GAMEMODE.Tribes:GetTribeLevel( LocalPlayer() ) >= 10 then
		cost = math.ceil(cost * 0.9)
	end
	local tt = ""

	tt = tt .. item.title
	tt = tt .. "\n"
	tt = tt .. item.description
	tt = tt .. "\n\n"
	tt = tt .. "Item Requirements\n-----------------\n"

	tt = tt .. "GTokens: " .. cost .. "\n"

	return tt

end

function SGS_ToolTipShop2(item)

	local tt = ""

	tt = tt .. item.title
	tt = tt .. "\n"
	tt = tt .. item.description
	tt = tt .. "\n\n"
	tt = tt .. "Item Requirements\n-----------------\n"

	tt = tt .. "Candy Canes: " .. item.cost .. "\n"

	return tt

end

function SGS_ToolTipShort(item)

	local tt = ""

	tt = tt .. ( item.title or item.name )
	tt = tt .. "\n"
	tt = tt .. item.description

	return tt

end

function SGS_PetTooltip( pet )

	local tt = ""
	tt = tt .. pet.name or "UNNAMED"
	tt = tt .. "\n"
	tt = tt .. "Age: " .. (pet.age or "1")
	tt = tt .. "\n"
	tt = tt .. "Skill: " .. (pet.skill or "1")

	return tt

end


function SGS_MyCalcView(ply, pos, angles, fov)

	if ply:InVehicle() then
		return GAMEMODE:CalcVehicleView( ply:GetVehicle(), ply, { origin = pos, angles = angles, fov = fov } )
	end

	if SGS.person == "third" then

		local view = {}
		if SGS.amode then
			view.origin = pos - ( angles:Forward() * 60 ) - ( angles:Up() * 48 )
		else
			view.origin = pos - ( angles:Forward() * 45 ) + ( angles:Right() * 25 )
		end

		view.angles = angles
		view.fov = fov

		local trace = {}
		if SGS.amode then
			trace.start = LocalPlayer():GetShootPos() - ( angles:Up() * 48 )
		else
			trace.start = LocalPlayer():GetShootPos()
		end
		trace.endpos = view.origin
		trace.filter = ents.FindByClass("player")

		local tr = util.TraceLine(trace)

		if tr.Hit then
			--SGS.camhit = true
			view.origin = tr.HitPos
			return view
		else
			SGS.camhit = false
			return view
		end
	end

end
hook.Add("CalcView", "SGS_MyCalcView", SGS_MyCalcView)

function GM:CalcVehicleView( veh, ply, view )
	if ply:GetAttachment(ply:LookupAttachment("eyes")) then
		view.origin = ply:GetAttachment(ply:LookupAttachment("eyes")).Pos + ply:GetAngles():Forward() * 1
	else
		view.origin = ply:LocalToWorld(ply:OBBCenter()) + ply:GetAngles():Forward() * 5 + ply:GetAngles():Up() * 5
	end


	return view
end

function SGS_DrawLocalPlayer(ply)
	if ply:InVehicle() then
		local ang = ply:GetVehicle():WorldToLocalAngles( EyeAngles() )
		if ang.p < 0 then
			return
		end
	end

	if SGS.person == "third" then
		if SGS.camhit == false then
			return true
		end
	end
 end
 hook.Add("ShouldDrawLocalPlayer", "SGS_DrawLocalPlayer", SGS_DrawLocalPlayer)


function SGS_CreateDerma()
	
	local Avatar = vgui.Create( "AvatarImage" )
	Avatar:SetSize( 64, 64 )
	Avatar:SetPos( 8, ScrH() - 72 )
	Avatar:SetPlayer( LocalPlayer(), 64 )
	
	--[[
	SGS.topbar = vgui.Create("sgs_topbar")
	SGS.topbar:SetVisible(true)
	
	SGS.needshud = vgui.Create("sgs_needshud")
	SGS.needshud:SetVisible(true)
	]]
end


function GM:OnSpawnMenuOpen()
	if not (LocalPlayer():GetInitialized() == INITSTATE_OK) then return end

	GAMEMODE.newQMenu:ShowMenu()
	RunConsoleCommand("sgs_refreshspp")
		
	--[[
	if not IsValid( SGS.tabmenu ) then
		SGS.tabmenu = vgui.Create("sgs_tabmenu")
	end

	RunConsoleCommand("sgs_refreshspp")
	SGS.tabmenu:SetVisible( true )
	SGS.tabmenu:MakePopup()
	SGS.tabmenu:SetKeyboardInputEnabled( false )
	gui.EnableScreenClicker(true)
	RestoreCursorPosition()
	]]
end

function GM:OnSpawnMenuClose()
	if not (LocalPlayer():GetInitialized() == INITSTATE_OK) then return end
	
	GAMEMODE.newQMenu:HideMenu()
	--[[
	SGS.tabmenu:SetVisible( false )
	RememberCursorPosition()
	gui.EnableScreenClicker(false)
	]]
end

function SGS_PlayErrorSound(shake)
	surface.PlaySound( Sound("garrysmod/content_downloaded.wav") )
	if shake then
		util.ScreenShake( LocalPlayer():GetPos(), 10, 10, 1, 0 )
	end
end


function SGS_WatchMouseWheel( _, bind )

	if string.find("invprev",string.lower(bind)) then
		SGS_ScrollTool(1)
	elseif string.find("invnext",string.lower(bind)) then
		SGS_ScrollTool(-1)
	end

end
hook.Add( "PlayerBindPress", "SGS_WatchMouseWheel", SGS_WatchMouseWheel )

function SGS_ScrollTool( mod )

	if LocalPlayer().isgrab then return end
	if LocalPlayer():InVehicle() then return end
	if not LocalPlayer():Alive() then return end

	local total = #SGS.hotbarscrollitems
	local newitem = SGS.scrollitem + mod

	if newitem > total then newitem = 1 end
	if newitem <= 0 then newitem = total end
	SGS.scrollitem = newitem

	RunConsoleCommand("SGS_EquipTools", SGS.hotbarscrollitems[newitem])
	surface.PlaySound( "buttons/lightswitch2.wav" )

end


function SGS_HotBarTools( _, bind )

	if string.find("slot1",string.lower(bind)) then
		if SGS.HotBarcontents[1] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[1] ) == "tool" then
				RunConsoleCommand("SGS_EquipTools", SGS.HotBarcontents[1])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[1] ) == "edible" then
				RunConsoleCommand("sgs_eat", SGS.HotBarcontents[1])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[1] ) == "potion" then
				RunConsoleCommand("sgs_pdrink", SGS.HotBarcontents[1])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[1] ) == "spell" then
				RunConsoleCommand("sgs_cast", SGS.HotBarcontents[1])
			end
		end
	elseif string.find("slot2",string.lower(bind)) then
		if SGS.HotBarcontents[2] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[2] ) == "tool" then
				RunConsoleCommand("SGS_EquipTools", SGS.HotBarcontents[2])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[2] ) == "edible" then
				RunConsoleCommand("sgs_eat", SGS.HotBarcontents[2])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[2] ) == "potion" then
				RunConsoleCommand("sgs_pdrink", SGS.HotBarcontents[2])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[2] ) == "spell" then
				RunConsoleCommand("sgs_cast", SGS.HotBarcontents[2])
			end
		end
	elseif string.find("slot3",string.lower(bind)) then
		if SGS.HotBarcontents[3] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[3] ) == "tool" then
				RunConsoleCommand("SGS_EquipTools", SGS.HotBarcontents[3])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[3] ) == "edible" then
				RunConsoleCommand("sgs_eat", SGS.HotBarcontents[3])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[3] ) == "potion" then
				RunConsoleCommand("sgs_pdrink", SGS.HotBarcontents[3])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[3] ) == "spell" then
				RunConsoleCommand("sgs_cast", SGS.HotBarcontents[3])
			end
		end
	elseif string.find("slot4",string.lower(bind)) then
		if SGS.HotBarcontents[4] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[4] ) == "tool" then
				RunConsoleCommand("SGS_EquipTools", SGS.HotBarcontents[4])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[4] ) == "edible" then
				RunConsoleCommand("sgs_eat", SGS.HotBarcontents[4])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[4] ) == "potion" then
				RunConsoleCommand("sgs_pdrink", SGS.HotBarcontents[4])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[4] ) == "spell" then
				RunConsoleCommand("sgs_cast", SGS.HotBarcontents[4])
			end
		end
	elseif string.find("slot5",string.lower(bind)) then
		if SGS.HotBarcontents[5] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[5] ) == "tool" then
				RunConsoleCommand("SGS_EquipTools", SGS.HotBarcontents[5])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[5] ) == "edible" then
				RunConsoleCommand("sgs_eat", SGS.HotBarcontents[5])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[5] ) == "potion" then
				RunConsoleCommand("sgs_pdrink", SGS.HotBarcontents[5])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[5] ) == "spell" then
				RunConsoleCommand("sgs_cast", SGS.HotBarcontents[5])
			end
		end
	elseif string.find("slot6",string.lower(bind)) then
		if SGS.HotBarcontents[6] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[6] ) == "tool" then
				RunConsoleCommand("SGS_EquipTools", SGS.HotBarcontents[6])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[6] ) == "edible" then
				RunConsoleCommand("sgs_eat", SGS.HotBarcontents[6])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[6] ) == "potion" then
				RunConsoleCommand("sgs_pdrink", SGS.HotBarcontents[6])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[6] ) == "spell" then
				RunConsoleCommand("sgs_cast", SGS.HotBarcontents[6])
			end
		end
	elseif string.find("slot7",string.lower(bind)) then
		if SGS.HotBarcontents[7] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[7] ) == "tool" then
				RunConsoleCommand("SGS_EquipTools", SGS.HotBarcontents[7])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[7] ) == "edible" then
				RunConsoleCommand("sgs_eat", SGS.HotBarcontents[7])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[7] ) == "potion" then
				RunConsoleCommand("sgs_pdrink", SGS.HotBarcontents[7])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[7] ) == "spell" then
				RunConsoleCommand("sgs_cast", SGS.HotBarcontents[7])
			end
		end
	elseif string.find("slot8",string.lower(bind)) then
		if SGS.HotBarcontents[8] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[8] ) == "tool" then
				RunConsoleCommand("SGS_EquipTools", SGS.HotBarcontents[8])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[8] ) == "edible" then
				RunConsoleCommand("sgs_eat", SGS.HotBarcontents[8])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[8] ) == "potion" then
				RunConsoleCommand("sgs_pdrink", SGS.HotBarcontents[8])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[8] ) == "spell" then
				RunConsoleCommand("sgs_cast", SGS.HotBarcontents[8])
			end
		end
	elseif string.find("slot9",string.lower(bind)) then
		if SGS.HotBarcontents[9] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[9] ) == "tool" then
				RunConsoleCommand("SGS_EquipTools", SGS.HotBarcontents[9])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[9] ) == "edible" then
				RunConsoleCommand("sgs_eat", SGS.HotBarcontents[9])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[9] ) == "potion" then
				RunConsoleCommand("sgs_pdrink", SGS.HotBarcontents[9])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[9] ) == "spell" then
				RunConsoleCommand("sgs_cast", SGS.HotBarcontents[9])
			end
		end
	elseif string.find("slot0",string.lower(bind)) then
		if SGS.HotBarcontents[10] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[10] ) == "tool" then
				RunConsoleCommand("SGS_EquipTools", SGS.HotBarcontents[10])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[10] ) == "edible" then
				RunConsoleCommand("sgs_eat", SGS.HotBarcontents[10])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[10] ) == "potion" then
				RunConsoleCommand("sgs_pdrink", SGS.HotBarcontents[10])
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[10] ) == "spell" then
				RunConsoleCommand("sgs_cast", SGS.HotBarcontents[10])
			end
		end
	end

end
hook.Add( "PlayerBindPress", "SGS_HotBarTools", SGS_HotBarTools )

function PlayerMeta:ShouldShowName()

	if LocalPlayer():GetNWBool("inpvp", false) == false then --Local Player NOT in PVP

		return true

	else --Local Player IS in PVP

		if self:GetNWBool("inpvp", false) then --Target Player IS in PVP

			if LocalPlayer():Team() == self:Team() then --Target and Local Player are same team

				if self:GetNWBool("hidefromteam", false) then --Target player is hiding name from teammates

					return false

				else --Target player is not hiding name from teammates

					return true

				end

			else --Target and local player are different teams

				return false

			end

		else --Target Player is NOT in PVP

			return true

		end

	end

	return true

end



local enablenames = true
local enabletitles = true
local textalign = 1
local distancemulti = 0.6
function DrawNameTitle()

	local vStart = LocalPlayer():GetPos()
	local vEnd

	for k, v in pairs(player.GetAll()) do

		if v:GetNWBool("adminmode", false) then continue end
		if v:Team() == 1002 then continue end
		if v:ShouldShowName() == false then continue end
		if v == LocalPlayer() then continue end


		local vStart = LocalPlayer():GetPos()
		local vEnd = v:GetPos() + Vector(0,0,25)
		local trace = {}

		trace.start = vStart
		trace.endpos = vEnd
		local trace = util.TraceLine( trace )

		if trace.HitWorld then
			local mepos = LocalPlayer():GetPos()
			local tpos = v:GetPos()
			local tdist = mepos:Distance(tpos)
			if tdist <= 2000 then

				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				draw.RoundedBoxEx( 2, pos.x - 4, pos.y - 4, 8, 8, team.GetColor(v:Team()), true, true, true, true )

			end
		else
			local mepos = LocalPlayer():GetPos()
			local tpos = v:GetPos()
			local tdist = mepos:Distance(tpos)

			if tdist <= 600 then
				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()

				if v != LocalPlayer() then
					draw.SimpleTextOutlined( v:Name(), "SGS_HUD3", pos.x, pos.y - 25, team.GetColor(v:Team()), textalign, 1,1,Color(0,0,0,255))
					draw.SimpleTextOutlined("[" .. team.GetName( v:Team() ) .. "]", "SGS_HUD3", pos.x, pos.y - 10, team.GetColor(v:Team()),textalign,1,1,Color(0,0,0,255))
					if v:GetNWBool("inpvp", false) then
						draw.SimpleTextOutlined("::PvP::", "SGS_HUD3", pos.x, pos.y + 5, Color(255,0,0,alphavalue),textalign,1,1,Color(0,0,0,255))
					end
				end
			elseif tdist > 600 and tdist <= 2000 then

				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				draw.RoundedBoxEx( 2, pos.x - 4, pos.y - 4, 8, 8, team.GetColor(v:Team()), true, true, true, true )

			end
		end
	end
end
hook.Add("HUDPaint", "DrawNameTitle", DrawNameTitle)

function SGS_HUD_Main()
	pl = LocalPlayer()

	if not SGS.needs then
		SGS.needs = {}
		SGS.needs["fatigue"] = 1000
		SGS.needs["hunger"] = 1000
		SGS.needs["thirst"] = 1000
	end


	if SGS.accepttos == false then return end
	--SPP DISPLAY--
	local tr = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
	if(tr.HitNonWorld) then
		if(tr.Entity:IsValid() and !tr.Entity:IsPlayer() and !LocalPlayer():InVehicle()) then
			local PropOwner = "Owner: "
			local OwnerObj = tr.Entity:GetNetworkedEntity("OwnerObj", false)
			if(OwnerObj and OwnerObj:IsValid() and OwnerObj:IsPlayer()) then
				PropOwner = PropOwner..OwnerObj:Name()
			else
				OwnerObj = tr.Entity:GetNetworkedString("Owner", "N/A")
				if(type(OwnerObj) == "string") then
					PropOwner = PropOwner..OwnerObj
				elseif(IsValid(OwnerObj) and OwnerObj:IsPlayer()) then
					PropOwner = PropOwner..OwnerObj:Name()
				else
					PropOwner = PropOwner.."N/A"
				end
			end
			if tr.Entity:GetNWBool("shared", false) then
				PropOwner = PropOwner.. " (SHARED)"
			end
			if tr.Entity:GetNWBool("tribeshared", false) then
				PropOwner = PropOwner.. " (TRIBE)"
			end
			surface.SetFont( "SGS_HUD2" )
			local Width, Height = surface.GetTextSize(PropOwner)
			Width = Width + 25

			
			surface.SetDrawColor( 0, 0, 0, 210 )
			surface.DrawRect( ScrW() - (Width + 8) - 110, 6, Width + 12, Height + 16 )
			surface.DrawRect( ScrW() - (Width + 8) - 107, 9, Width + 6, Height + 10 )
			
			draw.SimpleText(PropOwner, "SGS_HUD2", ScrW() - (Width / 2) - 115, 21, Color(255, 255, 255, 255), 1, 1)
		end
	end

	--TREE OWNER DISPLAY--
	local tr = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
	if(tr.HitNonWorld) then
		if tr.Entity:IsValid() and tr.Entity:IsTree() then
			if tr.Entity:GetPos():DistToSqr( LocalPlayer():GetPos() ) <= 62500 then
				local PropOwner = "Planted By: "
				local owner = "World"
				if SGS.trees[tr.Entity] then
					owner = SGS.trees[tr.Entity]
				end
				local OwnerObj = owner
				PropOwner = PropOwner..OwnerObj

				draw.SimpleTextOutlined(PropOwner, "SGS_HUD2", ( ScrW() / 2 ) , ( ScrH() / 2 ) + 80, Color(255, 255, 255, 255), 1, 1, 1, Color(0,0,0,255))
			end
		end
	end

	--TRANSLATED RESOURCE DISPLAY--
	local tr = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
	if(tr.HitNonWorld) then
		if tr.Entity:IsValid() then
			if tr.Entity:GetPos():DistToSqr( LocalPlayer():GetPos() ) <= 62500 then
				if SGS_LookupResourceTranslation( tr.Entity:GetClass() ) then
					local translated = SGS_LookupResourceTranslation( tr.Entity:GetClass() )
					draw.SimpleTextOutlined(translated.name, "SGS_HUD2", ( ScrW() / 2 ) , ( ScrH() / 2 ) + 52, Color(255, 100, 100, 255), 1, 1, 1, Color(0,0,0,255))
					draw.SimpleTextOutlined("Required Level: " .. translated.rlvl, "SGS_HUD2", ( ScrW() / 2 ) , ( ScrH() / 2 ) + 66, Color(255, 255, 255, 255), 1, 1, 1, Color(0,0,0,255))
				end
			end
		end
	end

	--[[
	--Messages Window--

	draw.RoundedBoxEx( 16, ScrW() - 400, ScrH() - 95, 230, 95, Color(80, 80, 80, 150), true, false, false, false ) --Outter Box
	draw.RoundedBoxEx( 16, ScrW() - 170, ScrH() - 90, 170, 90, Color(80, 80, 80, 150), false, false, false, false ) --Outter Box 2
	draw.RoundedBoxEx( 2, ScrW() - 20, ScrH() - 95, 20, 5, Color(80, 80, 80, 150), false, false, false, false ) --Outter Box 2
	draw.RoundedBoxEx( 16, ScrW() - 395, ScrH() - 90, 395, 90, Color(50, 50, 50, 255), true, false, false, false ) --Inner Box

	--XP Window--
	local xpheight = 14 + ( #GAMEMODE.InfoXPMessages * 15 )
	draw.RoundedBoxEx( 4, ScrW() - 220, ScrH() - 90 - xpheight, 210, xpheight, Color(80, 80, 80, 150), true, true, false, false ) --Outter Box
	draw.RoundedBoxEx( 4, ScrW() - 215, ScrH() - 85 - xpheight, 200, xpheight - 5, Color(50, 50, 50, 255), true, true, false, false ) --Inner Box
	]]

end
hook.Add( "HUDPaint", "SGS_HUDMain", SGS_HUD_Main)

local ppex_sunbeams 			= CreateClientConVar( "ppex_sunbeams", 				"0", 		true, false )
local ppex_sunbeams_ignore 		= CreateClientConVar( "ppex_sunbeams_ignore", 			"0", 		false, false )
local ppex_sunbeams_darken		= CreateClientConVar( "ppex_sunbeams_darken", 		"0.95", 	false, false )
local ppex_sunbeams_multiply  	= CreateClientConVar( "ppex_sunbeams_multiply", 	"1.0", 		false, false )
local ppex_sunbeams_sunsize		= CreateClientConVar( "ppex_sunbeams_sunsize", 		"0.075", 	false, false )

local ppex_sunbeams_x_offset	= CreateClientConVar( "ppex_sunbeams_x_offset", 		"0.000", 	false, false )
local ppex_sunbeams_y_offset	= CreateClientConVar( "ppex_sunbeams_y_offset", 		"0.000", 	false, false )
local ppex_sunbeams_z_offset	= CreateClientConVar( "ppex_sunbeams_z_offset", 		"0.000", 	false, false )

function DrawSunBeamsCL()
	local modx = ppex_sunbeams_x_offset:GetFloat()
	local mody = ppex_sunbeams_y_offset:GetFloat()
	local modz = ppex_sunbeams_z_offset:GetFloat()

	local sun = util.GetSunInfo()
	if (!sun) then return end

	if !ppex_sunbeams_ignore:GetBool() && (sun.obstruction == 0) then return end

	sun.direction.x = sun.direction.x + modx
	sun.direction.y = sun.direction.y + mody
	sun.direction.z = sun.direction.z + modz

	local sunpos = EyePos() + sun.direction * 4096
	local scrpos = sunpos:ToScreen()

	local dot = (sun.direction:Dot( EyeVector() ) - 0.8) * 5
	if (dot <= 0) then return end

	local newmul = ppex_sunbeams_multiply:GetFloat()
	if ppex_sunbeams_ignore:GetBool() then
		newmul = newmul * dot
	else
		newmul = newmul * dot * sun.obstruction
	end

	DrawSunbeams( ppex_sunbeams_darken:GetFloat(),
				newmul,
				ppex_sunbeams_sunsize:GetFloat(),
				scrpos.x / ScrW(),
				scrpos.y / ScrH()
				);
end
hook.Add( "RenderScreenspaceEffects", "DrawSunBeamsCL", DrawSunBeamsCL )


-------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------


surface.CreateFont( "ScoreboardDefault",
{
	font		= "Helvetica",
	size		= 22,
	weight		= 800
})

surface.CreateFont( "ScoreboardDefaultTitle",
{
	font		= "Helvetica",
	size		= 32,
	weight		= 800
})

--[[---------------------------------------------------------
   Name: gamemode:HUDDrawScoreBoard( )
   Desc: If you prefer to draw your scoreboard the stupid way (without vgui)
-----------------------------------------------------------]]
function GM:HUDDrawScoreBoard()

end

matproxy.Add(
{
	name	=	"PlayerToolColor",

	init	=	function( self, mat, values )

		self.ResultTo = values.resultvar

	end,

	bind	=	function( self, mat, ent )

		if ( !IsValid( ent ) ) then return end

		local owner = ent:GetOwner();
		if ( !IsValid( owner ) ) then return end

		local col = owner:GetWeaponColor();

		mat:SetVector( self.ResultTo, col );

	end
})


function PlayerMeta:GetRagdollEntity()

	return self:GetNetworkedEntity( "m_hRagdollEntity" )

end

function DrawTorchLights()
	if SGS.showlights == false then return end
	local pl = LocalPlayer()
	for k, v in pairs( player.GetAll() ) do
		if IsValid( v:GetActiveWeapon() ) and v:GetActiveWeapon():GetClass() == "gms_handtorch" then
			local dis = pl:GetPos():DistToSqr( v:GetPos() )
			if dis <= SGS.drawlights then
				local dlight = DynamicLight( v:GetActiveWeapon():EntIndex() )
				if ( dlight ) then
					dlight.Pos = v:GetActiveWeapon():GetPos() + Vector(0,0,35)
					dlight.r = 255
					dlight.g = 100
					dlight.b = 50
					dlight.Brightness = 1.5
					dlight.MinLight = 0.01
					dlight.Size = 350
					dlight.Decay = 210 * 2
					dlight.DieTime = CurTime() + 1
					dlight.Style = 6
				end
			end
		end
	end
end
hook.Add( "Think", "drawTorchLights", DrawTorchLights )

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

g_OldTex = g_OldTex or surface.SetTexture
g_LastTexID = 0
function surface.SetTexture( id, ... )
    g_LastTexID = id
    return g_OldTex( id, ... )
end


function PlayerMeta:PlayerHasToolInGroup( group )
	for k, v in pairs( SGS.Tools[group] ) do
		if SGS_CheckTool(v.entity) then return true end
	end
	return false
end

function PlayerMeta:HowManyCasts( spell )
	local times = 100000
	for k, v in pairs( spell.cost ) do
		local stone_div = ( SGS.resources[ k ] or 0 ) / v
		if stone_div < times then times = stone_div end
	end
	times = math.floor( times )
	return times
end

function PlayerMeta:HasSeedsOfType( stype )
	for _, v in pairs( SGS.Seeds[ stype ] ) do
		if ( SGS.resources[ v.resource ] or 0 ) > 0 then
			return true
		end
	end
	return false
end

function PlayerMeta:CurrentEquippedTool()
	local tool = "None"
	if IsValid( self:GetActiveWeapon() ) then
		tool = SGS_ReverseToolLookup( self:GetActiveWeapon():GetClass()).title
	end
	return tool
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

net.Receive("GAT_ColorMessage", function(length )
	local message = net.ReadTable()
	chat.AddText( unpack( message ) )
end)