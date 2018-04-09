function SGS_IncubatorMenu()

	SGS.Incubator = vgui.Create("sgs_incubatormenu")
	SGS.Incubator:SetVisible(true)
	SGS.Incubator:MakePopup()

end


/*--------------------------------
--------------Help----------------
--------------------------------*/
local PANEL = {}

function PANEL:Init()


    self:SetPos( ( ScrW() / 2 ) - 212, ( ScrH() / 2 ) - 125 )
    self:SetSize( 425, 300 )
    self:SetVisible( false )
	
	
	self:DrawFrame()
	
	
end

function PANEL:Paint( w, h )

	/* Outter Backgrounds */
	draw.RoundedBoxEx( 8, 0, 0, 250, 300, Color( 80, 80, 80, 150 ), true, true, true, true )
	draw.RoundedBoxEx( 8, 250, 85, 25, 80, Color( 80, 80, 80, 150 ), false, false, false, false )
	draw.RoundedBoxEx( 8, 275, 25, 150, 200, Color( 80, 80, 80, 150 ), true, true, true, true )
	
	/* Inner Backgrounds */
	draw.RoundedBoxEx( 8, 4, 4, 242, 292 , Color( 0, 0, 0, 200 ), true, true, true, true )
	draw.RoundedBoxEx( 8, 246, 89, 33, 72 , Color( 0, 0, 0, 200 ), false, false, false, false )
	draw.RoundedBoxEx( 8, 279, 29, 142, 192, Color( 0, 0, 0, 200 ), true, true, true, true )

end

function PANEL:DrawFrame()

	local MainText = vgui.Create( "DLabel", self )
	MainText:SetPos( 14, 10 )
	MainText:SetText( "Incubation Menu" )
	MainText:SetFont( "SGS_FarmText" )
	MainText:SetColor( Color( 255, 255, 255, 255 ) )
	MainText:SizeToContents()
	
	local EggContainer = vgui.Create( "DIconLayout", self)
	EggContainer:SetSize( 222, 222 )
	EggContainer:SetPos( 24, 30 )
	EggContainer:SetSpaceY( 4 )
	EggContainer:SetSpaceX( 4 )
	
	for k, v in pairs( SGS.Eggs ) do
		local EggButton = vgui.Create( "DImageButton" )
		EggButton:SetMaterial( v.material )
		EggButton:SetSize( 64, 64 )
		EggButton:SetToolTip( v.tooltip )
		EggContainer:Add( EggButton )
		
		EggButton.PaintOver = function()
			local eggcount = SGS.resources[v.resource] or 0
			draw.SimpleText(eggcount, "proplisticons", 2, 2, Color(255, 255,255, 255), 0, 0)
		end
		EggButton.DoClick = function ( EggButton )
			surface.PlaySound( "ui/buttonclickrelease.wav" )
			RunConsoleCommand("sgs_incubate", v.resource, v.npcclass)
		end
	end
	
	local MakeFood = vgui.Create( "DButton", self )
	MakeFood:SetSize( 134, 16 )
	MakeFood:SetPos( 283, 33 )
	MakeFood:SetText( "Pet Food (2x) - Meat" )
	MakeFood:SetToolTip( "Requires 1x Antlion Meat" )
	MakeFood.DoClick = function( MakeFood )
		RunConsoleCommand("sgs_makepetfood", "1", "1")
	end
	
	local MakeFood = vgui.Create( "DButton", self )
	MakeFood:SetSize( 134, 16 )
	MakeFood:SetPos( 283, 53 )
	MakeFood:SetText( "Pet Food (10x) - Meat" )
	MakeFood:SetToolTip( "Requires 5x Antlion Meat" )
	MakeFood.DoClick = function( MakeFood )
		RunConsoleCommand("sgs_makepetfood", "1", "5")
	end
	
	local MakeFood = vgui.Create( "DButton", self )
	MakeFood:SetSize( 134, 16 )
	MakeFood:SetPos( 283, 73 )
	MakeFood:SetText( "Pet Food (20x) - Meat" )
	MakeFood:SetToolTip( "Requires 10x Antlion Meat" )
	MakeFood.DoClick = function( MakeFood )
		RunConsoleCommand("sgs_makepetfood", "1", "10")
	end
	
	local MakeFood = vgui.Create( "DButton", self )
	MakeFood:SetSize( 134, 16 )
	MakeFood:SetPos( 283, 93 )
	MakeFood:SetText( "Pet Food (2x) - Wheat" )
	MakeFood:SetToolTip( "Requires 5x Wheat" )
	MakeFood.DoClick = function( MakeFood )
		RunConsoleCommand("sgs_makepetfood", "2", "5")
	end
	
	local MakeFood = vgui.Create( "DButton", self )
	MakeFood:SetSize( 134, 16 )
	MakeFood:SetPos( 283, 113 )
	MakeFood:SetText( "Pet Food (10x) - Wheat" )
	MakeFood:SetToolTip( "Requires 25x Wheat" )
	MakeFood.DoClick = function( MakeFood )
		RunConsoleCommand("sgs_makepetfood", "2", "25")
	end
	
	local MakeFood = vgui.Create( "DButton", self )
	MakeFood:SetSize( 134, 16 )
	MakeFood:SetPos( 283, 133 )
	MakeFood:SetText( "Pet Food (20x) - Wheat" )
	MakeFood:SetToolTip( "Requires 50x Wheat" )
	MakeFood.DoClick = function( MakeFood )
		RunConsoleCommand("sgs_makepetfood", "2", "50")
	end
	
	local CloseButton = vgui.Create( "DButton", self )
	CloseButton:SetSize( 16, 16 )
	CloseButton:SetPos( 228, 10 )
	CloseButton:SetText( "X" )
	CloseButton.DoClick = function( CloseButton )
		self:Remove()
	end
	
	
end


vgui.Register( "sgs_incubatormenu", PANEL, "Panel" )
