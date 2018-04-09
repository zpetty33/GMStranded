AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel(SGS.proplist["harvester"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor(Color(255, 255, 255, 255))
	self:DrawShadow(true)
	self.phys = self:GetPhysicsObject()
	self.roll = 0
	
	if self.phys:IsValid() then
		self.phys:Wake()
		self.phys:SetMass(20)
	end
	
	self.roll = 0
	
	self.on = false
	
	self.dest = self:GetPos() + Vector(0,0,120)
	
	self:StartMotionController()
	
	
	

end

function ENT:PhysicsSimulate( physobj, deltatime )
	-- Do physics
	physobj:Wake()
	
	if self.roll <= 360 then
		self.roll = self.roll + 2
		if self.roll >= 360 then self.roll = 0 end
	end
	
	self:SetLocalVelocity( (self.dest - self:GetPos()) )
	self:SetAngles(Angle(0,self.roll-180,0))

end

function ENT:Use( ply )

	if CurTime() < ply.lastuse + 0.5 then return end
	
	self:SetMoveType(MOVETYPE_FLY)
	self:MoveToRock()

	ply.lastuse = CurTime()
	
	

end


function ENT:FindNearest( eType )

	local SphereFind = ents.FindInSphere( self:GetPos(), 8000 )
	local filteredlist = {}
	
	if table.Count( SphereFind ) == 0 then return end
		
	for k, v in pairs(SphereFind) do
		if v:GetClass() == eType then
			table.insert( filteredlist, v )
		end
	end
	
	if table.Count( filteredlist ) == 0 then return end
	
	self.NEDis = 64000000
	self.NEnt = nil
	for k, v in pairs( filteredlist ) do
		if v:GetPos():DistToSqr(self:GetPos()) < self.NEDis then
			self.NEnt = v
			self.NEDis = v:GetPos():DistToSqr(self:GetPos())
		end
	end
	
	return self.NEnt

end

function ENT:MoveToRock()

	local dent = self:FindNearest( "gms_stonenode" )
	local entxy = dent:LocalToWorld(dent:OBBCenter())
	self.dest = Vector(entxy.x, entxy.y, entxy.z) + Vector(0,0,dent:OBBMaxs().z) + Vector( 0, 0, 120)

end
