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
	
	self:DrawModel()
	self:CreateShadow()
	
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
		if self.res == nil then self.res = "ERROR" end
		if self.amt == nil then self.amt = 0 end
		if self.lastrequest == nil then self.lastrequest = CurTime() end
		
		if ( self.res == "ERROR" ) and ( self.lastrequest < ( CurTime() - 3 ) ) then
			self:RequestUpdate()
		end
		
		local FixAngles = self:GetAngles()
		local FixRotation = Vector(0, 270, 0)
		FixAngles:RotateAroundAxis(FixAngles:Right(), FixRotation.x)
		FixAngles:RotateAroundAxis(FixAngles:Up(), FixRotation.y)
		FixAngles:RotateAroundAxis(FixAngles:Forward(), FixRotation.z)
		local TargetPos = self:GetPos() + (self:GetUp() * 12)
		cam.Start3D2D(TargetPos, FixAngles, 0.125)
			local x = -80
			local y = -80
			draw.RoundedBox( 12, x, y, 160, 120, Color(0, 0, 0, sa) )
			draw.SimpleText("RESOURCE", "resource", x + 35, y + 2, Color(255,255,255,sa), 0, 0)
			draw.SimpleText("BOX", "resource", x + 63, y + 18, Color(255,255,255,sa), 0, 0)
			
			draw.SimpleText("Resource:", "resource2",x + 5 , y + 45, Color(255,255,255,sa), 0, 0)
			draw.SimpleText(self.res, "resource2",x + 5 , y + 55, Color(255,0,0,sa), 0, 0)
			
			draw.SimpleText("Resource:", "resource2",x + 5 , y + 75, Color(255,255,255,sa), 0, 0)
			draw.SimpleText(tostring(self.amt), "resource2",x + 5 , y + 85, Color(0,255,0,sa), 0, 0)
		cam.End3D2D()
	end
end

function ENT:RequestUpdate()

	self.lastrequest = CurTime()
	
	net.Start( "sgs_updateresourcebox" )
		net.WriteEntity( self )
	net.SendToServer()

end



--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	self.res = "ERROR"
	self.amt = 0
	self.lastrequest = CurTime() - 3
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