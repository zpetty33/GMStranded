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
 	self:PhysicsInitSphere(32,"metal")
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:SetMoveType(MOVETYPE_FLY)
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetColor(Color(255,0,0,255))
	
	self:DrawShadow(false)
	
	self.phys = self:GetPhysicsObject()
	
	if self.phys:IsValid() then
		self.phys:SetMass(10);
	end
	
	self.dietime = CurTime() + 2

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

function ENT:PhysicsSimulate( physobj, deltatime )

		
end

--Called when an entity starts touching this SENT.
--Return: Nothing

function ENT:StartTouch(entEntity)
end	
	
--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()

	if CurTime() >= self.dietime then
		self:Remove()
	end
	
	local ED = EffectData()
	local col = self:GetColor()
	ED:SetOrigin( self:GetPos() )
	ED:SetStart( Vector( col.r, col.g, col.b ) )
	local effect = util.Effect( 'pulse_alchemy', ED, true, true )

	self:NextThink(0.1)
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