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
	self:SetModel("models/props_wasteland/rockgranite01a.mdl")
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetUseType(3)
	
	self:SetColor( Color( 255,150,150,255) )
	
	self:SetAngles( Angle( -60, 0, -105 ) )
	self:SetPos( self:GetPos() - Vector( 0, 0, 0 ) )
	
	self.baselen = 20
	
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false) -- Freezes the object in place.
	end
	
	self.durability = math.random( 8, 12 )
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
function ENT:Touch( ent2 )
	if not ent2:IsPlayer() then return end
	if not ent2.lastburned_meteor then ent2.lastburned_meteor = CurTime() - 10 end
	if CurTime() < ent2.lastburned_meteor + 1 then return end
	ent2:Burn( math.random(15, 30) )
	ent2.lastburned_meteor = CurTime()
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
	
	local ED = EffectData()
	ED:SetOrigin( self:GetPos() + self:GetUp()*10 )
	util.Effect( 'meteor_smoke', ED )

	self:NextThink( CurTime() + 0.1 )
	return true;
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end