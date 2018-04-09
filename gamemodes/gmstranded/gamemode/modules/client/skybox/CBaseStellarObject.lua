Class "CBaseStellarObject" : Namespace "SkyObj" {
	m_strBodyName = "",

	--Config constants
	m_int2PI = math.pi *2,
	m_intRad = (math.pi /180),
	m_intMaxPolyLOD = 36,
	m_intMinPolyLOD = 8,

	--Physical characteristics
	m_intAge 			= 0,
	m_intRadius 		= 2,
	m_intMass			= 0,
	m_intTemp			= 0,

	--Render bits
	m_angRotation		= Angle( 0, 0, 0 ),
	m_angTilt 			= Angle( 0, 0, 0 ),
	m_vecPos 			= Vector( 0, 0, 0 ),
	m_colColor 			= Color( 255, 255, 255, 255 ),
	m_matSurfaceTexture = Material( "debug/debugvertexcolor" ),
	
	m_tblAtmosphereLayers 	= {},
	m_pLightSource			= nil,
	m_bNoDraw 				= false,

	--Stranded stuff
	m_tblDayData = {
		Start = 1230,
		End = 360,
		Length = 1440,
		StartTime = nil,
		StartOffset = nil,
	},
	m_intRiseAng = 80,
	m_intSetAng = -260,
	m_intRotationR = 90,
	m_intRotationY = 0,

	--Orbit-ey space-ey bits
	m_pParentBody 	= nil,
	m_tblOrbitData = {},

	TYPE_UNKNOWN = -1,
	TYPE_STAR = 0,
	TYPE_PLANET = 1,
}

function SkyObj.CBaseStellarObject:Initialize()
	self.m_strHookID = "CBaseStellarObject:".. tostring( self ).. tostring(math.random(-16384, 16384))
	hook.Add( "Tick", self.m_strHookID, function()
		self:Tick()
	end )
	hook.Add( "DayLightUpdateTime", self.m_strHookID, function( intMin )
		self:DayLightUpdateTime( intMin )
	end )
	hook.Add( "sgs_timeupdate", self.m_strHookID, function( intTime )
        self.m_tblDayData.StartTime = nil
        self:DayLightUpdateTime( intTime )
	end )

end

function SkyObj.CBaseStellarObject:OnRemove()
	hook.Remove( "Tick", self.m_strHookID )
	hook.Remove( "DayLightUpdateTime", self.m_strHookID )
	hook.Remove( "sgs_timeupdate", self.m_strHookID )
end

function SkyObj.CBaseStellarObject:SetPos( vec_or_x, y, z )
	if type( vec_or_x ) == "number" then
		self.m_vecPos.x = vec_or_x
		self.m_vecPos.y = y
		self.m_vecPos.z = z
	else
		self.m_vecPos = vec_or_x
	end
end

function SkyObj.CBaseStellarObject:GetPos()
	return self.m_vecPos
end

function SkyObj.CBaseStellarObject:SetColor( col_r, g, b, a )
	if type( col_r ) == "number" then
		self.m_colColor.r = col_r
		self.m_colColor.g = g
		self.m_colColor.b = b
		self.m_colColor.a = a
	else
		self.m_colColor = col_r
	end
end

function SkyObj.CBaseStellarObject:GetColor()
	return self.m_colColor
end

function SkyObj.CBaseStellarObject:SetSurfaceTexture( strTexturePath )
	self.m_matSurfaceTexture = Material( strTexturePath )
	self.m_strSurfaceTexture = strTexturePath
end

function SkyObj.CBaseStellarObject:GetSurfaceTexture()
	return self.m_matSurfaceTexture
end

function SkyObj.CBaseStellarObject:SetMass( intMass )
	self.m_intMass = intMass
end

function SkyObj.CBaseStellarObject:GetMass()
	return self.m_intMass
end

function SkyObj.CBaseStellarObject:SetAge( intYears )
	self.m_intAge = intYears
end

function SkyObj.CBaseStellarObject:GetAge()
	return self.m_intAge
end

function SkyObj.CBaseStellarObject:SetTemp( intTemp )
	self.m_intTemp = intTemp
end

function SkyObj.CBaseStellarObject:GetTemp()
	return self.m_intTemp
end

function SkyObj.CBaseStellarObject:SetRadius( intRad )
	self.m_intRadius = intRad
end

function SkyObj.CBaseStellarObject:GetRadius()
	return self.m_intRadius
end

function SkyObj.CBaseStellarObject:SetNoDraw( bNoDraw )
	self.m_bNoDraw = bNoDraw
end

function SkyObj.CBaseStellarObject:GetNoDraw()
	return self.m_bNoDraw
end

function SkyObj.CBaseStellarObject:SetName( strStarName )
	self.m_strBodyName = strStarName
end

function SkyObj.CBaseStellarObject:GetName()
	return self.m_strBodyName
end

function SkyObj.CBaseStellarObject:SetTilt( angTilt )
	self.m_angTilt = angTilt
end

function SkyObj.CBaseStellarObject:GetTilt()
	return self.m_angTilt
end

function SkyObj.CBaseStellarObject:SetRotation( angRotation )
	self.m_angRotation = angRotation
end

function SkyObj.CBaseStellarObject:GetRotation()
	return self.m_angRotation
end

function SkyObj.CBaseStellarObject:SetRotationOverride( angRotation )
	self.m_angOverride = angRotation
end

function SkyObj.CBaseStellarObject:GetRotationOverride()
	return self.m_angOverride
end

function SkyObj.CBaseStellarObject:SetParentBody( insStellarObject )
	self.m_pParentBody = insStellarObject
end

function SkyObj.CBaseStellarObject:GetParentBody()
	if self.m_strParentName and not self.m_pParentBody then
		self:SetParentBody( GAMEMODE.Sky:FindObject(self.m_strParentName) )
	end
	
	return self.m_pParentBody
end

function SkyObj.CBaseStellarObject:SetLightSource( insStellarObject )
	self.m_pLightSource = insStellarObject
end

function SkyObj.CBaseStellarObject:GetLightSource()
	return self.m_pLightSource
end

function SkyObj.CBaseStellarObject:AddAtmosphereLayer( strMatPath, colColor, intExtraRadius, funcRender )
	self.m_tblAtmosphereLayers[#self.m_tblAtmosphereLayers +1] = {
		Mat = strMatPath and Material( strMatPath ) or nil,
		Color = colColor,
		Radius = intExtraRadius,
		RenderFunc = funcRender,
	}

	return self.m_tblAtmosphereLayers[#self.m_tblAtmosphereLayers]
end

function SkyObj.CBaseStellarObject:GetAtmosphereLayer( intLayer )
	return self.m_tblAtmosphereLayers[intLayer]
end

function SkyObj.CBaseStellarObject:GetAtmosphereLayers()
	return self.m_tblAtmosphereLayers
end

function SkyObj.CBaseStellarObject:PickSurfacePoint( intU, intV, intRad )
	local phi = self.m_int2PI *(intU or math.random())
	local theta = 2 *math.asin( math.sqrt(intV or math.random()) )

	local x = (intRad or self.m_intRadius) *math.sin(theta)
	local y = x *math.sin(phi)
	x = x *math.cos(phi)
	local z = (intRad or self.m_intRadius) *math.cos(theta)

	return Vector( x, y, z )
end

--[[ Orbital Stuff ]]--
--Define an orbit around the parent body
function SkyObj.CBaseStellarObject:DefineOrbit( intRadius, intInclination )
	self.m_tblOrbitData = {
		Radius = intRadius,
		StartTime = CurTime(),
		TimeOffset = 0,
		Elevation = 0,
		Inclination = intInclination,
	}
end

--Converts spherical coordinates of orbit data to cartesian coordinates
function SkyObj.CBaseStellarObject:ComputeOrbitPos()
	local data = self.m_tblOrbitData
	local i = 90 *self.m_intRad
	local x = data.Radius *math.sin(i) *math.cos(data.Elevation)
	local y = data.Radius *math.sin(i) *math.sin(data.Elevation)
	local z = 0
	
	local xo = x
	local yo = y *math.cos(data.Inclination) -z *math.sin(data.Inclination)
	local zo = y *math.sin(data.Inclination) +z *math.cos(data.Inclination)

	local yRot, zRot = self.m_intRotationY, self.m_intRotationR
	yRot = yRot *self.m_intRad
	zRot = zRot *self.m_intRad
	local xr = math.cos(yRot) *math.cos(zRot) *xo +math.sin(zRot) *yo +math.sin(yRot) *math.cos(zRot) *zo
	local yr = -math.cos(yRot) *math.sin(zRot) *xo +math.cos(zRot) *yo -math.sin(yRot) *math.sin(zRot) *zo
	local zr = -math.sin(yRot) *xo +math.cos(yRot) *zo

	return self:GetParentBody() and self:GetParentBody():GetPos() +Vector( xr, yr, zr ) or Vector( xr, yr, zr )
end

function SkyObj.CBaseStellarObject:DayLightUpdateTime( intMin )
	if intMin < self.m_tblDayData.End or intMin >= self.m_tblDayData.Start then
		if not self.m_tblDayData.StartTime then
			self.m_tblDayData.StartTime = CurTime()

			if intMin >= self.m_tblDayData.End then
				self.m_tblDayData.StartOffset = intMin -self.m_tblDayData.Start
			elseif intMin < self.m_tblDayData.End then
				self.m_tblDayData.StartOffset = intMin +(self.m_tblDayData.Length -self.m_tblDayData.Start)
			end
		end
	else
		if self.m_tblDayData.StartTime then
			self.m_tblDayData.StartTime = nil
			self.m_tblDayData.StartOffset = nil

			self.m_tblOrbitData.Elevation = self.m_intElevationOverride or math.pi /2
			self:SetPos( self:ComputeOrbitPos() )
		end
	end
end

function SkyObj.CBaseStellarObject:Tick()
	if not self.m_tblOrbitData.Radius then return end
	local data = self.m_tblOrbitData
	local day = self.m_tblDayData

	if self:GetParentBody() then
		if not day.StartTime then
			return
		end

		if self.m_intElevationOverride then
			data.Elevation = self.m_intElevationOverride +self:GetParentBody().m_tblOrbitData.Elevation --Copy Parent
		else
			local scaler = CurTime() /self.m_intChildOrbitDuration
			data.Elevation = ((math.pi *2) *scaler) *(self.m_bRetrogradeOrbit and -1 or 1)
			data.Elevation = data.Elevation +self:GetParentBody().m_tblOrbitData.Elevation --Copy Parent
		end
	elseif not self.m_intElevationOverride then
		if not day.StartTime then
			return
		end

		local scalerDuration = (day.Length -day.Start) +day.End
		local scaler = math.abs( ((CurTime() +day.StartOffset) -day.StartTime) /scalerDuration )
		scaler = math.Clamp( scaler, 0, 1 )
		data.Elevation = Lerp( scaler, self.m_intRiseAng *self.m_intRad, self.m_intSetAng *self.m_intRad )
	else
		data.Elevation = self.m_intElevationOverride
	end

	data.Elevation = (self.m_intElevationOffset or 0) +data.Elevation

	self:SetPos( self:ComputeOrbitPos() )
end

--[[ Rendering ]]--
function SkyObj.CBaseStellarObject:GetRenderMatrix()
	local mat = Matrix()
	mat:Translate( self.m_vecPos )

	local rotAng
	if self.m_angOverride then
		rotAng = self.m_angOverride
	else
		local time = SysTime()
		rotAng = Angle( self.m_angRotation.p *time, self.m_angRotation.y *time, self.m_angRotation.r *time )
	end
	
	local axisAng = Angle( 0, 0, 0 )
	axisAng:RotateAroundAxis( axisAng:Up(), self.m_angTilt.p )
	axisAng:RotateAroundAxis( axisAng:Right(), self.m_angTilt.y )
	axisAng:RotateAroundAxis( axisAng:Forward(), self.m_angTilt.r )

	mat:Rotate( axisAng )
	mat:Rotate( rotAng )
	mat:Translate( -self.m_vecPos )

	return mat
end

function SkyObj.CBaseStellarObject:GetLightPos()
	if self:GetParentBody() and self.m_bParentIsLight then
		return self:GetParentBody():GetPos()
	end

	return self.m_vecLightPos or Vector( 0 )
end

function SkyObj.CBaseStellarObject:GetLightColor()
	if self:GetParentBody() and self.m_bParentIsLight then
		return self:GetParentBody():GetLightColor()
	end

	return self.m_colLightColor or self:GetColor()
end

function SkyObj.CBaseStellarObject:Render()
	if not self.m_tblDayData.StartTime then return end

	cam.PushModelMatrix( self:GetRenderMatrix() )
		--Draw the object
		render.SetMaterial( self:GetSurfaceTexture() )
		render.DrawSphere(
			self.m_vecPos,
			self:GetRadius(),
			self.m_intMaxPolyLOD,
			self.m_intMaxPolyLOD,
			self:GetColor()
		)

		--Draw the atmo layers
		render.UpdateRefractTexture()
		if #self.m_tblAtmosphereLayers > 0 then
			local rad = self:GetRadius()
		
			for k, v in ipairs( self.m_tblAtmosphereLayers ) do
				if v.RenderFunc then
					v.RenderFunc( self, v )
					continue
				end
		
				render.SetMaterial( v.Mat )
				render.DrawSphere(
					self.m_vecPos,
					rad +(rad *v.Radius),
					self.m_intMaxPolyLOD,
					self.m_intMaxPolyLOD,
					v.Color or self:GetColor()
				)
			end
		end
	cam.PopModelMatrix()
end

function SkyObj.CBaseStellarObject:ParseWorldPreset( tblData )
	self:SetName( tblData.BodyName )
	self:SetRotation( tblData.Rotation or Angle(0, 0, 0) )
	self:SetTilt( tblData.AxisTilt or Angle(0, 0, 0) )
	self:SetSurfaceTexture( tblData.SurfaceTexture )
	self:SetRadius( tblData.Radius )
	self:SetColor( tblData.Color or Color(255, 255, 255, 255) )

	if tblData.Orbit.ParentName then
		self.m_strParentName = tblData.Orbit.ParentName
	end

	self.m_angOverride = tblData.AngleOverride
	self.m_intElevationOverride = tblData.Orbit.Elevation
	self.m_intChildOrbitDuration = tblData.Orbit.ChildOrbitDuration
	self.m_intElevationOffset = tblData.Orbit.ElevationOffset
	self.m_bRetrogradeOrbit = tblData.Orbit.Retrograde

	self:DefineOrbit( tblData.Orbit.Radius, tblData.Orbit.Inclination )
	self.m_intRotationR = tblData.Orbit.RotationR
	self.m_intRotationY = tblData.Orbit.RotationY
	self.m_intRiseAng = tblData.Orbit.RiseAng or self.m_intRiseAng
	self.m_intSetAng = tblData.Orbit.SetAng or self.m_intSetAng

	if tblData.Lighting then
		self.m_vecLightPos = tblData.Lighting.Origin
		self.m_bParentIsLight = tblData.Lighting.ParentIsLight
		self.m_colLightColor = tblData.Lighting.Color
	end
end