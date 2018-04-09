function SGS_PetHouseMenu()

	local PetHouseMenu = vgui.Create( "DFrame" )
	PetHouseMenu:SetTitle("Pet House")
	PetHouseMenu:SetSize( 348, 378 )
	PetHouseMenu:Center()
	PetHouseMenu:MakePopup()
	
	SGS.PetContainer = vgui.Create( "DIconLayout", PetHouseMenu)
	SGS.PetContainer:SetSize( 340, 340 )
	SGS.PetContainer:SetPos( 4, 34 )
	SGS.PetContainer:SetSpaceY( 5 )
	SGS.PetContainer:SetSpaceX( 5 )
	
	for k, v in pairs( SGS.pethouse ) do
		local PetButton = vgui.Create( "SpawnIcon" )
		PetButton:SetModel( v.model )
		PetButton:SetSize( 64, 64 )
		PetButton:SetToolTip( SGS_PetTooltip( v ) )
		SGS.PetContainer:Add( PetButton )
		PetButton.DoClick = function ( PetButton )
			surface.PlaySound( "ui/buttonclickrelease.wav" )
			RunConsoleCommand("sgs_petfromcage", tostring(k))
			PetHouseMenu:Close()
		end
	end

end