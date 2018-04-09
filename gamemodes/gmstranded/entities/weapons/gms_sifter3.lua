AddCSLuaFile()
SWEP.Base = "custom_base"
SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/c_slam.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["Detonator"] = { scale = Vector(1, 1, 1), pos = Vector(-30, 0, 0), angle = Angle(0, 0, 0) },
	["Slam_panel"] = { scale = Vector(1, 1, 1), pos = Vector(-30, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-0.408, 1.32, -3.402), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(-1.803, 1.381, -0.75), angle = Angle(1.126, 0, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(2.519, 0.052, 3.079), angle = Angle(0, 0, 0) },
	["Slam_base"] = { scale = Vector(1, 1, 1), pos = Vector(-30, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0.555, -0.556, 0.185), angle = Angle(1.11, 0, 0) }
}

SWEP.VElements = {
	["sifter_model"] = { type = "Model", model = "models/devonjones/stranded/sifter.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.119, 6.32, -0.654), angle = Angle(120.391, 45.266, -3.23), size = Vector(0.795, 0.795, 0.795), color = Color(255 * 0.1, 255 * 0.3, 255 * 0.1, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["sifter_model"] = { type = "Model", model = "models/devonjones/stranded/sifter.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.177, 6.592, -2.96), angle = Angle(102.133, 76.799, -62.304), size = Vector(0.795, 0.795, 0.795), color = Color(255 * 0.1, 255 * 0.3, 255 * 0.1, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
    if CLIENT then return end
    self:SetNextPrimaryFire(CurTime() + 1)
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	local pl = self.Owner
	
	local tr = pl:TraceFromEyes(130)
	if tr.HitWorld then
		if tostring(tr.MatType) == "78" then
			SGS_Sift_Start( pl, 1, 3 )
		else
			pl:SendMessage("You can only sift sand.", 60, Color(255, 0, 0, 255))
		end
	end
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end