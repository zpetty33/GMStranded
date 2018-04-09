function HideHUD(name)
	for k, v in pairs( { "CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudWeaponSelection", "CHudHistoryResource", "CHudCrosshair" } ) do
		if name == v then return false end
	end
end
hook.Add( "HUDShouldDraw", "HideHUD", HideHUD)

function SGS_DrawCrosshair()
	if not LocalPlayer():Alive() then return end
	local trace = LocalPlayer():GetEyeTraceNoCursor()
	local hitpos = trace.HitPos
	local pos = hitpos:ToScreen()
	--Custom Crosshairs--
	local x = pos.x
	local y = pos.y
	
	if SGS.hudtimer[ "display" ] == true then return end

	surface.SetDrawColor( Color(255, 255, 255, 255) )
	

	--Stationary Inside--
	surface.DrawRect( x-1, y-1, 3, 3 )
	surface.DrawLine( x - 12, y, x - 5, y )
	surface.DrawLine( x + 12, y, x + 5, y )
	surface.DrawLine( x, y - 12, x, y - 5 )
	surface.DrawLine( x, y + 12, x, y + 5 )

	
	--Red Corners--
	surface.SetDrawColor( Color(255, 0, 0, 255) )
	surface.DrawLine( x - 8, y + 12, x - 12, y + 12 )
	surface.DrawLine( x - 12, y + 12, x - 12, y + 8 )
	surface.DrawLine( x - 12, y - 8, x - 12, y - 12 )
	surface.DrawLine( x - 12, y - 12, x - 8, y - 12 )
	surface.DrawLine( x + 8, y + 12, x + 12, y + 12 )
	surface.DrawLine( x + 12, y + 12, x + 12, y + 8 )
	surface.DrawLine( x + 12, y - 8, x + 12, y - 12 )
	surface.DrawLine(x + 12, y - 12, x + 8, y - 12 )

end
hook.Add( "HUDPaint", "SGS_DrawCrosshair", SGS_DrawCrosshair )



/*--------------------------------
---------HotBar Panels------------
--------------------------------*/

function SGS_OpenHotBar()

	if SGS.HotBar then
		SGS.HotBar:Remove()
		SGS.HotBar = nil
		SGS.hotbarinit = false
	else
		SGS.HotBar = vgui.Create( "sgs_HotBar" )
		SGS.HotBar:SetVisible(true)
		SGS.HotBar:SetZPos( 1100 )
	end
	
end

local PANEL = {}

function PANEL:Init()

    self:SetPos( ( ScrW() / 2 ) - ( 525 / 2 ), ScrH() - 68 )
    self:SetSize( 534, 64 )
    self:SetVisible(false)
	self:SetZPos( -99 )
	
	SGS.hotbarinit = true
	function ReloadHotBar()
		if ValidPanel(self) then self:DrawOthers() end
	end
	concommand.Add( "sgs_refreshhotbar", ReloadHotBar )
	
	self:DrawOthers()

end

function PANEL:Paint()

	--Main Window--	
	surface.SetDrawColor( 0, 0, 0, 210 )
	surface.DrawRect( 4, 4, 524, 56 ) --Icon Outter

end

function PANEL:DrawOthers()
	if ValidPanel( SGS.HotBarContainer ) then SGS.HotBarContainer:Remove() end

	SGS.HotBarContainer = vgui.Create( "DIconLayout", self)
	SGS.HotBarContainer:SetSize( 688, 48 )
	SGS.HotBarContainer:SetPos( 8, 8 )
	SGS.HotBarContainer:SetSpaceY( 0 )
	SGS.HotBarContainer:SetSpaceX( 4 )
	
	local ugroup = "guest"
	
	if LocalPlayer():IsMember() then ugroup = "member" end
	if LocalPlayer():IsDonator() then ugroup = "donator" end

	for i = 1, 10 do
		local HotBarSlot = vgui.Create( "sgs_HotBarslot" )
		HotBarSlot:SetSize( 48, 48 )
		HotBarSlot.slotID = i
		SGS.HotBarContainer:Add( HotBarSlot )
		HotBarSlot:Receiver( "HotbarDrop", function( pnl, tbl, dropped, menu, x, y )
			if ( !dropped ) then return end
			surface.PlaySound( "ui/buttonclickrelease.wav" )
			if tbl[1].dropType == "tool" then
				SGS_AssignHotBar( pnl.slotID, tbl[1].tool, true )
			elseif tbl[1].dropType == "spell" then
				SGS_AssignHotBarSpell( pnl.slotID, tbl[1].spell, true )
			end
		end )
		HotBarSlot:Receiver( "resourceDrop", function( pnl, tbl, dropped, menu, x, y )
			if ( !dropped ) then return end
			surface.PlaySound( "ui/buttonclickrelease.wav" )
			if tbl[1].dropType == "consumable" then
				SGS_AssignHotBarConsumable( pnl.slotID, tbl[1].res, true )
			end
		end )
		if SGS.HotBarcontents[i] then
			if SGS_HotBarReturnType( SGS.HotBarcontents[i] ) == "tool" then
				HotBarSlot:SetUpSlot( i, ugroup, "tool" )
				if SGS_CheckOwnership(SGS.HotBarcontents[i]) then
					local item = SGS_ReverseToolLookup(SGS.HotBarcontents[i])
					local HotBarButton = vgui.Create( "sgs_HotBarbutton", HotBarSlot)
					HotBarButton:SetupButton( 0, 0, 48, 48, item, i, "tool" )
				else
					SGS.HotBarcontents[i] = nil
					LocalPlayer():SetPData("sgs13HotBar_slot" .. tostring(i), "NONE")
				end
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[i] ) == "edible" then
				HotBarSlot:SetUpSlot( i, ugroup, "edible" )
				if SGS_CheckInventory(SGS.HotBarcontents[i]) then
					local item = SGS_ReverseFoodLookup(SGS.HotBarcontents[i])
					local HotBarButton = vgui.Create( "sgs_HotBarbutton", HotBarSlot)
					HotBarButton:SetupButton( 0, 0, 48, 48, item, i, "edible" )
				else
					SGS.HotBarcontents[i] = nil
					LocalPlayer():SetPData("sgs13HotBar_slot" .. tostring(i), "NONE")
				end
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[i] ) == "potion" then
				HotBarSlot:SetUpSlot( i, ugroup, "potion" )
				if SGS_CheckInventory(SGS.HotBarcontents[i]) then
					local item = SGS_ReversePotionLookup(SGS.HotBarcontents[i])
					local HotBarButton = vgui.Create( "sgs_HotBarbutton", HotBarSlot)
					HotBarButton:SetupButton( 0, 0, 48, 48, item, i, "potion" )
				else
					SGS.HotBarcontents[i] = nil
					LocalPlayer():SetPData("sgs13HotBar_slot" .. tostring(i), "NONE")
				end
			elseif SGS_HotBarReturnType( SGS.HotBarcontents[i] ) == "spell" then
				HotBarSlot:SetUpSlot( i, ugroup, "spell" )
				local item = SGS_ReverseSpellLookup(SGS.HotBarcontents[i])
				--print( item )
				local HotBarButton = vgui.Create( "sgs_HotBarbutton", HotBarSlot)
				HotBarButton:SetupButton( 0, 0, 48, 48, item, i, "spell" )
			end
		end
		HotBarSlot:SetUpSlot( i, ugroup, "none" )
	end
end
vgui.Register("sgs_HotBar", PANEL, "EditablePanel")


/*--------------------------------
----------HotBar Slots------------
--------------------------------*/

local PANEL = {}

function PANEL:Init()

	self.ready = false

end

function PANEL:Paint()

	if self.ready == false then return end

	surface.SetDrawColor( 0, 0, 0, 210 )
	surface.DrawRect( 0, 0, 48, 48 ) --Icon Outter
	
	local bnumber = tostring( self.index )
	if bnumber == "10" then bnumber = "0" end
	
	draw.SimpleText(bnumber, "HotBarnumbers", 3, 1, Color(255, 255,255, 255), 0, 0)
	
end

function PANEL:SetUpSlot( index, ugroup, stype )

	self.index = index
	self.ugroup = ugroup
	self.stype = stype

	self.ready = true

end
vgui.Register("sgs_HotBarslot", PANEL, "EditablePanel")


/*--------------------------------
---------HotBar Buttons-----------
--------------------------------*/

local PANEL = {}

function PANEL:Init()

	self.ready = false

end

function PANEL:SetupButton( x, y, x2, y2, item, index, btype )
	--PrintTable(item)

	self:SetPos( x, y )
	if btype == "tool" then
		self:SetMaterial( item.icon )
	elseif btype == "edible" then
		self:SetMaterial( item.material )
	elseif btype == "potion" then
		self:SetMaterial( item.material )
	elseif btype == "spell" then
		self:SetMaterial( item.material )
	end
	self:SetSize( x2, y2 )
	self:SetToolTip( SGS_ToolTipShort(item) )
	
	self.item = item
	self.index = index
	self.btype = btype
	
	self.ready = true

end


function PANEL:DoClick()

	surface.PlaySound( "ui/buttonclickrelease.wav" )
	if self.btype == "tool" then
		RunConsoleCommand("SGS_EquipTools", self.item.entity)
	elseif self.btype == "edible" then
		RunConsoleCommand("sgs_eat", self.item.name)
	elseif self.btype == "potion" then
		RunConsoleCommand("sgs_pdrink", self.item.mname)
	elseif self.btype == "spell" then
		RunConsoleCommand("sgs_cast", self.item.spell)
	end
	
end

function PANEL:DoRightClick()

	local DropDown = DermaMenu()
	DropDown:AddOption("Remove from HotBar", function() SGS_RemoveFromHotBar( self.index ) end )
	DropDown:Open()

end

function PANEL:PaintOver()

	if self.ready == false then return end
	
	local bnumber = tostring(self.index)
	if bnumber == "10" then bnumber = "0" end
	draw.SimpleText(bnumber, "HotBarnumbers", 3, 1, Color(255, 255,255, 255), 0, 0)

	if self.btype == "edible" or self.btype == "potion" then
		local count = SGS.resources[SGS.HotBarcontents[self.index]] or 0
		local len = string.len(tostring(count))
		draw.SimpleText(tostring(count), "HotBarnumbers", 38 - ( (len*7) - 7 ), 34, Color(255, 255, 0, 255), 0, 0)
	end

end
vgui.Register("sgs_HotBarbutton", PANEL, "DImageButton")



/*--------------------------------
--------Side Inventory------------
--------------------------------*/

function SGS_OpenSideInventory()

	if SGS.sideinventory then
		SGS.sideinventoryposx, SGS.sideinventoryposy = SGS.sideinventory:GetPos()
		SGS.sideinventory:Remove()
		SGS.sideinventory = nil
	else
		SGS.sideinventory = vgui.Create( "sgs_sideinventory" )
		SGS.sideinventory:SetVisible(true)
	end
	
end

local PANEL = {}

function PANEL:Init()
	self:ShowCloseButton(false)
	self:SetTitle("")


	self:SetPos( SGS.sideinventoryposx, SGS.sideinventoryposy ) 
	self:SetSize( 260, 625 )
    self:SetVisible(false)
	self:SetZPos( -99 )
	
	self:DrawOthers()

end

function PANEL:Paint()
	--if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "gmod_camera" then return end
	DFrame.Paint( self, self:GetWide(), self:GetTall() )


	--Main Window--
	draw.RoundedBoxEx( 8, 0, 0, 260, 625, Color(80, 80, 80, 150), true, true, true, true ) --Outter
	draw.RoundedBoxEx( 8, 4, 4, 252, 617, Color(0, 0, 0, 200), true, true, true, true ) --Inner
	
	draw.SimpleText("Inventory Quick-View", "SGS_HUD2", 62, 8, Color(255,200,60,255), 0, 0)
	
	draw.SimpleText("Inventory: " .. SGS.curinv .. " / " .. SGS.maxinv, "SGS_HUD2", 14, 580, Color(50,255,50,255), 0, 0)
	draw.SimpleText("Hold Q to free your mouse.", "SGS_HUD2", 14, 592, Color(120,160,255,255), 0, 0)
	draw.SimpleText("Double click an item to drop it", "SGS_HUD2", 14, 604, Color(120,160,255,255), 0, 0)
end

function PANEL:DrawOthers()

	local PlayerInventory = vgui.Create( "DListView" )
	PlayerInventory:SetParent( self )
	PlayerInventory:SetPos( 12, 24 )
	PlayerInventory:SetSize( 236, 554 )
	PlayerInventory:SetMultiSelect( false )
	PlayerInventory:AddColumn( "Resource Type" )
	PlayerInventory:AddColumn( "Amount" )	
	PlayerInventory.DoDoubleClick = function( p, i, l)
		SGS.temprType = l:GetValue(1)
		SGS.temprAmt = l:GetValue(2)
		SGS_DropFromSidePanel()
		end
		
	concommand.Add( "sgs_refreshsideinventory", function()
		if IsValid(PlayerInventory) then
			PlayerInventory:Clear()
			for k, v in pairs( SGS.resources ) do
				if v <= 0 then continue end
				PlayerInventory:AddLine( k, v )
			end
			PlayerInventory:SortByColumn( 1 )
		end
	end )
	RunConsoleCommand( "sgs_refreshsideinventory" )

end
vgui.Register("sgs_sideinventory", PANEL, "DFrame")




/*--------------------------------
------Side Inventory Drop---------
--------------------------------*/



function SGS_DropFromSidePanel()

	SGS.sideinventorydrop = vgui.Create( "sgs_sideinventorydrop" )
	SGS.sideinventorydrop:SetVisible(true)
	SGS.sideinventorydrop:MakePopup()

end

local PANEL = {}

function PANEL:Init()

	local width = 140
	local height = 124
	
	self:SetSize( width, height )
	self:SetPos( ( ScrW() / 2 ) - ( width / 2 ), ( ( ScrH() / 2 ) - ( height / 2 ) ) )
	self:SetVisible( false )
	
	self:DrawFrame()

end

function PANEL:Paint()
	
	draw.RoundedBoxEx( 8, 0, 0, 140, 124, Color( 80, 80, 80, 255 ), true, true, true, true )
	draw.RoundedBoxEx( 8, 4, 4, 132, 116, Color( 0, 0, 0, 255 ), true, true, true, true )
	
end

function PANEL:DrawFrame()	

	local CloseButton = vgui.Create( "DButton", self )
	CloseButton:SetSize( 12, 12 )
	CloseButton:SetPos( 118, 8 )
	CloseButton:SetText( "X" )
	CloseButton.DoClick = function( CloseButton )
		self:Remove()
	end
	
	local PopupTitle = vgui.Create("DLabel", self)
	PopupTitle:SetPos(8,8) // Position
	PopupTitle:SetColor(Color(255,255,50,255)) // Color
	PopupTitle:SetFont("SGS_RCacheMenuText")
	PopupTitle:SetText("Amount to Drop")
	PopupTitle:SizeToContents()
	
	local PopupTitleRes = vgui.Create("DLabel", self)
	PopupTitleRes:SetPos(8,24) // Position
	PopupTitleRes:SetColor(Color(255,80,80,255)) // Color
	PopupTitleRes:SetFont("SGS_RCacheMenuText")
	PopupTitleRes:SetText(CapAll((string.gsub(SGS.temprType, "_", " "))))
	PopupTitleRes:SizeToContents()
	
	local TextEntry = vgui.Create( "DTextEntry", self )
	TextEntry:SetWide( 120 )
	TextEntry:SetPos( 10, 44 )
	TextEntry:SetText( SGS.temprAmt )
	TextEntry:SetEditable( true )
	
	local SetAllButton = vgui.Create( "DButton", self )
	SetAllButton:SetSize( 58, 18 )
	SetAllButton:SetPos( 10, 90 )
	SetAllButton:SetText( "Set All" )
	SetAllButton.DoClick = function( SetAllButton )
		TextEntry:SetText( SGS.temprAmt )
	end
	
	local SetOneButton = vgui.Create( "DButton", self )
	SetOneButton:SetSize( 58, 18 )
	SetOneButton:SetPos( 72, 90 )
	SetOneButton:SetText( "Set One" )
	SetOneButton.DoClick = function( SetOneButton )
		TextEntry:SetText( "1" )
	end	
	
	local DropButton = vgui.Create( "DButton", self )
	DropButton:SetSize( 120, 18 )
	DropButton:SetPos( 10, 68 )
	DropButton:SetText( "Drop" )
	DropButton.DoClick = function( DropButton )
		RunConsoleCommand("sgs_dropresource", SGS.temprType, TextEntry:GetValue())
		self:Remove()
	end

end
vgui.Register( "sgs_sideinventorydrop", PANEL, "EditablePanel" )


surface.CreateFont( "DeathNotice1",
{
	font		= "Helvetica",
	size		= 36,
	weight		= 800,
	shadow		= true
})
surface.CreateFont( "DeathNotice2",
{
	font		= "Helvetica",
	size		= 24,
	weight		= 800,
	shadow		= true
})
surface.CreateFont( "DeathNotice3",
{
	font		= "Helvetica",
	size		= 14,
	weight		= 800,
	shadow		= true
})
surface.CreateFont( "DeathNotice4",
{
	font		= "Helvetica",
	size		= 18,
	weight		= 800,
	shadow		= true
})
surface.CreateFont( "DeathNotice5",
{
	font		= "Helvetica",
	size		= 64,
	weight		= 800,
	shadow		= false
})
surface.CreateFont( "DeathNotice6",
{
	font		= "Tahoma",
	size		= 124,
	weight		= 800,
	shadow		= false
})


--DEATH HUD
function SGS_DeathHUD()
	if not LocalPlayer():GetNWBool("displaydeathnotice", false) then return end
	draw.RoundedBoxEx( 4, ScrW() / 2 - 300, ScrH() / 2 - 225, 600, 450, Color(80, 80, 80, 200), true, true, true, true )
	draw.RoundedBoxEx( 4, ScrW() / 2 - 296, ScrH() / 2 - 221, 592, 442, Color(50, 50, 50, 200), true, true, true, true )
	local keyword = "respawn"
	if LocalPlayer():Alive() then keyword = "close" end
	draw.DrawText( "Press Jump (Defult: Space) to " .. keyword .. "!", "DeathNotice4", ScrW() / 2, ScrH() / 2 - 210, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	draw.DrawText( "You Have Died!", "DeathNotice1", ScrW() / 2, ScrH() / 2 - 190, Color( 255, 20, 20, 255 ), TEXT_ALIGN_CENTER )
	draw.DrawText( "You Were Killed By: ", "DeathNotice2", ScrW() / 2 - 280, ScrH() / 2 - 130 , Color( 255, 20, 20, 255 ), TEXT_ALIGN_LEFT )
	draw.DrawText( SGS.killerstring, "DeathNotice2", ScrW() / 2 - 80, ScrH() / 2 - 130 , Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
	draw.DrawText( "Items Dropped: ", "DeathNotice2", ScrW() / 2 - 280, ScrH() / 2 - 80 , Color( 255, 20, 20, 255 ), TEXT_ALIGN_LEFT )
	draw.DrawText( "Items Destroyed: ", "DeathNotice2", ScrW() / 2 - 80, ScrH() / 2 - 80 , Color( 255, 20, 20, 255 ), TEXT_ALIGN_LEFT )
	draw.DrawText( "Tools Dropped: ", "DeathNotice2", ScrW() / 2 + 140, ScrH() / 2 - 80 , Color( 255, 20, 20, 255 ), TEXT_ALIGN_LEFT )
	
	
	draw.DrawText( SGS.itemsdropped, "DeathNotice3", ScrW() / 2 - 280, ScrH() / 2 - 50 , Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
	draw.DrawText( SGS.itemsdestroyed, "DeathNotice3", ScrW() / 2 - 80, ScrH() / 2 - 50 , Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
	draw.DrawText( SGS.toolsdropped, "DeathNotice3", ScrW() / 2 + 140, ScrH() / 2 - 50 , Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
end
hook.Add( "HUDPaint", "SGS_DeathHUD", SGS_DeathHUD )

--DEATH HUD
function SGS_DeathHUD2()
	if LocalPlayer():Alive() then return end
	if LocalPlayer():GetNWBool("displaydeathnotice", false) then return end
	draw.DrawText( "You Are Near Death!", "DeathNotice5", ScrW() / 2 - 2, 148, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER )
	draw.DrawText( "You Are Near Death!", "DeathNotice5", ScrW() / 2, 150, Color( 255, 20, 20, 255 ), TEXT_ALIGN_CENTER )
	draw.DrawText( "Unless Resurrected You Will Die In:", "DeathNotice1", ScrW() / 2 - 2, 208, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER )
	draw.DrawText( "Unless Resurrected You Will Die In:", "DeathNotice1", ScrW() / 2, 210, Color( 255, 20, 20, 255 ), TEXT_ALIGN_CENTER )
	local timeleft = math.Clamp( LocalPlayer():GetNWInt("deathtotaltime", 60) - ( math.floor( CurTime() ) - LocalPlayer():GetNWInt("lastdeathtime") ), 0, LocalPlayer():GetNWInt("deathtotaltime", 60) )
	draw.DrawText( timeleft, "DeathNotice6", ScrW() / 2 -2, 298, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER )
	draw.DrawText( timeleft, "DeathNotice6", ScrW() / 2, 300, Color( 255, 20, 20, 255 ), TEXT_ALIGN_CENTER )
	
	draw.DrawText( "Press Reload (Default: R) To Skip Timer", "DeathNotice2", ScrW() / 2 -2, 430, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER )
	draw.DrawText( "Press Reload (Default: R) To Skip Timer", "DeathNotice2", ScrW() / 2, 432, Color( 255, 20, 20, 255 ), TEXT_ALIGN_CENTER )
	
end
hook.Add( "HUDPaint", "SGS_DeathHUD2", SGS_DeathHUD2 )





surface.CreateFont( "UnlockFont1",
{
	font		= "Tahoma",
	size		= 28,
	weight		= 800,
	shadow		= false
})
surface.CreateFont( "UnlockFont2",
{
	font		= "Tahoma",
	size		= 18,
	weight		= 800,
	shadow		= false
})

--UnlockHUD
local unlock_window_w = 350
local unlock_window_h = 100
local unlock_window_top = 75
function SGS_UnlockHUD()
	if not LocalPlayer().skillunlocktbl then return end
	if CurTime() > ( LocalPlayer().achievementstart or 0 ) + 8 then return end
	draw.RoundedBoxEx( 4, ScrW() / 2 - unlock_window_w/2, unlock_window_top, unlock_window_w, unlock_window_h, Color(80, 80, 80, 150), true, true, true, true )
	draw.RoundedBoxEx( 4, ScrW() / 2 - (unlock_window_w/2 - 4), unlock_window_top+4, unlock_window_w - 8, unlock_window_h - 8, Color(50, 50, 50, 150), true, true, true, true )
	
	draw.DrawText( "Congratulations!", "UnlockFont1", ScrW() / 2 - 2, unlock_window_top + 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	draw.DrawText( "You have reached " .. LocalPlayer().skillunlocktbl[1] .. " level: " .. LocalPlayer().skillunlocktbl[2], "UnlockFont2", ScrW() / 2 - 2, unlock_window_top + 35, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	draw.DrawText( LocalPlayer().skillunlocktbl[3], "UnlockFont2", ScrW() / 2 - 2, unlock_window_top + 60, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	draw.DrawText( LocalPlayer().skillunlocktbl[4], "UnlockFont2", ScrW() / 2 - 2, unlock_window_top + 75, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
end
hook.Add( "HUDPaint", "SGS_UnlockHUD", SGS_UnlockHUD )


function surface.PrecacheArc( cx, cy, radius, thickness, startang, endang, roughness, bClockwise )
	local triarc = {}
	local deg2rad = math.pi / 180
	
	-- Correct start/end ang
	local startang, endang = startang or 0, endang or 0
	if bClockwise and startang < endang then
		local temp = startang
		startang = endang
		endang = temp
		temp = nil
	elseif startang > endang then 
		local temp = startang
		startang = endang
		endang = temp
		temp = nil
	end
	-- Define step
	local roughness = math.max( roughness or 1, 1 )
	local step = roughness
	if bClockwise then
		step = math.abs( roughness ) * -1
	end
	-- Create the inner circle's points.
	local inner = {}
	local r = radius - thickness
	for deg=startang, endang, step do
		local rad = deg2rad * deg
		table.insert( inner, {
			x = cx + (math.cos(rad) * r),
			y = cy + (math.sin(rad) * r)
		} )
	end
	-- Create the outer circle's points.
	local outer = {}
	for deg=startang, endang, step do
		local rad = deg2rad * deg
		table.insert( outer, {
			x = cx + (math.cos(rad) * radius),
			y = cy + (math.sin(rad) * radius)
		} )
	end
	-- Triangulate the points.
	for tri = 1, #inner *2 do -- twice as many triangles as there are degrees.
		local p1,p2,p3
		p1 = outer[math.floor(tri /2) +1]
		p3 = inner[math.floor((tri +1) /2) +1]
		if tri %2 == 0 then --if the number is even use outer.
			p2 = outer[math.floor((tri +1) /2)]
		else
			p2 = inner[math.floor((tri +1) /2)]
		end
		table.insert( triarc, {p1, p2, p3} )
	end
	-- Return a table of triangles to draw.
	return triarc
end

function surface.DrawArc( arc )
	for k,v in ipairs(arc) do
		surface.DrawPoly( v )
	end
end

function draw.Arc( cx, cy, radius, thickness, startang, endang, roughness, color, bClockwise )
	surface.SetDrawColor( color )
	surface.DrawArc( surface.PrecacheArc(cx,cy,radius,thickness,startang,endang,roughness,bClockwise) )
end

local texID = surface.GetTextureID( "debug/debugvertexcolor" )
hook.Add( "PostRenderVGUI", "Circles", function()
	if ( SGS.hudtimer[ "display" ] or false ) == false then return end
	local angSeg = 205
	local angOffset = 270
	local size = 64
	local innerColor = Color(20, 200, 200, 220)
	
	if SGS.colors[ SGS.hudtimer[ "skill" ] ] then
		innerColor = SGS.colors[ SGS.hudtimer[ "skill" ] ]
	end
	
	local barlen = (SGS.hudtimer[ "etime" ] - CurTime()) / SGS.hudtimer[ "len" ]
	barlen = -barlen + 1
	local w = barlen * 360
	if barlen == 0 then w = 0 end
	
	angSeg = math.Clamp(w, 0, 360)
	
	surface.SetTexture( 0 )
	draw.Arc(
		ScrW() /2, --pos x
		ScrH() /2, --pos y
		size /2, --circle radius
		9, --border thickness
		angOffset, --start angle
		angOffset +360, --end angle
		4, --steps (smaller=more steps)
		Color(0, 0, 0, 180),
		false
	)
	draw.Arc(
		ScrW() /2, --pos x
		ScrH() /2, --pos y
		(size - 3) / 2, --circle radius
		6, --border thickness
		angOffset, --start angle
		angOffset +angSeg, --end angle
		4, --steps (smaller=more steps)
		innerColor,
		false
	)

	draw.SimpleTextOutlined(SGS.hudtimer[ "text" ], "SGS_HUD3", ( ScrW() / 2 ) , ( ScrH() / 2 ) -50, Color(255, 255, 255, 255), 1, 1, 1, Color(0,0,0,255))
	
	
	if CurTime() >= SGS.hudtimer[ "etime" ] then
		SGS.hudtimer[ "display" ] = false
	end
end )


--surface.CreateFont( "tahoma", 14, 600, true, false, "SGS_HUD3" )
surface.CreateFont( "SGS_NEWHUD1", {
	font	=	"tahoma",
	size	=	12
	}
)
--surface.CreateFont( "tahoma", 14, 600, true, false, "SGS_HUD3" )
surface.CreateFont( "SGS_NEWHUD5", {
	font	=	"tahoma",
	size	=	12,
	weight	=	800
	}
)
--surface.CreateFont( "tahoma", 14, 600, true, false, "SGS_HUD3" )
surface.CreateFont( "SGS_NEWHUD2", {
	font	=	"tahoma",
	size	=	14,
	weight	=	800
	}
)
--surface.CreateFont( "tahoma", 14, 600, true, false, "SGS_HUD3" )
surface.CreateFont( "SGS_NEWHUD3", {
	font	=	"tahoma",
	size	=	17,
	weight	=	800
	}
)
--surface.CreateFont( "tahoma", 14, 600, true, false, "SGS_HUD3" )
surface.CreateFont( "SGS_NEWHUD4", {
	font	=	"tahoma",
	size	=	17,
	weight	=	200
	}
)

function SGS_GetTotalSurvivalLevels()
	local total = SGS.levels["woodcutting"] + SGS.levels["mining"] + SGS.levels["construction"] + SGS.levels["smithing"] + SGS.levels["farming"] + SGS.levels["fishing"] + SGS.levels["cooking"] + SGS.levels["combat"] + SGS.levels["alchemy"] + SGS.levels["arcane"] - 10
	return total
end

CreateClientConVar( "sgs_enablehudnumbers", "0", true, false )
hungerIcon = Material( "vgui/hud/hunger.png", "noclamp smooth" )
thirstIcon = Material( "vgui/hud/thirst.png", "noclamp smooth" )
energyIcon = Material( "vgui/hud/energy.png" )
healthIcon = Material( "vgui/hud/health.png" )
playerIcon = Material( "vgui/hud/player.png" )
tribeIcon = Material( "vgui/hud/tribe.png" )
coinsIcon = Material( "vgui/hud/coins.png" )
oxygenIcon = Material( "vgui/hud/oxygen.png" )
potionIcon = Material( "vgui/hud/potion.png" )
houseIcon = Material( "vgui/hud/house.png" )
bleedIcon = Material( "vgui/hud/blood.png" )
brokenIcon = Material( "vgui/hud/brokenbone.png" )
melonaidsIcon = Material( "vgui/hud/melonaids.png" )
function SGS_AllThingsHUD()
	if SGS.accepttos == false then return end
	if LocalPlayer().showKeybinds == nil then LocalPlayer().showKeybinds = true end
	local lastExp = SGS.last_skill_exp or "mining"
	local skillFade = SGS.skillFade or 1
	
	--Drawing the Needs Bars
	local x = 6
	local y = ScrH() - 6
	
	--Drawing all of the outter boxes
	surface.SetDrawColor( 0, 0, 0, 210 )
	surface.DrawRect( x, y - 68, 68, 68 ) --Icon Outter
	
	surface.DrawRect( x + 72, y - 68, 160, 20 ) --Hunger Outter
	surface.DrawRect( x + 102, y - 65, 127, 14 ) --Hunger Inner
	
	surface.DrawRect( x + 72, y - 44, 160, 20 ) --Thirst Outter
	surface.DrawRect( x + 102, y - 41, 127, 14 ) --Thirst Inner
	
	surface.DrawRect( x + 72, y - 20, 160, 20 ) --Energy Outter
	surface.DrawRect( x + 102, y - 17, 127, 14 ) --Energy Inner
	
	surface.DrawRect( x, y - 98, 232, 26 ) 		--Health Outter
	surface.DrawRect( x + 26, y - 94, 202, 18 ) --Health Inner
	
	surface.DrawRect( x, y - 122, 160, 20 ) 	--Tribe Outter
	surface.DrawRect( x + 26, y - 119, 131, 14 ) --Tribe Inner
	
	surface.DrawRect( x, y - 146, 160, 20 )		--Name Outter
	surface.DrawRect( x + 26, y - 143, 131, 14 ) --Name Inner
	
	surface.DrawRect( ScrW() - 406, y - 106, 400, 106 ) --Minconsole Outter
	surface.DrawRect( ScrW() - 403, y - 103, 394, 100 ) --Minconsole Inner
	
	surface.DrawRect( ScrW() - 406, y - 140, 400, 30 ) --Survival Level Outt1er
	surface.DrawRect( ScrW() - 403, y - 125, 394, 12 ) --Survival Level Bar Inner
	
	surface.SetDrawColor( 0, 0, 0, 210 * skillFade )
	surface.DrawRect( ScrW() - 406, y - 187, 400, 43 ) --Skill Level Outter
	surface.DrawRect( ScrW() - 403, y - 159, 394, 12 ) --Skill Level Bar Inner
	
	surface.SetDrawColor( 0, 0, 0, 210 )
	surface.DrawRect( ScrW() - 102, 6, 96, 115 ) --Clock Outter
	surface.DrawRect( ScrW() - 99, 9, 90, 20 ) --Clock Inner 1
	surface.DrawRect( ScrW() - 99, 49, 90, 20 ) --Clock Inner 2
	surface.DrawRect( ScrW() - 99, 98, 90, 20 ) --Clock Inner 3
	
	if LocalPlayer().showKeybinds then
	surface.DrawRect( x, 6, 126, 116 ) --Keybinds Outter
	surface.DrawRect( x + 3, 9, 120, 20 ) --Keybinds Inner
	end
	
	--Icons
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( hungerIcon	)
	surface.DrawTexturedRect( x + 80, y - 65, 14, 14 )
	surface.SetMaterial( thirstIcon	)
	surface.DrawTexturedRect( x + 80, y - 41, 14, 14 )
	surface.SetMaterial( energyIcon	)
	surface.DrawTexturedRect( x + 82, y - 17, 10, 14 )
	surface.SetMaterial( healthIcon	)
	surface.DrawTexturedRect( x + 5, y - 93, 16, 16 )
	surface.SetMaterial( playerIcon	)
	surface.DrawTexturedRect( x + 5, y - 143, 16, 16 )
	surface.SetMaterial( tribeIcon	)
	surface.DrawTexturedRect( x + 5, y - 119, 16, 16 )
	surface.SetMaterial( coinsIcon	)
	surface.DrawTexturedRect( ScrW() - 90 , 74, 16, 16 )
	if LocalPlayer():Sheltered() then
		surface.SetDrawColor( 255, 255, 255, 180 )
		surface.SetMaterial( houseIcon	)
		surface.DrawTexturedRect( 5 , y - 180, 32, 32 )
	end
	
	if LocalPlayer().bleeding then
		surface.SetDrawColor( 250, 180, 180, 180 )
		surface.SetMaterial( bleedIcon	)
		surface.DrawTexturedRect( 38 , y - 180, 32, 32 )
	end
	
	if LocalPlayer().brokenleg then
		surface.SetDrawColor( 255, 255, 255, 180 )
		surface.SetMaterial( brokenIcon	)
		surface.DrawTexturedRect( 70 , y - 175, 24, 24 )
	end
	
	if LocalPlayer().melonaids then
		surface.SetDrawColor( 255, 255, 255, 200 )
		surface.SetMaterial( melonaidsIcon	)
		surface.DrawTexturedRect( 100 , y - 175, 24, 24 )
	end
	
	if ( SGS.o2show or false ) == true then	
		-- Oxygen Meter
		surface.SetDrawColor( 0, 0, 0, 210 )
		surface.DrawRect( x + 235, y - 20, 160, 20 ) --Oxygen Outter
		surface.DrawRect( x + 265, y - 17, 127, 14 ) --Oxygen Inner
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( oxygenIcon	)
		surface.DrawTexturedRect( x + 242, y - 18, 16, 16 )
		surface.SetDrawColor( 0, 255, 255, 210 )
		local barlen = (SGS.o2 / SGS.maxneeds) * 127
		surface.DrawRect( x + 265, y - 17, barlen, 14 ) --Oxygen Meter
	end
	
	if ( LocalPlayer():GetNWBool( "potionshow", false ) or false ) == true then	
		-- Potion Meter
		surface.SetDrawColor( 0, 0, 0, 210 )
		surface.DrawRect( x + 235, y - 44, 160, 20 ) --Potion Outter
		surface.DrawRect( x + 265, y - 41, 127, 14 ) --Potion Inner
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( potionIcon	)
		surface.DrawTexturedRect( x + 242, y - 42, 16, 16 )
		surface.SetDrawColor( 255, 80, 255, 210 )
		local barlen = (LocalPlayer():GetNWInt("potionendtime", CurTime()) - CurTime()) / LocalPlayer():GetNWInt("potiontime", CurTime()) * 127
		surface.DrawRect( x + 265, y - 41, barlen, 14 )
	end
	
	--Health Bar
	surface.SetDrawColor( 255, 50, 50, 255 )
	local w = ( LocalPlayer():Health() / LocalPlayer():GetMaxHealth() ) * 202
	surface.DrawRect( x + 26, y - 94, w, 18 ) --Health Inner
	
	--Hunger Bar
	surface.SetDrawColor( 45, 190, 45, 255 )
	local w = ( SGS.needs["hunger"] / SGS.maxneeds ) * 127
	surface.DrawRect( x + 102, y - 65, w, 14 )
	
	--Thirst Bar
	surface.SetDrawColor( 120, 220, 255, 255 )
	local w = ( SGS.needs["thirst"] / SGS.maxneeds ) * 127
	surface.DrawRect( x + 102, y - 41, w, 14 )
	
	--Energy Bar
	surface.SetDrawColor( 220, 220, 0, 255 )
	local w = ( SGS.needs["fatigue"] / SGS.maxneeds ) * 127
	surface.DrawRect( x + 102, y - 17, w, 14 )
	
	if GetConVar("sgs_enablehudnumbers"):GetBool() then
		surface.SetFont( "SGS_NEWHUD2" )
		local message = math.Clamp( math.ceil(( LocalPlayer():Health() / LocalPlayer():GetMaxHealth() ) * 100), 0, 100 ) .. "%"
		local w, _ = surface.GetTextSize( message )
		surface.SetTextColor( 120, 120, 120, 255 )
		surface.SetTextPos( x + 134 - (w/2), y - 93 )
		surface.DrawText( message )
		surface.SetFont( "SGS_NEWHUD2" )
		local message = math.ceil(( SGS.needs["hunger"] / SGS.maxneeds ) * 100) .. "%"
		local w, _ = surface.GetTextSize( message )
		surface.SetTextColor( 120, 120, 120, 255 )
		surface.SetTextPos( x + 170 - (w/2), y - 65 )
		surface.DrawText( message )
		surface.SetFont( "SGS_NEWHUD2" )
		local message = math.ceil(( SGS.needs["thirst"] / SGS.maxneeds ) * 100) .. "%"
		local w, _ = surface.GetTextSize( message )
		surface.SetTextColor( 120, 120, 120, 255 )
		surface.SetTextPos( x + 170 - (w/2), y - 41 )
		surface.DrawText( message )		
		surface.SetFont( "SGS_NEWHUD2" )
		local message = math.ceil(( SGS.needs["fatigue"] / SGS.maxneeds ) * 100) .. "%"
		local w, _ = surface.GetTextSize( message )
		surface.SetTextColor( 120, 120, 120, 255 )
		surface.SetTextPos( x + 170 - (w/2), y - 17 )
		surface.DrawText( message )
	
	end
	
	
	--Survival Exp Bar
	local curLvl = SGS_GetTotalSurvivalLevels()
	surface.SetDrawColor( 150, 200, 0, 255 )
	local clvlexp = ( SGS.levels["survival"] - 1 ) * 20
	local nextexp = SGS.levels["survival"] * 20
	local w = ((SGS_GetTotalSurvivalLevels() - clvlexp) / (nextexp - clvlexp)) * 394
	surface.DrawRect( ScrW() - 403, y - 125, w, 12 )
	
	--Skill Exp Bar
	surface.SetDrawColor( SGS.colors[ lastExp ].r, SGS.colors[ lastExp ].g, SGS.colors[ lastExp ].b, 100 * skillFade )
	local w = ((SGS.exp[lastExp] - SGS.explist[SGS.levels[lastExp]])/ (SGS.explist[SGS.levels[lastExp] + 1] - SGS.explist[SGS.levels[lastExp]])) * 394
	surface.DrawRect( ScrW() - 403, y - 159, w, 12 )
	local w2 = ( ( SGS.last_skill_amt or 0 ) / (SGS.explist[SGS.levels[lastExp] + 1] - SGS.explist[SGS.levels[lastExp]])) * 394
	if w2 > w then w2 = w end
	surface.SetDrawColor( SGS.colors[ lastExp ].r, SGS.colors[ lastExp ].g, SGS.colors[ lastExp ].b, 255 * skillFade )
	surface.DrawRect( ScrW() - 403 + w - w2, y - 159, w2, 12 )
	
	--Player Name
	surface.SetFont( "SGS_NEWHUD1" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( x + 28, y - 142 )
	surface.DrawText( LocalPlayer():GetName() )
	
	--Tribe Name
	surface.SetFont( "SGS_NEWHUD1" )
	surface.SetTextColor( team.GetColor( LocalPlayer():Team() ) )
	surface.SetTextPos( x + 28, y - 118 )
	surface.DrawText( team.GetName( LocalPlayer():Team() ) )
	
	--Survival Level Text
	surface.SetFont( "SGS_NEWHUD5" )
	surface.SetTextColor( Color(255,255,255,255) )
	surface.SetTextPos( ScrW() - 399, y - 138 )
	surface.DrawText( "Survival lvl: " .. SGS.levels["survival"])
	local message = curLvl .. " / " .. SGS.levels["survival"] * 20
	local w, _ = surface.GetTextSize( message )
	surface.SetTextPos( ScrW() - 406 + 200 - ( w / 2 ), y - 138 )
	surface.DrawText(message)
	
	--Skill Level Text
	surface.SetFont( "SGS_NEWHUD5" )
	surface.SetTextColor( Color(255,255,255,255 * skillFade) )
	surface.SetTextPos( ScrW() - 399, y - 175 )
	surface.DrawText( "lvl: " .. SGS.levels[lastExp])
	local message = SGS.exp[lastExp] .. " / " .. SGS.explist[SGS.levels[lastExp] + 1]
	local w, _ = surface.GetTextSize( message )
	surface.SetTextPos( ScrW() - 406 + 200 - ( w / 2 ), y - 172 )
	surface.DrawText( message )
	surface.SetFont( "SGS_NEWHUD2" )
	local message = Cap(lastExp)
	local w, _ = surface.GetTextSize( message )
	surface.SetTextColor( Color(255,255,255,255 * skillFade) )
	surface.SetTextPos( ScrW() - 406 + 200 - ( w / 2 ), y - 186 )
	surface.DrawText( message )
	
	surface.SetFont( "SGS_NEWHUD5" )
	local message = SGS.last_skill_message or ""
	local w, _ = surface.GetTextSize( message )
	surface.SetTextColor( Color(255,255,255,255 * skillFade) )
	surface.SetTextPos( ScrW() - 10 - w, y - 175 )
	surface.DrawText( message )
	
	--Time Text
	surface.SetFont( "SGS_NEWHUD3" )
	local day = SGS_CheckTimeForDay( SGS.day )
	local time = tostring(SGS_CheckTimeForHour( SGS.time )) .. ":" .. tostring(SGS_CheckTimeForMinute( SGS.time ))
	w2, h2 = surface.GetTextSize(time)
	surface.SetTextPos( ScrW() - 52 - (w2 / 2), 10 )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.DrawText( time )	
	surface.SetFont( "SGS_NEWHUD4" )
	w, h = surface.GetTextSize(day)
	surface.SetTextPos( ScrW() - 52 - (w / 2), 30 )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.DrawText( day )
	
	surface.SetFont( "SGS_NEWHUD3" )
	surface.SetTextColor( 255, 0, 0, 255 )
	surface.SetTextPos( ScrW() - 86 , 50 )
	surface.DrawText( "PVP:"  )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( ScrW() - 50 , 50 )
	if LocalPlayer():GetNWBool("inpvp", false) == true then
		surface.DrawText( "ON"  )
	else
		surface.DrawText( "OFF"  )
	end
	surface.SetFont( "SGS_NEWHUD3" )
	surface.SetTextPos( ScrW() - 70 , 74 )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.DrawText( SGS.gtokens )
	
	surface.SetFont( "SGS_NEWHUD2" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( ScrW() - 90 , 100 )
	surface.DrawText( "V: " .. GAMEMODE.Version )
	
	if LocalPlayer().showKeybinds then
		--Keybinds
		local modi = 12
		surface.SetFont( "SGS_HUD2" )
		surface.SetTextPos( x + 15 , 11 )
		surface.SetTextColor( 0, 255, 255, 255 )
		surface.DrawText( "Game Keybinds" )
		surface.SetTextColor( 255, 255, 255, 255 )
		surface.SetTextPos( x + 10 , 32 + modi * 0 )
		surface.DrawText( "F1: Skills Menu" )
		surface.SetTextPos( x + 10 , 32 + modi * 1 )
		surface.DrawText( "F2: Toggle Hotbar" )
		surface.SetTextPos( x + 10 , 32 + modi * 2 )
		surface.DrawText( "F3: Tribe Menu" )
		surface.SetTextPos( x + 10 , 32 + modi * 3 )
		surface.DrawText( "F4: Inventory List" )
		surface.SetTextPos( x + 10 , 32 + modi * 4 )
		surface.DrawText( "F6: Rules / Help" )
		surface.SetTextPos( x + 10 , 32 + modi * 5 )
		surface.DrawText( "F7: Commands List" )
		surface.SetTextPos( x + 10 , 32 + modi * 6 )
		surface.DrawText( "F8: Stats Menu" )
	end

	
	--Mini Console Text
	for k,msg in pairs(GAMEMODE.InfoMessages) do
		local txt = msg.Text
		local line = (ScrH() - 120) + (msg.drawline * 15)
		local tab = ScrW() - 396
		local col = msg.Col
		--draw.SimpleTextOutlined(txt,"ScoreboardText",tab,line,col,0,0,0.5,Color(100,100,100,150))
		draw.SimpleText(txt,"SGS_HUD2",tab,line,col,0,0)
		GAMEMODE.CheckTotalMessages()
	end
	
	if SGS.skillmenuopen == true then

		local x = ( ScrW() - 260 )
		local y = ScrH() - 548
		local multi = 35
		surface.SetDrawColor( 0, 0, 0, 210 )
		surface.DrawRect( x, y ,  254, 351 )
		
		for i=1, 10 do
			local y = ScrH() - 548 + multi * (i-1)
			surface.SetDrawColor( 0, 0, 0, 210 )
			surface.DrawRect( x + 3, y + 3 , 248, 30 )
			surface.DrawRect( x + 6, y + 18 , 242, 12 )
			local skill = SGS.skills[i]
			local nextexp = SGS.explist[SGS.levels[skill] + 1]
			local clvlexp = SGS.explist[SGS.levels[skill]]
			local curexp =  SGS.exp[skill]
			local curlevel = SGS.levels[skill]
			local barlen = ((curexp - clvlexp)/ (nextexp - clvlexp)) * 242
			surface.SetDrawColor( SGS.colors[ skill ].r, SGS.colors[ skill ].g, SGS.colors[ skill ].b, 210 )
			surface.DrawRect( x + 6, y + 18 , barlen, 12 )
			surface.SetDrawColor( 0, 0, 0, 210 )
			surface.SetFont( "SGS_NEWHUD5" )
			surface.SetTextPos( x + 10, y + 4 )		
			surface.SetTextColor( Color(255,255,255,255) )
			surface.DrawText( Cap(skill) .. ": " .. curlevel )
			surface.SetTextColor( Color(255,255,255,255) )
			local message = curexp .. " / " .. nextexp
			local w, _ = surface.GetTextSize( message )
			surface.SetTextPos( x + 248 - w , y + 4 )
			surface.DrawText(message)
		end		
	end
	
	if SGS.showafk then
		local x = ScrW() / 2
		local y = 200
		surface.SetDrawColor( 0, 0, 0, 210 )
		surface.DrawRect( x - 75, y - 68, 150, 55 ) --Icon Outter
		surface.DrawRect( x - 72, y - 65, 144, 20 ) --Icon Inner
		surface.SetFont( "SGS_NEWHUD3" )
		surface.SetTextPos( x - 48 , y - 65 )
		surface.SetTextColor( 255, 0, 0, 255 )
		surface.DrawText( "YOU ARE AFK" )
		surface.SetFont( "SGS_NEWHUD2" )
		surface.SetTextPos( x - 48 , y - 42 )
		surface.SetTextColor( 255, 255, 255, 255 )
		surface.DrawText( "Time AFK: " .. SGS.afktime .. "m" )
		surface.SetFont( "SGS_NEWHUD1" )
		surface.SetTextPos( x - 65 , y - 30 )
		surface.DrawText( "Type !afk to exit AFK mode." )
	end	
	
	if SGS.commandsmenuopen == true then	
		local x = ( ScrW() - 246 )
		local y = 100
		
		surface.SetDrawColor( 0, 0, 0, 210 )
		surface.DrawRect( x , y , 240, 160 ) --Icon Outter
		surface.DrawRect( x + 3 , y + 3 , 240 - 6, 20 ) --Icon Inner
		surface.SetTextColor( 255, 0, 0, 255 )
		surface.SetFont( "SGS_NEWHUD3" )
		surface.SetTextPos( x + 50 , y + 3  )
		surface.DrawText( "F7 - Commands List" )
		
		surface.SetFont( "SGS_NEWHUD5" )
		surface.SetTextColor( 255, 255, 255, 255 )
		local offset = 15
		surface.SetTextPos( x + 6 , y +30 + offset*0 )
		surface.DrawText( "!sleep - Sleeps for 10 seconds." )
		surface.SetTextPos( x + 6 , y +30 + offset*1 )
		surface.DrawText( "!save - Saves your character." )
		surface.SetTextPos( x + 6 , y +30 + offset*2 )
		surface.DrawText( "!firstperson - Change Views" )
		surface.SetTextPos( x + 6 , y +30 + offset*3 )
		surface.DrawText( "!thirdperson - Change Views" )
		surface.SetTextPos( x + 6 , y +30 + offset*4 )
		surface.DrawText( "!unstuck - Teleport to spawn" )
		surface.SetTextPos( x + 6 , y +30 + offset*5 )
		surface.DrawText( "!cancel - Cancels a process" )
		surface.SetTextPos( x + 6 , y +30 + offset*6 )
		surface.DrawText( "!foragetoggle - Toggles foraging on UseKey" )
		surface.SetTextPos( x + 6 , y +30 + offset*7 )
		surface.DrawText( "!givetoken - Gives GTokens to other players." )
	end	
	
end
hook.Add( "HUDPaint", "SGS_AllThingsHUD", SGS_AllThingsHUD )

function SGS_OpenSkillMenu()
	if SGS == nil then return end
	if SGS.sideinventory then return end
	if input.IsKeyDown(98) then
		SGS.commandsmenuopen = true
		SGS.skillmenuopen = false
	else
		SGS.commandsmenuopen = false
	end
end
hook.Add( "Think", "SGS_OpenSkillMenu", SGS_OpenSkillMenu )