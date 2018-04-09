AddCSLuaFile()
SWEP.Base = "custom_base"
SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/c_crowbar.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-8.197, 0.43, -2.122), angle = Angle(-1.657, 0, 0) }
}

SWEP.VElements = {
	["hammer_model"] = { type = "Model", model = "models/devonjones/stranded/hammer.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.877, 1.46, -3.819), angle = Angle(180, 76.273, 0), size = Vector(0.769, 0.769, 0.769), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["hammer_model"] = { type = "Model", model = "models/devonjones/stranded/hammer.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.734, 1.001, -4.902), angle = Angle(-175.355, 55.285, 0), size = Vector(0.981, 0.981, 0.981), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	local ply = self.Owner
    if CLIENT then return end
    self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
	
	local trace = ply:TraceFromEyes(150)
	
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to use this on a prop!", 60, Color(255, 0, 0, 255))
		return
	end
	 
	for k, v in pairs(SGS.AllowedRemove) do
		if trace.Entity:GetClass() == v then
			if !trace.Entity:CPPICanTool(ply, true) then
				ply:SendMessage("This does not belong to you!", 60, Color(255, 0, 0, 255))
				return
			end
			if trace.Entity:GetClass() == "gms_prop" then
				SGS_UnBuildProp_Start(ply, 3, trace.Entity)
			end
			return
		end
	end
	ply:SendMessage("You are not authorized to remove that!", 60, Color(255, 0, 0, 255))
	return
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	local ply = self.Owner
    if CLIENT then return end
    self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
	
	local trace = ply:TraceFromEyes(150)
	
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to use this on a prop!", 60, Color(255, 0, 0, 255))
		return
	end
	
	if trace.Entity.health then
		if trace.Entity.health < trace.Entity.maxhealth then
			trace.Entity.health = math.Clamp( trace.Entity.health + 25, 1, trace.Entity.maxhealth )
			sound.Play( "physics/metal/metal_solid_impact_soft" .. math.random(3) .. ".wav", trace.HitPos, 80, math.random(80,120) )
			
			local hp_percent = trace.Entity.health / trace.Entity.maxhealth
			trace.Entity:SetColor( Color( trace.Entity.healthycolor.r * hp_percent, trace.Entity.healthycolor.g * hp_percent, trace.Entity.healthycolor.b * hp_percent, 255 ) )
		end
	end	
end