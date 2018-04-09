AddCSLuaFile()
SWEP.Base = "custom_base"
SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/c_crowbar.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-0.183, 3.039, -0.672), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-6.134, -0.396, 0), angle = Angle(0, 0, 0) }
}


SWEP.VElements = {
	["hoe_model"] = { type = "Model", model = "models/devonjones/stranded/hoe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.15, 1.659, -6.296), angle = Angle(180, 61.928, 2.528), size = Vector(0.689, 0.689, 0.689), color = Color(204, 204, 204, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["hoe_model"] = { type = "Model", model = "models/devonjones/stranded/hoe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.69, 2.509, -6.687), angle = Angle(5.716, -115.833, -175.655), size = Vector(0.87, 0.87, 0.87), color = Color(204, 204, 204, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	local ply = self.Owner
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_MISSCENTER )
	if IsFirstTimePredicted() then
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	end

	local modi = 4.4
	local timemodi = 2.2
    self.Weapon:SetNextPrimaryFire(CurTime() + ( 3 - timemodi ) )
	if CLIENT then return end
	
	if self.Owner:GetLevel("farming") < 65 then
		self.Owner:SendMessage("This tool requires farming level 65 or higher.", 60, Color(255, 125, 0, 255))
		return
	end
	
	local tr = ply:TraceFromEyes(140)
	if tr.HitWorld then
		local mattype = tr.MatType
		if not ( mattype == MAT_DIRT or mattype == MAT_SAND or mattype == MAT_GRASS or mattype == MAT_SNOW ) then return end
		for k, v in pairs(ents.FindInSphere( tr.HitPos, 50 )) do
			if v:GetClass() == "gms_wheat" or v:GetClass() == "gms_liferoot" then
				SGS_Harvest_Start(ply, 3 - timemodi, v)
				return
			end
		end
		SGS_Forage_Start(ply, 3 - timemodi, modi)
	else
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "gms_gardenblock" then
			for k, v in pairs(ents.FindInSphere( tr.HitPos, 50 )) do
				if v:GetClass() == "gms_wheat" or v:GetClass() == "gms_liferoot" then
					SGS_Harvest_Start(ply, 3 - timemodi, v)
					return
				end
			end
		end
		ply:SendMessage("(SGS) You need to swing this at the ground!", 60, Color(255, 0, 0, 255))
	end

end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end