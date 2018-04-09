local PANEL = {}
local PlayerVoicePanels = {}

function PANEL:Init()

	self.LabelName = vgui.Create( "DLabel", self )
	self.LabelName:SetFont( "GModNotify" )
	self.LabelName:Dock( FILL )
	self.LabelName:SetTextColor( Color( 255, 255, 255, 255 ) )

	self.Color = color_transparent

	self:SetSize( 250, 20 + 8 )
	self:DockPadding( 4, 4, 4, 4 )
	self:DockMargin( 2, 2, 2, 2 )
	self:Dock( BOTTOM )

end

function PANEL:Setup( ply )

	self.ply = ply
	self.LabelName:SetText( ply:Nick() )
	
	self.Color = team.GetColor( ply:Team() )
	
	self:InvalidateLayout()

end

function PANEL:Paint( w, h )

	if ( !IsValid( self.ply ) ) then return end
	draw.RoundedBox( 4, 0, 0, w, h, self.Color )
	draw.RoundedBox( 4, 2, 2, w - 4, h - 4, Color(0,0,0,255) )

end

function PANEL:Think( )

	if ( self.fadeAnim ) then
		self.fadeAnim:Run()
	end

end

function PANEL:FadeOut( anim, delta, data )
	
	if ( anim.Finished ) then
	
		if ( IsValid( PlayerVoicePanels[ self.ply ] ) ) then
			PlayerVoicePanels[ self.ply ]:Remove()
			PlayerVoicePanels[ self.ply ] = nil
			return
		end
		
	return end
			
	self:SetAlpha( 255 - (255 * delta) )

end

derma.DefineControl( "VoiceNotify", "", PANEL, "DPanel" )



function GM:PlayerStartVoice( ply )

	if ( !IsValid( g_VoicePanelList ) ) then return end
	
	-- There'd be an exta one if voice_loopback is on, so remove it.
	GAMEMODE:PlayerEndVoice( ply )


	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then
			PlayerVoicePanels[ ply ].fadeAnim:Stop()
			PlayerVoicePanels[ ply ].fadeAnim = nil
		end

		PlayerVoicePanels[ ply ]:SetAlpha( 255 )

		return;

	end

	if ( !IsValid( ply ) ) then return end

	local pnl = g_VoicePanelList:Add( "VoiceNotify" )
	pnl:Setup( ply )
	
	PlayerVoicePanels[ ply ] = pnl
	
end


local function VoiceClean()

	for k, v in pairs( PlayerVoicePanels ) do
	
		if ( !IsValid( k ) ) then
			GAMEMODE:PlayerEndVoice( k )
		end
	
	end

end

timer.Create( "VoiceClean", 10, 0, VoiceClean )


function GM:PlayerEndVoice( ply )
	
	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then return end

		PlayerVoicePanels[ ply ].fadeAnim = Derma_Anim( "FadeOut", PlayerVoicePanels[ ply ], PlayerVoicePanels[ ply ].FadeOut )
		PlayerVoicePanels[ ply ].fadeAnim:Start( 0.2 )

	end
	
end


local function CreateVoiceVGUI()

	g_VoicePanelList = vgui.Create( "DPanel" )

	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos( ScrW() - 250, 100 )
	g_VoicePanelList:SetSize( 250, ScrH() - 300 )
		g_VoicePanelList:SetDrawBackground( false )

end
hook.Add( "InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI )