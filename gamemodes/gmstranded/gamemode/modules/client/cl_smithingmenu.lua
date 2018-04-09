function SGS_SmithingMenu()

	SGS.smithingmenu = vgui.Create( "DFrame" )
	SGS.smithingmenu:ShowCloseButton(true)
	SGS.smithingmenu:SetDraggable(false)
	SGS.smithingmenu:SetSize( 320,370 )
	SGS.smithingmenu:SetPos( ScrW() / 2 - 160, ScrH() / 2 - 170 )
	SGS.smithingmenu:SetTitle( "Crafting Menu" )

	local CatList = vgui.Create( "DPanelList", SGS.smithingmenu)

	CatList:EnableVerticalScrollbar( true )
	CatList:EnableHorizontal( false )
	CatList:SetSize( 300, 330 )
	CatList:SetPos( 10, 30 )
	CatList:SetPadding( 3 )
	CatList:SetSpacing( 3 )
	
	
	
	for k, v in pairs( SGS.Tools ) do
		if k == "main" then continue end
		if k == "construction" then continue end
		if k == "enchanted" then continue end
		if k == "woodcutting-sapphire" then continue end
		if k == "woodcutting-emerald" then continue end
		if k == "woodcutting-ruby" then continue end
		if k == "woodcutting-diamond" then continue end
		if k == "mining-sapphire" then continue end
		if k == "mining-emerald" then continue end
		if k == "mining-ruby" then continue end
		if k == "mining-diamond" then continue end
		
		local IconList = vgui.Create( "DIconLayout")
		local CollapseCat = vgui.Create( "DCollapsibleCategory" )
		CatList:AddItem(CollapseCat)
		
		CollapseCat:SetSize( 335, 50 )
		CollapseCat:SetExpanded( 1 )
		CollapseCat:SetLabel( Cap(k) .. " Tools" )
	

		CollapseCat:SetContents( IconList )

		IconList:SetSpaceY( 4 )
		IconList:SetSpaceX( 4 )

		
		for k2, v2 in pairs(SGS.Tools[k]) do
			local icon = vgui.Create( "DImageButton", IconList )
			icon:SetMaterial( v2.icon )
			icon:SetToolTip( SGS_ToolTip(v2) )
			icon:SetSize( 64, 64 )
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
				RunConsoleCommand("sgs_smith", v2.entity)
				--SGS.smithingmenu:SetVisible(false)
			end
		end
	end
	SGS.smithingmenu:MakePopup()
end

