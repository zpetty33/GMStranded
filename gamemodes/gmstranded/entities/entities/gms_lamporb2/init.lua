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
 	--self:PhysicsInitSphere(32,"metal");
	self:SetColor( Color(100, 255, 100, 220) )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	self:DrawShadow(false)
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

end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end