if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
	
end

if (CLIENT) then
	SWEP.PrintName			= "Prop Locker Tool"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	SWEP.Slot = 4
	SWEP.SlotPos		= 2
end



SWEP.Author			= ""
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

		if self.enttable and #self.enttable > 0 then
		
			for k, v in pairs(self.enttable) do
				if IsValid(v) then
					v:SetColor( v.oldcolor or Color(255,255,255,255) )
					SGS_RemoveLockedProp( v )
				end
			end
			
			self.enttable = {}
			ply:SendMessage("Selected items unlocked!", 60, Color(255, 0, 0, 255))
		
		else
		
			ply:SendMessage("You must first select up to 10 items!", 60, Color(255, 0, 0, 255))
		
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
			if IsValid(v) then
				if v.oldcolor then
					v:SetColor( v.oldcolor )
				else
					v:SetColor( Color(255,255,255,255) )
				end
			end
		end
	end
	
	self.enttable = nil
	
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
	
	local ent = trace.Entity

	if table.HasValue( SGS.AllowedRemove, ent:GetClass() ) then
		if not ent:CPPICanTool(ply, true) then
			ply:SendMessage("(SGS) This does not belong to you!", 60, Color(255, 0, 0, 255))
			return
		end
		
		if table.HasValue( self.enttable, ent ) then
			table.remove( self.enttable, table.KeyFromValue( self.enttable, ent ) )
			ent:SetColor( ent.oldcolor or Color(255,255,255,255) )
		else
			if #self.enttable < 10 then
				ent.oldcolor = ent:GetColor()
				ent:SetColor( Color(255,150,150,200) )
				table.insert( self.enttable, ent )
			else
				ply:SendMessage("You can only select up to 10 items at a time.", 60, Color(255, 0, 0, 255))
			end
		end
	else
		ply:SendMessage("(SGS) You are not authorized to augment that!", 60, Color(255, 0, 0, 255))
	end

end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	local ply = self.Owner
	
	if CLIENT then return end
    self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)

	if self.enttable and #self.enttable > 0 then
		for k, v in pairs(self.enttable) do
			if IsValid(v) then
				v:SetColor( v.oldcolor or Color(255,255,255,255) )
				SGS_AddLockedProp( v )
				
			end
		end
		self.enttable = {}
	else
		ply:SendMessage("You must first select up to 10 items.", 60, Color(255, 0, 0, 255))
	end
	
end