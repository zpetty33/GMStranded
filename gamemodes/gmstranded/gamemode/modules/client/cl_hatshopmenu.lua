function SGS_HatShopMenu()

	SGS.hattobuy = ""
	
	local HatShopMenu = vgui.Create( "DFrame" )
	HatShopMenu:ShowCloseButton(true)
	HatShopMenu:SetDraggable(false)
	HatShopMenu:SetSize( 380, 300 )
	HatShopMenu:SetTitle( "Hat Shop - Select a hat for more information!" )
	HatShopMenu:Center()
	HatShopMenu:MakePopup()	
	HatShopMenu:SetVisible(true)
	
	local HatListPanel = vgui.Create( "DPanel", HatShopMenu )
	HatListPanel:SetPos(5, 25 )
	HatListPanel:SetSize( 165, 270 )
	HatListPanel.Paint = function()
		draw.RoundedBoxEx( 0, 0, 0, 173, 320, Color(80, 80, 80, 255), false, false, false, false )
	end
	
	local HatsList = vgui.Create( "DScrollPanel", HatListPanel )
	HatsList:SetPos( 0, 0 )
	HatsList:SetSize( 165, 270 )
	
	local HatsListIcons = vgui.Create( "DIconLayout", HatsList )
	HatsListIcons:SetSize( 158, 270 )
	HatsListIcons:SetPos( 0, 0 )
	HatsListIcons:SetSpaceY( 3 )
	HatsListIcons:SetSpaceX( 3 )
	
	for k, v in pairs( SGS.HatShop ) do
		for _, hat in pairs( SGS.HatShop[k] ) do
			local icon = vgui.Create( "SpawnIcon" )
			icon:SetModel( hat.model )
			icon:SetSize( 48, 48 )
			icon:SetToolTip( SGS_ToolTipShort(hat) )
			icon.DoClick = function( icon )
				HatView:SetModel(hat.model)
				hcLabel:SetText("Hat Cost: " .. tostring(hat.price))
				hcLabel:SizeToContents()
				SGS.hattobuy = hat.ach
			end
			HatsListIcons:Add( icon )
		end
	end
	
	HatViewPanel = vgui.Create( "DPanel", HatShopMenu )
	HatViewPanel:SetPos(175, 25 )
	HatViewPanel:SetSize( 200, 200 )
	HatViewPanel.Paint = function()
		draw.RoundedBoxEx( 0, 0, 0, 200, 200, Color(80, 80, 80, 255), false, false, false, false )
	end
	
	HatView = vgui.Create( "DModelPanel", HatViewPanel )
	HatView:SetModel("")
	HatView:SetPos(0, 0 )
	HatView:SetSize( 200, 200 )
	HatView:SetCamPos( Vector(10,10,10) )
	HatView:SetLookAt( Vector(0, 0, 5) )
	HatView:SetDirectionalLight( BOX_LEFT, Color( 255, 255, 255, 255 ) )
	
	local gtLabel = vgui.Create("DLabel", HatShopMenu)
	gtLabel:SetPos(175,280) // Position
	gtLabel:SetColor(Color(50,234,50,255)) // Color
	gtLabel:SetFont("SGS_RCacheMenuText")
	gtLabel:SetText("GTokens: " .. tostring( SGS.gtokens )) // Text
	gtLabel:SizeToContents()
	
	hcLabel = vgui.Create("DLabel", HatShopMenu)
	hcLabel:SetPos(175,225) // Position
	hcLabel:SetColor(Color(255,255,255,255)) // Color
	hcLabel:SetFont("SGS_RCacheMenuText")
	hcLabel:SetText("Hat Cost: 0") // Text
	hcLabel:SizeToContents()
		
	local buyButton = vgui.Create( "DButton", HatShopMenu )
	buyButton:SetSize( 70, 30 )
	buyButton:SetPos( 305, 235 )
	buyButton:SetText( "BUY" )
	buyButton.DoClick = function( buyButton )
		if SGS.hattobuy ~= "" then
			RunConsoleCommand( "sgs_buyhat", SGS.hattobuy )
			HatShopMenu:Close()
		end
	end
		
	local buyButton = vgui.Create( "DButton", HatShopMenu )
	buyButton:SetSize( 70, 30 )
	buyButton:SetPos( 305, 265 )
	buyButton:SetText( "USE TOKEN" )
	buyButton.DoClick = function( buyButton )
		if SGS.hattobuy ~= "" then
			RunConsoleCommand( "sgs_buyhattoken", SGS.hattobuy )
			HatShopMenu:Close()
		end
	end
	
	
end
