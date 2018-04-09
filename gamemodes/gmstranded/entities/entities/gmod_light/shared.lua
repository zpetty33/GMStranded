

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName		= ""
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false



function ENT:SetBrightness( _in_ )
	self:SetNetworkedVar( "Brightness", _in_ )
end

function ENT:GetBrightness()
	return self:GetNetworkedVar( "Brightness", 1 )
end


function ENT:SetLightSize( _in_ )
	self:SetNetworkedVar( "LightSize", _in_ )
end

function ENT:GetLightSize()
	return self:GetNetworkedVar( "LightSize", 256 )
end
	

function ENT:SetOn( _in_ )
	self:SetNetworkedBool( "Enabled", _in_ )
end

function ENT:GetOn()
	return self:GetNetworkedVar( "Enabled", true )
end
