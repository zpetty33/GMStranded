net.Receive("client_opentotemmenu", function(length )

	SGS.totemtype = net.ReadString()
	SGS.totempower = net.ReadInt( 32 )
	SGS.totemenabled = net.ReadBit()
	SGS.totem = net.ReadEntity()
	
	SGS_TotemMenu()

end)

function SGS_TotemMenu()
	
	TotemMenu = vgui.Create( "DFrame" )
	TotemMenu:ShowCloseButton(true)
	TotemMenu:SetDraggable(false)
	TotemMenu:SetSize( 305, 120 )
	TotemMenu:SetTitle( "Totem Menu - " .. Cap(SGS.totemtype) )
	TotemMenu:Center()
	TotemMenu:MakePopup()
	
	PowerLabel = vgui.Create( "DLabel", TotemMenu )
	PowerLabel:SetPos( 5, 35 )
	PowerLabel:SetColor( Color(255,255,255,255) )
	PowerLabel:SetFont( "SGS_HUD2" )
	PowerLabel:SetText( "Current Totem Power: " )
	PowerLabel:SizeToContents()
	
	PowerLabel2 = vgui.Create( "DLabel", TotemMenu )
	PowerLabel2:SetPos( 135, 35 )
	PowerLabel2:SetColor( Color(255,0,0,255) )
	PowerLabel2:SetFont( "SGS_HUD2" )
	PowerLabel2:SetText( SGS.totempower )
	PowerLabel2:SizeToContents()
	
	StatusLabel = vgui.Create( "DLabel", TotemMenu )
	StatusLabel:SetPos( 5, 50 )
	StatusLabel:SetColor( Color(255,255,255,255) )
	StatusLabel:SetFont( "SGS_HUD2" )
	StatusLabel:SetText( "Current Totem Status: " )
	StatusLabel:SizeToContents()
	
	StatusLabel2 = vgui.Create( "DLabel", TotemMenu )
	StatusLabel2:SetPos( 137, 50 )
	local color
	if SGS.totemenabled == 1 then color = Color(0,255,0,255) else color = Color(255,0,0,255) end
	StatusLabel2:SetColor( color )
	StatusLabel2:SetFont( "SGS_HUD2" )
	local status
	if SGS.totemenabled == 1 then status = "ONLINE" else status = "OFFLINE" end
	StatusLabel2:SetText( status )
	StatusLabel2:SizeToContents()
	
	AddBTN1 = vgui.Create( "DButton", TotemMenu )
	AddBTN1:SetSize( 70, 20 )
	AddBTN1:SetPos( 5, 70 )
	AddBTN1:SetText( "Add Sapphire" )
	AddBTN1.DoClick = function( self )
		RunConsoleCommand( "sgs_fueltotem", "sapphire", SGS.totem:EntIndex() )
		TotemMenu:Close()
	end
	
	AddBTN2 = vgui.Create( "DButton", TotemMenu )
	AddBTN2:SetSize( 70, 20 )
	AddBTN2:SetPos( 80, 70 )
	AddBTN2:SetText( "Add Emerald" )
	AddBTN2.DoClick = function( self )
		RunConsoleCommand( "sgs_fueltotem", "emerald", SGS.totem:EntIndex() )
		TotemMenu:Close()
	end
	
	AddBTN3 = vgui.Create( "DButton", TotemMenu )
	AddBTN3:SetSize( 70, 20 )
	AddBTN3:SetPos( 155, 70 )
	AddBTN3:SetText( "Add Ruby" )
	AddBTN3.DoClick = function( self )
		RunConsoleCommand( "sgs_fueltotem", "ruby", SGS.totem:EntIndex() )
		TotemMenu:Close()
	end
	
	AddBTN4 = vgui.Create( "DButton", TotemMenu )
	AddBTN4:SetSize( 70, 20 )
	AddBTN4:SetPos( 230, 70 )
	AddBTN4:SetText( "Add Diamond" )
	AddBTN4.DoClick = function( self )
		RunConsoleCommand( "sgs_fueltotem", "diamond", SGS.totem:EntIndex() )
		TotemMenu:Close()
	end
	
	EnableBTN = vgui.Create( "DButton", TotemMenu )
	EnableBTN:SetSize( 70, 20 )
	EnableBTN:SetPos( 80, 95 )
	EnableBTN:SetText( "ENABLE" )
	EnableBTN.DoClick = function( self )
		RunConsoleCommand( "sgs_enabletotem", SGS.totem:EntIndex() )
		TotemMenu:Close()
	end
	
	DisableBTN = vgui.Create( "DButton", TotemMenu )
	DisableBTN:SetSize( 70, 20 )
	DisableBTN:SetPos( 155, 95 )
	DisableBTN:SetText( "DISABLE" )
	DisableBTN.DoClick = function( self )
		RunConsoleCommand( "sgs_disabletotem", SGS.totem:EntIndex() )
		TotemMenu:Close()
	end
	
	
		
	TotemMenu:SetVisible(true)

end
