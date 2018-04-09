include('shared.lua')

local SmokeOn = CreateClientConVar( 'fireworks_smoke', '1', true, false)
local FlameGlow = CreateClientConVar( 'fireworks_flame', '1', true, false)

function ENT:Initialize()

	self.Emitter = ParticleEmitter( self:GetPos(), false ) -- I have a feeling that using this position may be bad if the firework moves. Maybe taking it out of the players PVS?
	self.NextPuff = CurTime()

	MX, MN = self:GetRenderBounds()

	self:SetRenderBounds( MN + Vector( 0, 0, 512 ), MX )
	
end

local Mat = Material( 'sprites/gmdm_pickups/light' )

-- Technically because I'm doing this in Draw, some players may see less particles if they have lower FPS. But this might be a good thing, because it won't drown them any more.
function ENT:Draw()

	self:DrawModel()
	if SGS.showparticles == false then return end

	if FrameTime() == 0 || !self.Emitter || ( self.NextPuff > CurTime() ) then return end // Don't do the effects if the player is paused (this would be bad)
	
	local Pos = self:GetPos() + self:GetUp()*19
	local FuseLevel = self:GetDTInt( 0 ) || 0
	local FlameColor = self:GetDTVector( 0 ) || Vector( 255, 165, 0 )
	
	local Force = math.Rand( 100, 250 )
	
	if FuseLevel > 1 && FlameGlow:GetBool() then
	
		local Particle	= self.Emitter:Add( 'sprites/gmdm_pickups/light', Pos + VectorRand() )
		
		if Particle then

			Particle:SetVelocity( self:GetUp()*Force + VectorRand()*10 )
			Particle:SetDieTime( math.Rand( 0.75, 1.25 ) )
			
			Particle:SetColor( FlameColor.x, FlameColor.y, FlameColor.z )
			Particle:SetStartAlpha( math.Rand( 100, 255 ) )
			
			
			Particle:SetStartSize( math.Rand( 5, 50 ) )
			Particle:SetEndSize( math.Rand( 0.1, 0.5 ) )
			
			Particle:SetGravity( Vector( 0, 0, -400 ) )
			
			Particle:SetCollide( true )
			Particle:SetBounce( 1 )
			
		end
		
		-- Draw a nice flashing sprite.
		
		local SizeSprite = math.cos( CurTime()*10 )*256
		
		render.SetMaterial( Mat )
		render.DrawSprite( Pos, SizeSprite, SizeSprite, Color(FlameColor.x, FlameColor.y, FlameColor.z) )

	
	end
	

	self.NextPuff = CurTime()+math.random()*0.05
	
end

function ENT:OnRemove()

	if IsValid( self.Emitter ) then
	
		self.Emitter:Finish()
		SafeRemoveEntity( self.Emitter )
		
	end

end