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
	Reload
---------------------------------------------------------*/
function SWEP:Reload()
	local ply = self.Owner
	
	if CLIENT then return end
	
	if CurTime() > ply.lastuse + 1 then

		if self.enttable and #self.enttable >= 1 then
		
			for k, v in pairs(self.enttable) do
				constraint.RemoveConstraints( v, "NoCollide" )
			end
			
			for k3, v3 in pairs(self.enttable) do
				local ec = v3:GetColor()
				v3:SetColor(Color(math.Clamp(ec.r + 100, 0, 255), math.Clamp(ec.g + 100, 0, 255), ec.b, 255))
			end
			self.enttable = {}
			ply:SendMessage("(SGS) NoCollide constraints removed!", 60, Color(255, 0, 0, 255))
		
		else
		
			ply:SendMessage("(SGS) You must first select up to 10 items!", 60, Color(255, 0, 0, 255))
		
		end
		
		ply.lastuse = CurTime()
	end
end

/*---------------------------------------------------------
	Deploy
---------------------------------------------------------*/
function SWEP:Deploy()
	
	self.enttable = {}
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
	
end

/*---------------------------------------------------------
	Remove
---------------------------------------------------------*/
function SWEP:OnRemove()
	
	if self.enttable and #self.enttable > 0 then
		for k, v in pairs(self.enttable) do
			local ec = v:GetColor()
			v:SetColor(Color(math.Clamp(ec.r + 100, 0, 255), math.Clamp(ec.g + 100, 0, 255), ec.b, 255))
		end
	end
	
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
		ply:SendMessage("(SGS) You need to use this on a prop!", 60, Color(255, 0, 0, 255))
		return
	end

	for k, v in pairs(SGS.AllowedRemove) do
		if trace.Entity:GetClass() == v then
		
			if !trace.Entity:CPPICanTool(ply, true) then
				ply:SendMessage("(SGS) This does not belong to you!", 60, Color(255, 0, 0, 255))
				return
			end
		
			local found = false
			local ec = trace.Entity:GetColor()
			for k, v in pairs(self.enttable) do
				if v == trace.Entity then
					table.remove( self.enttable, k )
					trace.Entity:SetColor(Color(math.Clamp(ec.r + 100, 0, 255), math.Clamp(ec.g + 100, 0, 255), ec.b, 255))
					found = true
					break
				end
			end
			
			if found then
				ply:SendMessage("(SGS) Prop Unselected!", 60, Color(255, 0, 0, 255))
			else
				if #self.enttable < 10 then
					ply:SendMessage("(SGS) Prop Selected!", 60, Color(255, 0, 0, 255))
					trace.Entity:SetColor(Color(math.Clamp(ec.r - 100, 0, 255), math.Clamp(ec.g - 100, 0, 255), ec.b, 255))
					table.insert(self.enttable, trace.Entity)
				else
					ply:SendMessage("(SGS) You can only select 10 items at a time!", 60, Color(255, 0, 0, 255))
				end
			end
			
			return
		end
	end
	
	ply:SendMessage("(SGS) You are not authorized to augment that!", 60, Color(255, 0, 0, 255))
	return
	
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	local ply = self.Owner
	
	if CLIENT then return end
    self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)

	if self.enttable and #self.enttable >= 2 then
	
		for k, v in pairs(self.enttable) do
			constraint.RemoveConstraints( v, "NoCollide" )
		end
		
		for k4, v4 in pairs(self.enttable) do
			for k2, v2 in pairs(self.enttable) do
				constraint.NoCollide( v4, v2, 0, 0)
			end
		end
		
		
		
		for k3, v3 in pairs(self.enttable) do
			local ec = v3:GetColor()
			v3:SetColor(Color(math.Clamp(ec.r + 100, 0, 255), math.Clamp(ec.g + 100, 0, 255), ec.b, 255))
		end
		self.enttable = {}
	
	else
	
		ply:SendMessage("(SGS) You must first select from 2 to 10 items!", 60, Color(255, 0, 0, 255))
	
	end
	
end