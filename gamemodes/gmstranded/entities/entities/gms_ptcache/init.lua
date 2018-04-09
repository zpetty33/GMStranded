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
	self:SetModel(SGS.proplist["tcache"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetTrigger( true )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMaterial( "models/props_wasteland/wood_fence01a" )
	self.mat = "models/props_wasteland/wood_fence01a"
	self:SetColor(Color(100, 100, 100,255))
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetUseType(3)

	self.enabled = false

	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false) -- Freezes the object in place.
	end
	
	self.lastent = nil
end

function ENT:SetResourceDropInfo( rType, rAmt )

	self.POwner.ptcontents[rType] = (self.POwner.ptcontents[rType] or 0) + rAmt

end

function ENT:GetTotalResources()

	if self.POwner.ptcontents then

		local total = 0
		for k, v in pairs( self.POwner.ptcontents ) do
			total = total + v
		end
		return total
		
	end
	
end

function ENT:Use( ply )

	if CurTime() < ply.lastuse + 1 then return end
	
	if self.enabled == false then 
		ply:SendMessage("This cache is disabled!", 60, Color(255, 255, 0, 255))
		ply.lastuse = CurTime()
		return 
	end

	net.Start("UpdateTCacheTable")
		net.WriteTable( self.POwner.ptcontents )
	net.Send( ply )
	
	net.Start("sgs_opentcache")
		net.WriteString( "p" )
	net.Send( ply )
	
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
function ENT:StartTouch(ent2)

end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()

		local f_ents = ents.FindInSphere(self:GetPos(), 120)
		local f_num = 0
		
		for _, v in pairs(f_ents) do
			if v:GetClass() == "gms_tcache" or v:GetClass() == "gms_ptcache" then
				f_num = f_num + 1
			end
		end
		
		if f_num >= 2 then 
			self:SetColor(Color(200, 200, 200, 180))
			self.enabled = false
		else
			self:SetColor(Color(100, 100, 100,255))
			self.enabled = true
		end
		
		
		local oc = false
		for k, v in pairs( player.GetAll() ) do
		
			if v:GetPlayerID() == self.POwner64 then
				oc = true

				self.POwner = v
				if self.POwner.ptcontents == nil then
					self.POwner.ptcontents = {}
				end

				break
			end
			oc = false
		
		end
		
		self.enabled = oc
		self:NextThink( CurTime() + 0.5 )
		return true

end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:StartTouch(ent2)

	if self.enabled == false then return end
	
	if self:GetTotalResources() >= 25 then return end
	
	if ent2:GetClass() == "gms_tool" and ent2 != self.lastent then
		self:SetResourceDropInfo( ent2.tooltype, 1 )
		self.lastent = ent2
		ent2:Remove()
	end
	
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end