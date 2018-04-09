if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if (CLIENT) then
	SWEP.PrintName			= "Remover Tool"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	SWEP.Slot = 4
	SWEP.SlotPos		= 2
end



SWEP.Author		= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""


SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/v_toolgun.mdl"
SWEP.WorldModel			= "models/weapons/w_toolgun.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
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
end

/*---------------------------------------------------------
	Deploy
---------------------------------------------------------*/
function SWEP:Deploy()
	
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
	
end
/*---------------------------------------------------------
	Reload
---------------------------------------------------------*/
function SWEP:Reload()
end

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
	
	if ply:IsAdmin() or SGS.inedit == true then
		SGS.Log("**" .. trace.Entity:GetClass() .. " was removed by " .. ply:Nick() .. "!")
		trace.Entity:Remove()
		timer.Simple( 0, function() ply:SendPropCount() ply:SendStructureCount() end )
		return
	end
	
	if trace.Entity.locked then
		ply:SendMessage("This can't be removed with a plant grown on it.",3,Color(255,0,0,255))
		return
	end

	for k, v in pairs(SGS.AllowedRemove) do
		if trace.Entity:GetClass() == v then
			if !trace.Entity:CPPICanTool(ply, true) then
				ply:SendMessage("This does not belong to you!", 60, Color(255, 0, 0, 255))
				return
			end
			SGS.Log("**" .. trace.Entity:GetClass() .. " was removed by " .. ply:Nick() .. "!")
			trace.Entity:Remove()
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
	
	ply:SendMessage("The deconstruct function has been moved to the Hammer!", 60, Color(255, 100, 100, 255))
	return
end