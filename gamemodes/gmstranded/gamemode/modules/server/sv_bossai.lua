local PlayerMeta = FindMetaTable("Player")

hook.Add( "DayLightChangeTime", "DayChangeBossCheck", function( time )
	if not SGS.bossspawnedtoday then SGS.bossspawnedtoday = false end
	if (DayLight.Day ~= 5) and SGS.bossspawnedtoday then SGS.bossspawnedtoday = false end
	if SGS.bossspawnedtoday then return end
	if not (DayLight.Day == 5) then return end

	if math.random(1,300) == 150 then
		SGS_SpawnRandomBoss()
		SGS.bossspawnedtoday = true
	end
end)

function SGS_SpawnRandomBoss()
	if math.random(5) <= 3 then
		SGS_SpawnAntlionBoss()
	else
		SGS_SpawnHunterBoss()
	end
end

function SGS_SpawnAntlionBoss()
	SGS_MakeCreature( "npc_antlionguard", GAMEMODE.Worlds.tblWorlds[2].BossSpawnPos + Vector(200,0,0), nil )
	for k, v in pairs(player.GetAll()) do
		v:SendMessage("The Antlion Boss emerges in the Arena!", 60, Color(255, 255, 0, 255))
	end
end

function SGS_SpawnHunterBoss()
	SGS_MakeCreature( "npc_hunter", GAMEMODE.Worlds.tblWorlds[2].BossSpawnPos + Vector(200,0,0), nil )
	for k, v in pairs(player.GetAll()) do
		v:SendMessage("The Hunter Boss has arrived in the Arena!", 60, Color(255, 255, 0, 255))
	end
end

function SGS_BossSlam()
	for k, v in pairs( ents.FindByClass( "npc_antlionguard" ) ) do
		if v.ispet then continue end
		if v:GetNPCState() == 2 or v:GetNPCState() == 3 then
			if math.random(1,50) == 5 then
				SGS_BossSmokeRing( v )
			end
		end
	end
end
timer.Create( "SGS_BossSlamTimer", 1, 0, function() SGS_BossSlam() end )

function SGS_BossSpawnHealers( boss )
	if math.random(3) >= 2 then
		newpos = boss:GetPos() + Vector(0, 600, 500)
		local trace = {}
		trace.start = newpos
		trace.endpos = trace.start + Vector(0,0,-1200)
		trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
		local tr = util.TraceLine(trace)
		if tr.Hit then
			SGS_SpawnHealer( boss, tr.HitPos + Vector(0,0,10) )
		end
	end
	
	if math.random(3) >= 2 then
		newpos2 = boss:GetPos() + Vector(600, 0, 300)
		local trace = {}
		trace.start = newpos2
		trace.endpos = trace.start + Vector(0,0,-600)
		trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
		local tr = util.TraceLine(trace)
		if tr.Hit then
			SGS_SpawnHealer( boss, tr.HitPos + Vector(0,0,10) )
		end
	end
		
	if math.random(3) >= 2 then
		newpos3 = boss:GetPos() + Vector(-600, 0, 300)
		local trace = {}
		trace.start = newpos3
		trace.endpos = trace.start + Vector(0,0,-600)
		trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
		local tr = util.TraceLine(trace)
		if tr.Hit then
			SGS_SpawnHealer( boss, tr.HitPos + Vector(0,0,10) )
		end
	end
		
	if math.random(3) >= 2 then
		newpos4 = boss:GetPos() + Vector(0, -600, 300)
		local trace = {}
		trace.start = newpos4
		trace.endpos = trace.start + Vector(0,0,-600)
		trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
		local tr = util.TraceLine(trace)
		if tr.Hit then
			SGS_SpawnHealer( boss, tr.HitPos + Vector(0,0,10) )
		end
	end
end

function SGS_SpawnHealer( boss, pos )
	if not IsValid(boss) then return end
	
	local healer = ents.Create( "npc_antlion" )
	healer:SetKeyValue("spawnflags", "262144")
	healer.special = "worker"
	healer:SetPos( pos )
	healer:SetKeyValue( "startburrowed", 1 )
	healer:SetNWBool("isburrowed", true)
	local healer_u = healer
	healer:Spawn()
	timer.Simple( math.random(10) / 10, function() SGS_Unburrow( healer_u ) SGS_NPCShield( healer_u ) end )
	local aimAngle = ((boss:GetPos() + boss:GetAngles():Forward()) - healer:GetPos()):Angle()
	aimAngle.p = 0
	aimAngle.r = 0
	healer:SetAngles( aimAngle )
			
	healer:AddRelationship("npc_antlion D_LI 99")
	healer:AddRelationship("npc_hunter D_LI 99")
	healer:AddRelationship("player D_LI 999")
	
	healer:AddEntityRelationship(boss, D_HT, 999 )
	
	healer:SetNetworkedString("Owner", "World")
	local npctable = SGS_ReverseNPCLookup("npc_antlion_w")
	healer.ispet = false
		
	local level = 0
	local hp = npctable.hp
	local dmg = npctable.damage
	if npctable.scale == true then
		level = 1
		if math.random(1,3) <=2 then
			level = 1
		else
			level = math.random(2,5)
		end
		hp = npctable.hp + (( level - 1) * 50)
		dmg = npctable.damage + (( level - 1) * 5)
	end
	
	healer:SetNWInt("level", level)
	healer.level = level
	healer.healer = true

	healer:SetMaxHealth(hp)
	healer:SetHealth(hp)
	
	healer:SetNWInt("maxhp", hp)
	
	healer:SetNWString("name", "Antlion Healer")
	
	healer.dmg = dmg
	healer.htype = "friendly"
	
	healer.spawned = CurTime()
	
	timer.Simple(1800, function() SGS_RemoveNPC( healer ) end )
end

function SGS_BossShieldTimer()
	for k, v in pairs( ents.FindByClass( "npc_antlionguard" ) ) do
		if v.ispet then continue end
		if v:GetNWBool("shielded") then continue end
		if v:GetNPCState() == 2 or v:GetNPCState() == 3 then
			if math.random(1,30) == 1 then
				SGS_NPCShield( v, math.random(10,15) )
			end
		end
	end
end
timer.Create( "SGS_BossShieldTimer", 1, 0, function() SGS_BossShieldTimer() end )

function SGS_NPCShield( npc, time )
	if not IsValid( npc ) then return end
	time = tonumber(time)
	npc:SetNWBool( "shielded", true )
	npc.shieldsound = CreateSound( npc, "npc/scanner/combat_scan_loop6.wav" )
	
	npc.shieldsound:Play()
	npc.shieldsound:ChangeVolume(0,0)
	npc.shieldsound:ChangeVolume(1,2)
	if time then timer.Simple( time, function() SGS_Unshield( npc ) end ) end
end

hook.Add( "EntityRemoved", "Stop Shield", function( ent )
	if ent.shieldsound then ent.shieldsound:Stop() end
end )

function SGS_Unshield( npc )
	if not IsValid( npc ) then return end
	npc.shieldsound:FadeOut( 1 )
	npc:SetNWBool( "shielded", false )
end

function SGS_BossSlamMega( loc, ply )
	if not IsValid(ply) then return end
	local ED = EffectData()
	ED:SetOrigin( loc + Vector(0,0,30) )
	util.Effect( 'particle_bosssmokering', ED )
	
	util.ScreenShake( loc, 10, 10, 0.3, 750 )
	for k, v in pairs( player.GetAll() ) do
		if v:GetPos():DistToSqr( loc ) < 90000 then
			v:SetVelocity(( v:GetPos() - loc):GetNormal() * 1100 + Vector(0,0,1200) )
		end
	end
	
	for k, v in pairs( ents.FindInSphere(loc, 1000) ) do
		if (v:GetClass() == "npc_antlion") and (not v.ispet) then
			v:TakeDamage( 1000, ply, ply )
		end
	end
end

function SGS_BossSmokeRing( npc )
	if not IsValid( npc ) then return end
	if npc.thumps == nil then npc.thumps = 0 end
	npc.thumps = npc.thumps + 1
	
	local ED = EffectData()
	ED:SetOrigin( npc:GetPos() + npc:GetUp()* 10 )
	util.Effect( 'particle_bosssmokering', ED )
	
	util.ScreenShake( npc:GetPos(), 10, 10, 0.3, 750 )
	
	npc:EmitSound( 'npc/antlion_guard/shove1.wav', 500, 100 )
	
	if npc.thumps < 3 then
		timer.Simple( 0.4, function() SGS_BossSmokeRing(npc) end )
		return
	end
	
	if npc.thumps >= 3 then
		npc.thumps = 0
		for k, v in pairs( player.GetAll() ) do
			if v:GetPos():DistToSqr( npc:GetPos() ) < 40000 then
				v:SetVelocity(( v:GetPos() - npc:GetPos()):GetNormal() * 500 + Vector(0,0,425) )
			end
		end
	end
	
end

function SGS_BossLevitatePlayer( npc )
	for k, v in pairs( ents.FindInSphere( npc:GetPos(), 500 ) ) do
		if v:IsPlayer() then
			v:SetVelocity( Vector( 0, 0, 400 ) )
			timer.Simple( 0.6, function() 
				v:SetMoveType( MOVETYPE_NONE ) 
				v.levitate = true
				v:SetNWBool("levitated", true)
				timer.Simple( 5, function() SGS_BossUnLevitatePlayer( v ) end )
			end )
		end
	end
end

function SGS_BossUnLevitatePlayer( ply )
	if not IsValid( ply ) then return end
	ply.levitate = false
	ply:SetNWBool("levitated", false)
	ply:SetMoveType( MOVETYPE_WALK ) 
end

function SGS_TeleportBoss( npc, radius )
	local curpos = npc:GetPos()
	local newpos = curpos + Vector(math.random(-radius,radius), math.random(-radius,radius), 800)
	local trace = {}
	trace.start = newpos
	trace.endpos = trace.start + Vector(0,0,-1000)
	trace.mask = bit.bor(MASK_SOLID)
	trace.filter = npc
	
	local tr = util.TraceLine(trace)
	if tr.Hit then
		local newpos = tr.HitPos
		
		local ED = EffectData()
		ED:SetOrigin( npc:GetPos() )
		ED:SetStart(Vector(255,255,0))
		local effect = util.Effect( 'boss_teleport', ED, true, true )
		
		npc:EmitSound( "ambient/voices/squeal1.wav", 125, math.random( 75,150 ), 1, CHAN_AUTO )
		npc:SetPos( newpos + Vector(0,0,20) )
	end
end

function SGS_TeleportBossArena( npc )
	if npc:GetNWBool("enraged", false) then return end
	local newpos = Vector(math.random(-1850, 1850), math.random(-1850, 1850), 4300)
		
	local ED = EffectData()
	ED:SetOrigin( npc:GetPos() )
	ED:SetStart(Vector(255,255,0))
	local effect = util.Effect( 'boss_teleport', ED, true, true )
	
	local trace = {}
	trace.start = newpos
	trace.endpos = trace.start + Vector(0,0,-2000)
	trace.mask = bit.bor(MASK_SOLID)
	trace.filter = npc
	
	local tr = util.TraceLine(trace)
	if tr.Hit then
		local newpos = tr.HitPos
		
		local ED = EffectData()
		ED:SetOrigin( npc:GetPos() )
		ED:SetStart(Vector(255,255,0))
		local effect = util.Effect( 'boss_teleport', ED, true, true )
		
		npc:EmitSound( "ambient/voices/squeal1.wav", 125, math.random( 75,150 ), 1, CHAN_AUTO )
		npc:SetPos( newpos + Vector(0,0,20) )
	end
end

function SGS_SpawnManhacks( npc )
	npc:EmitSound( "npc/ministrider/ministrider_preflechette.wav", 130, math.random( 90,110 ), 1, CHAN_AUTO )
	
	local mhnum = math.random( 3, 7 )
	
	for i = 1, mhnum do
		local newpos = npc:GetPos() + Vector(math.random(-200,200), math.random(-200,200), 100)
		SGS_MakeCreature( "npc_manhack", newpos, nil, npc )
	end
end

hook.Add("Think", "RemoveManhackGarbage", function()
	if not SGS.nextgarbagecleanup then SGS.nextgarbagecleanup = CurTime() end
	if CurTime() < SGS.nextgarbagecleanup then return end
	SGS.nextgarbagecleanup = CurTime() + 3
	for k, v in pairs( ents.FindByClass("prop_physics") ) do
		if string.find( v:GetModel(), "gib" ) then v:Remove() end
	end
end )

function SGS_BossTeleportTimer()
	for k, v in pairs( ents.FindByClass( "npc_hunter" ) ) do
		if v.ispet then continue end
		if v:GetNWBool("enraged", false) then continue end
		if v:GetNPCState() == 3 then
			if math.random(1,4) == 3 then
				SGS_TeleportBossArena( v )
			end
		end
	end
end
timer.Create( "SGS_BossTeleportTimer", 2, 0, function() SGS_BossTeleportTimer() end )

function SGS_SpawnMeteorShower( npc )
	for i=1, 15 do
		local meteor = ents.Create( "gms_meteor" )
		meteor:SetPos( npc:GetPos() )
		meteor.falltime = 0.5 + i*0.1
		meteor.owner = npc
		meteor:Spawn()
	end
end

function SGS_SpawnMinions( npc )
	for i = 1, math.random(3,6) do
		SGS_SpawnMinion( npc )
	end
end

function SGS_SpawnMinion( npc )
	if not IsValid( npc ) then return end
	cpos = npc:GetPos()
	npos = cpos + Vector(math.random(-300,300), math.random(-300,300), 500)
	
	local trace = {}
	trace.start = npos
	trace.endpos = trace.start + Vector(0,0,-1200)
	trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
	trace.filter = self
	
	local tr = util.TraceLine(trace)
	if tr.Hit then
		if not (tr.MatType == MAT_SLOSH) then
			if tr.HitWorld then
				npos = tr.HitPos + Vector(0,0,10)
				if math.random(3) == 1 then
					SGS_MakeCreature( "npc_antlion_w", npos, npc.ptable )
				else
					SGS_MakeCreature( "npc_antlion", npos, npc.ptable )
				end
			end
		end
	end

end

function SGS_NPCBossDamage( ent, dmginfo )
 	local infl = dmginfo:GetInflictor()
	local att = dmginfo:GetAttacker()
	local amount = dmginfo:GetDamage()
	
	if not IsValid( infl ) then return end
	if not infl:IsPlayer() then return end
	if ent.ispet then return end
	
			
	if ent:GetClass() == "npc_antlionguard" then
		if math.random(1,10) == 1 then
			SGS_BossSmokeRing( ent )
		end
		if math.random(1,30) == 1 then
			SGS_NPCShield( ent, math.random(10,15) )
		end
		if math.random(25) == 1 then
			ent:EmitSound("npc/zombie/zombie_pain5.wav", 250, 50)
			SGS_SpawnMeteorShower( ent )
		end
		if math.random(35) == 1 then
			SGS_SpawnMinions( ent )
		end
		if math.random(40) == 1 then
			SGS_BossSpawnHealers( ent )
		end
	elseif ent:GetClass() == "npc_hunter" then
		if math.random( 1, 15 ) == 5 then
			SGS_TeleportBossArena( ent )
		end
		if math.random( 1, 15 ) == 1 then
			SGS_BossLevitatePlayer( ent )
		end
		if math.random( 1, 18 ) == 1 then
			SGS_SpawnManhacks( ent )
		end
		
		if ( ent:Health() < (ent:GetMaxHealth() / 2 ) ) and ( not ent:GetNWBool("enraged", false) ) then
			HunterPhase2( ent )
		end
	end
end
hook.Add("EntityTakeDamage", "SGS_NPCBossDamage", SGS_NPCBossDamage)

function SGS_BossDamageHandling( ent, dmginfo )
 	local infl = dmginfo:GetInflictor()
	local att = dmginfo:GetAttacker()
	local amount = dmginfo:GetDamage()
	
	if ent:IsPlayer() then
		if ent == infl then return end
		if infl:GetClass() == "hunter_flechette" then
			if math.random( 7 ) == 1 then
				SGS_Bleed( ent, math.random(20,30) )
			end
		end
		if infl:GetClass() == "npc_manhack" then
			if math.random( 2 ) == 1 then
				SGS_Bleed( ent, math.random(15,30) )
			end
		end
	end
 
end
hook.Add("EntityTakeDamage", "SGS_BossDamageHandling", SGS_BossDamageHandling)

function BossKillPlayer( ply, wep, killer )
	if not killer:IsNPC() then return end
	
	if killer:GetClass() == "npc_hunter" then
		killer:EmitSound("npc/ministrider/hunter_laugh" .. math.random(3,5) .. ".wav", 125)
		SGS_BossHeal( killer, killer:GetMaxHealth() / 10 )
	end
	
	if killer:GetClass() == "npc_manhack" then
		if IsValid(killer.parent) then
			killer.parent:EmitSound("npc/ministrider/hunter_laugh" .. math.random(3,5) .. ".wav", 125)
			SGS_BossHeal( killer.parent, killer.parent:GetMaxHealth() / 10 )
		end
	end
	
	
end
hook.Add( "PlayerDeath", "BossKillPlayer", BossKillPlayer )

function HunterPhase2( npc )
	npc:EmitSound("npc/ministrider/hunter_scan" .. math.random(2) .. ".wav", 125)
	npc:SetPos( Vector(3.626172, -84.403702, 3728.257813) )
	npc:SetNWBool("enraged", true)
	hook.Add("Think", npc, LevitateBurn)
end

function LevitateBurn( ent )
	if ( ent.nextthink or 0 ) > CurTime() then return end
		for k, v in pairs( player.GetAll() ) do
			if not v:Alive() then continue end
			if v:GetNWBool("levitated", false) then
				v:LaserBurn( 1, ent )
			end
		end
	ent.nextthink = CurTime() + 0.2
end