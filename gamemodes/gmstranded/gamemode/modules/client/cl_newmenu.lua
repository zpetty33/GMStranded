GM.NewMenu = GM.NewMenu or {}
local PlayerMeta = FindMetaTable( "Player" )

--[[

	New Menu
	
]]

surface.CreateFont("MenuFont1", {
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

function GM.NewMenu:ShowNewMenu( ply, com, args )
	self.new_menu = vgui.Create( "new_menu" )
	self.new_menu:MakePopup()
end
concommand.Add( "gms_newmenu", function( ... ) GAMEMODE.NewMenu:ShowNewMenu( ... ) end )

local PANEL = {}

function PANEL:Init()

	self:SetSize( ScrW() - 100, ScrH() - 100 )
    self:Center()
	self:DrawFrame()
	self:SetTitle("")
	self:SetDraggable( false )
	
end

function PANEL:Paint()
	--Main Window--	
	surface.SetDrawColor( 0, 0, 0, 210 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	surface.DrawRect( 4, 29, 180, self:GetTall() - 33 ) --LeftButtonPanel
	surface.DrawRect( 4, 4, self:GetWide() - 8, 22 ) --TopPanel
	surface.DrawRect( 188, 29, self:GetWide() - 192, self:GetTall() - 33 ) --TopPanel
end



function PANEL:DrawFrame()

	self.firsttime = true

	local button_dock = vgui.Create( "DPanel", self )
	button_dock:SetWidth( 180 )
	button_dock:Dock( LEFT )
	button_dock:DockMargin( 0, 0, 0, 0 )
	button_dock.Paint = function()
	end
	
	local content_window = vgui.Create( "DPanel", self )
	content_window:Dock( FILL )
	content_window:DockMargin( 3, 0, 0, 0 )
	content_window.Paint = function()
		surface.SetDrawColor( 0, 0, 0, 210 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end

	GAMEMODE.NewMenu.btn_option1 = vgui.Create( "menu_button", button_dock )
	GAMEMODE.NewMenu.btn_option2 = vgui.Create( "menu_button", button_dock )
	GAMEMODE.NewMenu.btn_option3 = vgui.Create( "menu_button", button_dock )
	GAMEMODE.NewMenu.btn_option9 = vgui.Create( "menu_button", button_dock )
	GAMEMODE.NewMenu.btn_option5 = vgui.Create( "menu_button", button_dock )
	GAMEMODE.NewMenu.btn_option6 = vgui.Create( "menu_button", button_dock )
	GAMEMODE.NewMenu.btn_option7 = vgui.Create( "menu_button", button_dock )
	GAMEMODE.NewMenu.btn_option8 = vgui.Create( "menu_button", button_dock )
	
	GAMEMODE.NewMenu.btn_option1:SetWide( 130 )
	GAMEMODE.NewMenu.btn_option1:SetText( "Server Rules" )
	GAMEMODE.NewMenu.btn_option1:DockMargin( 2, 2, 4, 0 )
	GAMEMODE.NewMenu.btn_option1:Dock( TOP )
	GAMEMODE.NewMenu.btn_option1.OnMousePressed = function()
		DeactivateAllButtons()
		GAMEMODE.NewMenu.btn_option1.active = true
		
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "motd_panel", content_window )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end

	GAMEMODE.NewMenu.btn_option2:SetWide( 130 )
	GAMEMODE.NewMenu.btn_option2:SetText( "Stranded WIKI" )
	GAMEMODE.NewMenu.btn_option2:DockMargin( 2, 2, 4, 0 )
	GAMEMODE.NewMenu.btn_option2:Dock( TOP )
	GAMEMODE.NewMenu.btn_option2.OnMousePressed = function()
		DeactivateAllButtons()
		GAMEMODE.NewMenu.btn_option2.active = true
		
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "wiki_panel", content_window )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end

	GAMEMODE.NewMenu.btn_option3:SetWide( 130 )
	GAMEMODE.NewMenu.btn_option3:SetText( "Beginner's Guide" )
	GAMEMODE.NewMenu.btn_option3:DockMargin( 2, 2, 4, 0 )
	GAMEMODE.NewMenu.btn_option3:Dock( TOP )
	GAMEMODE.NewMenu.btn_option3.OnMousePressed = function()
		DeactivateAllButtons()
		GAMEMODE.NewMenu.btn_option3.active = true
		
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "guide_panel", content_window )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end

	GAMEMODE.NewMenu.btn_option9:SetWide( 130 )
	GAMEMODE.NewMenu.btn_option9:SetText( "Forums" )
	GAMEMODE.NewMenu.btn_option9:DockMargin( 2, 2, 4, 0 )
	GAMEMODE.NewMenu.btn_option9:Dock( TOP )
	GAMEMODE.NewMenu.btn_option9.OnMousePressed = function()
		DeactivateAllButtons()
		GAMEMODE.NewMenu.btn_option9.active = true
		
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "forums_panel", content_window )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end

	GAMEMODE.NewMenu.btn_option5:SetWide( 130 )
	GAMEMODE.NewMenu.btn_option5:SetText( "Achievements" )
	GAMEMODE.NewMenu.btn_option5:DockMargin( 2, 2, 4, 0 )
	GAMEMODE.NewMenu.btn_option5:Dock( TOP )
	GAMEMODE.NewMenu.btn_option5.OnMousePressed = function()
		DeactivateAllButtons()
		GAMEMODE.NewMenu.btn_option5.active = true
		
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "achievements_panel", content_window )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end

	GAMEMODE.NewMenu.btn_option6:SetWide( 130 )
	GAMEMODE.NewMenu.btn_option6:SetText( "Useful Commands" )
	GAMEMODE.NewMenu.btn_option6:DockMargin( 2, 2, 4, 0 )
	GAMEMODE.NewMenu.btn_option6:Dock( TOP )
	GAMEMODE.NewMenu.btn_option6.OnMousePressed = function()
		DeactivateAllButtons()
		GAMEMODE.NewMenu.btn_option6.active = true
	end

	GAMEMODE.NewMenu.btn_option7:SetWide( 130 )
	GAMEMODE.NewMenu.btn_option7:SetText( "Donate!" )
	GAMEMODE.NewMenu.btn_option7:DockMargin( 2, 2, 4, 2 )
	GAMEMODE.NewMenu.btn_option7:Dock( BOTTOM )
	GAMEMODE.NewMenu.btn_option7.OnMousePressed = function()
		DeactivateAllButtons()
		GAMEMODE.NewMenu.btn_option7.active = true
		
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "donate_panel", content_window )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end

	GAMEMODE.NewMenu.btn_option8:SetWide( 130 )
	GAMEMODE.NewMenu.btn_option8:SetText( "Leaderboard" )
	GAMEMODE.NewMenu.btn_option8:DockMargin( 2, 2, 4, 2 )
	GAMEMODE.NewMenu.btn_option8:Dock( TOP )
	GAMEMODE.NewMenu.btn_option8.OnMousePressed = function()
		DeactivateAllButtons()
		GAMEMODE.NewMenu.btn_option8.active = true
		
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "leaderboard_panel", content_window )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
	end
	
	if self.firsttime then
		DeactivateAllButtons()
		GAMEMODE.NewMenu.btn_option1.active = true
		if ValidPanel(self.content) then self.content:Remove() end
		self.content = vgui.Create( "motd_panel", content_window )
		self.content:Dock( FILL )
		self.content:DockMargin( 0, 0, 0, 0 )
		self.firsttime = false
	end
	
	

end
vgui.Register("new_menu", PANEL, "DFrame")

function DeactivateAllButtons()
	GAMEMODE.NewMenu.btn_option1.active = false
	GAMEMODE.NewMenu.btn_option2.active = false
	GAMEMODE.NewMenu.btn_option3.active = false
	GAMEMODE.NewMenu.btn_option5.active = false
	GAMEMODE.NewMenu.btn_option6.active = false
	GAMEMODE.NewMenu.btn_option7.active = false
	GAMEMODE.NewMenu.btn_option8.active = false
	GAMEMODE.NewMenu.btn_option9.active = false
end

local MOTD = {}
function MOTD:Init()
	local HTML = vgui.Create("DHTML", self)
	HTML:Dock( FILL )
	HTML:OpenURL("http://www.g4p.org/StrandedMenu")
end
function MOTD:Paint()

end
vgui.Register("motd_panel", MOTD, "Panel")

local WIKI = {}
function WIKI:Init()
	local HTML = vgui.Create("DHTML", self)
	HTML:Dock( FILL )
	HTML:OpenURL("https://g4p.org/wiki/index.php/Main_Page")
end
function WIKI:Paint()

end
vgui.Register("wiki_panel", WIKI, "Panel")

local GUIDE = {}
function GUIDE:Init()
	local HTML = vgui.Create("DHTML", self)
	HTML:Dock( FILL )
	HTML:OpenURL("http://www.g4p.org/StrandedMenu/guide.php")
end
function GUIDE:Paint()

end
vgui.Register("guide_panel", GUIDE, "Panel")

local FORUMS = {}
function FORUMS:Init()
	local HTML = vgui.Create("DHTML", self)
	HTML:Dock( FILL )
	HTML:OpenURL("http://www.g4p.org/Forum")
end
function FORUMS:Paint()

end
vgui.Register("forums_panel", FORUMS, "Panel")

local DONATE = {}
function DONATE:Init()
	local HTML = vgui.Create("DHTML", self)
	HTML:Dock( FILL )
	HTML:OpenURL("https://g4p.org/StrandedMenu/donate.php")
end
function DONATE:Paint()

end
vgui.Register("donate_panel", DONATE, "Panel")

local LEADERBOARD = {}
function LEADERBOARD:Init()
	local HTML = vgui.Create("DHTML", self)
	HTML:Dock( FILL )
	HTML:OpenURL("https://g4p.org/StrandedMenu/leaderboard.php")
end
function LEADERBOARD:Paint()

end
vgui.Register("leaderboard_panel", LEADERBOARD, "Panel")

local ACHIEVEMENTS = {}
function ACHIEVEMENTS:Init()
	self:DrawFrame()
end
function ACHIEVEMENTS:DrawFrame()
	
	local List = vgui.Create( "DScrollPanel", self )
	List:Dock(FILL)
	
	for k, v in pairs( SGS.Ach ) do
		if v.show == true then		
	
			local item = vgui.Create( "DPanel", List )
			item:SetHeight( 60 )
			item:DockMargin( 8, 2, 8, 2 )
			item.Paint = function(self)
				draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color(240,240,240,255) )
				if SGS_GetAch( v.short ) then
					draw.RoundedBox( 4, 2, 2, 56, 56, Color(50,255,50,255) )
				else
					draw.RoundedBox( 4, 2, 2, 56, 56, Color(255,50,50,255) )
				end
				
				draw.DrawText( v.long, "achtitle1", 65, 0, Color(0,0,0,255), 0 )
				draw.DrawText( v.displaytext, "achtitle2", 65, 18, Color(120,120,120,255), 0 )
				
				if v.associatedstat then
					local divisor = v.stat_divisor or 1 
					draw.DrawText( "Progress: " .. tostring(math.Clamp(math.floor(SGS_GetStat(v.associatedstat)/divisor), 0, tonumber(v.statneeded)/divisor)) .. " / " .. tostring(tonumber(v.statneeded)/divisor), "achtitle2", 65, 40, Color(0,0,0,255), 0 )
				end
				if v.reward then
					local w, h  = surface.GetTextSize( "Reward: " .. v.reward )
					local w2, h2  = surface.GetTextSize( v.reward )
					draw.DrawText( "Reward: ", "achtitle2", self:GetWide() - w - 10, 40, Color(150,25,25,255), 0 )
					draw.DrawText( v.reward, "achtitle2", self:GetWide() - w2 - 10, 40, Color(25,150,25,255), 0 )
				end
					
			end
			item:Dock(TOP)
		end
	end

end
function ACHIEVEMENTS:Paint()

end
vgui.Register("achievements_panel", ACHIEVEMENTS, "Panel")


local BUTTON = {}
function BUTTON:Init()
	self:SetTall( 30 )
	self.btxt = ""
	self.enabled = true
	self.active = false
end

function BUTTON:Paint()
	if self.enabled then
		if self.active then
			surface.SetDrawColor( 100, 125, 125, 210 )
			surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
			draw.DrawText(self.btxt, "MenuFont1", self:GetWide() / 2, 6, Color(220,220,220,255), TEXT_ALIGN_CENTER)			
		else
			surface.SetDrawColor( 100, 100, 100, 210 )
			surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
			draw.DrawText(self.btxt, "MenuFont1", self:GetWide() / 2, 6, Color(220,220,220,255), TEXT_ALIGN_CENTER)
		end
	else
		surface.SetDrawColor( 65, 65, 65, 210 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
		draw.DrawText(self.btxt, "MenuFont1", self:GetWide() / 2, 6, Color(150,150,150,255), TEXT_ALIGN_CENTER)
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
vgui.Register("menu_button", BUTTON, "DPanel")