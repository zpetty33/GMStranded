CreateClientConVar("spp_check", 1, false, true)
CreateClientConVar("spp_admin", 1, false, true)
CreateClientConVar("spp_use", 1, false, true)
CreateClientConVar("spp_edmg", 1, false, true)
CreateClientConVar("spp_pgr", 1, false, true)
CreateClientConVar("spp_awp", 1, false, true)
CreateClientConVar("spp_dpd", 1, false, true)
CreateClientConVar("spp_dae", 0, false, true)
CreateClientConVar("spp_delay", 120, false, true)

function SGS_SPP_Client()

	SPP_ClientMenu = vgui.Create( "DFrame" )
	
	SPP_ClientMenu:ShowCloseButton(true)
	SPP_ClientMenu:SetDraggable(true)
	SPP_ClientMenu:SetSize( 350, 480 )
	SPP_ClientMenu:SetPos( ScrW() / 2 - 175, 70 )
	SPP_ClientMenu:SetTitle( "SPP Client Menu" )
	SPP_ClientMenu:SetVisible(true)
	SPP_ClientMenu:MakePopup()
	
	SPP_ClientMenuForm = vgui.Create( "DPanelList", SPP_ClientMenu)
	SPP_ClientMenuForm:EnableVerticalScrollbar( true )
	SPP_ClientMenuForm:EnableHorizontal( false )
	SPP_ClientMenuForm:SetSize( 340, 450 )
	SPP_ClientMenuForm:SetPos( 5, 25 )
	SPP_ClientMenuForm:SetSpacing( 10 )
	
	
	local label1 = vgui.Create( "DLabel" )
	label1:SetColor(Color(255,255,255,255)) // Color
	label1:SetFont("default")
	label1:SetText("SPP - Client Customization Menu")
	label1:SizeToContents()
	SPP_ClientMenuForm:AddItem( label1 )
	
	local button1 = vgui.Create( "DButton" )
	button1:SetText("Cleanup Props")
	button1:SetConsoleCommand( "spp_cleanupprops" )
	SPP_ClientMenuForm:AddItem( button1 )
	
	local label2 = vgui.Create( "DLabel" )
	label2:SetColor(Color(255,255,255,255)) // Color
	label2:SetFont("default")
	label2:SetText("Friends Panel")
	label2:SizeToContents()
	SPP_ClientMenuForm:AddItem( label2 )
	
	local Players = player.GetAll()
	if(table.Count(Players) == 1) then
		local label3 = vgui.Create( "DLabel" )
		label3:SetColor(Color(255,255,255,255)) // Color
		label3:SetFont("default")
		label3:SetText("No Other Players Are Online")
		label3:SizeToContents()
		SPP_ClientMenuForm:AddItem( label3 )
	else
		for k, ply in pairs(Players) do
			if(ply and ply:IsValid() and ply != LocalPlayer()) then
				local FriendCommand = "spp_friend_"..ply:GetNWString("SPPSteamID")
				if(!LocalPlayer():GetInfo(FriendCommand)) then
					CreateClientConVar(FriendCommand, 0, false, true)
				end
				local checkbox = vgui.Create( "DCheckBoxLabel" )
				checkbox:SetText( ply:Nick() )
				checkbox:SetConVar( FriendCommand )
				SPP_ClientMenuForm:AddItem( checkbox )
			end
		end
		local button2 = vgui.Create( "DButton" )
		button2:SetText("Apply Settings")
		button2:SetConsoleCommand( "spp_applyfriends" )
		SPP_ClientMenuForm:AddItem( button2 )
	end

end



function SGS_SPP_Admin()

	SPP_AdminMenu = vgui.Create( "DFrame" )
	
	SPP_AdminMenu:ShowCloseButton(true)
	SPP_AdminMenu:SetDraggable(true)
	SPP_AdminMenu:SetSize( 350, 480 )
	SPP_AdminMenu:SetPos( ScrW() / 2 - 175, 70 )
	SPP_AdminMenu:SetTitle( "SPP Admin Menu" )
	SPP_AdminMenu:SetVisible(true)
	SPP_AdminMenu:MakePopup()
	
	SPP_AdminMenuForm = vgui.Create( "DPanelList", SPP_AdminMenu)
	SPP_AdminMenuForm:EnableVerticalScrollbar( true )
	SPP_AdminMenuForm:EnableHorizontal( false )
	SPP_AdminMenuForm:SetSize( 340, 450 )
	SPP_AdminMenuForm:SetPos( 5, 25 )
	SPP_AdminMenuForm:SetSpacing( 10 )
	
	
	if(!LocalPlayer():IsAdmin()) then
		local label1 = vgui.Create( "DLabel" )
		label1:SetColor(Color(255,255,255,255)) // Color
		label1:SetFont("default")
		label1:SetText("You are not an admin!")
		label1:SizeToContents()
		SPP_AdminMenuForm:AddItem( label1 )
		return
	end
	
	local label2 = vgui.Create( "DLabel" )
	label2:SetColor(Color(255,255,255,255)) // Color
	label2:SetFont("default")
	label2:SetText("SPP - Admin Customization Menu")
	label2:SizeToContents()
	SPP_AdminMenuForm:AddItem( label2 )
	
	local checkbox1 = vgui.Create( "DCheckBoxLabel" )
	checkbox1:SetText( "Prop Protection" )
	checkbox1:SetConVar( "spp_check" )
	SPP_AdminMenuForm:AddItem( checkbox1 )
	
	local checkbox2 = vgui.Create( "DCheckBoxLabel" )
	checkbox2:SetText( "Admins Can Do Everything" )
	checkbox2:SetConVar( "spp_admin" )
	SPP_AdminMenuForm:AddItem( checkbox2 )
	
	local checkbox3 = vgui.Create( "DCheckBoxLabel" )
	checkbox3:SetText( "Use Protection" )
	checkbox3:SetConVar( "spp_use" )
	SPP_AdminMenuForm:AddItem( checkbox3 )
	
	local checkbox4 = vgui.Create( "DCheckBoxLabel" )
	checkbox4:SetText( "Entity Damage Protection" )
	checkbox4:SetConVar( "spp_edmg" )
	SPP_AdminMenuForm:AddItem( checkbox4 )
	
	local checkbox5 = vgui.Create( "DCheckBoxLabel" )
	checkbox5:SetText( "Physgun Reload Protection" )
	checkbox5:SetConVar( "spp_pgr" )
	SPP_AdminMenuForm:AddItem( checkbox5 )
	
	local checkbox6 = vgui.Create( "DCheckBoxLabel" )
	checkbox6:SetText( "Admins Can Touch World Prop" )
	checkbox6:SetConVar( "spp_awp" )
	SPP_AdminMenuForm:AddItem( checkbox6 )
	
	local checkbox7 = vgui.Create( "DCheckBoxLabel" )
	checkbox7:SetText( "Disconnect Prop Deletion" )
	checkbox7:SetConVar( "spp_dpd" )
	SPP_AdminMenuForm:AddItem( checkbox7 )
	
	local checkbox8 = vgui.Create( "DCheckBoxLabel" )
	checkbox8:SetText( "Delete Admin Entities" )
	checkbox8:SetConVar( "spp_dae" )
	SPP_AdminMenuForm:AddItem( checkbox8 )
	
	local NumSlider = vgui.Create( "DNumSlider" )
	NumSlider:SetText( "Deletion Delay (Seconds)" )
	NumSlider:SetConVar( "spp_delay" )
	NumSlider:SetDecimals( 0 )
	NumSlider:SetMin( 10 )
	NumSlider:SetMax( 500 )
	SPP_AdminMenuForm:AddItem( NumSlider )
	
	local button1 = vgui.Create( "DButton" )
	button1:SetText("Apply Settings")
	button1:SetConsoleCommand( "spp_apply" )
	SPP_AdminMenuForm:AddItem( button1 )
	
	local label3 = vgui.Create( "DLabel" )
	label3:SetColor(Color(255,255,255,255)) // Color
	label3:SetFont("default")
	label3:SetText("Cleanup Props")
	label3:SizeToContents()
	SPP_AdminMenuForm:AddItem( label3 )
	
	for k, ply in pairs(player.GetAll()) do
		if(ply and ply:IsValid()) then
			local button = vgui.Create( "DButton" )
			button:SetText(ply:Nick())
			button:SetConsoleCommand( "spp_cleanupprops", tostring(ply:EntIndex()) )
			SPP_AdminMenuForm:AddItem( button )
		end
	end
	
	local label4 = vgui.Create( "DLabel" )
	label4:SetColor(Color(255,255,255,255)) // Color
	label4:SetFont("default")
	label4:SetText("Other Cleanup Options")
	label4:SizeToContents()
	SPP_AdminMenuForm:AddItem( label4 )
	
	local button2 = vgui.Create( "DButton" )
	button2:SetText("Cleanup Disconnected Players Props")
	button2:SetConsoleCommand( "spp_cdp" )
	SPP_AdminMenuForm:AddItem( button2 )
	
end



