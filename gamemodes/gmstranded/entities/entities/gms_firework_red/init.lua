AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 24
	local ent = ents.Create( 'sent_firework2' )
	
	ent:SetPos( SpawnPos )
	ent:SetAngles( Angle(180, 0, 0) )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()

	self:SetModel( 'models/props_junk/garbage_plasticbottle003a.mdl' )
	self:SetAngles(Angle(180, 0, 0))

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

	self:SetUseType( SIMPLE_USE )
	
	self.Launched = false
	self.FuseStarted = false
	
	self:SetupData()

	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then
		
		--phys:Wake()

	end

	self:StartMotionController()
	
	phys:EnableMotion(false)
	
end

/*---------------------------------------------------------
   Name: PhysicsCollide
---------------------------------------------------------*/
function ENT:PhysicsCollide( Data, Phys )

	if Data.Speed > 500 && self.Launched && self.CollisionExplode then
	
		self:Explode()
		
	end

end


function ENT:SetupDataTables()
 
    self:DTVar( 'Int', 0, 'FuseLevel' );
	self:DTVar( 'Vector', 0, 'FlameColor' ) -- Using a Vector because there's no way of sending Color via datatable. (Please inform me if there is)
	
end


function ENT:SetupData()

	self.Col = Color( 255, 0, 0 )
	self.FuseTime = 1
	self.FWScale = .4
	self.AutoUnfreeze = true
	self.ExplodeTime = 2
	self.FlameColor = Vector( 255, 165, 0 )
	self.DamageExplode = false
	self.CollisionExplode = true
	self.TrajectoryRand = 8
	self.BlastDamage = false
	
	// Make FlameColor brighter, because it looks really bad when its one pure color. (255, 0, 0) for example
	
	local Hue, Saturation, Value = ColorToHSV( Color( self.FlameColor.x, self.FlameColor.y, self.FlameColor.z ) )
	local Col = HSVToColor( Hue, Saturation/3, Value )
	local NewFlame = Vector( Col.r, Col.g, Col.b ) || Vector( 255, 165, 0 )
	
	self:SetDTVector( 0, NewFlame )
	
end

function ENT:OnTakeDamage( dmginfo )

	self:TakePhysicsDamage( dmginfo )

	if self.DamageExplode then self:Explode(); end
	
end

function ENT:PhysicsSimulate( phys, deltatime )

	if !self.Launched then return SIM_NOTHING end

	local ForceAngle = Vector( 0, 0, 0 )
	local ForceLinear = Vector( 0, 0, -4750 )

	local Traj = self.TrajectoryRand
	
	if Traj != 0 then
	
		ForceAngle = VectorRand()*25*Traj
		local RandForceLinear = VectorRand()*225*Traj
		ForceLinear = Vector( RandForceLinear.x, RandForceLinear.y, -4750 )
	
	end
	
	if self.ExplodeTime != 0 then
	
		local Num = self.ExplodeTime
		local Frac = ( -( CurTime() - (self.LaunchTime) ) + Num ) / Num
		ForceLinear.z = ForceLinear.z*Frac

	end
	
	return ForceAngle, ForceLinear, SIM_LOCAL_ACCELERATION
	
end


function ENT:Explode()

	if self.Exploded then return end
	self.Exploded = true
	--for i=0, 5 do
	
	local ED = EffectData()
	
	ED:SetOrigin( self:GetPos() )
	ED:SetStart( Vector( self.Col.r, self.Col.g, self.Col.b ) ) // Vector is color.
	ED:SetScale( self.FWScale )
	
	local effect = util.Effect( 'firework_explosion', ED, true, true )
	
	--end
	
	local DoBlastDamage = self.BlastDamage -- I have to save this as a variable because I'm removing the entity before blast damage (more information in comment below)
	self:Remove()
	
	-- Note! Make sure this is called AFTER it's removed!
	-- Otherwise, itll cause an infinite loop of creating the effect & exploding.
	
	-- (It was pretty cool, though)
	
end

local function SafeExplode( Ent )

	if !IsValid( Ent ) then return end
	
	Ent:Explode()

end

function ENT:Launch()

	if self.Launched then return end
	
	self:EmitSound( 'fireworks/firework_launch_'..math.random( 1, 2 )..'.wav', 165, math.Rand( 75, 125 ) )
	
	self:SetDTInt( 0, 2 ) -- This controls the flame effect
	
	local Phys = self:GetPhysicsObject()
	
	if Phys:IsValid() then

		if self.AutoUnfreeze then Phys:EnableMotion( true ); end
		Phys:Wake()
		
	end
	
	if self.ExplodeTime != 0 then timer.Simple( self.ExplodeTime, function() SafeExplode(self) end ); end
	
	self.LaunchTime = CurTime()
	self.Launched = true
	
	local ED = EffectData()
	ED:SetOrigin( self:GetPos() + self:GetUp()*19 )
	util.Effect( 'cball_explode', ED )
	SafeRemoveEntityDelayed( self, 5 )
	
end

local function SafeLaunch( Ent )

	if !IsValid( Ent ) then return end
	
	Ent:Launch()

end

function ENT:StartFuse()

	if self.FuseStarted then return end
	
	self:SetColor( Color(255, 100, 100, 255) )
	
	self:SetDTInt( 0, 1 )  -- This controls the flame effect
	
	timer.Simple( self.FuseTime, function() SafeLaunch(self) end )

	self.FuseStarted = true
	
end

function ENT:Use( activator, caller )

	self:StartFuse()
	
end

function ENT:TriggerInput( iname, value )

	if ( iname == 'Launch' && util.tobool( value )) then
	
		self:Launch()
	
	elseif ( iname == 'Start Fuse' && util.tobool( value )) then
	
		self:StartFuse()
	
	elseif ( iname == 'Explode' && util.tobool( value )) then

		SafeExplode( self )
	
	/*elseif ( iname == 'Fuse Time' && value) then

		self.FuseTime = math.Clamp( tonumber( value ), 0.5, math.huge ) || 2
	
	elseif ( iname == 'Explode Time') then

		self.ExplodeTime = math.max( tonumber( value ), 0 ) || 0*/
	
	elseif ( iname == 'Explode Color RGB' && value) then

		if type( value ) != 'Vector' then return end
		
		local R,G,B = value[1], value[2], value[3]
		self.Col = Color( R, G, B )
	
	elseif ( iname == 'Instability' && value) then
	
		self.TrajectoryRand = math.Clamp( tonumber( value ), 0, 50 ) || 10
	
	elseif ( iname == 'Scale' && value) then

		self.FWScale = math.Clamp( tonumber( value ), 0.1, 3 ) || 1
	
	elseif ( iname == 'Trail Color RGB' && value) then
	
		if type( value ) != 'Vector' then return end
		local R,G,B = value[1], value[2], value[3]
		
		local Hue, Saturation, Value = ColorToHSV( Color( R, G, B ) )
		local Col = HSVToColor( Hue, Saturation/3, Value )
		local NewFlame = Vector( Col.r, Col.g, Col.b ) || Vector( 255, 165, 0 )
		
		self.FlameColor = NewFlame
		self:SetDTVector( 0, NewFlame )
		
	end
end
