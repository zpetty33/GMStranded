function SGS_SignMenu()
	
	SignMenu = vgui.Create( "DFrame" )
	SignMenu:ShowCloseButton(true)
	SignMenu:SetDraggable(false)
	SignMenu:SetSize( 150, 180 )
	SignMenu:SetTitle( "Set Sign Text" )
	SignMenu:SetPos( ScrW() / 2 - 75, ScrH() / 2 - 75 )
	SignMenu:MakePopup()
	
	local line1 = vgui.Create("DTextEntry", SignMenu)
	line1:SetSize( 130, 20 )
	line1:SetPos( 10, 40 )

	local line2 = vgui.Create("DTextEntry", SignMenu)
	line2:SetSize( 130, 20 )
	line2:SetPos( 10, 65 )
	
	local line3 = vgui.Create("DTextEntry", SignMenu)
	line3:SetSize( 130, 20 )
	line3:SetPos( 10, 90 )
	
	local line4 = vgui.Create("DTextEntry", SignMenu)
	line4:SetSize( 130, 20 )
	line4:SetPos( 10, 115 )
	
	local line5 = vgui.Create("DTextEntry", SignMenu)
	line5:SetSize( 130, 20 )
	line5:SetPos( 10, 140 )
	
	local button = vgui.Create( "DButton", SignMenu )
	button:SetSize( 35, 15 )
	button:SetPos( 10, 165 )
	button:SetText( "Set" )
	button.DoClick = function( button )
		RunConsoleCommand("sgs_setsign", line1:GetValue(), line2:GetValue(), line3:GetValue(), line4:GetValue(), line5:GetValue(), LocalPlayer():GetNetworkedInt( "sign", 0 ))
		SignMenu:SetVisible(false)
	end
		
	SignMenu:SetVisible(true)

end
