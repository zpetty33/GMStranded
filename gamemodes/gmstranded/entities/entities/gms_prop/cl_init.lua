include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH
--Called when it's time to draw the entity.
--Return: Nothing
function ENT:Draw()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if SGS.drawdistance == nil then return end
	if dis > SGS.drawdistance then 
		if self.shadowcreated then
			self:DestroyShadow()
			self:DrawShadow( false )
			self.shadowcreated = false
		end
		return 
	end
	if not self.shadowcreated then
		self:DrawShadow( true )
		self.shadowcreated = true
	end
	self:CreateShadow()
	self.Entity:DrawModel()
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	self.shadowcreated = false
end

--Return true if this entity is translucent.
--Return: Boolean
function ENT:IsTranslucent()
end

--Called when a save-game is loaded.
--Return: Nothing
function ENT:OnRestore()
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
end