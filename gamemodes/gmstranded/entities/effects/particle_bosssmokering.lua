local Brightness = CreateClientConVar( 'g4p_fireworks_brightness', '0.4', true, false)
local ShowGlow = CreateClientConVar( 'fireworks_glow', '1', true, false)
local SmokeExplosion = CreateClientConVar( 'fireworks_smokeexplosion', '1', true, false)

/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )
	
	self.Origin = data:GetOrigin()
	self.StartTime = CurTime()
	local pl = LocalPlayer()
	local dis = pl:GetPos():DistToSqr(self.Origin)
	if dis > SGS.drawlights * 10 then return end
	if SGS.showparticles == false then return end
	
	// Do flash/glow effect
	
	local NumSmoke = 256
	
	local emitter = ParticleEmitter( self.Origin, false )

		
		for i=0, NumSmoke do
		
			local newstart = self.Origin + ( Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), 0):GetNormal() * 100)
			
			local SmokeEffect = emitter:Add( 'particle/particle_noisesphere', newstart )
			
			if SmokeEffect then
				
				SmokeEffect:SetVelocity( Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), 0):GetNormal() * math.Rand(100,200) )
				
				SmokeEffect:SetLifeTime( 0 )
				SmokeEffect:SetDieTime( 1 )
				
				SmokeEffect:SetStartAlpha( 128 )
				SmokeEffect:SetEndAlpha( 0 )
				
				SmokeEffect:SetRoll( 0, 360 )
				SmokeEffect:SetRollDelta( math.Rand( -1, 1 ) )
				
				local Size = math.Rand( 10, 20 )
				SmokeEffect:SetStartSize( Size )
				SmokeEffect:SetEndSize( Size * math.Rand( 1, 2 ) )
				
				SmokeEffect:SetAirResistance( 50 )
				SmokeEffect:SetGravity( Vector( 0, 0, 35 ) )
				
				local RandDarkness = math.Rand( 0.25, 5 )
				
				SmokeEffect:SetColor( 255*RandDarkness, 255*RandDarkness, 255*RandDarkness )
			
			end
		end
		
	emitter:Finish()
	
	SafeRemoveEntityDelayed( self, 3 ) // Some people say it doesn't remove itself properly. So hopefully this will fix it. (If it was ever really broken) (I don't think it was)
	
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

end