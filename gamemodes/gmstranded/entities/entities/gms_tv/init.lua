AddCSLuaFile "cl_init.lua"
AddCSLuaFile "shared.lua"
include "shared.lua"

ENT.Base = "base_ai"

util.AddNetworkString( "gm_tv_rplay" )
net.Receive( "gm_tv_rplay", function( intMsgLen, pPlayer )
	local ent, strVideoID = net.ReadEntity(), net.ReadString()
	if not IsValid( ent ) or not strVideoID then return end
	if pPlayer:GetPos():Distance( ent:GetPos() ) >ent.m_intUseRange then return end
	
	if not pPlayer:IsDonator() then
		for k, v in pairs( ent.m_tblPresets ) do
			if v.ID == strVideoID then
				ent:PlayVideo( strVideoID )
				break
			end
		end
	else
		ent:PlayVideo( strVideoID )
	end
end )

util.AddNetworkString( "gm_tv_rplayt" )
net.Receive( "gm_tv_rplayt", function( intMsgLen, pPlayer )
	if true then return end
	local ent, strVideoID = net.ReadEntity(), net.ReadString()
	if not IsValid( ent ) or not strVideoID then return end
	if not pPlayer:IsDonator() then return end
	if pPlayer:GetPos():Distance( ent:GetPos() ) >ent.m_intUseRange then return end
	
	ent:PlayTwitch( strVideoID )
end )

util.AddNetworkString( "gm_tv_rstop" )
net.Receive( "gm_tv_rstop", function( intMsgLen, pPlayer )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if pPlayer:GetPos():Distance( ent:GetPos() ) >ent.m_intUseRange then return end
	
	ent:StopVideo()
end )

util.AddNetworkString( "gm_tv_play" )
local function NetworkTVPlay( ent, strVideoID, intTimeOffset, pPlayer )
    net.Start( "gm_tv_play" )
        net.WriteUInt( ent:EntIndex(), 16 )
        net.WriteString( strVideoID )
        net.WriteUInt( intTimeOffset or 0, 32 )
    if not pPlayer then
        net.Broadcast()
    else
        net.Send( pPlayer )
    end
end

util.AddNetworkString( "gm_tv_playt" )
local function NetworkTVPlayTwitch( ent, strVideoID, pPlayer )
    net.Start( "gm_tv_playt" )
        net.WriteUInt( ent:EntIndex(), 16 )
        net.WriteString( strVideoID )
    if not pPlayer then
        net.Broadcast()
    else
        net.Send( pPlayer )
    end
end

util.AddNetworkString( "gm_tv_stop" )
local function NetworkTVStop( ent )
	net.Start( "gm_tv_stop" )
		net.WriteEntity( ent )
	net.Broadcast()
end

util.AddNetworkString( "gm_tv_menu" )
local function NetworkShowTVMenu( ent, pPlayer )
	net.Start( "gm_tv_menu" )
		net.WriteEntity( ent )
	net.Send( pPlayer )
end

hook.Add( "PlayerInitialSpawn", "tv_update", function( pPlayer )
	for k, v in pairs( ents.FindByClass("gms_tv") ) do
		if v:GetCurrentVideo() then
			NetworkTVPlay( v, v:GetCurrentVideo(), RealTime() -v:GetVideoPlayTime(), pPlayer )
		elseif v:GetTwitchUser() then
			NetworkTVPlayTwitch( v, v.m_strTwitchUserID, pPlayer )
		end
	end
end )

function ENT:Initialize()
	self:SetModel( "models/props/cs_office/TV_plasma.mdl" )
	self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:DrawShadow( true )
	self:SetTrigger( true )
	self:SetUseType( SIMPLE_USE )
end

function ENT:Use( pPlayer )
	//NetworkShowTVMenu( self, pPlayer )
end

function ENT:PlayVideo( strVideoID )
	NetworkTVPlay( self, strVideoID, 0 )
	self.m_intStartVideoTime = RealTime()
	self.m_strCurrentVideo = strVideoID
end



function ENT:StopVideo()
	NetworkTVStop( self )
	self.m_strCurrentVideo = nil
	self.m_intStartVideoTime = nil
	self.m_strTwitchUserID = nil
end

function ENT:PlayTwitch( strUserID )
	self.m_strTwitchUserID = strUserID
	NetworkTVPlayTwitch( self, strUserID )
end

function ENT:GetCurrentVideo()
	return self.m_strCurrentVideo
end

function ENT:GetTwitchUser()
	return self.m_strTwitchUserID
end

function ENT:GetVideoPlayTime()
	return self.m_intStartVideoTime or 0
end