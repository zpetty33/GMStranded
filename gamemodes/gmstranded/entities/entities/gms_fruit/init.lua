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
	self:SetModel(self.model)
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	if not self.growth then
		self.growth = 1
	end
	
	self.lastgrow = CurTime()
	
	self.issap = true
	self.saptime = CurTime() + math.random(5,20)
	
	self.maxgrowth = math.random( 4, 12 )
	self.maxgrowth = self.maxgrowth / 10
	
	--math.random(1500, 2100)
	self.decaytime = math.random(1500, 2100) + CurTime()
	self.droptime = self.decaytime - 30
	self.attached = true
	self:SetUseType(3)
end

function ENT:Use( ply )
	if CurTime() < ply.lastuse + 0.5 then return end
	
	if self.growth < self.maxgrowth then
		ply:SendMessage("This fruit isn't fully grown.",3,Color(255,50,50,255))
		return
	end
	
	ply:EatFruit( self.lvl, self.maxgrowth )
	if self.parent.tfruit then
		self.parent.tfruit = self.parent.tfruit - 1
	end
	self:Remove()
	ply.lastuse = CurTime()
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


	if self.issap then
		if CurTime() >= self.saptime then self.issap = false end
	end
	
	if self.issap == false then
		if self.growth <= self.maxgrowth then
		
			if CurTime() >= self.lastgrow + 0.05 then
				self.lastgrow = CurTime()
				self.growth = self.growth + 0.05
				self:SetModelScale(self.growth, 0)
			end
		
		end
	end
	

	if (CurTime() >= self.droptime) and self.attached == true then
		self:Drop()
	end
	
	if (CurTime() >= self.decaytime) then
	
		if IsValid(self.parent) then
			if self.parent.tfruit == nil then
				self:Remove()
			else
				self.parent.tfruit = self.parent.tfruit - 1
				self:Remove()
			end
		else
			self:Remove()
		end
	end
	self:NextThink(CurTime() + 0.05)
	return true
	

end

function ENT:Drop()

	self:SetParent()
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:GetPhysicsObject():Wake()
	self.attached = false
	self.decaytime = CurTime() + 30

end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end