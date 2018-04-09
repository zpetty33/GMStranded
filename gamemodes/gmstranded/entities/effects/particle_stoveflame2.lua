
function EFFECT:Init( data )
	self.Entity = data:GetEntity()
	self:SetParent( Entity )

	self.Origin = data:GetOrigin()
	self.StartTime = CurTime()
	self.ParticlesPerSecond, self.ParticlesToSpawn = 35, 0

	self.Emitter = ParticleEmitter( self.Origin, false )
end

function EFFECT:Think()
	local finished = not IsValid( self.Entity ) or self.Entity:GetColor().r == 40
	if finished then
		self.Emitter:Finish()
	else
		local pos = self.Entity:GetPos()
		self:SetPos(pos)
		self.Emitter:SetPos(pos)
	end

	return not finished
end

function EFFECT:Render()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self:GetPos())
	if SGS.showparticles == false then return end
	if SGS.drawdistance == nil then return end
	if dis > SGS.drawdistance / 8 then return end
	if SGS.showparticles == false then return end

	self.ParticlesToSpawn = self.ParticlesToSpawn + FrameTime() * self.ParticlesPerSecond

	while self.ParticlesToSpawn >= 1 do
		self.ParticlesToSpawn = self.ParticlesToSpawn - 1
		
		local ang = math.Rand(0, 360)
		local dir = math.cos(ang) * self.Entity:GetRight() + math.sin(ang) * self.Entity:GetForward()

		--                          [OFFSET TO CENTER            ]   [CIRCLE]  [UNDER PAN              ]
		local pos = self:GetPos() + 4.5 * self.Entity:GetForward() + dir * 4 - 2 * self.Entity:GetUp()

		local particle = self.Emitter:Add('sprites/flamelet'..math.random(1,5), pos)
		if particle then
			particle:SetVelocity(dir * math.Rand(8, 12))
			particle:SetGravity(Vector(0, 0, math.Rand(8, 12)))
			particle:SetAirResistance(10)
			
			particle:SetLifeTime(0)
			particle:SetDieTime(math.Rand(0.1, 0.5))
			 
			particle:SetStartSize(math.Rand(0.75, 1.25))
			particle:SetEndSize(math.Rand(1, 1.5))
			
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-5, 5))
			
			local col = 235 + math.random(20)
			particle:SetColor(col, col, col)

			particle:SetLighting( false )
		end
	end
end