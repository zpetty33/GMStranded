AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.NoAutoClose = true;

--Called when an entity is no longer touching this SENT.
--Return: Nothing
function ENT:EndTouch(entEntity)
end

--Called when the SENT is spawned
--Return: Nothing

function ENT:Initialize()
	self:SetModel("models/props_c17/Frame002a.mdl")
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor(Color(255, 255, 255, 255))
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetUseType(3)
	
	self:SetNWString("line1", "Press Use")
	self:SetNWString("line2", "On this sign")
	self:SetNWString("line3", "")
	self:SetNWString("line4", "to set the")
	self:SetNWString("line5", "lines of text.")
end


function ENT:Use( ply )

	if CurTime() < ply.lastuse + 0.5 then return end
	
	local dis = ply:GetShootPos():DistToSqr(self:GetPos())
	

	if dis > 5625 then
		ply.lastuse = CurTime()
		return
	end
	
	ply:SetNWInt("sign", self:EntIndex())
	ply:SendLua("SGS_SignMenu()")
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

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end