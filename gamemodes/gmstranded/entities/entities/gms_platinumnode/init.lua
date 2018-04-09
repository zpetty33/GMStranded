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
	self:SetModel("models/ore_nodes/gold_node/gold_node.mdl")
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor(Color(163, 184, 255, 255))
	self:SetUseType(3)
	
	self.depleted = false
	self.respawn = CurTime()	
	self.rtotal = math.random(1, 4)
	self.baselen = 6
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false) -- Freezes the object in place.
	end
	self.rgives = "platinum_ore"
end

function ENT:RespawnTimer()
	self.respawn = CurTime() + math.random(280, 400)
end

function ENT:Use( ply )
	if ply.foragetoggle then return end
	SGS_Mine( ply, self, 0, 1, nil, nil )
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

	if self.depleted == true then
		if CurTime() >= self.respawn then
			self.rtotal = math.random(1, 4)
			self.depleted = false
			self:SetColor(Color(163, 184, 255, 255))
		end
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