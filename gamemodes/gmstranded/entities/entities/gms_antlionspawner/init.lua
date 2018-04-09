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
	
	self.total = math.random(1,3)
	
	self.shoulddraw = true
end

function ENT:Use( ply )

end

function ENT:SpawnAntlion()

	if math.random(1,4) >= 2 then
		return
	end
	
	local locallions = 0
	for k, v in pairs( ents.FindInSphere(self:GetPos(), 1000) ) do
		if v:GetClass() == "npc_antlion" then
			locallions = locallions + 1
		end
	end
	
	if locallions > self.total then return end
	
	local globallions = 0
	for k, v in pairs( ents.FindByClass("npc_antlion") ) do
	
		if v.ispet == false then
			globallions = globallions + 1
		end
	
	end
	
	if globallions >= SGS.totallions then return end

	local tries = 50
	
	for i = 1, tries do
	
		cpos = self:GetPos()
		npos = cpos + Vector(math.random(-500,500), math.random(-500,500), 400)
		
		local trace = {}
		trace.start = npos
		trace.endpos = trace.start + Vector(0,0,-600)
		trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
		trace.filter = self
		
		local tr = util.TraceLine(trace)
		
		if tr.Hit then
	
			if tr.MatType == MAT_SLOSH then
			else
				if tr.HitWorld then
					npos = tr.HitPos + Vector(0,0,10)
					SGS_MakeCreature( "npc_antlion", npos, nil )
					break
				else
					
				end
			end
		end
	
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
--Called when an entity starts touching this SENT.
--Return: Nothing
function ENT:StartTouch(entEntity)
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
	if SGS.inedit then
		if self.shoulddraw == false then
			self.shoulddraw = true
			self:SetNWBool("draw", true)
			self:PhysicsInit( SOLID_VPHYSICS )
			self:SetSolid( SOLID_VPHYSICS )
			self:SetColor(Color(255,255,255,255))
		end
	else
		if self.shoulddraw == true then
			self.shoulddraw = false
			self:SetNWBool("draw", false)
			self:PhysicsInit( SOLID_NONE )
			self:SetSolid( SOLID_NONE )
			self:SetColor(Color(255,255,255,0))
		end
	end
	
	if math.random(1,10) == 1 then
		self:SpawnAntlion()
	end
	
	self:NextThink(CurTime() + 1)
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