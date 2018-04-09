AddCSLuaFile()
SWEP.Base = "custom_base"
SWEP.HoldType = "knife"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/c_crowbar.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-8.431, -0.695, -2.451), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["pan_model"] = { type = "Model", model = "models/props_c17/metalPot002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.634, 1.123, -7.118), angle = Angle(-88.614, -158.95, -13.436), size = Vector(0.755, 0.755, 0.755), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["pan_model"] = { type = "Model", model = "models/props_c17/metalPot002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.366, 2.703, -10.747), angle = Angle(-81.821, -66.764, 126.623), size = Vector(1.128, 1.128, 1.128), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
    if CLIENT then return end
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end