surface.CreateFont( "RadioSmallText", {
	font = "Tahoma",
	size = 12,
	weight = 200,
} )

surface.CreateFont( "ScoreboardText", {
	font = "Arial",
	size = 16,
	weight = 600,
} )

function SGS_RadioMenu( radio )
	if not IsValid( radio ) then return end
	
	radiomenu = vgui.Create( "sgs_radiomenu" )
	radiomenu.radio = radio
	radiomenu:MakePopup()
	radiomenu:SetVisible(true)

end

local PANEL = {}
function PANEL:Init()

	local width = 240
	local height = 360
	
	if LocalPlayer():IsDonator() then
		height = height + 100
		self.donator = true
	end
	
	self:SetSize( width, height )
	self:SetPos( ( ScrW() / 2 ) - ( width / 2 ), ( ( ScrH() / 2 ) - ( height / 2 ) ) )
	self:SetVisible( false )
	
	self:DrawFrame()

end

function PANEL:Paint()
	
	draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), Color( 80, 80, 80, 255 ), true, true, true, true )
	draw.RoundedBoxEx( 8, 4, 4, self:GetWide()-8, self:GetTall()-8, Color( 0, 0, 0, 255 ), true, true, true, true )
	
	if self.donator then
		draw.SimpleText( "Donator - Set Station", "ScoreboardText", 50, 355, Color(255,255,255,255), 0, 0 )
		draw.SimpleText( "____________________________", "ScoreboardText", 8, 358, Color(255,255,255,255), 0, 0 )
		draw.SimpleText( "Station ID:", "ScoreboardText", 8, 380, Color(255,100,100,255), 0, 0 )
		
		draw.SimpleText( "Go to www.shoutcast.com and find the station", "RadioSmallText", 8, 400, Color(255,200,200,255), 0, 0 )
		draw.SimpleText( "you want to play. Hover over the link to the", "RadioSmallText", 8, 410, Color(255,200,200,255), 0, 0 )
		draw.SimpleText( "link for the station. The Station ID is the", "RadioSmallText", 8, 420, Color(255,200,200,255), 0, 0 )
		draw.SimpleText( "number at the end of the link URL. id=xxxxxx", "RadioSmallText", 8, 430, Color(255,200,200,255), 0, 0 )
		draw.SimpleText( "THE STATION TYPE HAS TO BE MP3.", "RadioSmallText", 8, 440, Color(255,0,0,255), 0, 0 )
	end
	
end

function PANEL:Think()
	self:RequestFocus()
end

function PANEL:DrawFrame()

	local x = 4
	local y = 20

	local CloseButton = vgui.Create( "DButton", self )
	CloseButton:SetSize( 12, 12 )
	CloseButton:SetPos( self:GetWide() - 22, 8 )
	CloseButton:SetText( "X" )
	CloseButton.DoClick = function( CloseButton )
		self:Remove()
	end
	
	local stationList = vgui.Create( "DListView", self )
	stationList:SetPos( x + 4, y + 4)
	stationList:SetSize( self:GetWide() - 16, 300 )
	stationList:SetMultiSelect(false)
	stationList:AddColumn( "Category" )
	stationList:AddColumn( "Station ID" )
	
	for k, v in pairs( SGS.RadioList ) do
		for _, id in pairs( SGS.RadioList[k] ) do
			stationList:AddLine( k, id.stationid )
		end
	end
	
	stationList:SelectFirstItem()
	
	local playBtn = vgui.Create( "DButton", self )
	playBtn:SetSize( 80, 20 )
	playBtn:SetPos( x+4, 326 )
	playBtn:SetText( "Play Station" )
	playBtn.DoClick = function( btn )
		local selectedID = tostring(stationList:GetLine(stationList:GetSelectedLine()):GetValue(2))
		if IsValid( self.radio ) then
			net.Start( "radio_ctos" )
				net.WriteEntity( self.radio )
				net.WriteString( selectedID )
			net.SendToServer()
		end
		self:Remove()
	end
	
	local stopBtn = vgui.Create( "DButton", self )
	stopBtn:SetSize( 80, 20 )
	stopBtn:SetPos( self:GetWide() - 88, 326 )
	stopBtn:SetText( "Stop Radio" )
	stopBtn.DoClick = function( btn )
		if IsValid( self.radio ) then
			net.Start( "radio_ctos" )
				net.WriteEntity( self.radio )
				net.WriteString( "0" )
			net.SendToServer()
		end
		self:Remove()
	end
	
	if LocalPlayer():IsDonator() then
		
		local idText = vgui.Create( "DTextEntry", self )
		idText:SetPos( 80, 378 )
		idText:SetSize( 80, 20 )
		idText:SetMultiline( false )
		
		local playBtn2 = vgui.Create( "DButton", self )
		playBtn2:SetSize( 68, 20 )
		playBtn2:SetPos( 164, 378 )
		playBtn2:SetText( "Play" )
		playBtn2.DoClick = function( btn )
			if tonumber( idText:GetValue() ) then
				local selectedID = tostring(idText:GetValue())
				if IsValid( self.radio ) then
					net.Start( "radio_ctos" )
						net.WriteEntity( self.radio )
						net.WriteString( selectedID )
					net.SendToServer()
				end
			end
			self:Remove()
		end

	end

end
vgui.Register("sgs_radiomenu", PANEL, "EditablePanel")