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
	self:SetModel(SGS.proplist["incubator"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetUseType(3)
	self.spawning = true
	self.EdTime = CurTime() + self.ToTime
	
	self.eggstart = CurTime()
	
	self.egginterval = 30
	--self.egginterval = 5
	
end

function ENT:AttachEgg( ply, npc_class )
	NPCEgg = ents.Create( "gms_egg" )
	NPCEgg.POwner = ply
	NPCEgg.NPCClass = npc_class
	NPCEgg:SetPos( self:LocalToWorld(Vector(0,-32,20) ) )
	NPCEgg.SpawnTime = CurTime()
	NPCEgg.HatchTime = math.random( 300, 400 )
	NPCEgg.EndTime = NPCEgg.SpawnTime + NPCEgg.HatchTime
	NPCEgg:Spawn()
	NPCEgg:SetModelScale( 0.3, 0)

	NPCEgg:SetParent( self )
	NPCEgg:CPPISetOwner(ply)
	
	ply.hasegg = true
	
	self.inuse = true
	self.eggstart = CurTime()
	self.attachedegg = NPCEgg
end

function ENT:EggGrowth( ent )

	if not IsValid( ent ) then
		self.inuse = false
		return
	end
	
	if ent:GetModelScale() >= 0.9 then
		self:EggHatch( self.attachedegg )
		return
	end
	
	self:EmitSound(Sound("items/suitchargeok1.wav"), 40, math.random(90, 110))
	ent:SetModelScale( ent:GetModelScale() + 0.2, 0 )
	
	self.eggstart = CurTime()


end

function ENT:EggHatch( ent )

	if not IsValid( ent ) then
		self.inuse = false
	end
	
	self.inuse = false
	ent:Hatch()

end


function ENT:Use( ply )

	if CurTime() > ply.lastuse + 1 then
		ply.lastuse = CurTime()
		ply:SendLua( "SGS_IncubatorMenu()")
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
	
	if self.inuse then
		if not IsValid(self.attachedegg) then
			self.inuse = false
		end
		
		if CurTime() > self.eggstart + self.egginterval then
			self:EggGrowth(self.attachedegg)
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