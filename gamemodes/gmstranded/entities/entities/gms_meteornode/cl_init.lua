include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH
--Called when it's time to draw the entity.
--Return: Nothing
function ENT:Draw()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if SGS.drawdistance == nil then return end
		if dis > SGS.drawdistance then 
		self:DestroyShadow()
		return 
	end
	self:CreateShadow()
	self.Entity:DrawModel()
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	self:CreateVortex()
end

function ENT:CreateVortex()
	self.vortex = ents.CreateClientProp()
	self.vortex:SetPos( self:GetPos() )
	self.vortex:SetModel( "models/effects/portalfunnel.mdl" )
	self.vortex:SetParent( self )
	self.vortex:Spawn()
	
	self.vortex:SetModelScale( 0.8, 0 )
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

function ENT:OnRemove()
	if IsValid( self.vortex ) then
		self.vortex:Remove()
	end
end