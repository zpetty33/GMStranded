/*--------------------------------
---------------Tabs---------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()

    self:SetPos(40, 40)
    self:SetSize(620,530)
    self:SetVisible(false)
	
	self:DrawTabs()

end

function PANEL:DrawTabs()

	self:SetShowIcons( false )
	
	local SheetItemOne = vgui.Create( "sgs_propsmenu" )
	local SheetItemTwo = vgui.Create( "sgs_structuresmenu" )
	local SheetItemThree = vgui.Create( "sgs_farmmenu" )
	local SheetItemFour = vgui.Create( "sgs_toolsmenu" )
	local SheetItemFive = vgui.Create( "sgs_resourcemenu" )
	local SheetItemTen = vgui.Create( "sgs_spellmenu" )
	local SheetItemEig = vgui.Create( "sgs_optionsmenu" )
	local SheetItemSix = vgui.Create( "sgs_pmodelmenu" )
	local SheetItemSev = vgui.Create( "sgs_sppmenu" )
	local SheetItemEight = vgui.Create( "sgs_voicechans" )
	
	
 	self:AddSheet( "Props", SheetItemOne, _, false, false, "Props Menu" )
 	self:AddSheet( "Structures", SheetItemTwo, _, false, false, "Structures Menu" )
 	self:AddSheet( "Farming", SheetItemThree, _, false, false, "Farming Menu" )
 	self:AddSheet( "Tools", SheetItemFour, _, false, false, "Tools Menu" )
 	self:AddSheet( "Resources", SheetItemFive, _, false, false, "Resource Menu" )
 	self:AddSheet( "Spells", SheetItemTen, _, false, false, "Spell Menu" )
 	self:AddSheet( "Options", SheetItemEig, _, false, false, "Options Menu" )
 	self:AddSheet( "Player Model", SheetItemSix, _, false, false, "Player Model Menu" )
	self:AddSheet( "Prop Protection", SheetItemSev, _, false, false, "Prop Protection Menu" )
	self:AddSheet( "Voice Channels", SheetItemEight, _, false, false, "Voice Channel Menu" )

end
vgui.Register("sgs_tabmenu", PANEL, "DPropertySheet")

/*--------------------------------
------------Prop Menu-------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0, 0)
    self:SetSize(600, 510)
    self:SetVisible(false)
	
	self:DrawFrame()
	
	
end

function PANEL:DrawFrame()

	local Scroll = vgui.Create( "DScrollPanel", self )
	Scroll:SetSize( 150, 500 )
	Scroll:SetPos( 5, 5 )

	local List = vgui.Create( "DIconLayout", Scroll )
	List:SetSize( Scroll:GetWide() - 15, Scroll:GetTall() )
	List:SetPos( 0, 0 )
	List:SetSpaceY(2)
	
	self.scroll2 = vgui.Create( "DScrollPanel", self )
	self.scroll2:SetSize( 435, 500 )
	self.scroll2:SetPos( 160, 5 )

	self.list2 = vgui.Create( "DIconLayout", self.scroll2 )
	self.list2:SetSize( self.scroll2:GetWide() - 15, self.scroll2:GetTall() )
	self.list2:SetPos( 0, 0 )
	self.list2:SetSpaceY(4)
	
	for k, v in pairs( SGS.props ) do
		local catButton = vgui.Create( "DButton" )
		catButton:SetSize( 135, 20 )
		catButton:SetText( Cap(k) .. " Items" )
		catButton.DoClick = function( button )
			surface.PlaySound( "ui/buttonclickrelease.wav" ) 
			if IsValid(self.list2) then self.list2:Clear( true ) end
			
			for _, prop in pairs( SGS.props[k] ) do
				local icon = vgui.Create( "SpawnIcon", IconList )
				icon:SetModel( prop.model )
				icon:SetToolTip( SGS_ToolTip(prop))
				icon.PaintOver = function()
					for k3, v3 in pairs( prop.reqlvl ) do
						local plvl = SGS.levels[ k3 ] or 0
						if plvl < v3 then
							draw.RoundedBoxEx( 2, 5, 5, 54, 20, Color(255, 80, 80, 150), false, false, false, false )
							draw.SimpleText("INSUFFICIENT", "proplisticons", 7, 7, Color(0, 0, 0, 255), 0, 0)
							draw.SimpleText("SKILL", "proplisticons", 25, 15, Color(0, 0, 0, 255), 0, 0)
							icon.OnCursorEntered = function()
								return true
							end
							break
						end
					end
					for k3, v3 in pairs( prop.cost ) do
						local pamt = SGS.resources[ k3 ] or 0
						if pamt < v3 then
							draw.RoundedBoxEx( 2, 5, 39, 54, 20, Color(255, 255, 50, 150), false, false, false, false )
							draw.SimpleText("INSUFFICIENT", "proplisticons", 7, 41, Color(0, 0, 0, 255), 0, 0)
							draw.SimpleText("RESOURCES", "proplisticons", 8, 49, Color(0, 0, 0, 255), 0, 0)
							icon.OnCursorEntered = function()
								return true
							end
							break
						end
					end
				end
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_Spawn", prop.uid)
				end
				icon.DoRightClick = function( icon )
					local DropDown = DermaMenu()
					DropDown:AddOption("Rebuild Icon", function() icon:RebuildSpawnIcon() end )
					DropDown:Open()
				end	
				self.list2:Add( icon )
			end
		
		end
		
		
		List:Add( catButton )	
	end



end
vgui.Register("sgs_propsmenu", PANEL, "Panel")



/*--------------------------------
------------Structures-------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0, 0)
    self:SetSize(600, 510)
    self:SetVisible(false)
	
	self:DrawFrame()
	
	
end

function PANEL:DrawFrame()
	local CatLists = vgui.Create( "DPanelList", self)
	CatLists:EnableVerticalScrollbar( true )
	CatLists:EnableHorizontal( false )
	CatLists:SetSize( 600, 510 )
	CatLists:SetPos( 0, 0 )
	CatLists:SetPadding( 4 )
	
	
	for k, v in pairs( SGS.structures ) do
	
		local IconList = vgui.Create( "DIconLayout")
		local CollapseCat = vgui.Create( "DCollapsibleCategory" )
		CatLists:AddItem(CollapseCat)
				
		--CollapseCat:SetSize( 470, 50 )
		CollapseCat:SetExpanded( 1 )
		CollapseCat:SetLabel( Cap(k) .. " Structures" )
		
		CollapseCat:SetContents( IconList )
		
		
		IconList:SetSpaceX( 4 )
		IconList:SetSpaceY( 4 )
		
		
		for k2, v2 in pairs(SGS.structures[k]) do
			local icon = vgui.Create( "SpawnIcon", IconList )
			icon:SetModel( v2.model )
			--icon:SetToolTip( v2.tooltip .. "\nConstruction Level: " .. v2.reqlvl["construction"])
			icon:SetToolTip( SGS_ToolTip(v2) )
			IconList:Add( icon )
			icon.PaintOver = function()
				for k3, v3 in pairs( v2.reqlvl ) do
					local plvl = SGS.levels[ k3 ] or 0
					if plvl < v3 then
						draw.RoundedBoxEx( 2, 5, 5, 54, 20, Color(255, 80, 80, 150), false, false, false, false )
						draw.SimpleText("INSUFFICIENT", "proplisticons", 7, 7, Color(0, 0, 0, 255), 0, 0)
						draw.SimpleText("SKILL", "proplisticons", 25, 15, Color(0, 0, 0, 255), 0, 0)
						icon.OnCursorEntered = function()
							return true
						end
						break
					end
				end
				for k3, v3 in pairs( v2.cost ) do
					local pamt = SGS.resources[ k3 ] or 0
					if pamt < v3 then
						draw.RoundedBoxEx( 2, 5, 39, 54, 20, Color(255, 255, 50, 150), false, false, false, false )
						draw.SimpleText("INSUFFICIENT", "proplisticons", 7, 41, Color(0, 0, 0, 255), 0, 0)
						draw.SimpleText("RESOURCES", "proplisticons", 8, 49, Color(0, 0, 0, 255), 0, 0)
						icon.OnCursorEntered = function()
							return true
						end
						break
					end
				end
			end
			icon.DoClick = function ( icon ) 
				surface.PlaySound( "ui/buttonclickrelease.wav" ) 
				RunConsoleCommand("SGS_SpawnStructure", v2.ent) 
			end
			icon.DoRightClick = function( icon )
				local DropDown = DermaMenu()
				DropDown:AddOption("Created Packaged Version", function() RunConsoleCommand("SGS_SpawnStructurePackaged", v2.ent) end )
				DropDown:AddOption("Rebuild Icon", function() icon:RebuildSpawnIcon() end )
				DropDown:Open()
			end	
		end
	end	
end
vgui.Register("sgs_structuresmenu", PANEL, "Panel")


/*--------------------------------
-------------Farming--------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0, 0)
    self:SetSize(470, 510)
    self:SetVisible(false)
	
	self:DrawFrame()
	
	
end

function PANEL:DrawFrame()
	function DrawSeeds()
	
		if SGS.resources == nil then return end
	
		if SGS.farminggroup then SGS.farminggroup:Remove() end
		
		
		
		
		SGS.farminggroup = vgui.Create("DPanel", self)
		SGS.farminggroup:SetPos(0,0)
		SGS.farminggroup:SetSize(470, 510)
		SGS.farminggroup:SetPaintBackground( false )
		
		
		
		local FruitLabel = vgui.Create("DLabel", SGS.farminggroup)
		FruitLabel:SetColor(Color(255,255,255,255)) // Color
		FruitLabel:SetFont("SGS_HUD2")
		FruitLabel:SetPos( 0, 7 )
		FruitLabel:SetText("Fruit Seeds") // Text
		FruitLabel:SizeToContents() // make the control the same size as the text.
		
		local FarmList = vgui.Create( "DIconLayout", SGS.farminggroup)
		FarmList:SetSize( 150,150 )
		FarmList:SetPos( 0, 25 )
		FarmList:SetSpaceX( 3 )
		FarmList:SetSpaceY( 3 )
		
		
		local TreeLabel = vgui.Create("DLabel", SGS.farminggroup)
		TreeLabel:SetColor(Color(255,255,255,255)) // Color
		TreeLabel:SetFont("SGS_HUD2")
		TreeLabel:SetPos( 155, 7 )
		TreeLabel:SetText("Tree Seeds") // Text
		TreeLabel:SizeToContents() // make the control the same size as the text.
		
		local TreeList = vgui.Create( "DIconLayout", SGS.farminggroup)
		TreeList:SetSize( 150,150 )
		TreeList:SetPos( 155, 25 )
		TreeList:SetSpaceX( 3 )
		TreeList:SetSpaceY( 3 )
		
		
		local FoodLabel = vgui.Create("DLabel", SGS.farminggroup)
		FoodLabel:SetColor(Color(255,255,255,255)) // Color
		FoodLabel:SetFont("SGS_HUD2")
		FoodLabel:SetPos( 310, 7 )
		FoodLabel:SetText("Food Seeds") // Text
		FoodLabel:SizeToContents() // make the control the same size as the text.
		
		local FoodList = vgui.Create( "DIconLayout", SGS.farminggroup)
		FoodList:SetSize( 150,150 )
		FoodList:SetPos( 310, 25 )
		FoodList:SetSpaceX( 3 )
		FoodList:SetSpaceY( 3 )
		
		local AlchLabel = vgui.Create("DLabel", SGS.farminggroup)
		AlchLabel:SetColor(Color(255,255,255,255)) // Color
		AlchLabel:SetFont("SGS_HUD2")
		AlchLabel:SetPos( 0, 177 )
		AlchLabel:SetText("Alchemy Seeds") // Text
		AlchLabel:SizeToContents() // make the control the same size as the text.
		
		local AlchList = vgui.Create( "DIconLayout", SGS.farminggroup)
		AlchList:SetSize( 150,150 )
		AlchList:SetPos( 0, 195 )
		AlchList:SetSpaceX( 3 )
		AlchList:SetSpaceY( 3 )
		
		
		/*
			
		local AlchList = vgui.Create( "DPanelList", SGS.farminggroup)
		AlchList:SetSize( 130,210 )
		AlchList:SetPos( 0, 200 )
		AlchList:EnableVerticalScrollbar( true )
		AlchList:EnableHorizontal( false )
		AlchList:SetPadding( 4 )
		AlchList:AddItem( AlchLabel )
		*/
		
		for _, v in pairs( SGS.Seeds[ "fruit" ] ) do
			if SGS.resources[v.resource] then
				if SGS.resources[v.resource] >= 1 then
					local FruitButton = vgui.Create( "DImageButton", FarmList)
					FruitButton:SetMaterial( v.icon )
					FruitButton:SetToolTip( v.title .. "\nFarming Level: " .. tostring(v.reqlvl["farming"]) )
					FruitButton:SetSize( 32, 32 )
					FruitButton.DoClick = function( FruitButton )
						RunConsoleCommand("sgs_plant", v.resource)
					end
					FarmList:Add( FruitButton )
					FruitButton.PaintOver = function()
						local seedcount = SGS.resources[v.resource] or 0
						draw.SimpleText(seedcount, "farmingoverlayicons", 2, 2, Color(255, 0, 0, 255), 0, 0)
					end
				end
			end
		end
		
		
		for _, v in pairs( SGS.Seeds[ "trees" ] ) do
			if SGS.resources[v.resource] then
				if SGS.resources[v.resource] >= 1 then
					local TreeButton = vgui.Create( "DImageButton", TreeList)
					TreeButton:SetSize( 32, 32 )
					TreeButton:SetMaterial( v.icon )
					TreeButton:SetToolTip( v.title .. "\nFarming Level: " .. tostring(v.reqlvl["farming"]) )
					TreeButton.DoClick = function( TreeButton )
						RunConsoleCommand("sgs_planttree", v.resource)
					end
					TreeList:Add( TreeButton )
					TreeButton.PaintOver = function()
						local seedcount = SGS.resources[v.resource] or 0
						draw.SimpleText(seedcount, "farmingoverlayicons", 2, 2, Color(255, 0, 0, 255), 0, 0)
					end
				end
			end
		end
		
		
		
		for _, v in pairs( SGS.Seeds[ "food" ] ) do
			if SGS.resources[v.resource] then
				if SGS.resources[v.resource] >= 1 then
					local FoodButton = vgui.Create( "DImageButton", FoodList)
					FoodButton:SetSize( 32, 32 )
					FoodButton:SetMaterial( v.icon )
					FoodButton:SetToolTip( v.title .. "\nFarming Level: " .. tostring(v.reqlvl["farming"]) )
					FoodButton.DoClick = function( FoodButton )
						RunConsoleCommand("sgs_plantfood", v.resource)
					end
					FoodList:Add( FoodButton )
					FoodButton.PaintOver = function()
						local seedcount = SGS.resources[v.resource] or 0
						draw.SimpleText(seedcount, "farmingoverlayicons", 2, 2, Color(255, 0, 0, 255), 0, 0)
					end					
				end
			end
		end
		

		for _, v in pairs( SGS.Seeds[ "alchemy" ] ) do
			if SGS.resources[v.resource] then
				if SGS.resources[v.resource] >= 1 then
					local AlchButton = vgui.Create( "DImageButton", AlchList)
					AlchButton:SetSize( 32, 32 )
					AlchButton:SetMaterial( v.icon )
					AlchButton:SetToolTip( v.title .. "\nFarming Level: " .. tostring(v.reqlvl["farming"]) )
					AlchButton.DoClick = function( AlchButton )
						RunConsoleCommand("sgs_plantfood", v.resource)
					end
					AlchList:Add( AlchButton )
					AlchButton.PaintOver = function()
						local seedcount = SGS.resources[v.resource] or 0
						draw.SimpleText(seedcount, "farmingoverlayicons", 2, 2, Color(255, 0, 0, 255), 0, 0)
					end	
				end
			end
		end
		
		local hbLabel = vgui.Create("DLabel", SGS.farminggroup)
		hbLabel:SetPos(0,478) // Position
		hbLabel:SetColor(Color(255,0,255,255)) // Color
		hbLabel:SetFont("SGS_RCacheMenuText")
		hbLabel:SetText("Total Plants: " .. SGS.plantcount .. " / " .. SGS.maxplants) // Text
		hbLabel:SizeToContents()

	end
	DrawSeeds()
	concommand.Add( "sgs_refreshfarming", DrawSeeds )
end
vgui.Register("sgs_farmmenu", PANEL, "Panel")


/*-------------------------------
-------------Spells--------------
-------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0, 0)
    self:SetSize(600, 510)
    self:SetVisible(false)
	
	self:DrawFrame()
	
	
end

function PANEL:DrawFrame()
	function DrawSpells()
		if SGS.spellsgroup then SGS.spellsgroup:Remove() end
		
		SGS.spellsgroup = vgui.Create("DPanel", self)
		SGS.spellsgroup:SetPos(0,0)
		SGS.spellsgroup:SetSize(600, 510)
		SGS.spellsgroup:SetPaintBackground( false )
		
		
		
		local FruitLabel = vgui.Create("DLabel", SGS.spellsgroup)
		FruitLabel:SetColor(Color(255,255,255,255)) // Color
		FruitLabel:SetFont("SGS_HUD2")
		FruitLabel:SetPos( 0, 7 )
		FruitLabel:SetText("Arcane Spells") // Text
		FruitLabel:SizeToContents() // make the control the same size as the text.
		
		local SpellList = vgui.Create( "DIconLayout", SGS.spellsgroup)
		SpellList:SetSize( 600,150 )
		SpellList:SetPos( 0, 25 )
		SpellList:SetSpaceX( 3 )
		SpellList:SetSpaceY( 3 )
		
				
		for _, v in pairs( SGS.SpellList ) do
			if SGS.levels["arcane"] < v.reqlvl then continue end
			
			if v.tribelevel then
				if GAMEMODE.Tribes:GetTribeLevel( LocalPlayer() ) < v.tribelevel then
					continue
				end
			end
			local SpellButton = vgui.Create( "DImageButton", SpellList)
			SpellButton:SetMaterial( v.material )
			SpellButton:SetToolTip( SGS_SpellToolTip(v) )
			SpellButton:SetSize( 48, 48 )
			SpellButton.PaintOver = function()
				for k3, v3 in pairs( v.cost ) do
					local pamt = SGS.resources[ k3 ] or 0
					if pamt < v3 then
						draw.RoundedBoxEx( 2, 2, 14, 44, 20, Color(255, 50, 50, 150), false, false, false, false )
						draw.SimpleText("NO STONES", "proplisticons", 5, 20, Color(255, 255, 255, 255), 0, 0)
						SpellButton.OnCursorEntered = function()
							return true
						end
						break
					end
				end
			end
			SpellButton.DoClick = function( SpellButton )
				RunConsoleCommand( "sgs_cast", v.spell )
			end
			SpellButton.DoRightClick = function( SpellButton )
				local DropDown = DermaMenu()
					DropDown:AddOption("Assign to HotKey 1", function() SGS_AssignHotBarSpell( 1, v.spell, true ) end )
					DropDown:AddOption("Assign to HotKey 2", function() SGS_AssignHotBarSpell( 2, v.spell, true ) end )
					DropDown:AddOption("Assign to HotKey 3", function() SGS_AssignHotBarSpell( 3, v.spell, true ) end )
					DropDown:AddOption("Assign to HotKey 4", function() SGS_AssignHotBarSpell( 4, v.spell, true ) end )
					if LocalPlayer():IsMember() then
						DropDown:AddOption("Assign to HotKey 5", function() SGS_AssignHotBarSpell( 5, v.spell, true ) end )
						DropDown:AddOption("Assign to HotKey 6", function() SGS_AssignHotBarSpell( 6, v.spell, true ) end )
						if LocalPlayer():IsDonator() then
							DropDown:AddOption("Assign to HotKey 7", function() SGS_AssignHotBarSpell( 7, v.spell, true ) end )
							DropDown:AddOption("Assign to HotKey 8", function() SGS_AssignHotBarSpell( 8, v.spell, true ) end )
							DropDown:AddOption("Assign to HotKey 9", function() SGS_AssignHotBarSpell( 9, v.spell, true ) end )
							DropDown:AddOption("Assign to HotKey 0", function() SGS_AssignHotBarSpell( 10, v.spell, true ) end )
						end
					end
				DropDown:Open()
			end
			
			SpellList:Add( SpellButton )
		end

	end
	DrawSpells()
	concommand.Add( "sgs_refreshspells", DrawSpells )
end
vgui.Register("sgs_spellmenu", PANEL, "Panel")



/*--------------------------------
-------------Options--------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0, 0)
    self:SetSize(470, 510)
    self:SetVisible(false)
	
	self:DrawFrame()
	
	
end

function PANEL:DrawFrame()
	function DrawItems()
	
		if SGS.optionsgroup then SGS.optionsgroup:Remove() end
		
		SGS.optionsgroup = vgui.Create("DPanel", self)
		SGS.optionsgroup:SetPos(0,0)
		SGS.optionsgroup:SetSize(470, 510)
		SGS.optionsgroup:SetPaintBackground( false )
		
		local OptionsLabel = vgui.Create("DLabel")
		OptionsLabel:SetColor(Color(255,255,255,255)) // Color
		OptionsLabel:SetFont("SGS_FarmText")
		OptionsLabel:SetText("Game Options") // Text
		OptionsLabel:SizeToContents() // make the control the same size as the text.
		
		local HatsLabel = vgui.Create("DLabel")
		HatsLabel:SetColor(Color(255,255,255,255)) // Color
		HatsLabel:SetFont("SGS_FarmText")
		HatsLabel:SetText("Hats") // Text
		HatsLabel:SizeToContents() // make the control the same size as the text.
		
		local PetsLabel = vgui.Create("DLabel")
		PetsLabel:SetColor(Color(255,255,255,255)) // Color
		PetsLabel:SetFont("SGS_FarmText")
		PetsLabel:SetText("Pets") // Text
		PetsLabel:SizeToContents() // make the control the same size as the text.
		
		local SpecialLabel = vgui.Create("DLabel")
		SpecialLabel:SetColor(Color(255,255,255,255)) // Color
		SpecialLabel:SetFont("SGS_FarmText")
		SpecialLabel:SetText("Special Options") // Text
		SpecialLabel:SizeToContents() // make the control the same size as the text.
		
		local TogglesLabel = vgui.Create("DLabel")
		TogglesLabel:SetColor(Color(255,255,255,255)) // Color
		TogglesLabel:SetFont("SGS_FarmText")
		TogglesLabel:SetText("Toggles") // Text
		TogglesLabel:SizeToContents() // make the control the same size as the text.
		
		local ClientLabel = vgui.Create("DLabel")
		ClientLabel:SetColor(Color(255,255,255,255)) // Color
		ClientLabel:SetFont("SGS_FarmText")
		ClientLabel:SetText("Client Options") // Text
		ClientLabel:SizeToContents() // make the control the same size as the text.
		
		local OptionsList = vgui.Create( "DPanelList", SGS.optionsgroup)
		OptionsList:SetSize( 130,190 )
		OptionsList:SetPos( 0, 25 )
		OptionsList:EnableVerticalScrollbar( true )
		OptionsList:EnableHorizontal( false )
		OptionsList:SetPadding( 4 )
		OptionsList:AddItem( OptionsLabel )
		
		local HatsList = vgui.Create( "DPanelList", SGS.optionsgroup)
		HatsList:SetSize( 130,190 )
		HatsList:SetPos( 150, 25 )
		HatsList:EnableVerticalScrollbar( true )
		HatsList:EnableHorizontal( false )
		HatsList:SetPadding( 4 )
		HatsList:AddItem( HatsLabel )
		
		local TogglesList = vgui.Create( "DPanelList", SGS.optionsgroup)
		TogglesList:SetSize( 130,190 )
		TogglesList:SetPos( 300, 25 )
		TogglesList:EnableVerticalScrollbar( true )
		TogglesList:EnableHorizontal( false )
		TogglesList:SetPadding( 4 )
		TogglesList:AddItem( TogglesLabel )
		
		local PetsList = vgui.Create( "DPanelList", SGS.optionsgroup)
		PetsList:SetSize( 130,260 )
		PetsList:SetPos( 0, 240 )
		PetsList:EnableVerticalScrollbar( true )
		PetsList:EnableHorizontal( false )
		PetsList:SetPadding( 4 )
		PetsList:AddItem( PetsLabel )
		
		local SpecialList = vgui.Create( "DPanelList", SGS.optionsgroup)
		SpecialList:SetSize( 130,260 )
		SpecialList:SetPos( 150, 240 )
		SpecialList:EnableVerticalScrollbar( true )
		SpecialList:EnableHorizontal( false )
		SpecialList:SetPadding( 4 )
		SpecialList:AddItem( SpecialLabel )
		
		local ClientList = vgui.Create( "DPanelList", SGS.optionsgroup)
		ClientList:SetSize( 130,260 )
		ClientList:SetPos( 300, 240 )
		ClientList:EnableVerticalScrollbar( true )
		ClientList:EnableHorizontal( false )
		ClientList:SetPadding( 4 )
		ClientList:AddItem( ClientLabel )
		
	
		for _, v in pairs( SGS.Commands[ "game" ] ) do
			local OptionButton = vgui.Create( "DButton", OptionsList)
			OptionButton:SetText( v.title )
			OptionButton:SetSize( 120, 20 )
			OptionButton:SetToolTip( SGS_ToolTipShort(v) )
			OptionButton.DoClick = function( OptionButton )
				RunConsoleCommand( unpack(v.command) )
			end
			OptionsList:AddItem( OptionButton )
		end
		
		for _, v in pairs( SGS.Commands[ "hats" ] ) do
			if SGS_GetAch(v.achreq) then
				local HatsButton = vgui.Create( "DButton", HatsList)
				HatsButton:SetText( v.title )
				HatsButton:SetSize( 120, 20 )
				HatsButton:SetToolTip( SGS_ToolTipShort(v) )
				HatsButton.DoClick = function( HatsButton )
					RunConsoleCommand( unpack(v.command) )
				end
				HatsList:AddItem( HatsButton )
			end
		end
		
		for _, v in pairs( SGS.Commands[ "pets" ] ) do
			local PetsButton = vgui.Create( "DButton", PetsList)
			PetsButton:SetText( v.title )
			PetsButton:SetSize( 120, 20 )
			PetsButton:SetToolTip( SGS_ToolTipShort(v) )
			PetsButton.DoClick = function( PetsButton )
				RunConsoleCommand( unpack(v.command) )
			end
			PetsList:AddItem( PetsButton )
		end
		
		for _, v in pairs( SGS.Commands[ "special" ] ) do
			if v.skillreq == nil or SGS.levels[v.skillreq] == SGS.maxlevel then
				local SpecialButton = vgui.Create( "DButton", SpecialList)
				SpecialButton:SetText( v.title )
				SpecialButton:SetSize( 120, 20 )
				SpecialButton:SetToolTip( SGS_ToolTipShort(v) )
				SpecialButton.DoClick = function( SpecialButton )
					RunConsoleCommand( unpack(v.command) )
				end
				SpecialList:AddItem( SpecialButton )
			end
		end
		
		for _, v in pairs( SGS.Commands[ "toggles" ] ) do
			local ToggleButton = vgui.Create( "DButton", TogglesList)
			ToggleButton:SetText( v.title )
			ToggleButton:SetSize( 120, 20 )
			ToggleButton:SetToolTip( SGS_ToolTipShort(v) )
			ToggleButton.DoClick = function( ToggleButton )
				if v.command[1] == "sgs_togglepvp" then
					if LocalPlayer():GetNWBool("inpvp", false) == true then
						RunConsoleCommand( unpack(v.command) )
					else
						SGS_ConfirmPvPDialogue()
					end
				else
					RunConsoleCommand( unpack(v.command) )
				end
			end
			TogglesList:AddItem( ToggleButton )
		end
		
		for _, v in pairs( SGS.Commands[ "client" ] ) do
			local ClientButton = vgui.Create( "DButton", ClientList)
			ClientButton:SetText( v.title )
			ClientButton:SetSize( 120, 20 )
			ClientButton:SetToolTip( SGS_ToolTipShort(v) )
			ClientButton.DoClick = function( ClientButton )
				RunConsoleCommand( unpack(v.command) )
			end
			ClientList:AddItem( ClientButton )
		end
	end
	DrawItems()
	concommand.Add( "sgs_refreshoptions", DrawItems )
	

		
		
end
vgui.Register("sgs_optionsmenu", PANEL, "Panel")

function SGS_ConfirmPvPDialogue()

	ConfirmPvP = vgui.Create( "DFrame" )
	ConfirmPvP:ShowCloseButton(true)
	ConfirmPvP:SetDraggable(false)
	ConfirmPvP:SetSize( 250, 70 )
	ConfirmPvP:SetTitle( "Confirm PvP Action" )
	ConfirmPvP:SetPos( ScrW() / 2 - 125, ScrH() / 2 - 35 )
	ConfirmPvP:MakePopup()
	
	local InvLabel = vgui.Create("DLabel", ConfirmPvP)
	InvLabel:SetPos(10,25) // Position
	InvLabel:SetColor(Color(255,0,80,255)) // Color
	InvLabel:SetFont("SGS_RCacheMenuText")
	InvLabel:SetText("Are you sure you wish to toggle PvP?") // Text
	InvLabel:SizeToContents()
	
	local InvLabel = vgui.Create("DLabel", ConfirmPvP)
	InvLabel:SetPos(10,35) // Position
	InvLabel:SetColor(Color(255,0,80,255)) // Color
	InvLabel:SetFont("SGS_RCacheMenuText")
	InvLabel:SetText("Other players will be able to kill you.") // Text
	InvLabel:SizeToContents()
	
	local button = vgui.Create( "DButton", ConfirmPvP )
	button:SetSize( 30, 15 )
	button:SetPos( 10, 50 )
	button:SetText( "No" )
	button.DoClick = function( button )
		ConfirmPvP:SetVisible(false)
	end
	
	local button3 = vgui.Create( "DButton", ConfirmPvP )
	button3:SetSize( 30, 15 )
	button3:SetPos( 50, 50 )
	button3:SetText( "Yes" )
	button3.DoClick = function( button3 )
		RunConsoleCommand("sgs_togglepvp")
		ConfirmPvP:SetVisible(false)
	end
	
	ConfirmPvP:SetVisible(true)
end




/*--------------------------------
--------------Tools---------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0, 0)
    self:SetSize(600, 510)
    self:SetVisible(false)
	
	self:DrawFrame()
	
	
end

function PANEL:DrawFrame()
	function DrawItems()
	
		if SGS.toolsgroup then SGS.toolsgroup:Remove() end
		
		SGS.toolsgroup = vgui.Create("DPanel", self)
		SGS.toolsgroup:SetPos(0,0)
		SGS.toolsgroup:SetSize(600, 510)
		SGS.toolsgroup:SetPaintBackground( false )

		local ToolContainer = vgui.Create( "DIconLayout", SGS.toolsgroup)
		ToolContainer:SetSize( 600, 440 )
		ToolContainer:SetPos( 0, 0 )
		ToolContainer:SetSpaceY( 4 )
		ToolContainer:SetSpaceX( 4 )
		
		for k, v in SortedPairs( SGS_ReturnSortedTable( SGS.Tools ) ) do
			
			for k2, v2 in pairs( SGS.Tools[k] ) do
		
				if SGS_CheckTool( v2.entity ) then

					local icon = vgui.Create( "DImageButton", ToolContainer)
					icon:SetMaterial( v2.icon )
					icon:SetSize( 64, 64 )
					icon:SetToolTip( SGS_ToolTipShort(v2) )
					icon.PaintOver = function()
						local tool_count = SGS_CountTools( v2.entity )
						draw.SimpleText(tool_count, "SGS_HUD2", 50, 50, Color(255, 255, 255, 255), 0, 0)
					end
					
					ToolContainer:Add( icon )
					icon.DoClick = function( icon ) 
						surface.PlaySound( "ui/buttonclickrelease.wav" ) 
						RunConsoleCommand("SGS_EquipTools", v2.entity) 
					end
					
					icon.DoRightClick = function( icon )
						local DropDown = DermaMenu()
							DropDown:AddOption("Assign to HotKey 1", function() SGS_AssignHotBar( 1, v2.entity, true ) end )
							DropDown:AddOption("Assign to HotKey 2", function() SGS_AssignHotBar( 2, v2.entity, true ) end )
							DropDown:AddOption("Assign to HotKey 3", function() SGS_AssignHotBar( 3, v2.entity, true ) end )
							DropDown:AddOption("Assign to HotKey 4", function() SGS_AssignHotBar( 4, v2.entity, true ) end )
							if LocalPlayer():IsMember() then
								DropDown:AddOption("Assign to HotKey 5", function() SGS_AssignHotBar( 5, v2.entity, true ) end )
								DropDown:AddOption("Assign to HotKey 6", function() SGS_AssignHotBar( 6, v2.entity, true ) end )
								if LocalPlayer():IsDonator() then
									DropDown:AddOption("Assign to HotKey 7", function() SGS_AssignHotBar( 7, v2.entity, true ) end )
									DropDown:AddOption("Assign to HotKey 8", function() SGS_AssignHotBar( 8, v2.entity, true ) end )
									DropDown:AddOption("Assign to HotKey 9", function() SGS_AssignHotBar( 9, v2.entity, true ) end )
									DropDown:AddOption("Assign to HotKey 0", function() SGS_AssignHotBar( 10, v2.entity, true ) end )
								end
							end
						DropDown:Open()
					end					
					
				end
				
			end
			
		end
		
		local button = vgui.Create( "DButton", SGS.toolsgroup )
		button:SetSize( 50, 20 )
		button:SetPos( 0, 450 )
		button:SetText( "UNEQUIP" )
		button.DoClick = function( button )
			RunConsoleCommand("SGS_UnEquipTool")
		end
		
		local button = vgui.Create( "DButton", SGS.toolsgroup )
		button:SetSize( 50, 20 )
		button:SetPos( 55, 450 )
		button:SetText( "DROP" )
		button.DoClick = function( button )
			RunConsoleCommand("SGS_DropTool")
		end
		
		local hbLabel = vgui.Create("DLabel", SGS.toolsgroup)
		hbLabel:SetPos(0,478) // Position
		hbLabel:SetColor(Color(0,80,255,255)) // Color
		hbLabel:SetFont("SGS_RCacheMenuText")
		hbLabel:SetText("Right click on a food or potion to add it to your hotbar.") // Text
		hbLabel:SizeToContents()
		
	end
	DrawItems()
	concommand.Add( "sgs_refreshtools", DrawItems )
end
vgui.Register("sgs_toolsmenu", PANEL, "Panel")


/*--------------------------------
------------Resources-------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0, 0)
    self:SetSize(600, 510)
    self:SetVisible(false)
	
	self:DrawFrame()
	
	
end

function PANEL:DrawFrame()

	function DrawResources()
		if SGS.resourcesgroup then SGS.resourcesgroup:Remove() end
		
		SGS.resourcesgroup = vgui.Create("DPanel", self)
		SGS.resourcesgroup:SetPos(0,0)
		SGS.resourcesgroup:SetSize(600, 510)
		SGS.resourcesgroup:SetPaintBackground( false )
		
		
		local curinv = 0
		for k, v in pairs(SGS.resources) do
			curinv = curinv + tonumber(v)
		end
		SGS.curinv = curinv
		
		local InvLabel = vgui.Create("DLabel", SGS.resourcesgroup)
		InvLabel:SetPos(0,450) // Position
		InvLabel:SetColor(Color(255,0,80,255)) // Color
		InvLabel:SetFont("SGS_RCacheMenuText")
		InvLabel:SetText("Inventory: " .. tostring( SGS.curinv ) .. " / " .. tostring( SGS.maxinv ) ) // Text
		InvLabel:SizeToContents()
		
		local gtLabel = vgui.Create("DLabel", SGS.resourcesgroup)
		gtLabel:SetPos(0,465) // Position
		gtLabel:SetColor(Color(255,0,255,255)) // Color
		gtLabel:SetFont("SGS_RCacheMenuText")
		gtLabel:SetText("GTokens: " .. tostring( SGS.gtokens )) // Text
		gtLabel:SizeToContents()
		
		local hbLabel = vgui.Create("DLabel", SGS.resourcesgroup)
		hbLabel:SetPos(0,478) // Position
		hbLabel:SetColor(Color(0,80,255,255)) // Color
		hbLabel:SetFont("SGS_RCacheMenuText")
		hbLabel:SetText("Right click on a food or potion to add it to your hotbar.") // Text
		hbLabel:SizeToContents()
		
		local RCacheLabel = vgui.Create("DLabel")
		RCacheLabel:SetColor(Color(255,255,255,255)) // Color
		RCacheLabel:SetFont("SGS_RCacheMenuText")
		RCacheLabel:SetText("Raw Materials") // Text
		RCacheLabel:SizeToContents()
		
		local RCacheLabel2 = vgui.Create("DLabel")
		RCacheLabel2:SetColor(Color(255,255,255,255)) // Color
		RCacheLabel2:SetFont("SGS_RCacheMenuText")
		RCacheLabel2:SetText("Consumable") // Text
		RCacheLabel2:SizeToContents()
		
		local RCacheLabel3 = vgui.Create("DLabel")
		RCacheLabel3:SetColor(Color(255,255,255,255)) // Color
		RCacheLabel3:SetFont("SGS_RCacheMenuText")
		RCacheLabel3:SetText("Seeds/Farming") // Text
		RCacheLabel3:SizeToContents()
		
		local RCacheLabel4 = vgui.Create("DLabel")
		RCacheLabel4:SetColor(Color(255,255,255,255)) // Color
		RCacheLabel4:SetFont("SGS_RCacheMenuText")
		RCacheLabel4:SetText("Potions/Consumables") // Text
		RCacheLabel4:SizeToContents()
		
		local RCacheLabel5 = vgui.Create("DLabel")
		RCacheLabel5:SetColor(Color(255,255,255,255)) // Color
		RCacheLabel5:SetFont("SGS_RCacheMenuText")
		RCacheLabel5:SetText("Packaged Structures") // Text
		RCacheLabel5:SizeToContents()
		
		
		
		--OTHERS--
		ResList = vgui.Create( "DPanelList", SGS.resourcesgroup)
		ResList:SetSize( 160,400 )
		ResList:SetPos( 0, 25 )
		ResList:EnableVerticalScrollbar( true )
		ResList:EnableHorizontal( true )
		ResList:SetPadding( 4 )
		ResList:AddItem( RCacheLabel )
		
		--Edible--
		ResList2 = vgui.Create( "DPanelList", SGS.resourcesgroup)
		ResList2:SetSize( 160,210 )
		ResList2:SetPos( 160, 25 )
		ResList2:EnableVerticalScrollbar( true )
		ResList2:EnableHorizontal( true )
		ResList2:SetPadding( 4 )
		ResList2:AddItem( RCacheLabel2 )
		
		--Seeds--
		ResList3 = vgui.Create( "DPanelList", SGS.resourcesgroup)
		ResList3:SetSize( 160,210 )
		ResList3:SetPos( 320, 25 )
		ResList3:EnableVerticalScrollbar( true )
		ResList3:EnableHorizontal( true )
		ResList3:SetPadding( 4 )
		ResList3:AddItem( RCacheLabel3 )
		
		--Packaged Structures--
		ResList5 = vgui.Create( "DPanelList", SGS.resourcesgroup)
		ResList5:SetSize( 160,210 )
		ResList5:SetPos( 160, 240 )
		ResList5:EnableVerticalScrollbar( true )
		ResList5:EnableHorizontal( true )
		ResList5:SetPadding( 4 )
		ResList5:AddItem( RCacheLabel5 )
		
		--Potions--
		ResList4 = vgui.Create( "DPanelList", SGS.resourcesgroup)
		ResList4:SetSize( 160,210 )
		ResList4:SetPos( 320, 240 )
		ResList4:EnableVerticalScrollbar( true )
		ResList4:EnableHorizontal( true )
		ResList4:SetPadding( 4 )
		ResList4:AddItem( RCacheLabel4 )
		
		for k, v in SortedPairs( SGS.resources ) do
			if tonumber(v) > 0 then
				local reslbl = vgui.Create("DButton")
				reslbl:SetText( CapAll(string.gsub(k, "_", " ")) .. ": " .. v )
				reslbl:SetSize( 150, 20 )

				local endsearch = false
				for k2, v2 in pairs( SGS.menuedible ) do
					if v2 == k then
						ResList2:AddItem( reslbl )
						reslbl.DoClick = function( reslbl )
							SGS.dropmenu = k
							SGS.dropval = "1"
							SGS.dropvalmax = v
							SGS_DropResourceMenu()
						end
						reslbl.DoRightClick = function( reslbl )
							local DropDown = DermaMenu()
								DropDown:AddOption("Drop All (Owned)", function() RunConsoleCommand("sgs_dropresource", k, v) end )
								DropDown:AddOption("Drop All (Unowned)", function() RunConsoleCommand("sgs_dropresource2", k, v) end )
								DropDown:AddOption("Delete All", function() SGS_ConfirmDestroy( k, v ) end )
								DropDown:AddOption("Assign to HotKey 1", function() SGS_AssignHotBarConsumable( 1, k, true ) end )
								DropDown:AddOption("Assign to HotKey 2", function() SGS_AssignHotBarConsumable( 2, k, true ) end )
								DropDown:AddOption("Assign to HotKey 3", function() SGS_AssignHotBarConsumable( 3, k, true ) end )
								DropDown:AddOption("Assign to HotKey 4", function() SGS_AssignHotBarConsumable( 4, k, true ) end )
								if LocalPlayer():IsMember() then
									DropDown:AddOption("Assign to HotKey 5", function() SGS_AssignHotBarConsumable( 5, k, true ) end )
									DropDown:AddOption("Assign to HotKey 6", function() SGS_AssignHotBarConsumable( 6, k, true ) end )
									if LocalPlayer():IsDonator() then
										DropDown:AddOption("Assign to HotKey 7", function() SGS_AssignHotBarConsumable( 7, k, true ) end )
										DropDown:AddOption("Assign to HotKey 8", function() SGS_AssignHotBarConsumable( 8, k, true ) end )
										DropDown:AddOption("Assign to HotKey 9", function() SGS_AssignHotBarConsumable( 9, k, true ) end )
										DropDown:AddOption("Assign to HotKey 0", function() SGS_AssignHotBarConsumable( 10, k, true ) end )
									end
								end
							DropDown:Open()
						end
						endsearch = true
						break
					end
				end
				
				for k2, v2 in pairs( SGS.menuseeds ) do
					if v2 == k then
						ResList3:AddItem( reslbl )
						reslbl.DoClick = function( reslbl )
							SGS.dropmenu = k
							SGS.dropval = v
							SGS.dropvalmax = v
							SGS_DropResourceMenu()
						end
						reslbl.DoRightClick = function( reslbl )
							local DropDown = DermaMenu()
								DropDown:AddOption("Drop All (Owned)", function() RunConsoleCommand("sgs_dropresource", k, v) end )
								DropDown:AddOption("Drop All (Unowned)", function() RunConsoleCommand("sgs_dropresource2", k, v) end )
								DropDown:AddOption("Delete All", function() SGS_ConfirmDestroy( k, v ) end )
							DropDown:Open()
						end
						endsearch = true
						break
					end
				end
				
				for k2, v2 in pairs( SGS.menupotions ) do
					if v2 == k then
						ResList4:AddItem( reslbl )
						reslbl.DoClick = function( reslbl )
							SGS.dropmenu = k
							SGS.dropval = "1"
							SGS.dropvalmax = v
							SGS_DropResourceMenu()
						end
						reslbl.DoRightClick = function( reslbl )
							local DropDown = DermaMenu()
								DropDown:AddOption("Drop All (Owned)", function() RunConsoleCommand("sgs_dropresource", k, v) end )
								DropDown:AddOption("Drop All (Unowned)", function() RunConsoleCommand("sgs_dropresource2", k, v) end )
								DropDown:AddOption("Delete All", function() SGS_ConfirmDestroy( k, v ) end )
								DropDown:AddOption("Assign to HotKey 1", function() SGS_AssignHotBarConsumable( 1, k, true ) end )
								DropDown:AddOption("Assign to HotKey 2", function() SGS_AssignHotBarConsumable( 2, k, true ) end )
								DropDown:AddOption("Assign to HotKey 3", function() SGS_AssignHotBarConsumable( 3, k, true ) end )
								DropDown:AddOption("Assign to HotKey 4", function() SGS_AssignHotBarConsumable( 4, k, true ) end )
								if LocalPlayer():IsMember() then
									DropDown:AddOption("Assign to HotKey 5", function() SGS_AssignHotBarConsumable( 5, k, true ) end )
									DropDown:AddOption("Assign to HotKey 6", function() SGS_AssignHotBarConsumable( 6, k, true ) end )
									if LocalPlayer():IsDonator() then
										DropDown:AddOption("Assign to HotKey 7", function() SGS_AssignHotBarConsumable( 7, k, true ) end )
										DropDown:AddOption("Assign to HotKey 8", function() SGS_AssignHotBarConsumable( 8, k, true ) end )
										DropDown:AddOption("Assign to HotKey 9", function() SGS_AssignHotBarConsumable( 9, k, true ) end )
										DropDown:AddOption("Assign to HotKey 0", function() SGS_AssignHotBarConsumable( 10, k, true ) end )
									end
								end
							DropDown:Open()
						end
						endsearch = true
						break
					end
				end
				
				for k2, v2 in pairs( SGS.AllowedPackage ) do
					if v2 == k then
						ResList5:AddItem( reslbl )
						reslbl.DoClick = function( reslbl )
							SGS.dropmenu = k
							SGS.dropval = "1"
							SGS.dropvalmax = v
							SGS_DropResourceMenu()
						end
						reslbl.DoRightClick = function( reslbl )
							local DropDown = DermaMenu()
								DropDown:AddOption("Drop All (Owned)", function() RunConsoleCommand("sgs_dropresource", k, v) end )
								DropDown:AddOption("Drop All (Unowned)", function() RunConsoleCommand("sgs_dropresource2", k, v) end )
								DropDown:AddOption("Delete All", function() SGS_ConfirmDestroy( k, v ) end )
							DropDown:Open()
						end
						endsearch = true
						break
					end
				end
					
				if endsearch == false then
					ResList:AddItem( reslbl )
					reslbl.DoClick = function( reslbl )
						SGS.dropmenu = k
						SGS.dropval = v
						SGS.dropvalmax = v
						SGS_DropResourceMenu()
					end
					reslbl.DoRightClick = function( reslbl )
						local DropDown = DermaMenu()
							DropDown:AddOption("Drop All (Owned)", function() RunConsoleCommand("sgs_dropresource", k, v) end )
							DropDown:AddOption("Drop All (Unowned)", function() RunConsoleCommand("sgs_dropresource2", k, v) end )
							DropDown:AddOption("Delete All", function() SGS_ConfirmDestroy( k, v ) end )
						DropDown:Open()
					end
				end
			end
		end
	end
	DrawResources()
	concommand.Add( "sgs_refreshresources", DrawResources )
end
vgui.Register("sgs_resourcemenu", PANEL, "Panel")

function SGS_DropResourceMenu()

	if ValidPanel( DropResourceMenu ) then DropResourceMenu:Close() end
	
	DropResourceMenu = vgui.Create( "DFrame" )
	DropResourceMenu:ShowCloseButton(true)
	DropResourceMenu:SetDeleteOnClose( true )
	DropResourceMenu:SetDraggable( true )
	DropResourceMenu:SetSize( 195, 130 )
	DropResourceMenu:SetTitle( "Item Action" )
	DropResourceMenu:SetPos( ScrW() / 2 - 75, ScrH() / 2 - 75 )
	DropResourceMenu:MakePopup()
	
	local resText = vgui.Create("DTextEntry", DropResourceMenu)
	resText:SetText(SGS.dropmenu)
	resText:SetSize( 185, 20 )
	resText:SetPos( 5, 30 )
	resText:SetEditable( false )
	
	local amtText = vgui.Create("DTextEntry", DropResourceMenu)
	amtText:SetText(SGS.dropval)
	amtText:SetSize( 185, 20 )
	amtText:SetPos( 5, 55 )
	amtText:SetEditable( true )
	
	local button = vgui.Create( "DButton", DropResourceMenu )
	button:SetSize( 90, 20 )
	button:SetPos( 5, 80 )
	button:SetText( "Drop (Owned)" )
	button.DoClick = function( button )
		RunConsoleCommand("sgs_dropresource", resText:GetValue(), amtText:GetValue())
		DropResourceMenu:Close()
	end
	
	local button5 = vgui.Create( "DButton", DropResourceMenu )
	button5:SetSize( 90, 20 )
	button5:SetPos( 100, 80 )
	button5:SetText( "Drop (UnOwned)" )
	button5.DoClick = function( button5 )
		RunConsoleCommand("sgs_dropresource2", resText:GetValue(), amtText:GetValue())
		DropResourceMenu:Close()
	end
	
	local button3 = vgui.Create( "DButton", DropResourceMenu )
	button3:SetSize( 90, 20 )
	button3:SetPos( 5, 105 )
	button3:SetText( "Destroy" )
	button3.DoClick = function( button3 )
		--RunConsoleCommand("sgs_destroyresource", resText:GetValue(), amtText:GetValue())
		SGS_ConfirmDestroy( resText:GetValue(), amtText:GetValue() )
		DropResourceMenu:Close()
	end
	
	local button4 = vgui.Create( "DButton", DropResourceMenu )
	button4:SetSize( 90, 20 )
	button4:SetPos( 100, 105 )
	button4:SetText( "Set All" )
	button4.DoClick = function( button4 )
		amtText:SetText(SGS.dropvalmax)
	end
	
	
	for k, v in pairs(SGS.menuedible) do
		if v == SGS.dropmenu then
			DropResourceMenu:SetSize( 195, 155 )
			local button2 = vgui.Create( "DButton", DropResourceMenu )
			button2:SetSize( 90, 20 )
			button2:SetPos( 5, 130 )
			button2:SetText( "Consume" )
			button2.DoClick = function( button2 )
				RunConsoleCommand("sgs_eat", resText:GetValue())
				DropResourceMenu:Close()
			end
			break
		end
	end
	
	for k, v in pairs(SGS.menupotions) do
		if v == SGS.dropmenu then
			DropResourceMenu:SetSize( 195, 155 )
			local button2 = vgui.Create( "DButton", DropResourceMenu )
			button2:SetSize( 90, 20 )
			button2:SetPos( 5, 130 )
			button2:SetText( "Use" )
			button2.DoClick = function( button2 )
				RunConsoleCommand("sgs_pdrink", resText:GetValue())
				DropResourceMenu:Close()
			end
			break
		end
	end
	
	for k, v in pairs(SGS.AllowedPackage) do
		if v == SGS.dropmenu then
			DropResourceMenu:SetSize( 195, 155 )
			local button2 = vgui.Create( "DButton", DropResourceMenu )
			button2:SetSize( 90, 20 )
			button2:SetPos( 5, 130 )
			button2:SetText( "Unpack" )
			button2.DoClick = function( button2 )
				RunConsoleCommand("sgs_unpack", resText:GetValue())
				DropResourceMenu:Close()
			end
			break
		end
	end
	
	DropResourceMenu:SetVisible(true)
end

function SGS_ConfirmDestroy( res, amt )

	if ValidPanel( ConfirmDestory ) then ConfirmDestory:Close() end

	ConfirmDestory = vgui.Create( "DFrame" )
	ConfirmDestory:ShowCloseButton( true )
	ConfirmDestory:SetDeleteOnClose( true )
	ConfirmDestory:SetDraggable(false)
	ConfirmDestory:SetSize( 200, 60 )
	ConfirmDestory:SetTitle( "Confirm Destroy" )
	ConfirmDestory:SetPos( ScrW() / 2 - 75, ScrH() / 2 - 75 )
	ConfirmDestory:MakePopup()
	
	local InvLabel = vgui.Create("DLabel", ConfirmDestory)
	InvLabel:SetPos(10,25) // Position
	InvLabel:SetColor(Color(255,0,80,255)) // Color
	InvLabel:SetFont("SGS_RCacheMenuText")
	InvLabel:SetText("Destroy: " .. CapAll(string.gsub(res, "_", " ")) .. " (" .. tostring(amt) .. "x)?") // Text
	InvLabel:SizeToContents()
	
	local button = vgui.Create( "DButton", ConfirmDestory )
	button:SetSize( 30, 15 )
	button:SetPos( 10, 40 )
	button:SetText( "No" )
	button.DoClick = function( button )
		ConfirmDestory:Close()
	end
	
	local button3 = vgui.Create( "DButton", ConfirmDestory )
	button3:SetSize( 30, 15 )
	button3:SetPos( 50, 40 )
	button3:SetText( "Yes" )
	button3.DoClick = function( button3 )
		RunConsoleCommand("sgs_destroyresource", res, amt)
		ConfirmDestory:Close()
	end
	
	ConfirmDestory:SetVisible( true )
end


/*--------------------------------
----------Player Models-----------
--------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0, 0)
    self:SetSize(600, 510)
    self:SetVisible(false)
	
	self:DrawFrame()
	
	
end

function PANEL:DrawFrame()
	
	function DrawIcons()
		if SGS.PMCatLists then SGS.PMCatLists:Remove() end
	
		SGS.PMCatLists = vgui.Create( "DPanelList", self)
		SGS.PMCatLists:EnableVerticalScrollbar( true )
		SGS.PMCatLists:EnableHorizontal( false )
		SGS.PMCatLists:SetSize( 430, 480 )
		SGS.PMCatLists:SetPos( 0, 0 )
		SGS.PMCatLists:SetPadding( 4 )
		
		if SGS.tier == "1" or SGS.tier == "2" or SGS.tier == "3" or SGS.tier == "4" or SGS.tier == "d" or SGS.tier == "m" or SGS.tier == "a" then
			local IconList = vgui.Create( "DIconLayout")
			local CollapseCat = vgui.Create( "DCollapsibleCategory" )
			SGS.PMCatLists:AddItem(CollapseCat)
			CollapseCat:SetExpanded( 1 )
			CollapseCat:SetLabel( "1. Basic Survivor" )
			CollapseCat:SetContents( IconList )
			IconList:SetSpaceX( 4 )
			IconList:SetSpaceY( 4 )
			for k2, v2 in pairs(SGS.pmlist1) do
				local icon = vgui.Create( "SpawnIcon", IconList )
				icon:SetModel( player_manager.TranslatePlayerModel(v2) )
				icon:SetToolTip( v2 )
				IconList:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v2) 
				end
			end
		end
		
		if SGS.tier == "2" or SGS.tier == "3" or SGS.tier == "4" or SGS.tier == "d" or SGS.tier == "m" or SGS.tier == "a" then
			local IconList2 = vgui.Create( "DIconLayout")
			local CollapseCat2 = vgui.Create( "DCollapsibleCategory" )
			SGS.PMCatLists:AddItem(CollapseCat2)
			CollapseCat2:SetExpanded( 2 )
			CollapseCat2:SetLabel( "2. Skilled Survivor" )
			CollapseCat2:SetContents( IconList2 )
			IconList2:SetSpaceX( 4 )
			IconList2:SetSpaceY( 4 )
			for k2, v2 in pairs(SGS.pmlist2) do
				local icon = vgui.Create( "SpawnIcon", IconList2 )
				icon:SetModel( player_manager.TranslatePlayerModel(v2) )
				icon:SetToolTip( v2 )
				IconList2:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v2) 
				end
			end
		end
		
		if SGS.tier == "3" or SGS.tier == "4" or SGS.tier == "d" or SGS.tier == "m" or SGS.tier == "a" then
			local IconList3 = vgui.Create( "DIconLayout")
			local CollapseCat3 = vgui.Create( "DCollapsibleCategory" )
			SGS.PMCatLists:AddItem(CollapseCat3)
			CollapseCat3:SetExpanded( 3 )
			CollapseCat3:SetLabel( "3. Adept Survivor" )
			CollapseCat3:SetContents( IconList3 )
			IconList3:SetSpaceX( 4 )
			IconList3:SetSpaceY( 4 )
			for k2, v2 in pairs(SGS.pmlist3) do
				local icon = vgui.Create( "SpawnIcon", IconList3 )
				icon:SetModel( player_manager.TranslatePlayerModel(v2) )
				icon:SetToolTip( v2 )
				IconList3:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v2) 
				end
			end
		end
		
		if SGS.tier == "4" or SGS.tier == "d" or SGS.tier == "m" or SGS.tier == "a" then
			local IconList3 = vgui.Create( "DIconLayout")
			local CollapseCat3 = vgui.Create( "DCollapsibleCategory" )
			SGS.PMCatLists:AddItem(CollapseCat3)
			CollapseCat3:SetExpanded( 3 )
			CollapseCat3:SetLabel( "4. Veteran Survivor" )
			CollapseCat3:SetContents( IconList3 )
			IconList3:SetSpaceX( 4 )
			IconList3:SetSpaceY( 4 )
			for k2, v2 in pairs(SGS.pmlist4) do
				local icon = vgui.Create( "SpawnIcon", IconList3 )
				icon:SetModel( player_manager.TranslatePlayerModel(v2) )
				icon:SetToolTip( v2 )
				IconList3:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v2) 
				end
			end
		end
		
		if SGS.tier == "d" or SGS.tier == "m" or SGS.tier == "a" then
			local IconListD = vgui.Create( "DIconLayout")
			local CollapseCatD = vgui.Create( "DCollapsibleCategory" )
			SGS.PMCatLists:AddItem(CollapseCatD)
			CollapseCatD:SetExpanded( 3 )
			CollapseCatD:SetLabel( "5. Donator" )
			CollapseCatD:SetContents( IconListD )
			IconListD:SetSpaceX( 4 )
			IconListD:SetSpaceY( 4 )
			for k2, v2 in pairs(SGS.pmlistd) do
				local icon = vgui.Create( "SpawnIcon", IconListD )
				icon:SetModel( player_manager.TranslatePlayerModel(v2) )
				icon:SetToolTip( v2 )
				IconListD:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v2) 
				end
			end
		end

		if SGS.tier == "m" or SGS.tier == "a" then
			local IconList4 = vgui.Create( "DIconLayout")
			local CollapseCat4 = vgui.Create( "DCollapsibleCategory" )
			SGS.PMCatLists:AddItem(CollapseCat4)
			CollapseCat4:SetExpanded( 4 )
			CollapseCat4:SetLabel( "6. Moderator" )
			CollapseCat4:SetContents( IconList4 )
			IconList4:SetSpaceX( 4 )
			IconList4:SetSpaceY( 4 )
			for k2, v2 in pairs(SGS.pmlistm) do
				local icon = vgui.Create( "SpawnIcon", IconList4 )
				icon:SetModel( player_manager.TranslatePlayerModel(v2) )
				icon:SetToolTip( v2 )
				IconList4:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v2) 
				end
			end
		end
		
		if SGS.tier == "a" then
			local IconList5 = vgui.Create( "DIconLayout")
			local CollapseCat5 = vgui.Create( "DCollapsibleCategory" )
			SGS.PMCatLists:AddItem(CollapseCat5)
			CollapseCat5:SetExpanded( 5 )
			CollapseCat5:SetLabel( "7. Administrators" )
			CollapseCat5:SetContents( IconList5 )
			IconList5:SetSpaceX( 4 )
			IconList5:SetSpaceY( 4 )
			for k2, v2 in pairs(SGS.pmlista) do
				local icon = vgui.Create( "SpawnIcon", IconList5 )
				icon:SetModel( player_manager.TranslatePlayerModel(v2) )
				icon:SetToolTip( v2 )
				IconList5:Add( icon )
				icon.DoClick = function ( icon ) 
					surface.PlaySound( "ui/buttonclickrelease.wav" ) 
					RunConsoleCommand("SGS_changepmodel", v2) 
				end
			end
		end
	end
	DrawIcons()
	concommand.Add( "sgs_refreshpmodels", DrawIcons )
	
	local ColorOptionsPanel = vgui.Create( "DPanel", self )
	ColorOptionsPanel:SetSize( 160,200 )
	ColorOptionsPanel:SetPos( 435, 20 )
	
	local PlayerModelColorLabel = vgui.Create("DLabel", self)
	PlayerModelColorLabel:SetPos( 435, 5 )
	PlayerModelColorLabel:SetColor(Color(255,255,255,255)) // Color
	PlayerModelColorLabel:SetFont("SGS_FarmText")
	PlayerModelColorLabel:SetText("Player Model Color") // Text
	PlayerModelColorLabel:SizeToContents() // make the control the same size as the text.
	
	local PModelColor = vgui.Create( "DColorMixer", ColorOptionsPanel)
	PModelColor:SetColor(Color(255,255,255,255))
	PModelColor:Dock( FILL )
	PModelColor:SetPalette( true )
	PModelColor:SetAlphaBar( false )
	PModelColor:SetWangs( false )
		
	local PModelColorButton = vgui.Create( "DButton", self )
	PModelColorButton:SetText("Set Color")
	PModelColorButton:SetSize( 160, 20 )
	PModelColorButton:SetPos( 435, 225 )
	PModelColorButton.DoClick = function( PModelColorButton )
		local color2 = PModelColor:GetColor()
		RunConsoleCommand( "sgs_setplayercolor", color2.r, color2.g, color2.b )
	end
	
end
vgui.Register("sgs_pmodelmenu", PANEL, "EditablePanel")


/*--------------------------------
---------------TOS----------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()

	self.x = ScrW()
	self.y = ScrH()
	
	self.sizex = self.x * 0.8
	self.sizey = self.y * 0.8
	
	self:SetSize( self.sizex, self.sizey )
    self:SetPos((ScrW() / 2) - (self.sizex / 2), (ScrH() / 2) - (self.sizey / 2))
    self:SetVisible(false)
	
	self.time = SGS.tostime
	self.nextthink = CurTime() + 1
	self.bdisabled = true

	self:DrawFrame()
end

function PANEL:Paint( w, h )
	surface.SetDrawColor( 0, 0, 0, 210 )
	surface.DrawRect( 4, 4,  self:GetWide() - 8, self:GetTall() - 8 )
end

function PANEL:DrawFrame()
	--HTMLPanel = vgui.Create("DPanel", self)
	--HTMLPanel:SetPos(8,64)
	--HTMLPanel:SetSize(782, 500)
	
	
	HTMLTest = vgui.Create("DHTML", self)
	HTMLTest:SetPos(12,12)
	HTMLTest:SetSize( self.sizex - 24, self.sizey - 68 )
	HTMLTest:OpenURL("http://www.g4p.org/StrandedTOS/")
	
	TOSbutton = vgui.Create( "DButton", self )
	TOSbutton:SetSize( 120, 40 )
	TOSbutton:SetPos( 12, self.sizey - 52  )
	TOSbutton:SetText( "Wait: " .. self.time )
	TOSbutton:SetDisabled( true )
	TOSbutton.DoClick = function( TOSbutton )
		if TOSbutton:GetDisabled() then return end
		RunConsoleCommand("sgs_accepttos")
		self:Remove()
	end
	
	TOSbutton2 = vgui.Create( "DButton", self )
	TOSbutton2:SetSize( 120, 40 )
	TOSbutton2:SetPos( 140, self.sizey - 52 )
	TOSbutton2:SetText( "I DON'T ACCEPT" )
	TOSbutton2.DoClick = function( TOSbutton2 )
		RunConsoleCommand("disconnect")
	end
	
	
end


function PANEL:Think()
	if CurTime() < self.nextthink then return end
	if self.bdisabled then
		if self.time > 0 then
			self.time = self.time - 1
			TOSbutton:SetText( "Wait: " .. self.time )
			TOSbutton:SetDisabled( true )
		else
			TOSbutton:SetText( "I ACCEPT" )
			TOSbutton:SetDisabled( false )
			self.bdisabled = false
		end
	end
	self.nextthink = CurTime() + 1
end
vgui.Register("sgs_tospanel", PANEL, "EditablePanel")

/*--------------------------------
------------SPP Menu-------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0, 0)
    self:SetSize(600, 510)
    self:SetVisible(false)
	
	self:DrawFrame()
	
	
end

function PANEL:DrawFrame()

	function DrawSPPFrame()
	
		if SGS.SPP_ClientMenuForm then SGS.SPP_ClientMenuForm:Remove() end
		
		SGS.SPP_ClientMenuForm = vgui.Create( "DPanelList", self)
		SGS.SPP_ClientMenuForm:EnableVerticalScrollbar( true )
		SGS.SPP_ClientMenuForm:EnableHorizontal( false )
		SGS.SPP_ClientMenuForm:SetSize( 600, 480 )
		SGS.SPP_ClientMenuForm:SetPos( 0, 0 )
		SGS.SPP_ClientMenuForm:SetSpacing( 10 )
		
		
		local label1 = vgui.Create( "DLabel" )
		label1:SetColor(Color(255,255,255,255)) // Color
		label1:SetFont("default")
		label1:SetText("SPP - Client Customization Menu")
		label1:SizeToContents()
		SGS.SPP_ClientMenuForm:AddItem( label1 )
		
		local button1 = vgui.Create( "DButton" )
		button1:SetText("Cleanup Props")
		button1:SetConsoleCommand( "spp_cleanupprops" )
		SGS.SPP_ClientMenuForm:AddItem( button1 )
		
		local label2 = vgui.Create( "DLabel" )
		label2:SetColor(Color(255,255,255,255)) // Color
		label2:SetFont("default")
		label2:SetText("Friends Panel")
		label2:SizeToContents()
		SGS.SPP_ClientMenuForm:AddItem( label2 )
		
		local Players = player.GetAll()
		if(table.Count(Players) == 1) then
			local label3 = vgui.Create( "DLabel" )
			label3:SetColor(Color(255,255,255,255)) // Color
			label3:SetFont("default")
			label3:SetText("No Other Players Are Online")
			label3:SizeToContents()
			SGS.SPP_ClientMenuForm:AddItem( label3 )
		else
			for k, ply in pairs(Players) do
				if(ply and ply:IsValid() and ply != LocalPlayer()) then
					local FriendCommand = "spp_friend_"..ply:GetNWString("SPPSteamID", "")
					if(!LocalPlayer():GetInfo(FriendCommand)) then
						CreateClientConVar(FriendCommand, 0, false, true)
					end
					local checkbox = vgui.Create( "DCheckBoxLabel" )
					checkbox:SetText( ply:Nick() )
					checkbox:SetConVar( FriendCommand )
					SGS.SPP_ClientMenuForm:AddItem( checkbox )
				end
			end
			local button2 = vgui.Create( "DButton" )
			button2:SetText("Apply Settings")
			button2:SetConsoleCommand( "spp_applyfriends" )
			SGS.SPP_ClientMenuForm:AddItem( button2 )
		end
		
		local button2 = vgui.Create( "DButton" )
		button2:SetText("Disown ALL Props/Structures")
		button2.DoClick = function( button2 )
			SGS_ConfirmPropDisown()		
		end
		SGS.SPP_ClientMenuForm:AddItem( button2 )
	end
	DrawSPPFrame()
	concommand.Add( "sgs_refreshspp", DrawSPPFrame )
end
vgui.Register("sgs_sppmenu", PANEL, "Panel")

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

/*---------------------------------
----------Voice Channels-----------
---------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos(0, 0)
    self:SetSize(600, 510)
    self:SetVisible(false)
	
	self:DrawFrame()
	
	
end

function PANEL:DrawFrame()

	function DrawVCFrame()
	
		if SGS.VoiceChatPanel then SGS.VoiceChatPanel:Remove() end
		
		SGS.VoiceChatPanel = vgui.Create( "DPanel", self )
		SGS.VoiceChatPanel:SetPos(0,0)
		SGS.VoiceChatPanel:SetSize(600, 510)
		SGS.VoiceChatPanel:SetPaintBackground( false )
		
		local VCListView = vgui.Create( "DListView", SGS.VoiceChatPanel )
		VCListView:SetPos( 0, 0 )
		VCListView:SetSize( 600, 450 )
		VCListView:SetMultiSelect( false )
		VCListView:AddColumn( "ID" ):SetFixedWidth( 40 )
		VCListView:AddColumn( "Channel Name" )
		VCListView:AddColumn( "Passworded" ):SetFixedWidth( 70 )
		VCListView:AddColumn( "Creator" ):SetFixedWidth( 130 )
		
		local VCJoinBtn = vgui.Create( "DButton", SGS.VoiceChatPanel )
		VCJoinBtn:SetPos( 0, 455 )
		VCJoinBtn:SetSize( 80, 20)
		VCJoinBtn:SetText( "Join Selected" )
		VCJoinBtn.DoClick = function( VCJoinBtn )
			local cid = tostring(VCListView:GetLine(VCListView:GetSelectedLine()):GetValue(1))
			if cid == "A" or cid == "W" or cid == "T"then 
				RunConsoleCommand("sgs_joinvoicechannel", cid )
			else
				if SGS.voicechannels[tonumber(cid)].ispassworded then
					SGS_VCJoinPassworded( cid )
				else
					RunConsoleCommand("sgs_joinvoicechannel", tonumber(cid) )
				end
			end
		end
		
		local VCCreateBtn = vgui.Create( "DButton", SGS.VoiceChatPanel )
		VCCreateBtn:SetPos( 480, 455 )
		VCCreateBtn:SetSize( 80, 20)
		VCCreateBtn:SetText( "Create New" )
		VCCreateBtn.DoClick = function( VCCreateBtn ) SGS_CreateNewVCGUI() end	
		
		local VCRefreshBtn = vgui.Create( "DButton", SGS.VoiceChatPanel )
		VCRefreshBtn:SetPos( 250, 455 )
		VCRefreshBtn:SetSize( 80, 20)
		VCRefreshBtn:SetText( "Refresh List" )
		VCRefreshBtn.DoClick = function( VCRefreshBtn ) RunConsoleCommand("sgs_requestvclist") end
		
		
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
		
	end
	DrawVCFrame()
	concommand.Add( "sgs_refreshvc", DrawVCFrame )

end
vgui.Register("sgs_voicechans", PANEL, "Panel")

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

/*--------------------------------
--------------Help----------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()

	self.x = ScrW()
	self.y = ScrH()
	
	self.sizex = self.x * 0.8
	self.sizey = self.y * 0.8
	
	self:SetSize( self.sizex, self.sizey )
    self:SetPos((ScrW() / 2) - (self.sizex / 2), (ScrH() / 2) - (self.sizey / 2))
    self:SetVisible(false)
	
	self:DrawFrame()
end

function PANEL:Paint( w, h )
	surface.SetDrawColor( 0, 0, 0, 210 )
	surface.DrawRect( 4, 4,  self:GetWide() - 8, self:GetTall() - 8 )
end

function PANEL:DrawFrame()	
	
	HTMLTest = vgui.Create("DHTML", self)
	HTMLTest:SetPos(12,12)
	HTMLTest:SetSize( self.sizex - 24, self.sizey - 68 )
	HTMLTest:OpenURL("http://www.g4p.org/StrandedTOS/guide.php")
	
	TOSbutton = vgui.Create( "DButton", self )
	TOSbutton:SetSize( 120, 40 )
	TOSbutton:SetPos( 12, self.sizey - 52  )
	TOSbutton:SetText( "CLOSE" )
	TOSbutton.DoClick = function( TOSbutton )
		self:Remove()
	end
	
	
end

vgui.Register("sgs_helppanel", PANEL, "Panel")

/*--------------------------------
--------------Wiki----------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos((ScrW() / 2) - 400, 30)
    self:SetSize(800, 650)
    self:SetVisible(false)
	
	
	self:DrawFrame()
	
	
end

function PANEL:Paint( w, h )

	draw.RoundedBoxEx( 16, 0, 0, self:GetWide(), self:GetTall(), Color(80, 80, 80, 150), true, true, true, true )

end

function PANEL:DrawFrame()
	HTMLPanel = vgui.Create("DPanel", self)
	HTMLPanel:SetPos(8,64)
	HTMLPanel:SetSize(782, 500)
	
	
	HTMLTest = vgui.Create("DHTML", HTMLPanel)
	HTMLTest:SetPos(0,0)
	HTMLTest:Dock( FILL )
	HTMLTest:OpenURL("http://www.g4p.org/Wiki/")
	
	HelpButton = vgui.Create( "DButton", self )
	HelpButton:SetSize( 120, 40 )
	HelpButton:SetPos( 8, 572 )
	HelpButton:SetText( "OK" )
	HelpButton.DoClick = function( HelpButton )
		self:Remove()
	end

	
	
end
vgui.Register("sgs_wikipanel", PANEL, "EditablePanel")


/*---------------------------------
----------New Scoreboard?----------
---------------------------------*/
local PANEL = {}

function PANEL:Init()
    
	self:SetPos((ScrW() / 2) - 400, ScrH() * 0.1)
    self:SetSize(815, ScrH() * 0.8)
    self:SetVisible(false)
	
	
	self:DrawFrame()
	
	
end

function PANEL:Paint( w, h )

	--draw.RoundedBoxEx( 16, 0, 0, self:GetWide(), self:GetTall(), Color(80, 80, 80, 150), true, true, true, true )
	
	
	draw.SimpleTextOutlined( " |G4P| Stranded ", "ScoreboardDefaultTitle", 8, 0, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 2, Color(0,0,0,255))

end

function PANEL:DrawFrame()
	if SGS.ScoreBoardPanel then SGS.ScoreBoardPanel:Remove() end
	
	

	SGS.ScoreBoardPanel = vgui.Create("DPanelList", self)
	SGS.ScoreBoardPanel:SetPos(8,40)
	SGS.ScoreBoardPanel:SetSize(800, ScrH() * 0.7)
	SGS.ScoreBoardPanel:EnableVerticalScrollbar( true )
	
	
	for k, v in pairs( team.GetAllTeams() ) do
		if #team.GetPlayers( k ) <= 0 then continue end
		if k == 1002 then continue end
	
		local teambanner = vgui.Create( "DPanel" )
		teambanner:SetSize( 782, 25 )
		teambanner.Paint = function()
			surface.SetFont( "ScoreboardDefault" )
			surface.SetTextColor( Color(0, 0, 0, 255) )
			surface.SetDrawColor( team.GetColor( k ) )
			surface.DrawRect( 0, 0, teambanner:GetWide(), teambanner:GetTall() )
			surface.SetDrawColor(Color(0,0,0,255))
			surface.DrawOutlinedRect( 0, 0, teambanner:GetWide(), teambanner:GetTall() )
			local tw, th = surface.GetTextSize( team.GetName( k ) )
			surface.SetTextPos( 400 - (tw / 2), 12 - (th / 2) )
			surface.DrawText( team.GetName( k ) )
		end
		SGS.ScoreBoardPanel:AddItem( teambanner )
		
		local titlebarbanner = vgui.Create( "DPanel" )
		titlebarbanner:SetSize( 782, 20 )
		titlebarbanner.Paint = function()
			surface.SetFont( "SGS_RCacheMenuText" )
			surface.SetTextColor( Color(0, 0, 0, 255) )
			surface.SetDrawColor( Color(255, 255, 255, 255) )
			surface.DrawRect( 0, 0, titlebarbanner:GetWide(), titlebarbanner:GetTall() )
			surface.SetDrawColor(Color(0,0,0,255))
			surface.DrawOutlinedRect( 0, 0, titlebarbanner:GetWide(), titlebarbanner:GetTall() )
			local _, th = surface.GetTextSize( "I" )
			surface.SetTextPos( 5, 10 - (th / 2) )
			surface.DrawText("Name:")
			surface.SetTextPos( 400, 10 - (th / 2) )
			surface.DrawText("Level:")
			surface.SetTextPos( 510, 10 - (th / 2) )
			surface.DrawText("Voice Channel:")
			surface.SetTextPos( 640, 10 - (th / 2) )
			surface.DrawText("Ping:")
			surface.SetTextPos( 685, 10 - (th / 2) )
			surface.DrawText("Mute:")
			surface.SetTextPos( 720, 10 - (th / 2) )
			surface.DrawText("Gag:")
			surface.SetTextPos( 760, 10 - (th / 2) )
			surface.DrawText("Stats:")
		end
		SGS.ScoreBoardPanel:AddItem( titlebarbanner )
		
		for _, ply in pairs(player.GetAll()) do
			if ply then
				if ply:Team() == k then
					local playerbanner = vgui.Create( "DPanel" )
					playerbanner:SetSize( 782, 20 )
					local pname = ply:Nick()
					local pslvl = ply:GetNWString("survival", "0")
					if ply:IsUserGroup("usera") then pslvl = "1" end
					local pvc = ply:GetNWString("voicechannel", "A")
					if ply:IsUserGroup("usera") then pvc = "A" end
					local pping = ply:Ping()
					playerbanner.Paint = function()
						surface.SetFont( "SGS_RCacheMenuText" )
						surface.SetTextColor( Color(0, 0, 0, 255) )
						surface.SetDrawColor( Color(255, 255, 255, 255) )
						surface.DrawRect( 0, 0, playerbanner:GetWide(), playerbanner:GetTall() )
						surface.SetDrawColor(Color(0,0,0,255))
						surface.DrawOutlinedRect( 0, 0, playerbanner:GetWide(), playerbanner:GetTall() )
						local tw, th = surface.GetTextSize( pname )
						surface.SetTextPos( 5, 10 - (th / 2) )
						if ply:GetNWBool( "afk", false ) then
							surface.SetTextColor( Color(255, 0, 0, 255) )
							surface.DrawText( "*AFK*" )
							surface.SetTextColor( Color(0, 0, 0, 255) )
							surface.SetTextPos( 45, 10 - (th / 2) )
							surface.DrawText( pname )
						else
							surface.DrawText( pname )
						end
						surface.SetTextPos( 410, 10 - (th / 2) )
						surface.DrawText( pslvl )
						surface.SetTextPos( 550, 10 - (th / 2) )
						surface.DrawText( pvc )
						surface.SetTextPos( 648, 10 - (th / 2) )
						surface.DrawText( pping )
					end
					
					gagbutton = vgui.Create("DImageButton", playerbanner)
					gagbutton:SetSize( 16, 16 )
					gagbutton:SetPos( 725, 2 )
					if ply:IsMuted() then 
						gagbutton:SetImage( "icon32/muted.png" )
					else
						gagbutton:SetImage( "icon32/unmuted.png" )
					end
					gagbutton.DoClick = function() ply:SetMuted( !ply:IsMuted() ) self:DrawFrame() end
					
					mutebutton = vgui.Create("DImageButton", playerbanner)
					mutebutton:SetSize( 16, 16 )
					mutebutton:SetPos( 690, 2 )
					if ply.ismuted then 
						mutebutton:SetImage( "icon32/muted.png" )
					else
						mutebutton:SetImage( "icon32/unmuted.png" )
					end
					mutebutton.DoClick = function() 
						if ply.ismuted then
							ply.ismuted = false
						else
							ply.ismuted = true
						end
						self:DrawFrame() 
					end
					
					statsbutton = vgui.Create("DImageButton", playerbanner)
					statsbutton:SetSize( 16, 16 )
					statsbutton:SetPos( 765, 2 )
					statsbutton:SetImage( "icon16/table_edit.png" )
					statsbutton.DoClick = function() RunConsoleCommand( "sgs_viewplayerstats", ply:Nick() ) end
					
					
					SGS.ScoreBoardPanel:AddItem( playerbanner )
				end
			end
		end
		
		local blankbar = vgui.Create( "DPanel" )
		blankbar:SetSize( 782, 12 )
		blankbar.Paint = function()
			surface.SetDrawColor( Color(255, 255, 255, 0) )
			surface.DrawRect( 0, 0, blankbar:GetWide(), blankbar:GetTall() )
		end
		SGS.ScoreBoardPanel:AddItem( blankbar )
		
	end
	
end
vgui.Register("sgs_newscoreboard", PANEL, "EditablePanel")


--[[---------------------------------------------------------
   Name: gamemode:ScoreboardShow( )
   Desc: Sets the scoreboard to visible
-----------------------------------------------------------]]
function GM:ScoreboardShow()

	if ( not IsValid(SGS.ScoreBoard) ) then
	
		SGS.ScoreBoard = vgui.Create("sgs_newscoreboard")
		
	end
	
	if ( IsValid(SGS.ScoreBoard) ) then
	
		SGS.ScoreBoard:Show()
		SGS.ScoreBoard:DrawFrame()
		SGS.ScoreBoard:MakePopup()
		SGS.ScoreBoard:SetKeyboardInputEnabled( false )
		
	end

end

--[[---------------------------------------------------------
   Name: gamemode:ScoreboardHide( )
   Desc: Hides the scoreboard
-----------------------------------------------------------]]
function GM:ScoreboardHide()

	if ( IsValid(SGS.ScoreBoard) ) then
		SGS.ScoreBoard:Hide()
	end

end