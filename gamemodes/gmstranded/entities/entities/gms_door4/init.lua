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
	self:SetModel("models/props_phx/construct/metal_plate2x2.mdl")
	self:SetAngles(Angle(0,0,90))
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetColor(Color(255,255,255,255))
	
	self.state = 0
	self.stime = CurTime()
	
end


function ENT:Use( ply )
	if CurTime() > ply.lastuse + 0.5 then
	
		if self.state == 0 then
			self:OpenDoor()
		end
		ply.lastuse = CurTime()
		
	end
end

function ENT:OpenDoor()
	self.stime = CurTime() + 3
	self.state = 1
	self:SetColor(Color(255,255,255,60))
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:EmitSound(Sound("buttons/combine_button1.wav"), 80, math.random(80, 120))
end

function ENT:CloseDoor()
	self.state = 0
	self:SetColor(Color(255,255,255,255))
	self:SetCollisionGroup( COLLISION_GROUP_NONE )
	self:EmitSound(Sound("buttons/combine_button5.wav"), 80, math.random(80, 120))
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
	if self.state == 1 then
		if CurTime() >= self.stime then self:CloseDoor() end
	end
	self:NextThink(CurTime() + 0.1)
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