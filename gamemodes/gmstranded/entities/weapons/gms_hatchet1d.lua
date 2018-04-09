AddCSLuaFile()

SWEP.ViewModelFOV		= 70
SWEP.ViewModelFlip		= false

SWEP.ViewModel			= SGS.proplist["hatchet_v"]
SWEP.WorldModel			= SGS.proplist["hatchet_w"]

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
	
	self.Owner:GetViewModel():SetPlaybackRate(1.3)
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
	
end

local SwingSound = Sound( "weapons/slam/throw.wav" )
/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	local anim = { "swingdown", "swingleft" }
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( table.Random(anim) ) )
	self:EmitSound( SwingSound )
	
	if CLIENT then return end
	local ply = self.Owner
	
    self.Weapon:SetNextPrimaryFire(CurTime() + 0.1)
	
	local trace = ply:TraceFromEyes(100)
	
	if not IsValid(trace.Entity) then
		ply:SendMessage("(SGS) You need to swing this at a tree!", 60, Color(255, 0, 0, 255))
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.8)
		return
	end
	if not ( string.Left(trace.Entity:GetClass(), 8) == "gms_tree" ) then
		ply:SendMessage("(SGS) You need to swing this at a tree!", 60, Color(255, 0, 0, 255))
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.8)
		return
	end
	for k, v in pairs( SGS_ReverseToolLookup(self:GetClass() ).uselevel ) do
		if ply:GetLevel( k ) < v then
			ply:SendMessage("This tool requires level " .. tostring(v) .. " " .. Cap(k) .. " to use!", 60, Color(255, 0, 0, 255))
			return
		end
	end
	local modi = 1.2
	local timemodi = 0.2
	
	SGS_Lumber( ply, trace.Entity, timemodi, modi, "d", nil )

end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end


function SWEP:Think()

	self:NextThink(CurTime())
	return true

end