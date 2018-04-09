
function EFFECT:Init( data )
	self.Entity = data:GetEntity()
	self:SetParent( Entity )

	self.Origin = data:GetOrigin()
	self.StartTime = CurTime()
	self.ParticlesPerSecond, self.ParticlesToSpawn = 24, 0

	self.Emitter = ParticleEmitter( self.Origin, false )
end

function EFFECT:Think()

	local finished = not IsValid( self.Entity )
	if finished then
		self.Emitter:Finish()
	else
		local pos = self.Entity:GetPos()
		self:SetPos(pos)
		self.Emitter:SetPos(self:LocalToWorld(Vector( 0, 0, -14 )))
	end

	return not finished
end

function EFFECT:Render()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if SGS.drawdistance == nil then return end
	if dis > SGS.drawdistance / 8 then return end
	if SGS.showparticles == false then return end

	self.ParticlesToSpawn = self.ParticlesToSpawn + FrameTime() * self.ParticlesPerSecond

	while self.ParticlesToSpawn >= 1 do
		self.ParticlesToSpawn = self.ParticlesToSpawn - 1
		
		-- Purposefully incorrect disk point picking (Fire brighter in center this way)
		-- http://mathworld.wolfram.com/DiskPointPicking.html
		local ang = math.Rand(0, 360)
		local pos = self.Entity:LocalToWorld(Vector( 0, 0, -14 )) + Vector(math.cos(ang), math.sin(ang)) * math.Rand(0, 4)

		local particle = self.Emitter:Add('sprites/flamelet'..math.random(1,5), pos)
		if particle then
			particle:SetVelocity( Vector(0,0,math.random(8,20)) )
			
			particle:SetLifeTime(0)
			particle:SetDieTime(math.Rand(0.2, 1))
			
			particle:SetStartAlpha(math.random(230,255))
			particle:SetEndAlpha( 150 )
			
			local Size = 
			particle:SetStartSize(math.Rand(4, 6))
			particle:SetEndSize(math.Rand(0, 1))
			
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-10, 10))
			
			local col = 235 + math.random(20)
			particle:SetColor(col, col, col)

			--ColorParticleStreak:SetAngleVelocity( Angle( math.Rand( -40, 40 ), math.Rand( -40, 40 ), math.Rand( -40, 40 ) ) ) 
			particle:SetLighting( false )
		end
	end
end