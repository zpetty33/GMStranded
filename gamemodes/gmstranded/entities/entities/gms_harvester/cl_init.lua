include("shared.lua")

--Called when it's time to draw the entity.
--Return: Nothing
function ENT:Draw()
	self.Entity:DrawModel()
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
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