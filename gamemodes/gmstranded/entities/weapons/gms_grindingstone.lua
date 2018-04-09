AddCSLuaFile()
SWEP.Base = "custom_base"
SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_medkit.mdl"
SWEP.WorldModel = "models/weapons/c_medkit.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["medkit_bone"] = { scale = Vector(0.989, 0.989, 0.989), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["Rock"] = { type = "Model", model = "models/props_foliage/rock_forest01.mdl", bone = "medkit_bone", rel = "", pos = Vector(-0.856, 0, 0), angle = Angle(-27.448, 7.879, -68.584), size = Vector(0.216, 0.216, 0.216), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["Rock"] = { type = "Model", model = "models/props_foliage/rock_forest01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.476, 3.66, -1.068), angle = Angle(-95.449, 14.795, 151.833), size = Vector(0.175, 0.175, 0.175), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
    if CLIENT then return end
    self.Weapon:SetNextPrimaryFire(CurTime() + 2)
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	local pl = self.Owner
	
	pl:SendLua( "SGS_GrindingMenu()")
end

function SWEP:SecondaryAttack()
end