include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH
--Called when it's time to draw the entity.
--Return: Nothing

local wave = Material( "sprites/gmdm_pickups/light" )

function ENT:Draw()

	if(not self.StartPos) then self.StartPos = self:GetPos() end; -- Needed for several workarounds
	local color = self:GetColor()
	local start = self:GetPos();

	render.SetMaterial(wave);
	render.DrawSprite( start, self.s, self.s, color	);
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	self.s = 64
	
	self.r = self:GetColor().r
	self.g = self:GetColor().g
	self.b = self:GetColor().b
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
	if dis > SGS.drawlights * 5 then return end
	if SGS.showlights == false then return end


	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.Pos = self:GetPos()
		dlight.r = self.r
		dlight.g = self.g
		dlight.b = self.b
		dlight.Brightness = 0.3
		dlight.MinLight = 0.05
		dlight.Size = 256	
		dlight.Decay = 210 * 2
		dlight.DieTime = CurTime() + 1
		dlight.Style = 5
	end
end