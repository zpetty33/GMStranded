AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	-- The XQM Afterburner model
	self:SetModel("models/XQM/AfterBurner1.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass(75) -- Heavy enough to anchor the raft
		phys:Wake()
	end
	
	-- REQUIRED: Tells the entity to use the smooth PhysicsSimulate function
	self:StartMotionController()
	
	self.IsOn = false
	self.MaxFuel = 1000
	self.FuelPerCoal = 250
	
	-- Network these variables so the client-side 3D text and particles can read them
	self:SetNWInt("Fuel", 0)
	self:SetNWBool("IsOn", false)
end

function ENT:Use(activator, caller)
	if not IsValid(activator) or not activator:IsPlayer() then return end

	-- SHIFT + E: Refuel the Engine
	if activator:KeyDown(IN_SPEED) then
		
		-- Use GMStranded's native inventory check
		if activator:GetResource("coal") >= 1 then
			local currentFuel = self:GetNWInt("Fuel", 0)
			
			if currentFuel < self.MaxFuel then
				-- Take 1 coal from the player
				activator:SubResource("coal", 1) 
				
				local newFuel = math.Clamp(currentFuel + self.FuelPerCoal, 0, self.MaxFuel)
				self:SetNWInt("Fuel", newFuel)
				
				self:EmitSound("ambient/materials/rock_scrape.wav", 75, 100)
			else
				activator:PrintMessage(HUD_PRINTCENTER, "Furnace is full!")
			end
		else
			activator:PrintMessage(HUD_PRINTCENTER, "You need Coal in your inventory to fuel this!")
		end

	-- REGULAR E: Toggle On/Off
	else
		-- Prevent spamming the button
		if (self.NextToggle or 0) > CurTime() then return end
		self.NextToggle = CurTime() + 1
		
		local currentFuel = self:GetNWInt("Fuel", 0)
		
		if currentFuel <= 0 then
			self:EmitSound("buttons/button10.wav", 75, 100)
			activator:PrintMessage(HUD_PRINTCENTER, "Out of Fuel!")
			return
		end

		self.IsOn = not self.IsOn
		self:SetNWBool("IsOn", self.IsOn)
		
		if self.IsOn then
			self:EmitSound("vehicles/airboat/engine_start.wav", 75, 100)
		else
			self:EmitSound("vehicles/airboat/engine_stop.wav", 75, 100)
		end
	end
end

-- Smooth Physics Propulsion
function ENT:PhysicsSimulate( phys, deltatime )
	if not self.IsOn then return SIM_NOTHING end
	if self:GetNWInt("Fuel", 0) <= 0 then return SIM_NOTHING end

	local ThrusterWorldPos = phys:GetPos()
	
	-- FIXED: XQM models push along their Up axis (Z-axis). 
	-- Adjust the 50000 to make the ship faster/slower
	local ThrusterWorldForce = self:GetUp() * -50000 
	
	-- Calculates how to push the ship based on where the engine is welded
	local linear, angular = phys:CalculateVelocityOffset( ThrusterWorldForce, ThrusterWorldPos )
	
	return angular, phys:WorldToLocalVector(linear), SIM_LOCAL_ACCELERATION
end

-- Fuel Drain Logic
function ENT:Think()
	if self.IsOn then
		local currentFuel = self:GetNWInt("Fuel", 0)
		
		if currentFuel > 0 then
			self:SetNWInt("Fuel", currentFuel - 1)
			self:NextThink(CurTime() + 0.2)
			return true
		else
			-- Engine dies when empty
			self.IsOn = false
			self:SetNWBool("IsOn", false)
			self:EmitSound("vehicles/airboat/engine_stop.wav", 75, 80)
		end
	end
end