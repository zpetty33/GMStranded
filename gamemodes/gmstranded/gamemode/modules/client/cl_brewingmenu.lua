function SGS_BrewingMenu()

	SGS.brewingmenu = vgui.Create( "DFrame" )
	SGS.brewingmenu:ShowCloseButton(true)
	SGS.brewingmenu:SetDraggable(false)
	SGS.brewingmenu:SetSize( 320,340 )
	SGS.brewingmenu:SetPos( ScrW() / 2 - 160, ScrH() / 2 - 170 )
	SGS.brewingmenu:SetTitle( "Alchemy Brewing Menu" )

	local CatList = vgui.Create( "DPanelList", SGS.brewingmenu)
	CatList:AddItem(ToolsCollapseCat)
	CatList:EnableVerticalScrollbar( true )
	CatList:EnableHorizontal( false )
	CatList:SetSize( 300, 300 )
	CatList:SetPos( 10, 30 )
	CatList:SetPadding( 4 )
	
	for k, v in pairs( SGS.Brewing ) do
	
		if k == "achievement" then continue end
		if k == "firstaid" then continue end

		local IconList = vgui.Create( "DPanelList")
		local CollapseCat = vgui.Create( "DCollapsibleCategory" )
		CatList:AddItem(CollapseCat)
		
		CollapseCat:SetSize( 335, 50 )
		CollapseCat:SetExpanded( 1 )
		CollapseCat:SetLabel( CapAll(string.gsub(k, "_", " ")) )
	

		CollapseCat:SetContents( IconList )
		
		IconList:EnableVerticalScrollbar( true )
		IconList:EnableHorizontal( true )
		IconList:SetAutoSize( true )
		IconList:SetPadding( 4 )
		IconList:SetSpacing(5)
		
		for k2, v2 in pairs(SGS.Brewing[k]) do
			local icon = vgui.Create( "DImageButton", IconList )
			icon:SetMaterial( v2.material )
			icon:SetToolTip( SGS_ToolTip(v2) )
			icon:SetSize(64, 64)
			IconList:AddItem( icon )
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
				RunConsoleCommand("sgs_brew", v2.mname)
				--SGS.brewingmenu:SetVisible(false)
			end
		end
	end
	SGS.brewingmenu:MakePopup()
end

