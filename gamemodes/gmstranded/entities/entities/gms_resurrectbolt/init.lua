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
 	self:PhysicsInitSphere(10,"metal_bouncy")
	self:SetCollisionBounds(Vector(1,1,1)*-5,Vector(1,1,1)*5)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetColor(Color(255,255,255,255))
	self:DrawShadow( false )
	
	--PhysObject
	self:PhysWake()
	self.Phys = self:GetPhysicsObject()
	local vel = self.Direction * ( self.Speed * 2.1 )
	if(self.Phys and self.Phys:IsValid()) then
		self.Phys:SetMass(1)
		self.Phys:EnableGravity( false )
		self.Phys:SetVelocity(vel)
	end
	self.Created = CurTime()
	
	self.lastpulse = CurTime()
	
	timer.Simple( 5, function() if IsValid(self) then self:Destroy() end end )
	SafeRemoveEntityDelayed( self, 6 )
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS 
end

function ENT:Think(ply)
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() end
	local bc = math.random( 100, 150 )
	
	local ED = EffectData()
	ED:SetOrigin( self:GetPos() )
	ED:SetStart( Vector( bc + 80, bc, bc ) )
	local effect = util.Effect( 'pulse_resurrectbolt', ED, true, true )
	
	self:NextThink(0.1)
	return true
end

function ENT:PhysicsCollide( data, physobj )
	local e = data.HitEntity

	if (e) then
		
		local pos = data.HitPos
		local world = e:IsWorld()
		local owner = self:GetOwner()
		if (owner == nil) then owner = self end
		local hitnormal = data.HitNormal;
		local class = e:GetClass()

		if world then hitnormal = -1*hitnormal; end

		if (owner == e) then return end
		sound.Play( "ambient/levels/citadel/weapon_disintegrate1.wav", pos, 80, math.random(80,120) )
		self:FindResTarget()
		self:Destroy()

	end
end

function ENT:FindResTarget()
	local pos = self:GetPos()
	
	for k, v in pairs( ents.FindInSphere( pos, 100 ) ) do
		if v:GetClass() == "prop_ragdoll" then
			if v.ply then
				v.ply:Resurrect()
				return
			end
		end
	end
end


function ENT:Destroy()

	local bc = self:GetColor()

	local ED = EffectData()
	ED:SetOrigin( self:GetPos() )
	ED:SetStart(Vector(bc.r,bc.g,bc.b))
	local effect = util.Effect( 'bolt_explosion', ED, true, true )

	-- May fix crash @ AlexALX
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE);
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_NONE);
	--
	self.PhysicsCollide = function() end; -- Dummy
	self.Touch = self.PhysicsCollide;
	self.StartTouch = self.Touch;
	self.EndTouch = self.Touch;
	self.Think = self.Touch;
	self.PhysicsUpdate = self.Touch;
	self:SetTrigger(false);
	local e = self.Entity;
	timer.Simple(0,
		function()
			if(IsValid(e)) then e:Remove() end;
		end
	);
end
