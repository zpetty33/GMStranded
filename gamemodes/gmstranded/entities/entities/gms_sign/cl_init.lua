include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH
--Called when it's time to draw the entity.
--Return: Nothing
function ENT:Draw()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if SGS.drawdistance == nil then return end
		if dis > SGS.drawdistance / 4 then 
		self:DestroyShadow()
		return 
	end
	self:CreateShadow()
	
	local pl = LocalPlayer()
	self.Entity:DrawModel()
	local sa = 1
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if dis <= 160000 then
		sa = 1
	elseif dis > 160000 and dis <= 360000 then
		sa = (dis - 160000) / 200
		sa = -sa + 1
	else
		sa = 0
	end
	sa = sa * 255
	
	if dis <= 360000 then
		local FixAngles = self.Entity:GetAngles()
		local FixRotation = Vector(90, 180, 180)
		FixAngles:RotateAroundAxis(FixAngles:Right(), FixRotation.x)
		FixAngles:RotateAroundAxis(FixAngles:Up(), FixRotation.y)
		FixAngles:RotateAroundAxis(FixAngles:Forward(), FixRotation.z)
		local TargetPos = self.Entity:GetPos() + (self.Entity:GetUp() * 12) + (self.Entity:GetForward() * 0.2)
		cam.Start3D2D(TargetPos, FixAngles, 0.125)
			local x = -10
			local y = -74
			draw.RoundedBox( 2, x, y, 220, 145, Color(0, 0, 0, sa) )
			draw.SimpleText( self:GetNWString("line1"), "sign", x+105 , y+10 , Color(255,255,255,sa), 1, 1)
			draw.SimpleText( self:GetNWString("line2"), "sign", x+105 , y+35 , Color(255,255,255,sa), 1, 1)
			draw.SimpleText( self:GetNWString("line3"), "sign", x+105 , y+60 , Color(255,255,255,sa), 1, 1)
			draw.SimpleText( self:GetNWString("line4"), "sign", x+105 , y+85 , Color(255,255,255,sa), 1, 1)
			draw.SimpleText( self:GetNWString("line5"), "sign", x+105 , y+110 , Color(255,255,255,sa), 1, 1)
		cam.End3D2D()
	end
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	self.line1 = "ABCDEFGHIJKLMNOP"
	self.line2 = "This is rediculo"
	self.line3 = "TEST LINE 3"
	self.line4 = "TEST LINE 4"
	self.line5 = "TEST LINE 5"
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