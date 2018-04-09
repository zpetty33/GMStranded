
/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )
	
	self.Origin = data:GetOrigin()
	self.StartTime = CurTime()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self.Origin)
	if dis > SGS.drawlights * 3 then return end
	if SGS.showparticles == false then return end


	local NumParticles = 1600
	
	local emitter = ParticleEmitter( self.Origin, false )
	
		for i=0, NumParticles do
			
			local newstart = self.Origin + ( Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), 0):GetNormal() * math.Rand(0,32))
			newstart = newstart + Vector(0,0,math.Rand(15,20))
			local ColorParticleStreak = emitter:Add( 'sprites/rico1', newstart )
			
			if ColorParticleStreak then
				
				ColorParticleStreak:SetLifeTime( 0 )
				ColorParticleStreak:SetDieTime( 4 )
				
				ColorParticleStreak:SetStartAlpha( 255 )
				ColorParticleStreak:SetEndAlpha( 200 )
				
				local Size = math.Rand( 20,30 )
				ColorParticleStreak:SetStartSize( Size )
				ColorParticleStreak:SetEndSize( 1 )
				
				local AirResistance = 5
				
				ColorParticleStreak:SetAirResistance( AirResistance )
				
				ColorParticleStreak:SetGravity( Vector( 0, 0, 1 ) )
				
				ColorParticleStreak:SetColor( 255,255,255 )
				
				--ColorParticleStreak:SetStartLength( 5 )
				--ColorParticleStreak:SetEndLength( 5 )
				
				ColorParticleStreak:SetCollide( false )
				ColorParticleStreak:SetBounce( 0 )
				
				timer.Simple( 0.1, function()
					ColorParticleStreak:SetVelocity( Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), 0):GetNormal() * math.random(120,240) )
				end )
				
	
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