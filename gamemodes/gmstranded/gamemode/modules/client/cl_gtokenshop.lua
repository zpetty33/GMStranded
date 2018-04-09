function SGS_ShopMenu()

	SGS.gshop = vgui.Create( "DFrame" )
	SGS.gshop:ShowCloseButton(true)
	SGS.gshop:SetDraggable(false)
	SGS.gshop:SetSize( 320,370 )
	SGS.gshop:SetPos( ScrW() / 2 - 160, ScrH() / 2 - 170 )
	SGS.gshop:SetTitle( "GToken Shop" )

	local CatList = vgui.Create( "DPanelList", SGS.gshop)
	CatList:AddItem(ToolsCollapseCat)
	CatList:EnableVerticalScrollbar( true )
	CatList:EnableHorizontal( false )
	CatList:SetSize( 300, 300 )
	CatList:SetPos( 10, 30 )
	CatList:SetPadding( 4 )
	
	for k, v in pairs( SGS.Shop ) do
	
		local IconList = vgui.Create( "DPanelList")
		local CollapseCat = vgui.Create( "DCollapsibleCategory" )
		CatList:AddItem(CollapseCat)
		
		CollapseCat:SetSize( 335, 50 )
		CollapseCat:SetExpanded( 1 )
		CollapseCat:SetLabel( Cap(k) )
	

		CollapseCat:SetContents( IconList )
		
		IconList:EnableVerticalScrollbar( true )
		IconList:EnableHorizontal( true )
		IconList:SetAutoSize( true )
		IconList:SetPadding( 4 )
		IconList:SetSpacing(5)
		
		for k2, v2 in pairs(SGS.Shop[k]) do
			local cost = v2.cost
			if GAMEMODE.Tribes:GetTribeLevel( LocalPlayer() ) >= 10 then
				cost = math.ceil(cost * 0.9)
			end
			local icon = vgui.Create( "DImageButton", IconList )
			icon:SetImage( v2.material )
			icon:SetToolTip( SGS_ToolTipShop(v2) )
			icon:SetSize(64, 64)
			IconList:AddItem( icon )
			icon.PaintOver = function()
				if SGS.gtokens < cost then
					draw.RoundedBoxEx( 2, 5, 39, 54, 20, Color(255, 255, 50, 150), false, false, false, false )
					draw.SimpleText("INSUFFICIENT", "proplisticons", 7, 41, Color(0, 0, 0, 255), 0, 0)
					draw.SimpleText("GTOKENS", "proplisticons", 8, 49, Color(0, 0, 0, 255), 0, 0)
					icon.OnCursorEntered = function()
						return true
					end
				end
			end
			icon.DoClick = function ( icon ) 
				surface.PlaySound( "ui/buttonclickrelease.wav" )
				RunConsoleCommand("sgs_buy", v2.uid)
				--SGS.cookingmenu:SetVisible(false)
			end
		end
	end
	
	local ShopLabel = vgui.Create("DLabel", SGS.gshop)
	ShopLabel:SetPos(10,345) // Position
	ShopLabel:SetColor(Color(255,255,0,255)) // Color
	ShopLabel:SetFont("SGS_RCacheMenuText")
	ShopLabel:SetText("Your GTokens: " .. SGS.gtokens) // Text
	ShopLabel:SizeToContents()
	/*
	local button = vgui.Create( "DButton", SGS.gshop )
	button:SetSize( 120, 20 )
	button:SetPos( 10, 342 )
	button:SetText( "Toggle Burning" )
	button.DoClick = function( button )
		RunConsoleCommand("sgs_burncheck")
	end
	*/
	SGS.gshop:MakePopup()
end




function SGS_ShopMenu2()

	SGS.gshop2 = vgui.Create( "DFrame" )
	SGS.gshop2:ShowCloseButton(true)
	SGS.gshop2:SetDraggable(false)
	SGS.gshop2:SetSize( 320,370 )
	SGS.gshop2:SetPos( ScrW() / 2 - 160, ScrH() / 2 - 170 )
	SGS.gshop2:SetTitle( "Special Shop" )

	local CatList = vgui.Create( "DPanelList", SGS.gshop2)
	CatList:AddItem(ToolsCollapseCat)
	CatList:EnableVerticalScrollbar( true )
	CatList:EnableHorizontal( false )
	CatList:SetSize( 300, 300 )
	CatList:SetPos( 10, 30 )
	CatList:SetPadding( 4 )
	
	for k, v in pairs( SGS.SpecialShop ) do
	
		local IconList = vgui.Create( "DPanelList")
		local CollapseCat = vgui.Create( "DCollapsibleCategory" )
		CatList:AddItem(CollapseCat)
		
		CollapseCat:SetSize( 335, 50 )
		CollapseCat:SetExpanded( 1 )
		CollapseCat:SetLabel( Cap(k) )
	

		CollapseCat:SetContents( IconList )
		
		IconList:EnableVerticalScrollbar( true )
		IconList:EnableHorizontal( true )
		IconList:SetAutoSize( true )
		IconList:SetPadding( 4 )
		IconList:SetSpacing(5)
		
		for k2, v2 in pairs(SGS.SpecialShop[k]) do
			local icon = vgui.Create( "DImageButton", IconList )
			icon:SetImage( v2.material )
			icon:SetToolTip( SGS_ToolTipShop2(v2) )
			icon:SetSize(64, 64)
			IconList:AddItem( icon )
			icon.PaintOver = function()
				if ( SGS.resources[ "candy_cane" ] or 0 ) < v2.cost then
					draw.RoundedBoxEx( 2, 5, 39, 54, 20, Color(255, 255, 50, 150), false, false, false, false )
					draw.SimpleText("INSUFFICIENT", "proplisticons", 7, 41, Color(0, 0, 0, 255), 0, 0)
					draw.SimpleText("GTOKENS", "proplisticons", 8, 49, Color(0, 0, 0, 255), 0, 0)
					icon.OnCursorEntered = function()
						return true
					end
				end
			end
			icon.DoClick = function ( icon ) 
				surface.PlaySound( "ui/buttonclickrelease.wav" )
				RunConsoleCommand("sgs_buy2", v2.uid)
			end
		end
	end
	
	local ShopLabel = vgui.Create("DLabel", SGS.gshop2)
	ShopLabel:SetPos(10,345) // Position
	ShopLabel:SetColor(Color(255,255,0,255)) // Color
	ShopLabel:SetFont("SGS_RCacheMenuText")
	ShopLabel:SetText("Your Candy Canes: " .. ( SGS.resources[ "candy_cane" ] or 0) ) // Text
	ShopLabel:SizeToContents()
	SGS.gshop2:MakePopup()
end
