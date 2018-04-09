Class "CSolarCamera" : Namespace "SkyObj" {
	m_vecSkyPos = Vector( 0, 0, 0 ),
	m_angSkyAngle = Angle( 45, 0, 0 ),
	m_tblCurrentSky = {},
}

function SkyObj.CSolarCamera:Initialize()
	hook.Add( "PostDraw2DSkyBox", "ASD", function()
		self:RenderStellarObjects()
	end )

	self.m_matSkyOverlay = Material( "planets/sky_4" )
end

function SkyObj.CSolarCamera:OnRemove()
	self:ClearSky()
end

function SkyObj.CSolarCamera:ClearSky()
	for k, v in pairs( self.m_tblCurrentSky ) do
		v:Remove()
	end

	self.m_tblCurrentSky = {}
end

function SkyObj.CSolarCamera:FindObject( strName )
	for k, v in ipairs( self.m_tblCurrentSky ) do
		if v:GetName() == strName then return v end
	end
end

function SkyObj.CSolarCamera:AddObject( insStellarObject )
	self.m_tblCurrentSky[#self.m_tblCurrentSky +1] = insStellarObject
end

function SkyObj.CSolarCamera:DrawSkyOverlay()
	local mat = Matrix()
	mat:Translate( self.m_vecSkyPos )
	mat:Rotate( self.m_angSkyAngle )

	local data = self.m_tblCurrentSky[1]
	if data and data.m_tblOrbitData and data.m_tblOrbitData.Elevation then
		local elv = (self.m_tblCurrentSky[1].m_tblOrbitData.Elevation) *(math.pi *180)
		mat:Rotate( Angle(0, -(elv /8), 0) )
	end
	
	mat:Translate( -self.m_vecSkyPos )

	render.SetMaterial( self.m_matSkyOverlay )
	render.OverrideDepthEnable( true, false )
	render.CullMode( MATERIAL_CULLMODE_CW )
		cam.PushModelMatrix( mat )
			render.DrawSphere(
				self.m_vecSkyPos,
				8192,
				32,
				32,
				Color( 255, 255, 255, 255 )
			)
		cam.PopModelMatrix()
	render.CullMode( MATERIAL_CULLMODE_CCW )
	render.OverrideDepthEnable( true, true )
end

function SkyObj.CSolarCamera:RenderStellarObjects()
	render.SuppressEngineLighting( true )
	render.PushFilterMag( 4 )
	render.PushFilterMin( 4 )
	render.OverrideDepthEnable( true, true )
		--Planets
		cam.Start3D( self.m_vecSkyPos, EyeAngles() )
			--self:DrawSkyOverlay()

			for k, v in ipairs( self.m_tblCurrentSky ) do
				v:Render()
			end
		cam.End3D()
	render.OverrideDepthEnable( false, false )
	render.PopFilterMag()
	render.PopFilterMin()
	render.SuppressEngineLighting( false )
end