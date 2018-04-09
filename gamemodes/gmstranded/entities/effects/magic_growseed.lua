/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )
	
	self.Origin = data:GetOrigin()
	self.StartTime = CurTime()
	local Col = data:GetStart()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self.Origin)
	if dis > SGS.drawlights * 5 then return end
	if SGS.showparticles == false then return end
	
	local Hue, Saturation, Value = ColorToHSV( Color( Col.r, Col.g, Col.b ) )
	Col = HSVToColor( Hue, Saturation/3, Value )


	local NumParticles = 256
	
	local emitter = ParticleEmitter( self.Origin, false )
	
		for i=0, NumParticles do
			
			local newstart = self.Origin + ( Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), 0):GetNormal() * 2)
			local ColorParticleStreak = emitter:Add( 'sprites/gmdm_pickups/light', newstart )
			local GlowEffect = emitter:Add( 'sprites/gmdm_pickups/light', newstart )
			
			if ColorParticleStreak && GlowEffect then
				
				ColorParticleStreak:SetVelocity( Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), 0):GetNormal() * math.Rand(75,150) )
				
				ColorParticleStreak:SetLifeTime( 0 )
				ColorParticleStreak:SetDieTime( math.Rand(1,2) )
				
				ColorParticleStreak:SetStartAlpha( 255 )
				ColorParticleStreak:SetEndAlpha( 0 )
				
				local Size = math.Rand( 5, 15 )
				ColorParticleStreak:SetStartSize( Size )
				ColorParticleStreak:SetEndSize( 0 )
				
				local AirResistance = math.Rand(  25, 50 )
				
				ColorParticleStreak:SetAirResistance( AirResistance )
				
				local Gravity = math.Rand( 20, 150 )
				
				ColorParticleStreak:SetGravity( Vector( 0, 0, Gravity ) )
				
				ColorParticleStreak:SetColor( Col.r, Col.g, Col.b )
				
				ColorParticleStreak:SetStartLength( 20 )
				ColorParticleStreak:SetEndLength( 0 )
				
				ColorParticleStreak:SetCollide( false )
				ColorParticleStreak:SetBounce( 1 )
				
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