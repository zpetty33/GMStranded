include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH
--Called when it's time to draw the entity.
--Return: Nothing

function ENT:Draw()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if dis > 640000 then return end
	
	self:CreateShadow()
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
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if dis > 640000 then return end
	if SGS.showlights == false then return end

	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.Pos = self:LocalToWorld(Vector(15,-40, 10) )
		dlight.r = 255
		dlight.g = 255
		dlight.b = 255
		dlight.Brightness = 0.9
		dlight.MinLight = 0.1
		dlight.Size = 80	
		dlight.Decay = 10
		dlight.DieTime = CurTime() + 0.5
		dlight.Style = 6
	end
	
end