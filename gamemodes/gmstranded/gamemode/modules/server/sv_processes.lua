function SGS_StartTimer( ply, txt, len, skill )

	if not skill then skill = "generic" end
	
	net.Start("sgs_starttimer")
		net.WriteString( txt )
		net.WriteInt( len, 32 )
		net.WriteString( skill )
	net.Send( ply )
	
end

function SGS_StopTimer( ply )
	ply:SendLua("SGS_StopTimer()")
end

function SGS_Lumber( ply, tree, timemodi, modi, gem, void )
	if not IsValid(tree) then return end
	if tree:GetClass() == "gms_treeseed" then
		ply:SendMessage("Be patient, you can't cut down seeds!", 60, Color(255, 125, 0, 255))
		return
	end
	local rlvl = SGS_LookupResourceTranslation( tree:GetClass() ).rlvl
	if ply:GetLevel("woodcutting") < rlvl then
		ply:SendMessage("This tree requires level " .. tostring(rlvl) .. " or greater to cut.", 60, Color(255, 125, 0, 255))
		return
	end
	local newtime = tree.baselen - timemodi
	SGS_Lumber_Start( ply, tree, newtime, tree.lvl, modi, gem, void )
end

function SGS_Mine( ply, rock, timemodi, modi, gem, void, autosmelt )
	local rlvl = SGS_LookupResourceTranslation( rock:GetClass() ).rlvl
	if ply:GetLevel("mining") < rlvl then
		ply:SendMessage("This rock requires level " .. tostring(rlvl) .. " or greater to mine.", 60, Color(255, 125, 0, 255))
		return
	end
	local newtime = rock.baselen - timemodi
	
	if rock:GetClass() == "gms_stonenode" then
		SGS_StoneMine_Start( ply, rock, newtime, modi, gem, void, autosmelt )
	elseif rock:GetClass() == "gms_ironnode" then
		SGS_IronMine_Start( ply, rock, newtime, modi, gem, void, autosmelt )
	elseif rock:GetClass() == "gms_coalnode" then
		SGS_CoalMine_Start( ply, rock, newtime, modi, gem, void, autosmelt )
	elseif rock:GetClass() == "gms_silvernode" then
		SGS_SilverMine_Start( ply, rock, newtime, modi, gem, void, autosmelt )
	elseif rock:GetClass() == "gms_triniumnode" then
		SGS_TriniumMine_Start( ply, rock, newtime, modi, gem, void, autosmelt )
	elseif rock:GetClass() == "gms_naquadahnode" then
		SGS_NaquadahMine_Start( ply, rock, newtime, modi, gem, void, autosmelt )
	elseif rock:GetClass() == "gms_goldnode" then
		SGS_GoldMine_Start( ply, rock, newtime, modi, gem, void, autosmelt )
	elseif rock:GetClass() == "gms_mithrilnode" then
		SGS_MithrilMine_Start( ply, rock, newtime, modi, gem, void, autosmelt )
	elseif rock:GetClass() == "gms_platinumnode" then
		SGS_PlatinumMine_Start( ply, rock, newtime, modi, gem, void, autosmelt )
	elseif rock:GetClass() == "gms_meteornode" then
		if modi >= 2.8 then
			SGS_MeteorMine_Start( ply, rock, newtime, modi, gem, true )
		else
			ply:SendMessage("This pickaxe won't work...", 60, Color(255, 125, 0, 255))
		end
	end
end


-------------
--LUMBERING--
-------------

function SGS_Lumber_Start(ply, tree, len, lvl, modi, gem, void)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if not tree.growth then
		tree.growth = 1
	end
	
	if tree.growth < tree.maxgrowth then
		ply:SendMessage("This tree is not fully grown yet.", 60, Color(255, 50, 50, 255))
		return
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/wood/wood_box_impact_bullet1.wav", "physics/wood/wood_box_impact_bullet2.wav", "physics/wood/wood_box_impact_bullet3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	if not tree.rtotal then
		tree.rtotal = 1
	end
	
	local txt = "Lumbering..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "woodcutting" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Lumber_Stop( ply, tree, lvl, modi, gem, void ) end )

end

function SGS_Lumber_Stop(ply, tree, lvl, modi, gem, void)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	

	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if ply.level[ "woodcutting" ] == nil then
		ply:SendMessage("CRITICAL ERROR #002. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not tree:IsValid() then
		ply:SendMessage("The tree is gone!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
	local xp = 25
	local modifier = 1
	local seedtype = "tree_seed"
	
	if lvl == 1 then
		xp = 12
		modifier = 1
		seedtype = "tree_seed"
	elseif lvl == 2 then
		xp = 19
		modifier = 1.2
		seedtype = "oak_seed"
	elseif lvl == 3 then
		xp = 34
		modifier = 1.4
		seedtype = "maple_seed"
	elseif lvl == 4 then
		xp = 50
		modifier = 1.6
		seedtype = "pine_seed"
	elseif lvl == 5 then
		xp = 75
		modifier = 1.8
		seedtype = "yew_seed"
	elseif lvl == 6 then
		xp = 120
		modifier = 2
		seedtype = "buckeye_seed"
	elseif lvl == 7 then
		xp = 210
		modifier = 2.2
		seedtype = "palm_seed"
	end
	
	local lvlmodi = ( ply.level[ "woodcutting" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi * modifier >= 40 then		
		/* check to see if we found a relic instead of a seed */
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, chance) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		
		local chance = 800
		if gem == "d" then chance = 650 end
		if ply.luck then
			local luck = 150
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundBirdEgg()
			return
		end
		
		local size = math.random(1,100)
		local ent = {}
		if not ply:InGrindMode() then
			ent = ents.Create( "gms_wood" )
		end
		if size < 70 then
			if not ply:InGrindMode() then
				ply:SendMessage("You managed to knock down a small chunk of wood!", 60, Color(0, 255, 0, 255))
			else
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp )
			ent.level = 1
		end
		if size >= 70 and size < 92 then
			if not ply:InGrindMode() then
				ply:SendMessage("You managed to knock down a chunk of wood!", 60, Color(0, 255, 0, 255))
			else
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.2 )
			ent.level = 2
		end
		if size >= 92 then
			if not ply:InGrindMode() then
				ply:SendMessage("You managed to knock down a large chunk of wood!", 60, Color(0, 255, 0, 255))
			else
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.5 )
			ent.level = 3
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "woodcutting", math.ceil( xp ) )
		
		if math.random(250) == 1 then
		
			ply:SendMessage( "You found a Red Apple.", 60, Color(0, 255, 255, 255) )
			ply:AddResource( "red_apple", 1 )
		
		end
		
		
		ent.wtype = lvl
		tree.rtotal = tree.rtotal - ent.level
		if not ply:InGrindMode() then
			ent:SetPos( npos )
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------]
		
			local npo = ent:GetPhysicsObject()
			npo:Wake()

		
			if gem == "r" then
				if math.random(1,10) == 1 then
					ply:SendMessage("The encrusted ruby glows brightly!", 60, Color(0, 255, 255, 255))
					local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
					local ent = ents.Create( "gms_wood" )
					ent.level = math.random(1,2)
					ent.wtype = lvl
					ent:SetPos( npos )
					ent:Spawn()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(ply)
					-------------------------
					local npo = ent:GetPhysicsObject()
					npo:Wake()
				end
			end
		end
		
		
		if tree.rtotal <= 0 then
			if IsValid(tree.owner) and tree.owner:IsPlayer() then
				tree.owner.tplants = tree.owner.tplants - 1
				tree.owner:UpdatePlantCount()
			end
			SGS_RemoveAResource(tree)
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "woodcutting2", 1 )
			ply:CheckForAchievements("woodcuttingmaster")
			tree:EmitSound("physics/wood/wood_box_break2.wav", 60, math.random(80,120))
		end
		
		local chance = 2
		if gem == "d" then chance = 10 end
		if math.random(1,140 + (lvl * 15)) <= chance then --Find a seed!
			ply:SendMessage("You have managed to find a seed.", 60, Color(0, 255, 0, 255))
			ply:AddResource( seedtype, 1 )
		end
		
		if lvl >= 3 then
			local chance = 500
			if gem == "d" then chance = 400 end
			if ply.luck then
				local luck = 100
				luck = luck * ply.luck
				chance = chance - luck
			end
			if math.random(1,chance) == 1 then
				ply:SendMessage("You have found some enchanted wood!!!", 60, Color(0, 255, 0, 255))
				ply:AddResource( "enchanted_wood", 1 )
				ply:AddStat( "woodcutting3", 1 )
			end
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end


-------------
--STONE MINING--
-------------

function SGS_StoneMine_Start(ply, res, len, modi, gem, void, autosmelt)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if res.depleted == true then
		ply:SendMessage("This resource is exhausted.", 60, Color(255, 255, 255, 255))
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/concrete/rock_impact_hard1.wav", "physics/concrete/rock_impact_hard2.wav", "physics/concrete/rock_impact_hard3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	
	local txt = "Mining..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "mining" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_StoneMine_Stop( ply, res, modi, gem, void, autosmelt ) end )

end

function SGS_StoneMine_Stop(ply, stone, modi, gem, void, autosmelt)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "mining" ] == nil then
		ply:SendMessage("CRITICAL ERROR #003. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not stone:IsValid() then
		ply:SendMessage("The rock is depleted!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
	
	local xp = 15
	
	local lvlmodi = ( ply.level[ "mining" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi >= 30 then		
		/* check to see if we found a relic instead of a seed */
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, chance) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		local size = math.random(1,100)
		local ent = {}
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent = ents.Create( "gms_stone" )
		end

		if size < 70 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				if not autosmelt then
					ply:SendMessage("You managed to break free a small chunk of stone!", 60, Color(0, 255, 0, 255))
				end
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp )
			ent.level = 1
		end
		if size >= 70 and size < 92 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				if not autosmelt then
					ply:SendMessage("You managed to break free a chunk of stone!", 60, Color(0, 255, 0, 255))
				end
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.2 )
			ent.level = 2
		end
		if size >= 92 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				if not autosmelt then
					ply:SendMessage("You managed to break free a large chunk of stone!", 60, Color(0, 255, 0, 255))
				end
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.5 )
			ent.level = 3
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "mining", xp )
		
		stone.rtotal = stone.rtotal - ent.level
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent:SetPos( npos )
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------
			local npo = ent:GetPhysicsObject()
			npo:Wake()
			
			if gem == "r" then
				if math.random(1,10) == 1 then
					ply:SendMessage("The encrusted ruby glows brightly!", 60, Color(0, 255, 255, 255))
					local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
					local ent = ents.Create( "gms_stone" )
					ent.level = math.random(1,2)
					ent:SetPos( npos )
					ent:Spawn()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(ply)
					-------------------------
					local npo = ent:GetPhysicsObject()
					npo:Wake()
				end
			end
		end
		
		if autosmelt then
			ply:SendMessage("The heat of your pickaxe gives you something different.", 60, Color(0, 255, 0, 255))
			ply:AddResource( "glass", ent.level )
		end
		
		
		if stone.rtotal <= 0 then
			stone.depleted = true
			stone:RespawnTimer()
			stone:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
			stone:SetColor(Color( 40, 40, 40, 200 ) )
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "mining7",1 )
			ply:CheckForAchievements("miningmaster")
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end





---------------
--IRON MINING--
---------------

function SGS_IronMine_Start(ply, res, len, modi, gem, void, autosmelt)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if res.depleted == true then
		ply:SendMessage("This resource is exhausted.", 60, Color(255, 255, 255, 255))
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/concrete/rock_impact_hard1.wav", "physics/concrete/rock_impact_hard2.wav", "physics/concrete/rock_impact_hard3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	local txt = "Mining..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "mining" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_IronMine_Stop( ply, res, modi, gem, void, autosmelt ) end )

end

function SGS_IronMine_Stop(ply, res, modi, gem, void, autosmelt)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "mining" ] == nil then
		ply:SendMessage("CRITICAL ERROR #004. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not res:IsValid() then
		ply:SendMessage("The rock is depleted!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
	
	local xp = 30
	
	local lvlmodi = ( ply.level[ "mining" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi >= 50 then		
		/* check to see if we found a relic instead of a seed */
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, chance) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		local size = math.random(1,100)
		local ent = {}
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent = ents.Create( "gms_iron" )
		end
		if size < 60 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				if not autosmelt then
					ply:SendMessage("You managed to break free a small chunk of iron!", 60, Color(0, 255, 0, 255))
				end
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp )
			ent.level = 1
		end
		if size >= 60 and size < 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				if not autosmelt then
					ply:SendMessage("You managed to break free a chunk of iron!", 60, Color(0, 255, 0, 255))
				end
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.2 )
			ent.level = 2
		end
		if size >= 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				if not autosmelt then
					ply:SendMessage("You managed to break free a large chunk of iron!", 60, Color(0, 255, 0, 255))
				end
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.5 )
			ent.level = 3
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "mining", xp )

		res.rtotal = res.rtotal - ent.level
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent:SetPos( npos ) 
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------
			local npo = ent:GetPhysicsObject()
			npo:Wake()
			
			if gem == "r" then
				if math.random(1,10) == 1 then
					ply:SendMessage("The encrusted ruby glows brightly!", 60, Color(0, 255, 255, 255))
					local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
					local ent = ents.Create( "gms_iron" )
					ent.level = math.random(1,2)
					ent:SetPos( npos )
					ent:Spawn()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(ply)
					-------------------------
					local npo = ent:GetPhysicsObject()
					npo:Wake()
				end
			end
		end
		
		if autosmelt then
			ply:SendMessage("The heat of your pickaxe gives you something different.", 60, Color(0, 255, 0, 255))
			ply:AddResource( "iron", ent.level )
		end
		
		ply:CheckForGem(1)
		
		if gem == "d" then
			ply:CheckForGem(1)
			ply:CheckForGem(1)
			ply:CheckForGem(1)
		end
		if ply.luck then
			if ply.luck >= 0.5 then ply:CheckForGem(1) end
			if ply.luck >= 1 then ply:CheckForGem(1) end
		end
		
		if res.rtotal <= 0 then
			res.depleted = true
			res:RespawnTimer()
			res:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
			res:SetColor(Color(80, 80, 80, 180))
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "mining7",1 )
			ply:CheckForAchievements("miningmaster")
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end

---------------
--COAL MINING--
---------------

function SGS_CoalMine_Start(ply, res, len, modi, gem, void, autosmelt)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if res.depleted == true then
		ply:SendMessage("This resource is exhausted.", 60, Color(255, 255, 255, 255))
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/concrete/rock_impact_hard1.wav", "physics/concrete/rock_impact_hard2.wav", "physics/concrete/rock_impact_hard3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	local txt = "Mining..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "mining" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_CoalMine_Stop( ply, res, modi, gem, void, autosmelt ) end )

end

function SGS_CoalMine_Stop(ply, res, modi, gem, void, autosmelt)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "mining" ] == nil then
		ply:SendMessage("CRITICAL ERROR #005. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not res:IsValid() then
		ply:SendMessage("The rock is depleted!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
	
		local xp = 40
	
	local lvlmodi = ( ply.level[ "mining" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi >= 60 then		
		/* check to see if we found a relic instead of a seed */
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, chance) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		local size = math.random(1,100)
		local ent = {}
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent = ents.Create( "gms_coal" )
		end
		if size < 60 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				if not autosmelt then
					ply:SendMessage("You managed to break free a small chunk of coal!", 60, Color(0, 255, 0, 255))
				end
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp )
			ent.level = 1
		end
		if size >= 60 and size < 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				if not autosmelt then
					ply:SendMessage("You managed to break free a chunk of coal!", 60, Color(0, 255, 0, 255))
				end
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.2 )
			ent.level = 2
		end
		if size >= 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				if not autosmelt then
					ply:SendMessage("You managed to break free a large chunk of coal!", 60, Color(0, 255, 0, 255))
				end
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.5 )
			ent.level = 3
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "mining", xp )

		res.rtotal = res.rtotal - ent.level
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent:SetPos( npos ) 
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------
			local npo = ent:GetPhysicsObject()
			npo:Wake()
			
			if gem == "r" then
				if math.random(1,10) == 1 then
					ply:SendMessage("The encrusted ruby glows brightly!", 60, Color(0, 255, 255, 255))
					local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
					local ent = ents.Create( "gms_coal" )
					ent.level = math.random(1,2)
					ent:SetPos( npos )
					ent:Spawn()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(ply)
					-------------------------
					local npo = ent:GetPhysicsObject()
					npo:Wake()
				end
			end
		end
		
		if autosmelt then
			ply:SendMessage("The heat of your pickaxe gives you something different.", 60, Color(0, 255, 0, 255))
			ply:AddResource( "charcoal", ent.level )
		end
		
		ply:CheckForGem(2)
		
		if gem == "d" then
			ply:CheckForGem(2)
			ply:CheckForGem(2)
			ply:CheckForGem(2)
		end

		if ply.luck then
			if ply.luck >= 0.5 then ply:CheckForGem(2) end
			if ply.luck >= 1 then ply:CheckForGem(2) end
		end
		
		if res.rtotal <= 0 then
			res.depleted = true
			res:RespawnTimer()
			res:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
			res:SetColor(Color(70, 70, 70, 180))
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "mining7",1 )
			ply:CheckForAchievements("miningmaster")
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end

-----------------
--SILVER MINING--
-----------------

function SGS_SilverMine_Start(ply, res, len, modi, gem, void, autosmelt)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if res.depleted == true then
		ply:SendMessage("This resource is exhausted.", 60, Color(255, 255, 255, 255))
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/concrete/rock_impact_hard1.wav", "physics/concrete/rock_impact_hard2.wav", "physics/concrete/rock_impact_hard3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	local txt = "Mining..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "mining" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_SilverMine_Stop( ply, res, modi, gem, void, autosmelt ) end )

end

function SGS_SilverMine_Stop(ply, res, modi, gem, void, autosmelt)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "mining" ] == nil then
		ply:SendMessage("CRITICAL ERROR #006. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not res:IsValid() then
		ply:SendMessage("The rock is depleted!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
	
		local xp = 50
	
	local lvlmodi = ( ply.level[ "mining" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi >= 70 then		
		/* check to see if we found a relic instead of a seed */
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, chance) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		local size = math.random(1,100)
		local ent = {}
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent = ents.Create( "gms_silver" )
		end
		if size < 60 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a small chunk of silver!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp )
			ent.level = 1
		end
		if size >= 60 and size < 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a chunk of silver!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.2 )
			ent.level = 2
		end
		if size >= 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a large chunk of silver!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.5 )
			ent.level = 3
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "mining", xp )

		res.rtotal = res.rtotal - ent.level
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent:SetPos( npos ) 
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------
			local npo = ent:GetPhysicsObject()
			npo:Wake()
			
			if gem == "r" then
				if math.random(1,10) == 1 then
					ply:SendMessage("The encrusted ruby glows brightly!", 60, Color(0, 255, 255, 255))
					local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
					local ent = ents.Create( "gms_silver" )
					ent.level = math.random(1,2)
					ent:SetPos( npos )
					ent:Spawn()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(ply)
					-------------------------
					local npo = ent:GetPhysicsObject()
					npo:Wake()
				end
			end
		end
		
		if autosmelt then
			ply:SendMessage("The heat of your pickaxe gives you something different.", 60, Color(0, 255, 0, 255))
			ply:AddResource( "silver", ent.level )
		end
		
		ply:CheckForGem(3)
		
		if gem == "d" then
			ply:CheckForGem(3)
			ply:CheckForGem(3)
			ply:CheckForGem(3)
		end

		if ply.luck then
			if ply.luck >= 0.5 then ply:CheckForGem(3) end
			if ply.luck >= 1 then ply:CheckForGem(3) end
		end
		
		if res.rtotal <= 0 then
			res.depleted = true
			res:RespawnTimer()
			res:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
			res:SetColor(Color(0, 0, 0, 180))
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "mining7",1 )
			ply:CheckForAchievements("miningmaster")
		end
		
		local chance = 500
		if gem == "d" then chance = 400 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1,chance) == 1 then
			ply:SendMessage("You have found some enchanted metal!!!", 60, Color(0, 255, 0, 255))
			ply:AddResource( "enchanted_metal", 1 )
			ply:AddStat( "mining9", 1 )
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end

--------------------
---TRINIUM MINING---
--------------------

function SGS_TriniumMine_Start(ply, res, len, modi, gem, void, autosmelt)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if res.depleted == true then
		ply:SendMessage("This resource is exhausted.", 60, Color(255, 255, 255, 255))
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/concrete/rock_impact_hard1.wav", "physics/concrete/rock_impact_hard2.wav", "physics/concrete/rock_impact_hard3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	local txt = "Mining..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "mining" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_TriniumMine_Stop( ply, res, modi, gem, void, autosmelt ) end )

end

function SGS_TriniumMine_Stop(ply, res, modi, gem, void, autosmelt)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "mining" ] == nil then
		ply:SendMessage("CRITICAL ERROR #007. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not res:IsValid() then
		ply:SendMessage("The rock is depleted!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
	
		local xp = 65
	
	local lvlmodi = ( ply.level[ "mining" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi >= 80 then		
		/* check to see if we found a relic instead of a seed */
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, chance) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		local size = math.random(1,100)
		local ent = {}
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent = ents.Create( "gms_trinium" )
		end
		if size < 60 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a small chunk of trinium!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp )
			ent.level = 1
		end
		if size >= 60 and size < 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a chunk of trinium!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.2 )
			ent.level = 2
		end
		if size >= 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a large chunk of trinium!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.5 )
			ent.level = 3
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "mining", xp )

		res.rtotal = res.rtotal - ent.level
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent:SetPos( npos ) 
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------
			local npo = ent:GetPhysicsObject()
			npo:Wake()
			
			if gem == "r" then
				if math.random(1,10) == 1 then
					ply:SendMessage("The encrusted ruby glows brightly!", 60, Color(0, 255, 255, 255))
					local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
					local ent = ents.Create( "gms_trinium" )
					ent.level = math.random(1,2)
					ent:SetPos( npos )
					ent:Spawn()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(ply)
					-------------------------
					local npo = ent:GetPhysicsObject()
					npo:Wake()
				end
			end
		end
		
		if autosmelt then
			ply:SendMessage("The heat of your pickaxe gives you something different.", 60, Color(0, 255, 0, 255))
			ply:AddResource( "trinium", ent.level )
		end
		
		ply:CheckForGem(4)
		
		if gem == "d" then
			ply:CheckForGem(4)
			ply:CheckForGem(4)
			ply:CheckForGem(4)
		end

		if ply.luck then
			if ply.luck >= 0.5 then ply:CheckForGem(4) end
			if ply.luck >= 1 then ply:CheckForGem(4) end
		end
		
		if res.rtotal <= 0 then
			res.depleted = true
			res:RespawnTimer()
			res:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
			res:SetColor(Color(20, 20, 20, 255))
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "mining7",1 )
			ply:CheckForAchievements("miningmaster")
		end
		
		local chance = 500
		if gem == "d" then chance = 400 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1,chance) == 1 then
			ply:SendMessage("You have found some enchanted metal!!!", 60, Color(0, 255, 0, 255))
			ply:AddResource( "enchanted_metal", 1 )
			ply:AddStat( "mining9", 1 )
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end


-------------------
--NAQUADAH MINING--
-------------------

function SGS_NaquadahMine_Start(ply, res, len, modi, gem, void, autosmelt)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if res.depleted == true then
		ply:SendMessage("This resource is exhausted.", 60, Color(255, 255, 255, 255))
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/concrete/rock_impact_hard1.wav", "physics/concrete/rock_impact_hard2.wav", "physics/concrete/rock_impact_hard3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	local txt = "Mining..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "mining" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_NaquadahMine_Stop( ply, res, modi, gem, void, autosmelt ) end )

end

function SGS_NaquadahMine_Stop(ply, res, modi, gem, void, autosmelt)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "mining" ] == nil then
		ply:SendMessage("CRITICAL ERROR #008. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not res:IsValid() then
		ply:SendMessage("The rock is depleted!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
	
		local xp = 90
	
	local lvlmodi = ( ply.level[ "mining" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi >= 80 then		
		/* check to see if we found a relic instead of a seed */
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, chance) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		local size = math.random(1,100)
		local ent = {}
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent = ents.Create( "gms_naquadah" )
		end
		if size < 60 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a small chunk of naquadah!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp )
			ent.level = 1
		end
		if size >= 60 and size < 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a chunk of naquadah!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.2 )
			ent.level = 2
		end
		if size >= 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a large chunk of naquadah!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.5 )
			ent.level = 3
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "mining", xp )

		res.rtotal = res.rtotal - ent.level
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent:SetPos( npos ) 
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------
			local npo = ent:GetPhysicsObject()
			npo:Wake()
			
			if gem == "r" then
				if math.random(1,10) == 1 then
					ply:SendMessage("The encrusted ruby glows brightly!", 60, Color(0, 255, 255, 255))
					local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
					local ent = ents.Create( "gms_naquadah" )
					ent.level = math.random(1,2)
					ent:SetPos( npos )
					ent:Spawn()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(ply)
					-------------------------
					local npo = ent:GetPhysicsObject()
					npo:Wake()
				end
			end
		end
		
		if autosmelt then
			ply:SendMessage("The heat of your pickaxe gives you something different.", 60, Color(0, 255, 0, 255))
			ply:AddResource( "naquadah", ent.level )
		end
		
		ply:CheckForGem(5)
		
		if gem == "d" then
			ply:CheckForGem(5)
			ply:CheckForGem(5)
			ply:CheckForGem(5)
		end

		if ply.luck then
			if ply.luck >= 0.5 then ply:CheckForGem(5) end
			if ply.luck >= 1 then ply:CheckForGem(5) end
		end
		
		if res.rtotal <= 0 then
			res.depleted = true
			res:RespawnTimer()
			res:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
			res:SetColor(Color(0, 0, 0, 180))
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "mining7",1 )
			ply:CheckForAchievements("miningmaster")
		end
		
		local chance = 500
		if gem == "d" then chance = 400 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1,chance) == 1 then
			ply:SendMessage("You have found some enchanted metal!!!", 60, Color(0, 255, 0, 255))
			ply:AddResource( "enchanted_metal", 1 )
			ply:AddStat( "mining9", 1 )
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end


-------------------
----GOLD MINING----
-------------------

function SGS_GoldMine_Start(ply, res, len, modi, gem, void, autosmelt)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if res.depleted == true then
		ply:SendMessage("This resource is exhausted.", 60, Color(255, 255, 255, 255))
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/concrete/rock_impact_hard1.wav", "physics/concrete/rock_impact_hard2.wav", "physics/concrete/rock_impact_hard3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	local txt = "Mining..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "mining" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_GoldMine_Stop( ply, res, modi, gem, void, autosmelt ) end )

end

function SGS_GoldMine_Stop(ply, res, modi, gem, void, autosmelt)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "mining" ] == nil then
		ply:SendMessage("CRITICAL ERROR #008. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not res:IsValid() then
		ply:SendMessage("The rock is depleted!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
	
		local xp = 140
	
	local lvlmodi = ( ply.level[ "mining" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi >= 80 then		
		/* check to see if we found a relic instead of a seed */
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, chance) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		local size = math.random(1,100)
		local ent = {}
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent = ents.Create( "gms_gold" )
		end
		if size < 60 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a small chunk of gold!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp )
			ent.level = 1
		end
		if size >= 60 and size < 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a chunk of gold!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.2 )
			ent.level = 2
		end
		if size >= 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a large chunk of gold!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.5 )
			ent.level = 3
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "mining", xp )

		res.rtotal = res.rtotal - ent.level
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent:SetPos( npos ) 
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------
			local npo = ent:GetPhysicsObject()
			npo:Wake()
			
			if gem == "r" then
				if math.random(1,10) == 1 then
					ply:SendMessage("The encrusted ruby glows brightly!", 60, Color(0, 255, 255, 255))
					local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
					local ent = ents.Create( "gms_gold" )
					ent.level = math.random(1,2)
					ent:SetPos( npos )
					ent:Spawn()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(ply)
					-------------------------
					local npo = ent:GetPhysicsObject()
					npo:Wake()
				end
			end
		end
		
		if autosmelt then
			ply:SendMessage("The heat of your pickaxe gives you something different.", 60, Color(0, 255, 0, 255))
			ply:AddResource( "gold", ent.level )
		end
		
		ply:CheckForGem(6)
		
		if gem == "d" then
			ply:CheckForGem(6)
			ply:CheckForGem(6)
			ply:CheckForGem(6)
		end

		if ply.luck then
			if ply.luck >= 0.5 then ply:CheckForGem(6) end
			if ply.luck >= 1 then ply:CheckForGem(6) end
		end
		
		if res.rtotal <= 0 then
			res.depleted = true
			res:RespawnTimer()
			res:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
			res:SetColor(Color(0, 0, 0, 255))
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "mining7",1 )
			ply:CheckForAchievements("miningmaster")
		end
		
		local chance = 500
		if gem == "d" then chance = 400 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1,chance) == 1 then
			ply:SendMessage("You have found some enchanted metal!!!", 60, Color(0, 255, 0, 255))
			ply:AddResource( "enchanted_metal", 1 )
			ply:AddStat( "mining9", 1 )
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end

--------------------
---MITHRIL MINING---
--------------------

function SGS_MithrilMine_Start(ply, res, len, modi, gem, void, autosmelt)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if res.depleted == true then
		ply:SendMessage("This resource is exhausted.", 60, Color(255, 255, 255, 255))
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/concrete/rock_impact_hard1.wav", "physics/concrete/rock_impact_hard2.wav", "physics/concrete/rock_impact_hard3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	local txt = "Mining..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "mining" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_MithrilMine_Stop( ply, res, modi, gem, void, autosmelt ) end )

end

function SGS_MithrilMine_Stop(ply, res, modi, gem, void, autosmelt)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "mining" ] == nil then
		ply:SendMessage("CRITICAL ERROR #008. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not res:IsValid() then
		ply:SendMessage("The rock is depleted!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
	
		local xp = 140
	
	local lvlmodi = ( ply.level[ "mining" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi >= 80 then		
		/* check to see if we found a relic instead of a seed */
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, chance) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		local size = math.random(1,100)
		local ent = {}
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent = ents.Create( "gms_mithril" )
		end
		if size < 60 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a small chunk of mithril!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp )
			ent.level = 1
		end
		if size >= 60 and size < 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a chunk of mithril!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.2 )
			ent.level = 2
		end
		if size >= 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a large chunk of mithril!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.5 )
			ent.level = 3
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "mining", xp )

		res.rtotal = res.rtotal - ent.level
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent:SetPos( npos ) 
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------
			local npo = ent:GetPhysicsObject()
			npo:Wake()
			
			if gem == "r" then
				if math.random(1,10) == 1 then
					ply:SendMessage("The encrusted ruby glows brightly!", 60, Color(0, 255, 255, 255))
					local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
					local ent = ents.Create( "gms_mithril" )
					ent.level = math.random(1,2)
					ent:SetPos( npos )
					ent:Spawn()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(ply)
					-------------------------
					local npo = ent:GetPhysicsObject()
					npo:Wake()
				end
			end
		end
		
		if autosmelt then
			ply:SendMessage("The heat of your pickaxe gives you something different.", 60, Color(0, 255, 0, 255))
			ply:AddResource( "mithril", ent.level )
		end
		
		ply:CheckForGem(6)
		
		if gem == "d" then
			ply:CheckForGem(6)
			ply:CheckForGem(6)
			ply:CheckForGem(6)
		end

		if ply.luck then
			if ply.luck >= 0.5 then ply:CheckForGem(7) end
			if ply.luck >= 1 then ply:CheckForGem(7) end
		end
		
		if res.rtotal <= 0 then
			res.depleted = true
			res:RespawnTimer()
			res:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
			res:SetColor(Color(0, 0, 0, 255))
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "mining7",1 )
			ply:CheckForAchievements("miningmaster")
		end
		
		local chance = 500
		if gem == "d" then chance = 400 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1,chance) == 1 then
			ply:SendMessage("You have found some enchanted metal!!!", 60, Color(0, 255, 0, 255))
			ply:AddResource( "enchanted_metal", 1 )
			ply:AddStat( "mining9", 1 )
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end

---------------------
---PLATINUM MINING---
---------------------

function SGS_PlatinumMine_Start(ply, res, len, modi, gem, void, autosmelt)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if res.depleted == true then
		ply:SendMessage("This resource is exhausted.", 60, Color(255, 255, 255, 255))
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/concrete/rock_impact_hard1.wav", "physics/concrete/rock_impact_hard2.wav", "physics/concrete/rock_impact_hard3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	local txt = "Mining..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "mining" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_PlatinumMine_Stop( ply, res, modi, gem, void, autosmelt ) end )

end

function SGS_PlatinumMine_Stop(ply, res, modi, gem, void, autosmelt)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "mining" ] == nil then
		ply:SendMessage("CRITICAL ERROR #008. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not res:IsValid() then
		ply:SendMessage("The rock is depleted!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
	
	local xp = 210
	
	local lvlmodi = ( ply.level[ "mining" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi >= 80 then		
		/* check to see if we found a relic instead of a seed */
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, chance) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		local size = math.random(1,100)
		local ent = {}
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent = ents.Create( "gms_platinum" )
		end
		if size < 60 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a small chunk of platinum!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp )
			ent.level = 1
		end
		if size >= 60 and size < 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a chunk of platinum!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.2 )
			ent.level = 2
		end
		if size >= 90 then
			if ( not ply:InGrindMode() ) and ( not autosmelt ) then
				ply:SendMessage("You managed to break free a large chunk of platinum!", 60, Color(0, 255, 0, 255))
			elseif ply:InGrindMode() then
				ply:SendMessage("You are in grinding mode. Resources are not dropped.", 60, Color(0, 255, 0, 255))
			end
			xp = math.ceil( xp * 1.5 )
			ent.level = 3
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "mining", xp )

		res.rtotal = res.rtotal - ent.level
		if ( not ply:InGrindMode() ) and ( not autosmelt ) then
			ent:SetPos( npos ) 
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(ply)
			-------------------------
			local npo = ent:GetPhysicsObject()
			npo:Wake()
			
			if gem == "r" then
				if math.random(1,10) == 1 then
					ply:SendMessage("The encrusted ruby glows brightly!", 60, Color(0, 255, 255, 255))
					local npos = ( (ply:GetPos() + (ply:GetAngles():Forward() * 20)) + (ply:GetAngles():Right() * math.random(-20,20)) ) + Vector(0,0,70)
					local ent = ents.Create( "gms_platinum" )
					ent.level = math.random(1,2)
					ent:SetPos( npos )
					ent:Spawn()
					--SPP MAKE PLAYER OWNER--
					ent:CPPISetOwner(ply)
					-------------------------
					local npo = ent:GetPhysicsObject()
					npo:Wake()
				end
			end
		end
		
		if autosmelt then
			ply:SendMessage("The heat of your pickaxe gives you something different.", 60, Color(0, 255, 0, 255))
			ply:AddResource( "platinum", ent.level )
		end
		
		ply:CheckForGem(8)
		
		if gem == "d" then
			ply:CheckForGem(8)
			ply:CheckForGem(8)
			ply:CheckForGem(8)
		end

		if ply.luck then
			if ply.luck >= 0.5 then ply:CheckForGem(8) end
			if ply.luck >= 1 then ply:CheckForGem(8) end
		end
		
		if res.rtotal <= 0 then
			res.depleted = true
			res:RespawnTimer()
			res:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
			res:SetColor(Color(0, 0, 0, 255))
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "mining7",1 )
			ply:CheckForAchievements("miningmaster")
		end
		
		local chance = 500
		if gem == "d" then chance = 400 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1,chance) == 1 then
			ply:SendMessage("You have found some enchanted metal!!!", 60, Color(0, 255, 0, 255))
			ply:AddResource( "enchanted_metal", 1 )
			ply:AddStat( "mining9", 1 )
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end

---------------------
---Meteor MINING---
---------------------

function SGS_MeteorMine_Start(ply, res, len, modi, gem, void)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if not gem then
		gem = "n"
	end
	
	if gem == "e" then
		if math.random(1,10) == 1 then
			len = len * 0.7
			ply:SendMessage("The encrusted emerald glows brightly!", 60, Color(0, 255, 255, 255))
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/concrete/rock_impact_hard1.wav", "physics/concrete/rock_impact_hard2.wav", "physics/concrete/rock_impact_hard3.wav"}
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	local txt = "Mining..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "mining" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_MeteorMine_Stop( ply, res, modi, gem, void ) end )

end

function SGS_MeteorMine_Stop(ply, res, modi, gem, void)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "mining" ] == nil then
		ply:SendMessage("CRITICAL ERROR #008. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not IsValid( res ) then
		ply:SendMessage("The meteor is gone", 60, Color(255, 0, 0, 255))
		return
	end
	
	local xp = 800
	
	local lvlmodi = ( ply.level[ "mining" ] * 0.05 ) + 1
	
	if ( math.random(1,100) * modi ) * lvlmodi >= 80 then		
		local chance = 600
		if gem == "d" then chance = 500 end
		if ply.luck then
			local luck = 100
			luck = luck * ply.luck
			chance = chance - luck
		end
		
		if gem == "s" then
			if math.random(1,10) == 1 then
				xp = xp * 2
				ply:SendMessage("The encrusted sapphire glows brightly!", 60, Color(0, 255, 255, 255))
			end
		end
		
		ply:AddExp( "mining", xp )
		
		local loot_table = {
		"silver_ore",
		"gold_ore",
		"trinium_ore", 
		"naquadah_ore",
		"mithril_ore", 
		"platinum_ore" }
		
		
		local chance = 20
		if ply.luck then
			if ply.luck >= 0.5 then chance = 18 end
			if ply.luck >= 1 then chance = 15 end
		end
		if gem == "d" then chance = chance - 5 end
		if math.random(chance) == 1 then
			ply:AddResource( "meteoric_iron_ore", 1 )
			SGS.Log("** " .. ply:Nick() .. " found a meteoric iron ore!")
		else
			ply:AddResource( loot_table[math.random(#loot_table)], math.random(5,10) )
		end

		ply:CheckForGem(20)
		ply:CheckForStone( true )
		
		if gem == "d" then
			ply:CheckForGem(20)
			ply:CheckForGem(20)
			ply:CheckForGem(20)
		end

		if ply.luck then
			if ply.luck >= 0.5 then ply:CheckForGem(30) end
			if ply.luck >= 1 then ply:CheckForGem(50) end
		end
		
		local chance = 80
		if gem == "d" then chance = 70 end
		if ply.luck then
			local luck = 10
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1,chance) == 1 then
			ply:SendMessage("You have found some enchanted metal!!!", 60, Color(0, 255, 0, 255))
			ply:AddResource( "enchanted_metal", 1 )
			ply:AddStat( "mining9", 1 )
		end
		
		if not res.durability then res.durability = 10 end
		res.durability = res.durability - 1
		
		if res.durability <= 0 then
			ply:SendMessage("You have exhausted this resource.", 60, Color(255, 255, 255, 255))
			ply:AddStat( "mining7",1 )
			ply:CheckForAchievements("miningmaster")
			res:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
			res:Remove()
		end
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end


-------------
--Sleeping--
-------------

function SGS_Sleep_Start(ply, len, bed, heal)
	if ply.inprocess == true then
		return
	end
	
	if ply.amode then
		return
	end
	
	ply:ScreenFade( SCREENFADE.OUT, Color(0,0,0), 2, len-2 )
	ply:SetNoDraw( true )
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.sleeping = true
	ply.processtype = "sleeping"
	
	--Check for shelter
	local trace = {}
	trace.start = ply:GetShootPos()
	trace.endpos = trace.start + (ply:GetUp() * 300)
	trace.filter = ply

	local tr = util.TraceLine(trace)

	if !tr.HitWorld and !tr.HitNonWorld then
		ply.sheltered = false
	else
		ply.sheltered = true
	end
	ply:CreateRagdoll()
	
	local txt = "Sleeping..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Sleep_Stop( ply, bed, heal ) end )
	
end

function SGS_Sleep_Stop(ply, bed, heal)
	
	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply.sleeping = false
	ply.passedout = false
	ply:SetNWString("action", "Idle")
	RDRemoveRagdollEntity( ply )
	ply:SetNoDraw( false )
	
	if ply.sheltered == true then
		if heal then
			if bed then
				ply:Heal(30)
				ply:SendMessage("You feel rested! 30hp restored.", 60, Color(255, 255, 0, 255))
			else
				ply:Heal(10)
				ply:SendMessage("You feel rested! 10hp restored.", 60, Color(255, 255, 0, 255))
			end
		end
		ply.needs["fatigue"] = ply.maxneeds
	else
		ply:SendMessage("You awaken stiff from sleeping in the elements!", 60, Color(255, 255, 0, 255))
		ply.needs["fatigue"] = ply.maxneeds
	end
	ply:AddStat( "general3", 1 )
	ply:SendNeeds()
	
end


----------------
--Eating Fruit--
----------------

function SGS_EatFruit_Start(ply, len, lvl, size)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.processtype = "eating"
	
	local txt = "Eating..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_EatFruit_Stop( ply, lvl, size ) end )

end

function SGS_EatFruit_Stop(ply, lvl, size)

	if not ply:IsValid() then return end

	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")

	local sound = {"npc/barnacle/barnacle_crunch2.wav", "npc/barnacle/barnacle_crunch3.wav"}
	ply:EmitSound(sound[math.random(#sound)], 60, math.random(80,120))
	
	if lvl == "goldmelon" then
	
		ply:SendMessage("You Feel Amazing!", 60, Color(255, 255, 0, 255))
		ply.needs["hunger"] = ply.maxneeds
		ply:AddExp( "farming", math.ceil( ply.level[ "farming" ] * 45 ) )
		ply:SendNeeds()
		ply:AddStat("farming3", 1)
		ply:CheckForAchievements("farminghat")
		return
	
	end
	
	ply:AddStat("general2", 1)
	
	ply:SendMessage("You feel less hungry!", 60, Color(255, 255, 0, 255))
	local torestore = math.floor(SGS.Seeds[ "fruit" ][lvl].eatheal * size)
	if ply.needs["hunger"] + torestore >= ply.maxneeds then
		ply.needs["hunger"] = ply.maxneeds
	else
		ply.needs["hunger"] = ply.needs["hunger"] + torestore
	end
	ply:SendNeeds()
	
	if math.random(1,5) >= 4 then
		local ftype = SGS.Seeds[ "fruit" ][lvl].title
		ply:SendMessage("You found some " .. SGS.Seeds[ "fruit" ][lvl].title .."s!", 60, Color(0, 255, 0, 255))
		ply:AddResource( SGS.Seeds[ "fruit" ][lvl].resource, 1 )
	end
	
	if math.random(1,100) <= 3 then
		ply:SetSick(math.random(8,12))
		ply:AddStat( "general4", 1 )
	end
end


-----------------
---Eating Food---
-----------------

function SGS_Eat_Start(ply, len, food)
	if ply.inprocess == true then
		return
	end
	
	if ply.amode then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't eat while dead.",3,Color(255,0,0,255))
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.processtype = "eating"
	
	local txt = "Eating..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Eat_Stop( ply, food ) end )

end

function SGS_Eat_Stop(ply, food)

	if not ply:IsValid() then return end

	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")

	local sound = {"npc/barnacle/barnacle_crunch2.wav", "npc/barnacle/barnacle_crunch3.wav"}
	ply:EmitSound(sound[math.random(#sound)], 60, math.random(80,120))
	
	local hun = food.eatheal
	
	ply:SendMessage("You feel less hungry!", 60, Color(255, 255, 0, 255))
	if ply.needs["hunger"] + hun >= ply.maxneeds then
		ply.needs["hunger"] = ply.maxneeds
	else
		ply.needs["hunger"] = ply.needs["hunger"] + hun
	end
	ply:SubResource( food.name, 1 )
	ply:SendNeeds()
	ply:ConCommand("sgs_refreshhotbar")
end


-------------
--Foraging--
-------------

function SGS_Forage_Start(ply, len, modi, void)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/wood/wood_strain2.wav", "physics/wood/wood_strain4.wav" }
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "gathering"
	
	local txt = "Foraging..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "farming" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Forage_Stop(ply, modi, void) end )

end

function SGS_Forage_Stop(ply, modi, void)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "farming" ] == nil then
		ply:SendMessage("CRITICAL ERROR #001. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	
	
	local lvlmodi = ( ply.level[ "farming" ] * 0.05 ) + 1
	
	if ( math.random( 1, 100 ) * modi ) * lvlmodi >= 45 then
		if not void then
			/* check to see if we found a relic instead of a seed */
			if math.random(1, 700) == 1 then
				ply:FoundRelic()
				return --Break out of the function so we don't find a seed as well
			end
			
			/* check to see if we found an artifact */
			if math.random(1, 700) == 1 then
				ply:FoundArtifact()
				return --Break out of the function so we don't find a seed as well
			end
		end
		
		local stype = math.random(1,4)
		local stable = {}
		
		if stype <= 3 then
			local stype2 = math.random(1,32)
			
			if stype2 <= 7 then
				stable["name"] = "pypa_seed"
				stable["title"] = "Pypa Seeds"
				stable["maxfind"] = 2
				stable["expbase"] = 2
			elseif stype2 > 7 and stype2 <= 13 then
				stable["name"] = "guacca_seed"
				stable["title"] = "Guacca Seeds"
				stable["maxfind"] = 2
				stable["expbase"] = 4
			elseif stype2 > 13 and stype2 <= 18 then
				stable["name"] = "arctus_seed"
				stable["title"] = "Arctus Seeds"
				stable["maxfind"] = 2
				stable["expbase"] = 6
			elseif stype2 > 18 and stype2 <= 22 then
				stable["name"] = "liechi_seed"
				stable["title"] = "Liechi Seeds"
				stable["maxfind"] = 2
				stable["expbase"] = 12
			elseif stype2 > 22 and stype2 <= 25 then
				stable["name"] = "lum_seed"
				stable["title"] = "Lum Seeds"
				stable["maxfind"] = 1
				stable["expbase"] = 16
			elseif stype2 > 25 and stype2 <= 27 then
				stable["name"] = "perriot_seed"
				stable["title"] = "Perriot Seeds"
				stable["maxfind"] = 1
				stable["expbase"] = 22
			elseif stype2 > 27 and stype2 <= 29 then
				stable["name"] = "pallie_seed"
				stable["title"] = "Pallie Seeds"
				stable["maxfind"] = 1
				stable["expbase"] = 26
			elseif stype2 > 29 and stype2 <= 31 then
				stable["name"] = "moly_seed"
				stable["title"] = "Moly Seeds"
				stable["maxfind"] = 1
				stable["expbase"] = 35
			elseif stype2 > 31 then
				stable["name"] = "karopa_seed"
				stable["title"] = "Karopa Seeds"
				stable["maxfind"] = 1
				stable["expbase"] = 50
			end	
		else
			local stype2 = math.random(1,4)
			
			if stype2 <= 3 then
				stable["name"] = "wheat_seed"
				stable["title"] = "Wheat Seeds"
				stable["maxfind"] = 2
				stable["expbase"] = 12
			else
				stable["name"] = "liferoot_seed"
				stable["title"] = "Liferoot Seeds"
				stable["maxfind"] = 2
				stable["expbase"] = 12
			end
		end
		if void then
			ply:AddExp( "farming", math.ceil( stable["expbase"] * 2.5 / 10 ) )
		else
			ply:AddExp( "farming", math.ceil( stable["expbase"] * modi / 10 ) )
		end
		ply:SendMessage("You found some " .. stable["title"] .. "!", 60, Color(0, 255, 0, 255))
		local tofind = math.random(1,stable["maxfind"])
		ply:AddResource( stable["name"], tofind )
		ply:AddStat( "farming2", tofind )
		ply:ConCommand("sgs_refreshfarming")
	else
		ply:SendMessage("You were unable to obtain anything useful.", 60, Color(255, 255, 255, 255))
	end
	ply:CheckBot()
	
	if not void then
		/* check to see if we found an egg */
		chance = 800
		if ply.luck then
			local luck = 150
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundEgg()
		end
	end
end

--------------
--Harvesting--
--------------

function SGS_Harvest_Start(ply, len, plant)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if not IsValid(plant) then
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/wood/wood_strain2.wav", "physics/wood/wood_strain4.wav" }
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "harvest"
	
	local txt = "Harvesting..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "farming" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Harvest_Stop(ply, plant) end )

end

function SGS_Harvest_Stop(ply, plant)

	if not ply:IsValid() then return end
	
	if not IsValid(plant) then
		ply:Freeze( false )
		ply.inprocess = false
	ply.processtype = "idle"
		ply:SetNWString("action", "Idle")
		ply.ps = false
		ply:SendMessage("There is nothing left to harvest.", 60, Color(255, 0, 0, 255))
		return
	end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "farming" ] == nil then
		ply:SendMessage("CRITICAL ERROR #001. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	
	
	local lvlmodi = ( ply.level[ "farming" ] * 0.05 ) + 1
	
	if math.random( 1, 100 ) * lvlmodi >= 30 then
		
		/* check to see if we found a relic instead of a seed */
		if math.random(1, 650) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, 650) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		ply:AddExp( "farming", math.ceil( 35 ) )
		ply:SendMessage("You harvested some " .. CapAll(string.gsub(plant.harvest, "_", " ")) .. "!", 60, Color(0, 255, 0, 255))
		ply:AddResource( plant.harvest, 1 )
		if plant.rtotal == nil then
			plant.rtotal = 1
		end
		plant.rtotal = plant.rtotal - 1
				
		if math.random(1,10) == 1 then
			ply:SendMessage("You found a " .. CapAll(string.gsub(plant.seed, "_", " ")) .. ".", 60, Color(0, 255, 0, 255))
			ply:AddResource( plant.seed, 1 )
		end
		ply:ConCommand("sgs_refreshfarming")
	else
		ply:SendMessage("Your harvest failed.", 60, Color(255, 0, 0, 255))
		if plant.rtotal == nil then
			plant.rtotal = 1
		end
		plant.rtotal = plant.rtotal - 1
	end
	ply:CheckBot()
	ply:RandomFindChance()
end

-------------
--Build Prop--
-------------

function SGS_BuildProp_Start(ply, len, item)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if GAMEMODE.Worlds:GetEntityWorldSpace( ply ).SpawningItemsBlocked then
		ply:SendMessage("Spawning Items in the Arena is prohibited.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not ply:CanBuildProp() then
		ply:SendMessage("You have reached your max prop limit.", 60, Color(255, 0, 0, 255))
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/metal/metal_solid_impact_soft1.wav", "physics/metal/metal_solid_impact_soft2.wav", "physics/metal/metal_solid_impact_soft3.wav" }
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "build"
	
	if ply.equippedtool == "gms_hammer" then
		len = math.floor(len / 2)
	end
	
	local txt = "Constructing..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "construction" )
		
	local tr = ply:GetEyeTrace()
	
	local ent
	if item.ischair then
		ent = ents.Create("prop_vehicle_prisoner_pod")
		local data = list.Get( "Vehicles" )["Seat_Jeep"]
        if data.KeyValues then
            for k, v in pairs( data.KeyValues ) do
                ent:SetKeyValue( k, v )
            end
        end
	else
		ent = ents.Create("gms_prop")
	end
	ent:SetPos(ply:TraceFromEyes(200).HitPos + Vector(0,0,10))
	if item.uid == "decor9" then
		local model = SGS.MotivationalPosters[math.random(1,#SGS.MotivationalPosters)]
		ent:SetModel(model)
	elseif item.uid == "decor10" then
		local model = SGS.Paintings[math.random(1,#SGS.Paintings)]
		ent:SetModel(model)
	else
		ent:SetModel(item.model)
	end
	
	ent:SetAngles(ply:GetAngles())
	if item.color then
		c = item.color
	else
		c = Color(255,255,255,255)
	end
	ent:SetColor(Color(c.r,c.g,c.b,0))
	ent.permcolor = Color(c.r, c.g, c.b, 255)
	ent.ToTime = len
	ent:Spawn()
	ent:SetMaterial("models/wireframe")
	local phys = ent:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false) -- Freezes the object in place.
	end
	ent.uid = item.uid
	ply.buildent = ent
	--SPP MAKE PLAYER OWNER--
	ent:CPPISetOwner(ply)
	-------------------------
	
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_BuildProp_Stop( ply, ent, item ) end )

end

function SGS_BuildProp_Stop(ply, ent, item)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "construction" ] == nil then
		ply:SendMessage("CRITICAL ERROR #009. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	ent:SetMaterial("")
	
	if item.xp > 0 then
	
		ply:AddExp( "construction", item.xp )
		ply:AddStat( "construction1", 1 )
		ply:CheckForAchievements("constructionmaster")
		
		for k, v in pairs( item.cost ) do
			ply:SubResource( k, v )
		end
	
		chance = 800
		if ply.luck then
			local luck = 150
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundGrayEgg()
		end

		--ent:GetPhysicsObject():Wake()
		ply:RandomFindChance()
	end
	ply.buildent = nil
	ply:SendPropCount()
end

--------------------
--Deconstruct Prop--
--------------------

function SGS_UnBuildProp_Start(ply, len, item)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/metal/metal_solid_impact_soft1.wav", "physics/metal/metal_solid_impact_soft2.wav", "physics/metal/metal_solid_impact_soft3.wav" }
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "unbuild"
	
	local txt = "Deconstructing..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "construction" )
		
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_UnBuildProp_Stop( ply, ent, item ) end )

end

function SGS_UnBuildProp_Stop(ply, ent, item)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if not item:IsValid() then
		ply:SendMessage("The prop no longer exists.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "construction" ] == nil then
		ply:SendMessage("CRITICAL ERROR #009. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	SGS_ReturnRes( ply, item.uid )
	ply:AddStat( "construction2", 1 )
	SGS.Log("** " .. item:GetClass() .. " was deconstructed by " .. ply:Nick() .. "!")
	item:Remove()
	ply:SendPropCount()
	
end


-------------------
--Build Structure--
-------------------

function SGS_BuildStructure_Start(ply, len, item, packaged)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if GAMEMODE.Worlds:GetEntityWorldSpace( ply ).RestrictBuild then
		ply:SendMessage("Spawning Items in the Arena is prohibited.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not ply:CanBuildStructure() then
		ply:SendMessage("You have reached your max structure limit.", 60, Color(255, 0, 0, 255))
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/metal/metal_solid_impact_soft1.wav", "physics/metal/metal_solid_impact_soft2.wav", "physics/metal/metal_solid_impact_soft3.wav" }
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "build"
	
	if ply.equippedtool == "gms_hammer" then
		len = math.floor(len / 2)
	end
	 
	
	local txt = "Constructing..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "construction" )
		
	if not packaged then
		local tr = ply:GetEyeTrace()
		
		local ent = ents.Create(item.ent)
		local trace = ply:TraceFromEyes(200)
		ent:SetPos(trace.HitPos + trace.HitNormal * 32)
		ent:SetAngles(ply:GetAngles()  + Angle( 0, 180, 0 ))
		ent:SetColor(Color(255,255,255,0))
		ent.ToTime = len
		ent.POwner = ply
		ent.POwner64 = ply:GetPlayerID()
		ent:Spawn()
		ent:SetMaterial("models/wireframe")
		local phys = ent:GetPhysicsObject()
		if phys and phys:IsValid() then
			phys:EnableMotion(false) -- Freezes the object in place.
		end
		ply.buildent = ent
		--SPP MAKE PLAYER OWNER--
		ent:CPPISetOwner(ply)
		-------------------------
		timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_BuildStructure_Stop( ply, ent, item, packaged ) end )
	else
		timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_BuildStructure_Stop( ply, _, item, packaged ) end )
	end
	

end

function SGS_BuildStructure_Stop(ply, ent, item, packaged)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "construction" ] == nil then
		ply:SendMessage("CRITICAL ERROR #010. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	ply:AddExp( "construction", item.xp )
	ply:AddStat( "construction3", 1 )

	chance = 800
	if ply.luck then
		local luck = 150
		luck = luck * ply.luck
		chance = chance - luck
	end	
	if math.random(1, chance) == 1 then
		ply:FoundGrayEgg()
	end
	
	for k, v in pairs( item.cost ) do
		ply:SubResource( k, v )
	end
	
	if not packaged then
		if ent.mat then
			ent:SetMaterial( ent.mat )
		else
			ent:SetMaterial("")
		end
		
		SGS.Log("**" .. ent:GetClass() .. " was constructed by " .. ply:Nick() .. "!")
	else
		ply:AddResource( item.ent, 1 )
	end
	
	ply:RandomFindChance()
	ply.buildent = nil
	ply:SendStructureCount()
end

--------------------
--Unpack Structure--
--------------------

function SGS_UnpackStructure_Start(ply, len, item)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if GAMEMODE.Worlds:GetEntityWorldSpace( ply ).RestrictUnpack then
		if not table.HasValue( GAMEMODE.Worlds:GetEntityWorldSpace( ply ).AllowedUnpackEntities, item ) then
			ply:SendMessage("Spawning Items in the Arena is prohibited.", 60, Color(255, 0, 0, 255))
			return
		end
	end
	
	if not ply:CanBuildStructure() then
		ply:SendMessage("You have reached your max structure limit.", 60, Color(255, 0, 0, 255))
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/metal/metal_solid_impact_soft1.wav", "physics/metal/metal_solid_impact_soft2.wav", "physics/metal/metal_solid_impact_soft3.wav" }
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "build"
	
	if ply:HasTool( "gms_hammer" ) then
		len = math.ceil(len - 1)
	end
	 
	
	local txt = "Unpacking Structure..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "construction" )
		
	local tr = ply:GetEyeTrace()
	
	local ent = ents.Create(item)
	local trace = ply:TraceFromEyes(200)
	ent:SetPos(trace.HitPos + trace.HitNormal * 32)
	ent:SetAngles(ply:GetAngles()  + Angle( 0, 180, 0 ))
	ent:SetColor(Color(255,255,255,0))
	ent.ToTime = len
	ent.POwner = ply
	ent.POwner64 = ply:GetPlayerID()
	ent:Spawn()
	local phys = ent:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:EnableMotion(false) -- Freezes the object in place.
	end
	ply.buildent = ent
	--SPP MAKE PLAYER OWNER--
	ent:CPPISetOwner(ply)
	-------------------------
	
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_UnpackStructure_Stop( ply, ent, item ) end )

end

function SGS_UnpackStructure_Stop(ply, ent, item)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	ply:SubResource( item , 1 )
	SGS.Log("**" .. ent:GetClass() .. " was un-packaged by " .. ply:Nick() .. "!")
	ply.buildent = nil
	ply:SendStructureCount()
	
end

-------------
---Fishing---
-------------

function SGS_Fish_Start(ply, len, modi, void)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end

	if not ply:CheckWater(800) then return end
	ply:Freeze( true )
	ply.inprocess = true
	ply.processtype = "fishing"
	
	local trace = {}
	trace.start = ply:GetShootPos()
	trace.endpos = trace.start + (ply:GetAimVector() * 400)
	trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
	trace.filter = ply

	local tr = util.TraceLine(trace)
	
	local effectdata = EffectData()
	effectdata:SetStart( tr.HitPos )
	effectdata:SetOrigin( tr.HitPos )
	effectdata:SetScale( 2 )
	util.Effect( "waterripple", effectdata )
	
	
	
	
	local txt = "Fishing..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "fishing" )
	ply:SendMessage("You cast out your line...", 60, Color(255, 255, 0, 255))
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Fish_Stop( ply, modi, void ) end )

end

function SGS_Fish_Stop(ply, modi, void)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "fishing" ] == nil then
		ply:SendMessage("CRITICAL ERROR #011. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	local lvlmodi = ( ply.level[ "fishing" ] * 0.05 ) + 1
	
	local chance = ( math.random(1,100) * modi ) * lvlmodi
	
	if chance >= 60 then		
		/* check to see if we found a relic instead of a seed */
		if math.random(1, 600) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, 600) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end

		chance = 800
		if ply.luck then
			local luck = 150
			luck = luck * ply.luck
			chance = chance - luck
		end
		if math.random(1, chance) == 1 then
			ply:FoundGreenEgg()
		end
	
		ply:SendMessage("You feel a tug on your line!", 60, Color(255, 255, 0, 255))
		local fnum = 0
		for k, v in pairs(SGS.Fish) do
			if ply:GetLevel( "fishing" ) >= v.reqlvl then
				fnum = fnum + 1
			else
				break
			end
		end
		fnum = math.ceil(fnum * 1.5)
		local catch = SGS.Fish[math.Clamp(math.random( 1, fnum ), 1, #SGS.Fish)]
		if catch.reqlvl <= ply:GetLevel( "fishing" ) then
			ply:SendMessage("You caught a " .. CapAll(string.gsub(catch.name, "_", " ")) .. "!", 60, Color(0, 255, 0, 255))
			ply:AddExp( "fishing", catch.xp )
			ply:AddResource( catch.name, 1 )
			ply:AddStat( "fishing1", 1 )
			ply:CheckForAchievements("fishmaster")
		else
			ply:SendMessage("The fish got away!", 60, Color(255, 0, 0, 255))
			ply:AddStat( "fishing2", 1 )
		end
		
		local trace = {}
		trace.start = ply:GetShootPos()
		trace.endpos = trace.start + (ply:GetAimVector() * 400)
		trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
		trace.filter = ply

		local tr = util.TraceLine(trace)
		
		local effectdata = EffectData()
		effectdata:SetStart( tr.HitPos ) // not sure if we need a start and origin (endpoint) for this effect, but whatever
		effectdata:SetOrigin( tr.HitPos )
		effectdata:SetScale( 5 )
		util.Effect( "watersplash", effectdata )
		util.Effect( "waterripple", effectdata )
	
	else
		ply:SendMessage("Not even a nibble...", 60, Color(255, 255, 0, 255))
	end
	ply:CheckBot()
	if not void then
		ply:RandomFindChance()
	end
end

----------------------
---Advanced Fishing---
----------------------

function SGS_AdvancedFish_Start(ply, len, modi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end

	if not ply:CheckWater(800) then return end
	ply:Freeze( true )
	ply.inprocess = true
	ply.processtype = "fishing"
	
		local trace = {}
		trace.start = ply:GetShootPos()
		trace.endpos = trace.start + (ply:GetAimVector() * 400)
		trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
		trace.filter = ply

		local tr = util.TraceLine(trace)
		
		local effectdata = EffectData()
		effectdata:SetStart( tr.HitPos ) // not sure if we need a start and origin (endpoint) for this effect, but whatever
		effectdata:SetOrigin( tr.HitPos )
		effectdata:SetScale( 2 )
		util.Effect( "waterripple", effectdata )
	
	
	
	
	local txt = "Fishing..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "fishing" )
	ply:SendMessage("You cast out your line...", 60, Color(255, 255, 0, 255))
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_AdvancedFish_Stop( ply, modi ) end )

end

function SGS_AdvancedFish_Stop(ply, modi)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "fishing" ] == nil then
		ply:SendMessage("CRITICAL ERROR #011. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	local lvlmodi = ( ply.level[ "fishing" ] * 0.05 ) + 1
	
	local chance = ( math.random(1,100) * modi ) * lvlmodi
	
	if chance >= 60 then		
		/* check to see if we found a relic instead of a seed */
		if math.random(1, 600) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, 600) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
	
		ply:SendMessage("You feel a tug on your line!", 60, Color(255, 255, 0, 255))
		local catch = SGS.Fish[math.random(6,10)]
		if catch.areqlvl <= ply:GetLevel( "fishing" ) then
			ply:SendMessage("You caught a " .. CapAll(string.gsub(catch.name, "_", " ")) .. "!", 60, Color(0, 255, 0, 255))
			ply:AddExp( "fishing", catch.xp )
			ply:AddResource( catch.name, 1 )
			ply:AddStat( "fishing1", 1 )
			ply:CheckForAchievements("fishmaster")
		else
			ply:SendMessage("The fish got away!", 60, Color(255, 0, 0, 255))
			ply:AddStat( "fishing2", 1 )
		end
		
		local trace = {}
		trace.start = ply:GetShootPos()
		trace.endpos = trace.start + (ply:GetAimVector() * 400)
		trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
		trace.filter = ply

		local tr = util.TraceLine(trace)
		
		local effectdata = EffectData()
		effectdata:SetStart( tr.HitPos ) // not sure if we need a start and origin (endpoint) for this effect, but whatever
		effectdata:SetOrigin( tr.HitPos )
		effectdata:SetScale( 5 )
		util.Effect( "watersplash", effectdata )
		util.Effect( "waterripple", effectdata )
	
	else
		ply:SendMessage("Not even a nibble...", 60, Color(255, 255, 0, 255))
	end
	ply:CheckBot()
	ply:RandomFindChance()
end



-------------
---Sifting---
-------------

function SGS_Sift_Start(ply, len, modi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end

	ply:Freeze( true )
	ply.inprocess = true
	ply.sound = CreateSound(ply, "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav")
	ply.sound:Play()
	ply.processtype = "gathering"
	
	
	local txt = "Sifting..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len )
	ply:SendMessage("You sift through the sand..", 60, Color(255, 255, 0, 255))
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Sift_Stop( ply, modi ) end )

end

function SGS_Sift_Stop(ply, modi)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.sound:Stop()
	
	local chance = ( math.random(1,100) * modi )
	
	if chance >= 40 then		
		/* check to see if we found a relic instead of a seed */
		if math.random(1, 800) == 1 then
			ply:FoundRelic()
			return --Break out of the function so we don't find a seed as well
		end
		
		/* check to see if we found an artifact */
		if math.random(1, 800) == 1 then
			ply:FoundArtifact()
			return --Break out of the function so we don't find a seed as well
		end
		ply:SendMessage("You collected some pure sand!", 60, Color(0, 255, 0, 255))
		ply:AddResource( "sand", math.random(1,3) )
	else
		ply:SendMessage("This sand is too impure.", 60, Color(255, 255, 0, 255))
	end
	ply:CheckBot()
	--ply:RandomFindChance()
end


--------------
---Smelting---
--------------

function SGS_Smelt_Start(ply, len, ore, modi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	trace = ply:TraceFromEyes(100)
	
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to be at a furnace to smelt!", 60, Color(255, 0, 0, 255))
		return
	end
	
	if trace.Entity:GetClass() == "gms_furnace" then
		ply:Freeze( true )
		ply.inprocess = true
		ply.sound = CreateSound(ply, "ambient/fire/fire_big_loop1.wav")
		ply.sound:Play()
		ply.processtype = "smelting"
		
		local txt = "Smelting..."
		ply:SetNWString("action", txt)
		SGS_StartTimer( ply, txt, len, "smithing" )
		timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Smelt_Stop( ply, ore, modi ) end )
	else
		ply:SendMessage("You need to be at a furnace to smelt!", 60, Color(255, 0, 0, 255))
	end
	


end

function SGS_Smelt_Stop(ply, ore, modi)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.sound:Stop()
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "smithing" ] == nil then
		ply:SendMessage("CRITICAL ERROR #013. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	local lvlmodi = ( ply.level[ "smithing" ] * 0.05 ) + 1
	
	local chance = ( math.random( 1, 100 ) * modi ) * lvlmodi
	
	if chance > 35 then
		ply:SendMessage("You smelted " .. CapAll(string.gsub(ore.title, "_", " ")) .. "!", 60, Color(0, 255, 0, 255))
		ply:AddExp( "smithing", ore.xp )
		for k, v in pairs(ore.gives) do
			ply:AddResource( k, v )
			ply:AddStat( "smithing2", v )
			ply:CheckForAchievements("smithingmaster")
		end
		for k, v in pairs( ore.cost ) do
			ply:SubResource( k, v )
		end	
	else
		ply:SendMessage("The " .. CapAll(string.gsub(ore.title, "_", " ")) .. " came out too impure!", 60, Color(255, 0, 0, 255))
		for k, v in pairs( ore.cost ) do
			local tolose = math.random(math.ceil(v/2), v)
			ply:SubResource( k, tolose )
			ply:AddStat( "smithing3", tolose )
		end
	end
	ply:RandomFindChance()
end

--------------------
---Arcane Forging---
--------------------

function SGS_ArcaneForge_Start(ply, len, stone, modi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	trace = ply:TraceFromEyes(100)
	
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to be at an arcane forge!", 60, Color(255, 0, 0, 255))
		return
	end
	
	if trace.Entity:GetClass() == "gms_arcaneforge" then
		ply:Freeze( true )
		ply.inprocess = true
		ply.sound = CreateSound(ply, "ambient/fire/fire_big_loop1.wav")
		ply.sound:Play()
		ply.processtype = "forging"
		trace.Entity:CreateForgeEffect( len - 0.3 ) 
		
		local txt = "Forging..."
		ply:SetNWString("action", txt)
		SGS_StartTimer( ply, txt, len, "arcane" )
		timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_ArcaneForge_Stop( ply, stone, modi ) end )
	else
		ply:SendMessage("You need to be at an arcane forge!", 60, Color(255, 0, 0, 255))
	end
	


end

function SGS_ArcaneForge_Stop(ply, stone, modi)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.sound:Stop()
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "arcane" ] == nil then
		ply:SendMessage("CRITICAL ERROR #013. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end

	ply:SendMessage("You performed " .. CapAll(string.gsub(stone.title, "_", " ")) .. "!", 60, Color(0, 255, 0, 255))
	ply:AddExp( "arcane", stone.xp )
	
	
	local mply = 1
	if ply:GetLevel( "arcane" ) >= stone.spclvl[ "double" ] then mply = 2 end
	if ply:GetLevel( "arcane" ) >= stone.spclvl[ "triple" ] then mply = 3 end
	
	for k, v in pairs(stone.gives) do
		ply:AddResource( k, v * mply )
		ply:AddStat( "arcane4", v * mply )
	end
	
	for k, v in pairs( stone.cost ) do
		ply:SubResource( k, v )
	end	

	ply:RandomFindChance()
end

---------------
---First Aid---
---------------

function SGS_AidCraft_Start(ply, len, potion, modi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	trace = ply:TraceFromEyes(100)
	
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to be at an aid workstation to craft!", 60, Color(255, 0, 0, 255))
		return
	end
	
	if trace.Entity:GetClass() == "gms_aidbench" then
		ply:Freeze( true )
		ply.inprocess = true
		ply.processtype = "crafting"
		
		local txt = "Crafting..."
		ply:SetNWString("action", txt)
		SGS_StartTimer( ply, txt, len, "alchemy" )
		timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_AidCraft_Stop( ply, potion, modi ) end )
	else
		ply:SendMessage("You need to be at anaid workstation to craft!", 60, Color(255, 0, 0, 255))
	end
	


end

function SGS_AidCraft_Stop(ply, recipee, modi)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "alchemy" ] == nil then
		ply:SendMessage("CRITICAL ERROR #013. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	local lvlmodi = ( ply.level[ "alchemy" ] * 0.05 ) + 1
	
	local chance = ( math.random( 1, 100 ) * modi ) * lvlmodi
	
	if chance > 30 then
		ply:SendMessage("You crafted a/an " .. CapAll(string.gsub(recipee.title, "_", " ")) .. "!", 60, Color(0, 255, 0, 255))
		ply:AddExp( "alchemy", recipee.xp )
		ply:AddStat( "alchemy1", 1 )
		for k, v in pairs(recipee.gives) do
			ply:AddResource( k, v )
		end
		for k, v in pairs( recipee.cost ) do
			ply:SubResource( k, v )
		end	
	else
		ply:SendMessage("The " .. CapAll(string.gsub(recipee.title, "_", " ")) .. " didn't turn out quite right!", 60, Color(255, 0, 0, 255))
		for k, v in pairs( recipee.cost ) do
			ply:SubResource( k, math.random(math.ceil(v/2), v) )
		end
	end
	ply:RandomFindChance()
end


-------------
---Brewing---
-------------

function SGS_Brew_Start(ply, len, potion, modi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	trace = ply:TraceFromEyes(100)
	
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to be at a potions lab to brew!", 60, Color(255, 0, 0, 255))
		return
	end
	
	if trace.Entity:GetClass() == "gms_alchlab" then
		ply:Freeze( true )
		ply.inprocess = true
		ply.sound = CreateSound(ply, "ambient/fire/fire_big_loop1.wav")
		ply.sound:Play()
		ply.processtype = "brewing"
		
		local txt = "Brewing..."
		ply:SetNWString("action", txt)
		SGS_StartTimer( ply, txt, len, "alchemy" )
		timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Brew_Stop( ply, potion, modi ) end )
	else
		ply:SendMessage("You need to be at a potions lab to brew!", 60, Color(255, 0, 0, 255))
	end
	


end

function SGS_Brew_Stop(ply, potion, modi)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.sound:Stop()
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "alchemy" ] == nil then
		ply:SendMessage("CRITICAL ERROR #013. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	local lvlmodi = ( ply.level[ "alchemy" ] * 0.05 ) + 1
	
	local chance = ( math.random( 1, 100 ) * modi ) * lvlmodi
	
	if chance > 30 then
		ply:SendMessage("You brewed a/an " .. CapAll(string.gsub(potion.title, "_", " ")) .. "!", 60, Color(0, 255, 0, 255))
		ply:AddExp( "alchemy", potion.xp )
		ply:AddStat( "alchemy1", 1 )
		for k, v in pairs(potion.gives) do
			ply:AddResource( k, v )
		end
		for k, v in pairs( potion.cost ) do
			ply:SubResource( k, v )
		end	
	else
		ply:SendMessage("The " .. CapAll(string.gsub(potion.title, "_", " ")) .. " failed to brew!", 60, Color(255, 0, 0, 255))
		for k, v in pairs( potion.cost ) do
			ply:SubResource( k, math.random(math.ceil(v/2), v) )
		end
	end
	ply:RandomFindChance()
end


-----------------
---Transmuting---
-----------------

function SGS_XMute_Start(ply, len, recipee, modi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	trace = ply:TraceFromEyes(100)
	
	
	if not ply.equippedtool == "gms_alchemystone" then
		ply:SendMessage("You need to have your Alchemist's Stone equipped!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local ent = ents.Create("gms_alchorb")
		local trace = ply:TraceFromEyes(200)
		ent:SetPos((ply:GetPos() + (ply:GetForward() * 40)) + Vector(0,0,64))
		ent:SetColor(Color(255,0,0,255))
	ent:Spawn()

	
	ply:Freeze( true )
	ply.inprocess = true
	ply.sound = CreateSound(ply, "ambient/machines/combine_shield_loop3.wav")
	ply.sound:Play()
	ply.processtype = "xmute"
		
	local txt = "Transmuting..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "alchemy" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_XMute_Stop( ply, recipee, modi ) end )

end

function SGS_XMute_Stop(ply, recipee, modi)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.sound:Stop()
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "alchemy" ] == nil then
		ply:SendMessage("CRITICAL ERROR #013. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	local lvlmodi = ( ply.level[ "alchemy" ] * 0.05 ) + 1
	
	local chance = ( math.random( 1, 100 ) * modi ) * lvlmodi
	
	if recipee.uid == "core1" then chance = 100 end -- Don't want a GToken item to fail.
	
	if chance > 20 then
		if recipee.uid == "artifact1" then
			ply:IdentifyArtifact()
			ply:AddExp( "alchemy", recipee.xp )
			ply:AddStat( "alchemy3", 1 )
			for k, v in pairs( recipee.cost ) do
				ply:SubResource( k, v )
			end	
		else
			ply:SendMessage("You transmuted a/an " .. recipee.stitle .. "!", 60, Color(0, 255, 0, 255))
			ply:AddExp( "alchemy", recipee.xp )
			ply:AddStat( "alchemy4", 1 )
			ply:CheckForAchievements("alchemymaster")
			for k, v in pairs( recipee.cost ) do
				ply:SubResource( k, v )
			end	
			for k, v in pairs( recipee.gives ) do
				ply:AddResource( k, v )
			end
		end
	else
		ply:SendMessage("Your transmute failed!", 60, Color(255, 0, 0, 255))
		for k, v in pairs( recipee.cost ) do
			ply:SubResource( k, math.random(math.ceil(v/2), v) )
		end
	end
	ply:RandomFindChance()
end

----------------
----Grinding----
----------------

function SGS_Grind_Start(ply, len, recipee, modi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	trace = ply:TraceFromEyes(100)
	
	
	if not ply.equippedtool == "gms_grindingstone" then
		ply:SendMessage("You need to have your Grinding Stone equipped!", 60, Color(255, 0, 0, 255))
		return
	end
	
	local ent = ents.Create("gms_alchorb")
		local trace = ply:TraceFromEyes(200)
		ent:SetPos((ply:GetPos() + (ply:GetForward() * 40)) + Vector(0,0,64))
	ent:Spawn()
	ent:SetColor(Color(141,141,141,255))

	
	ply:Freeze( true )
	ply.inprocess = true
	ply.sound = CreateSound(ply, "ambient/materials/rock1.wav")
	ply.sound:Play()
	ply.processtype = "grind"
		
	local txt = "Grinding..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "smithing" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Grind_Stop( ply, recipee, modi ) end )

end

function SGS_Grind_Stop(ply, recipee, modi)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.sound:Stop()
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "smithing" ] == nil then
		ply:SendMessage("CRITICAL ERROR #013. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	local lvlmodi = ( ply.level[ "smithing" ] * 0.05 ) + 1
	
	local chance = ( math.random( 1, 100 ) * modi ) * lvlmodi
	
	if chance > 20 then
		local amt = math.random(1,3)
	
		ply:SendMessage("You created (" .. tostring(amt) .. "x) " .. recipee.stitle .. "!", 60, Color(0, 255, 0, 255))
		ply:AddExp( "smithing", recipee.xp )
		for k, v in pairs( recipee.cost ) do
			ply:SubResource( k, v )
			ply:AddStat( "smithing4", v )
		end	
		for k, v in pairs( recipee.gives ) do
			ply:AddResource( k, amt * v )
		end
	else
		ply:SendMessage("The ore was too impure!", 60, Color(255, 0, 0, 255))
		for k, v in pairs( recipee.cost ) do
			local tolose = math.random(math.ceil(v/2), v)
			ply:SubResource( k, tolose )
			ply:AddStat( "smithing3", tolose )
		end
	end
	ply:RandomFindChance()
end

--------------
---Smithing---
--------------

function SGS_Smith_Start(ply, len, tool, modi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	trace = ply:TraceFromEyes(100)
	
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to be at a workbench to smith!", 60, Color(255, 0, 0, 255))
		return
	end
		
	if ply.equippedtool == "gms_hammer" then
		len = math.floor(len / 2)
	end
	
	if trace.Entity:GetClass() == "gms_workbench" or trace.Entity:GetClass() == "gms_workbench2" then
		ply:Freeze( true )
		ply.inprocess = true
		ply.stable = { "physics/metal/metal_solid_impact_soft1.wav", "physics/metal/metal_solid_impact_soft2.wav", "physics/metal/metal_solid_impact_soft3.wav" }
		ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
		ply.ps = true
		ply.processtype = "smithing"
		
		local txt = "Smithing..."
		ply:SetNWString("action", txt)
		SGS_StartTimer( ply, txt, len, "smithing" )
		timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Smith_Stop( ply, tool, modi ) end )
	else
		ply:SendMessage("You need to be at a workbench to smith!", 60, Color(255, 0, 0, 255))
	end
	


end

function SGS_Smith_Stop(ply, tool, modi)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "smithing" ] == nil then
		ply:SendMessage("CRITICAL ERROR #014. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	ply:SendMessage("You created a " .. CapAll(string.gsub(tool.title, "_", " ")) .. "!", 60, Color(0, 255, 0, 255))
	ply:AddExp( "smithing", tool.xp )
	
	ply:AddTool( tool.entity )
	ply:AddStat( "smithing1", 1 )
	
	for k, v in pairs( tool.cost ) do
		ply:SubResource( k, v )
	end
	ply:RandomFindChance()
	
end

--------------
---Gem Tool---
--------------

function SGS_GemTool_Start(ply, len, tool, modi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	trace = ply:TraceFromEyes(100)
	
	if not IsValid(trace.Entity) then
		ply:SendMessage("You need to be at a gemming table to gem a tool!", 60, Color(255, 0, 0, 255))
		return
	end
	
	if trace.Entity:GetClass() == "gms_gemtable" then
		ply:Freeze( true )
		ply.inprocess = true
		ply.stable = { "physics/metal/metal_solid_impact_soft1.wav", "physics/metal/metal_solid_impact_soft2.wav", "physics/metal/metal_solid_impact_soft3.wav" }
		ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
		ply.ps = true
		ply.processtype = "gemming"
		
		local txt = "Gemming Tool..."
		ply:SetNWString("action", txt)
		SGS_StartTimer( ply, txt, len, "smithing" )
		timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_GemTool_Stop( ply, tool, modi ) end )
	else
		ply:SendMessage("You need to be at a gemming table to gem a tool!", 60, Color(255, 0, 0, 255))
	end
	


end

function SGS_GemTool_Stop(ply, tool, modi)

	if not ply:IsValid() then return end
	
	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	if ply.level == nil then
		ply:SendMessage("CRITICAL ERROR #100. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	if ply.level[ "smithing" ] == nil then
		ply:SendMessage("CRITICAL ERROR #014. Please report this error code.", 60, Color(255, 0, 0, 255))
		return
	end
	
	if not ply:HasToolInventory( tool.entity2 ) then
		can = false
		ply:SendMessage("If it's equipped make sure to unequip it first", 60, Color(255, 0, 0, 255))
		ply:SendMessage("You need a(n) " .. SGS_ReverseToolLookup( tool.entity2 ).title .. " in your inventory.", 60, Color(255, 0, 0, 255))
		return
	end
	
	ply:SendMessage("You created a " .. CapAll(string.gsub(tool.title, "_", " ")) .. "!", 60, Color(0, 255, 0, 255))
	ply:AddExp( "smithing", tool.xp )
	
	ply:AddTool( tool.entity )
	
	ply:RemTool( tool.entity2 )
	for k, v in pairs( tool.cost ) do
		ply:SubResource( k, v )
	end
	ply:RandomFindChance()
	
end


------------------
---Drink Potion---
------------------

function SGS_DrinkPotion_Start(ply, len, potion)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if potion.ptype == "achievement" then
		if ply:GetAch(potion.uid) then
			ply:SendMessage("You already have this achievement: " .. potion.title .. "!", 60, Color(255, 0, 0, 255))
			return
		end
	end
	
	if potion.ptype == "upgrade" then
		if potion.uid == "mut" then
			if ply:IsDonator() then
				ply:SendMessage("You can not use this item at this time!", 60, Color(255,0,0,255))
				return
			end
		end
		
		if potion.uid == "tribe_upgrade" then
			if not GAMEMODE.Tribes:PlayerOwnsTribe( ply ) then
				ply:SendMessage("You cannot upgrade a tribe you are not the leader of.", 60, Color(255,0,0,255))
				return			
			end
			
			if GAMEMODE.Tribes:IsTribePersistent( ply ) then
				ply:SendMessage("Your tribe is already persistent.", 60, Color(255,0,0,255))
				return			
			end
		end
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.processtype = "drinking"
	
	local txt = "Drinking Potion..."
	if potion.alttext then
		txt = potion.alttext
	end
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "alchemy" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_DrinkPotion_Stop( ply, potion ) end )

end

function SGS_DrinkPotion_Stop(ply, potion)

	if not ply:IsValid() then return end

	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")

	ply:EmitSound(Sound("npc/barnacle/barnacle_gulp"..math.random(1,2)..".wav"), 60, math.random(70, 130))
	ply:SubResource( potion.mname, 1 )
	
	SGS_PotionDrink( ply, potion )
	
	if potion.salvage then
		if math.random(100) <= 35 then
			ply:AddResource( potion.salvage, 1 )
			ply:SendMessage("You were able to salvage the vial/flask.", 60, Color(0,255,0,255))
		end
	end
	
	ply:AddStat( "alchemy2", 1 )
end


--------------------
---Package Entity---
--------------------

function SGS_Package_Start(ply, len, ent)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	if ent.locked then
		ply:SendMessage("This can't be packaged with a plant grown on it.",3,Color(255,0,0,255))
		return
	end
	
	if ent.broken then
		ply:SendMessage("You have no need to package a broken item.",3,Color(255,0,0,255))
		return
	end
	
	if ply:HasTool( "gms_hammer" ) then
		len = math.ceil(len - 1)
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.stable = { "physics/metal/metal_solid_impact_soft1.wav", "physics/metal/metal_solid_impact_soft2.wav", "physics/metal/metal_solid_impact_soft3.wav" }
	ply:EmitSound(ply.stable[math.random(#ply.stable)], 60, math.random(80,120))
	ply.ps = true
	ply.processtype = "packaging"
	
	local txt = "Packing Structure..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len, "construction" )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Package_Stop( ply, ent ) end )

end

function SGS_Package_Stop(ply, ent)

	if not ply:IsValid() then return end
	if !IsValid(ent) then 
		ply:Freeze( false )
		ply.inprocess = false
	ply.processtype = "idle"
		ply:SetNWString("action", "Idle")
		ply.ps = false
		ply:SendMessage("Package failed!", 60, Color(255,0,0,255))
		return 
	end

	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false

	local togive = ent:GetClass()
	
	SGS.Log("**" .. ent:GetClass() .. " was packaged by " .. ply:Nick() .. "!")
	ent:Remove()
	
	ply:AddResource( togive, 1 )
	timer.Simple( 0, function() print( ply:SendStructureCount() ) end )

end

--------------------
----Bottle Water----
--------------------

function SGS_BottleWater_Start(ply, len)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.processtype = "bottling"
	
	local txt = "Bottling Water..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_BottleWater_Stop( ply ) end )

end

function SGS_BottleWater_Stop(ply)

	if not ply:IsValid() then return end

	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false

	ply:AddResource( "bottled_water", 1 )

end

--------------------------
----Drink Bottle Water----
--------------------------

function SGS_DrinkBottleWater_Start(ply, len)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.processtype = "drinking"
	
	local txt = "Drinking Water..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_DrinkBottleWater_Stop( ply ) end )

end

function SGS_DrinkBottleWater_Stop(ply)

	if not ply:IsValid() then return end

	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false

	ply:DrinkWater(500)
	ply:SubResource( "bottled_water", 1 )

end

-------------------
---Extract Seeds---
-------------------

function SGS_Extract_Start(ply, len, ent, mod)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.processtype = "extracting"
	
	local lvl = 1
	if ent.lvl == nil then
	else
		lvl = ent.lvl
	end
	
	local txt = "Extracting Seeds..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_Extract_Stop( ply, ent, lvl, mod ) end )

end

function SGS_Extract_Stop(ply, ent, lvl, mod)

	if not ply:IsValid() then return end
	if !IsValid(ent) then 
		ply:Freeze( false )
		ply.inprocess = false
		ply.processtype = "idle"
		ply:SetNWString("action", "Idle")
		ply.ps = false
		ply:SendMessage("Seed Extraction Failed!", 60, Color(255,0,0,255))
		return 
	end

	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	
	local chance = math.random(1,100) * mod
	
	if chance >= 35 then
		ply:SendMessage("Extraction successful!", 60, Color(0, 255, 0, 255))
		ply:AddResource( SGS.Seeds[ "fruit" ][lvl].resource, 1 )
	else
		ply:SendMessage("There were no useful seeds!", 60, Color(255, 0, 0, 255))
	end
	
	if ent.parent.tfruit then
		ent.parent.tfruit = ent.parent.tfruit - 1
	end

	ent:Remove()

end


-------------------
---Make Pet Food---
-------------------

function SGS_MakePetFood_Start(ply, len, ftype, multi)
	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end
	
	ply:Freeze( true )
	ply.inprocess = true
	ply.processtype = "crafting"
	
	local txt = "Making Pet Food..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_MakePetFood_Stop( ply, ftype, multi ) end )

end

function SGS_MakePetFood_Stop(ply, ftype, multi)

	if not ply:IsValid() then return end

	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false
	

	ply:SendMessage("Pet Food Created!", 60, Color(0, 255, 0, 255))
	
	if ftype == 1 then
		ply:SubResource( "antlion_meat", multi )
		ply:AddResource( "pet_food", multi * 2 )
	else
		ply:SubResource( "wheat", multi )
		ply:AddResource( "pet_food", math.floor(multi * 0.4) )	
	end

end

-------------------
--Read Skill Book--
-------------------

function SGS_ReadSkillBook_Start(ply, len, book)

	if ply.inprocess == true then
		return
	end
	
	if not ply:Alive() then
		ply:SendMessage("You can't do this while dead.",3,Color(255,0,0,255))
		return
	end
	
	if ply.amode then
		return
	end

	if ply.skillbookactive == true then
		ply:SendMessage("You already have a skill book active!", 60, Color(255, 0, 0, 255))
		return
	end

	ply:Freeze(true)
	ply.inprocess = true
	ply.processtype = "reading"

	local txt = "Reading skill book..."
	ply:SetNWString("action", txt)
	SGS_StartTimer( ply, txt, len )
	timer.Create( ply:UniqueID() .. "processtimer", len, 1, function() SGS_ReadSkillBook_Stop( ply, book ) end )

end


function SGS_ReadSkillBook_Stop(ply, book)

	if not ply:IsValid() then return end

	ply:Freeze( false )
	ply.inprocess = false
	ply.processtype = "idle"
	ply:SetNWString("action", "Idle")
	ply.ps = false

	ply:SubResource( book, 1 )
	SGS_ReadSkillBook(ply, book)

end