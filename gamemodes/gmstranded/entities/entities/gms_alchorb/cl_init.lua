include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH
--Called when it's time to draw the entity.
--Return: Nothing

ENT.Glow = SGS.MaterialFromVMT(
	"StaffGlow",
	[["UnLitGeneric"
	{
		"$basetexture"		"sprites/light_glow01"
		"$nocull" 1
		"$additive" 1
		"$vertexalpha" 1
		"$vertexcolor" 1
	}]]
);
ENT.Shaft = Material("effects/ar2ground2");
ENT.LightSettings = "cl_staff_dynlights_flight";

function ENT:Draw()

	if(not self.StartPos) then self.StartPos = self:GetPos() end; -- Needed for several workarounds
	local color = self:GetColor()
	local start = self:GetPos();

	render.SetMaterial(self.Glow);
	for i =1,2 do
		render.DrawSprite(
			start,
			self.s,self.s,
			color
		);
	end
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	self.s = 32
	self.grow = 1
	self.Created = CurTime();
	self.Sizes={self.s,self.s,180}; -- X,Y and shaft-leght!
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

	if self.grow == 1 then
		if self.s <= 64 then
			self.s = self.s + 2
		else
			self.s = 64
			self.grow = 0
		end
	else
		if self.s >= 32 then
			self.s = self.s - 2
		else
			self.s = 32
			self.grow = 1
		end
	end
end