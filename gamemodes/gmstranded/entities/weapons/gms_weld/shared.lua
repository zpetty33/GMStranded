if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if (CLIENT) then
	SWEP.PrintName			= "Weld Tool"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	SWEP.Slot = 4
	SWEP.SlotPos			= 3 -- Put it right next to the remover tool
end

SWEP.Author			= "SpaceGandalf"
SWEP.Contact		= ""
SWEP.Purpose		= "Welds two props together."
SWEP.Instructions	= "Primary: Select two props to weld. Secondary: Cancel. Reload: Remove welds."

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/v_toolgun.mdl"
SWEP.WorldModel			= "models/weapons/w_toolgun.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

/*---------------------------------------------------------
	Initialize
---------------------------------------------------------*/
SWEP.HoldType = "pistol"
function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
	self.Target1 = nil -- Used to remember the first prop you click
end

/*---------------------------------------------------------
	Deploy
---------------------------------------------------------*/
function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

/*---------------------------------------------------------
	PrimaryAttack - Select & Weld
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	local ply = self.Owner
	if CLIENT then return end
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
	
	local trace = ply:TraceFromEyes(150)
	local ent = trace.Entity
	
	-- Make sure we hit a valid prop and not the world or a player
	if not IsValid(ent) or ent:IsPlayer() or ent:IsWorld() then
		ply:SendMessage("You need to use this on a prop!", 60, Color(255, 0, 0, 255))
		return
	end

	-- Ownership Check (Admins bypass)
	if not (ply:IsAdmin() or SGS.inedit == true) then
		if not ent:CPPICanTool(ply, true) then
			ply:SendMessage("This does not belong to you!", 60, Color(255, 0, 0, 255))
			return
		end
	end

	-- Logic: Is this our first click or our second click?
	if not IsValid(self.Target1) then
		-- First Click
		self.Target1 = ent
		ply:SendMessage("First prop selected. Shoot a second prop to weld.", 60, Color(0, 255, 0, 255))
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	else
		-- Second Click
		if self.Target1 == ent then
			ply:SendMessage("You cannot weld a prop to itself!", 60, Color(255, 0, 0, 255))
			return
		end

		-- Create the Weld (Ent1, Ent2, Bone1, Bone2, ForceLimit, NoCollide)
		-- We set NoCollide to 'true' so welded props don't glitch out against each other
		local constr = constraint.Weld(self.Target1, ent, 0, 0, 0, true, false)
		
		if IsValid(constr) then
			ply:SendMessage("Props successfully welded together!", 60, Color(0, 255, 0, 255))
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		else
			ply:SendMessage("Failed to create weld.", 60, Color(255, 0, 0, 255))
		end
		
		-- Reset the selection so they can weld something else
		self.Target1 = nil 
	end
end

/*---------------------------------------------------------
	SecondaryAttack - Cancel Selection
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	local ply = self.Owner
	if CLIENT then return end
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)

	if IsValid(self.Target1) then
		self.Target1 = nil
		ply:SendMessage("Weld selection cancelled.", 60, Color(255, 255, 0, 255))
	end
end

/*---------------------------------------------------------
	Reload - Remove Welds
---------------------------------------------------------*/
function SWEP:Reload()
	local ply = self.Owner
	if CLIENT then return end

	local trace = ply:TraceFromEyes(150)
	local ent = trace.Entity

	if IsValid(ent) and not ent:IsPlayer() and not ent:IsWorld() then
		-- Ownership Check
		if not (ply:IsAdmin() or SGS.inedit == true) then
			if not ent:CPPICanTool(ply, true) then return end
		end

		-- Remove the constraints
		constraint.RemoveConstraints(ent, "Weld")
		ply:SendMessage("Welds removed from this prop.", 60, Color(255, 255, 0, 255))
		self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
	end
end