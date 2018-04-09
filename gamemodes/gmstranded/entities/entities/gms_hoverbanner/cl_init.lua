include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH

--Called when it's time to draw the entity.
--Return: Nothing
ENT.rotate = 0
function ENT:Draw()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if SGS.drawdistance == nil then return end
		if dis > SGS.drawdistance / 4 then 
		self:DestroyShadow()
		return 
	end
	self:CreateShadow()
	self.Entity:DrawModel()
	
	if self.rotate >= 360 then
		self.rotate = 0
	end
	self.rotate = self.rotate + 0.2
	
	local r1 = self.rotate
	local r2 = self.rotate - 180
	
	local TargetPos = self.Entity:GetPos() + (self.Entity:GetUp() * 50)
	cam.Start3D2D(TargetPos, Angle(9,90,90), 0.25)
		surface.SetDrawColor( 255, 255, 255, 255 );
		surface.SetMaterial( Material("vgui/banner.png") )
		surface.DrawTexturedRect( -260, 0, 519, 105 )
	cam.End3D2D()
	
	--[[
	local TargetPos = self.Entity:GetPos() + (self.Entity:GetUp() * 50)
	cam.Start3D2D(TargetPos, Angle(0,0,90), 0.25)
		surface.SetDrawColor( 255, 255, 255, 255 );
		surface.SetMaterial( Material("vgui/banner.png") )
		surface.DrawTexturedRect( -260, 0, 519, 105 )
	cam.End3D2D()
	]]
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

