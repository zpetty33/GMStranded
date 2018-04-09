local PlayerMeta = FindMetaTable("Player")

-- lua_run SGS_SpawnPet( "npc_antlion", Entity(1):GetPos() + Vector(0,0,-30), Entity(1) )
function SGS_SpawnPet( npcclass, loc, owner )
	if not IsValid(owner) then
		return
	end
	
	local NPC = ents.Create(npcclass)
	NPC:SetPos( loc )
	NPC.owner = owner
	NPC.oid = owner:GetPlayerID()
	NPC:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	if npcclass == "npc_dog" then
		NPC:SetModelScale( 0.2, 0 )
		NPC.maxgrowth = 0.4
		NPC.curgrowth = 0.2
		NPC.growthinterval = 0.05
	elseif npcclass == "npc_crow" or npcclass == "npc_pigeon" or npc_class == "npc_seagull" then
		NPC:SetModelScale( 0.6, 0 )
		NPC.maxgrowth = 1.0
		NPC.curgrowth = 0.6
		NPC.growthinterval = 0.1
	else
		
		if npcclass == "npc_antlion" or npcclass == "npc_vortigaunt" then
			NPC.curgrowth = 0.3
			NPC.maxgrowth = 0.7
			NPC.growthinterval = 0.1
		elseif npcclass == "npc_antlionguard" then
			NPC.curgrowth = 0.2
			NPC.maxgrowth = 0.6
			NPC.growthinterval = 0.1
		else
			NPC.curgrowth = 0.3
			NPC.maxgrowth = 1.1
			NPC.growthinterval = 0.2
		end
		NPC:SetModelScale( NPC.curgrowth, 0)
	end
	
	NPC:Spawn()
	owner:AddStat( "general16", 1 )
	NPC:SetNWBool("ispet", true)
	NPC:AddRelationship("player D_LI 999")
	NPC:CPPISetOwner(owner)
	NPC:SetNWString("ownername", owner:Nick())
	NPC.ispet = true
	NPC.hunger = 360
	NPC.mode = "idle"
	NPC.age = 1
	NPC.skill = 1
	NPC.petid = "pid" .. tostring( os.time() ) .. tostring( owner:GetPlayerID() )
	
	NPC:SetNWFloat( "size", NPC.curgrowth )
	
	NPC:AddRelationship("npc_alyx D_LI 99")
	NPC:AddRelationship("npc_antlion D_LI 99")
	NPC:AddRelationship("npc_antlionguard D_LI 99")
	NPC:AddRelationship("npc_barney D_LI 99")
	NPC:AddRelationship("npc_breen D_LI 99")
	NPC:AddRelationship("npc_citizen D_LI 99")
	NPC:AddRelationship("npc_combine_s D_LI 99")
	NPC:AddRelationship("npc_crow D_LI 99")
	NPC:AddRelationship("npc_dog D_LI 99")
	NPC:AddRelationship("npc_eli D_LI 99")
	NPC:AddRelationship("npc_fastzombie D_LI 99")
	NPC:AddRelationship("npc_fastzombie_torso D_LI 99")
	NPC:AddRelationship("npc_gman D_LI 99")
	NPC:AddRelationship("npc_headcrab D_LI 99")
	NPC:AddRelationship("npc_headcrab_black D_LI 99")
	NPC:AddRelationship("npc_headcrab_fast D_LI 99")
	NPC:AddRelationship("npc_kleiner D_LI 99")
	NPC:AddRelationship("npc_metropolice D_LI 99")
	NPC:AddRelationship("npc_monk D_LI 99")
	NPC:AddRelationship("npc_mossman D_LI 99")
	NPC:AddRelationship("npc_pigeon D_LI 99")
	NPC:AddRelationship("npc_poisonzombie D_LI 99")
	NPC:AddRelationship("npc_strider D_LI 99")
	NPC:AddRelationship("npc_stalker D_LI 99")
	NPC:AddRelationship("npc_vortigaunt D_LI 99")
	NPC:AddRelationship("npc_zombie D_LI 99")
	NPC:AddRelationship("npc_zombie_torso D_LI 99")
	NPC:AddRelationship("npc_seagull D_LI 99")
	NPC:AddRelationship("npc_hunter D_LI 99")
	
	
	timer.Simple( 450, function() SGS_PetsAge( NPC ) end )
	timer.Simple( 20, function() SGS_PetsWander( NPC ) end )
	timer.Simple( 10, function() SGS_PetsFindFood( NPC ) end )
	
	owner.hasegg = false
	
	if IsValid(owner) and owner:IsPlayer() then
		owner.lastpet = NPC
		owner:SendLua("SGS_PetNameMenu()")
	end
end

function SGS_NamePetCon(ply, com, args)
	if not #args == 1 then
		ply:SendMessage("Invalid Command -- sgs_namepet [name]", 60, Color(255, 80, 80, 255))
		return
	end
	if IsValid(ply.lastpet) and (not ply.lastpet == nil) then
		ply.lastpet:SetNWString("petname", args[1])
	end
	
	ply:SendMessage("Your new pet is named: " .. args[1] .. ".", 60, Color(80, 80, 255, 255))
	ply.lastpet.name = args[1]
	ply.lastpet:SetNWString( "petname", args[1] )
end
concommand.Add("sgs_namepet", SGS_NamePetCon)


function SGS_ConCommandPlacePetFood( ply, com, args )

	if #args >= 1 then
		ply:SendMessage("Invalid Command -- sgs_placepetfood", 60, Color(255, 80, 80, 255))
		return
	end
	
	local cost = ply.resource[ "pet_food" ] or 0
	
	if cost < 1 then
		ply:SendMessage("You do not have any pet food!",3,Color(255,80,80,255))
		return
	end
	
	if SGS_CountPetFood( ply ) >= 10 then
		ply:SendMessage("You are only allowed 10 pet food spawned at a time.",3,Color(255,80,80,255))
		return
	end
		
	local mattype = "WUT?"
		if ply:CheckMat(300) then mattype = ply:CheckMat(300)	end
	local tr = ply:TraceFromEyes(140)
	if tr.HitWorld then
		if mattype == MAT_DIRT or mattype == MAT_SAND or mattype == MAT_GRASS or mattype == MAT_SNOW then --Checks to see if user presses use on a sand or dirt texture
			ply:SubResource( "pet_food", 1 )
			SGS_SpawnPetFood( tr.HitPos, ply )
		else
			ply:SendMessage("You cannot place pet food on this type of surface!",3,Color(255,80,80,255))
		end
	else
		ply:SendMessage("The food must be placed on the ground!",3,Color(255,80,80,255))
	end
	
end
concommand.Add("sgs_placepetfood", SGS_ConCommandPlacePetFood)

function SGS_SpawnPetFood( loc, owner )

	local PetFood = ents.Create( "gms_petfood" )
	PetFood:SetPos( loc )
	PetFood:Spawn()
	
	PetFood.owner = owner:GetPlayerID()
	
	PetFood:CPPISetOwner(owner)
		
end

function SGS_CountPetFood( ply )
	local count = 0
	for k, v in pairs( ents.FindByClass("gms_petfood") ) do
		if v.owner == ply:GetPlayerID() then
			count = count + 1
		end
	end
	
	return count
end

function SGS_PetsFindFood( pet )

	if IsValid( pet ) then
		
		if pet.hunger <= 310 then
		
			local foundfood = false
		
			if IsValid( pet.owner ) then
				for k, v in pairs( ents.FindInSphere( pet:GetPos(), 200 ) ) do
					if v:GetClass() == "gms_petfood" then
						if v.claimed == nil then
							v.claimed = false
						end
						if v.claimed then continue end
			
						pet.mode = "eating"
						pet:SetLastPosition( v:GetPos() )
						pet:SetSchedule( SCHED_FORCED_GO_RUN )
						
						v.claimed = true
						
						timer.Simple(4, function()
							if IsValid(v) then
								v:Remove()
								if not IsValid(pet) then return end
								local sound = {"npc/barnacle/barnacle_crunch2.wav", "npc/barnacle/barnacle_crunch3.wav"}
								pet:EmitSound(sound[math.random(#sound)], 50, math.random(100,140))
								pet.mode = "idle"
								pet.hunger = math.Clamp(pet.hunger + 80, 0, 360)
			
								
							end
						end)
						
						foundfood = true
						break
							
					end
				end
			end
			
			if not foundfood then
				pet.hunger = math.Clamp(pet.hunger - 2, 0, 360)
			end
			
			if pet.hunger <= 60 then
				pet:SetNWBool("famished", true)
				if IsValid(pet.owner) then
					pet.owner:SendMessage("Your pet " .. pet:GetNWString("petname") .. " is famished.",3,Color(255,80,80,255))
				end
			else
				pet:SetNWBool("famished", false)
			end
			
			if pet.hunger <= 0 then
				if IsValid(pet.owner) then
					pet.owner:SendMessage("Your pet " .. pet:GetNWString("petname") .. " has died of hunger.",3,Color(255,80,80,255))
				end
				SGS.Log("** The pet " .. pet:GetClass() .. " has died of hunger!")
				pet:Remove()
			end
		else
			pet.hunger = math.Clamp(pet.hunger - 1, 0, 360)
		end
		timer.Simple(10, function() SGS_PetsFindFood( pet ) end )
	end
end


function SGS_PetsWander( pet )

	if IsValid(pet) then
			
		if pet.mode == "idle" then
		
			local curpos = pet:GetPos()
			local newpos = curpos + Vector(math.random(-50,50), math.random(-50,50), 200)
			local trace = {}
			trace.start = newpos
			trace.endpos = trace.start + Vector(0,0,-500)
			trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
			trace.filter = pet
			
			local tr = util.TraceLine(trace)
			if tr.Hit then
				if tr.MatType == MAT_SLOSH then
				else
					local newpos = tr.HitPos
					pet:SetLastPosition(newpos)
					pet:SetSchedule( SCHED_FORCED_GO )
					if math.random(1,40) == 10 then
						if IsValid( pet.owner ) then
							SGS_PetFindsSomething( pet, pet.owner )
						end
					end
				end
			end
			
		end
		timer.Simple(30, function() SGS_PetsWander( pet ) end )
	end
	
end

function SGS_PetFindsSomething( pet, ply )

	if not IsValid( pet ) then return end
	if not IsValid( ply ) then return end
	
	local rare = math.random(1,100)
	local skill = ( pet.skill or 1 ) - 1
	
	rare = rare + ( math.Clamp((skill / 3), 1, 15) ) * 3
	
	if rare >= 95 then
		SGS_PetFindRare( pet, ply )
	else
		SGS_PetFindCommon( pet, ply )
	end
end

function SGS_PetFindRare( pet, ply )
	local class = pet:GetClass()
	local possible_rewards = {}
	
	if class == "npc_crow" or class == "npc_pigeon" or class == "npc_seagull" then
		possible_rewards = { "black_pet_egg", "yellow_pet_egg", "white_pet_egg", "woodcutting_relic_2", "woodcutting_relic_3" }
	end
	
	if class == "npc_headcrab" or class == "npc_headcrab_fast" or class == "npc_headcrab_black" then
		possible_rewards = { "brown_pet_egg", "orange_pet_egg", "blue_pet_egg", "farming_relic_2", "farming_relic_3" }
	end
	
	if class == "npc_dog" then
		possible_rewards = { "gray_pet_egg", "construction_relic_2", "construction_relic_3", "gray_pet_egg", "construction_relic_2", "construction_relic_3", "metal_scraps" }
	end
	
	if class == "npc_vortigaunt" then
		possible_rewards = { "green_pet_egg", "fishing_relic_2", "fishing_relic_3" }
	end
	
	if class == "npc_antlion" then
		possible_rewards = { "red_pet_egg", "bugbait", "bugbait", "combat_relic_1", "combat_relic_1", "combat_relic_1", "combat_relic_2", "combat_relic_3" }
	end

	if class == "npc_antlionguard" then --Considering not dropping pet egg due to this egg being a "boss" drop.
		possible_rewards = { "bugbait", "bugbait", "combat_relic_2", "combat_relic_2", "combat_relic_3", "combat_elixir", "strong_combat_elixir" }
	end

	if class == "npc_hunter" then --Likewise, considering not dropping pet egg.
		possible_rewards = { "strong_luck_elixir", "strong_luck_elixir", "strong_exp_elixir", "strong_exp_elixir", "enchanted_wood", "enchanted_metal", "diamond" }
	end
	
	if #possible_rewards <= 0 then return end
	
	local reward = possible_rewards[math.random(#possible_rewards)]
	
	ply:SendMessage("Your pet has found you a " .. CapAll(reward), 60, Color(0, 255, 100, 255))
	ply:AddResource( reward, 1 )
	
	pet.skill = pet.skill + 1
end

function SGS_PetFindCommon( pet, ply )
	
	local class = pet:GetClass()
	local possible_rewards = {}
	
	if class == "npc_crow" or class == "npc_pigeon" or class == "npc_seagull" then
		possible_rewards = { "tree_seed", "oak_seed", "maple_seed", "pine_seed", "yew_seed", "buckeye_seed", "palm_seed" }
	end
	
	if class == "npc_headcrab" or class == "npc_headcrab_fast" or class == "npc_headcrab_black" then
		possible_rewards = { "wheat_seed", "liferoot_seed", "guacca_seed", "arctus_seed", "liechi_seed", "lum_seed", "perriot_seed", "pallie_seed", "moly_seed", "karopa_seed" }
	end
	
	if class == "npc_dog" then
		possible_rewards = { "stone", "iron_ore", "coal", "silver_ore", "trinium_ore", "naquadah_ore", "platinum_ore", "mithril_ore", "gold_ore" }
	end
	
	if class == "npc_vortigaunt" then
		possible_rewards = { "trout", "cod", "herring", "salmon", "tuna", "lobster", "bass", "swordfish", "shark", "eel" }
	end
	
	if class == "npc_antlion" then
		possible_rewards = { "antlion_meat" }
	end
	
	if #possible_rewards <= 0 then return end
	
	local reward = possible_rewards[math.random(#possible_rewards)]
	local amt = math.random(2)
	
	ply:SendMessage("Your pet has found you " .. tostring(amt) .. "x " .. CapAll(reward) .. "(s)", 60, Color(0, 255, 100, 255))
	ply:AddResource( reward, amt )
	
end

function SGS_ConCommandMakePetFood( ply, com, args )

	if #args ~= 2 then
		ply:SendMessage("Invalid Command -- sgs_makepetfood <1/2> <1/5/10>", 60, Color(255, 80, 80, 255))
		return
	end
	
	if not tonumber(args[1]) then return end
	if not tonumber(args[2]) then return end
	
	local ftype = tonumber(args[1])
	ftype = math.Clamp( ftype, 1, 2 )
	local multi = tonumber(args[2])
	
	if multi <= 0 then return end
	
	if tostring(multi) == tostring(tonumber("nan")) then
		SGS_Log( "!!!!!!!!!!!" .. ply:Nick() .. " is trying to 'nan' dupe an item.")
		ply:SendMessage("This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
		return false
	end
	
	if ftype == 1 then
		if ply:GetResource( "antlion_meat" ) < multi then
			ply:SendMessage("This recipe requires " .. tostring(multi) .. "x Antlion Meat!",3,Color(255,80,80,255))
			return
		end
	else
		if ply:GetResource( "wheat" ) < multi then
			ply:SendMessage("This recipe requires " .. tostring(multi) .. "x Wheat!",3,Color(255,80,80,255))
			return
		end	
	end

	SGS_MakePetFood_Start(ply, 3, ftype, multi)
	
end
concommand.Add("sgs_makepetfood", SGS_ConCommandMakePetFood)

function SGS_PetsAge( pet )
	if IsValid( pet ) then
		
		pet.age = pet.age + 1

		if pet.age == 15 then
			pet.curgrowth = pet.curgrowth + pet.growthinterval
			SGS_PetGrow(pet, pet.curgrowth)
		end

		if pet.age == 30 then
			pet.curgrowth = pet.curgrowth + pet.growthinterval
			SGS_PetGrow(pet, pet.curgrowth)
		end

		if pet.age == 40 then
			pet.curgrowth = pet.curgrowth + pet.growthinterval
			SGS_PetGrow(pet, pet.curgrowth)
		end
		
		if pet.age == 50 then
			pet.curgrowth = pet.curgrowth + pet.growthinterval
			SGS_PetGrow(pet, pet.curgrowth)
			if IsValid( pet.owner ) then
				pet.owner:AddStat( "pets11", 1 )
				pet.owner:CheckForAchievements("squirrelhat")
			end
		end
		
		pet:SetNWInt("age", pet.age)
		
		if pet.age >= 80 then
			if math.random(1,3) == 1 then
				SGS_PetDieAge(pet)
			end
		end
		
		if pet.age >= 100 then
			SGS_PetDieAge(pet)
		end
		
			
		timer.Simple( 450, function() SGS_PetsAge( pet ) end )
	end
end


function SGS_PetDieAge( pet )

	if IsValid(pet.owner) then
		pet.owner:SendMessage("Your pet " .. pet:GetNWString("petname") .. " has died of old age.",3,Color(255,80,80,255))
		local rtokenamt = math.random(50,300)
		pet.owner:SendMessage("You are awarded (" .. rtokenamt .. ") GTokens." ,3,Color(255,80,80,255))
		pet.owner:GiveGTokens( rtokenamt )
		pet.owner:AddStat( "general13", rtokenamt )
	end

	if IsValid( pet ) then
		SGS.Log("** The pet " .. pet:GetClass() .. " has died of old age!")
		pet:Remove()
	end

end

function SGS_PetGrow( pet, scale )

	if not IsValid( pet ) then
		return
	end

	pet:SetModelScale( scale, 0)
	pet:SetNWFloat( "size", scale )
	
	pet:SetPos( pet:GetPos() + Vector(0,0,10) )
	
	if IsValid(pet.owner) then
		if scale < pet.maxgrowth then
			pet.owner:SendMessage("Your pet " .. pet:GetNWString("petname") .. " is healthy and has grown a little!",3,Color(80,255,80,255))
		else
			pet.owner:SendMessage("Your pet " .. pet:GetNWString("petname") .. " is healthy and is now fully grown!!",3,Color(80,255,80,255))
		end
	end

end

function SGS_NegatePetDamage( ent, dmginfo )
	if ent:IsNPC() then
		if ent.ispet == nil then ent.ispet = false end
		
		if ent.ispet then
			dmginfo:ScaleDamage(0)
			return false
		end
	end
end
hook.Add("EntityTakeDamage", "SGS_NegatePetDamage", SGS_NegatePetDamage)

function SGS_PetFromCage( ply, petid, cage )

	if ply:CountPets() >= 5 then
		ply:SendMessage("You are only allowed 5 pets out at a time.", 60, Color(255, 80, 80, 255))
		return
	end

	if ply.pethouse[petid] == nil then return end
	
	local ptable = ply.pethouse[petid]
	
	if ptable == nil then return end
	if not IsValid(cage) then return end
	
	ply.pethouse[petid] = nil
	
	local pet = ents.Create( ptable.class )
	pet:SetPos( cage:LocalToWorld(Vector(75,0,20) ) )
	pet.owner = ply
	pet.oid = ply:GetPlayerID()
	pet:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	pet.maxgrowth = ptable.maxgrowth
	pet.curgrowth = ptable.curgrowth
	pet.growthinterval = ptable.growthinterval
	pet:SetModelScale( ptable.curgrowth, 0)
	pet:SetNWFloat( "size", ptable.curgrowth )
	
	pet:Spawn()
	
	pet:SetNWBool("ispet", true)
	pet:AddRelationship("player D_LI 999")
	pet:CPPISetOwner(ply)
	pet:SetNWString("ownername", ply:Nick())
	pet.ispet = true
	pet.hunger =  ptable.hunger
	pet.mode = "idle"
	pet.age = ptable.age
	pet:SetNWInt("age", pet.age)
	pet.petid = petid
	pet.skill = (ptable.skill or 1)
	
	pet.name = ptable.name or "UNNAMED"
	pet:SetNWString( "petname", pet.name )
	
	pet:AddRelationship("npc_alyx D_LI 99")
	pet:AddRelationship("npc_antlion D_LI 99")
	pet:AddRelationship("npc_antlionguard D_LI 99")
	pet:AddRelationship("npc_barney D_LI 99")
	pet:AddRelationship("npc_breen D_LI 99")
	pet:AddRelationship("npc_citizen D_LI 99")
	pet:AddRelationship("npc_combine_s D_LI 99")
	pet:AddRelationship("npc_crow D_LI 99")
	pet:AddRelationship("npc_dog D_LI 99")
	pet:AddRelationship("npc_eli D_LI 99")
	pet:AddRelationship("npc_fastzombie D_LI 99")
	pet:AddRelationship("npc_fastzombie_torso D_LI 99")
	pet:AddRelationship("npc_gman D_LI 99")
	pet:AddRelationship("npc_headcrab D_LI 99")
	pet:AddRelationship("npc_headcrab_black D_LI 99")
	pet:AddRelationship("npc_headcrab_fast D_LI 99")
	pet:AddRelationship("npc_kleiner D_LI 99")
	pet:AddRelationship("npc_metropolice D_LI 99")
	pet:AddRelationship("npc_monk D_LI 99")
	pet:AddRelationship("npc_mossman D_LI 99")
	pet:AddRelationship("npc_pigeon D_LI 99")
	pet:AddRelationship("npc_poisonzombie D_LI 99")
	pet:AddRelationship("npc_strider D_LI 99")
	pet:AddRelationship("npc_stalker D_LI 99")
	pet:AddRelationship("npc_vortigaunt D_LI 99")
	pet:AddRelationship("npc_zombie D_LI 99")
	pet:AddRelationship("npc_zombie_torso D_LI 99")
	pet:AddRelationship("npc_seagull D_LI 99")
	pet:AddRelationship("npc_hunter D_LI 99")
	
	
	timer.Simple( 300, function() SGS_PetsAge( pet ) end )
	timer.Simple( 20, function() SGS_PetsWander( pet ) end )
	timer.Simple( 5, function() SGS_PetsFindFood( pet ) end )

end

function PetFromCageConCommand( ply, _, args )

	if not #args == 1 then return end
	if args[1] == nil then return end
	
	local trace = ply:TraceFromEyes(100)
	
	if not IsValid(trace.Entity) then
		return
	end
		
	if not trace.Entity:GetClass() == "gms_pethouse" then
		return
	end
		
	local ent = trace.Entity
	
	SGS_PetFromCage( ply, args[1], ent )

end
concommand.Add("sgs_petfromcage", PetFromCageConCommand)

function SGS_IncubateEgg( ply, _, args )

	local trace = ply:TraceFromEyes(100)
	
	if args[1] == nil then
		return
	end
	
	if not IsValid(trace.Entity) then
		return
	end
		
	if not trace.Entity:GetClass() == "gms_incubator" then
		return
	end
		
	local incubator = trace.Entity
	
	if not string.match( args[1], "pet_egg" ) then return end
	
	if  ply.resource[ args[1] ] == nil then
		ply:SendMessage("You don't have any " .. CapAll(string.gsub(args[1], "_", " ")) .. "s.", 60, Color(255, 80, 80, 255))
		return
	end
	
	if ( ply.resource[ args[1] ] ) < 1 then
		ply:SendMessage("You don't have any " .. CapAll(string.gsub(args[1], "_", " ")) .. "s.", 60, Color(255, 80, 80, 255))
		return
	end
	
	if incubator.inuse == true then
		ply:SendMessage("This incubator is already in use.", 60, Color(255, 80, 80, 255))
		return
	end
	
	if ply.hasegg == true then
		ply:SendMessage("You can only hatch one egg at a time.", 60, Color(255, 80, 80, 255))
		return
	end
	
	if ply:CountPets() >= 5 then
		ply:SendMessage("You are only allowed 5 pets out at a time.", 60, Color(255, 80, 80, 255))
		return
	end

	ply:SubResource( args[1], 1 )
	incubator:AttachEgg( ply, SGS_ReverseEggLookup( args[1] ).npcclass )

end
concommand.Add("sgs_incubate", SGS_IncubateEgg)

function SGS_ReclaimPets( ply )

	if not IsValid( ply ) then return end

	for _, v in pairs( ents.FindByClass( "npc_*" ) ) do
		if IsValid(v) and ( v.oid == ply:GetPlayerID() ) then
			v.owner = ply
		end
	end

end

function PlayerMeta:CountPets()
	if not IsValid( self ) then return end
	
	local count = 0

	for _, v in pairs( ents.FindByClass( "npc_*" ) ) do
		if IsValid(v) and ( v.oid == self:GetPlayerID() ) then
			count = count + 1
		end
	end
	
	if self.hasegg == true then
		count = count + 1
	end
	
	return count
end