AddCSLuaFile()
SWEP.Base = "custom_base"
SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/c_stunstick.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-2.909, -3.97, -3.768), angle = Angle(-1.874, 0, 0) }
}


SWEP.VElements = {
	["torch"] = { type = "Model", model = "models/devonjones/stranded/torch.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.76, 1.554, -4.959), angle = Angle(180, 138.914, 0.381), size = Vector(0.697, 0.697, 0.697), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["orb"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "torch", pos = Vector(0.16, 0.241, 8.829), angle = Angle(0, 0, 0), size = Vector(0.289, 0.289, 0.289), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["torch"] = { type = "Model", model = "models/devonjones/stranded/torch.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.66, 1.779, -4.028), angle = Angle(180, 95.352, 17.398), size = Vector(0.697, 0.697, 0.697), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["orb"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "torch", pos = Vector(0.16, 0.241, 8.829), angle = Angle(0, 0, 0), size = Vector(0.289, 0.289, 0.289), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()

	local ply = self.Owner
    if CLIENT then return end
    self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)

	local tr = ply:TraceFromEyes(160)
	
	if tr.HitWorld then
		local ent = ents.Create("gms_torch")
		ent:SetPos(tr.HitPos + Vector(0,0,6))
		ent:Spawn()
		ent:SetAngles( Angle(0,0,0) )
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(ply)
		-------------------------
		
		local phys = ent:GetPhysicsObject()
		if phys and phys:IsValid() then
			phys:EnableMotion(false) -- Freezes the object in place.
		end
		
		--ply:RemTool( ply:GetActiveWeapon():GetClass() )
		ply:StripWeapons()
		ply.equippedtool = "NONE"
		SGS_EquipTools( ply, _, {"gms_handtorch"} )
	else
		ply:SendMessage("You must place the torch on a world surface.", 60, Color(255, 0, 0, 255))
		return
	end
end

--Called when the SENT thinks.
--Return: Nothing
function SWEP:Think()
end