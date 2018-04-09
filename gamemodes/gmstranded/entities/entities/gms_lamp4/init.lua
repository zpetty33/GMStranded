AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.NoAutoClose = true;

--Called when an entity is no longer touching this SENT.
--Return: Nothing
function ENT:EndTouch(entEntity)
end

--Called when the SENT is spawned
--Return: Nothing

function ENT:Initialize()
	self:SetModel("models/props_c17/pottery03a.mdl")
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetColor(Color(255, 255, 255, 255))
	
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false) -- Freezes the object in place.
	end
	
	
	--self:SpawnOrb()
end


function ENT:SpawnOrb()
	self.light = ents.Create( "gms_lamporb4" )
	self.light:SetPos( self:LocalToWorld(Vector(0,0,30) ) )
	self.light:Spawn()
	self.light:SetParent( self )
	self.light:SetNetworkedString("Owner", "World")
end


function ENT:Use( ply )

	if CurTime() > ply.lastuse + 0.5 then
	
		if IsValid(self.light) then
			self.light:Remove()
		else
			self:SpawnOrb()
		end
		ply.lastuse = CurTime()
		
	end


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

	self:NextThink( CurTime() + 1 )
	return true;

end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end