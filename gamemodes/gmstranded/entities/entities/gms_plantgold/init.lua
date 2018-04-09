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
	self:SetModel(SGS.proplist["specialbush"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetColor(Color(255,255,255,255))
	
	self.tfruit = 1
	
	local ent = ents.Create( "gms_goldmelon" )
	ent:SetPos( self:GetPos() + Vector( 0, 0, 20 ) )
	ent:SetColor( Color(186, 142, 0, 255) )
	ent:SetMaterial("models/shiny")
	ent:Spawn()
	ent:CPPISetOwner(self.owner)
	ent.parent = self

end

function ENT:Use( ply )
	
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
	if self.tfruit <= 0 then
		if IsValid(self.owner) then
			if self.owner:IsPlayer() then
				self.owner.tplants = self.owner.tplants - 1
				self.owner:UpdatePlantCount()
			end
		end
		if self.slab then
			self.slab.locked = false
		end
		self:Remove()
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