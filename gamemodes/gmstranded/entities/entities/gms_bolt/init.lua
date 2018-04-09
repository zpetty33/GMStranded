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
		self.Phys:SetMass(self.Size*5)
		self.Phys:EnableGravity(true)
		self.Phys:SetVelocity(vel)
	end
	--self:SetLocalVelocity(vel)
	self.Created = CurTime()
	
	self.lastpulse = CurTime()
	
	timer.Simple( 3, function() if IsValid(self) then self:Destroy() end end )
	--SafeRemoveEntityDelayed( self, 3 )
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS 
end

function ENT:Think(ply)
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() end
	local bc = self:GetColor()
	
	local ED = EffectData()
	ED:SetOrigin( self:GetPos() )
	ED:SetStart(Vector(bc.r,bc.g,bc.b))
	local effect = util.Effect( 'pulse_bolt', ED, true, true )
	
	self:NextThink(0.1)
	return true
end

function ENT:PhysicsCollide( data, physobj )
	local e = data.HitEntity

	if (e) then
		
		if e:GetClass() == "phys_bone_follower" and IsValid(e:GetOwner()) then
			e = e:GetOwner()
		end

		local pos = data.HitPos
		local world = e:IsWorld()
		local owner = self:GetOwner()
		if (owner == nil) then owner = self end
		local hitnormal = data.HitNormal;
		local class = e:GetClass()

		if world then hitnormal = -1*hitnormal; end

		if (owner == e) then return end
		if e:GetClass() == "worldspawn" then return end
		if e:GetClass() == "gms_bolt" then return end
		if e:GetNWBool( "shielded" ) then return end
		BoltDamage( e, owner, self.damage, pos )
		sound.Play( "weapons/airboat/airboat_gun_energy2.wav", pos, 80, math.random(80,120) )
		self:Destroy();

	end
end

function BoltDamage( victim, attacker, amount, position )
	dmg = DamageInfo()
	dmg:SetDamageType( DMG_DISSOLVE )
	dmg:SetDamage( amount )
	
	dmg:SetAttacker(attacker)
	dmg:SetInflictor(attacker)
	victim:TakeDamageInfo(dmg)
end

function ENT:Destroy()
	local bc = self:GetColor()
	local ED = EffectData()
	ED:SetOrigin( self:GetPos() )
	ED:SetStart(Vector(bc.r,bc.g,bc.b))
	local effect = util.Effect( 'bolt_explosion', ED, true, true )
	self:SetTrigger(false);
	local e = self.Entity;
	timer.Simple(0,
		function()
			if(IsValid(e)) then e:Remove() end;
		end
	);
end
