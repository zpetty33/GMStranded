local PlayerMeta = FindMetaTable("Player")

function SGS_MakeCreature( npcclass, loc, aggrotable, parent )
	if SGS_ReverseNPCLookup(npcclass) then
		local npc
		local npctable = SGS_ReverseNPCLookup(npcclass)
		if npctable.class == "npc_antlion_w" then
			npc = ents.Create(npctable.class2)
			npc.special = "worker"
		else
			npc = ents.Create(npctable.class)
		end
		
		if npctable.flags then
			npc:SetKeyValue("spawnflags", npctable.flags)
		end
		npc:SetPos( loc )
		
		if npcclass == "npc_antlion" or npcclass == "npc_antlion_w" or npcclass == "npc_antlionguard" then
			npc:SetKeyValue( "startburrowed", 1 )
			npc:SetNWBool("isburrowed", true)
			local npc_u = npc
			timer.Simple( 3, function()	SGS_Unburrow( npc_u ) end )
		end
		
		npc:Spawn()
		npc:SetModelScale( npctable.size, 0)
		
		npc.ptable = {}
		if npctable.htype == "hostile" then
			npc:AddRelationship("player D_HT 999")
		else
			npc:AddRelationship("player D_NU 999")
		end
		
		npc:AddRelationship("npc_alyx D_LI 99")
		npc:AddRelationship("npc_antlion D_LI 99")
		npc:AddRelationship("npc_antlionguard D_LI 99")
		npc:AddRelationship("npc_barney D_LI 99")
		npc:AddRelationship("npc_breen D_LI 99")
		npc:AddRelationship("npc_citizen D_LI 99")
		npc:AddRelationship("npc_combine_s D_LI 99")
		npc:AddRelationship("npc_crow D_LI 99")
		npc:AddRelationship("npc_dog D_LI 99")
		npc:AddRelationship("npc_eli D_LI 99")
		npc:AddRelationship("npc_fastzombie D_LI 99")
		npc:AddRelationship("npc_fastzombie_torso D_LI 99")
		npc:AddRelationship("npc_gman D_LI 99")
		npc:AddRelationship("npc_headcrab D_LI 99")
		npc:AddRelationship("npc_headcrab_black D_LI 99")
		npc:AddRelationship("npc_headcrab_fast D_LI 99")
		npc:AddRelationship("npc_kleiner D_LI 99")
		npc:AddRelationship("npc_metropolice D_LI 99")
		npc:AddRelationship("npc_monk D_LI 99")
		npc:AddRelationship("npc_mossman D_LI 99")
		npc:AddRelationship("npc_pigeon D_LI 99")
		npc:AddRelationship("npc_poisonzombie D_LI 99")
		npc:AddRelationship("npc_strider D_LI 99")
		npc:AddRelationship("npc_stalker D_LI 99")
		npc:AddRelationship("npc_vortigaunt D_LI 99")
		npc:AddRelationship("npc_zombie D_LI 99")
		npc:AddRelationship("npc_zombie_torso D_LI 99")
		npc:AddRelationship("npc_seagull D_LI 99")
		npc:AddRelationship("npc_hunter D_LI 99")
		
		npc:SetNetworkedString("Owner", "World")
		
		if GAMEMODE.Worlds:GetVectorWorldSpace( loc ).Name == "Arena" then
			npc:AddRelationship("player D_HT 999")
			npc.arenanpc = true
			npc:SetCustomCollisionCheck(true)
		end
		
		npc.ispet = false
		
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
		
		if npctable.name == "Manhack" then level = 1 end
		
		npc:SetNWInt("level", level)
		npc.level = level

		npc:SetMaxHealth(hp)
		npc:SetHealth(hp)
		
		npc:SetNWInt("maxhp", hp)
		
		npc:SetNWString("name", npctable.name)
		
		npc.dmg = dmg
		npc.htype = npctable.htype
		
		npc.spawned = CurTime()
		
		if parent then
			npc.parent = parent
		end
		
		timer.Simple(1800, function() SGS_RemoveNPC( npc ) end )
		
		if aggrotable then
			for k, v in pairs( aggrotable ) do
				if not IsValid(k) then continue end
				if k:IsPlayer() and k:Alive() then
					SGS_SetHostile( npc, k )
				end
			end
		end
		
		if npcclass == "npc_zombie" then
			for k, v in pairs( player.GetAll() ) do
				if v:GetLevel("survival") < 5 then
					SGS_SetNeutral( npc, v )
				end
			end
			
			if GAMEMODE.Worlds.BloodMoon then
				npc:SetMaxHealth(hp * 3)
				npc:SetHealth(hp * 3)
				npc:SetNWInt("maxhp", hp * 3)
				npc:SetNWString("name", "Blood " .. npctable.name)
				npc.dmg = dmg * 3
				npc.bloodmoon_spawned = true
			end
			hook.Add("Think", npc, ZombieThink)
		end

	end
end

function ZombieThink( ent )
	if ( ent.nextthink or 0 ) > CurTime() then return end
	local enemy = ent:GetEnemy()
	if IsValid(enemy) then
		if ent:IsUnreachable(enemy) then
			SGS_SetNeutral( ent, enemy )
			timer.Simple( 3, function() SGS_ForceHostile( ent, enemy ) end )
			ent:MarkEnemyAsEluded()
		end
	end
	
	ent.nextthink = CurTime() + 2
end

function SGS_NPC_Collision( ent1, ent2 )
	if ent1.arenanpc and ent2.arenanpc then 
		return false 
	end
end
hook.Add("ShouldCollide", "CustomNPCCollision", SGS_NPC_Collision)

function SGS_Unburrow( npc )
	if IsValid(npc) then
		npc:Fire("Unburrow")
		npc:SetNWBool("isburrowed", false)
	end
end

function SGS_SetZombiesNeutral( ply )

	if not IsValid( ply ) then return end

	for k, v in pairs( ents.FindByClass("npc_zombie") ) do
		if IsValid(v) and v:IsNPC() and (not v.ispet) then
			SGS_SetNeutral( v, ply )
		end
	end

end

function SGS_StriderKill()

	for _, npc in pairs( ents.FindByClass("npc_strider") ) do
		for k, v in pairs(player.GetAll()) do 
			if npc:Disposition( v ) == D_HT then
				if npc:GetPos():DistToSqr(v:GetPos()) >= 1000000 then
					if math.random(1,3) == 1 then
						v:SetName("stridertarget")
						timer.Simple(1, function() npc:Fire("setcannontarget", "stridertarget") end )
						timer.Simple(2, function() v:SetName("notarget") end )
					end
				end
			end
		end
	end

end
timer.Create("SGS_StriderKill", 10, 0, SGS_StriderKill)

function SGS_RemoveNPC( npc )
	if not IsValid(npc) then return end
	if npc.spawned == nil then
		npc.spawned = CurTime()
	end
	if ( CurTime() - 5 ) < npc.spawned then
		timer.Simple(1800, function() SGS_RemoveNPC( npc ) end )
		return
	end
	npc:Remove()
end

function SGS_SetAllCreaturesHostile()
	for k, v in pairs(ents.FindByClass("npc_*")) do
		v:AddRelationship("player D_HT 999")
	end
end

function SGS_SetAllCreaturesPassive()
	for k, v in pairs(ents.FindByClass("npc_*")) do
		v:AddRelationship("player D_NU 999")
	end
end

function SGS_ChangeALRelationship()

	if SGS_DayPhase() == SGS.lastphase then return end

	if SGS_DayPhase() == "day" or SGS_DayPhase() == "dawn" then
		if SGS.lastphase == "night" or SGS.lastphase == "dusk" then
			SGS.lastphase = "day"
			for k, v in pairs(ents.FindByClass("npc_antlion")) do
				v:AddRelationship("player D_NU 999")
			end
		end
	end
			
	if SGS_DayPhase() == "night" or SGS_DayPhase() == "dusk" then
		if SGS.lastphase == "day" or SGS_DayPhase() == "dawn" then
			SGS.lastphase = "night"
			for k, v in pairs(ents.FindByClass("npc_antlion")) do
				v:AddRelationship("player D_HT 999")
			end
		end
	end	

end


function SGS_ReverseNPCLookup( tEnt )

	for k, v in pairs( SGS.NPCs ) do
		if v.class == tEnt then
			return v
		end
	end
	
	return nil

end

function SGS_NPCDamage( ent, dmginfo )
 	local infl = dmginfo:GetInflictor()
	local att = dmginfo:GetAttacker()
	local amount = dmginfo:GetDamage()
	
	if not IsValid( infl ) then return end
	
	if ent:IsNPC() or ent:IsNextBot() then
		
		if infl:GetClass() == "player" then
			if ent.ispet then return end
			if ent.htype == nil then ent.htype = "neutral" end
			if ent.htype == "neutral" then
				for k, v in pairs(ents.FindInSphere(ent:GetPos(), 500)) do
					if v:GetClass() == ent:GetClass() then
						if not v.ispet and not v.healer then
							SGS_SetHostile( v, infl )
							if v.ptable == nil then
								v.ptable = {}
							end
							v.ptable[infl] = infl
						end
						continue
					end
					if ent:GetClass() == "npc_antlionguard" and v:GetClass() == "npc_antlion" then
						if not v.ispet and not v.healer then
							SGS_SetHostile( v, infl )
							if v.ptable == nil then
								v.ptable = {}
							end
							v.ptable[infl] = infl
						end
						continue
					end
				end
				SGS_SetHostile( ent, infl )
			end
			
			if ent:GetNWBool("enraged", false) then
				dmginfo:ScaleDamage(0.5)
			end
			
			if ent.ptable == nil then
				ent.ptable = {}
			end
			
			ent.ptable[infl] = infl
			
			if ent:GetClass() == "npc_zombie" then
				if ent.ispet then return end
				ent:AddEntityRelationship(infl, D_HT, 999 )
			end
			
		elseif infl:GetClass() == "grenade_spit" then
			if not ent:GetClass() == "npc_antlionguard" then return end
			dmginfo:ScaleDamage(0)
			SGS_BossHeal( ent, math.random(5,25) )
		else
			if infl:GetClass() == "npc_strider" then
				if ent.ispet then return end
				dmginfo:ScaleDamage(4)
			elseif infl:GetClass() == "entityflame" then
				dmginfo:ScaleDamage(1)
			else
				dmginfo:ScaleDamage(0)
				return
			end
		end
	end
end
hook.Add("EntityTakeDamage", "SGS_NPCDamage", SGS_NPCDamage)

function SGS_BossHeal( boss, amt )

	if boss:Health() + amt <= boss:GetMaxHealth() then
		boss:SetHealth(boss:Health() + amt)
	else
		boss:SetHealth(boss:GetMaxHealth())
	end

end

function SGS_SetHostile( npc, ply )
	if not IsValid( npc ) then return end
	if not IsValid( ply ) then return end

	if SGS_ReverseNPCLookup(npc:GetClass()) then
		local npctable = SGS_ReverseNPCLookup(npc:GetClass())
		if npctable.htype == "neutral" then
			npc:AddEntityRelationship(ply, D_HT, 999 )
			if npc:IsNextBot() then
				npc:Aggro( ply )
			end
			timer.Create( "resethostile_" .. npc:EntIndex(), 20, 1, function() SGS_SetNeutral( npc, ply ) end)
		end
	end

end

function SGS_ForceHostile( npc, ply )
	if not IsValid( npc ) then return end
	if not IsValid( ply ) then return end

	npc:AddEntityRelationship(ply, D_HT, 999 )
end

function SGS_SetNeutral( npc, ply )

	if !IsValid(npc) then return end
	if !IsValid(ply) then return end

	npc:AddEntityRelationship(ply, D_NU, 999 )
	if npc:IsNextBot() then
		npc:DeAggro()
	end
	
end
 
function SGS_NPCKilled( npc, ply, wep )

	if not ply:IsPlayer() then return end
	
	if SGS_ReverseNPCLookup(npc:GetClass()) then
		local npctable = SGS_ReverseNPCLookup(npc:GetClass())
		
		if npc.special == "worker" then
			npctable = SGS_ReverseNPCLookup("npc_antlion_w")
		end
		local exp = 0
		if npctable.scale then
			exp = npctable.exp + ( (npctable.exp/2) * (npc.level-1) )
		else
			exp = npctable.exp
		end
		local ptable = {}
		if npc.ptable then
			ptable = npc.ptable
		else
			ptable = { ply }
		end
		
		if npc.bloodmoon_spawned then
			exp = exp * 1.25  --YOU'RE WELCOME WHINEY BITCHES!!!
		end
		
		for k, v in pairs( ptable ) do
			if not IsValid(v) then continue end
			if not v:IsPlayer() then continue end
			if not v:IsConnected() then continue end
			if not GAMEMODE.Worlds:GetEntityWorldSpace( npc ) == GAMEMODE.Worlds:GetEntityWorldSpace( v ) then continue end
			v:AddExp( "combat", exp )
			if npc:GetClass() == "npc_antlion" then v:AddStat( "combat1", 1 ) end
			if npc:GetClass() == "npc_antlionguard" then v:AddStat( "combat3", 1 ) end
			if npc:GetClass() == "npc_zombie" then v:AddStat( "combat8", 1 ) v:CheckForAchievements( "zombieslayer" ) end

			chance = 250
			if v.luck then
				local luck = 100
				luck = luck * v.luck
				chance = chance - luck
			end
			
			if npc.bloodmoon_spawned then
				v:AddStat( "bloodmoon2", 1 )
			end
			
			if npc:GetClass() == "npc_antlion" then
				if math.random(1, chance) == 1 then
					v:FoundRedEgg()
				end
				if math.random(250) == 1 then
					v:SendMessage( "The Antlion's head was found in pristine condition.", 60, Color(0, 255, 0, 255))
					v:AddResource( "gms_antlionheadtrophy", 1 )
				end
			end
			
			if npc:GetClass() == "npc_zombie" then
				local chance = 10
				if npc.bloodmoon_spawned then chance = 7 end
				if math.random(chance) == 1 then
					v:SendMessage( "You managed to snag a usable strip of cloth.", 60, Color(0, 255, 0, 255))
					v:AddResource( "cloth", 1 )
				end
			end
			
			if npc:GetClass() == "npc_antlionguard" then
				local pos = npc:GetPos()

				local ED = EffectData()
				ED:SetOrigin( pos )
				local effect = util.Effect( 'boss_die', ED, true, true )
				timer.Simple(3, function() SGS_BossSlamMega( pos, ply ) end )
			end
		end
		
		SGS_NPCLoot( npctable.loottype, npc, ply )
		
		if npc:GetClass() == "npc_strider" then
			npc:Fire("break", nil, 0)
			local data = EffectData()
			local radstep = (2*math.pi)/6
			local normvec = Vector()
			for i=0,5 do
				data:SetOrigin(npc:GetPos()+VectorRand()*32)
				normvec.x = math.cos(radstep*i)
				normvec.y = math.sin(radstep*i)
				normvec.z = 0
				data:SetNormal(normvec)
				if (math.random(0,5) == 0) then
					data:SetScale(1)
				else
					data:SetScale(2)
				end
				util.Effect("StriderBlood",data)
			end
			util.ScreenShake(npc:GetPos(),20,150,1,1250)
			data:SetOrigin(npc:GetPos())
			util.Effect("cball_explode",data)
			npc:EmitSound("Weapon_StriderBuster.Detonate")
			util.ScreenShake(npc:GetPos(),700,1,1,800)
			
			timer.Simple(5, function()
				for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
					v:Remove()
				end
				for k, v in pairs(ents.FindByClass("prop_physics")) do
					if string.find(v:GetModel(), "strider") then
						v:Remove()
					end
				end
			end )
			
			npc:Remove()
		end
		
		if npc:GetClass() == "npc_manhack" then
			
		end

	end
end
hook.Add("OnNPCKilled", "SGS_NPCKilled", SGS_NPCKilled)

function SGS_NPCLoot( ltype, npc, ply )

	if ltype == "antlion" then
		
		local ent = ents.Create( "gms_meat" )
		ent:SetPos( npc:GetPos() +  Vector(math.random(-60,60),math.random(-60,60),40) )
		ent:SetModel( "models/gibs/antlion_gib_large_2.mdl" )
		ent:Spawn()
		ent.res = "antlion_head"
		ent:CPPISetOwner(ply)
		local npo = ent:GetPhysicsObject()
		npo:Wake()
		
		for i = 1, math.random(1,3) do		
			local npos = npc:GetPos() +  Vector(math.random(-60,60),math.random(-60,60),40)
			local ent = ents.Create( "gms_meat" )
			ent:SetPos( npos )
			ent:SetMaterial("models/flesh")
			ent:SetModel(SGS.proplist["meat"])
			if math.random(1,2) == 1 then
				ent:SetModel( "models/gibs/hgibs_spine.mdl" )
				ent:Spawn()
				ent.res = "antlion_leg"
			else
				ent:Spawn()
			end
			
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------
			local npo = ent:GetPhysicsObject()
			npo:Wake()
		end
		
	elseif ltype == "antlionboss" then
	
		local npos = npc:GetPos() +  Vector(0,0,40)
	
		local ent = ents.Create( "gms_rcache" )
	
		ent:SetPos( npos )
		ent:Spawn()
		
		local raredrop = false
		
		/* Antlion Guard Pet 1/60 chance */
		if math.random(1,60) == 1 then
			ent:SetResourceDropInfo( "pink_pet_egg", 1 )
			raredrop = true
		end
		if math.random(1,45) == 1 then
			ent:SetResourceDropInfo( "boss_pcache_core", 1 )
			raredrop = true
		end
		/* Antlion Meat 1/1 chance */
		if math.random(1,1) == 1 then ent:SetResourceDropInfo( "antlion_meat", math.random(20, 40) ) end		
		/* Antlion Pet 1/8 chance */
		if math.random(1,8) == 1 then ent:SetResourceDropInfo( "red_pet_egg", 1 ) end
		/* Boss Pickaxe Head 1/30 chance */
		if math.random(1,30) == 1 then
			ent:SetResourceDropInfo( "boss_pick_head", 1 )
			raredrop = true
		end			
		/* Boss Hatchet Head 1/30 chance */
		if math.random(1,30) == 1 then
			ent:SetResourceDropInfo( "boss_hatchet_head", 1 )
			raredrop = true
		end
		/* Boss Weapon Core 1/30 chance */
		if math.random(1,30) == 1 then
			ent:SetResourceDropInfo( "boss_rod_core", 1 )
			raredrop = true 
		end
		/* Hat Token 1/30 chance */
		if math.random(1,25) == 1 then
			ent:SetResourceDropInfo( "hat_token", 1 )
			raredrop = true 
		end		
		/* Chaos Stones 1/10 chance */
		if math.random(1,10) == 1 then ent:SetResourceDropInfo( "chaos_stone", 10 ) end		
		/* Nature Stones 1/15 chance */
		if math.random(1,15) == 1 then ent:SetResourceDropInfo( "nature_stone", 10 ) end		
		/* Cosmic Stones 1/20 chance */
		if math.random(1,20) == 1 then ent:SetResourceDropInfo( "cosmic_stone", 10 ) end		
		/* Sapphire 1/8 chance */
		if math.random(1,8) == 1 then ent:SetResourceDropInfo( "sapphire", math.random(1,8 ) ) end		
		/* Emerald 1/8 chance */
		if math.random(1,8) == 1 then ent:SetResourceDropInfo( "emerald", math.random(1,8 ) ) end		
		/* Ruby 1/12 chance */
		if math.random(1,12) == 1 then ent:SetResourceDropInfo( "ruby", math.random(1,5 ) ) end		
		/* Diamond 1/18 chance */
		if math.random(1,18) == 1 then ent:SetResourceDropInfo( "diamond", math.random(1,3) ) end
		
		if raredrop == false then
			local chance = math.random(1, 100)
			
			if chance == 1 then
				ent:SetResourceDropInfo( "pink_pet_egg", 1 )
			elseif chance > 1 and chance <= 4 then
				ent:SetResourceDropInfo( "boss_pick_head", 1 )
			elseif chance > 4 and chance <= 7 then
				ent:SetResourceDropInfo( "boss_hatchet_head", 1 )
			elseif chance > 7 and chance <= 10 then
				ent:SetResourceDropInfo( "boss_rod_core", 1 )
			elseif chance > 10 and chance <= 15 then
				ent:SetResourceDropInfo( "hat_token", 1 )
			end
		end
		
		ent:SetNetworkedString("Owner", "World")
		
		local npo = ent:GetPhysicsObject()
		npo:Wake()
		SafeRemoveEntityDelayed( ent , 300 )
		
	elseif ltype == "hunterboss" then
	
		local npos = npc:GetPos() +  Vector(0,0,40)
	
		local ent = ents.Create( "gms_rcache" )
	
		ent:SetPos( npos )
		ent:Spawn()
		
		local raredrop = false
		ent:SetResourceDropInfo( "wind_stone", math.random(60) )
		ent:SetResourceDropInfo( "water_stone", math.random(60) )
		ent:SetResourceDropInfo( "fire_stone", math.random(60) )
		ent:SetResourceDropInfo( "earth_stone", math.random(60) )
		ent:SetResourceDropInfo( "inert_stone", math.random(60) )
		/* Antlion Guard Pet 1/60 chance */
		if math.random(1,60) == 1 then
			ent:SetResourceDropInfo( "teal_pet_egg", 1 )
			raredrop = true
		end
		if math.random(1,35) == 1 then
			ent:SetResourceDropInfo( "boss_pcache_core", 1 )
			raredrop = true
		end
		/* Antlion Pet 1/6 chance */
		if math.random(1,5) == 1 then ent:SetResourceDropInfo( "red_pet_egg", 1 ) end
		/* Boss Pickaxe Head 1/30 chance */
		if math.random(1,15) == 1 then
			ent:SetResourceDropInfo( "boss_pick_head", 1 )
			raredrop = true
		end			
		/* Boss Hatchet Head 1/30 chance */
		if math.random(1,15) == 1 then
			ent:SetResourceDropInfo( "boss_hatchet_head", 1 )
			raredrop = true
		end
		/* Boss Weapon Core 1/30 chance */
		if math.random(1,15) == 1 then
			ent:SetResourceDropInfo( "boss_rod_core", 1 )
			raredrop = true 
		end
		/* Hat Token 1/30 chance */
		if math.random(1,10) == 1 then
			ent:SetResourceDropInfo( "hat_token", 1 )
			raredrop = true 
		end
		/* Void Cache 1/20 chance */
		if math.random(1,10) == 1 then
			ent:SetResourceDropInfo( "void_cache", math.random(2) )
			raredrop = true 
		end
		/* Void Cache 1/20 chance */
		if math.random(1,10) == 1 then
			ent:SetResourceDropInfo( "void_crystal", math.random(2) )
			raredrop = true 
		end
		/* Enchanted Metal 1/30 chance */
		if math.random(1,10) == 1 then
			ent:SetResourceDropInfo( "enchanted_metal", 1 )
			raredrop = true 
		end
		/* Enchanted Wood 1/30 chance */
		if math.random(1,10) == 1 then
			ent:SetResourceDropInfo( "enchanted_wood", 1 )
			raredrop = true
		end	
		/* Chaos Stones 1/10 chance */
		if math.random(1,5) == 1 then ent:SetResourceDropInfo( "chaos_stone", math.random(20) ) end		
		/* Nature Stones 1/15 chance */
		if math.random(1,5) == 1 then ent:SetResourceDropInfo( "nature_stone", math.random(20) ) end		
		/* Cosmic Stones 1/20 chance */
		if math.random(1,5) == 1 then ent:SetResourceDropInfo( "cosmic_stone", math.random(20) ) end		
		/* Sapphire 1/8 chance */
		if math.random(1,10) == 1 then ent:SetResourceDropInfo( "sapphire", math.random(10) ) end		
		/* Emerald 1/8 chance */
		if math.random(1,10) == 1 then ent:SetResourceDropInfo( "emerald", math.random(10) ) end		
		/* Ruby 1/12 chance */
		if math.random(1,10) == 1 then ent:SetResourceDropInfo( "ruby", math.random(8) ) end		
		/* Diamond 1/18 chance */
		if math.random(1,10) == 1 then ent:SetResourceDropInfo( "diamond", math.random(5) ) end	
		/* Random Structure */
		if math.random(1,5) == 1 then ent:SetResourceDropInfo( SGS.AllowedPackage[math.random(#SGS.AllowedPackage)], 1 ) end
		
		ent:SetNetworkedString("Owner", "World")
		
		local npo = ent:GetPhysicsObject()
		npo:Wake()
		SafeRemoveEntityDelayed( ent , 300 )
		
	elseif ltype == "manhack" then
		if math.random(1,75) == 1 then
			ply:SendMessage( "This manhack dropped some metal scraps.", 60, Color(0, 255, 0, 255))
			ply:AddResource( "metal_scraps", 1 )
		end
	end

end

function SGS_BurrowAntlions( )
	SGS.weather = "rain"
	
	for k, v in pairs( ents.FindByClass("npc_antlion") ) do
		if not IsValid(v) then continue end
		if v.ispet then continue end
		timer.Simple( math.random(2, 5), function() if IsValid(v) then v:Fire("Burrow") v:SetNWBool("isburrowed", true) end end )
	end
end

function SGS_UnburrowAntlions( )
	timer.Simple( 10, function()
		for k, v in pairs( ents.FindByClass("npc_antlion") ) do
			if v.ispet then continue end
			if not IsValid(v) then continue end
			timer.Simple( math.random(2, 5), function() 
				if IsValid(v) then 
					v:Fire("Unburrow") 
					v:SetNWBool("isburrowed", false)
				end 
			end )
			v:SetColor( Color( 255, 255, 255, 255 ) )
		end
	end )
end

function SGS_SpawnNPC( calling_ply, classname )
	if not calling_ply:IsValid() then return end
	
	if calling_ply:IsSuperAdmin() then
		if not params then params = "" end

		local trace = calling_ply:GetEyeTrace()
		local vector = trace.HitPos
		vector.z = vector.z + 20

		SGS_MakeCreature( classname, vector, nil )
	end
end

function SGS_SpawnNPC_Con( ply, com, args )

	local class = args[1]
	
	SGS_SpawnNPC( ply, class )

end
concommand.Add( "sgs_npc", SGS_SpawnNPC_Con )

function SGS_SpawnNPC_Chat( ply, text, public )
	if (string.sub(string.lower(text), 1, 4) == "!npc") then
		local args = string.Explode( " ", text )

		local class = args[2]
		
		SGS_SpawnNPC( ply, class )
		return false
	end
end
hook.Add( "PlayerSay", "SGS_SpawnNPC_Chat", SGS_SpawnNPC_Chat )


function SGS_SpawnZombieNightTime()
	if GAMEMODE.Worlds.BloodMoon then return end
	if SGS_DayPhase() == "night" then
	
		for k, v in pairs( player.GetAll() ) do
			
			if not GAMEMODE.Worlds:GetWorld( v ) then continue end
			if not GAMEMODE.Worlds:GetWorld( v ).ZombieSpawns then continue end
			if not IsValid(v) then continue end
			if not v:Alive() then continue end
			if v.amode then continue end
			if not (v:GetInitialized() == INITSTATE_OK) then continue end
			if v:GetLevel("survival") < 5 then continue end
			if math.random(1,10) > 1 then continue end
			SGS_SpawnZombieOnPlayer( v )
			
		end
		
	end
end
timer.Create( "SpawnZombies", 15, 0, SGS_SpawnZombieNightTime )

function SGS_SpawnZombieBloodMoon()
	if not GAMEMODE.Worlds.BloodMoon then return end
	if not SGS_DayPhase() == "night" then return end
	if #ents.FindByClass("npc_zombie") > 50 then return end

	for k, v in pairs( player.GetAll() ) do
		
		if GAMEMODE.Worlds:CountEntitiesOnWorld( GAMEMODE.Worlds:GetEntityWorldSpaceID( v ), "npc_zombie" ) >= 20 then continue end
		if not GAMEMODE.Worlds:GetWorld( v ) then continue end
		if not GAMEMODE.Worlds:GetWorld( v ).ZombieSpawns then continue end
		if not IsValid(v) then continue end
		if not v:Alive() then continue end
		if v.amode then continue end
		if not (v:GetInitialized() == INITSTATE_OK) then continue end
		if v:GetLevel("survival") < 5 then continue end
		if math.random(1,6) > 1 then continue end
		SGS_SpawnZombieOnPlayer( v )

	end
end
timer.Create( "SpawnZombiesBloodMoon", 2, 0, SGS_SpawnZombieBloodMoon )

function SGS_SpawnZombieOnPlayer( ply )

	if not IsValid( ply ) then return end
	cpos = ply:GetPos()
	npos = cpos + Vector(math.random(-300,300), math.random(-300,300), 400)
	
	local trace = {}
	trace.start = npos
	trace.endpos = trace.start + Vector(0,0,-600)
	trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
	trace.filter = self
	
	local tr = util.TraceLine(trace)
	if tr.Hit then
		if not (tr.MatType == MAT_SLOSH) then
			if tr.MatType == MAT_DIRT or tr.MatType == MAT_SAND or tr.MatType == MAT_GRASS or tr.MatType == MAT_SNOW then
				if tr.HitWorld then
					npos = tr.HitPos + Vector(0,0,10)
					SGS_MakeCreature( "npc_zombie", npos )
				end
			end
		end
	end

end

function SGS_IgniteZombies()
	for k, v in pairs( ents.FindByClass("npc_zombie") ) do
		if v.ispet then continue end
		if v.ignited then continue end
		
		if SGS_DayPhase() == "day" then
			v:Ignite(999)
		end
	end
	
	for k, v in pairs( ents.FindByClass("npc_head*" ) ) do
		if v.ispet then continue end
		
		SafeRemoveEntity( v )
	end
end
timer.Create( "IgniteZombies", 1, 0, SGS_IgniteZombies )