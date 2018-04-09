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
	self:SetModel(SGS.proplist["seed"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetColor(Color(255,255,255,255))
	if self.GrowTime == nil then
		self.GrowTime = 30
	end
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
	if self.GrowTime == nil then
		self.GrowTime = 30
	end
	
	local timemod = 1
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 500)) do
		if v:GetClass() == "gms_gardengnome" then
			timemod = timemod + 0.6
		end
	end
	if not GAMEMODE.Worlds:GetEntityWorldSpace( self ) then
		self:Remove()
		return
	end
	if not GAMEMODE.Worlds:GetEntityWorldSpace( self ).Weather then
		self:Remove()
		return
	end
	local weather = GAMEMODE.Worlds:GetEntityWorldSpace( self ).Weather.Current
	if weather == 1 or weather == 2 or weather ==3 then
		timemod = timemod + 0.4
	end
	self.GrowTime = self.GrowTime - timemod
	if self.GrowTime <= 0 then
		if math.random( 1, 150 ) <= 1 then
			self:GrowGold()
		else
			self:GrowPlant()
		end
	end
	self:NextThink(CurTime() + 1)
	return true
end

function ENT:GrowPlant()
	local ent = ents.Create("gms_plant")
	ent:SetPos( self:GetPos() )
	for _, v in pairs( SGS.Seeds["fruit"] ) do
		if v.resource == self.pType then
			ent.tfruit = math.random( v.minfruit, v.maxfruit )
			ent.fEnt = v.entity
			break
		end
	end
	ent.fType = self.pType
	ent.fColor = self.fColor
	ent.fMaterial = self.fMaterial
	ent.fEatHeal = self.fEatHeal
	ent.lvl = self.lvl
	ent.model = self.model
	ent.owner = self.owner

	if self.oid then
		ent.oid = self.oid
	end
	
	if IsValid(self.parent) and self.parent:GetClass() == "gms_gardenblock" then
		ent:SetAngles(self.parent:GetAngles())
		ent.slab = self.parent
	end
	ent:Spawn()
	ent:SetNetworkedString("Owner", "World")
	ent:SetParent(self.parent)
	self:Remove()
end

function ENT:GrowGold()
	local ent = ents.Create("gms_plantgold")
	ent.owner = self.owner
	ent:SetPos( self:GetPos() )
	ent:Spawn()
	ent:SetNetworkedString("Owner", "World")
	if not self.parent == "none" then
		ent:SetParent(self.parent)
	end
	
	self:Remove()
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end