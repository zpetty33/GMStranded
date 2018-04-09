
/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )
	
	self.Origin = data:GetOrigin()
	self.StartTime = CurTime()
	local Col = Color(255,255,255,255)
	if SGS.showparticles == false then return end


	local NumParticles = 2
	
	local emitter = ParticleEmitter( self.Origin, false )
	
		for i=0, NumParticles do
			
			local newstart = self.Origin + ( Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), 0):GetNormal() * math.Rand(0,4))
			newstart = newstart + Vector(math.Rand(-30,30),math.Rand(-30,30),math.Rand(15,20))
			local ColorParticleStreak = emitter:Add( 'particle/particle_noisesphere', newstart )
			
			if ColorParticleStreak then
				
				ColorParticleStreak:SetVelocity( Vector(0,0,math.random(10,30)) )
				
				ColorParticleStreak:SetLifeTime( 0 )
				ColorParticleStreak:SetDieTime( math.Rand(2, 4) )
				
				ColorParticleStreak:SetStartAlpha( math.random(230,255) )
				ColorParticleStreak:SetEndAlpha( 100 )
				
				local Size = math.Rand( 10, 20 )
				ColorParticleStreak:SetStartSize( Size )
				ColorParticleStreak:SetEndSize( math.random(5,15) )
				
				ColorParticleStreak:SetRoll( math.Rand(0, 0) )
				--ColorParticleStreak:SetRollDelta( math.Rand(-10, 10) )
				
				local RandDarkness = math.Rand( 5, 10 )
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