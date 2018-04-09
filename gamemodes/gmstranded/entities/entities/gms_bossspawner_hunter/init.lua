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
	self:SetModel(SGS.proplist["harvester"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetColor(Color(255,255,255,255))
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetUseType(3)
	
	self.on = false
	self.summoned = false
	self.max = 10
	
	
end

function ENT:Use( ply )

	if not (GAMEMODE.Worlds:GetEntityWorldSpace( self ).BossSpawnPos) then
		ply:SendMessage("There doesn't seem to be any boss activity on this world.", 60, Color(255, 0, 0, 255))
		return
	end
	self.on = not self.on

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

	if self.on then
	
		local ED = EffectData()
		ED:SetOrigin( self:GetPos() + self:GetUp()*19 )
		util.Effect( 'cball_explode', ED )
		
		local ED = EffectData()
		ED:SetOrigin( self:GetPos() + self:GetUp()*19 )
		util.Effect( 'smoke_ring', ED )
		
		util.ScreenShake( self:GetPos(), 10, 10, 0.3, 750 )
		
		self:EmitSound( 'ambient/energy/spark' .. tostring(math.random(1,3)) .. '.wav', 140, math.Rand( 75, 125 ) )
		self:EmitSound( 'physics/body/body_medium_impact_soft4.wav', 180, math.Rand( 75, 150 ) )
		
		
		if math.random(1, self.max) == 1 and self.summoned == false then
			self.summoned = true
			self:Summon()
		else
			self.max = self.max - 1
		end
	end
	
	self:NextThink( CurTime() + 1.5 )
	return true;

end

function ENT:Summon()

	self.on = false
	SGS_SpawnHunterBoss()
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