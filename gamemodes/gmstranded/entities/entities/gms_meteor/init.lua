--################# HEADER #################
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");


--################### Init
function ENT:Initialize()
	self:PhysicsInitSphere(32,"metal");
	self:SetCollisionBounds(Vector()*-16,Vector()*16);
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE);
	self:SetMoveType(MOVETYPE_FLY);
	self:SetColor( Color(255, 120, 0, 255) )
	self:DrawShadow(false)
	self.phys = self:GetPhysicsObject()
	
	if self.phys:IsValid() then
		self.phys:SetMass(20);
	end
	local skypos = GAMEMODE.Worlds:GetEntityWorldSpace( self ).SkyPos - 50
	local newPos = Vector(self:GetPos().x, self:GetPos().y, skypos) + Vector(math.random(-500, 500), math.random(-500, 500), 0) 
	self:SetPos( newPos )

	local trail = util.SpriteTrail(self, 0, Color(255, 100, 0, 255), false, 64, 16, 0.5, 1/(15+1)*0.5, "trails/plasma.vmt")
	
	timer.Simple( self.falltime or 1, function() if IsValid(self) then self:Launch() end end )
end

--################# Prevent PVS bug/drop of all networkes vars (Let's hope, it works) @aVoN
function ENT:UpdateTransmitState() return TRANSMIT_ALWAYS end;


function ENT:Think()

end

function ENT:Launch()
	self:Ignite(10)
	
	self:SetVelocity( Vector(0,0,-1) * 1500)
end

function ENT:Touch(e)
	util.ScreenShake( self:GetPos(), 10, 10, 0.3, 500 )
	self:EmitSound( 'weapons/explode'.. tostring(math.random(3,5)) ..'.wav', 80, math.random(80,120) )
	if IsValid(self.owner) then
		util.BlastDamage( self.owner, self.owner, self:GetPos(), 300, math.random(20,40) )
	end
	for k, v in pairs( player.GetAll() ) do
		if v:GetPos():DistToSqr( self:GetPos() ) < 90000 then
			v:SetVelocity(( v:GetPos() - self:GetPos()):GetNormal() * 500 + Vector(0,0,150) )
			v:ViewPunch( Angle( math.random(-60,60), math.random(-60,60), math.random(-60,60) ) )
		end
	end
	
	self:Remove()
end