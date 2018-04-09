local meta = FindMetaTable( "Entity" )
local PlayerMeta = FindMetaTable("Player")

_R = debug.getregistry() --removal with no reason

--[[ net ]]--
function net.WriteByte( int ) --inconsistant/removal
	net.WriteInt( int, 8 )
end

function net.ReadByte() --inconsistant/removal
	return net.ReadInt( 8 )
end

function net.WriteBool( b ) --inconsistant
	net.WriteBit( b )
end

function net.ReadBool() --inconsistant
	return net.ReadBit() == 1
end

local _fIsValid = IsValid
function _G.IsValid( wut )
	local fuck, shit = pcall( _fIsValid, wut )

	if fuck then
		return shit
	else
		return false
	end
end

function meta:SetMaxHealth( var )
	self:SetNWInt("maxhealth", var)
end

function meta:GetMaxHealth()
	return self:GetNWInt("maxhealth", 100)
end

function meta:SetInitialized( var )
	self:SetNWInt("initstate", var)
end

function meta:GetInitialized()
	return self:GetNWInt("initstate", 0)
end