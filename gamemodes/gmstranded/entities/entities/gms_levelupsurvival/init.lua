AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:PhysicsInitSphere( 4, "metal" )
	self:SetCollisionBounds( Vector()*-4, Vector()*4 )
	self:SetSolid( SOLID_NONE )
	self:SetColor(Color(255,0,0,255))
	self:DrawShadow(false)
	self.phys = self:GetPhysicsObject()
	if self.phys:IsValid() then
		self.phys:Wake()
		self.phys:SetMass(20)
	end
	
	self:StartMotionController()
	self.m_ShadowParams = {}
	
	self.m_Player = self.ply

	
	self.z = 10
	self.range = 80
	self.mov = "stay"
	self.tstart = CurTime()
	self.tend = self.tstart + 4
	self.everyother = CurTime()
	self.trail = util.SpriteTrail(self, 0, self.skillcolor, false, 12, 40, 0.3, 1/(15+1)*0.5, "trails/laser.vmt")

end

function ENT:PhysicsSimulate( physobj, deltatime )
	-- Calculate position
	if !IsValid( self.m_Player ) then return SIM_NOTHING end

	local speed = 20
	local pos = self.m_Player:GetPos() + Vector(
		math.cos( CurTime()*speed ) * self.range,
		math.sin( CurTime()*speed ) * self.range,
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
	
	local eftime = ( (self.tend - CurTime()) / 4 )
	self.z = ( ( ( -eftime + 1 )  * 110 ) + 10 )
	
	self.range = ( ( ( eftime ) * 140 ) + 5 )

	

	if self.tend <= CurTime() then
		self:Blast()
		self:Remove()
	end
	
	
	if self.everyother + 0.2 < CurTime() then
		self.skillcolor = Color(math.random(150,255), math.random(150,255), math.random(150,255), 255)
		self:SetColor(self.skillcolor)
		self.everyother = CurTime()
	end
	self.trail:SetColor(self.skillcolor)
	
	
end


function ENT:Blast()
	local fx = EffectData();
	fx:SetOrigin(self:GetPos());
	fx:SetNormal(Vector(0,0,1));
	fx:SetEntity(self.Entity);
	fx:SetScale(1);
	fx:SetAngles(Angle(self.Entity:GetColor()));
	util.Effect("cball_explode",fx,true,true);
end



