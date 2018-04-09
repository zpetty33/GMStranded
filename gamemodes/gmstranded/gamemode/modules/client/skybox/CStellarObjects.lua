Class "CStar" : Namespace "SkyObj" : Extends "CBaseStellarObject" {
	--Physical characteristics
	m_intBrightness = 1,
	m_intMaxRadiusScale = 1,
	m_matStarLight 	= Material( "gamey/stars/star_glow" ),
	m_matStarLight2 = Material( "gamey/stars/star_glow2" ),

	m_strSpectralClass = "G", --Base color
	m_tblSpectralBaseColors = {
		["O"] = Color( 190, 190, 255, 255 ),
		["B"] = Color( 220, 220, 255, 255 ),
		["A"] = Color( 240, 242, 255, 255 ),
		["F"] = Color( 255, 255, 255, 255 ),
		["G"] = Color( 240, 220, 110, 255 ),
		["K"] = Color( 255, 205, 70, 255 ),
		["M"] = Color( 255, 160, 100, 255 ),
	},
}

function SkyObj.CStar:Initialize()
	self.super.Initialize( self )
	self:SetColor( self.m_tblSpectralBaseColors[self.m_strSpectralClass] )
	self:DisableDistanceScaler( true )

	local mat = self:AddAtmosphereLayer(
		"gamey/stars/star_atmo",
		Color(255, 255, 255, 255),
		0.005
	).Mat
	mat:SetFloat( "$refractamount", 0.066 )
	mat:SetFloat( "$reflectamount", 0.9 )
	mat:SetString( "$forceexpensive", "true" )
end

function SkyObj.CStar:SetBrightness( intBrightness )
	self.m_intBrightness = intBrightness
end

function SkyObj.CStar:GetBrightness()
	return self.m_intBrightness
end

function SkyObj.CStar:SetSpectralClass( strClass )
	self.m_strSpectralClass = strClass
	self:SetColor( self.m_tblSpectralBaseColors[self.m_strSpectralClass] )
end

function SkyObj.CStar:GetSpectralClass()
	return self.m_strSpectralClass
end

function SkyObj.CStar:Render()
	if g_InSkyboxRender then return end

	render.SuppressEngineLighting( true )
	render.SetLightingMode( 2 )
		self.super.Render( self )
	render.SetLightingMode( 0 )
	render.SuppressEngineLighting( false )

	--Draw star lighting
	local light = DynamicLight( LocalPlayer():EntIndex() )
	if light then
		light.Pos = self.m_vecPos
		light.r = self.m_colColor.r
		light.g = self.m_colColor.g
		light.b = self.m_colColor.b
		light.Brightness = 4 *self.m_intBrightness
		light.Decay = 10000
		light.Size = 16384
		light.DieTime = CurTime() +2
	end

	local rad = self:GetScaledRadius()

	--Draw star light glare
	local scaler = 2.5 *self.m_intBrightness
	render.SetMaterial( self.m_matStarLight2 )
	render.DrawQuadEasy(
		self.m_vecPos,
		Angle(EyeAngles().p, EyeAngles().y, 0):Forward() *-1,
		rad *scaler, rad *scaler,
		self.m_colColor,
		SysTime() *-1
	)
	
	local scaler = 4 *self.m_intBrightness
	render.SetMaterial( self.m_matStarLight )
	render.DrawQuadEasy(
		self.m_vecPos,
		Angle(EyeAngles().p, EyeAngles().y, 0):Forward() *-1,
		rad *scaler, rad *scaler,
		self.m_colColor,
		SysTime()
	)
end

--Reads object metadata from server
function SkyObj.CStar:ReadNetworkFullUpdate( ... )
	self.super.ReadNetworkFullUpdate( self, ... )

	--read star vars
	self:SetBrightness( net.ReadFloat() )
	self:SetSpectralClass( net.ReadString() )
end

-- -------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------

Class "CPlanet" : Namespace "SkyObj" : Extends "CBaseStellarObject" {
	--Physical characteristics
	m_matAtmosphere = Material( "planets/star_glow2" ),
	m_matCloudLayer = nil,
	m_colAtmoColor 	= Color( 200, 200, 255, 255 ),
	m_colCloudColor = Color( 255, 255, 255, 255 ),

	m_angCloudRotation = Angle( 0, 0, 0 ),

	m_bHasAtmosphere = false,
	m_bCloudsEnabled = false,

	m_intAtmoScale = 1.66,
	m_intCloudScale = 0.005,

	m_intDayDuration = nil,
	m_intDayTimeOffset = 0,
	m_intStartDayTime = 0,
	m_bRetrogradeRotation = false,
}

function SkyObj.CPlanet:Initialize()
	self.super.Initialize( self )
	self:AddAtmosphereLayer( nil, nil, nil, self.RenderCloudLayer )
end

--Rotation/Day Time
function SkyObj.CPlanet:SetDayDuration( intTime )
	self.m_intDayDuration = intTime
	self.m_intStartDayTime = CurTime()
end

function SkyObj.CPlanet:PreturbDayTime( intTimeOffset, intStartTime )
	self.m_intDayTimeOffset = intTimeOffset

	if intStartTime then
		self.m_intStartDayTime = intStartTime
	end
end

function SkyObj.CPlanet:SetRetrogradeRotation( bEnable )
	self.m_bRetrogradeRotation = bEnable
end

--Atmosphere & Clouds
function SkyObj.CPlanet:EnableAtmosphere( bDraw )
	self.m_bHasAtmosphere = bDraw
end

function SkyObj.CPlanet:HasAtmosphere()
	return self.m_bHasAtmosphere
end

function SkyObj.CPlanet:SetAtmoColor( col_r, g, b, a )
	if type( col_r ) == "number" then
		self.m_colAtmoColor.r = col_r
		self.m_colAtmoColor.g = g
		self.m_colAtmoColor.b = b
		self.m_colAtmoColor.a = a
	else
		self.m_colAtmoColor = col_r
	end
end

function SkyObj.CPlanet:GetAtmoColor()
	return self.m_colAtmoColor
end

function SkyObj.CPlanet:SetCloudColor( col_r, g, b, a )
	if type( col_r ) == "number" then
		self.m_colCloudColor.r = col_r
		self.m_colCloudColor.g = g
		self.m_colCloudColor.b = b
		self.m_colCloudColor.a = a
	else
		self.m_colCloudColor = col_r
	end
end

function SkyObj.CPlanet:GetCloudColor()
	return self.m_colCloudColor
end

function SkyObj.CPlanet:SetAtmoScale( intScale )
	self.m_intAtmoScale = intScale
end

function SkyObj.CPlanet:GetAtmoScale()
	return self.m_intAtmoScale
end

function SkyObj.CPlanet:EnableCloudLayer( bEnable )
	self.m_bCloudsEnabled = bEnable
end

function SkyObj.CPlanet:GetCloudsEnabled()
	return self.m_bCloudsEnabled
end

function SkyObj.CPlanet:SetCloudLayer( strMat )
	self.m_matCloudLayer = Material( strMat )
	return self.m_matCloudLayer
end

function SkyObj.CPlanet:GetCloudLayer()
	return self.m_matCloudLayer
end

function SkyObj.CPlanet:SetCloudScale( int )
	self.m_intCloudScale = int
end

function SkyObj.CPlanet:GetCloudScale()
	return self.m_intCloudScale
end

function SkyObj.CPlanet:SetCloudRotation( angRot )
	self.m_angCloudRotation = angRot
end

function SkyObj.CPlanet:GetCloudRotation()
	return self.m_angCloudRotation
end

function SkyObj.CPlanet:UpdateRotation()
	if not self.m_intDayDuration then return end
	local data = self.m_tblWorldData.Day
	if not data.StartTime then data.StartTime = CurTime() end

	local curTime = CurTime()
	local startTime = data.StartTime
	local timeScaler = math.abs( (curTime -startTime) /self.m_intDayDuration )
	timeScaler = math.Clamp( timeScaler, 0, 1 )

	local ang
	if self.m_bRetrogradeRotation then
		ang = Angle(0, Lerp(timeScaler, 360, 0), 0)
	else
		ang = Angle(0, Lerp(timeScaler, 0, 360), 0)
	end

	if timeScaler == 1 then
		data.StartTime = CurTime()
		self.m_intDayTimeOffset = 0
	end

	self.m_angOverride = ang
end

function SkyObj.CPlanet:GetCloudRenderMatrix()
	local mat = Matrix()
	mat:Translate( self:GetPos() )

	local time = SysTime()
	local rotAng
	if self.m_angOverride then
		rotAng = self.m_angOverride +(self.m_angCloudRotation *time)
	else
		rotAng = Angle(
			(self.m_angRotation.p +self.m_angCloudRotation.p) *time,
			(self.m_angRotation.y +self.m_angCloudRotation.y) *time,
			(self.m_angRotation.r +self.m_angCloudRotation.r) *time
		)
	end 

	local axisAng = Angle( 0, 0, 0 )
	axisAng:RotateAroundAxis( axisAng:Up(), self.m_angTilt.p )
	axisAng:RotateAroundAxis( axisAng:Right(), self.m_angTilt.y )
	axisAng:RotateAroundAxis( axisAng:Forward(), self.m_angTilt.r )

	mat:Rotate( axisAng )
	mat:Rotate( rotAng )
	mat:Translate( -self:GetPos() )

	return mat
end

function SkyObj.CPlanet:RenderRings()
	if self.m_intRingScale then
		local norm = self.m_vecPos:GetNormal() *-1
		
		render.SetColorModulation( self.m_colRings.r /255, self.m_colRings.g /255, self.m_colRings.b /255, self.m_colRings.a /255 )
			render.SetMaterial( self.m_matRings )
			render.DrawQuadEasy( self.m_vecPos, self.m_intRingNorm, self.m_intRingScale, self.m_intRingScale, self:GetColor(), norm:Angle().y -180 )
			render.DrawQuadEasy( self.m_vecPos, self.m_intRingNorm *-1, self.m_intRingScale, self.m_intRingScale, self:GetColor(), norm:Angle().y -180 )
		render.SetColorModulation( 1, 1, 1, 1 )
	end
end

function SkyObj.CPlanet:RenderCloudLayer( tblLayer )
	if not self.m_bCloudsEnabled then return end
	local rad = self:GetRadius()

	cam.PushModelMatrix( self:GetCloudRenderMatrix() )
		render.SetMaterial( self.m_matCloudLayer )
		render.DrawSphere(
			self:GetPos(),
			rad *self.m_intCloudScale,
			self.m_intMaxPolyLOD,
			self.m_intMaxPolyLOD,
			self.m_colCloudColor
		)
	cam.PopModelMatrix()
end

function SkyObj.CPlanet:Render()
	self:UpdateRotation()
	if not self.m_tblDayData.StartTime then return end
	
	--Draw the atmo halo effect
	if self.m_bHasAtmosphere then
		local norm = self.m_vecPos:GetNormal() *-1
		local rad = self:GetRadius() *self.m_intAtmoScale
		local ang = norm:Angle()
	
		render.SetMaterial( self.m_matAtmosphere )
		render.DrawQuadEasy(
			self.m_vecPos,
			norm,
			rad,
			rad,
			self.m_colAtmoColor,
			ang.y -180
		)
	end
	
	--self.super.Render( self )
	render.SuppressEngineLighting( true )
		local parentColor = self:GetLightColor()
		--Disable the ambient lighting after turning off engine lighting...
		--wut. Why do i have to do this for SetLocalModelLights? SuppressEngineLighting not good enough?
		for i = 0, 5 do
			render.SetModelLighting( i, 0, 0, 0 )
		end
	
		render.SetLocalModelLights{{
			type = MATERIAL_LIGHT_POINT,
			pos = self:GetLightPos(),
			color = Vector( parentColor.r /255, parentColor.g /255, parentColor.b /255 ),
			dir = (self:GetPos() -self:GetLightPos()):GetNormal(),
		}}
	
		--Render
		self.super.Render( self )
		self:RenderRings()

		for i = 0, 5 do
			render.SetModelLighting( i, 1, 1, 1 )
		end
	
		render.SetLocalModelLights()
	render.SuppressEngineLighting( false )
end

function SkyObj.CPlanet:ParseWorldPreset( tblData )
	SkyObj.CBaseStellarObject.ParseWorldPreset( self, tblData )

	self:SetAtmoColor( tblData.AtmoColor )
	self:SetCloudColor( tblData.CloudColor )
	self:SetCloudRotation( tblData.CloudRotation )
	self:EnableAtmosphere( tblData.HasAtmosphere )
	self:EnableCloudLayer( tblData.HasClouds )
	
	self:SetCloudLayer( tblData.CloudTexture )
	self:SetAtmoScale( tblData.AtmoScale )
	self:SetCloudScale( tblData.CloudScale )

	if tblData.Day then
		self:SetRetrogradeRotation( tblData.Day.RetrogradeRotation )
		self:SetDayDuration( tblData.Day.Duration )
	end

	self.m_tblWorldData = tblData

	if tblData.Rings then
		self.m_intRingScale = tblData.Rings.RingScale
		self.m_matRings = Material( tblData.Rings.RingTexture )
		self.m_intRingNorm = tblData.Rings.RingNorm
		self.m_colRings = tblData.Rings.Color
		
  		self.m_matRings:SetString("$blendtintcoloroverbase", "1")
  		self.m_matRings:Recompute()
	end
end

-- -------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------

Class "CSprite" : Namespace "SkyObj" : Extends "CBaseStellarObject" {
	m_vecPosOffset = Vector( 0, 0, 0 ),
}

function SkyObj.CSprite:Render()
	if not self.m_tblDayData.StartTime then return end
	
	render.SuppressEngineLighting( true )
		render.SetMaterial( self:GetSurfaceTexture() )

		local max = self.m_intSetAng *self.m_intRad
		local asd = 1 +(self.m_tblOrbitData.Elevation -max) /max
		local rad = Lerp( asd, 0, 180 )

		local norm = self.m_vecPos:GetNormal() *-1
		render.DrawQuadEasy( self.m_vecPosOffset +self.m_vecPos, norm, self:GetRadius(), self:GetRadius(), self:GetColor(), norm:Angle().y -180 ) 
	render.SuppressEngineLighting( false )
end