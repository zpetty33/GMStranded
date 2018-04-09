hook.Add( "SGSPlayerChangedWorld", "GravityChange", function( ply, world )
	if world.Gravity then
		ply:SetGravity( world.Gravity )
	end
	
	if world.Secret then
		if not ply:GetAch("secretworld") then
			ply:SetAch("secretworld")
		end
	end
end )

function GM.Worlds:StartBloodMoon()
	GAMEMODE.Worlds.BloodMoon = true
	for _, v in pairs( player.GetAll() ) do
		v:SendMessage( "The Blood Moon is rising!", 60, Color(255, 0, 0, 255))
		v.in_start_bloodmoon = true
	end
	self:NetworkBloodmoon()
end

function GM.Worlds:StopBloodMoon()
	GAMEMODE.Worlds.BloodMoon = false
	for _, v in pairs( player.GetAll() ) do
		v:SendMessage( "The Blood Moon has ended.", 60, Color(255, 0, 0, 255))
		self:CalculateSurvivors( v )
	end
	self:NetworkBloodmoon()
end

function GM.Worlds:CalculateSurvivors( ply )
	if ply.in_start_bloodmoon then
		ply:AddStat( "bloodmoon1", 1 )
		ply:CheckForAchievements("bloodchampion")
		ply.in_start_bloodmoon = nil
	end
end

hook.Add( "DayLightChangeTime", "BloodMoonCheck", function( min )
	if  min == 1280 then
		if not GAMEMODE.Worlds.lastbloodmoon then GAMEMODE.Worlds.lastbloodmoon = 0 end
		if GAMEMODE.Worlds.lastbloodmoon > 0 then
			GAMEMODE.Worlds.lastbloodmoon = GAMEMODE.Worlds.lastbloodmoon - 1
		end
	end

	if min == 1280 and math.random(5) == 1 and GAMEMODE.Worlds.lastbloodmoon == 0 then
		GAMEMODE.Worlds:StartBloodMoon()
		GAMEMODE.Worlds.lastbloodmoon = 4
	end
	
	if min == 300 and GAMEMODE.Worlds.BloodMoon then
		GAMEMODE.Worlds:StopBloodMoon()
	end
end )

function GM.Worlds:NetworkBloodmoon( ply )
	net.Start("sgs_updatebloodmoon")
	net.WriteBool( self.BloodMoon )
	if IsValid(ply) then
		net.Send( ply )
	else
		net.Broadcast()
	end
end

function GM.Worlds:CountEntitiesOnWorld( w_id, ent_class )
	local count = 0
	for k, v in pairs( ents.FindByClass( ent_class ) ) do
		if self:GetEntityWorldSpaceID( v ) == w_id then
			count = count + 1
		end
	end
	return count
end

hook.Add("PlayerInitialSpawn", "NetworkBloodmoonOnJoin", function( ply )
	timer.Simple( 5, function()
		if IsValid(ply) then GAMEMODE.Worlds:NetworkBloodmoon( ply ) end
	end )
end )