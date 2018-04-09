SGS.Spells = {}
local PlayerMeta = FindMetaTable("Player")

function PlayerMeta:CastSpell( spell )

	if not SGS.Spells[spell] then return end
	if self:InVehicle() then return end
	SGS.Spells[spell]( self )

end

function SGS_ConCastSpell( ply, com, args )

	if not ply:IsSuperAdmin() then return end
	if not #args == 1 then return end
	
	ply:CastSpell( args[1] )

end
concommand.Add( "cast_spell", SGS_ConCastSpell )

function SGS_RegisterSpell( name, func )
	SGS.Spells[name] = func
end

local SPELL = {}
SPELL.name = "windbolt"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(5,7)
	bolt:Spawn()
	bolt:SetColor(Color(255,255,255,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "waterbolt"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(9,15)
	bolt:Spawn()
	bolt:SetColor(Color(125,164,255,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "earthbolt"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(17,24)
	bolt:Spawn()
	bolt:SetColor(Color(0,135,54,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "firebolt"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(26,32)
	bolt:Spawn()
	bolt:SetColor(Color(220,0,0,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "windblast"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(35,43)
	bolt:Spawn()
	bolt:SetColor(Color(255,255,255,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "waterblast"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(45,50)
	bolt:Spawn()
	bolt:SetColor(Color(125,164,255,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "earthblast"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(52,64)
	bolt:Spawn()
	bolt:SetColor(Color(0,135,54,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "fireblast"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(67,73)
	bolt:Spawn()
	bolt:SetColor(Color(220,0,0,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "windwave"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(75,82)
	bolt:Spawn()
	bolt:SetColor(Color(255,255,255,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "waterwave"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(85,93)
	bolt:Spawn()
	bolt:SetColor(Color(125,164,255,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "earthwave"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(96,104)
	bolt:Spawn()
	bolt:SetColor(Color(0,135,54,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "firewave"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_bolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 1000
		bolt.Size = 2
		bolt:SetOwner( self )
		bolt.damage = math.random(104,112)
	bolt:Spawn()
	bolt:SetColor(Color(220,0,0,255))
	self:AddStat( "arcane1", 1 )
	self:CheckForAchievements("arcanemaster")
	
	
	return true
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "spawnteleport"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	self:Freeze( true )
	SGS_TeleportEffect( self )
	timer.Simple( 2, function() 
		if IsValid( self ) and self:Alive() then 
			local spawnarea = ents.FindByClass( "info_player_start" )
			local random_entry = math.random(#spawnarea)
			local newpos = spawnarea[random_entry]:GetPos()
			self:SetPos(newpos)
			self:Freeze( false )
		end
	end )
	self:AddStat( "arcane2", 1 )
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )


local SPELL = {}
SPELL.name = "setteleportlocation"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	SGS_SetTeleportEffect( self )
	self.teleportdest = self:GetPos()
	self:AddStat( "arcane2", 1 )
	
	return true
end
SGS_RegisterSpell( SPELL.name, SPELL.func )


local SPELL = {}
SPELL.name = "teleporttosetlocation"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	self:Freeze( true )
	SGS_TeleportEffect( self )
	timer.Simple( 2, function() 
		if IsValid( self ) and self:Alive() then 
			local newpos = self:GetPos()
			if self.teleportdest then
				newpos = self.teleportdest
			else
				local spawnarea = ents.FindByClass( "info_player_start" )
				local random_entry = math.random(#spawnarea)
				newpos = spawnarea[random_entry]:GetPos()
			end
			self:SetPos(newpos)
			self:Freeze( false )
		end
	end )
	self:AddStat( "arcane2", 1 )
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )


local SPELL = {}
SPELL.name = "teleporttocursor"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	self:Freeze( true )
	
	local newpos = self:TraceFromEyes(12000).HitPos + Vector(0,0,10)
	
	SGS_TeleportEffect( self )
	timer.Simple( 2, function() 
		if IsValid( self ) and self:Alive() then 
			self:SetPos(newpos)
			self:Freeze( false )
		end
	end )
	self:AddStat( "arcane2", 1 )
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "consumetree"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	
	local tr = self:TraceFromEyes(300)
	
	if not IsValid(tr.Entity) then 
		self:SendMessage("You must cast this spell on a tree!", 60, Color(255, 0, 0, 255))
		return false
	end
	
	SGS_ConsumeTree( self, tr.Entity )
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "collectresources"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 500)) do
		for k2, v2 in pairs( SGS.collectibles ) do
			if v:GetClass() == v2 then
				if v:CPPICanTool(self, true) then
					local ED = EffectData()
					ED:SetOrigin( v:GetPos() )
					local effect = util.Effect( 'magic_pickupdrops', ED, true, true )
					timer.Simple( 1.1, function()
						if IsValid( v ) then
							self:AddResource( v.gives, v.level )
							SafeRemoveEntity(v)
						end
					end )
				end
			end
		end
	end
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )


local SPELL = {}
SPELL.name = "callrain"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	if self.lastrain + 600 > CurTime() then
		self:SendMessage("You must wait " .. math.floor(self.lastrain + 600 - CurTime()) .. " more seconds before casting this spell.", 60, Color(255, 0, 0, 255))
		self.failedspell = true
		return false
	end
	
	SGS_CallRainEffect( self )
	SGS_StartRain()
	self.lastrain = CurTime()
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )


local SPELL = {}
SPELL.name = "stoprain"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	SGS_StopRainEffect( self )
	SGS_StopRain()
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )


local SPELL = {}
SPELL.name = "setnight"
SPELL.func = function( self )
	if not IsValid( self ) then return end
	if ( self.timechange + 600 > CurTime() ) and ( not self:IsSuperAdmin() ) then
		self:SendMessage("You must wait " .. math.floor(self.timechange + 600 - CurTime()) .. " more seconds before changing the time.", 60, Color(255, 0, 0, 255))
		self.failedspell = true
		return false
	end	
	
	if GAMEMODE.Worlds.BloodMoon then
		self:SendMessage("The spell backfires!", 60, Color(255, 0, 0, 255))
		d = DamageInfo() 
		d:SetDamageType( DMG_DISSOLVE ) 
		d:SetDamage( 250 ) 
		d:SetAttacker(Entity(0)) 
		d:SetInflictor(Entity(0)) 
		self:TakeDamageInfo(d)
		return true	
	end
	
	DayLight.Minute = 0
	DayLight:ChangeTime()
	net.Start("sgs_settimeupdate")
		net.WriteInt( DayLight.Minute, 16 )
	net.Broadcast()
	self.timechange = CurTime()
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "setday"
SPELL.func = function( self )
	if not IsValid( self ) then return end
	if ( self.timechange + 600 > CurTime() ) and ( not self:IsSuperAdmin() ) then
		self:SendMessage("You must wait " .. math.floor(self.timechange + 600 - CurTime()) .. " more seconds before changing the time.", 60, Color(255, 0, 0, 255))
		self.failedspell = true
		return false
	end	
	
	if GAMEMODE.Worlds.BloodMoon then
		self:SendMessage("The spell backfires!", 60, Color(255, 0, 0, 255))
		d = DamageInfo() 
		d:SetDamageType( DMG_DISSOLVE ) 
		d:SetDamage( 250 ) 
		d:SetAttacker(Entity(0)) 
		d:SetInflictor(Entity(0)) 
		self:TakeDamageInfo(d)
		return true	
	end
	
	DayLight.Minute = 720
	DayLight:ChangeTime()
	net.Start("sgs_settimeupdate")
		net.WriteInt( DayLight.Minute, 16 )
	net.Broadcast()
	self.timechange = CurTime()
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "setdawn"
SPELL.func = function( self )
	if not IsValid( self ) then return end
	if ( self.timechange + 600 > CurTime() ) and ( not self:IsSuperAdmin() ) then
		self:SendMessage("You must wait " .. math.floor(self.timechange + 600 - CurTime()) .. " more seconds before changing the time.", 60, Color(255, 0, 0, 255))
		self.failedspell = true
		return false
	end	
	
	if GAMEMODE.Worlds.BloodMoon then
		self:SendMessage("The spell backfires!", 60, Color(255, 0, 0, 255))
		d = DamageInfo() 
		d:SetDamageType( DMG_DISSOLVE ) 
		d:SetDamage( 250 ) 
		d:SetAttacker(Entity(0)) 
		d:SetInflictor(Entity(0)) 
		self:TakeDamageInfo(d)
		return true	
	end
	
	DayLight.Minute = 360
	DayLight:ChangeTime()
	net.Start("sgs_settimeupdate")
		net.WriteInt( DayLight.Minute, 16 )
	net.Broadcast()
	self.timechange = CurTime()
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "setdusk"
SPELL.func = function( self )
	if not IsValid( self ) then return end
	if ( self.timechange + 600 > CurTime() ) and ( not self:IsSuperAdmin() ) then
		self:SendMessage("You must wait " .. math.floor(self.timechange + 600 - CurTime()) .. " more seconds before changing the time.", 60, Color(255, 0, 0, 255))
		self.failedspell = true
		return false
	end
	
	if GAMEMODE.Worlds.BloodMoon then
		self:SendMessage("The spell backfires!", 60, Color(255, 0, 0, 255))
		d = DamageInfo() 
		d:SetDamageType( DMG_DISSOLVE ) 
		d:SetDamage( 250 ) 
		d:SetAttacker(Entity(0)) 
		d:SetInflictor(Entity(0)) 
		self:TakeDamageInfo(d)
		return true	
	end
	
	DayLight.Minute = 1250
	DayLight:ChangeTime()
	net.Start("sgs_settimeupdate")
		net.WriteInt( DayLight.Minute, 16 )
	net.Broadcast()
	self.timechange = CurTime()
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "killfruit"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	SGS_KillFruitEffect( self )
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 400)) do
		if v:GetClass() == "gms_fruit" then
			timer.Simple( math.random(1, 2.5), function()
				if IsValid(v) then v:Drop() end
			end)
		end
	end
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "growseeds"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	SGS_GrowSeedEffect( self )
	local newpos = self:TraceFromEyes(400).HitPos + Vector(0,0,5)
	
	for k, v in pairs(ents.FindInSphere(newpos, 150)) do
		if v:GetClass() == "gms_seed" or v:GetClass() == "gms_foodseed" or v:GetClass() == "gms_treeseed" then
			v.GrowTime = math.random(0,3)
		end
	end
	
	return true	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "selflight"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	
	if IsValid( self.magiclight ) then 
		self.magiclight:Remove()
	end
	
	local ent = ents.Create("gms_overlight")
		ent.ply = self
		ent.skillcolor = Color(255,255,255,255)
		ent:SetColor(Color(255,255,255,255))
		ent:SetPos(self:GetPos() + Vector(0,0,72))
		ent:Spawn()
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(self)
		-------------------------
		ent:Activate()
		
	self.magiclight = ent
	timer.Simple( 300, function()
		if IsValid(self.magiclight) then self.magiclight:Remove() end
	end)
	
	return true
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "healself"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	
	if not self.lastcasthealself then self.lastcasthealself = CurTime() - 15 end
	
	
	if self.lastcasthealself + 10 > CurTime() then
		self:SendMessage("You must wait " .. math.floor(self.lastcasthealself + 10 - CurTime()) .. " more seconds before healing again.", 60, Color(255, 0, 0, 255))
		self.failedspell = true
		return false
	end
	
	if IsValid( self.magicheal ) then 
		self.magicheal:Remove()
	end

	local val = math.Clamp( self:GetLevel( "arcane" ) * 3, 10, 200)
	
	if self.inpvp then val = math.floor( val * 0.4 ) end
	
	self:Heal( val )
	self:SendMessage("Healed for: " .. tostring(val) .. "hp!", 60, Color(0, 255, 0, 255))
	
	local ent = ents.Create("gms_heal")
		ent.ply = self
		ent:SetColor(Color(0,255,0,255))
		ent:SetPos(self:GetPos() + Vector(0,0,32))
		ent:Spawn()
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(self)
		-------------------------
		ent:Activate()
		
	self.magicheal = ent
	timer.Simple( 3, function()
		if IsValid(self.magicheal) then self.magicheal:Remove() end
	end)
	
	self.lastcasthealself = CurTime()
	
	return true
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "cureself"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	
	if IsValid( self.magicheal ) then 
		self.magicheal:Remove()
	end
	
	self:SendMessage("You are feeling better.", 60, Color(0, 255, 0, 255))
	self.sick = 0
	self.settings["melonaids"] = -1
	self:SendLua("LocalPlayer().melonaids = false")
	
	local ent = ents.Create("gms_heal")
		ent.ply = self
		ent:SetColor(Color(255,255,0,255))
		ent:SetPos(self:GetPos() + Vector(0,0,32))
		ent:Spawn()
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(self)
		-------------------------
		ent:Activate()
		
	self.magicheal = ent
	timer.Simple( 3, function()
		if IsValid(self.magicheal) then self.magicheal:Remove() end
	end)
	
	return true
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "healother"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	
	local tr = self:TraceFromEyes(500)
	
	if not IsValid(tr.Entity) then
		self:SendMessage("You must cast this spell on a player!", 60, Color(255, 0, 0, 255))
		self.failedspell = true
		return false
	end
	if not tr.Entity:IsPlayer() then
		self:SendMessage("You must cast this spell on a player!", 60, Color(255, 0, 0, 255))
		self.failedspell = true
		return false
	end
	
	local tarply = tr.Entity
	
	
	if IsValid( tarply.magicheal ) then 
		tarply.magicheal:Remove()
	end

	local val = math.Clamp( self:GetLevel( "arcane" ) * 3, 10, 200)
	
	if tarply.inpvp then val = math.floor( val * 0.4 ) end
	
	tarply:Heal( val )
	tarply:SendMessage("Healed for: " .. tostring(val) .. "hp by " .. self:Nick(), 60, Color(0, 255, 0, 255))
	
	local ent = ents.Create("gms_heal")
		ent.ply = tarply
		ent:SetColor(Color(0,255,0,255))
		ent:SetPos(tarply:GetPos() + Vector(0,0,32))
		ent:Spawn()
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(tarply)
		-------------------------
		ent:Activate()
		
	tarply.magicheal = ent
	timer.Simple( 3, function()
		if IsValid(tarply.magicheal) then tarply.magicheal:Remove() end
	end)
	
	return true
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "cureother"
SPELL.func = function( self )

	if not IsValid( self ) then return end
	
	local tr = self:TraceFromEyes(500)
	
	if not IsValid(tr.Entity) then
		self:SendMessage("You must cast this spell on a player!", 60, Color(255, 0, 0, 255))
		self.failedspell = true
		return false
	end
	if not tr.Entity:IsPlayer() then
		self:SendMessage("You must cast this spell on a player!", 60, Color(255, 0, 0, 255))
		self.failedspell = true
		return false
	end
	
	local tarply = tr.Entity
	
	if IsValid( tarply.magicheal ) then 
		tarply.magicheal:Remove()
	end
	
	tarply:SendMessage("You were cured by " .. self:Nick(), 60, Color(0, 255, 0, 255))
	tarply.sick = 0
	tarply.settings["melonaids"] = -1
	tarply:SendLua("LocalPlayer().melonaids = false")
	
	local ent = ents.Create("gms_heal")
		ent.ply = tarply
		ent:SetColor(Color(255,255,0,255))
		ent:SetPos(tarply:GetPos() + Vector(0,0,32))
		ent:Spawn()
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(tarply)
		-------------------------
		ent:Activate()
		
	tarply.magicheal = ent
	timer.Simple( 3, function()
		if IsValid(tarply.magicheal) then tarply.magicheal:Remove() end
	end)
	
	return true
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "massres"
SPELL.func = function( self )
	if GAMEMODE.Tribes:GetTribeLevel( self ) < 9 then
		self:SendMessage("Your tribe needs to be at least level 9 to cast this.", 60, Color(255, 0, 0, 255))
		return
	end
	if not IsValid( self ) then return end
	
	if ( self.lastcastmassres or 0 ) + 10 > CurTime() then
		self:SendMessage("You are unable to cast this yet.", 60, Color(255, 50, 50, 255))
		return
	end
	
	SGS_MassResurrectEffect( self )

	local plys = GAMEMODE.Tribes:GetOnlineClanMates( self )
	for k, v in pairs( plys ) do
		if v:GetPos():DistToSqr(self:GetPos()) <= 600000 then
			timer.Simple( math.random( 35, 50 ) / 10, function()
				v:Resurrect()
			end )
		end
	end
	
	self.lastcastmassres = CurTime()

	return true
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "cache"
SPELL.func = function( self )
	if GAMEMODE.Tribes:GetTribeLevel( self ) < 5 then
		self:SendMessage("Your tribe needs to be at least level 5 to cast this.", 60, Color(255, 0, 0, 255))
		return
	end
	if not IsValid( self ) then return end
	
	if ( self.lastcasttribecache or 0 ) + 30 > CurTime() then
		self:SendMessage("You are unable to summon another Tribe Cache yet.", 60, Color(255, 50, 50, 255))
		return
	end
	
	if GAMEMODE.Worlds:GetEntityWorldSpaceID( self ) == 8 then
		self:SendMessage("You are preventing you from summoning your tribe cache here.", 60, Color(255, 50, 50, 255))
		return
	end

	if IsValid( self.tribecacheent ) then self.tribecacheent:Remove() end
	self.tribecacheent = ents.Create( "gms_tribecache" )
	self.tribecacheent:SetPos( self:TraceFromEyes(140).HitPos )
	self.tribecacheent:Spawn()
	self.tribecacheent.tribeid = GAMEMODE.Tribes:GetPlayersTribe( self )
	self.tribecacheent.owner = self
	self.tribecacheent.POwner64 = self:GetPlayerID()
	--SPP MAKE PLAYER OWNER--
	self.tribecacheent:CPPISetOwner(self)
	-------------------------
	SGS_SpawnTribeCacheEffect( self.tribecacheent )
	self:SendMessage("You summon a Tribal Cache to your location!", 60, Color(100, 255, 100, 255))
	self.lastcasttribecache = CurTime()

	return true
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

local SPELL = {}
SPELL.name = "resurrect"
SPELL.func = function( self )

	if not IsValid( self ) then return end

	local bolt = ents.Create("gms_resurrectbolt")
		bolt:SetPos(self:GetPos() + Vector(0,0,60))
		bolt.Direction = self:GetAimVector()
		bolt.Speed = 100
		bolt.Size = 2
		bolt:SetOwner( self )
	bolt:Spawn()
	bolt:SetColor(Color(255,255,255,255))

	return true
	
end
SGS_RegisterSpell( SPELL.name, SPELL.func )

function SGS_SpellCastCon( ply, com, args )

	ply.failedspell = false

	if not #args == 1 then return end
	if not SGS_ReverseSpellLookup( args[1] ) then return end
	
	local spell = SGS_ReverseSpellLookup( args[1] )

	if ply:GetLevel("arcane") < spell.reqlvl then
		ply:SendMessage("This spell requires level " .. tostring(spell.reqlvl) .. ".", 60, Color(255, 0, 0, 255))
		return
	end
	
	for k, v in pairs( spell.cost ) do
		if ( ply.resource[ k ] or 0 ) < v then
			ply:SendMessage("Insufficient resources to cast this spell.", 60, Color(255, 0, 0, 255))
			return
		end
	end
	
	if ply.inprocess then
		ply:SendMessage("You can't cast spells while performing other actions.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't cast spells while dead.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if CurTime() < ( ( ply.lastcast or 0 ) + 0.5 ) then
		return
	end
	
	ply:CastSpell( args[1] )
	
	ply.lastcast = CurTime()
	
	if ply.failedspell == false then
		for k, v in pairs( spell.cost ) do
			ply:SubResource( k, v )
			ply:AddStat( "arcane3", v )
			ply:CheckForAchievements("wizardhat")
			for i = 1, v do
				if math.random(1,4) == 1 then
					ply:AddResourceSilent( "inert_stone", 1 )
				end
			end
		end
		
		ply:AddExp( "arcane", spell.exp )
	end

end
concommand.Add( "sgs_cast", SGS_SpellCastCon)