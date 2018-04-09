--[[
	Name: WHM (Weather Manager)
	File: cl_whm.lua
	For:
	By: Ultra
]]--

if not WHM then WHM = {} end
WHM.m_tblTypes 			= {}
WHM.m_tblActiveTypes 	= {}
local WHM_Think, WHM_RenderScreenspaceEffects

--[[ Registers a new type with WHM ]]--
function WHM:Register( tblType )
	if self.m_tblTypes[tblType.ID] then
		print( "[WHM:Register] Type conflict! will overwrite type id: ".. tblType.ID )	
	end

	self.m_tblTypes[tblType.ID] = tblType
end

--[[ Checks if a table is a valid WHM type ]]--
function WHM:ValidType( tbl )
	return tbl and tbl.ID and self.m_tblTypes[tbl.ID]
end

--[[ Returns a type table ]]--
function WHM:GetType( intTypeID )
	return self.m_tblTypes[intTypeID]
end

--[[ Checks if a type id is active ]]--
function WHM:IsTypeActive( intTypeID )
	return self.m_tblActiveTypes[intTypeID] and true or false
end

--[[ Starts a type and runs for intTime seconds before fading out. Pass -1 to run forever ]]--
function WHM:Start( intTypeID, intTime, intTimeOffset )
	if not self:ValidType( self:GetType(intTypeID) ) then print "wat" return end

	if not self:IsTypeActive( intTypeID ) then
		self.m_tblActiveTypes[intTypeID] = { Start = CurTime(), Length = intTime, }
		self:GetType( intTypeID ):Start( intTime, intTimeOffset )
	end
end

--[[ Stops a type, causing it to slowly fade out before stopping. Pass intTime to set fadeout speed ]]--
function WHM:Stop( intTypeID )
	if not self:ValidType( self:GetType(intTypeID) ) then return end
	if not self:IsTypeActive( intTypeID ) or self.m_tblActiveTypes[intTypeID].Stopping then return end

	self.m_tblActiveTypes[intTypeID].Stopping = true
	self.m_tblActiveTypes[intTypeID].StopTime = CurTime()
	self.m_tblActiveTypes[intTypeID].StopLength = intTime
	self:GetType( intTypeID ):FadeOut()
end

--[[ Forces a type to stop, skipping fade out, also called after :Stop() fade out is done to end ]]--
function WHM:ForceStop( intTypeID )
	if not self:ValidType( self:GetType(intTypeID) ) then return end

	self:GetType( intTypeID ):Stop()
	self.m_tblActiveTypes[intTypeID] = nil
end

function WHM:ForceStopAll()
	for k, v in pairs( self.m_tblActiveTypes ) do
		self:ForceStop( k )
	end
end

--[[ Hooks ]]--
local function WHM_Think()
	local cur_type

	for intTypeID, data in pairs( WHM.m_tblActiveTypes ) do
		cur_type = WHM:GetType( intTypeID )
		cur_type:Think( data )

		if (data.Length and data.Length ~= -1) and CurTime() > (data.Start +data.Length) then
			if not data.Stopping then
				WHM:Stop( intTypeID )
			end
		end
	end
end

local function WHM_RenderScreenspaceEffects()
	local cur_type

	for intTypeID, data in pairs( WHM.m_tblActiveTypes ) do
		cur_type = WHM:GetType( intTypeID )
		cur_type:RenderScreenspaceEffects()
	end
end

local function WHM_PostDrawTranslucentRenderables()
	local cur_type

	for intTypeID, data in pairs( WHM.m_tblActiveTypes ) do
		cur_type = WHM:GetType( intTypeID )
		cur_type:PostDrawTranslucentRenderables()
	end
end

hook.Add( "Think", "WHM:Think", WHM_Think )
hook.Add( "RenderScreenspaceEffects", "WHM:RenderScreenspaceEffects", WHM_RenderScreenspaceEffects )
hook.Add( "PostDrawTranslucentRenderables", "WHM:PostDrawTranslucentRenderables", WHM_PostDrawTranslucentRenderables )