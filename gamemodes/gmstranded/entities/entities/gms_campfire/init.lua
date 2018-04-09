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
	self:SetModel(SGS.proplist["campfire"])
	--self:SetMaterial("models/props_foliage/tree_deciduous_01a_trunk")
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetColor(Color(255,255,255,255))
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetUseType(3)
	
	self.dietime = CurTime() + 600

	--self:StartEffects( nil )

end

function ENT:StartEffects( ply )
	--[[
	local rfilter = RecipientFilter()
	if ply then
		rfilter:AddPlayer( ply )
	else
		rfilter:AddAllPlayers()
	end

	local ed = EffectData()
	ed:SetEntity( self )
	util.Effect( 'particle_luafire2', ed, true, rfilter )
	]]
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
--Called when an entity starts touching this SENT.
--Return: Nothing
function ENT:StartTouch(entEntity)
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()

	if CurTime() >= self.dietime then
		self:Remove()
		return
	end
	
	self:NextThink( CurTime() + 1 )
	return true;

end

--Called when an entity starts touching this SENT.
--Return: Nothing
function ENT:Touch( ent2 )
	if not ent2:IsPlayer() then return end
	if not SPropProtection.PlayerCanTouch(ent2, self) then return end
	if not ent2.lastburned_torch then ent2.lastburned_torch = CurTime() - 10 end
	if CurTime() < ent2.lastburned_torch + 1 then return end
	ent2:Burn( math.random(2, 5) )
	ent2.lastburned_torch = CurTime()
end
--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end