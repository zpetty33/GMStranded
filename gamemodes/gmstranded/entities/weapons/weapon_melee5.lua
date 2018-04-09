AddCSLuaFile()
SWEP.Base = "custom_base"
SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 60.100502512563
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/c_crowbar.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-3.646, -3.089, -2.162), angle = Angle(0.13, 0, 0) }
}

SWEP.VElements = {
	["rod"] = { type = "Model", model = "models/devonjones/stranded/largemace.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.02, 1.31, -2.937), angle = Angle(-180, 0, 0), size = Vector(1, 1, 1), color = Color(41, 155, 6, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["rod"] = { type = "Model", model = "models/devonjones/stranded/largemace.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.7, 2.217, -3.781), angle = Angle(-168.027, -53.746, -0.636), size = Vector(0.8, 0.8, 0.8), color = Color(41, 155, 6, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


local SwingSound = Sound( "weapons/slam/throw.wav" )
local Mins, Maxs = Vector(-12, -12, -12), Vector(12, 12, 12)
function SWEP:PrimaryAttack( right )
	local ply = self.Owner
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_MISSCENTER )
	if IsFirstTimePredicted() then
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	end

	force = self.Owner:EyeAngles():Forward()
	local td = {}
 
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.8)
	
	if CLIENT then return end
	
	ply:EmitSound( SwingSound )
	
	if ply:GetLevel("combat") >= 40 then
		td.start = ply:GetShootPos()
		td.endpos = td.start + force * 100
		td.filter = ply
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
					dmg:SetDamageType( DMG_GENERIC )
					dmg:SetDamage( math.random(28,41) )
					
					dmg:SetAttacker(self.Owner)
					dmg:SetInflictor(self.Owner)
					dmg:SetDamageForce(force * 20000)
					ent:TakeDamageInfo(dmg)
				end	
			end
			SGS_EmitHitSound( tr.MatType, tr.HitPos )
		end
		
		ply:ViewPunch(Angle(math.Rand(-2, 0), 5, math.Rand(-2, 2)))
	else
		ply:SendMessage("This weapon requires a level 40 or higher in combat.", 60, Color(255, 125, 0, 255))
	end

end

 
function SWEP:SecondaryAttack()
end