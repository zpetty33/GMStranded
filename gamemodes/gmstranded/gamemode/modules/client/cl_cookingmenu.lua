function SGS_CookingMenu()

	SGS.cookingmenu = vgui.Create( "DFrame" )
	SGS.cookingmenu:ShowCloseButton(true)
	SGS.cookingmenu:SetDraggable(false)
	SGS.cookingmenu:SetSize( 320,370 )
	SGS.cookingmenu:SetPos( ScrW() / 2 - 160, ScrH() / 2 - 170 )
	SGS.cookingmenu:SetTitle( "Cooking Menu" )

	local CatList = vgui.Create( "DPanelList", SGS.cookingmenu)
	CatList:AddItem(ToolsCollapseCat)
	CatList:EnableVerticalScrollbar( true )
	CatList:EnableHorizontal( false )
	CatList:SetSize( 300, 300 )
	CatList:SetPos( 10, 30 )
	CatList:SetPadding( 4 )
	
	for k, v in pairs( SGS.Food ) do
	
		if k == "relic" then continue end
		if k == "artifact" then continue end
		if k == "easteregg" then continue end
		if k == "specialfood" then continue end

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
		
		for k2, v2 in pairs(SGS.Food[k]) do
			local icon = vgui.Create( "DImageButton", IconList )
			icon:SetImage( v2.material )
			icon:SetToolTip( SGS_ToolTip(v2) )
			icon:SetSize(64, 64)
			IconList:AddItem( icon )
			icon.PaintOver = function()
				for k3, v3 in pairs( v2.reqlvl ) do
					local plvl = SGS.levels[ k3 ] or 0
					if plvl < v3 then
						draw.RoundedBoxEx( 2, 5, 5, 54, 20, Color(255, 80, 80, 100), false, false, false, false )
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
						draw.RoundedBoxEx( 2, 5, 39, 54, 20, Color(255, 255, 50, 100), false, false, false, false )
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
				RunConsoleCommand("sgs_cook", v2.name)
				--SGS.cookingmenu:SetVisible(false)
			end
		end
	end
	local button = vgui.Create( "DButton", SGS.cookingmenu )
	button:SetSize( 120, 20 )
	button:SetPos( 10, 342 )
	button:SetText( "Toggle Burning" )
	button.DoClick = function( button )
		RunConsoleCommand("sgs_burncheck")
	end
	SGS.cookingmenu:MakePopup()
end

