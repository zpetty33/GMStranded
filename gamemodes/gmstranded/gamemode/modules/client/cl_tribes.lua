GM.Tribes = GM.Tribes or {}
GM.Tribes.tblTribes = {}
local PlayerMeta = FindMetaTable( "Player" )

net.Receive( "tribes_sv_network", function( l )
	if not LocalPlayer():GetInitialized() == INITSTATE_OK then return end
	if net.ReadBit() == 1 then
		GAMEMODE.Tribes.tblTribes = net.ReadTable()
		GAMEMODE.Tribes:SetUpTeams()
	else
		local t_id = net.ReadInt( 16 )
		local tbl = net.ReadTable()
		if not tbl.delete then
			GAMEMODE.Tribes.tblTribes[ t_id ] = tbl
			GAMEMODE.Tribes:SetUpTeam( t_id, GAMEMODE.Tribes.tblTribes[ t_id ] )
		else
			GAMEMODE.Tribes.tblTribes[ t_id ] = nil
		end
	end
end )

net.Receive( "tribes_sv_networkpart", function( l )
	if not LocalPlayer():GetInitialized() == INITSTATE_OK then return end
	local t_id 		= net.ReadUInt( 8 )
	local to_edit 	= net.ReadUInt( 8 )
	if to_edit == 0 then
		local new_exp = net.ReadUInt(32)
		GAMEMODE.Tribes.tblTribes[ t_id ].exp = new_exp
	elseif to_edit == 1 then
		local new_exp = net.ReadUInt(32)
		local ply = net.ReadEntity()
		if not GAMEMODE.Tribes.tblTribes[ t_id ].expcontributions then GAMEMODE.Tribes.tblTribes[ t_id ].expcontributions = {} end
		GAMEMODE.Tribes.tblTribes[ t_id ].expcontributions[ ply:SteamID() ] = new_exp
	end

end )

net.Receive( "tribes_sv_openmenu", function( l )
	GAMEMODE.Tribes:ShowTribeMenu( _, _, _ )
end )

function GM.Tribes:SetUpTeams()
	for k, v in pairs( self.tblTribes ) do
		team.SetUp( k, v.tr_name, v.color )
	end
end

function GM.Tribes:SetUpTeam( id, tbl )
	team.SetUp( id, tbl.tr_name, tbl.color )
end

function PlayerMeta:GetTribe()
	if self:Team() ~= 10000 then
		return GAMEMODE.Tribes.tblTribes[ self:Team() ]
	end
	return nil
end

function GM.Tribes:CreateTribe( pl, tr_name, tr_color, perm_type, password )
	local tbl = {
		tr_name		=	tr_name,
		color		=	tr_color,
		perms		=	{ ptype = perm_type, password = password }
	}
	net.Start( "tribes_cl_createtribe" )
		net.WriteTable( tbl )
	net.SendToServer()
end

function GM.Tribes:JoinTribe( t_id, password )
	if not self:IsValid( t_id ) then return end
	net.Start( "tribes_cl_jointribe" )
		net.WriteInt( t_id, 16 )
		net.WriteString( password )
	net.SendToServer()
end

function GM.Tribes:ConJoinTribe( ply, com, args )
	local t_id = args[1]
	local pass = args[2] or ""
	self:JoinTribe( t_id, pass )
end
concommand.Add( "gms_jointribe", function( ... ) GAMEMODE.Tribes:ConJoinTribe( ... ) end )

function GM.Tribes:LeaveTribe()
	net.Start( "tribes_cl_jointribe" )
		net.WriteInt( 10000, 16 ) --Leave Current Tribe
		net.WriteString( "" )
	net.SendToServer()
end

function GM.Tribes:ConLeaveTribe( ply, com, args )
	self:LeaveTribe()
end
concommand.Add( "gms_leavetribe", function( ... ) GAMEMODE.Tribes:ConLeaveTribe( ... ) end )

function GM.Tribes:ConDisbandTribe( ply, com, args )
	self:DisbandTribe()
end
concommand.Add( "gms_disbandtribe", function( ... ) GAMEMODE.Tribes:ConDisbandTribe( ... ) end )

function GM.Tribes:DisbandTribe()
	Derma_Query( "You are about to disband your tribe... are you sure?", "Confirm Tribe Disband", 
	"Yes", 
	function()
		net.Start( "tribes_cl_jointribe" )
			net.WriteInt( 10001, 16 ) --Disband Current Tribe
			net.WriteString( "" )
		net.SendToServer()
	end, 
	"No", 
	function() 
	
	end )
end

function GM.Tribes:AdminDisbandTribe( t_id )
	Derma_Query( "Are you sure you would like to delete this tribe?", "Zonfire Prevention Check", 
	"Yes", 
	function()
		net.Start( "tribes_cl_admindisband" )
			net.WriteInt( t_id, 16 ) --Disband Selected Tribe
		net.SendToServer()
	end, 
	"No", 
	function() 
	
	end )
end

function GM.Tribes:SendInvitation( inv_ply )
	if not IsValid( inv_ply ) then return end
	local t_id = self:GetPlayersTribe( LocalPlayer() )
	net.Start( "tribes_cl_sendinvitation" )
		net.WriteInt( t_id, 16 )
		net.WriteEntity( inv_ply )
	net.SendToServer( inv_ply )
end

function GM.Tribes:KickFromTribe( p_id )
	local t_id = self:GetPlayersTribe( LocalPlayer() )
	if not self:IsValid( t_id ) then return end
	local tbl = { t_id = t_id, p_id = p_id }
	net.Start( "tribes_cl_kickplayer" )
		net.WriteTable( tbl )
	net.SendToServer()
end


--[[
Tribe Menu
]]

surface.CreateFont("TribeMenu1", {
	font = "Courier New", 
	size = 14, 
	weight = 600, 
	blursize = 0, 
	scanlines = 0, 
	antialias = false, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = true, 
	additive = false, 
	outline = false, 
})

surface.CreateFont("TribeMenu2", {
	font = "Arial", 
	size = 36, 
	weight = 800, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = true, 
	additive = false, 
	outline = false, 
})

surface.CreateFont("TribeMenu3", {
	font = "Arial", 
	size = 24, 
	weight = 800, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = true, 
	additive = false, 
	outline = false, 
})

surface.CreateFont("TribeMenu4", {
	font = "Tahoma", 
	size = 16, 
	weight = 800, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = true, 
	additive = false, 
	outline = false, 
})

surface.CreateFont("TribeMenu5", {
	font = "Arial", 
	size = 18, 
	weight = 800, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = true, 
	additive = false, 
	outline = false, 
})

function GM.Tribes:ShowTribeMenu( ply, com, args )
	self.tribe_menu = vgui.Create( "tribe_menu" )
	self.tribe_menu:MakePopup()
end
concommand.Add( "gms_tribemenu", function( ... ) GAMEMODE.Tribes:ShowTribeMenu( ... ) end )

local PANEL = {}

function PANEL:Init()
	if not GAMEMODE.Tribes:PlayerInTribe( LocalPlayer() ) then
		self:SetSize( 800, 600 )
	else
		if LocalPlayer():GetTribe().level == 0 then
			self:SetSize( 800, 600 )
		else
			self:SetSize( 1000, 600 )
		end
	end
    self:Center()
	self:DrawFrame()
	self:SetTitle("")
	self:SetDraggable( false )
end

function PANEL:DrawFrame()
	self.selected = 0
	local t_panel = vgui.Create( "DPanel", self )
	t_panel:SetHeight( 38 )
	t_panel:Dock( TOP )
	t_panel:DockMargin( 4, 4, 4, 4 )
	t_panel.Paint = function()
		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect( 0, 0, t_panel:GetWide(), t_panel:GetTall() )
	end
	
	if ( GAMEMODE.Tribes:PlayerInTribe( LocalPlayer() ) ) and LocalPlayer():GetTribe().level > 0 then
		local tr_panel = vgui.Create( "DScrollPanel", self )
		tr_panel:SetWidth( 200 )
		tr_panel:Dock( RIGHT )
		tr_panel:DockMargin( 4, 0, 4, 4 )
		tr_panel.Paint = function()
			local tr_lvl = GAMEMODE.Tribes:GetTribeLevel( LocalPlayer() )
			local inner_bar_max = tr_panel:GetWide() - 24
			local cur_exp = GAMEMODE.Tribes:GetExp( GAMEMODE.Tribes:GetPlayersTribe( LocalPlayer() ) )
			local next_level_exp = GAMEMODE.Tribes.ExpList[ tr_lvl + 1 ]
			local cur_level_exp = GAMEMODE.Tribes.ExpList[ tr_lvl ]
			local width = ( ( cur_exp - cur_level_exp ) / ( next_level_exp - cur_level_exp) ) * inner_bar_max
			
			surface.SetDrawColor( 50, 50, 50, 255 )
			surface.DrawRect( 0, 0, tr_panel:GetWide(), tr_panel:GetTall() )
			draw.DrawText("Tribe Information", "TribeMenu3", tr_panel:GetWide() / 2, 35, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			draw.DrawText("Tribe Level:", "TribeMenu1", 10, 70, Color(255,255,255,255), TEXT_ALIGN_LEFT)
			draw.DrawText(tr_lvl, "TribeMenu1", 110, 70, Color(50,255,50,255), TEXT_ALIGN_LEFT)
			surface.SetDrawColor( 200, 50, 50, 180 )
			draw.RoundedBox( 4, 10, 90, tr_panel:GetWide() - 20, 16, Color(150, 150, 150, 180) )
			if width <= 8 then width = 8 end
			draw.RoundedBox( 4, 12, 92, width, 12, Color(240, 50, 50, 210) )			
			draw.DrawText("Next Level:", "TribeMenu1", 30, 108, Color(255,255,255,255), TEXT_ALIGN_LEFT)
			draw.DrawText(next_level_exp, "TribeMenu1", 120, 108, Color(255,255,255,255), TEXT_ALIGN_LEFT)	
			draw.DrawText(cur_exp, "TribeMenu1", tr_panel:GetWide() / 2, 90, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			
			draw.DrawText("Tribe Admins", "TribeMenu3", tr_panel:GetWide() / 2, 150, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			draw.DrawText("Tribe Members", "TribeMenu3", tr_panel:GetWide() / 2, 290, Color(255,255,255,255), TEXT_ALIGN_CENTER)
		end
		
		local listadmins = vgui.Create("DScrollPanel", tr_panel)
		listadmins:SetSize( tr_panel:GetWide() - 20, 100 )
		listadmins:SetPos( 10, 180 )
		listadmins.Paint = function()
			surface.SetDrawColor( 80, 80, 80, 210 )
			surface.DrawRect( 0, 0, tr_panel:GetWide(), tr_panel:GetTall() )
		end
		for k, v in pairs( LocalPlayer():GetTribe().admins ) do
			local l = vgui.Create( "DPanel", listadmins )
			l:Dock(TOP)
			l:DockMargin( 4, 4, 4, 0 )
			l:SetHeight( 20 )
			l.Paint = function()
				surface.SetDrawColor( 60, 60, 60, 210 )
				surface.DrawRect( 0, 0, l:GetWide(), l:GetTall() )
				draw.DrawText(v, "TribeMenu4", l:GetWide() / 2, 2, Color(210,210,210,255), TEXT_ALIGN_CENTER)
			end
		end
		
		local listmembers = vgui.Create("DScrollPanel", tr_panel)
		listmembers:SetSize( tr_panel:GetWide() - 20, 187 )
		listmembers:SetPos( 10, 320 )
		listmembers.Paint = function()
			surface.SetDrawColor( 80, 80, 80, 210 )
			surface.DrawRect( 0, 0, tr_panel:GetWide(), tr_panel:GetTall() )
		end
		for k, v in pairs( LocalPlayer():GetTribe().members ) do
			local l = vgui.Create( "DPanel", listmembers )
			l:Dock(TOP)
			l:DockMargin( 4, 4, 4, 0 )
			l:SetHeight( 20 )
			l.Paint = function()
				surface.SetDrawColor( 60, 60, 60, 210 )
				surface.DrawRect( 0, 0, l:GetWide(), l:GetTall() )
				draw.DrawText(v, "TribeMenu4", l:GetWide() / 2, 2, Color(210,210,210,255), TEXT_ALIGN_CENTER)
			end
			if not LocalPlayer():GetTribe().expcontributions then LocalPlayer():GetTribe().expcontributions = {} end
			local contribution = 0
			if LocalPlayer():GetTribe().expcontributions[k] then
				contribution = LocalPlayer():GetTribe().expcontributions[k]
			end
			l:SetTooltip("Experience Contribution: " .. contribution)
		end
	end
	
	
	local btn_create = vgui.Create( "tribe_button", t_panel )
	btn_create:SetWide( 130 )
	btn_create:SetText( "CREATE TRIBE" )
	btn_create:DockMargin( 4, 4, 0, 4 )
	btn_create:Dock( LEFT )
	if GAMEMODE.Tribes:PlayerOwnsTribe( LocalPlayer() ) or GAMEMODE.Tribes:PlayerInTribe( LocalPlayer() ) then
		btn_create:Remove()
	end
	btn_create.OnMousePressed = function()
		if not btn_create.enabled then return end
		GAMEMODE.Tribes.create_tribe = vgui.Create( "tribe_create" )
		GAMEMODE.Tribes.create_tribe:MakePopup()
	end
	
	local btn_leave = vgui.Create( "tribe_button", t_panel )
	btn_leave:SetWide( 130 )
	btn_leave:SetText( "LEAVE TRIBE" )
	btn_leave:DockMargin( 0, 4, 4, 4 )
	btn_leave:Dock( RIGHT )
	if not GAMEMODE.Tribes:PlayerInTribe( LocalPlayer() ) then
		btn_leave:Remove()
	end
	if GAMEMODE.Tribes:PlayerOwnsTribe( LocalPlayer() ) then
		btn_leave:Remove()
	end
	btn_leave.OnMousePressed = function()
		if not btn_leave.enabled then return end
		GAMEMODE.Tribes:LeaveTribe()
		self:Remove()
	end
	
	local btn_disband = vgui.Create( "tribe_button", t_panel )
	btn_disband:SetWide( 130 )
	btn_disband:SetText( "DISBAND TRIBE" )
	btn_disband:DockMargin( 0, 4, 4, 4 )
	btn_disband:Dock( RIGHT )
	if not GAMEMODE.Tribes:PlayerOwnsTribe( LocalPlayer() ) then
		btn_disband:Remove()
		btn_disband:SetTooltip( "You are not the leader of a tribe." )
	end
	btn_disband.OnMousePressed = function()
		if not btn_disband.enabled then return end
		GAMEMODE.Tribes:DisbandTribe()
		self:Remove()
	end
	
	local btn_manage = vgui.Create( "tribe_button", t_panel )
	btn_manage:SetWide( 130 )
	btn_manage:SetText( "MANAGE TRIBE" )
	btn_manage:DockMargin( 0, 4, 4, 4 )
	btn_manage:Dock( RIGHT )
	btn_manage.OnMousePressed = function()
		GAMEMODE.Tribes.send_invite = vgui.Create( "tribe_managetribe" )
		GAMEMODE.Tribes.send_invite:MakePopup()		
	end
	if not GAMEMODE.Tribes:PlayerOwnsTribe( LocalPlayer() ) then
		btn_manage:Remove()
	end
	
	local btn_achievements = vgui.Create( "tribe_button", t_panel )
	btn_achievements:SetWide( 130 )
	btn_achievements:SetText( "TRIBE PERKS" )
	btn_achievements:DockMargin( 0, 4, 4, 4 )
	btn_achievements:Dock( RIGHT )
	btn_achievements.OnMousePressed = function()
		if not btn_achievements.enabled then return end
		GAMEMODE.Tribes.send_invite = vgui.Create( "tribe_perksmenu" )
		GAMEMODE.Tribes.send_invite:MakePopup()		
	end
	if not GAMEMODE.Tribes:PlayerInTribe( LocalPlayer() ) then
		btn_achievements:Remove()
	else
		if LocalPlayer():GetTribe().level == 0 then
			btn_achievements:Disable( true )
			btn_achievements:SetTooltip( "Level 0 tribes are not eligible for perks.\nPlease upgrade your tribe to enable this menu." )
		end
	end
	
	local r_panel = vgui.Create( "DPanel", self )
	r_panel:Dock( FILL )
	r_panel:DockMargin( 0, 0, 4, 4 )
	r_panel.Paint = function()
		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect( 0, 0, r_panel:GetWide(), r_panel:GetTall() )
		if not ( self.selected == 0 ) then
			local sel_tribe = GAMEMODE.Tribes.tblTribes[ self.selected ]
			draw.DrawText(sel_tribe.tr_name, "TribeMenu2", r_panel:GetWide() / 2, 15, sel_tribe.color, TEXT_ALIGN_CENTER)
			draw.DrawText("Tribal Leader: ", "TribeMenu3", 10, 65, Color(180,180,180,255), TEXT_ALIGN_LEFT)
			draw.DrawText("Tribe Level: ", "TribeMenu3", 10, 90, Color(180,180,180,255), TEXT_ALIGN_LEFT)
			draw.DrawText("Joinability: ", "TribeMenu3", 10, 115, Color(180,180,180,255), TEXT_ALIGN_LEFT)
			draw.DrawText("Members: ", "TribeMenu3", 10, 150, Color(180,180,180,255), TEXT_ALIGN_LEFT)
			
			
			draw.DrawText(sel_tribe.pl_name, "TribeMenu3", 150, 65, Color(255,255,255,255), TEXT_ALIGN_LEFT)
			draw.DrawText(sel_tribe.level, "TribeMenu3", 130, 90, Color(255,255,255,255), TEXT_ALIGN_LEFT)
			if sel_tribe.perms.ptype == 0 then p_text = "Open" end
			if sel_tribe.perms.ptype == 1 then p_text = "Passworded" end
			if sel_tribe.perms.ptype == 2 then p_text = "Invite Only" end
			draw.DrawText(p_text, "TribeMenu3", 120, 115, Color(255,255,255,255), TEXT_ALIGN_LEFT)
		end
	end
	
	
	local l_panel = vgui.Create( "DScrollPanel", self )
	l_panel:SetWidth( 300 )
	l_panel:Dock( LEFT )
	l_panel:DockMargin( 4, 0, 4, 4 )
	l_panel.Paint = function()
		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect( 0, 0, l_panel:GetWide(), l_panel:GetTall() )
	end
	for k, v in pairs(GAMEMODE.Tribes.tblTribes) do
		local tribe_card = vgui.Create( "DPanel", l_panel )
		tribe_card:SetHeight( 60 )
		tribe_card.Paint = function()
			if not ( self.selected == k ) then
				surface.SetDrawColor( 80, 80, 80, 210 )
			else
				surface.SetDrawColor( 80, 110, 80, 210 )
			end
			surface.DrawRect( 0, 0, tribe_card:GetWide(), tribe_card:GetTall() )
			draw.DrawText("Tribe: ", "TribeMenu1", 2, 2, Color(210,210,210,255), TEXT_ALIGN_LEFT)
			draw.DrawText( v.tr_name, "TribeMenu1", 52, 2, v.color, TEXT_ALIGN_LEFT)
			draw.DrawText("Leader: ", "TribeMenu1", 2, 14, Color(210,210,210,255), TEXT_ALIGN_LEFT)
			draw.DrawText( string.Left(v.pl_name, 20), "TribeMenu1", 60, 14, Color(210,210,210,255), TEXT_ALIGN_LEFT)
			draw.DrawText("Members: ", "TribeMenu1", 2, 26, Color(210,210,210,255), TEXT_ALIGN_LEFT)
			draw.DrawText( tostring(table.Count( v.members )), "TribeMenu1", 68, 26, Color(210,210,210,255), TEXT_ALIGN_LEFT)
			draw.DrawText("Level: ", "TribeMenu1", 2, 38, Color(210,210,210,255), TEXT_ALIGN_LEFT)
			draw.DrawText( v.level, "TribeMenu1", 50, 38, Color(210,210,210,255), TEXT_ALIGN_LEFT)
		end
		tribe_card.OnMousePressed = function()
			self.selected = k
			if IsValid(self.listmembers) then self.listmembers:Remove() end
			self.listmembers = vgui.Create("DScrollPanel", r_panel)
			self.listmembers:SetSize( r_panel:GetWide() - 20, 200 )
			self.listmembers:SetPos( 10, 180 )
			self.listmembers.Paint = function()
				surface.SetDrawColor( 80, 80, 80, 210 )
				surface.DrawRect( 0, 0, r_panel:GetWide(), r_panel:GetTall() )
			end
			for k, v in pairs( GAMEMODE.Tribes.tblTribes[ self.selected ].members ) do
				local l = vgui.Create( "DPanel", self.listmembers )
				l:Dock(TOP)
				l:DockMargin( 4, 4, 4, 0 )
				l:SetHeight( 20 )
				l.Paint = function()
					surface.SetDrawColor( 60, 60, 60, 210 )
					surface.DrawRect( 0, 0, l:GetWide(), l:GetTall() )
					draw.DrawText(v, "TribeMenu4", l:GetWide() / 2, 2, Color(210,210,210,255), TEXT_ALIGN_CENTER)
				end
			end
			if IsValid(self.joinbutton) then self.joinbutton:Remove() end
			self.joinbutton = vgui.Create( "tribe_button", r_panel )
			self.joinbutton:SetSize( 100, 30 )
			self.joinbutton:SetPos( 10, r_panel:GetTall() - 40 )
			self.joinbutton:SetText( "JOIN" )
			self.joinbutton.OnMousePressed = function()
				if GAMEMODE.Tribes.tblTribes[self.selected].perms.ptype ~= 1 then
					GAMEMODE.Tribes:JoinTribe( self.selected, "" )
					self:Remove()
				else
					GAMEMODE.Tribes.selTribe = self.selected
					GAMEMODE.Tribes.password_input = vgui.Create( "tribe_password" )
					GAMEMODE.Tribes.password_input:MakePopup()
				end
			end
			if IsValid(self.arbutton) then self.arbutton:Remove() end
			self.arbutton = vgui.Create( "tribe_button", r_panel )
			self.arbutton:SetSize( 120, 30 )
			self.arbutton:SetPos( r_panel:GetWide() - 130, r_panel:GetTall() - 40 )
			self.arbutton:SetText( "(Admin) Remove" )
			self.arbutton.OnMousePressed = function()
				GAMEMODE.Tribes:AdminDisbandTribe( self.selected )
				self:Remove()
			end
		end
		tribe_card:Dock( TOP )
		tribe_card:DockMargin( 2, 2, 2, 0 )
	end
end
vgui.Register("tribe_menu", PANEL, "DFrame")



local PANEL = {}
function PANEL:Init()
	self:SetSize( 300, 110 )
    self:Center()
	self:DrawFrame()
	self:SetTitle("Tribe Password Verification")
	self:SetDraggable( false )
	self:SetBackgroundBlur( true )
end
function PANEL:DrawFrame()
	local body_panel = vgui.Create( "DPanel", self )
	body_panel:Dock( FILL )
	body_panel.Paint = function()
		surface.SetDrawColor( 60, 60, 60, 210 )
		surface.DrawRect( 0, 0, body_panel:GetWide(), body_panel:GetTall() )
		draw.DrawText("Enter the Tribe Password", "TribeMenu1", body_panel:GetWide() / 2, 6, Color(210,210,210,255), TEXT_ALIGN_CENTER)
	end
	local txt_password = vgui.Create( "DTextEntry", self )
	txt_password:SetPos( 10, 50 )
	txt_password:SetSize( 280, 20 )
	joinbutton = vgui.Create("DPanel", body_panel)
	joinbutton:SetSize( 80, 25 )
	joinbutton:SetPos( body_panel:GetWide() / 2 - 26, 45 )
	joinbutton.Paint = function()
		surface.SetDrawColor( 120, 120, 120, 210 )
		surface.DrawRect( 0, 0, joinbutton:GetWide(), joinbutton:GetTall() )	
		draw.DrawText("Submit", "TribeMenu5", joinbutton:GetWide() / 2, 4, Color(210,210,210,255), TEXT_ALIGN_CENTER)
	end
	joinbutton.OnMousePressed = function()
		self:Remove()
		GAMEMODE.Tribes.tribe_menu:Remove()
		GAMEMODE.Tribes:JoinTribe( GAMEMODE.Tribes.selTribe, txt_password:GetValue() )
	end
end
vgui.Register("tribe_password", PANEL, "DFrame")



local BUTTON = {}
function BUTTON:Init()
	self:SetTall( 30 )
	self.btxt = ""
	self.enabled = true
end
function BUTTON:Paint()
	if self.enabled then
		surface.SetDrawColor( 100, 100, 100, 210 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
		draw.DrawText(self.btxt, "TribeMenu5", self:GetWide() / 2, 6, Color(220,220,220,255), TEXT_ALIGN_CENTER)
	else
		surface.SetDrawColor( 65, 65, 65, 210 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
		draw.DrawText(self.btxt, "TribeMenu5", self:GetWide() / 2, 6, Color(150,150,150,255), TEXT_ALIGN_CENTER)
	end
end
function BUTTON:SetText( txt )
	self.btxt = txt
end
function BUTTON:Disable( bool )
	if bool then
		self.enabled = false
	else
		self.enabled = true
	end
end
vgui.Register("tribe_button", BUTTON, "DPanel")


local PANEL = {}
function PANEL:Init()
	self:SetSize( 510, 250 )
    self:Center()
	self:SetTitle("Tribal Creation Menu")
	self:SetDraggable( false )
	self:SetBackgroundBlur( true )
	self:DrawFrame()
	self.showpass = false
	self.perms = 0
end
function PANEL:DrawFrame()
	local body_panel = vgui.Create( "DPanel", self )
	body_panel:Dock( FILL )
	body_panel.Paint = function()
		surface.SetDrawColor( 60, 60, 60, 210 )
		surface.DrawRect( 0, 0, body_panel:GetWide(), body_panel:GetTall() )
		draw.DrawText("Create Your Tribe", "TribeMenu1", body_panel:GetWide() / 2, 6, Color(210,210,210,255), TEXT_ALIGN_CENTER)
		draw.DrawText("Name Your Tribe:", "TribeMenu4", 10, 30, Color(210,210,210,255), TEXT_ALIGN_LEFT)
		draw.DrawText("Pick A Color:", "TribeMenu4", 210, 30, Color(210,210,210,255), TEXT_ALIGN_LEFT)
		draw.DrawText("Set Join Permissions:", "TribeMenu4", 10, 80, Color(210,210,210,255), TEXT_ALIGN_LEFT)
		draw.DrawText(": Open Joining", "TribeMenu4", 25, 98, Color(240,120,120,255), TEXT_ALIGN_LEFT)
		draw.DrawText(": Passworded", "TribeMenu4", 25, 118, Color(240,120,120,255), TEXT_ALIGN_LEFT)
		draw.DrawText(": Invite Only", "TribeMenu4", 25, 138, Color(240,120,120,255), TEXT_ALIGN_LEFT)
		if self.showpass then
			draw.DrawText("Password:", "TribeMenu4", 10, 160, Color(210,210,210,255), TEXT_ALIGN_LEFT)
		end
	end
	local txt_name = vgui.Create( "DTextEntry", body_panel )
	txt_name:SetPos( 8, 50 )
	txt_name:SetSize( 180, 20 )
	
	self.chk_open = vgui.Create( "DCheckBox", body_panel )
	self.chk_open:SetPos( 8, 100 )
	self.chk_open:SetValue(1)
	self.chk_open.DoClick = function()
		if self.chk_open:GetChecked() == false then
			self.chk_open:SetValue( 1 )
			self.chk_pass:SetValue( 0 )
			self.chk_invite:SetValue( 0 )
			self.HidePassField()
			self.perms = 0
		end
	end
	
	self.chk_pass = vgui.Create( "DCheckBox", body_panel )
	self.chk_pass:SetPos( 8, 120 )
	self.chk_pass:SetValue(0)
	self.chk_pass.DoClick = function()
		if self.chk_pass:GetChecked() == false then
			self.chk_open:SetValue( 0 )
			self.chk_pass:SetValue( 1 )
			self.chk_invite:SetValue( 0 )
			self.ShowPassField()
			self.perms = 1
		end
	end
	
	self.chk_invite = vgui.Create( "DCheckBox", body_panel )
	self.chk_invite:SetPos( 8, 140 )
	self.chk_invite:SetValue(0)
	self.chk_invite.DoClick = function()
		if self.chk_invite:GetChecked() == false then
			self.chk_open:SetValue( 0 )
			self.chk_pass:SetValue( 0 )
			self.chk_invite:SetValue( 1 )
			self.HidePassField()
			self.perms = 2
		end
	end
	
	function self.ShowPassField()
		self.txt_pass = vgui.Create( "DTextEntry", body_panel )
		self.txt_pass:SetPos( 8, 180 )
		self.txt_pass:SetSize( 180, 20 )
		self.showpass = true
	end
	
	function self.HidePassField()
		if IsValid(self.txt_pass) then self.txt_pass:Remove() end
		self.showpass = false
	end
	
	local color_mixer = vgui.Create( "DColorMixer", body_panel )
	color_mixer:SetAlphaBar( false )
	color_mixer:SetWangs( false )
	color_mixer:SetColor( Color( 255, 0, 255 ) )
	color_mixer:SetPos( 210, 50 )
	color_mixer:SetSize( 200, 160 )
	
	local create_button = vgui.Create( "tribe_button", body_panel )
	create_button:SetWide( 80 )
	create_button:SetText( "CREATE" )
	create_button:SetPos( self:GetWide() - 95, self:GetTall() - 70 )
	create_button.OnMousePressed = function()
		if txt_name:GetValue() == "" then
			Derma_Message( "Please enter a name for your tribe!", "Invalid Options", "OK" )
			return
		end
		if IsValid(self.txt_pass) and self.txt_pass:GetValue() == "" and self.perms == 1 then
			Derma_Message( "Please enter a password!", "Invalid Options", "OK" )
			return
		end
		local r = math.Clamp(color_mixer:GetVector().r * 255, 1, 255)
		local g = math.Clamp(color_mixer:GetVector().g * 255, 1, 255)
		local b = math.Clamp(color_mixer:GetVector().b * 255, 1, 255)
		if self.perms == 1 then
			GAMEMODE.Tribes:CreateTribe( LocalPlayer(), txt_name:GetValue(), Color(r,g,b,255), self.perms, self.txt_pass:GetValue() )
		else
			GAMEMODE.Tribes:CreateTribe( LocalPlayer(), txt_name:GetValue(), Color(r,g,b,255), self.perms, "" )
		end
		self:Remove()
		GAMEMODE.Tribes.tribe_menu:Remove()
	end
	
	
end
vgui.Register("tribe_create", PANEL, "DFrame")


local PANEL = {}
function PANEL:Init()
	self:SetSize( 300, 280 )
    self:Center()
	self:SetTitle("Send Tribe Invitation")
	self:SetDraggable( false )
	self:SetBackgroundBlur( true )
	self:DrawFrame()
	self.selected = 0
end
function PANEL:DrawFrame()
	local body_panel = vgui.Create( "DPanel", self )
	body_panel:Dock( FILL )
	body_panel.Paint = function()
		surface.SetDrawColor( 60, 60, 60, 210 )
		surface.DrawRect( 0, 0, body_panel:GetWide(), body_panel:GetTall() )
		draw.DrawText("Send an invitation to your tribe:", "TribeMenu1", body_panel:GetWide() / 2, 6, Color(210,210,210,255), TEXT_ALIGN_CENTER)
	end	
	playerslist = vgui.Create("DScrollPanel", body_panel)
	playerslist:Dock( FILL )
	playerslist:DockMargin(10,30,10,50)
	playerslist.Paint = function()
		surface.SetDrawColor( 80, 80, 80, 210 )
		surface.DrawRect( 0, 0, body_panel:GetWide(), body_panel:GetTall() )
	end
	
	local invite_button = vgui.Create( "tribe_button", body_panel )
	invite_button:SetWide( 80 )
	invite_button:SetText( "INVITE" )
	invite_button:SetPos( self:GetWide() / 2 - 40, self:GetTall() - 70 )
	invite_button.OnMousePressed = function()
		if not invite_button.enabled then return end
		GAMEMODE.Tribes:SendInvitation( self.selected_ply )
		self:Remove()
	end
	invite_button:Disable( true )

	for k, v in pairs( player.GetAll() ) do
		local l = vgui.Create( "DPanel", playerslist )
		l:Dock(TOP)
		l:DockMargin( 4, 4, 4, 0 )
		l:SetHeight( 20 )
		l.Paint = function()
			if self.selected ~= k then
			surface.SetDrawColor( 60, 60, 60, 210 )
			else
			surface.SetDrawColor( 60, 120, 60, 210 )
			end
			surface.DrawRect( 0, 0, l:GetWide(), l:GetTall() )
			draw.DrawText(v:Nick(), "TribeMenu4", l:GetWide() / 2, 2, Color(210,210,210,255), TEXT_ALIGN_CENTER)
		end
		l.OnMousePressed = function()
			self.selected = k
			self.selected_ply = v
			invite_button:Disable( false )
		end
	end
end
vgui.Register("tribe_sendinvite", PANEL, "DFrame")



local PANEL = {}
function PANEL:Init()
	self:SetSize( 300, 280 )
    self:Center()
	self:SetTitle("Tribe Management")
	self:SetDraggable( false )
	self:SetBackgroundBlur( true )
	self:DrawFrame()
	self.selected = 0
end
function PANEL:DrawFrame()
	local body_panel = vgui.Create( "DPanel", self )
	body_panel:Dock( FILL )
	body_panel.Paint = function()
		surface.SetDrawColor( 60, 60, 60, 210 )
		surface.DrawRect( 0, 0, body_panel:GetWide(), body_panel:GetTall() )
		draw.DrawText("Select a player to remove:", "TribeMenu1", body_panel:GetWide() / 2, 6, Color(210,210,210,255), TEXT_ALIGN_CENTER)
	end	
	playerslist = vgui.Create("DScrollPanel", body_panel)
	playerslist:Dock( FILL )
	playerslist:DockMargin(10,30,10,50)
	playerslist.Paint = function()
		surface.SetDrawColor( 80, 80, 80, 210 )
		surface.DrawRect( 0, 0, body_panel:GetWide(), body_panel:GetTall() )
	end
		
	local btn_invite = vgui.Create( "tribe_button", body_panel )
	btn_invite:SetText( "SEND INVITE" )
	btn_invite:DockMargin( 48, 4, 48, 4 )
	btn_invite:Dock( BOTTOM )
	btn_invite.OnMousePressed = function()
		GAMEMODE.Tribes.send_invite = vgui.Create( "tribe_sendinvite" )
		GAMEMODE.Tribes.send_invite:MakePopup()		
	end
	if not (GAMEMODE.Tribes:IsValid( GAMEMODE.Tribes:GetPlayersTribe( LocalPlayer() ) ) and GAMEMODE.Tribes.tblTribes[ GAMEMODE.Tribes:GetPlayersTribe( LocalPlayer() ) ].perms.ptype == 2) then
		btn_invite:Remove()
	end
	
	local invite_button = vgui.Create( "tribe_button", body_panel )
	invite_button:SetText( "REMOVE" )
	invite_button:DockMargin( 48, 4, 48, 4 )
	invite_button:Dock( BOTTOM )
	invite_button.OnMousePressed = function()
		if not invite_button.enabled then return end
		GAMEMODE.Tribes:KickFromTribe( self.selected )
		self:Remove()
		GAMEMODE.Tribes.tribe_menu:Remove()
	end
	invite_button:Disable( true )

	for k, v in pairs( GAMEMODE.Tribes.tblTribes[ GAMEMODE.Tribes:GetPlayersTribe( LocalPlayer() ) ].members ) do
		local l = vgui.Create( "DPanel", playerslist )
		l:Dock(TOP)
		l:DockMargin( 4, 4, 4, 0 )
		l:SetHeight( 20 )
		l.Paint = function()
			if self.selected ~= k then
			surface.SetDrawColor( 60, 60, 60, 210 )
			else
			surface.SetDrawColor( 60, 120, 60, 210 )
			end
			surface.DrawRect( 0, 0, l:GetWide(), l:GetTall() )
			draw.DrawText(v, "TribeMenu4", l:GetWide() / 2, 2, Color(210,210,210,255), TEXT_ALIGN_CENTER)
		end
		l.OnMousePressed = function()
			self.selected = k
			invite_button:Disable( false )
		end
	end
end
vgui.Register("tribe_managetribe", PANEL, "DFrame")




//Tribe Perks Menu
local PANEL = {}
function PANEL:Init()
	self:SetSize( 800, 400 )
    self:Center()
	self:SetTitle("Tribe Perks")
	self:SetDraggable( false )
	self:SetBackgroundBlur( true )
	self:DrawFrame()
	self.selected = 0
end
function PANEL:DrawFrame()
	local body_panel = vgui.Create( "DPanel", self )
	body_panel:Dock( FILL )
	body_panel.Paint = function()
		surface.SetDrawColor( 60, 60, 60, 210 )
		surface.DrawRect( 0, 0, body_panel:GetWide(), body_panel:GetTall() )
		draw.DrawText("Tribe Perks: Unlocked Perks Appear Green", "TribeMenu3", body_panel:GetWide() / 2, 5, Color(210,210,210,255), TEXT_ALIGN_CENTER)
	end	
	perkslist = vgui.Create("DScrollPanel", body_panel)
	perkslist:Dock( FILL )
	perkslist:DockMargin(10,30,10,10)
	perkslist.Paint = function()
		surface.SetDrawColor( 80, 80, 80, 210 )
		surface.DrawRect( 0, 0, body_panel:GetWide(), body_panel:GetTall() )
	end
		
	for k, v in ipairs( GAMEMODE.Tribes.LevelPerks ) do
		local l = vgui.Create( "DPanel", perkslist )
		l:Dock(TOP)
		l:DockMargin( 4, 4, 4, 0 )
		l:SetHeight( 50 )
		l.Paint = function()
			if GAMEMODE.Tribes:GetTribeLevel( LocalPlayer() ) >= k then
				surface.SetDrawColor( 60, 120, 60, 210 )
			else
				surface.SetDrawColor( 120, 60, 60, 210 )
			end
			surface.DrawRect( 0, 0, l:GetWide(), l:GetTall() )
			draw.DrawText("Level", "TribeMenu3", 30, 0, Color(210,210,210,255), TEXT_ALIGN_CENTER)
			draw.DrawText(k, "TribeMenu2", 32, 16, Color(210,210,210,255), TEXT_ALIGN_CENTER)
			draw.DrawText(v.name, "TribeMenu3", l:GetWide() / 2, 4, Color(210,210,210,255), TEXT_ALIGN_CENTER)
			draw.DrawText(v.desc, "TribeMenu4", l:GetWide() / 2, 27, Color(210,210,210,255), TEXT_ALIGN_CENTER)
		end
	end
end
vgui.Register("tribe_perksmenu", PANEL, "DFrame")