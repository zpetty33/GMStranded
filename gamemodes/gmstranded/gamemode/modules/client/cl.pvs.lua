if true then return end

local PvsExpanded = false
local w, h = 205, 28
local x, y = ScrW() /2 -(w /2), 60
local text_col = Color( 255, 255, 255, 255 )
local icon = Material( "icon16/cog.png", "unlitgeneric" )

net.Receive( "pvs_ud", function() 
	PvsExpanded = net.ReadBit() == 1
end )

hook.Add( "HUDPaint", "PvsUpdate", function( intW, intH )
	if PvsExpanded then return end
	
	draw.RoundedBox( 4, x, y, w, h, Color(50, 50, 50, 150) ) 
	surface.SetMaterial( icon )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRectRotated( x +14, y +11, 16, 16, SysTime() *-180 )
	surface.DrawTexturedRectRotated( x +20, y +18, 16, 16, SysTime() *180 )

	draw.Text{
		text = "Loading Entities...",
		font = "Trebuchet24",
		pos = { x +36, y +2 },
		xalign = TEXT_ALIGN_LEFT,
		yalign = TEXT_ALIGN_TOP,
		color = text_col
	}
end )