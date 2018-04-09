AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when an entity is no longer touching this SENT.
--Return: Nothing
function ENT:EndTouch(entEntity)
end

--Called when the SENT is spawned
--Return: Nothing

util.AddNetworkString("radio_openmenu")
util.AddNetworkString("radio_ctos")
util.AddNetworkString("radio_play")
util.AddNetworkString("radio_stop")

function ENT:Initialize()
	self:SetModel("models/props_lab/citizenradio.mdl")
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetColor( Color(255,255,255,255) )
	self:SetUseType(3)
	
	self.on = false
	self.stationid = ""
	self.ownerid = ""
end

function ENT:Use( ply )
	net.Start( "radio_openmenu" )
		net.WriteEntity( self )
	net.Send( ply )
end

function ENT:SetupSong( stationid, ply )
	
	self.stationid = stationid
	
	if IsValid( ply ) then
		net.Start( "radio_play" )
			net.WriteString( stationid )
			net.WriteEntity( self )
		net.Send( ply )
	else
		if self.on == true then
			self:StopSong()
		end
		net.Start( "radio_play" )
			net.WriteString( stationid )
			net.WriteEntity( self )
		net.Broadcast()
		self.on = true
	end

end

function ENT:StopSong()
	self.on = false
	net.Start( "radio_stop" )
		net.WriteEntity( self )
	net.Broadcast()
end

net.Receive( "radio_ctos", function( len, ply )
	local radio = net.ReadEntity()
	local stationid = net.ReadString()
	
	if not IsValid( radio ) then return end
	
	if stationid == "0" then
		radio:StopSong()
	else
		radio:SetupSong( stationid )
	end
end )

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
end
