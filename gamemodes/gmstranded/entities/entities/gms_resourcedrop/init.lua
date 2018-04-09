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
	self:SetModel(SGS.proplist["resourcedrop"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor(Color(255, 255, 255, 255))
	self:SetMaterial("models/props_wasteland/wood_fence01a")
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetUseType(3)
 	self.rType = "Resource"
 	self.rAmt = 0
	
	self.contents = {}
	self.submerged = false
	
	self.die = "NO"
	
	self.cb = true
	
	local physics = self:GetPhysicsObject()
	if ( physics:IsValid() ) then
		physics:SetMaterial( "wood" )
		physics:Wake()
	end
end

function ENT:CrashSaveData()
	-- Not sure which is important pres
	return {contents=self.contents, rType=self.rType, rAmt=self.rAmt}
end

function ENT:OnCrashRecovery( data )
	-- Not sure which is important pres - also you stored rAmt and rAmount
	-- and used rAmount in some places and rAmt everywhere else...
	self.contents = data.contents
	self.rType = data.rType
	self.rAmt = data.rAmt
end

function ENT:SetResourceDropInfo( rType, rAmt )

	self.contents[rType] = rAmt
	self.rType = rType
	self.rAmt = rAmt

end

function ENT:Use( ply )
	
	if ply.curinv >= ply.maxinv then
		ply:SendMessage("Your inventory is full!", 60, Color(255, 0, 0, 255))
		ply.lastuse = CurTime()
		return
	end
	
	if self.rAmt > ply.maxinv - ply.curinv then
		takeAmt = ply.maxinv - ply.curinv
		ply:AddResource( self.rType, takeAmt )
		self.rAmt = self.rAmt - takeAmt
		self:SetResourceDropInfo( self.rType, self.rAmt )
		SGS_SetupDrop( self, self.rType, self.rAmt )
		SGS.Log("** " .. takeAmt .. "x of " .. self.rType .. " was taken from a resource box by " .. ply:Nick() .. "!")
		return
	end
	
	for k, v in pairs( self.contents ) do
		self.cb = false
		ply:AddResource( k, v )
	end

	SGS.Log("** The resource box containing " .. self.rAmt .. "x of " .. self.rType .. " was picked up by " .. ply:Nick() .. "!")
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
	if self.enabled == false then return end
	
	if entEntity:GetClass() == "gms_resourcedrop" and entEntity.rType == self.rType then
		big_gms_combineresource(self,entEntity)
	end
end	
	
--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
		
	local f_ents = ents.FindInSphere(self:GetPos(), 60)
	local f_num = 0
	
	for _, v in pairs(f_ents) do
		if v:GetClass() == "gms_resourcedrop" then
			if v.rtype == self.rtype then
				f_num = f_num + 1
			end
		end
	end
	
	if f_num >= 3 then 
		self:SetColor(Color(200, 200, 200, 180))
		self.enabled = false
	else
		self:SetColor(Color(255, 255, 255, 255))
		self.enabled = true
	end
	
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
			SGS.Log("** The resource box containing " .. self.rAmt .. "x of " .. self.rType .. " was removed for being under water!")
			SafeRemoveEntity( self )
		end
	end

	self:NextThink( CurTime() + 0.2 )
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