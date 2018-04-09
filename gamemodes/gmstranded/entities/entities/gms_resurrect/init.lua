--################# HEADER #################
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");


--################### Init
function ENT:Initialize()
	self:PhysicsInitSphere( 4, "metal" )
	self:SetCollisionBounds( Vector()*-4, Vector()*4 )
	self:SetSolid( SOLID_NONE )
	self:DrawShadow(false)
	self.phys = self:GetPhysicsObject()
	if self.phys:IsValid() then
		self.phys:Wake()
		self.phys:SetMass(20)
	end
	
	
	
	self:StartMotionController()
	self.m_ShadowParams = {}
	
	self.everyother = CurTime()
	
	self.z = 4
	self.range = 36

end

--################# Prevent PVS bug/drop of all networkes vars (Let's hope, it works) @aVoN
function ENT:UpdateTransmitState() return TRANSMIT_ALWAYS end;

function ENT:Think()
	self:SetPos( self.opos )
	if not IsValid( self.parent ) then
		self:Remove()
	end

end


function ENT:PhysicsSimulate( physobj, deltatime )
	-- Calculate position
	if !IsValid( self.parent ) then return SIM_NOTHING end

	local speed = 8
	local pos = self.parent:GetPos() + Vector(
		math.cos( CurTime() * speed ) * self.range,
		math.sin( CurTime( )* speed ) * self.range,
		self.z
	)

	-- Do physics
	physobj:Wake()
	
	self.m_ShadowParams.secondstoarrive		= 0.1				-- How long it takes to move to pos and rotate accordingly - only if it _could_ move as fast as it want - damping and max speed/angular will make this invalid (Cannot be 0! Will give errors if you do)
	self.m_ShadowParams.pos					= pos				-- Where you want to move to
	self.m_ShadowParams.angle				= Angle( 0, 0, 0 )	-- Angle you want to move to
	self.m_ShadowParams.maxangular			= 5000				-- What should be the maximal angular force applied
	self.m_ShadowParams.maxangulardamp		= 10000				-- At which force/speed should it start damping the rotation
	self.m_ShadowParams.maxspeed			= 1000000			-- Maximal linear force applied
	self.m_ShadowParams.maxspeeddamp		= 10000				-- Maximal linear force/speed before  damping
	self.m_ShadowParams.dampfactor			= 0.8				-- The percentage it should damp the linear/angular force if it reaches it's max amount
	self.m_ShadowParams.teleportdistance	= 200				-- If it's further away than this it'll teleport (Set to 0 to not teleport)
	self.m_ShadowParams.deltatime			= deltatime			-- The deltatime it should use - just use the PhysicsSimulate one
 
	physobj:ComputeShadowControl( self.m_ShadowParams )
	
	local ED = EffectData()
	local bc = self:GetColor()
	ED:SetOrigin( self:GetPos() )
	ED:SetStart(Vector(bc.r,bc.g,bc.b))
	local effect = util.Effect( 'particle_resurrect', ED, true, true )

	
end




