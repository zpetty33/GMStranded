include("shared.lua")

ENT.RenderGroup = RENDERGROUP_BOTH

-- The Volumetric Coal Smoke Generator
function ENT:Think()
	if self:GetNWBool("IsOn", false) then
		
		self.SmokeTimer = self.SmokeTimer or 0
		if CurTime() > self.SmokeTimer then
			self.SmokeTimer = CurTime() + 0.015 

			-- FIXED: Shifted down the Z-axis to the nozzle
			local vOffset = self:GetPos() - self:GetUp() * 25
			-- FIXED: Smoke shoots out the bottom
			local vNormal = self:GetUp() * 1 

			local emitter = ParticleEmitter(vOffset, false)
			if IsValid(emitter) then
				local particle = emitter:Add("particles/smokey", vOffset + VectorRand() * 5)
				if particle then
					-- Shoot the smoke backwards out of the nozzle
					particle:SetVelocity(vNormal * math.Rand(150, 250) + VectorRand() * 20)
					particle:SetDieTime(2.0)
					particle:SetStartAlpha(math.Rand(150, 200))
					particle:SetStartSize(math.Rand(15, 25))
					particle:SetEndSize(math.Rand(64, 100))
					particle:SetRoll(math.Rand(-0.2, 0.2))
					particle:SetColor(40, 40, 45) -- Dark coal smoke
				end
				emitter:Finish()
			end
		end
	end
end

-- The Holographic Status UI
function ENT:Draw()
	self:DrawModel()

	local fuel = self:GetNWInt("Fuel", 0)
	local isOn = self:GetNWBool("IsOn", false)
	local maxFuel = 1000

	-- FIXED: Hovers off to the side of the engine so it doesn't clip
	local pos = self:GetPos() + self:GetRight() * 25 + self:GetUp() * 10
	local ang = self:GetAngles()
	
	-- Math to make the 3D text always face the player looking at it
	local plyAng = LocalPlayer():EyeAngles()
	ang = Angle(0, plyAng.y - 90, 90)

	cam.Start3D2D(pos, ang, 0.1)
		
		-- Translucent black background box
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(-100, -30, 200, 60)

		-- Dynamic ON/OFF text color
		local statusText = isOn and "ENGINE ON" or "ENGINE OFF"
		local statusColor = isOn and Color(0, 255, 0) or Color(255, 0, 0)
		
		draw.SimpleText(statusText, "Trebuchet24", 0, -15, statusColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("Coal Fuel: " .. fuel .. "/" .. maxFuel, "Trebuchet24", 0, 15, Color(255, 200, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		
	cam.End3D2D()
end