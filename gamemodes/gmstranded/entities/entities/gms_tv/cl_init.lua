include "shared.lua"
CreateClientConVar( "sgs_tv_volume", "8", true, false )

-- ----------------------------------------------------------------
-- Netcode
-- ----------------------------------------------------------------
local function NetworkRequestVideoPlay( ent, strVideoID )
	net.Start( "gm_tv_rplay" )
		net.WriteEntity( ent )
		net.WriteString( strVideoID )
	net.SendToServer()
end

local function NetworkRequestVideoPlayTwitch( ent, strVideoID )
	net.Start( "gm_tv_rplayt" )
		net.WriteEntity( ent )
		net.WriteString( strVideoID )
	net.SendToServer()
end

local function NetworkRequestVideoStop( ent )
	net.Start( "gm_tv_rstop" )
		net.WriteEntity( ent )
	net.SendToServer()
end

net.Receive( "gm_tv_play", function()
    local ent_index, strVideoID, intTime = net.ReadUInt( 16 ), net.ReadString(), net.ReadUInt( 32 )
    local ent = ents.GetByIndex( ent_index )

    if not IsValid( ent ) or not ent.PlayVideo then
        local function retry()
            intTime = intTime +1
            ent = ents.GetByIndex( ent_index )
            
            if not IsValid( ent ) or not ent.PlayVideo then
                timer.Simple( 1, retry )
                return
            end

            ent:PlayVideo( strVideoID, intTime )
        end
        timer.Simple( 1, retry )

        return
    end

    ent:PlayVideo( strVideoID, intTime )
end )

net.Receive( "gm_tv_playt", function()
    local ent_index, strVideoID = net.ReadUInt( 16 ), net.ReadString()
    local ent = ents.GetByIndex( ent_index )

    if not IsValid( ent ) or not ent.PlayTwitch then
        local function retry()
            ent = ents.GetByIndex( ent_index )
            
            if not IsValid( ent ) or not ent.PlayTwitch then
                timer.Simple( 1, retry )
                return
            end

            ent:PlayTwitch( strVideoID )
        end
        timer.Simple( 1, retry )

        return
    end

    ent:PlayTwitch( strVideoID )
end )

net.Receive( "gm_tv_stop", function()
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end

	ent:StopVideo()
end )

net.Receive( "gm_tv_menu", function()
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end

	ent:ShowMenu()
end )

function OnYoutubeLoaded( strID )
	for k, ent in pairs( ents.FindByClass("gms_tv") ) do
		if ent.m_strUID ~= strID then continue end
		ent:OnYoutubeLoaded()
		break
	end
end

-- ----------------------------------------------------------------
-- Entity
-- ----------------------------------------------------------------
function ENT:Initialize()
	self.m_vecCamPos = Vector( 6.175, -27.821627, 35.345478 )
	self.m_angCamAngs = Angle( 0, 90, 90 )
	self.m_intWidth, self.m_intHeight = 1920, 1920

	self.m_tblQuad = {
		[1] = Vector( 0, 0, 0 ),
		[2] = Vector( self.m_intWidth, 0, 0 ),
		[3] = Vector( self.m_intWidth, self.m_intHeight, 0 ),
		[4] = Vector( 0, self.m_intHeight, 0 )
	}

	self.m_strUID = "tv_".. tostring( self:EntIndex() ).. "_uid"
	self:ReloadPlayer()
end

function ENT:Reload()
	if ValidPanel( self.m_pnlWebPage ) then
		self.m_pnlWebPage:Remove()
	end

	self.m_pnlWebPage = vgui.Create( "DHTML" )
	self.m_pnlWebPage:SetSize( self.m_intWidth, 1128 )
	self.m_pnlWebPage:SetPaintedManually( true )
	self.m_pnlWebPage:SetScrollbars( false )
	self.m_pnlWebPage:SetAllowLua( true )
	self.m_pnlWebPage:SetMouseInputEnabled( false )
	self.m_pnlWebPage:SetKeyBoardInputEnabled( false )
end

function ENT:OnRemove()
	self.m_pnlWebPage:Remove()
end

function ENT:HasPlayer()
	return self.m_bTwitchStream and self.m_bHasTwitch or self.m_bHasPlayer
end

function ENT:ReloadPlayer()
	self.m_bHasPlayer = nil
	self.m_bHasTwitch = nil
	self.m_bTwitchStream = nil
	self:Reload()
	self.m_pnlWebPage:OpenURL( "http://g4p.org/YouTube/player.php?uid=".. self.m_strUID )
end

function ENT:OnYoutubeLoaded()
	self.m_bHasPlayer = true
end

function ENT:OnTwitchLoaded()
	self.m_bHasTwitch = true
	self.m_pnlWebPage:RunJavascript( "player.playVideo();" )
end

--Play, stop
function ENT:IsPlayingVideo()
	return self.m_bVideoStarted
end

function ENT:IsVideoLoaded()
	return self.m_bVideoLoaded
end

function ENT:LoadTwitch( strUserID )
	self.m_pnlWebPage:OpenURL( "http://g4p.org/YouTube/twitchplayer.php?vid=".. strUserID )
	self.m_bVideoLoaded = true
end

function ENT:LoadVideo()
	if self.m_bTwitchStream and self.m_strTwitchID then
		self:LoadTwitch( self.m_strTwitchID )
		return
	end

	self.m_pnlWebPage:RunJavascript( [[
		jQuery("#youtube-player-container")
			.tubeplayer("play", {
			id: "]].. self.m_strPlayingID.. [[",
			time: ]].. self.m_intPlayTime +(RealTime() -self.m_intStartPlay).. [[,
		});
	]] )

	self.m_bVideoLoaded = true
end

function ENT:UnloadVideo()
	
	if self.m_bTwitchStream then
		self.m_pnlWebPage:OpenURL( "http://g4p.org/YouTube/player.php?uid=".. self.m_strUID )
	else
		if self:HasPlayer() then
			self.m_pnlWebPage:RunJavascript( [[
				jQuery("#youtube-player-container").tubeplayer("stop");
			]] )
		end

		self:ReloadPlayer()
	end
	
	self.m_bVideoLoaded = false
end

function ENT:PlayVideo( strVideoID, intTime )
	if not self:HasPlayer() then
		timer.Simple( 1, function()
			if not IsValid( self ) then return end
			self:PlayVideo( strVideoID, intTime +1 )
		end )

		return
	end
	
	self.m_intPlayTime = intTime
	self.m_intStartPlay = RealTime()
	self.m_strPlayingID = strVideoID
	self.m_bVideoStarted = true
	self.m_bVideoLoaded = false
	self.m_strTwitchID = nil
	self.m_bTwitchStream = nil

	self:LoadVideo()
end

function ENT:PlayTwitch( strUserID )
	self.m_bTwitchStream = true
	self.m_bVideoStarted = true
	self.m_strTwitchID = strUserID
	
	self:LoadVideo()
end

function ENT:StopVideo()
	self:UnloadVideo()
	self.m_bVideoStarted = false
	self.m_bTwitchStream = false
	self.m_strTwitchID = nil
end

function ENT:GetMaxVolume()
	return GetConVarNumber( "sgs_tv_volume" ) or 50
end

function ENT:UpdateVolume()
	if not self:HasPlayer() then return end
	if not ValidPanel( self.m_pnlWebPage ) then return end
	if not self:IsVideoLoaded() then return end
	
	local vol
	if self:GetMaxVolume() ~= 0 then
		local fallOff = 512
		local scaler = (fallOff -LocalPlayer():GetPos():Distance(self:GetPos())) /fallOff

		vol = Lerp( scaler, 0, self:GetMaxVolume() )
	else
		vol = 0
	end
	
	if self.m_bTwitchStream then
		--
	else
		self.m_pnlWebPage:RunJavascript( [[
			jQuery("#youtube-player-container").tubeplayer("volume", ]].. vol.. [[);
		]] )
	end
end

function ENT:Draw()
	self:DrawModel()

	if not ValidPanel( self.m_pnlWebPage ) then 
		self:ReloadPlayer()
		return
	end


	local viewNorm = (self:GetPos() -EyePos()):GetNormalized()
	if viewNorm:Dot( self:GetAngles():Forward() * -1 ) <= 0 then
		return
	end

	if self:GetPos():Distance( EyePos() ) > 768 then
		return
	end

	if not self.m_intLastFrame or CurTime() > self.m_intLastFrame then
		self.m_pnlWebPage:UpdateHTMLTexture()
		self.m_intLastFrame = CurTime() +(1 /24)
	end

	self.m_matHTML = self.m_pnlWebPage:GetHTMLMaterial()
	if not self.m_matHTML then return end
	
	cam.Start3D2D( self:LocalToWorld(self.m_vecCamPos), self:LocalToWorldAngles(self.m_angCamAngs), 0.031 )
		render.SetMaterial( self.m_matHTML )
		render.DrawQuad(
			self.m_tblQuad[1],
			self.m_tblQuad[2],
			self.m_tblQuad[3],
			self.m_tblQuad[4]
		)
	cam.End3D2D()
end

function ENT:Think()
	if not ValidPanel( self.m_pnlWebPage ) then return end
	if not self:HasPlayer() then return end
	
	if self:IsPlayingVideo() then
		local range = self.m_bTwitchStream and 400 or 1024
		if not self:IsVideoLoaded() then
			if LocalPlayer():GetPos():Distance( self:GetPos() ) <= range then
				self:LoadVideo()
			end
		else
			if LocalPlayer():GetPos():Distance( self:GetPos() ) > range then
				self:UnloadVideo()
			end
		end
	end

	self:UpdateVolume()
end

function ENT:ShowMenu()
	self.m_pnlMenu = vgui.Create( "tv_menu" )
	self.m_pnlMenu:SetEntity( self )
	self.m_pnlMenu:SetSize( 640, 480 )
	self.m_pnlMenu:Center()
	self.m_pnlMenu:SetVisible( true )
	self.m_pnlMenu:MakePopup()

	self.m_pnlMenu:Rebuild()
end

-- ----------------------------------------------------------------
-- Panel: tv_menu
-- ----------------------------------------------------------------
local Panel = {}
function Panel:Init()
	self:SetTitle( "Video Selection" )
	self.m_pnlPresetList = vgui.Create( "DListView", self )
	self.m_pnlPresetList:AddColumn( "Video Name" )
	self.m_pnlPresetList:AddColumn( "Video ID" )

	self.m_pnlStopBtn = vgui.Create( "DButton", self )
	self.m_pnlStopBtn:SetText( "Stop Video" )
	self.m_pnlStopBtn.Think = function( btn )
		if not IsValid( self:GetEntity() ) then return end
		if not self:GetEntity():HasPlayer() then return end
		btn:SetDisabled( not self:GetEntity():IsPlayingVideo() )
	end
	self.m_pnlStopBtn.DoClick = function()
		if not IsValid( self:GetEntity() ) then return end
		NetworkRequestVideoStop( self:GetEntity() )
	end

	if LocalPlayer():IsDonator() then
		local textPrompt = "Enter Custom Video ID"

		self.m_pnlTextBox = vgui.Create( "DTextEntry", self )
		self.m_pnlTextBox:SetText( textPrompt )
		self.m_pnlTextBox.OnGetFocus = function()
			if self.m_pnlTextBox:GetValue() == textPrompt then
				self.m_pnlTextBox:SetText( "" )
			end
		end
		self.m_pnlTextBox.OnLoseFocus = function()
			if self.m_pnlTextBox:GetValue() == "" then
				self.m_pnlTextBox:SetText( textPrompt )
			end
		end
		self.m_pnlTextBox.OnEnter = function()
			if not IsValid( self:GetEntity() ) then return end
			if self.m_pnlTextBox:GetValue() == "" then return end
			if self.m_pnlTextBox:GetValue() == textPrompt then return end
			NetworkRequestVideoPlay( self:GetEntity(), self.m_pnlTextBox:GetValue() )
		end

		self.m_pnlPlayCustomBtn = vgui.Create( "DButton", self )
		self.m_pnlPlayCustomBtn:SetText( "Play Video ID" )
		self.m_pnlPlayCustomBtn.Think = function( btn )
			if not IsValid( self:GetEntity() ) then return end
			if not self:GetEntity():HasPlayer() then return end
			btn:SetDisabled( self.m_pnlTextBox:GetValue() == "" or self.m_pnlTextBox:GetValue() == textPrompt )
		end
		self.m_pnlPlayCustomBtn.DoClick = function()
			if not IsValid( self:GetEntity() ) then return end
			if self.m_pnlTextBox:GetValue() == "" then return end
			if self.m_pnlTextBox:GetValue() == textPrompt then return end
			NetworkRequestVideoPlay( self:GetEntity(), self.m_pnlTextBox:GetValue() )
			self:Remove()
		end
		--[[
		self.m_pnlPlayCustomTwBtn = vgui.Create( "DButton", self )
		self.m_pnlPlayCustomTwBtn:SetText( "Play Twitch Stream" )
		self.m_pnlPlayCustomTwBtn.Think = function( btn )
			if not IsValid( self:GetEntity() ) then return end
			if not self:GetEntity():HasPlayer() then return end
			btn:SetDisabled( self.m_pnlTextBox:GetValue() == "" or self.m_pnlTextBox:GetValue() == textPrompt )
		end
		self.m_pnlPlayCustomTwBtn.DoClick = function()
			if not IsValid( self:GetEntity() ) then return end
			if self.m_pnlTextBox:GetValue() == "" then return end
			if self.m_pnlTextBox:GetValue() == textPrompt then return end
			NetworkRequestVideoPlayTwitch( self:GetEntity(), self.m_pnlTextBox:GetValue() )
			self:Remove()
		end
		]]
	end
end

function Panel:Rebuild()
	for k, v in SortedPairsByMemberValue( self:GetEntity().m_tblPresets, "Name" ) do
		local line = self.m_pnlPresetList:AddLine( v.Name, v.ID )
		line.OnSelect = function( line )
			NetworkRequestVideoPlay( self:GetEntity(), v.ID )
			self:Remove()
		end
	end
end

function Panel:SetEntity( ent )
	self.m_entEntity = ent
end

function Panel:GetEntity()
	return self.m_entEntity
end

function Panel:PerformLayout( intW, intH )
	DFrame.PerformLayout( self, intW, intH )

	self.m_pnlStopBtn:SetSize( 100, 25 )
	self.m_pnlStopBtn:SetPos( 5, intH -30 )

	self.m_pnlPresetList:SetSize( intW -10, intH -40 -self.m_pnlStopBtn:GetTall() )
	self.m_pnlPresetList:SetPos( 5, 30 )

	if self.m_pnlPlayCustomBtn then
		self.m_pnlPlayCustomBtn:SetSize( 100, 25 )
		self.m_pnlPlayCustomBtn:SetPos( intW -(self.m_pnlPlayCustomBtn:GetWide() *2) -10, intH -self.m_pnlPlayCustomBtn:GetTall() -5 )
		
		--[[
		self.m_pnlPlayCustomTwBtn:SetSize( 100, 25 )
		self.m_pnlPlayCustomTwBtn:SetPos( intW -self.m_pnlPlayCustomBtn:GetWide() -5, intH -self.m_pnlPlayCustomBtn:GetTall() -5 )
		]]
		
		local x, y = self.m_pnlStopBtn:GetPos()
		self.m_pnlTextBox:SetPos( x +self.m_pnlStopBtn:GetWide() +5, y )
		self.m_pnlTextBox:SetSize( intW -(x +(self.m_pnlStopBtn:GetWide() *2) +10) -110, 25 )
	end
end
vgui.Register( "tv_menu", Panel, "DFrame" )