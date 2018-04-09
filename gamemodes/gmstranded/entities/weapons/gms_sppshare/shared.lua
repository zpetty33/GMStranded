if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if (CLIENT) then
	SWEP.PrintName			= "Share Tool"
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
	PrimaryAttack
---------------------------------------------------------*/
local restricted_entities = { "gms_tribecache" }
function SWEP:PrimaryAttack()
	local ply = self.Owner
    if CLIENT then return end
    self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	local trace = ply:TraceFromEyes(150)
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to use this on a prop!", 60, Color(255, 0, 0, 255))
		return
	end

	if table.HasValue( SGS.AllowedRemove, trace.Entity:GetClass() ) and not table.HasValue( restricted_entities, trace.Entity:GetClass() ) then
		if trace.Entity:CPPICanTool( ply, true ) then
			trace.Entity:CPPISetOwnerless(true)
			trace.Entity.ownerless = true
			timer.Simple( 180, function() SGS_MarkForDeletionOwnerless( trace.Entity ) end )
			ply:SendMessage("Unowned Item: This item will remove after 3 minutes of being ownerless!", 60, Color(0, 255, 255, 255))
			ply:SendPropCount()
			ply:SendStructureCount()
			return
		else
			ply:SendMessage("This does not belong to you!", 60, Color(255, 0, 0, 255))
			return
		end
	end
	ply:SendMessage("You are not authorized to modify that!", 60, Color(255, 0, 0, 255))
	return
	
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	local ply = self.Owner
    if CLIENT then return end
    self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	local trace = ply:TraceFromEyes(150)
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to use this on a prop!", 60, Color(255, 0, 0, 255))
		return
	end
	
	if table.HasValue( SGS.AllowedRemove, trace.Entity:GetClass() ) then
		if trace.Entity:CPPIGetOwner() == true then
			ply:SendMessage("You now own this item!", 60, Color(0, 255, 255, 255))
			trace.Entity.ownerless = false
			trace.Entity:CPPISetOwnerless(false)
			trace.Entity:CPPISetOwner(ply)
			return
		else
			ply:SendMessage("This item is already owned by another player!", 60, Color(255, 0, 0, 255))
			return
		end
	end
	ply:SendMessage("You are not authorized to modify that!", 60, Color(255, 0, 0, 255))
	return
	
end

/*---------------------------------------------------------
	Reload
---------------------------------------------------------*/
function SWEP:Reload()
	local ply = self.Owner
	if CLIENT then return end
	
	if CurTime() < ply.lastuse + 0.5 then return end
	
	ply.lastuse = CurTime()
	
	local trace = ply:TraceFromEyes(150)
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to use this on a prop!", 60, Color(255, 0, 0, 255))
		return
	end
	
	if table.HasValue( SGS.AllowedPackage, trace.Entity:GetClass() ) or ( trace.Entity:GetClass() == "gms_tribecache" ) then
		if !trace.Entity:CPPICanTool(ply, true) then
			ply:SendMessage("You can only share items you own!", 60, Color(255, 0, 0, 255))
			return
		end
		if trace.Entity:GetNWBool("shared") then
			if ply:Team() == 10000 then
				trace.Entity:SetNWBool("shared", false)
			else
				trace.Entity:SetNWBool("tribeshared", true)
				trace.Entity:SetNWBool("shared", false)
				trace.Entity.sharedtribe = ply:Team()
			end
		elseif trace.Entity:GetNWBool("tribeshared") then
			trace.Entity:SetNWBool("tribeshared", false)
			trace.Entity:SetNWBool("shared", false)
			trace.Entity.sharedtribe = nil
		else
			trace.Entity:SetNWBool("tribeshared", false)
			trace.Entity:SetNWBool("shared", true)
			trace.Entity.sharedtribe = nil
		end
		return
	end
	
	if trace.Entity:GetClass() == "prop_vehicle_prisoner_pod" then
		if !trace.Entity:CPPICanTool(ply, true) then
			ply:SendMessage("You can only share items you own!", 60, Color(255, 0, 0, 255))
			return
		end
		if trace.Entity:GetNWBool("shared") then
			trace.Entity:SetNWBool("tribeshared", true)
			trace.Entity:SetNWBool("shared", false)
		elseif trace.Entity:GetNWBool("tribeshared") then
			trace.Entity:SetNWBool("tribeshared", false)
			trace.Entity:SetNWBool("shared", false)
		else
			trace.Entity:SetNWBool("tribeshared", false)
			trace.Entity:SetNWBool("shared", true)
		end
		return
	end
	
	ply:SendMessage("You are not authorized to share that!", 60, Color(255, 0, 0, 255))
	return

end