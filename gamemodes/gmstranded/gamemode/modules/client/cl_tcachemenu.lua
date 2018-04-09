function SGS_TCacheMenu()

	SGS.tcachemenu = vgui.Create( "sgs_tcachemenu" )
	SGS.tcachemenu:MakePopup()
	SGS.tcachemenu:SetVisible(true)
end


/*--------------------------------
-----------Tcache Menu------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()
    self:SetPos((ScrW() / 2) - 85, (ScrH() / 2) - 175)
    self:SetSize(170, 370)
    self:SetVisible(true)
	
		
	self:DrawFrame()
end

function PANEL:Paint( w, h )

	draw.RoundedBoxEx( 16, 0, 0, self:GetWide(), self:GetTall(), Color(80, 80, 80, 150), true, true, true, true )

end

function PANEL:DrawFrame()

	local LimitLabel = vgui.Create("DLabel", self)
	LimitLabel:SetPos(110,10) // Position
	LimitLabel:SetColor(Color(50,255,50,255)) // Color
	LimitLabel:SetFont("SGS_RCacheMenuText")

	--OTHERS--
	ResList = vgui.Create( "DPanelList", self)
	ResList:SetSize( 150, 290 )
	ResList:SetPos( 10, 30 )
	ResList:EnableVerticalScrollbar( true )
	ResList:EnableHorizontal( false )
	ResList:SetPadding( 4 )
	
	local TCacheLabel = vgui.Create("DLabel", self)
	TCacheLabel:SetPos(10,10) // Position
	TCacheLabel:SetColor(Color(255,255,255,255)) // Color
	TCacheLabel:SetFont("SGS_TCacheMenuText")
	TCacheLabel:SetText("Tools / Weapons") // Text
	TCacheLabel:SizeToContents()
	
	local tamount = 0
	for k, v in SortedPairs( SGS.tcache ) do
		if tonumber(v) > 0 then
			local reslbl = vgui.Create("DButton")
			reslbl:SetText( CapAll(string.gsub(SGS_ReverseToolLookup( k ).title, "_", " ")) .. ": " .. v )
			reslbl:SetSize( 120, 20 )
			tamount = tamount + v

			ResList:AddItem( reslbl )
			reslbl.DoClick = function( reslbl )
				if SGS.ctype == "p" then
					net.Start( "cl_fromptcache" ) net.WriteString( k ) net.SendToServer()
				elseif SGS.ctype == "t" then
					net.Start( "cl_fromtcache" ) net.WriteString( k ) net.SendToServer()
				end
				SGS.tcachemenu:SetVisible(false)
			end
		end
	end
	
	if SGS.ctype == "p" then
		LimitLabel:SetText(tamount .. " / 25") // Text
	elseif SGS.ctype == "t" then
		LimitLabel:SetText(tamount .. " / 50") // Text
	end
	LimitLabel:SizeToContents()
	
	
	CloseButton = vgui.Create( "DButton", self )
	CloseButton:SetSize( 100, 30 )
	CloseButton:SetPos( 35, 325 )
	CloseButton:SetText( "Close" )
	CloseButton.DoClick = function( CloseButton )
		self:Remove()
	end

end
vgui.Register("sgs_tcachemenu", PANEL, "Panel")
