
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
	if dis > 960400 then return end
	if SGS.showparticles == false then return end
	local Hue, Saturation, Value = ColorToHSV( Color( Col.r, Col.g, Col.b ) )
	Col = HSVToColor( Hue, Saturation/3, Value )



	local emitter = ParticleEmitter( self.Origin, false )

	local newstart = self.Origin + Vector( math.random(-1,1), math.random(-1,1), 0)
	local ColorParticleStreak = emitter:Add( 'sprites/gmdm_pickups/light', newstart )
	
	if ColorParticleStreak then
		
		ColorParticleStreak:SetVelocity( Vector(math.Rand(0,10),math.Rand(0,10),0) )
		
		ColorParticleStreak:SetLifeTime( 0 )
		ColorParticleStreak:SetDieTime( 0.4 )
		
		ColorParticleStreak:SetStartAlpha( 150 )
		ColorParticleStreak:SetEndAlpha( 50 )
		
		local Size = math.Rand( 1, 8 )
		ColorParticleStreak:SetStartSize( Size )
		ColorParticleStreak:SetEndSize( 0 )
		
		local AirResistance = math.Rand(  0, 10 )
		
		ColorParticleStreak:SetAirResistance( AirResistance )
		
		local Gravity = math.Rand( 5, 25 )
		
		ColorParticleStreak:SetGravity( Vector( 0, 0, -Gravity ) )
		
		ColorParticleStreak:SetColor( Col.r, Col.g, Col.b )
		
		ColorParticleStreak:SetStartLength( 1 )
		ColorParticleStreak:SetEndLength( 8 )
		
		ColorParticleStreak:SetCollide( false )
		ColorParticleStreak:SetBounce( 0 )
		
	end
		
	emitter:Finish()
	
	SafeRemoveEntityDelayed( self, 2 ) // Some people say it doesn't remove itself properly. So hopefully this will fix it. (If it was ever really broken) (I don't think it was)
	
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