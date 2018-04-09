AddCSLuaFile()
SWEP.Weight = 1 
SWEP.PrintName = "Boss Rod"
SWEP.Author = "MrPresident"
SWEP.Purpose = "Melee Combat"
SWEP.Instructions = "Primary Attack - Attack"
SWEP.Category = "Melee"
 
SWEP.ViewModelFOV = 57
SWEP.ViewModel = "models/rods/c_boss_rod/c_boss_rod.mdl"
SWEP.WorldModel = "models/rods/c_boss_rod/c_boss_rod.mdl"
SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = -1
SWEP.Primary.Automatic          = false
SWEP.Primary.Ammo                       = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
 
SWEP.Slot = 5
SWEP.SlotPos = 3
 
SWEP.UseHands = true
SWEP.FiresUnderwater = true

local SwingSound = Sound( "weapons/slam/throw.wav" )
 
 
function SWEP:Initialize()
	self:SetWeaponHoldType( "melee" )
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:SetupDataTables()
	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )
	self:NetworkVar( "Int", 2, "Combo" )
end

function SWEP:UpdateNextIdle()
	local vm = self.Owner:GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() )
end
 
local Mins, Maxs = Vector(-12, -12, -12), Vector(12, 12, 12)
function SWEP:PrimaryAttack( right )

	local ply = self.Owner
	force = self.Owner:EyeAngles():Forward()
	local td = {}
 
	ply:SetAnimation( PLAYER_ATTACK1 )
	
	local anim = "swing"
	
	local vm = ply:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.8)
	self:UpdateNextIdle()
	if CLIENT then return end
	ply:EmitSound( SwingSound )

	if ply:GetLevel("combat") >= 35 then
		td.start = self.Owner:GetShootPos()
		td.endpos = td.start + force * 100
		td.filter = self.Owner
		td.mins = Mins
		td.maxs = Maxs
	
		if ( ply:IsPlayer() ) then
			ply:LagCompensation( true )
		end
		
		tr = util.TraceHull(td)
		
		if ( ply:IsPlayer() ) then
			ply:LagCompensation( false )
		end

		if tr.Hit then
			ent = tr.Entity
			if IsValid(ent) then
				if SERVER then
					dmg = DamageInfo()
					dmg:SetDamageType( DMG_DISSOLVE )
					dmg:SetDamage( math.random(60,74) )
					
					dmg:SetAttacker(self.Owner)
					dmg:SetInflictor(self.Owner)
					ent:TakeDamageInfo(dmg)
				end		
			end
			SGS_EmitHitSound( tr.MatType, tr.HitPos )
		end
		
		self.Owner:ViewPunch(Angle(math.Rand(-2, 0), 5, math.Rand(-2, 2)))
	else
		ply:SendMessage("This weapon requires a level 35 or higher in combat.", 60, Color(255, 125, 0, 255))
	end
 
end
 
function SWEP:SecondaryAttack()
end