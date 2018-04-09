AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when an entity is no longer touching this SENT.
--Return: Nothing
function ENT:EndTouch(entEntity)
end

--Called when the SENT is spawned
--Return: Nothing

function ENT:Initialize()
	self:SetModel(SGS.proplist["totem"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(3)
	
	self.skill = "alchemy"
	
	self.color = SGS.colors[self.skill]
	
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false) -- Freezes the object in place.
	end
	
	self.enabled = false
	
	self.power = 5
end

function ENT:Use( ply )
	self:Menu( ply )
end

function ENT:Menu( ply )
	net.Start( "client_opentotemmenu" )
		net.WriteString( self.skill )
		net.WriteInt( self.power, 32 )
		net.WriteBit( self.enabled )
		net.WriteEntity( self )
	net.Send( ply )
end

function ENT:Enable()
	self:Disable()
	self.orb = ents.Create("gms_totemdisplay")
	self.orb:SetColor(self.color)
	self.orb:SetPos( self:GetPos() )
	self.orb.parent = self
	self.orb:Spawn()
	self.enabled = true
end

function ENT:Disable()
	if IsValid(self.orb) then self.orb:Remove() end
	self.enabled = false
end

function ENT:AcceptInput(input, ply)
end

--Called when the entity key values are setup (either through calls to ent:SetKeyValue, or when the map is loaded).
--Return: Nothing
function ENT:KeyValue(k,v)
end

--Called when a save-game is loaded.
--Return: Nothing
function ENT:OnRestore()
end

--Called when something hurts the entity.
--Return: Nothing
function ENT:OnTakeDamage(dmiDamage)
end

--Controls/simulates the physics on the entity.
--Return: (SimulateConst) sim, (Vector) linear_force and (Vector) angular_force
function ENT:PhysicsSimulate(pobPhysics,numDeltaTime)
end

--Called when an entity starts touching this SENT.
--Return: Nothing
function ENT:StartTouch(entEntity)
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
	if not self.enabled then return end
	if not self.power then self.power = 0 end

	if self.power > 0 then
		self.power = self.power - 1
	else
		self:Disable()
	end
	self:NextThink(CurTime() + 1)
	return true
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end