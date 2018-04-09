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
	self:SetModel(SGS.proplist["pethouse"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetUseType(3)
	self:SetColor( Color(255, 255, 255, 255) )

	self.enabled = false
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false) -- Freezes the object in place.
	end
	
end

function ENT:Use( ply )

	if CurTime() < ply.lastuse + 1 then return end
	
	if self.enabled == false then 
		ply:SendMessage("This shelter is disabled!", 60, Color(255, 255, 0, 255))
		ply.lastuse = CurTime()
		return 
	end

	/* Open Pet Shelter Menu */
	SGS_SynchPethouse( ply )
	ply:SendLua("SGS_PetHouseMenu()")
	
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
function ENT:StartTouch(ent2)
	if self.enabled == false then return end
	if not IsValid( self.POwner ) then return end
	
	if table.Count(self.POwner.pethouse) >= self.POwner.maxpets then return end

	if ent2.ispet then
		if not (ent2.owner == self.POwner) then return end
		if self.POwner.pethouse[ent2.petid] == nil then
			self.POwner.pethouse[ent2.petid] = {}
			self.POwner.pethouse[ent2.petid].curgrowth = ent2.curgrowth
			self.POwner.pethouse[ent2.petid].maxgrowth = ent2.maxgrowth
			self.POwner.pethouse[ent2.petid].growthinterval = ent2.growthinterval
			self.POwner.pethouse[ent2.petid].age = ent2.age
			self.POwner.pethouse[ent2.petid].hunger = ent2.hunger
			self.POwner.pethouse[ent2.petid].name = ent2.name or "Mr. Bobsworth"
			self.POwner.pethouse[ent2.petid].model = ent2:GetModel()
			self.POwner.pethouse[ent2.petid].class = ent2:GetClass()
			self.POwner.pethouse[ent2.petid].petid = ent2.petid
			self.POwner.pethouse[ent2.petid].skill = ent2.skill
			ent2:Remove()
		end
	end
	
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
	local oc = false
	for k, v in pairs( player.GetAll() ) do
	
		if v:GetPlayerID() == self.POwner64 then
			oc = true
			
			self.POwner = v
			if self.POwner.pethouse == nil then
				self.POwner.pethouse = {}
			end

			break
		end
		oc = false
	
	end
	
	self.enabled = oc
	self:NextThink( CurTime() + 0.2 )
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