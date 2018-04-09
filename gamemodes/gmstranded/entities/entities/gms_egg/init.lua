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
	self:SetModel(SGS.proplist["egg"])
	self:SetMaterial("models/shiny")
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self.phys = self:GetPhysicsObject()
	self.roll = 0
	
	if self.phys:IsValid() then
		self.phys:Wake()
		self.phys:SetMass(20)
	end
	
	if self.NPCClass == "npc_headcrab" then
		self:SetColor( Color( 96, 69, 28, 255 ) )
		self.etype = "brown_pet_egg"
	elseif self.NPCClass == "npc_headcrab_fast" then
		self:SetColor( Color( 255, 93, 0, 255 ) )
		self.etype = "orange_pet_egg"
	elseif self.NPCClass == "npc_headcrab_black" then
		self:SetColor( Color( 29, 0, 255, 255 ) )
		self.etype = "blue_pet_egg"
	elseif self.NPCClass == "npc_vortigaunt" then
		self:SetColor( Color( 0, 118, 25, 255 ) )
		self.etype = "green_pet_egg"
	elseif self.NPCClass == "npc_dog" then
		self:SetColor( Color( 145, 145, 145, 255 ) )
		self.etype = "gray_pet_egg"
	elseif self.NPCClass == "npc_antlion" then
		self:SetColor( Color( 203, 33, 33, 255 ) )
		self.etype = "red_pet_egg"
	elseif self.NPCClass == "npc_antlionguard" then
		self:SetColor( Color( 255, 155, 255, 255 ) )
		self.etype = "pink_pet_egg"
	elseif self.NPCClass == "npc_crow" then
		self:SetColor( Color( 0, 0, 0, 255 ) )
		self.etype = "black_pet_egg"
	elseif self.NPCClass == "npc_pigeon" then
		self:SetColor( Color( 255, 242, 0, 255 ) )
		self.etype = "yellow_pet_egg"
	elseif self.NPCClass == "npc_seagull" then
		self:SetColor( Color( 255, 255, 255, 255 ) )
		self.etype = "white_pet_egg"
	elseif self.NPCClass == "npc_hunter" then
		self:SetColor( Color( 0, 255, 188, 255 ) )
		self.etype = "teal_pet_egg"
	end
	
	self.roll = 0
	
	if not IsValid(self.POwner) then
		self:Remove()
	end
	
	if self.NPCClass == nil then
		self.NPCClass = "npc_headcrab"
	end
	
	self:StartMotionController()
end

function ENT:Use( ply )
	if CurTime() > ply.lastuse + 0.5 then
		ply:AddResource( self.etype, 1 )
		self:Remove()
		ply.hasegg = false
		ply.lastuse = CurTime()
	end
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
	-- Do physics
	physobj:Wake()
	
	if self.roll <= 360 then
		self.roll = self.roll + 2
		if self.roll >= 360 then self.roll = 0 end
	end
	
	self:SetAngles(Angle(0,self.roll-180,0))

end

--Called when an entity starts touching this SENT.
--Return: Nothing
function ENT:StartTouch(entEntity)
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
	
	if not IsValid(self.POwner) then
		self:Remove()
	end
	
	self:NextThink(CurTime() + 1)
	return true
end

function ENT:Hatch()

	self:Remove()
	SGS_SpawnPet( self.NPCClass, self:GetPos(), self.POwner )
	
	if not IsValid(self.POwner) then return end
	if self.etype == "red_pet_egg" then
		self.POwner:AddStat( "pets1", 1 )
	elseif self.etype == "pink_pet_egg" then
		self.POwner:AddStat( "pets2", 1 )
	elseif self.etype == "white_pet_egg" then
		self.POwner:AddStat( "pets3", 1 )
	elseif self.etype == "yellow_pet_egg" then
		self.POwner:AddStat( "pets4", 1 )
	elseif self.etype == "black_pet_egg" then
		self.POwner:AddStat( "pets5", 1 )
	elseif self.etype == "orange_pet_egg" then
		self.POwner:AddStat( "pets6", 1 )
	elseif self.etype == "green_pet_egg" then
		self.POwner:AddStat( "pets7", 1 )
	elseif self.etype == "blue_pet_egg" then
		self.POwner:AddStat( "pets8", 1 )
	elseif self.etype == "brown_pet_egg" then
		self.POwner:AddStat( "pets9", 1 )
	elseif self.etype == "gray_pet_egg" then
		self.POwner:AddStat( "pets10", 1 )
	elseif self.etype == "teal_pet_egg" then
		self.POwner:AddStat( "pets12", 1 )
	end
	self.POwner:CheckForAchievements("headcrabhat")
end
--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end