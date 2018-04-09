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

 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON  )
	self:SetColor(Color(255,255,255,255))

	self:SetUseType(3)
	self.submerged = false

end

function ENT:Use( ply )

	ply:AddTool( self.tooltype )
	ply:SendMessage("You picked up a " .. SGS_ReverseToolLookup( self.tooltype ).title .. "!", 60, Color(0, 255, 50, 255))
	SGS.Log("** " .. ply:Nick() .. " picked up a " .. SGS_ReverseToolLookup( self.tooltype ).title .. "!")
	self:Remove()

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
	if self.submerged == false then
		if self:WaterLevel() > 0 then
			self.submerged = true
			self.submergedtime = CurTime()
		end
	else
		if self:WaterLevel() == 0 then
			self.submerged = false
		end
	end
	
	if self.submerged == true then
		if CurTime() > self.submergedtime + 180 then
			SafeRemoveEntity( self )
		end
	end
	
	self:NextThink( CurTime() + 0.5 )
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