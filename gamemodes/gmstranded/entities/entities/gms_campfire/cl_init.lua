include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH

--Called when it's time to draw the entity.
--Return: Nothing
ENT.rotate = 0
function ENT:Draw()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if SGS.drawdistance == nil then return end
	if dis > SGS.drawdistance / 8 then 
		self:DestroyShadow()
		return 
	end
	self:CreateShadow()
	self.Entity:DrawModel()
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	local ed = EffectData()
	ed:SetEntity( self )
	util.Effect( 'particle_luafire2', ed, true, rfilter )
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
	if dis > SGS.drawlights then return end
	if SGS.showlights == false then return end

	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.Pos = self:GetPos() + Vector(0,0,35)
		dlight.r = 255
		dlight.g = 100
		dlight.b = 50
		dlight.Brightness = 1.5
		dlight.MinLight = 0.01
		dlight.Size = 900	
		dlight.Decay = 210 * 2
		dlight.DieTime = CurTime() + 1
		dlight.Style = 6
	end
end

