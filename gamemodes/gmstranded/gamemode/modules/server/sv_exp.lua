local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")

SGS.bonusexp = {}

function PlayerMeta:GetTotalXP()

	local xp = 0
	for k, v in pairs( SGS.skills ) do
		xp = xp + self.exp[ v ]
	end
	return xp

end

function PlayerMeta:SetLevels()

	self.level = {}
	for k, v in pairs( SGS.skills ) do
		self.level[ v ] = 1
		self:SetLevel( v, self.level[ v ] )
	end

end

function PlayerMeta:SetLevel( skill, amt )
	if amt < 0 then
		amt = 0
	end
	self.level[ skill ] = amt
	net.Start("sgs_updatelevel")
		net.WriteString( skill )
		net.WriteInt( amt, 32 )
	net.Send( self )
end

function PlayerMeta:GetLevel(skill)
	if self.level == nil then return 1 end
	if self.level[ skill ] == nil then return 1 end

	if self.skillbook == skill and self.skillbookval then
		return self.level[ skill ] + self.skillbookval
	end

	return self.level[ skill ]
end

function PlayerMeta:SetSurvivalLevel()
	local nslvl = 1
	local tlvl =  0
	for k, v in pairs( SGS.skills ) do
		tlvl = tlvl + self.level[ v ]
	end
	nslvl = math.floor( (tlvl - 10) / 20 ) + 1
	nslvl = math.Clamp( nslvl, 1, SGS.maxlevelsurvival )

	self:SetNWString("survival", tostring(nslvl))
	self:SetLevel( "survival", nslvl )
	self:SetFrags( nslvl )
end

function PlayerMeta:SetSurvivalLevelStats()

	local pslvl = self.level[ "survival" ]

	--Set Max Health
	local mhealth = ( (pslvl - 1) * 4 ) + 100
	self:SetMaxHealth(mhealth)
	self:SetHealth(self:GetMaxHealth())

	--Set Max Inventory
	self:RecalculateMaxInv()
	self:CalcMaxPlants()

	self.maxneeds = 1000 * ( 1 + ( ( self:GetLevel( "survival" ) - 1 ) * 0.03) )
	self:SendLua("SGS.maxneeds = " .. self.maxneeds )

	self.o2 = self.maxneeds
	if self.o2 == nil then self.o2 = 1000 end
	net.Start("sgs_sendo2")
		net.WriteInt( self.o2, 32 )
		net.WriteString( "no" )
	net.Send( self )

	SGS_SetNeeds( self )



end

function PlayerMeta:CalcMaxPlants()
	local pslvl = self.level[ "survival" ]
	self.maxplants = 5 + math.ceil( pslvl / 6 )

	if self:GetAch("planting1") then
		self.maxplants = self.maxplants + 3
	end

	if self:GetAch("planting2") then
		self.maxplants = self.maxplants + 6
	end

	if self:IsDonator() then
		self.maxplants = self.maxplants + 2
	end

	if self:IsMember() then
		self.maxplants = self.maxplants + 4
	end

	self:SendLua( "SGS.maxplants = " .. self.maxplants )
	self:ConCommand( "sgs_refreshfarming" )
end

function PlayerMeta:CalcMaxPets()

	self.maxpets = 5

	if self:GetAch("maxpets1") then
		self.maxpets = self.maxpets + 5
	end

	if self:GetAch("maxpets2") then
		self.maxpets = self.maxpets + 5
	end

	if self:IsMember() then
		self.maxpets = self.maxpets + 5
	end

	if self:IsDonator() then
		self.maxpets = self.maxpets + 5
	end

end

function RecalcMaxPets( ply, com, args )
	ply:CalcMaxPets()
end
concommand.Add("sgs_recalculatemaxpets", RecalcMaxPets)

function SGS_ConRelculateMaxPlants(ply, com, args)
	ply:CalcMaxPlants()
end
concommand.Add("sgs_recalculatemaxplants", SGS_ConRelculateMaxPlants)

function PlayerMeta:AddExp( skill, amt, shared )
	if not self.loaded then return end
	if amt == 0 then return end
	local xp_string = ""
	if not shared then
		amt = math.ceil(amt * 0.6)
		local tribe_amt =  math.ceil( amt * 0.08 )
		local world_mod = 1
		if GAMEMODE.Worlds:GetEntityWorldSpace( self ) then
			world_mod = GAMEMODE.Worlds:GetEntityWorldSpace( self ).expmod or 1
		end
		if world_mod < 1 and self:GetLevel( "survival" ) < 5 then world_mod = 1 end

		amt = amt * world_mod

		if GAMEMODE.Tribes:GetTribeLevel( self ) >= 8 then
			amt = math.ceil(amt * 1.20)
		elseif GAMEMODE.Tribes:GetTribeLevel( self ) >= 2 then
			amt = math.ceil(amt * 1.10)
		end


		if SGS.bonusexp[skill] then
			if SGS.bonusexp[skill].enabled then
				local mod = 1 + SGS.bonusexp[skill].mod / 100
				amt = math.ceil(amt * mod)
			end
		end


		if self:IsMember() then
			if self:IsDonator() then
				amt = math.ceil(amt * 1.20)
			else
				amt = math.ceil(amt * 1.08)
			end
		end

		if ( self.peffect == true ) and ( self.elixir == skill ) then
			amt = amt * self.elixirval
			amt = math.ceil(amt)
		end

		if ( self.peffect == true ) and ( self.elixir == "all"	) then
			amt = amt * self.elixirval
			amt = math.ceil(amt)
		end

		if self.totems[skill] == true then
			amt = amt * 1.25
			amt = math.ceil(amt)
		end

		if GAMEMODE.Tribes:GetTribeLevel( self ) >= 3 then
			if math.random( 1, 4 ) == 1 then
				local amt2 = math.ceil( amt / 10 )
				local plys = GAMEMODE.Tribes:GetOnlineClanMates( self )
				for k, v in pairs( plys ) do
					if v:GetPos():DistToSqr(self:GetPos()) <= 11183968 then
						v:AddExp( skill, amt2, true )
					end
				end
			end
		elseif GAMEMODE.Tribes:GetTribeLevel( self ) >= 1 then
			if math.random( 1, 8 ) == 1 then
				local amt2 = math.ceil( amt / 20 )
				local plys = GAMEMODE.Tribes:GetOnlineClanMates( self )
				for k, v in pairs( plys ) do
					if v:GetPos():DistToSqr(self:GetPos()) <= 11183968 then
						v:AddExp( skill, amt2, true )
					end
				end
			end
		end

		local tribeshare = false
		if GAMEMODE.Tribes:GetTribeLevel( self ) >= 1 then
			if not GAMEMODE.Tribes.ExpCaps then GAMEMODE.Tribes.ExpCaps = {} end
			if not GAMEMODE.Tribes.ExpCaps[ self:GetPlayerID() ] then GAMEMODE.Tribes.ExpCaps[ self:GetPlayerID() ] = 0 end
			if GAMEMODE.Tribes.ExpCaps[ self:GetPlayerID() ] < GAMEMODE.Tribes.PlayerExpCap then
				GAMEMODE.Tribes.ExpCaps[ self:GetPlayerID() ] = GAMEMODE.Tribes.ExpCaps[ self:GetPlayerID() ] + tribe_amt
				if not GAMEMODE.Tribes.tblTribes[ GAMEMODE.Tribes:GetPlayersTribe( self ) ].expcontributions then GAMEMODE.Tribes.tblTribes[ GAMEMODE.Tribes:GetPlayersTribe( self ) ].expcontributions = {} end
				if not GAMEMODE.Tribes.tblTribes[ GAMEMODE.Tribes:GetPlayersTribe( self ) ].expcontributions[ self:SteamID() ] then GAMEMODE.Tribes.tblTribes[ GAMEMODE.Tribes:GetPlayersTribe( self ) ].expcontributions[ self:SteamID() ] = 0 end
				GAMEMODE.Tribes.tblTribes[ GAMEMODE.Tribes:GetPlayersTribe( self ) ].expcontributions[ self:SteamID() ] = GAMEMODE.Tribes.tblTribes[ GAMEMODE.Tribes:GetPlayersTribe( self ) ].expcontributions[ self:SteamID() ] + tribe_amt
				GAMEMODE.Tribes:AddExp( GAMEMODE.Tribes:GetPlayersTribe( self ), tribe_amt )
				GAMEMODE.Tribes:NetworkContribution( GAMEMODE.Tribes:GetPlayersTribe( self ), self, GAMEMODE.Tribes.tblTribes[ GAMEMODE.Tribes:GetPlayersTribe( self ) ].expcontributions[ self:SteamID() ] )
				tribeshare = true
			end
		end

		local clvl = self.level[ skill ]
		if clvl >= SGS.maxlevel then
			xp_string = "MAX!"
		else
			xp_string = "+" .. amt .. "xp"
		end

		if tribeshare then
			xp_string = xp_string .. " (+" .. tribe_amt .. " tribe)"
		end
	end

	local cexp = self.exp[ skill ]
	local nexp = cexp + amt
	local clvl = self.level[ skill ]

	if shared then
		xp_string = "from tribe: " .. amt .. "xp"
	end
	
	self:SendExpInfo( skill, nexp, amt, xp_string )

	if clvl >= SGS.maxlevel then return end

	self:SetExp( skill, nexp )

	local nlvl = SGS_CheckEXPforLVL( nexp )

	if nlvl > clvl then
		self:SetLevel( skill, nlvl )
		self:SendMessage("You have leveled up! Your " .. Cap(skill) .. " level is now " .. nlvl .. "!", 60, Color(0, 255, 255, 255))
		self:LevelUpEffect(skill)
		self:CheckSkillUnlock( skill, nlvl )
		self:SaveCharacter()

		if nlvl == SGS.maxlevel then
			self:AnnounceCap( skill )
		end
	end

	local cslvl = self.level[ "survival" ]
	local nslvl = 1
	local tlvl =  0
	for k, v in pairs( SGS.skills ) do
		tlvl = tlvl + self.level[ v ]
	end
	nslvl = math.floor( (tlvl - 10) / 20 ) + 1
	nslvl = math.Clamp( nslvl, 1, SGS.maxlevelsurvival )

	if nslvl > cslvl then
		self:SetSurvivalLevel()
		self:SendMessage("Your survival level has gone up!", 60, Color(0, 255, 255, 255))
		self:SendMessage("Max Health has increased!", 60, Color(0, 255, 255, 255))
		self:SendMessage("Max Inventory has increased!", 60, Color(0, 255, 255, 255))
		self:LevelUpSurvivalEffect()
		self:SetSurvivalLevelStats()
		self:SaveCharacter()
		self:CheckForAchievements( "steamgroup" )

		if nslvl == 10 or nslvl == 20 or nslvl == 30 or nslvl == SGS.maxlevelsurvival then
			self:AnnounceMilestone( nslvl )
		end
	end
end

function PlayerMeta:AddExp2( skill, amt )
	if not self.loaded then return end
	if amt == 0 then return end
	local xp_string = ""

	local clvl = self.level[ skill ]
	if clvl >= SGS.maxlevel then
		xp_string = "MAX!"
	else
		xp_string = "+" .. amt .. "xp"
	end

	local cexp = self.exp[ skill ]
	local nexp = cexp + amt
	local clvl = self.level[ skill ]
	
	self:SendExpInfo( skill, nexp, amt, xp_string )
	if clvl >= SGS.maxlevel then return end

	self:SetExp( skill, nexp )

	local nlvl = SGS_CheckEXPforLVL( nexp )

	if nlvl > clvl then
		self:SetLevel( skill, nlvl )
		self:SendMessage("You have leveled up! Your " .. Cap(skill) .. " level is now " .. nlvl .. "!", 60, Color(0, 255, 255, 255))
		self:LevelUpEffect(skill)
		self:CheckSkillUnlock( skill, nlvl )
		self:SaveCharacter()
		if nlvl == SGS.maxlevel then
			self:AnnounceCap( skill )
		end
	end

	local cslvl = self.level[ "survival" ]
	local nslvl = 1
	local tlvl =  0
	for k, v in pairs( SGS.skills ) do
		tlvl = tlvl + self.level[ v ]
	end
	nslvl = math.floor( (tlvl - 10) / 20 ) + 1
	nslvl = math.Clamp( nslvl, 1, SGS.maxlevelsurvival )

	if nslvl > cslvl then
		self:SetSurvivalLevel()
		self:SendMessage("Your survival level has gone up!", 60, Color(0, 255, 255, 255))
		self:SendMessage("Max Health has increased!", 60, Color(0, 255, 255, 255))
		self:SendMessage("Max Inventory has increased!", 60, Color(0, 255, 255, 255))
		self:LevelUpSurvivalEffect()
		self:SetSurvivalLevelStats()
		self:SaveCharacter()
		self:CheckForAchievements( "steamgroup" )

		if nslvl == 10 or nslvl == 20 or nslvl == 30 or nslvl == SGS.maxlevelsurvival then
			self:AnnounceMilestone( nslvl )
		end
	end
end


function PlayerMeta:CheckSkillUnlock( skill, lvl )
	print( skill, lvl )
	if SGS.SkillUnlocks[skill] then
		if SGS.SkillUnlocks[skill][lvl] then
			print( SGS.SkillUnlocks[skill][lvl].text )
			net.Start("sgs_skillunlock")
				net.WriteString(skill)
				net.WriteString(tostring(lvl))
				net.WriteString(SGS.SkillUnlocks[skill][lvl].text)
				net.WriteString(SGS.SkillUnlocks[skill][lvl].text2 or "")
			net.Send( self )
		end
	end
end

function PlayerMeta:SetExp( skill, amt )
	if amt < 0 then
		amt = 0
	end
	self.exp[ skill ] = amt

	net.Start("sgs_updateexp")
		net.WriteString( skill )
		net.WriteInt( amt, 32 )
	net.Send( self )

end


util.AddNetworkString("sgs_receiveexpmessage")
function PlayerMeta:SendExpInfo( skill, nexp, amt, xp_string )
	if amt < 0 then
		amt = 0
	end

	net.Start("sgs_receiveexpmessage")
		net.WriteString( skill )
		net.WriteInt( nexp, 32 )
		net.WriteInt( amt, 32 )
		net.WriteString( xp_string )
	net.Send( self )

end

function PlayerMeta:SetExpBase()
	self.exp = {}
	for k, v in pairs( SGS.skills ) do
		self.exp[ v ] = 0
		self:SetExp( v, self.exp[ v ] )
	end
end

function SGS_CheckEXPforLVL( pExp )
	local pLvl = 0
	for i, v in ipairs( SGS.explist ) do
		if pExp >= v then
			pLvl = i
		else
			return pLvl
		end
	end
end


function PlayerMeta:AnnounceCap( skill ) --Individual Skill Cap

	GAMEMODE.colorSay(_, { team.GetColor(self:Team()), self:Nick(), Color(255,255,255), " has achieved max level of ", SGS.colors[skill], skill, Color(255,255,255), "!!" } )
	self:ConCommand("sgs_refreshoptions")

end

function PlayerMeta:AnnounceMilestone( amt ) --Every 10 Survival Levels

	GAMEMODE.colorSay(_, { team.GetColor(self:Team()), self:Nick(), Color(255,255,255), " has achieved survival level ", Color(0,0,0), tostring(amt), Color(255,255,255), "!!" } )

end

function SGS_SetBonusExp( skill, mod )
	SGS.bonusexp[skill] = {}
	SGS.bonusexp[skill].enabled = true
	SGS.bonusexp[skill].mod = mod
end

function SGS_UnSetBonusExp( skill )
	SGS.bonusexp[skill].enabled = false
end


function SGS_ConSetBonusExp( ply, _, args )
	if not SGS_IsRootAdmin( ply ) then return end
	if not #args == 2 then return end
	if not tonumber(args[2]) then return end

	for k, v in pairs( SGS.skills ) do
		if v == string.lower(args[1]) then
			SGS_SetBonusExp( v, tonumber(args[2]) )
			SGS_SendMessage( ply, "Bonus EXP for " .. Cap(v) .. " set to " .. tonumber(args[2]) .. "%." )
			GAMEMODE.colorSay(nil, { Color(255,255,255), "Bonus EXP for skill ", Color(255,0,0), "(", SGS.colors[v], Cap(v), Color(255,0,0), ")", Color(255,255,255), " is now set to ", Color(0,255,0), args[2], "%", Color(255,255,255), "." } )
			return
		end
	end
end
concommand.Add( "sgs_setbonusexp", SGS_ConSetBonusExp)

function SGS_ConUnSetBonusExp( ply, _, args )
	if not SGS_IsRootAdmin( ply ) then return end
	if not #args == 1 then return end

	for k, v in pairs( SGS.skills ) do
		if v == string.lower(args[1]) then
			SGS_UnSetBonusExp( v )
			SGS_SendMessage( ply, "Bonus EXP for " .. Cap(v) .. " reset." )
			GAMEMODE.colorSay(nil, { Color(255,255,255), "Bonus EXP for skill ", Color(255,0,0), "(", SGS.colors[v], Cap(v), Color(255,0,0), ")", Color(255,255,255), " has reset." } )
			return
		end
	end
end
concommand.Add( "sgs_unsetbonusexp", SGS_ConUnSetBonusExp)

function SGS_AnnounceBonusExpOnJoin( ply )
	for k, v in pairs( SGS.skills ) do
		if SGS.bonusexp[v] then
			if SGS.bonusexp[v].enabled then
				GAMEMODE.colorSay(ply, { Color(255,255,255), "Bonus EXP for skill ", Color(255,0,0), "(", SGS.colors[v], Cap(v), Color(255,0,0), ")", Color(255,255,255), " is currently set to ", Color(0,255,0), tostring(SGS.bonusexp[v].mod), "%", Color(255,255,255), "." } )
			end
		end
	end
end
hook.Add( "PlayerInitialSpawn", "SGS_AnnounceBonusExpOnJoin", SGS_AnnounceBonusExpOnJoin )

function SGS_RandomSkill( ply, _, args )
	if not SGS_IsRootAdmin( ply ) then return end

	percent = tonumber(args[1]) or 25
	skill = SGS.skills[ math.random(#SGS.skills) ]

	SGS_SetBonusExp( skill, percent )
	SGS_SendMessage( ply, "Bonus EXP for " .. Cap(skill) .. " set to " .. percent .. "%." )
	GAMEMODE.colorSay(nil, { Color(255,255,255), "Bonus EXP for skill ", Color(255,0,0), "(", SGS.colors[skill], Cap(skill), Color(255,0,0), ")", Color(255,255,255), " is now set to ", Color(0,255,0), tostring(percent), "%", Color(255,255,255), "." } )

end
concommand.Add( "sgs_randombonus", SGS_RandomSkill )

function SGS_SetAllSkillsBonus( ply, _, args )
	if not SGS_IsRootAdmin( ply ) then return end

	percent = tonumber(args[1]) or 25

	for k, v in pairs( SGS.skills ) do
		SGS_SetBonusExp( v, percent )
		SGS_SendMessage( ply, "Bonus EXP for " .. Cap(v) .. " set to " .. percent .. "%." )
		GAMEMODE.colorSay(nil, { Color(255,255,255), "Bonus EXP for skill ", Color(255,0,0), "(", SGS.colors[v], Cap(v), Color(255,0,0), ")", Color(255,255,255), " is now set to ", Color(0,255,0), tostring(percent), "%", Color(255,255,255), "." } )
	end

end
concommand.Add( "sgs_allbonus", SGS_SetAllSkillsBonus )

function SGS_ConUnSetBonusExpAll( ply, _, args )
	if not SGS_IsRootAdmin( ply ) then return end

	for k, v in pairs( SGS.skills ) do
		if SGS.bonusexp[v] then
			SGS_UnSetBonusExp( v )
			SGS_SendMessage( ply, "Bonus EXP for " .. Cap(v) .. " reset." )
			GAMEMODE.colorSay(nil, { Color(255,255,255), "Bonus EXP for skill ", Color(255,0,0), "(", SGS.colors[v], Cap(v), Color(255,0,0), ")", Color(255,255,255), " has reset." } )
		end
	end
end
concommand.Add( "sgs_unsetbonusexpall", SGS_ConUnSetBonusExpAll)