AddCSLuaFile()
SWEP.ViewModelFOV		= 55
SWEP.ViewModelFlip		= false
SWEP.CSMuzzleFlashes	= false
SWEP.UseHands = true
SWEP.ViewModel			= SGS.proplist["pickaxe_v"]
SWEP.WorldModel			= SGS.proplist["pickaxe_w"]

local SwingSound = Sound( "weapons/slam/throw.wav" )

/*---------------------------------------------------------
	Initialize
---------------------------------------------------------*/
SWEP.HoldType = "melee"
function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
end

/*---------------------------------------------------------
	Deploy
---------------------------------------------------------*/
function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
end


/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	local ply = self.Owner
    
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	local anim = "swing"
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )
	self:EmitSound( SwingSound )
	
	if CLIENT then return end
	
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.25)
	local trace = ply:TraceFromEyes(100)
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to swing this at a rock!", 60, Color(255, 0, 0, 255))
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.8)
		return
	end
	if not ( table.HasValue(SGS.rocks, trace.Entity:GetClass() ) ) then
		ply:SendMessage("You need to swing this at a rock!", 60, Color(255, 0, 0, 255))
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.8)
		return
	end
	for k, v in pairs( SGS_ReverseToolLookup(self:GetClass() ).uselevel ) do
		if ply:GetLevel( k ) < v then
			ply:SendMessage("This tool requires level " .. tostring(v) .. " " .. Cap(k) .. " to use!", 60, Color(255, 0, 0, 255))
			return
		end
	end
	
	local modi = 4
	local timemodi = 2.5

	SGS_Mine( ply, trace.Entity, timemodi, modi, nil, true )
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end