include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH
--Called when it's time to draw the entity.
--Return: Nothing

ENT.Glow = SGS.MaterialFromVMT(
	"StaffGlow",
	[["UnLitGeneric"
	{
		"$basetexture"		"models/debug/debugwhite"
	}]]
);
function ENT:Draw()

	local pos = self:GetPos()
	
	render.SetMaterial(self.Glow)
	render.DrawSprite(
			pos,
			16, 16,
			Color(255,0,0,255)
		)
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