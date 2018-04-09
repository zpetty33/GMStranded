GM.newQMenu = GM.newQMenu or {}


--[[
Menus~
Props
Structures
Farming
Tools
Resources
Spells
Options
]]


surface.CreateFont( "farmingoverlayiconsnew", {
	font	=	"tahoma",
	size	=	12,
	weight	=	800
	}
)
surface.CreateFont( "qMenuFont1", {
	font	=	"tahoma",
	size	=	12,
	weight	=	800
	}
)
surface.CreateFont( "qMenuFont2", {
	font	=	"tahoma",
	size	=	12,
	weight	=	400
	}
)
surface.CreateFont( "qMenuFont3", {
	font	=	"tahoma",
	size	=	14,
	weight	=	800
	}
)
surface.CreateFont( "qMenuFont4", {
	font	=	"tahoma",
	size	=	11,
	weight	=	800
	}
)
surface.CreateFont("qMenuFont5", {
	font = "Arial", 
	size = 18, 
	weight = 800, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = true, 
	additive = false, 
	outline = false, 
})
surface.CreateFont( "qMenuFont6", {
	font	=	"tahoma",
	size	=	11,
	weight	=	600
	}
)




function GM.newQMenu:ShowMenu( ply, com, args )
	LocalPlayer().showKeybinds = false
	if not IsValid( self.menuObject ) then
		self.menuObject = vgui.Create( "new_Qmenu" )
		self.menuObject:MakePopup()
		self.menuObject:SetKeyboardInputEnabled( false )
	else
		self.menuObject:Show()
		self.menuObject:SetKeyboardInputEnabled( false )
		input.SetCursorPos( self.menuObject.mousepos.x, self.menuObject.mousepos.y )
	end
	self.dropPanel = vgui.Create( "drop_panel" )
	self.dropPanel:Show()
	self.dropPanel:Receiver( "resourceDrop", function( pnl, tbl, dropped, menu, x, y )
		if ( !dropped ) then return end
		surface.PlaySound( "ui/buttonclickrelease.wav" )
		RunConsoleCommand("sgs_dropresource", tbl[1].res, tbl[1].amt)
	end )
	self.dropPanel:SetZPos( 1000 )

	
end
concommand.Add( "+strandedmenu", function( ... ) GAMEMODE.newQMenu:ShowMenu( ... ) end )

function GM.newQMenu:HideMenu( ply, com, args )
	LocalPlayer().showKeybinds = true
	if IsValid( self.menuObject ) then
		self.menuObject.mousepos = {}
		self.menuObject.mousepos.x, self.menuObject.mousepos.y = input.GetCursorPos()
		self.menuObject:Hide()
		--self.menuObject:Close()
	end
	self.dropPanel:Remove()
end
concommand.Add( "-strandedmenu", function( ... ) GAMEMODE.newQMenu:HideMenu( ... ) end )

local PANEL = {}

function PANEL:Init()

	local x = ScrW() * 0.5
	if x < 650 then x = 650 end
	local y = ScrH() * 0.7

	self:SetSize( x, y )
	self:SetPos( 24, 24 )
	self:SetTitle("")
	self:SetDraggable( false )
	self:ShowCloseButton( false )
	self:DrawFrame()
	
end

function PANEL:Paint()
	--Main Window--	
	surface.SetDrawColor( 0, 0, 0, 210 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	surface.DrawRect( 4, 4, self:GetWide() - 8, 22 ) --TopPanel
	surface.DrawRect( 4, 29, 140, self:GetTall() - 33 ) --LeftButtonPanel
	surface.DrawRect( 148, 29, self:GetWide() - 152, self:GetTall() - 33 ) --RightContentPanel
	
	
	draw.DrawText("Plant Limit: " .. SGS.plantcount .. "/ " .. SGS.maxplants, "qMenuFont1", 10, self:GetTall() - 59, Color(220,220,220,255), TEXT_ALIGN_LEFT)
	draw.DrawText("Prop Limit: " .. SGS.propcount .. "/ " .. LocalPlayer():GetMaxProps(), "qMenuFont1", 10, self:GetTall() - 46, Color(220,220,220,255), TEXT_ALIGN_LEFT)
	draw.DrawText("Structure Limit: " .. SGS.structurecount .. "/ " .. LocalPlayer():GetMaxStructures(), "qMenuFont1", 10, self:GetTall() - 33, Color(220,220,220,255), TEXT_ALIGN_LEFT)
	
	draw.DrawText("Inventory: " .. tostring( SGS.curinv ) .. " / " .. tostring( SGS.maxinv ), "qMenuFont1", 10, self:GetTall() - 20, Color(220,220,220,255), TEXT_ALIGN_LEFT)
end

function PANEL:DrawFrame()
	--Create the list of buttons on the left
	local buttonList = vgui.Create( "DListLayout", self )
	buttonList:SetPos( 6, 31 )
	buttonList:SetSize( 136, self:GetTall() - 33 )
	
	self.firsttime = true
	
	GAMEMODE.newQMenu.btn_props = vgui.Create( "menu_qButton" )
	GAMEMODE.newQMenu.btn_structures = vgui.Create( "menu_qButton" )
	GAMEMODE.newQMenu.btn_farming = vgui.Create( "menu_qButton" )
	GAMEMODE.newQMenu.btn_tools = vgui.Create( "menu_qButton" )
	GAMEMODE.newQMenu.btn_resources = vgui.Create( "menu_qButton" )
	GAMEMODE.newQMenu.btn_spells = vgui.Create( "menu_qButton" )
	GAMEMODE.newQMenu.btn_options = vgui.Create( "menu_qButton" )
	GAMEMODE.newQMenu.btn_pmodel = vgui.Create( "menu_qButton" )
	GAMEMODE.newQMenu.btn_pprotect = vgui.Create( "menu_qButton" )
	GAMEMODE.newQMenu.btn_vchannel = vgui.Create( "menu_qButton" )
	
	GAMEMODE.newQMenu.contentPanel = vgui.Create( "DPanel", self )
	GAMEMODE.newQMenu.contentPanel:SetPos( 148, 29 )
	GAMEMODE.newQMenu.contentPanel:SetSize( self:GetWide() - 152, self:GetTall() - 33 )
	GAMEMODE.newQMenu.contentPanel:SetPaintBackground( false )
		
	GAMEMODE.newQMenu.btn_props:SetWide( 80 )
	GAMEMODE.newQMenu.btn_props:DockMargin( 0,0,0,2 )
	GAMEMODE.newQMenu.btn_props:SetButtonText( "Props" )
	GAMEMODE.newQMenu.btn_props.OnMousePressed = function()
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_props.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_props", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	buttonList:Add( GAMEMODE.newQMenu.btn_props )	
	
	GAMEMODE.newQMenu.btn_structures:SetWide( 130 )
	GAMEMODE.newQMenu.btn_structures:DockMargin( 0,0,0,2 )
	GAMEMODE.newQMenu.btn_structures:SetButtonText( "Structures" )
	GAMEMODE.newQMenu.btn_structures.OnMousePressed = function()
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_structures.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_structures", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	buttonList:Add( GAMEMODE.newQMenu.btn_structures )
	
	GAMEMODE.newQMenu.btn_farming:SetWide( 130 )
	GAMEMODE.newQMenu.btn_farming:DockMargin( 0,0,0,2 )
	GAMEMODE.newQMenu.btn_farming:SetButtonText( "Farming" )
	GAMEMODE.newQMenu.btn_farming.OnMousePressed = function()
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_farming.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_farming", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	buttonList:Add( GAMEMODE.newQMenu.btn_farming )
	
	GAMEMODE.newQMenu.btn_tools:SetWide( 130 )
	GAMEMODE.newQMenu.btn_tools:DockMargin( 0,0,0,2 )
	GAMEMODE.newQMenu.btn_tools:SetButtonText( "Tools" )
	GAMEMODE.newQMenu.btn_tools.OnMousePressed = function()
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_tools.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_tools", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	buttonList:Add( GAMEMODE.newQMenu.btn_tools )
	
	GAMEMODE.newQMenu.btn_resources:SetWide( 130 )
	GAMEMODE.newQMenu.btn_resources:DockMargin( 0,0,0,2 )
	GAMEMODE.newQMenu.btn_resources:SetButtonText( "Resources" )
	GAMEMODE.newQMenu.btn_resources.OnMousePressed = function()
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_resources.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_resources", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	buttonList:Add( GAMEMODE.newQMenu.btn_resources )
	
	GAMEMODE.newQMenu.btn_spells:SetWide( 130 )
	GAMEMODE.newQMenu.btn_spells:DockMargin( 0,0,0,2 )
	GAMEMODE.newQMenu.btn_spells:SetButtonText( "Spells" )
	GAMEMODE.newQMenu.btn_spells.OnMousePressed = function()
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_spells.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_spells", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	buttonList:Add( GAMEMODE.newQMenu.btn_spells )
	
	GAMEMODE.newQMenu.btn_options:SetWide( 130 )
	GAMEMODE.newQMenu.btn_options:DockMargin( 0,0,0,2 )
	GAMEMODE.newQMenu.btn_options:SetButtonText( "Options" )
	GAMEMODE.newQMenu.btn_options.OnMousePressed = function()
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_options.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_options", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	buttonList:Add( GAMEMODE.newQMenu.btn_options )
	
	GAMEMODE.newQMenu.btn_pmodel:SetWide( 130 )
	GAMEMODE.newQMenu.btn_pmodel:DockMargin( 0,0,0,2 )
	GAMEMODE.newQMenu.btn_pmodel:SetButtonText( "Player Model" )
	GAMEMODE.newQMenu.btn_pmodel.OnMousePressed = function()
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_pmodel.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_pmodel", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	buttonList:Add( GAMEMODE.newQMenu.btn_pmodel )
	
	GAMEMODE.newQMenu.btn_pprotect:SetWide( 130 )
	GAMEMODE.newQMenu.btn_pprotect:DockMargin( 0,0,0,2 )
	GAMEMODE.newQMenu.btn_pprotect:SetButtonText( "Prop Protection" )
	GAMEMODE.newQMenu.btn_pprotect.OnMousePressed = function()
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_pprotect.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_pprotect", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	buttonList:Add( GAMEMODE.newQMenu.btn_pprotect )
	
	GAMEMODE.newQMenu.btn_vchannel:SetWide( 130 )
	GAMEMODE.newQMenu.btn_vchannel:DockMargin( 0,0,0,2 )
	GAMEMODE.newQMenu.btn_vchannel:SetButtonText( "Voice Channels" )
	GAMEMODE.newQMenu.btn_vchannel.OnMousePressed = function()
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_vchannel.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_vchannel", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	buttonList:Add( GAMEMODE.newQMenu.btn_vchannel )
	
	if self.firsttime then
		DeactivateAllQButtons()
		GAMEMODE.newQMenu.btn_resources.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "qmenu_resources", GAMEMODE.newQMenu.contentPanel )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
		self.firsttime = false
	end
end
vgui.Register("new_Qmenu", PANEL, "DFrame")

function DeactivateAllQButtons()

	GAMEMODE.newQMenu.btn_props.active = false
	GAMEMODE.newQMenu.btn_structures.active = false
	GAMEMODE.newQMenu.btn_farming.active = false
	GAMEMODE.newQMenu.btn_tools.active = false
	GAMEMODE.newQMenu.btn_resources.active = false
	GAMEMODE.newQMenu.btn_spells.active = false
	GAMEMODE.newQMenu.btn_options.active = false
	GAMEMODE.newQMenu.btn_pmodel.active = false
	GAMEMODE.newQMenu.btn_pprotect.active = false
	GAMEMODE.newQMenu.btn_vchannel.active = false
	
end


local FARMING_TAB = {}
function FARMING_TAB:Init()
	self:DrawFrame()
end
function FARMING_TAB:DrawFrame()
	
	local function DrawSeedsNew()
		if GAMEMODE.newQMenu.farmingListPanel then GAMEMODE.newQMenu.farmingListPanel:Remove() end
		GAMEMODE.newQMenu.farmingListPanel = vgui.Create( "DListLayout", self )
		GAMEMODE.newQMenu.farmingListPanel:Dock( FILL )

		local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.farmingListPanel )
		MenuLabel:SetButtonText( "Farming" )
		MenuLabel:Dock( TOP )
		MenuLabel:DockMargin( 0, 0, 0, 6 )
			
		
		local has_seeds = false
		
		if LocalPlayer():HasSeedsOfType( "fruit" ) then
			has_seeds = true

			local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.farmingListPanel )
			MenuLabel:SetButtonText( "Fruit Seeds" )
			GAMEMODE.newQMenu.farmingListPanel:Add( MenuLabel )
			
			local SeedsPanel = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.farmingListPanel)
			SeedsPanel:SetSpaceX( 3 )
			SeedsPanel:SetSpaceY( 3 )
			SeedsPanel:DockMargin( 0, 0, 0, 4 )
			GAMEMODE.newQMenu.farmingListPanel:Add( SeedsPanel )
				
			for _, v in pairs( SGS.Seeds[ "fruit" ] ) do
				if SGS.resources[ v.resource ] then
					if SGS.resources[ v.resource ] >= 1 then
						local SeedButton = vgui.Create( "DImageButton", SeedsPanel)
						SeedButton:SetMaterial( v.icon )
						SeedButton:SetToolTip( v.title .. "\nFarming Level: " .. tostring(v.reqlvl["farming"]) )
						SeedButton:SetSize( 40, 40 )
						SeedButton.DoClick = function( SeedButton )
							RunConsoleCommand("sgs_plant", v.resource)
						end
						SeedsPanel:Add( SeedButton )
						SeedButton.PaintOver = function()
							local seedcount = SGS.resources[v.resource] or 0
							draw.SimpleText(seedcount, "farmingoverlayiconsnew", 2, 30, Color(255, 0, 0, 255), 0, 1)
						end
					end
				end
			end
		
		end
		
		if LocalPlayer():HasSeedsOfType( "trees" ) then
			has_seeds = true

			local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.farmingListPanel )
			MenuLabel:SetButtonText( "Tree Seeds" )
			GAMEMODE.newQMenu.farmingListPanel:Add( MenuLabel )
			
			local SeedsPanel = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.farmingListPanel)
			SeedsPanel:SetSpaceX( 3 )
			SeedsPanel:SetSpaceY( 3 )
			SeedsPanel:DockMargin( 0, 0, 0, 4 )
			GAMEMODE.newQMenu.farmingListPanel:Add( SeedsPanel )
				
			for _, v in pairs( SGS.Seeds[ "trees" ] ) do
				if SGS.resources[ v.resource ] then
					if SGS.resources[ v.resource ] >= 1 then
						local SeedButton = vgui.Create( "DImageButton", SeedsPanel)
						SeedButton:SetMaterial( v.icon )
						SeedButton:SetToolTip( v.title .. "\nFarming Level: " .. tostring(v.reqlvl["farming"]) )
						SeedButton:SetSize( 40, 40 )
						SeedButton.DoClick = function( SeedButton )
							RunConsoleCommand("sgs_planttree", v.resource)
						end
						SeedsPanel:Add( SeedButton )
						SeedButton.PaintOver = function()
							local seedcount = SGS.resources[v.resource] or 0
							draw.SimpleText(seedcount, "farmingoverlayiconsnew", 2, 30, Color(255, 0, 0, 255), 0, 1)
						end
					end
				end
			end
			
		end
		
		if LocalPlayer():HasSeedsOfType( "food" ) then
			has_seeds = true

			local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.farmingListPanel )
			MenuLabel:SetButtonText( "Food Seeds" )
			GAMEMODE.newQMenu.farmingListPanel:Add( MenuLabel )
			
			local SeedsPanel = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.farmingListPanel)
			SeedsPanel:SetSpaceX( 3 )
			SeedsPanel:SetSpaceY( 3 )
			SeedsPanel:DockMargin( 0, 0, 0, 4 )
			GAMEMODE.newQMenu.farmingListPanel:Add( SeedsPanel )
				
			for _, v in pairs( SGS.Seeds[ "food" ] ) do
				if SGS.resources[ v.resource ] then
					if SGS.resources[ v.resource ] >= 1 then
						local SeedButton = vgui.Create( "DImageButton", SeedsPanel)
						SeedButton:SetMaterial( v.icon )
						SeedButton:SetToolTip( v.title .. "\nFarming Level: " .. tostring(v.reqlvl["farming"]) )
						SeedButton:SetSize( 40, 40 )
						SeedButton.DoClick = function( SeedButton )
							RunConsoleCommand("sgs_plantfood", v.resource)
						end
						SeedsPanel:Add( SeedButton )
						SeedButton.PaintOver = function()
							local seedcount = SGS.resources[v.resource] or 0
							draw.SimpleText(seedcount, "farmingoverlayiconsnew", 2, 30, Color(255, 0, 0, 255), 0, 1)
						end
					end
				end
			end
			
		end
		
		if LocalPlayer():HasSeedsOfType( "alchemy" ) then
			has_seeds = true

			local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.farmingListPanel )
			MenuLabel:SetButtonText( "Alchemy Seeds" )
			GAMEMODE.newQMenu.farmingListPanel:Add( MenuLabel )
			
			local SeedsPanel = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.farmingListPanel)
			SeedsPanel:SetSpaceX( 3 )
			SeedsPanel:SetSpaceY( 3 )
			SeedsPanel:DockMargin( 0, 0, 0, 4 )
			GAMEMODE.newQMenu.farmingListPanel:Add( SeedsPanel )
				
			for _, v in pairs( SGS.Seeds[ "alchemy" ] ) do
				if SGS.resources[ v.resource ] then
					if SGS.resources[ v.resource ] >= 1 then
						local SeedButton = vgui.Create( "DImageButton", SeedsPanel)
						SeedButton:SetMaterial( v.icon )
						SeedButton:SetToolTip( v.title .. "\nFarming Level: " .. tostring(v.reqlvl["farming"]) )
						SeedButton:SetSize( 40, 40 )
						SeedButton.DoClick = function( SeedButton )
							RunConsoleCommand("sgs_plantfood", v.resource)
						end
						SeedsPanel:Add( SeedButton )
						SeedButton.PaintOver = function()
							local seedcount = SGS.resources[v.resource] or 0
							draw.SimpleText(seedcount, "farmingoverlayiconsnew", 2, 30, Color(255, 0, 0, 255), 0, 1)
						end
					end
				end
			end
			
		end
		
		if not has_seeds then
			local footer = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.farmingListPanel )
			footer:Dock( TOP )
			footer:SetButtonText( "You do not have any seeds." )
		end
		
		
		local footer = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.farmingListPanel )
		footer:Dock( BOTTOM )
		footer:SetButtonText( "Mouse over an icon for more information." )
		
		
		
	end
	DrawSeedsNew()
	concommand.Add( "sgs_refreshfarming", DrawSeedsNew )
	
end
function FARMING_TAB:Paint()

end
vgui.Register("qmenu_farming", FARMING_TAB, "Panel")

local SPELLS_TAB = {}
function SPELLS_TAB:Init()
	self:DrawFrame()
end
function SPELLS_TAB:DrawFrame()
	
	local function DrawSpellsNew()
		if GAMEMODE.newQMenu.spellsListScrollPanel then GAMEMODE.newQMenu.spellsListScrollPanel:Remove() end
		
		GAMEMODE.newQMenu.spellsListPanel = vgui.Create( "DPanel", self )
		GAMEMODE.newQMenu.spellsListPanel:Dock( FILL )
		GAMEMODE.newQMenu.spellsListPanel:SetPaintBackground(false)
		
		GAMEMODE.newQMenu.spellsListScrollPanel = vgui.Create( "DScrollPanel", GAMEMODE.newQMenu.spellsListPanel )
		GAMEMODE.newQMenu.spellsListScrollPanel:Dock( FILL )	

		local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.spellsListScrollPanel )
		MenuLabel:SetButtonText( "Arcane Spalls" )
		MenuLabel:Dock(TOP)
		
		local SpellContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.spellsListScrollPanel)
		SpellContainerButtons:SetSpaceY( 4 )
		SpellContainerButtons:SetSpaceX( 4 )
		SpellContainerButtons:Dock(TOP)
		SpellContainerButtons:DockMargin( 4, 4, 4, 4 )
		
		for _, v in pairs( SGS.SpellList ) do
			if SGS.levels["arcane"] < v.reqlvl then continue end
			
			if v.tribelevel then
				if GAMEMODE.Tribes:GetTribeLevel( LocalPlayer() ) < v.tribelevel then
					continue
				end
			end
			
			local SpellButton = vgui.Create( "menu_qSpellButton", SpellList)
			SpellButton.iconimage = v.material
			SpellButton:SetToolTip( SGS_SpellToolTip(v) )
			SpellButton:SetSize( 140, 34 )
			SpellButton:SetButtonText(v.name)
			SpellButton:Droppable("HotbarDrop")
			SpellButton.dropType = "spell"
			SpellButton.spell = v.spell
			SpellButton.PaintOver = function()
			if LocalPlayer():HowManyCasts(v) == 0 then
				draw.RoundedBoxEx( 0, 35, 18, 103, 12, Color(255, 50, 50, 150), false, false, false, false )
				draw.SimpleText("NO STONES", "qMenuFont2", 60, 18, Color(255, 255, 255, 255), 0, 0)
				SpellButton.OnCursorEntered = function()
					return true
				end
			else
				draw.RoundedBoxEx( 0, 35, 18, 103, 12, Color(50, 255, 50, 150), false, false, false, false )
				draw.SimpleText(LocalPlayer():HowManyCasts(v) .. "x Casts", "qMenuFont2", 68, 18, Color(255, 255, 255, 255), 0, 0)
			end
			end
			
			
						
			SpellButton:SetMouseInputEnabled( true )
			function SpellButton:DoClick()
				surface.PlaySound( "ui/buttonclickrelease.wav" )
				RunConsoleCommand( "sgs_cast", v.spell )
				LocalPlayer():HowManyCasts( v )
			end
			
			SpellContainerButtons:Add( SpellButton )
		end
		
	end
	DrawSpellsNew()
	concommand.Add( "sgs_refreshspells", DrawSpellsNew )
	
end
function SPELLS_TAB:Paint()

end
vgui.Register("qmenu_spells", SPELLS_TAB, "Panel")



local TOOLS_TAB = {}
function TOOLS_TAB:Init()
	self:DrawFrame()
end
function TOOLS_TAB:DrawFrame()	
	function DrawToolsNew()
	
		if GAMEMODE.newQMenu.toolsListPanel then GAMEMODE.newQMenu.toolsListPanel:Remove() end
		
		GAMEMODE.newQMenu.toolsListPanel = vgui.Create( "DPanel", self )
		GAMEMODE.newQMenu.toolsListPanel:Dock( FILL )
		GAMEMODE.newQMenu.toolsListPanel:SetPaintBackground(false)
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.toolsListPanel )
		header:Dock( TOP )
		header:SetButtonText( "Current Equipped: " .. LocalPlayer():CurrentEquippedTool())
		header:DockMargin( 0, 0, 0, 6 )
		
		
		
		local ToolOptions = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.toolsListPanel)
		ToolOptions:SetSpaceY( 4 )
		ToolOptions:SetSpaceX( 4 )
		ToolOptions:Dock(BOTTOM)
		ToolOptions:DockMargin( 4, 4, 4, 4 )
		
		local icon = vgui.Create( "menu_qButton2", ToolOptions)
		icon:SetSize( 120, 18 )
		icon:SetButtonText( "Unequip Current Tool" )
		icon.SetTextOffsetY = 2
		icon.OnMousePressed = function( panel, m )
			if m == MOUSE_LEFT then
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand("SGS_UnEquipTool")
			end
		end
		
		local icon = vgui.Create( "menu_qButton2", ToolOptions)
		icon:SetSize( 120, 18 )
		icon:SetButtonText( "Drop Current Tool" )
		icon.SetTextOffsetY = 2
		icon.OnMousePressed = function( panel, m )
			if m == MOUSE_LEFT then
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand("SGS_DropTool")
			end
		end
		
		

		GAMEMODE.newQMenu.toolsListScrollPanel = vgui.Create( "DScrollPanel", GAMEMODE.newQMenu.toolsListPanel )
		GAMEMODE.newQMenu.toolsListScrollPanel:Dock( FILL )
		
		for k, v in SortedPairs( SGS_ReturnSortedTable( SGS.Tools ) ) do
			
			if LocalPlayer():PlayerHasToolInGroup(k) then

				local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.toolsListScrollPanel )
				MenuLabel:SetButtonText( Cap(k) .. " Tools" )
				MenuLabel:Dock(TOP)

				local ToolContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.toolsListScrollPanel)
				ToolContainerButtons:SetSpaceY( 4 )
				ToolContainerButtons:SetSpaceX( 4 )
				ToolContainerButtons:Dock(TOP)
				ToolContainerButtons:DockMargin( 4, 4, 4, 4 )
				
				for k2, v2 in pairs( SGS.Tools[k] ) do
			
					if SGS_CheckTool( v2.entity ) then

						local icon = vgui.Create( "menu_qButton2", ToolContainerButtons)
						icon:SetSize( 120, 24 )
						icon:SetToolTip( SGS_ToolTipShort(v2) )
						icon:SetButtonText( v2.title )
						icon:Droppable("HotbarDrop")
						icon.dropType = "tool"
						icon.tool = v2.entity
						icon.PaintOver = function()
							local tool_count = SGS_CountTools( v2.entity ) .. "x"
							surface.SetFont( "SGS_HUD2" )
							local x, y = surface.GetTextSize( tool_count )
							draw.SimpleText(tool_count, "SGS_HUD2", 60 - x/2, 11, Color(255, 255, 255, 255), 0, 0)
						end
						
						ToolContainerButtons:Add( icon )
						
						icon:SetMouseInputEnabled( true )
						function icon:DoClick()
							surface.PlaySound( "ui/buttonclickrelease.wav" ) 
							RunConsoleCommand("SGS_EquipTools", v2.entity)
						end
					end
				end
			end
		end

	end
	DrawToolsNew()
	concommand.Add( "sgs_refreshtools", DrawToolsNew )
	
end
function TOOLS_TAB:Paint()

end
vgui.Register("qmenu_tools", TOOLS_TAB, "Panel")


local RESOURCES_TAB = {}
function RESOURCES_TAB:Init()
	self:DrawFrame()
end
function RESOURCES_TAB:DrawFrame()	
	function DrawResourcesNew()
	
		local curinv = 0
		for k, v in pairs(SGS.resources) do
			curinv = curinv + tonumber(v)
		end
		SGS.curinv = curinv
	
		if GAMEMODE.newQMenu.resourcesListPanel then GAMEMODE.newQMenu.resourcesListPanel:Remove() end
		
		GAMEMODE.newQMenu.resourcesListPanel = vgui.Create( "DPanel", self )
		GAMEMODE.newQMenu.resourcesListPanel:Dock( FILL )
		GAMEMODE.newQMenu.resourcesListPanel:SetPaintBackground(false)
		
		GAMEMODE.newQMenu.resourcesListScrollPanel = vgui.Create( "DScrollPanel", GAMEMODE.newQMenu.resourcesListPanel )
		GAMEMODE.newQMenu.resourcesListScrollPanel:Dock( FILL )
		
		local MenuLabel = vgui.Create( "menu_qLabelBarSmall", GAMEMODE.newQMenu.resourcesListPanel )
		MenuLabel:SetButtonText( "DRAG ANY ITEM OUTSIDE OF THE WINDOW TO DROP IT" )
		MenuLabel:Dock(BOTTOM)
		MenuLabel:DockMargin( 0, 0, 0, 0 )
		MenuLabel.PaintColor = Color( 40, 40, 40, 230 )

		local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.resourcesListScrollPanel )
		MenuLabel:SetButtonText( "Consumables" )
		MenuLabel:Dock(TOP)

		local ConsumableContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.resourcesListScrollPanel)
		ConsumableContainerButtons:SetSpaceY( 4 )
		ConsumableContainerButtons:SetSpaceX( 4 )
		ConsumableContainerButtons:Dock(TOP)
		ConsumableContainerButtons:DockMargin( 4, 4, 4, 4 )

		local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.resourcesListScrollPanel )
		MenuLabel:SetButtonText( "Raw Materials" )
		MenuLabel:Dock(TOP)

		local RawContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.resourcesListScrollPanel)
		RawContainerButtons:SetSpaceY( 4 )
		RawContainerButtons:SetSpaceX( 4 )
		RawContainerButtons:Dock(TOP)
		RawContainerButtons:DockMargin( 4, 4, 4, 4 )

		local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.resourcesListScrollPanel )
		MenuLabel:SetButtonText( "Packaged Structures" )
		MenuLabel:Dock(TOP)

		local PackagedContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.resourcesListScrollPanel)
		PackagedContainerButtons:SetSpaceY( 4 )
		PackagedContainerButtons:SetSpaceX( 4 )
		PackagedContainerButtons:Dock(TOP)
		PackagedContainerButtons:DockMargin( 4, 4, 4, 4 )
		
		
		for k, v in SortedPairs( SGS.resources ) do
			if v <= 0 then continue end
			
			local ResourceButton = vgui.Create( "menu_qResourceButton", ConsumableContainerButtons)
			ResourceButton:SetSize( 120, 24 )
			ResourceButton:SetButtonText( CapAll( string.gsub( k, "_", " " ) ) )
			ResourceButton:Droppable("resourceDrop")
			ResourceButton.res = k
			ResourceButton.amt = v
			ResourceButton.PaintOver = function()
				surface.SetFont( "qMenuFont1" )
				count = v
				local x, y = surface.GetTextSize( count )
				draw.SimpleText(count, "qMenuFont1", 60 - x/2, 11, Color(255, 255, 255, 255), 0, 0)
			end			
						
			ResourceButton:SetMouseInputEnabled( true )
						
			if table.HasValue( SGS.menuedible, k ) or table.HasValue( SGS.menupotions, k ) then
				ConsumableContainerButtons:Add( ResourceButton )
				ResourceButton.dropType = "consumable"
				ResourceButton.consumeEnable = true
			elseif table.HasValue( SGS.AllowedPackage, k ) then
				PackagedContainerButtons:Add( ResourceButton )
				ResourceButton.unpackEnable = true
			else
				RawContainerButtons:Add( ResourceButton )
			end
			
			function ResourceButton:DoClick()
				surface.PlaySound( "ui/buttonclickrelease.wav" )
				if GAMEMODE.newQMenu.ResourceDialogue then GAMEMODE.newQMenu.ResourceDialogue:Remove() end
				GAMEMODE.newQMenu.ResourceDialogue = vgui.Create( "resource_dialogue" )
				
				GAMEMODE.newQMenu.ResourceDialogue.res = k
				GAMEMODE.newQMenu.ResourceDialogue.amt = v
				print( GAMEMODE.newQMenu.ResourceDialogue.amt, GAMEMODE.newQMenu.ResourceDialogue.res )
				if ResourceButton.consumeEnable then GAMEMODE.newQMenu.ResourceDialogue.consumeEnable = true end
				if ResourceButton.unpackEnable then GAMEMODE.newQMenu.ResourceDialogue.unpackEnable = true end
				
				GAMEMODE.newQMenu.ResourceDialogue:MakePopup()
			end
			
			
		end		

	end
	DrawResourcesNew()
	concommand.Add( "sgs_refreshresources", DrawResourcesNew )	
end
function RESOURCES_TAB:Paint()

end
vgui.Register("qmenu_resources", RESOURCES_TAB, "Panel")



local PROPS_TAB = {}
function PROPS_TAB:Init()
	self:DrawFrame()
end
function PROPS_TAB:DrawFrame()	
	
		if GAMEMODE.newQMenu.propsListPanel then GAMEMODE.newQMenu.propsListPanel:Remove() end
		
		GAMEMODE.newQMenu.propsListPanel = vgui.Create( "DPanel", self )
		GAMEMODE.newQMenu.propsListPanel:Dock( FILL )
		GAMEMODE.newQMenu.propsListPanel:SetPaintBackground(false)
		
		local propOptions = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.propsListPanel)
		propOptions:SetSpaceY( 4 )
		propOptions:SetSpaceX( 4 )
		propOptions:Dock(BOTTOM)
		propOptions:DockMargin( 4, 4, 4, 4 )
		

		GAMEMODE.newQMenu.propsListScrollPanel = vgui.Create( "DScrollPanel", GAMEMODE.newQMenu.propsListPanel )
		GAMEMODE.newQMenu.propsListScrollPanel:Dock( FILL )
		
		for k, v in pairs( SGS_ReturnSortedTable( SGS.props ) ) do
			
			local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.propsListScrollPanel )
			MenuLabel:SetButtonText( Cap(k) .. " Items" )
			MenuLabel:Dock(TOP)

			local PropContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.propsListScrollPanel)
			PropContainerButtons:SetSpaceY( 4 )
			PropContainerButtons:SetSpaceX( 4 )
			PropContainerButtons:Dock(TOP)
			PropContainerButtons:DockMargin( 4, 4, 4, 4 )
			
			for _, prop in pairs( SGS.props[k] ) do
		
				local icon = vgui.Create( "menu_qPropButton", PropContainerButtons)
				icon:SetSize( 186, 30 )
				icon:SetToolTip( SGS_ToolTip(prop) )
				icon:SetButtonText( prop.title )
				icon.SetTextOffsetY = 1
				icon.model = prop.model
				icon.dorescheck = true
				icon.PaintOver = function()
					for k3, v3 in pairs( prop.reqlvl ) do
						local plvl = SGS.levels[ k3 ] or 0
						if plvl < v3 then
							surface.SetDrawColor( 255, 0, 0, 100 )
							surface.DrawRect( 38, 18, 144, 10 )
							draw.SimpleText("INSUFFICIENT SKILL", "qMenuFont2", 62, 17, Color(0, 0, 0, 255), 0, 0)
							icon.dorescheck = false
							icon.OnCursorEntered = function()
								return true
							end
							break
						end
					end
					if icon.dorescheck then
						for k3, v3 in pairs( prop.cost ) do
							local pamt = SGS.resources[ k3 ] or 0
							if pamt < v3 then
								surface.SetDrawColor( 255, 255, 0, 100 )
								surface.DrawRect( 38, 18, 144, 10 )
								draw.SimpleText("INSUFFICIENT RESOURCES", "qMenuFont2", 45, 17, Color(0, 0, 0, 255), 0, 0)
								icon.OnCursorEntered = function()
									return true
								end
								break
							end
						end
					end
				end
				
				PropContainerButtons:Add( icon )
				
				icon:SetMouseInputEnabled( true )
				function icon:DoClick()
					surface.PlaySound( "ui/buttonclickrelease.wav" )
					RunConsoleCommand("SGS_Spawn", prop.uid)
				end
			end
		end

end
function PROPS_TAB:Paint()

end
vgui.Register("qmenu_props", PROPS_TAB, "Panel")
	

local STRUCTURES_TAB = {}
function STRUCTURES_TAB:Init()
	self:DrawFrame()
end
function STRUCTURES_TAB:DrawFrame()	
	
		if GAMEMODE.newQMenu.propsListPanel then GAMEMODE.newQMenu.propsListPanel:Remove() end
		
		GAMEMODE.newQMenu.propsListPanel = vgui.Create( "DPanel", self )
		GAMEMODE.newQMenu.propsListPanel:Dock( FILL )
		GAMEMODE.newQMenu.propsListPanel:SetPaintBackground(false)	
		
		local MenuLabel = vgui.Create( "menu_qLabelBarSmall", GAMEMODE.newQMenu.propsListPanel )
		MenuLabel:SetButtonText( "RIGHT CLICK TO CREATE A PRE-PACKAGED STRUCTURE" )
		MenuLabel:Dock(BOTTOM)
		MenuLabel:DockMargin( 0, 4, 0, 0 )
		MenuLabel.PaintColor = Color( 40, 40, 40, 230 )		

		GAMEMODE.newQMenu.propsListScrollPanel = vgui.Create( "DScrollPanel", GAMEMODE.newQMenu.propsListPanel )
		GAMEMODE.newQMenu.propsListScrollPanel:Dock( FILL )
		
		for k, v in pairs( SGS_ReturnSortedTable( SGS.structures ) ) do
			
			local MenuLabel = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.propsListScrollPanel )
			MenuLabel:SetButtonText( Cap(k) .. " Structures" )
			MenuLabel:Dock(TOP)

			local PropContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.propsListScrollPanel)
			PropContainerButtons:SetSpaceY( 4 )
			PropContainerButtons:SetSpaceX( 4 )
			PropContainerButtons:Dock(TOP)
			PropContainerButtons:DockMargin( 4, 4, 4, 4 )
			
			for _, prop in pairs( SGS.structures[k] ) do
		
				local icon = vgui.Create( "menu_qPropButton", PropContainerButtons)
				icon:SetSize( 186, 30 )
				icon:SetToolTip( SGS_ToolTip(prop) )
				icon:SetButtonText( prop.title )
				icon.SetTextOffsetY = 1
				icon.model = prop.model
				icon.dorescheck = true
				icon.PaintOver = function()
					for k3, v3 in pairs( prop.reqlvl ) do
						local plvl = SGS.levels[ k3 ] or 0
						if plvl < v3 then
							surface.SetDrawColor( 255, 0, 0, 100 )
							surface.DrawRect( 38, 18, 144, 10 )
							draw.SimpleText("INSUFFICIENT SKILL", "qMenuFont2", 62, 17, Color(0, 0, 0, 255), 0, 0)
							icon.dorescheck = false
							icon.OnCursorEntered = function()
								return true
							end
							break
						end
					end
					if icon.dorescheck then
						for k3, v3 in pairs( prop.cost ) do
							local pamt = SGS.resources[ k3 ] or 0
							if pamt < v3 then
								surface.SetDrawColor( 255, 255, 0, 100 )
								surface.DrawRect( 38, 18, 144, 10 )
								draw.SimpleText("INSUFFICIENT RESOURCES", "qMenuFont2", 45, 17, Color(0, 0, 0, 255), 0, 0)
								icon.OnCursorEntered = function()
									return true
								end
								break
							end
						end
					end
				end
				
				PropContainerButtons:Add( icon )
				
				icon:SetMouseInputEnabled( true )
				icon.DoClick = function( icon )
					surface.PlaySound( "ui/buttonclickrelease.wav" )
					RunConsoleCommand("SGS_SpawnStructure", prop.ent)
				end
				icon.DoRightClick = function( icon )
					local DropDown = DermaMenu()
					DropDown:AddOption("Created Packaged Version", function() RunConsoleCommand("SGS_SpawnStructurePackaged", prop.ent) end )
					DropDown:AddOption("Rebuild Icon", function() icon:RebuildSpawnIcon() end )
					DropDown:Open()
				end	
			end
		end

end
function STRUCTURES_TAB:Paint()

end
vgui.Register("qmenu_structures", STRUCTURES_TAB, "Panel")

local OPTIONS_TAB = {}
function OPTIONS_TAB:Init()
	self:DrawFrame()
end
function OPTIONS_TAB:DrawFrame()	
	function DrawOptionsNew()
	
		if GAMEMODE.newQMenu.optionsListPanel then GAMEMODE.newQMenu.optionsListPanel:Remove() end
		
		GAMEMODE.newQMenu.optionsListPanel = vgui.Create( "DPanel", self )
		GAMEMODE.newQMenu.optionsListPanel:Dock( FILL )
		GAMEMODE.newQMenu.optionsListPanel:SetPaintBackground(false)
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.optionsListPanel )
		header:Dock( TOP )
		header:SetButtonText( "Game Options/Toggles" )
		header:DockMargin( 0, 0, 0, 6 )

		GAMEMODE.newQMenu.optionsListScrollPanel = vgui.Create( "DScrollPanel", GAMEMODE.newQMenu.optionsListPanel )
		GAMEMODE.newQMenu.optionsListScrollPanel:Dock( FILL )
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.optionsListScrollPanel )
		header:Dock( TOP )
		header:SetButtonText( "Game Commands" )
		header:DockMargin( 0, 0, 0, 6 )
		
		local OptionContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.optionsListScrollPanel)
		OptionContainerButtons:SetSpaceY( 4 )
		OptionContainerButtons:SetSpaceX( 4 )
		OptionContainerButtons:Dock(TOP)
		OptionContainerButtons:DockMargin( 4, 4, 4, 4 )
		
		for _, v in pairs( SGS.Commands[ "game" ] ) do
			local icon = vgui.Create( "menu_qButton2", OptionContainerButtons)
			icon:SetSize( 120, 20 )
			icon:SetToolTip( SGS_ToolTipShort(v) )
			icon:SetButtonText(  v.title )
			icon.SetTextOffsetY = 2
			OptionContainerButtons:Add( icon )
			
			icon:SetMouseInputEnabled( true )
			function icon:DoClick()
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand( unpack(v.command) )
			end
		end

		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.optionsListScrollPanel )
		header:Dock( TOP )
		header:SetButtonText( "Equip Hats" )
		header:DockMargin( 0, 0, 0, 6 )

		local OptionContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.optionsListScrollPanel)
		OptionContainerButtons:SetSpaceY( 4 )
		OptionContainerButtons:SetSpaceX( 4 )
		OptionContainerButtons:Dock(TOP)
		OptionContainerButtons:DockMargin( 4, 4, 4, 4 )
		
		for _, v in pairs( SGS.Commands[ "hats" ] ) do
			if SGS_GetAch(v.achreq) then
				local icon = vgui.Create( "menu_qButton2", OptionContainerButtons)
				icon:SetSize( 120, 20 )
				icon:SetToolTip( SGS_ToolTipShort(v) )
				icon:SetButtonText(  v.title )
			icon.SetTextOffsetY = 2
				OptionContainerButtons:Add( icon )
				
				icon:SetMouseInputEnabled( true )
				function icon:DoClick()
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand( unpack(v.command) )
				end
			end
		end
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.optionsListScrollPanel )
		header:Dock( TOP )
		header:SetButtonText( "Toggle Options" )
		header:DockMargin( 0, 0, 0, 6 )
		
		local OptionContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.optionsListScrollPanel)
		OptionContainerButtons:SetSpaceY( 4 )
		OptionContainerButtons:SetSpaceX( 4 )
		OptionContainerButtons:Dock(TOP)
		OptionContainerButtons:DockMargin( 4, 4, 4, 4 )
		
		for _, v in pairs( SGS.Commands[ "toggles" ] ) do
			local icon = vgui.Create( "menu_qButton2", OptionContainerButtons)
			icon:SetSize( 120, 20 )
			icon:SetToolTip( SGS_ToolTipShort(v) )
			icon:SetButtonText(  v.title )
			icon.SetTextOffsetY = 2
			OptionContainerButtons:Add( icon )
			
			icon:SetMouseInputEnabled( true )
			function icon:DoClick()
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand( unpack(v.command) )
			end
		end
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.optionsListScrollPanel )
		header:Dock( TOP )
		header:SetButtonText( "Pet Options" )
		header:DockMargin( 0, 0, 0, 6 )
		
		local OptionContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.optionsListScrollPanel)
		OptionContainerButtons:SetSpaceY( 4 )
		OptionContainerButtons:SetSpaceX( 4 )
		OptionContainerButtons:Dock(TOP)
		OptionContainerButtons:DockMargin( 4, 4, 4, 4 )
		
		for _, v in pairs( SGS.Commands[ "pets" ] ) do
			local icon = vgui.Create( "menu_qButton2", OptionContainerButtons)
			icon:SetSize( 120, 20 )
			icon:SetToolTip( SGS_ToolTipShort(v) )
			icon:SetButtonText(  v.title )
			icon.SetTextOffsetY = 2
			OptionContainerButtons:Add( icon )
			
			icon:SetMouseInputEnabled( true )
			function icon:DoClick()
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand( unpack(v.command) )
			end
		end
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.optionsListScrollPanel )
		header:Dock( TOP )
		header:SetButtonText( "Special Options" )
		header:DockMargin( 0, 0, 0, 6 )
		
		local OptionContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.optionsListScrollPanel)
		OptionContainerButtons:SetSpaceY( 4 )
		OptionContainerButtons:SetSpaceX( 4 )
		OptionContainerButtons:Dock(TOP)
		OptionContainerButtons:DockMargin( 4, 4, 4, 4 )
		
		for _, v in pairs( SGS.Commands[ "special" ] ) do
			local icon = vgui.Create( "menu_qButton2", OptionContainerButtons)
			icon:SetSize( 120, 20 )
			icon:SetToolTip( SGS_ToolTipShort(v) )
			icon:SetButtonText(  v.title )
			icon.SetTextOffsetY = 2
			OptionContainerButtons:Add( icon )
			
			icon:SetMouseInputEnabled( true )
			function icon:DoClick()
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand( unpack(v.command) )
			end
		end
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.optionsListScrollPanel )
		header:Dock( TOP )
		header:SetButtonText( "Client Options" )
		header:DockMargin( 0, 0, 0, 6 )
		
		local OptionContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.optionsListScrollPanel)
		OptionContainerButtons:SetSpaceY( 4 )
		OptionContainerButtons:SetSpaceX( 4 )
		OptionContainerButtons:Dock(TOP)
		OptionContainerButtons:DockMargin( 4, 4, 4, 4 )
		
		for _, v in pairs( SGS.Commands[ "client" ] ) do
			local icon = vgui.Create( "menu_qButton2", OptionContainerButtons)
			icon:SetSize( 120, 20 )
			icon:SetToolTip( SGS_ToolTipShort(v) )
			icon:SetButtonText(  v.title )
			icon.SetTextOffsetY = 2
			OptionContainerButtons:Add( icon )
			
			icon:SetMouseInputEnabled( true )
			function icon:DoClick()
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand( unpack(v.command) )
			end
		end


	end
	DrawOptionsNew()
	concommand.Add( "sgs_refreshtools", DrawOptionsNew )
	
end
function OPTIONS_TAB:Paint()

end
vgui.Register("qmenu_options", OPTIONS_TAB, "Panel")


local PMODEL_TAB = {}
function PMODEL_TAB:Init()
	self:DrawFrame()
end
function PMODEL_TAB:DrawFrame()	
	function DrawPlayerModelsNew()
	
		if GAMEMODE.newQMenu.pModelListPanel then GAMEMODE.newQMenu.pModelListPanel:Remove() end
		
		GAMEMODE.newQMenu.pModelListPanel2 = vgui.Create( "DPanel", self )
		GAMEMODE.newQMenu.pModelListPanel2:Dock( RIGHT )
		GAMEMODE.newQMenu.pModelListPanel2:SetWide(160)
		GAMEMODE.newQMenu.pModelListPanel2:SetPaintBackground(false)
		GAMEMODE.newQMenu.pModelListPanel2:DockMargin( 2, 0, 0, 0 )
				
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pModelListPanel2 )
		header:Dock( TOP )
		header:SetButtonText( "Model Color" )
		header:DockMargin( 0, 0, 0, 6 )
		
		local PModelColor = vgui.Create( "DColorMixer", GAMEMODE.newQMenu.pModelListPanel2)
		PModelColor:SetColor(Color(255,255,255,255))
		PModelColor:Dock( TOP )
		PModelColor:SetPalette( true )
		PModelColor:SetAlphaBar( false )
		PModelColor:SetWangs( false )
		
		local icon = vgui.Create( "menu_qButton2", GAMEMODE.newQMenu.pModelListPanel2)
		icon:SetHeight( 20 )
		icon:Dock( TOP )
		icon:DockMargin( 10, 4, 10, 0 )
		icon.SetTextOffsetY = 2
		icon:SetButtonText( "Set Color" )
		GAMEMODE.newQMenu.pModelListPanel2:Add( icon )
		
		icon:SetMouseInputEnabled( true )
		function icon:DoClick()
			surface.PlaySound( "ui/buttonclickrelease.wav" ) 
			local color2 = PModelColor:GetColor()
			RunConsoleCommand( "sgs_setplayercolor", color2.r, color2.g, color2.b )
		end
		
		GAMEMODE.newQMenu.pModelListPanel = vgui.Create( "DPanel", self )
		GAMEMODE.newQMenu.pModelListPanel:Dock( FILL )
		GAMEMODE.newQMenu.pModelListPanel:SetWide(300)
		GAMEMODE.newQMenu.pModelListPanel:SetPaintBackground(false)
		GAMEMODE.newQMenu.pModelListPanel:DockMargin( 0, 0, 2, 0 )
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pModelListPanel )
		header:Dock( TOP )
		header:SetButtonText( "Player Model Selection" )
		header:DockMargin( 0, 0, 0, 6 )

		GAMEMODE.newQMenu.pModelListScrollPanel = vgui.Create( "DScrollPanel", GAMEMODE.newQMenu.pModelListPanel )
		GAMEMODE.newQMenu.pModelListScrollPanel:Dock( FILL )
			
		if SGS.tier == "1" or SGS.tier == "2" or SGS.tier == "3" or SGS.tier == "4" or SGS.tier == "d" or SGS.tier == "m" or SGS.tier == "a" then
			local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pModelListScrollPanel )
			header:Dock( TOP )
			header:SetButtonText( "Basic Survivor Models" )
			header:DockMargin( 0, 0, 0, 6 )
		
			local pModelContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.pModelListScrollPanel)
			pModelContainerButtons:SetSpaceY( 4 )
			pModelContainerButtons:SetSpaceX( 4 )
			pModelContainerButtons:Dock(TOP)
			pModelContainerButtons:DockMargin( 4, 4, 4, 4 )
			
			for k, v in pairs(SGS.pmlist1) do
				local icon = vgui.Create( "SpawnIcon", pModelContainerButtons)
				icon:SetModel( player_manager.TranslatePlayerModel(v) )
				icon:SetToolTip( v )
				pModelContainerButtons:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v) 
				end				
			end
		end
			
		if SGS.tier == "2" or SGS.tier == "3" or SGS.tier == "4" or SGS.tier == "d" or SGS.tier == "m" or SGS.tier == "a" then
			local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pModelListScrollPanel )
			header:Dock( TOP )
			header:SetButtonText( "Skilled Survivor Models" )
			header:DockMargin( 0, 0, 0, 6 )
		
			local pModelContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.pModelListScrollPanel)
			pModelContainerButtons:SetSpaceY( 4 )
			pModelContainerButtons:SetSpaceX( 4 )
			pModelContainerButtons:Dock(TOP)
			pModelContainerButtons:DockMargin( 4, 4, 4, 4 )
			
			for k, v in pairs(SGS.pmlist2) do
				local icon = vgui.Create( "SpawnIcon", pModelContainerButtons)
				icon:SetModel( player_manager.TranslatePlayerModel(v) )
				icon:SetToolTip( v )
				pModelContainerButtons:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v) 
				end				
			end
		end
			
		if SGS.tier == "3" or SGS.tier == "4" or SGS.tier == "d" or SGS.tier == "m" or SGS.tier == "a" then
			local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pModelListScrollPanel )
			header:Dock( TOP )
			header:SetButtonText( "Adept Survivor Models" )
			header:DockMargin( 0, 0, 0, 6 )
		
			local pModelContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.pModelListScrollPanel)
			pModelContainerButtons:SetSpaceY( 4 )
			pModelContainerButtons:SetSpaceX( 4 )
			pModelContainerButtons:Dock(TOP)
			pModelContainerButtons:DockMargin( 4, 4, 4, 4 )
			
			for k, v in pairs(SGS.pmlist3) do
				local icon = vgui.Create( "SpawnIcon", pModelContainerButtons)
				icon:SetModel( player_manager.TranslatePlayerModel(v) )
				icon:SetToolTip( v )
				pModelContainerButtons:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v) 
				end				
			end
		end
			
		if SGS.tier == "4" or SGS.tier == "d" or SGS.tier == "m" or SGS.tier == "a" then
			local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pModelListScrollPanel )
			header:Dock( TOP )
			header:SetButtonText( "Veteran Survivor Models" )
			header:DockMargin( 0, 0, 0, 6 )
		
			local pModelContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.pModelListScrollPanel)
			pModelContainerButtons:SetSpaceY( 4 )
			pModelContainerButtons:SetSpaceX( 4 )
			pModelContainerButtons:Dock(TOP)
			pModelContainerButtons:DockMargin( 4, 4, 4, 4 )
			
			for k, v in pairs(SGS.pmlist4) do
				local icon = vgui.Create( "SpawnIcon", pModelContainerButtons)
				icon:SetModel( player_manager.TranslatePlayerModel(v) )
				icon:SetToolTip( v )
				pModelContainerButtons:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v) 
				end				
			end
		end
			
		if SGS.tier == "d" or SGS.tier == "m" or SGS.tier == "a" then
			local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pModelListScrollPanel )
			header:Dock( TOP )
			header:SetButtonText( "Donator Models" )
			header:DockMargin( 0, 0, 0, 6 )
		
			local pModelContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.pModelListScrollPanel)
			pModelContainerButtons:SetSpaceY( 4 )
			pModelContainerButtons:SetSpaceX( 4 )
			pModelContainerButtons:Dock(TOP)
			pModelContainerButtons:DockMargin( 4, 4, 4, 4 )
			
			for k, v in pairs(SGS.pmlistd) do
				local icon = vgui.Create( "SpawnIcon", pModelContainerButtons)
				icon:SetModel( player_manager.TranslatePlayerModel(v) )
				icon:SetToolTip( v )
				pModelContainerButtons:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v) 
				end				
			end
		end
			
		if SGS.tier == "m" or SGS.tier == "a" then
			local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pModelListScrollPanel )
			header:Dock( TOP )
			header:SetButtonText( "Moderator Models" )
			header:DockMargin( 0, 0, 0, 6 )
		
			local pModelContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.pModelListScrollPanel)
			pModelContainerButtons:SetSpaceY( 4 )
			pModelContainerButtons:SetSpaceX( 4 )
			pModelContainerButtons:Dock(TOP)
			pModelContainerButtons:DockMargin( 4, 4, 4, 4 )
			
			for k, v in pairs(SGS.pmlistm) do
				local icon = vgui.Create( "SpawnIcon", pModelContainerButtons)
				icon:SetModel( player_manager.TranslatePlayerModel(v) )
				icon:SetToolTip( v )
				pModelContainerButtons:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v) 
				end				
			end
		end
			
		if SGS.tier == "a" then
			local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pModelListScrollPanel )
			header:Dock( TOP )
			header:SetButtonText( "Administrator Models" )
			header:DockMargin( 0, 0, 0, 6 )
		
			local pModelContainerButtons = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.pModelListScrollPanel)
			pModelContainerButtons:SetSpaceY( 4 )
			pModelContainerButtons:SetSpaceX( 4 )
			pModelContainerButtons:Dock(TOP)
			pModelContainerButtons:DockMargin( 4, 4, 4, 4 )
			
			for k, v in pairs(SGS.pmlista) do
				local icon = vgui.Create( "SpawnIcon", pModelContainerButtons)
				icon:SetModel( player_manager.TranslatePlayerModel(v) )
				icon:SetToolTip( v )
				pModelContainerButtons:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v) 
				end				
			end
		end


	end
	DrawPlayerModelsNew()
	concommand.Add( "sgs_refreshpmodels", DrawPlayerModelsNew )
	
end
function PMODEL_TAB:Paint()

end
vgui.Register("qmenu_pmodel", PMODEL_TAB, "Panel")




local PPROTECT_TAB = {}
function PPROTECT_TAB:Init()
	self:DrawFrame()
end
function PPROTECT_TAB:DrawFrame()	
	function DrawSPPNew()
	
		if GAMEMODE.newQMenu.pProtectListPanel then GAMEMODE.newQMenu.pProtectListPanel:Remove() end
		
		GAMEMODE.newQMenu.pProtectListPanel = vgui.Create( "DPanel", self )
		GAMEMODE.newQMenu.pProtectListPanel:Dock( FILL )
		GAMEMODE.newQMenu.pProtectListPanel:SetWide(300)
		GAMEMODE.newQMenu.pProtectListPanel:SetPaintBackground(false)
		GAMEMODE.newQMenu.pProtectListPanel:DockMargin( 0, 0, 2, 0 )
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pProtectListPanel )
		header:Dock( TOP )
		header:SetButtonText( "Prop Protection Client Menu" )
		header:DockMargin( 0, 0, 0, 6 )

		GAMEMODE.newQMenu.pProtectListScrollPanel = vgui.Create( "DScrollPanel", GAMEMODE.newQMenu.pProtectListPanel )
		GAMEMODE.newQMenu.pProtectListScrollPanel:Dock( FILL )

		local icon = vgui.Create( "menu_qButton2", GAMEMODE.newQMenu.pProtectListScrollPanel)
		icon:SetSize( 120, 20 )
		icon:SetButtonText( "Cleanup All Owned Items" )
		icon.SetTextOffsetY = 2
		icon:Dock(TOP)
		icon:DockMargin( 10, 0, 10, 12 )
		GAMEMODE.newQMenu.pProtectListScrollPanel:Add( icon )
		icon:SetMouseInputEnabled( true )
		function icon:DoClick()
			surface.PlaySound( "ui/buttonclickrelease.wav" ) 
			RunConsoleCommand( "spp_cleanupprops" )
		end
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.pProtectListScrollPanel )
		header:Dock( TOP )
		header:SetButtonText( "Friends Panel" )
		header:DockMargin( 0, 0, 0, 6 )
		
		local Players = player.GetAll()
		if(table.Count(Players) == 1) then
			local header = vgui.Create( "menu_qLabelBarSmall", GAMEMODE.newQMenu.pProtectListScrollPanel )
			header:Dock( TOP )
			header:SetButtonText( "No Other Players Are Online :(" )
			header:DockMargin( 25, 0, 25, 6 )
		else
			local playerList = vgui.Create( "DIconLayout", GAMEMODE.newQMenu.pProtectListScrollPanel)
			playerList:Dock(TOP)
			playerList:SetSpaceY( 4 )
		
			for k, ply in pairs(Players) do
				if(ply and ply:IsValid() and ply != LocalPlayer()) then
					local FriendCommand = "spp_friend_"..ply:GetNWString("SPPSteamID", "")
					if(!LocalPlayer():GetInfo(FriendCommand)) then
						CreateClientConVar(FriendCommand, 0, false, true)
					end
					
					local checkbox = vgui.Create( "DCheckBoxLabel", playerList )
					checkbox:SetText( ply:Nick() )
					checkbox:SetConVar( FriendCommand )
					checkbox:Dock(TOP)
				end
			end
			
		end

		local icon = vgui.Create( "menu_qButton2", GAMEMODE.newQMenu.pProtectListScrollPanel)
		icon:SetSize( 120, 20 )
		icon:SetButtonText( "Apply Settings" )
		icon.SetTextOffsetY = 2
		icon:Dock(TOP)
		icon:DockMargin( 10, 0, 10, 12 )
		GAMEMODE.newQMenu.pProtectListScrollPanel:Add( icon )
		icon:SetMouseInputEnabled( true )
		function icon:DoClick()
			surface.PlaySound( "ui/buttonclickrelease.wav" ) 
			RunConsoleCommand( "spp_applyfriends" )
		end

		local icon = vgui.Create( "menu_qButton2", GAMEMODE.newQMenu.pProtectListScrollPanel)
		icon:SetSize( 120, 20 )
		icon:SetButtonText( "Unown ALL Props/Structures" )
		icon.SetTextOffsetY = 2
		icon:Dock(TOP)
		icon:DockMargin( 10, 0, 10, 12 )
		GAMEMODE.newQMenu.pProtectListScrollPanel:Add( icon )
		icon:SetMouseInputEnabled( true )
		function icon:DoClick()
			surface.PlaySound( "ui/buttonclickrelease.wav" ) 
			SGS_ConfirmPropDisown()
		end
		
	end
	DrawSPPNew()
	concommand.Add( "sgs_refreshspp", DrawSPPNew )
	
end
function PPROTECT_TAB:Paint()

end
vgui.Register("qmenu_pprotect", PPROTECT_TAB, "Panel")

function SGS_ConfirmPropCleanup(  )

	ConfirmCleanup = vgui.Create( "DFrame" )
	ConfirmCleanup:ShowCloseButton(true)
	ConfirmCleanup:SetDraggable(false)
	ConfirmCleanup:SetSize( 225, 100 )
	ConfirmCleanup:SetTitle( "Confirm Cleanup" )
	ConfirmCleanup:SetPos( ScrW() / 2 - 75, ScrH() / 2 - 75 )
	ConfirmCleanup:MakePopup()
	
	local InvLabel = vgui.Create("DLabel", ConfirmCleanup)
	InvLabel:SetPos(10,25) // Position
	InvLabel:SetColor(Color(255,255,0,255)) // Color
	InvLabel:SetFont("SGS_RCacheMenuText")
	InvLabel:SetText("Are you sure you want to cleanup all") // Text
	InvLabel:SizeToContents()
	
	local InvLabel = vgui.Create("DLabel", ConfirmCleanup)
	InvLabel:SetPos(10,40) // Position
	InvLabel:SetColor(Color(255,255,0,255)) // Color
	InvLabel:SetFont("SGS_RCacheMenuText")
	InvLabel:SetText("of your props?") // Text
	InvLabel:SizeToContents()
	
	local InvLabel = vgui.Create("DLabel", ConfirmCleanup)
	InvLabel:SetPos(10,55) // Position
	InvLabel:SetColor(Color(255,0,0,255)) // Color
	InvLabel:SetFont("SGS_RCacheMenuText")
	InvLabel:SetText("WARNING: This includes structures.") // Text
	InvLabel:SizeToContents()
	
	local button = vgui.Create( "DButton", ConfirmCleanup )
	button:SetSize( 40, 20 )
	button:SetPos( 10, 70 )
	button:SetText( "No" )
	button.DoClick = function( button )
		ConfirmCleanup:SetVisible(false)
	end
	
	local button3 = vgui.Create( "DButton", ConfirmCleanup )
	button3:SetSize( 40, 20 )
	button3:SetPos( 60, 70 )
	button3:SetText( "Yes" )
	button3.DoClick = function( button3 )
		RunConsoleCommand("sgs_cleanupmyprops")
		ConfirmCleanup:SetVisible(false)
	end
	
	ConfirmCleanup:SetVisible(true)
end

function SGS_ConfirmPropDisown(  )

	ConfirmDisown = vgui.Create( "DFrame" )
	ConfirmDisown:ShowCloseButton(true)
	ConfirmDisown:SetDraggable(false)
	ConfirmDisown:SetSize( 225, 100 )
	ConfirmDisown:SetTitle( "Confirm Disown" )
	ConfirmDisown:SetPos( ScrW() / 2 - 75, ScrH() / 2 - 75 )
	ConfirmDisown:MakePopup()
	
	local InvLabel = vgui.Create("DLabel", ConfirmDisown)
	InvLabel:SetPos(10,25) // Position
	InvLabel:SetColor(Color(255,255,0,255)) // Color
	InvLabel:SetFont("SGS_RCacheMenuText")
	InvLabel:SetText("Are you sure you want to disown all") // Text
	InvLabel:SizeToContents()
	
	local InvLabel = vgui.Create("DLabel", ConfirmDisown)
	InvLabel:SetPos(10,40) // Position
	InvLabel:SetColor(Color(255,255,0,255)) // Color
	InvLabel:SetFont("SGS_RCacheMenuText")
	InvLabel:SetText("of your props?") // Text
	InvLabel:SizeToContents()
	
	local InvLabel = vgui.Create("DLabel", ConfirmDisown)
	InvLabel:SetPos(10,55) // Position
	InvLabel:SetColor(Color(255,0,0,255)) // Color
	InvLabel:SetFont("SGS_RCacheMenuText")
	InvLabel:SetText("WARNING: This includes structures.") // Text
	InvLabel:SizeToContents()
	
	local button = vgui.Create( "DButton", ConfirmDisown )
	button:SetSize( 40, 20 )
	button:SetPos( 10, 70 )
	button:SetText( "No" )
	button.DoClick = function( button )
		ConfirmDisown:SetVisible(false)
	end
	
	local button3 = vgui.Create( "DButton", ConfirmDisown )
	button3:SetSize( 40, 20 )
	button3:SetPos( 60, 70 )
	button3:SetText( "Yes" )
	button3.DoClick = function( button3 )
		RunConsoleCommand("sgs_disownall")
		ConfirmDisown:SetVisible(false)
	end
	
	ConfirmDisown:SetVisible(true)
end

local VCHANNEL_TAB = {}
function VCHANNEL_TAB:Init()
	self:DrawFrame()
end
function VCHANNEL_TAB:DrawFrame()	
	function DrawVChannelNew()
	
		if GAMEMODE.newQMenu.vChannelListPanel then GAMEMODE.newQMenu.vChannelListPanel:Remove() end
		
		GAMEMODE.newQMenu.vChannelListPanel = vgui.Create( "DPanel", self )
		GAMEMODE.newQMenu.vChannelListPanel:Dock( FILL )
		GAMEMODE.newQMenu.vChannelListPanel:SetWide(300)
		GAMEMODE.newQMenu.vChannelListPanel:SetPaintBackground(false)
		GAMEMODE.newQMenu.vChannelListPanel:DockMargin( 0, 0, 2, 0 )
		
		local header = vgui.Create( "menu_qLabelBar", GAMEMODE.newQMenu.vChannelListPanel )
		header:Dock( TOP )
		header:SetButtonText( "Voice Channels Menu" )
		header:DockMargin( 0, 0, 0, 6 )

		GAMEMODE.newQMenu.vChannelListScrollPanel = vgui.Create( "DScrollPanel", GAMEMODE.newQMenu.vChannelListPanel )
		GAMEMODE.newQMenu.vChannelListScrollPanel:Dock( FILL )
		
		local VCListView = vgui.Create( "DListView", GAMEMODE.newQMenu.vChannelListScrollPanel )
		VCListView:SetHeight( 300 )
		VCListView:Dock(TOP)
		VCListView:DockMargin(6,0,6,10)
		VCListView:SetMultiSelect( false )
		VCListView:AddColumn( "ID" ):SetFixedWidth( 40 )
		VCListView:AddColumn( "Channel Name" )
		VCListView:AddColumn( "Passworded" ):SetFixedWidth( 70 )
		VCListView:AddColumn( "Creator" ):SetFixedWidth( 130 )
		
		local icon = vgui.Create( "menu_qButton2", GAMEMODE.newQMenu.vChannelListScrollPanel)
		icon:SetSize( 120, 20 )
		icon:SetButtonText( "Create New Channel" )
		icon.SetTextOffsetY = 2
		icon:Dock(TOP)
		icon:DockMargin( 10, 0, 10, 5 )
		GAMEMODE.newQMenu.vChannelListScrollPanel:Add( icon )
		icon:SetMouseInputEnabled( true )
		function icon:DoClick()
			surface.PlaySound( "ui/buttonclickrelease.wav" ) 
			SGS_CreateNewVCGUI()
		end
		
		local icon = vgui.Create( "menu_qButton2", GAMEMODE.newQMenu.vChannelListScrollPanel)
		icon:SetSize( 120, 20 )
		icon:SetButtonText( "Join Selected Channel" )
		icon.SetTextOffsetY = 2
		icon:Dock(TOP)
		icon:DockMargin( 10, 0, 10, 5 )
		GAMEMODE.newQMenu.vChannelListScrollPanel:Add( icon )
		icon:SetMouseInputEnabled( true )
		function icon:DoClick()
			surface.PlaySound( "ui/buttonclickrelease.wav" ) 
			local cid = tostring(VCListView:GetLine(VCListView:GetSelectedLine()):GetValue(1))
			if cid == "A" or cid == "W" or cid == "T" then 
				RunConsoleCommand("sgs_joinvoicechannel", cid )
			else
				if SGS.voicechannels[tonumber(cid)].ispassworded then
					SGS_VCJoinPassworded( cid )
				else
					RunConsoleCommand("sgs_joinvoicechannel", tonumber(cid) )
				end
			end
		end
		
		local icon = vgui.Create( "menu_qButton2", GAMEMODE.newQMenu.vChannelListScrollPanel)
		icon:SetSize( 120, 20 )
		icon:SetButtonText( "Refresh List" )
		icon.SetTextOffsetY = 2
		icon:Dock(TOP)
		icon:DockMargin( 10, 10, 10, 5 )
		GAMEMODE.newQMenu.vChannelListScrollPanel:Add( icon )
		icon:SetMouseInputEnabled( true )
		function icon:DoClick()
			surface.PlaySound( "ui/buttonclickrelease.wav" ) 
			RunConsoleCommand("sgs_requestvclist")
		end
		
		VCListView:AddLine( "A", "Public AllTalk Channel", "", "GAME")
		VCListView:AddLine( "T", "Tribe Voice Channel", "", "GAME")
		VCListView:AddLine( "W", "Local World Voice Channel", "", "GAME")
		for k, v in pairs(SGS.voicechannels) do
			if v.banned then continue end
			if v.ispassworded then
				VCListView:AddLine( v.id, v.name, "*secure*", v.creator)
			else
				VCListView:AddLine( v.id, v.name, "", v.creator)
			end
		end
		
		
		if LocalPlayer():IsAdmin() then
			local icon = vgui.Create( "menu_qButton2", GAMEMODE.newQMenu.vChannelListScrollPanel)
			icon:SetSize( 120, 20 )
			icon:SetButtonText( "Delete Voice Channel (ADMIN)" )
			icon.SetTextOffsetY = 2
			icon:Dock(TOP)
			icon:DockMargin( 10, 10, 10, 5 )
			GAMEMODE.newQMenu.vChannelListScrollPanel:Add( icon )
			icon:SetMouseInputEnabled( true )
			function icon:DoClick()
				surface.PlaySound( "ui/buttonclickrelease.wav" )
				local cid = tostring(VCListView:GetLine(VCListView:GetSelectedLine()):GetValue(1))
				if cid == "A" or cid == "W" or cid == "T" then return end
				RunConsoleCommand("sgs_removevc", cid)
			end
		end
		
	end
	DrawVChannelNew()
	concommand.Add( "sgs_refreshvc", DrawVChannelNew )
	
end
function VCHANNEL_TAB:Paint()

end
vgui.Register("qmenu_vchannel", VCHANNEL_TAB, "Panel")

function SGS_CreateNewVCGUI()

	local guiFrame = vgui.Create( "DFrame" )
	guiFrame:ShowCloseButton(true)
	guiFrame:SetDraggable(false)
	guiFrame:SetSize( 300, 150 )
	guiFrame:SetTitle( "Create Voice Channel" )
	guiFrame:SetPos( ScrW() / 2 - 150, ScrH() / 2 - 75 )
	guiFrame:MakePopup()
	
	local nametextbx = vgui.Create( "DTextEntry", guiFrame )
	nametextbx:SetPos( 10, 45 )
	nametextbx:SetSize( 280, 20 )
	nametextbx:SetAllowNonAsciiCharacters( false )
	
	local passtextbx = vgui.Create( "DTextEntry", guiFrame )
	passtextbx:SetPos( 10, 90 )
	passtextbx:SetSize( 280, 20 )
	passtextbx:SetAllowNonAsciiCharacters( false )
	
	
	local namelbl = vgui.Create( "DLabel", guiFrame )
	namelbl:SetPos(10,30) // Position
	namelbl:SetColor(Color(255,255,255,255)) // Color
	namelbl:SetFont("SGS_RCacheMenuText")
	namelbl:SetText("Channel Name") // Text
	namelbl:SizeToContents()
	
	
	local passlbl = vgui.Create( "DLabel", guiFrame )
	passlbl:SetPos(10,75) // Position
	passlbl:SetColor(Color(255,255,255,255)) // Color
	passlbl:SetFont("SGS_RCacheMenuText")
	passlbl:SetText("Channel Password (Leave blank for none)") // Text
	passlbl:SizeToContents()
	
	
	local okbtn = vgui.Create( "DButton" , guiFrame )
	okbtn:SetPos( 10, 120 )
	okbtn:SetSize( 50, 20)
	okbtn:SetText( "Create" )
	okbtn.DoClick = function( okbtn )
		if nametextbx:GetValue() == "" then
		else
			if passtextbx:GetValue() == "" then
				RunConsoleCommand( "sgs_createvoicechannel", nametextbx:GetValue() )
			else
				RunConsoleCommand( "sgs_createvoicechannel", nametextbx:GetValue(), passtextbx:GetValue() )
			end
			guiFrame:Close()
		end
	end
	
	
	local cancelbtn = vgui.Create( "DButton" , guiFrame )
	cancelbtn:SetPos( 70, 120 )
	cancelbtn:SetSize( 50, 20)
	cancelbtn:SetText( "Cancel" )
	cancelbtn.DoClick = function( cancelbtn ) guiFrame:Close() end

end

function SGS_VCJoinPassworded( cid )

	local vcid = tostring(cid)

	local guiFrame = vgui.Create( "DFrame" )
	guiFrame:ShowCloseButton(true)
	guiFrame:SetDraggable(false)
	guiFrame:SetSize( 300, 105 )
	guiFrame:SetTitle( "Enter Password" )
	guiFrame:SetPos( ScrW() / 2 - 150, ScrH() / 2 - 50 )
	guiFrame:MakePopup()
	
	local passtextbx = vgui.Create( "DTextEntry", guiFrame )
	passtextbx:SetPos( 10, 45 )
	passtextbx:SetSize( 280, 20 )
	
	
	local passlbl = vgui.Create( "DLabel", guiFrame )
	passlbl:SetPos(10,30) // Position
	passlbl:SetColor(Color(255,255,255,255)) // Color
	passlbl:SetFont("SGS_RCacheMenuText")
	passlbl:SetText("This channel is passworded") // Text
	passlbl:SizeToContents()


	local okbtn = vgui.Create( "DButton" , guiFrame )
	okbtn:SetPos( 10, 75 )
	okbtn:SetSize( 50, 20)
	okbtn:SetText( "Join" )
	okbtn.DoClick = function( okbtn )
		if passtextbx:GetValue() == "" then
		else
			RunConsoleCommand("sgs_joinvoicechannel", vcid, passtextbx:GetValue() )
			guiFrame:Close()
		end
	end
	
	
	local cancelbtn = vgui.Create( "DButton" , guiFrame )
	cancelbtn:SetPos( 70, 75 )
	cancelbtn:SetSize( 50, 20)
	cancelbtn:SetText( "Cancel" )
	cancelbtn.DoClick = function( cancelbtn ) guiFrame:Close() end

end



	
local LABEL_BAR = {}
function LABEL_BAR:Init()
	self:SetTall( 25 )
	self.btxt = ""
end

function LABEL_BAR:Paint()
	if self.PaintColor then
		surface.SetDrawColor( self.PaintColor )
	else
		surface.SetDrawColor( 65, 65, 65, 100 )
	end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	draw.DrawText(self.btxt, "qMenuFont5", self:GetWide() / 2, 4, Color(150,150,150,255), TEXT_ALIGN_CENTER)
end

function LABEL_BAR:SetButtonText( txt )
	self.btxt = txt
end
vgui.Register("menu_qLabelBar", LABEL_BAR, "DPanel")
		
local LABEL_BAR_SMALL = {}
function LABEL_BAR_SMALL:Init()
	self:SetTall( 16 )
	self.btxt = ""
end

function LABEL_BAR_SMALL:Paint()
	if self.PaintColor then
		surface.SetDrawColor( self.PaintColor )
	else
		surface.SetDrawColor( 65, 65, 65, 100 )
	end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	draw.DrawText(self.btxt, "qMenuFont4", self:GetWide() / 2, 3, Color(200,200,200,255), TEXT_ALIGN_CENTER)
end

function LABEL_BAR_SMALL:SetButtonText( txt )
	self.btxt = txt
end
vgui.Register("menu_qLabelBarSmall", LABEL_BAR_SMALL, "DPanel")


local BUTTON = {}
function BUTTON:Init()
	self:SetTall( 25 )
	self.btxt = ""
	self.enabled = true
	self.active = false
	self:SetCursor( "hand" )
	self:SetText(" ")
end

function BUTTON:Paint()
	if self.enabled then
		if self.active then
			surface.SetDrawColor( 100, 125, 125, 210 )
			surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
			draw.DrawText(self.btxt, "qMenuFont5", self:GetWide() / 2, 4, Color(220,220,220,255), TEXT_ALIGN_CENTER)			
		else
			surface.SetDrawColor( 100, 100, 100, 210 )
			surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
			draw.DrawText(self.btxt, "qMenuFont5", self:GetWide() / 2, 4, Color(220,220,220,255), TEXT_ALIGN_CENTER)
		end
	else
		surface.SetDrawColor( 65, 65, 65, 210 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
		draw.DrawText(self.btxt, "qMenuFont5", self:GetWide() / 2, 4, Color(150,150,150,255), TEXT_ALIGN_CENTER)
	end
end

function BUTTON:SetButtonText( txt )
	self.btxt = txt
end

function BUTTON:Disable( bool )
	if bool then
		self.enabled = false
	else
		self.enabled = true
	end
end
vgui.Register("menu_qButton", BUTTON, "DButton")


local BUTTON = {}
function BUTTON:Init()
	self:SetTall( 16 )
	self.btxt = ""
	self.enabled = true
	self.active = false
	self:SetCursor( "hand" )
	self:SetText(" ")
end

function BUTTON:Paint()

	local x = self:GetWide() / 2
	local y = 1 + ( self.SetTextOffsetY or 0 )

	if self.enabled then
		surface.SetDrawColor( 100, 100, 100, 210 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
		draw.DrawText(self.btxt, "qMenuFont1", x, y, Color(220,220,220,255), TEXT_ALIGN_CENTER)		
	else
		surface.SetDrawColor( 65, 65, 65, 180 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
		draw.DrawText(self.btxt, "qMenuFont1", x, y, Color(120,120,120,120), TEXT_ALIGN_CENTER)		
	end
end

function BUTTON:SetButtonText( txt )
	self.btxt = txt
end

function BUTTON:Disable( bool )
	if bool then
		self.enabled = false
	else
		self.enabled = true
	end
end
vgui.Register("menu_qButton2", BUTTON, "DButton")


local BUTTON = {}
function BUTTON:Init()
	self:SetTall( 16 )
	self.btxt = ""
	self.enabled = true
	self.active = false
	self:SetCursor( "hand" )
	self:SetText(" ")
	timer.Simple( 0, function() self:DrawIcons() end )
end

function BUTTON:DrawIcons()
	local icon = vgui.Create( "SpawnIcon", self )
	icon:SetSize(26,26)
	icon:SetPos( 2, 2 )
	icon:SetModel( self.model )
	icon:SetTooltip( "Click to rebuild icon graphic" )
	icon.DoClick = function ( icon )
		icon:RebuildSpawnIcon()
	end
end

function BUTTON:Paint()

	local x = ( self:GetWide() / 2 ) + 16 + ( self.SetTextOffsetX or 0 )
	local y = 3 + ( self.SetTextOffsetY or 0 )

	surface.SetDrawColor( 100, 100, 100, 210 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	draw.DrawText(self.btxt, "qMenuFont6", x, y, Color(220,220,220,255), TEXT_ALIGN_CENTER)			
	surface.SetDrawColor( 255, 255, 255, 255 )
end

function BUTTON:SetButtonText( txt )
	self.btxt = txt
end

function BUTTON:Disable( bool )
	if bool then
		self.enabled = false
	else
		self.enabled = true
	end
end
vgui.Register("menu_qPropButton", BUTTON, "DButton")



local BUTTON = {}
function BUTTON:Init()
	self.btxt = ""
	self.enabled = true
	self.active = false
	self:SetCursor( "hand" )
	self:SetText(" ")
end

function BUTTON:Paint()

	local x = ( self:GetWide() / 2 ) + 16 + ( self.SetTextOffsetX or 0 )
	local y = 3 + ( self.SetTextOffsetY or 0 )

	surface.SetDrawColor( 100, 100, 100, 210 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	draw.DrawText(self.btxt, "qMenuFont2", x, y, Color(220,220,220,255), TEXT_ALIGN_CENTER)			
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material(self.iconimage)	) -- If you use Material, cache it!
	surface.DrawTexturedRect( 1, 1, 32, 32 )
end

function BUTTON:SetButtonText( txt )
	self.btxt = txt
end

function BUTTON:Disable( bool )
	if bool then
		self.enabled = false
	else
		self.enabled = true
	end
end
vgui.Register("menu_qSpellButton", BUTTON, "DButton")




local BUTTON = {}
function BUTTON:Init()
	self.btxt = ""
	self.enabled = true
	self.active = false
	self:SetCursor( "hand" )
	self:SetText(" ")
end

function BUTTON:Paint()

	local x = ( self:GetWide() / 2 )  + ( self.SetTextOffsetX or 0 )
	local y = 1 + ( self.SetTextOffsetY or 0 )

	surface.SetDrawColor( 100, 100, 100, 210 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	draw.DrawText(self.btxt, "qMenuFont1", x, y, Color(220,220,220,255), TEXT_ALIGN_CENTER)			
end

function BUTTON:SetButtonText( txt )
	self.btxt = txt
end

function BUTTON:Disable( bool )
	if bool then
		self.enabled = false
	else
		self.enabled = true
	end
end
vgui.Register("menu_qResourceButton", BUTTON, "DButton")


--Background Drop Panel
local PANEL = {}
function PANEL:Init()

	self:SetSize( ScrW(), ScrH() )
	self:SetPos( 0, 0 )
	self:MoveToBack()
	
end
function PANEL:Paint()
	surface.SetDrawColor( 0, 0, 0, 0 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
end
vgui.Register("drop_panel", PANEL, "DPanel")



--Resource Dialogue Panel
local PANEL = {}
function PANEL:Init()
	self:SetSize( 250, 178 )
	self:SetZPos( 2000 )
	self:Center()
	self:DrawFrame()
end
function PANEL:Paint()
	surface.SetDrawColor( 60, 60, 60, 230 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
end
function PANEL:DrawFrame()
	local function DrawFrameTick()
		local destroy_confirm = false
		local resource_name = self.res or "ERROR"
		local resource_amt = self.amt or 0
		
		local ListPanel = vgui.Create( "DPanel", self )
		ListPanel:Dock( FILL )
		ListPanel:SetPaintBackground(false)

		local MenuLabel = vgui.Create( "menu_qLabelBar", ListPanel )
		MenuLabel:SetButtonText( CapAll( string.gsub( resource_name, "_", " " ) ) )
		MenuLabel:Dock(TOP)
		MenuLabel:DockMargin( 6, 6, 6, 0 )
		MenuLabel.PaintColor = Color( 40, 40, 40, 230 )

		local MenuLabel = vgui.Create( "menu_qLabelBarSmall", ListPanel )
		MenuLabel:SetButtonText( "Amount" )
		MenuLabel:Dock(TOP)
		MenuLabel:DockMargin( 6, 10, 6, 0 )
		MenuLabel.PaintColor = Color( 40, 40, 40, 230 )
		
		local resText = vgui.Create("DTextEntry", ListPanel)
		resText:SetText( resource_amt )
		resText:SetEditable( true )
		resText:Dock(TOP)
		resText:DockMargin( 6, 2, 6, 0 )

		local ContainerButtons = vgui.Create( "DIconLayout", ListPanel)
		ContainerButtons:SetSpaceY( 4 )
		ContainerButtons:SetSpaceX( 5 )
		ContainerButtons:Dock(TOP)
		ContainerButtons:DockMargin( 6, 10, 6, 0 )
			
		local OptionButton1 = vgui.Create( "menu_qButton2", ContainerButtons)
		OptionButton1:SetSize( 116, 18 )
		OptionButton1:SetButtonText( "Drop: Owned" )
		OptionButton1.SetTextOffsetY = 2
		OptionButton1.OnMousePressed = function( panel, m )
			if m == MOUSE_LEFT then
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand("sgs_dropresource", resource_name, resText:GetValue())
				self:Remove()
			end
		end
			
		local OptionButton2 = vgui.Create( "menu_qButton2", ContainerButtons)
		OptionButton2:SetSize( 116, 18 )
		OptionButton2:SetButtonText( "Drop: Unowned" )
		OptionButton2.SetTextOffsetY = 2
		OptionButton2.OnMousePressed = function( panel, m )
			if m == MOUSE_LEFT then
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand("sgs_dropresource2", resource_name, resText:GetValue())
				self:Remove()
			end
		end
			
		local OptionButton3 = vgui.Create( "menu_qButton2", ContainerButtons)
		OptionButton3:SetSize( 116, 18 )
		OptionButton3:SetButtonText( "Set Amount: All" )
		OptionButton3.SetTextOffsetY = 2
		OptionButton3.OnMousePressed = function( panel, m )
			if m == MOUSE_LEFT then
				surface.PlaySound( "ui/buttonclickrelease.wav" )
				resText:SetText( resource_amt )
			end
		end
			
		local OptionButton4 = vgui.Create( "menu_qButton2", ContainerButtons)
		OptionButton4:SetSize( 116, 18 )
		OptionButton4:SetButtonText( "Destroy" )
		OptionButton4.SetTextOffsetY = 2
		OptionButton4.OnMousePressed = function( panel, m )
			
			if m == MOUSE_LEFT then
				if destroy_confirm then
					surface.PlaySound( "ui/buttonclickrelease.wav" )
					RunConsoleCommand("sgs_destroyresource", resource_name, resText:GetValue())
					self:Remove()
				else
					surface.PlaySound( "buttons/button18.wav" )
					util.ScreenShake( LocalPlayer():GetPos(), 3, 4, 1, 250 )
					SGS_PrintMessageMiniConsole( "CONFIRM DELETE: Click Again to delete!", Color( 255,0,0,255) )
					destroy_confirm = true
				end
			end
		end
			
		local OptionButton5 = vgui.Create( "menu_qButton2", ContainerButtons)
		OptionButton5:SetSize( 116, 18 )
		OptionButton5:SetButtonText( "Consume / Use" )
		OptionButton5.SetTextOffsetY = 2
		OptionButton5.OnMousePressed = function( panel, m )
			if m == MOUSE_LEFT then
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand("sgs_pdrink", resource_name)
				RunConsoleCommand("sgs_eat", resource_name)
				self:Remove()
			end
		end
		OptionButton5:Disable( true )
			
		local OptionButton6 = vgui.Create( "menu_qButton2", ContainerButtons)
		OptionButton6:SetSize( 116, 18 )
		OptionButton6:SetButtonText( "Unpack" )
		OptionButton6.SetTextOffsetY = 2
		OptionButton6.OnMousePressed = function( panel, m )
			if m == MOUSE_LEFT then
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand("sgs_unpack", resource_name)
				self:Remove()
			end
		end
		OptionButton6:Disable( true )
			
		local OptionButton7 = vgui.Create( "menu_qButton2", ContainerButtons)
		OptionButton7:SetSize( 116, 18 )
		OptionButton7:SetButtonText( "Cancel" )
		OptionButton7.SetTextOffsetY = 2
		OptionButton7.OnMousePressed = function( panel, m )
			if m == MOUSE_LEFT then
				surface.PlaySound( "ui/buttonclickrelease.wav" )
				self:Remove()
			end
		end
		
		
		if self.consumeEnable then OptionButton5:Disable( false ) resText:SetText( "1" ) end
		if self.unpackEnable then OptionButton6:Disable( false ) resText:SetText( "1" )end
	end
	timer.Simple( 0, DrawFrameTick )
	
end
vgui.Register("resource_dialogue", PANEL, "EditablePanel")