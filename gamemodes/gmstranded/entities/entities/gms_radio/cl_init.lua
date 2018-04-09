include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH
--Called when it's time to draw the entity.
--Return: Nothing

function ENT:Draw()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if SGS.drawdistance == nil then return end
		if dis > SGS.drawdistance / 2 then 
		self:DestroyShadow()
		return 
	end
	self:CreateShadow()
	self.Entity:DrawModel()
	
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
		
		local FixAngles = self.Entity:GetAngles()
		local FixRotation = Vector(90, 90, 180)
		FixAngles:RotateAroundAxis(FixAngles:Right(), FixRotation.x)
		FixAngles:RotateAroundAxis(FixAngles:Up(), FixRotation.y)
		FixAngles:RotateAroundAxis(FixAngles:Forward(), FixRotation.z)
		local TargetPos = self.Entity:GetPos() + self.Entity:GetForward() * 8.5 + self.Entity:GetUp() * 15.5
		cam.Start3D2D(TargetPos, FixAngles, 0.125)
			local x = -50
			local y = 0
			local col = Color(255,255,255,sa)
			
			if self.on then
				col = Color(25,25,25,sa)
				
				if IsValid( self.station ) then
					local l, r = self.station:GetLevel()
					local level = math.floor( l * 115 ) * 2
					col = Color( 25, 25 + level, 25, sa )
				end
				
			else
				col = Color(255,25,25,sa)
			end
			draw.RoundedBox( 0, x, y, 140, 30, col )
		cam.End3D2D()
	end
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	self.on = false
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

	if IsValid(self.station) then
		self.station:SetPos( self:GetPos() )
	end
	
	self:NextThink( CurTime() + 0.5 )
	return true

end

function ENT:OnRemove()

	if IsValid(self.station) then
		self.station:Stop()
		SafeRemoveEntity( self.station )
	end

end


net.Receive( "radio_play", function( len )
	local stationid = net.ReadString()
	local stationent = net.ReadEntity()
	
	local stationurl = "http://yp.shoutcast.com/sbin/tunein-station.pls?id=" .. stationid
	
	if not IsValid( stationent ) then return end
	if IsValid(stationent.station) then return end
	
	stationent.on = true
	
	sound.PlayURL( stationurl, "3d", function( station )
		if IsValid(station) then
			stationent.station = station
			stationent.station:SetPos( stationent:GetPos() )
			stationent.station:SetVolume( 1 )
			stationent.station:Set3DFadeDistance( 300, 1000000000 )
			stationent.station:Play()
		end
	end )
end )

net.Receive( "radio_stop", function( len )
	local stationent = net.ReadEntity()
	if not IsValid( stationent ) then return end
	stationent.on = false
	if IsValid(stationent.station) then
		stationent.station:Stop()
		SafeRemoveEntity( stationent.station )
	end
end )

net.Receive( "radio_openmenu", function( len )
	local radioEdit = net.ReadEntity()
	if IsValid( radioEdit ) then
		SGS_RadioMenu( radioEdit )
	end
end )