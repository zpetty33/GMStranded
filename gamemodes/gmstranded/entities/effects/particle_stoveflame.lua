
/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )
	
	self.Origin = data:GetOrigin()
	self.StartTime = CurTime()
	local Col = Color(255,255,255,255)
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self.Origin)
	if SGS.drawdistance == nil then return end
	if dis > SGS.drawdistance / 8 then return end
	if SGS.showparticles == false then return end


	local NumParticles = 16
	
	local emitter = ParticleEmitter( self.Origin, false )
	
		for i=0, NumParticles do
			
			local newstart = self.Origin + ( Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), 0):GetNormal() * math.Rand(0,5))
			newstart = newstart + Vector(0,0,math.Rand(3,8))
			local ColorParticleStreak = emitter:Add( 'sprites/flamelet' ..math.random(1,5), newstart )
			
			if ColorParticleStreak then
				
				ColorParticleStreak:SetVelocity( Vector(0,0,math.random(5,15)) )
				
				ColorParticleStreak:SetLifeTime( 0 )
				ColorParticleStreak:SetDieTime( math.Rand(0.2, 1) )
				
				ColorParticleStreak:SetStartAlpha( math.random(230,255) )
				ColorParticleStreak:SetEndAlpha( 150 )
				
				local Size = math.Rand( 0.5, 2 )
				ColorParticleStreak:SetStartSize( Size )
				ColorParticleStreak:SetEndSize( math.random(0,0.1) )
				
				ColorParticleStreak:SetRoll( math.Rand(0, 360) )
				ColorParticleStreak:SetRollDelta( math.Rand(-10, 10) )
				
				local RandDarkness = math.Rand( 1, 1.0 )
				ColorParticleStreak:SetColor( Col.r*RandDarkness, Col.g*RandDarkness, Col.b*RandDarkness )

				--ColorParticleStreak:SetAngleVelocity( Angle( math.Rand( -40, 40 ), math.Rand( -40, 40 ), math.Rand( -40, 40 ) ) ) 
				ColorParticleStreak:SetLighting( false )
	
			end
			
		end
		
	emitter:Finish()
	
	SafeRemoveEntityDelayed( self, 7 ) // Some people say it doesn't remove itself properly. So hopefully this will fix it. (If it was ever really broken) (I don't think it was)
	
end

	
/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
	return CurTime() < self.StartTime + 0.5 // 5
end

local Mat = Material( 'sprites/gmdm_pickups/light' )
/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

	
	if CurTime() > self.StartTime + 0.5 then return end
	
	local Increase = ( ( CurTime() - self.StartTime ) / 0.5 )

	local Alpha = (-Increase+1)*0.75

	local Size = 8192*Increase
	
	render.SetMaterial( Mat )
	--render.DrawSprite( self.Origin, Size, Size, Color(255, 255, 255, Alpha*255) )

end