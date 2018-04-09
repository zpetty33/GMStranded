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
	self:SetModel(SGS.proplist["metal_workbench"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self.spawning = true
	self.EdTime = CurTime() + self.ToTime
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetUseType(3)
end

function ENT:Use( ply )

	if CurTime() > ply.lastuse + 1 then
		trace = ply:TraceFromEyes(100)
		if not IsValid(trace.Entity) then
			ply.lastuse = CurTime()
			return
		end
		ply:SendLua( "SGS_EnchantedSmithingMenu()")
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
	if self.spawning then
		local x = (self.EdTime - CurTime()) / self.ToTime
		x = -x + 1
		local a = math.Clamp( ( x * 255 ), 0, 255)
		
		self:SetColor(Color(255, 255, 255, a))
		
		if a >= 255 then
			self.spawning = false
		end
	end
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end