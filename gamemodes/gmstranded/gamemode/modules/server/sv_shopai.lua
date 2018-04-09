function SGS_ClaimShopNPC()
	for _, v in pairs(ents.FindByClass("npc_vortigaunt")) do
		if v.ispet == nil then v.ispet = false end
		if v.ispet then continue end

		SGS.shopent = v
		SGS.shopentstart = v:GetPos()
		
		SGS.shopent:SetNetworkedString("Owner", "World")
		timer.Remove( "checkShop" )
		timer.Create( "checkShop", 5, 1, function() SGS_CheckOnShop() end )
		--End Joke--
		
		
		
		SGS.shopent.status = "wander"
		SGS.shopstartpos = SGS.shopent:GetPos()
		SGS.shopent.spawn = SGS.shopent:GetPos()
		
		timer.Simple(1, function() SGS.shopent:EquipHat("farminghat") end )
		SGS.shopent:AddRelationship("npc_antlion D_LI 99")
		SGS.shopent:AddRelationship("npc_antlionguard D_LI 99")
		SGS.shopent:AddRelationship("npc_headcrab D_LI 99")
		SGS.shopent:AddRelationship("npc_headcrab_fast D_LI 99")
		SGS.shopent:AddRelationship("npc_headcrab_black D_LI 99")
		SGS.shopent:AddRelationship("npc_zombie D_LI 99")
		SGS.shopent:AddRelationship("npc_strider D_LI 99")
		SGS.shopent:AddRelationship("npc_kleiner D_LI 99")
		return
	end
	timer.Simple(5, SGS_ClaimShopNPC)
end
timer.Simple(5, SGS_ClaimShopNPC)

/*
function SGS_ClaimSpecialNPC()
	for _, v in pairs(ents.FindByClass("npc_breen")) do
		
		SGS.shopent2 = v
		SGS.shopent2start = v:GetPos()
		
		SGS.shopent2:SetNetworkedString("Owner", "World")
		timer.Simple( 5, function() SGS_CheckOnShop2() end )

		SGS.shopent2.status = "wander"
		SGS.shop2startpos = SGS.shopent2:GetPos()
		SGS.shopent2.spawn = SGS.shopent2:GetPos()
	end
	
	if IsValid(SGS.shopent2) then
		SGS.shopent2:AddRelationship("npc_antlion D_LI 99")
		SGS.shopent2:AddRelationship("npc_antlionguard D_LI 99")
		SGS.shopent2:AddRelationship("npc_headcrab D_LI 99")
		SGS.shopent2:AddRelationship("npc_headcrab_fast D_LI 99")
		SGS.shopent2:AddRelationship("npc_headcrab_black D_LI 99")
		SGS.shopent2:AddRelationship("npc_strider D_LI 99")
		SGS.shopent2:AddRelationship("npc_kleiner D_LI 99")
		
		return
	end
	timer.Simple(5, SGS_ClaimSpecialNPC)
end
*/

function SGS_ClaimHatNPC()
	for _, v in pairs(ents.FindByClass("npc_kleiner")) do
		
		SGS.shopent3 = v
		SGS.shopent3start = v:GetPos()
		
		SGS.shopent3:SetNetworkedString("Owner", "World")
		timer.Simple( 5, function() SGS_CheckOnShop3() end )

		SGS.shopent3.status = "wander"
		SGS.shop3startpos = SGS.shopent3:GetPos()
		SGS.shopent3.spawn = SGS.shopent3:GetPos()

		timer.Simple(1, function() SGS.shopent:EquipHat("toweringhat") end )
		SGS.shopent3:AddRelationship("npc_antlion D_LI 99")
		SGS.shopent3:AddRelationship("npc_antlionguard D_LI 99")
		SGS.shopent3:AddRelationship("npc_headcrab D_LI 99")
		SGS.shopent3:AddRelationship("npc_headcrab_fast D_LI 99")
		SGS.shopent3:AddRelationship("npc_headcrab_black D_LI 99")
		SGS.shopent3:AddRelationship("npc_strider D_LI 99")
		SGS.shopent3:AddRelationship("npc_kleiner D_LI 99")
		return
	end
	timer.Simple(5, SGS_ClaimHatNPC)
end
timer.Simple(5, SGS_ClaimHatNPC)

function SGS_CheckOnShop()

	if not GAMEMODE.Worlds.tblWorlds[1].loaded then
		return
	end

	for k, v in pairs(ents.FindByClass("npc_vortigaunt")) do
		if not v.ispet then
			timer.Remove( "checkShop" )
			timer.Create( "checkShop", 5, 1, function() SGS_CheckOnShop() end )
			return
		end
	end
	
	local newshop = ents.Create("npc_vortigaunt")
	newshop:SetPos(SGS.shopstartpos)
	newshop:Spawn()
	newshop.w_id = 1
	SGS_ClaimShopNPC()
	timer.Remove( "checkShop" )
	timer.Create( "checkShop", 5, 1, function() SGS_CheckOnShop() end )
	
end

function SGS_CheckOnShop2()

	for k, v in pairs(ents.FindByClass("npc_breen")) do
		timer.Simple( 5, function() SGS_CheckOnShop2() end )
		return
	end

	local newshop = ents.Create("npc_breen")
	newshop:SetPos(SGS.shop2startpos)
	newshop:Spawn()
	SGS_ClaimSpecialNPC()
	timer.Simple( 5, function() SGS_CheckOnShop2() end )
	
end

function SGS_CheckOnShop3()

	if not GAMEMODE.Worlds.tblWorlds[1].loaded then
		timer.Simple( 5, function() SGS_CheckOnShop3() end )
		return
	end

	for k, v in pairs(ents.FindByClass("npc_kleiner")) do
		timer.Simple( 5, function() SGS_CheckOnShop3() end )
		return
	end

	local newshop = ents.Create("npc_kleiner")
	newshop:SetPos(SGS.shop3startpos)
	newshop:Spawn()
	newshop.w_id = 7
	SGS_ClaimHatNPC()
	timer.Simple( 5, function() SGS_CheckOnShop3() end )
	
end


function SGS_ShopWalk()

	if IsValid(SGS.shopent) then
		if SGS.shopent.status == "wander" then
			SGS_MoveShop(SGS.shopent)
		end
	end
	timer.Simple(20, SGS_ShopWalk)

end
timer.Simple(20, SGS_ShopWalk)

function SGS_Shop2Walk()

	if IsValid(SGS.shopent2) then
		if SGS.shopent2.status == "wander" then
			SGS_MoveSpecial(SGS.shopent2)
		end
	end
	timer.Simple(20, SGS_Shop2Walk)

end
timer.Simple(20, SGS_Shop2Walk)

function SGS_Shop3Walk()

	if IsValid(SGS.shopent3) then
		if SGS.shopent3.status == "wander" then
			SGS_MoveHatNPC(SGS.shopent3)
		end
	end
	timer.Simple(20, SGS_Shop3Walk)

end
timer.Simple(20, SGS_Shop3Walk)


function SGS_MoveShop(ent)
	if not IsValid(SGS.shopent) then return end
	if SGS.inedit == true then return end
	if not ent.loop then
		ent.loop = 0
	end
	
	if ent:GetPos():DistToSqr( SGS.shopentstart ) > 9000000 then
		ent:SetPos( SGS.shopentstart + Vector( 0, 0, 20 ) )
	end
	
	if ent:WaterLevel() ~= 0 then
		ent:SetPos( SGS.shopentstart + Vector( 0, 0, 20 ) )	
	end
	
	if SGS.shopent:GetNPCState() == 3 then return end
	
	local curpos = ent:GetPos()
	local newpos = curpos + Vector(math.random(-300,300), math.random(-300,300), 200)
	
	local trace = {}
	trace.start = newpos
	trace.endpos = trace.start + Vector(0,0,-500)
	trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
	trace.filter = ent

	local tr = util.TraceLine(trace)
	
	if tr.Hit then
	
		if tr.MatType == MAT_SLOSH then
			ent.loop = ent.loop + 1
			if ent.loop >= 50 then 
				ent:SetPos(SGS.shopent.spawn)
				return
			end
			SGS_MoveShop(ent)
		else
			local newpos = tr.HitPos
			ent.loop = 0
			ent:SetLastPosition(newpos)
			ent:SetSchedule( SCHED_FORCED_GO )
		end

	else
	end
end

function SGS_MoveSpecial(ent)
	if SGS.inedit == true then return end
	if not ent.loop then
		ent.loop = 0
	end
	
	if ent:GetPos():DistToSqr( SGS.shopent2start ) > 9000000 then
		ent:SetPos( SGS.shopent2start + Vector( 0, 0, 20 ) )
	end
	
	if SGS.shopent2:GetNPCState() == 3 then return end
	
	local curpos = ent:GetPos()
	local newpos = curpos + Vector(math.random(-300,300), math.random(-300,300), 200)
	
	local trace = {}
	trace.start = newpos
	trace.endpos = trace.start + Vector(0,0,-500)
	trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
	trace.filter = ent

	local tr = util.TraceLine(trace)
	
	if tr.Hit then
	
		if tr.MatType == MAT_SLOSH then
			ent.loop = ent.loop + 1
			if ent.loop >= 50 then 
				ent:SetPos(SGS.shopent2.spawn)
				return
			end
			SGS_MoveSpecial(ent)
		else
			local newpos = tr.HitPos
			ent.loop = 0
			ent:SetLastPosition(newpos)
			ent:SetSchedule( SCHED_FORCED_GO )
		end
	end
end

function SGS_MoveHatNPC(ent)
	if not IsValid(SGS.shopent3) then return end
	if SGS.inedit == true then return end
	if not ent.loop then
		ent.loop = 0
	end
	
	if ent:GetPos():DistToSqr( SGS.shopent3start ) > 9000000 then
		ent:SetPos( SGS.shopent3start + Vector( 0, 0, 20 ) )
	end
	
	if SGS.shopent3:GetNPCState() == 3 then return end
	
	local curpos = ent:GetPos()
	local newpos = curpos + Vector(math.random(-300,300), math.random(-300,300), 200)
	
	local trace = {}
	trace.start = newpos
	trace.endpos = trace.start + Vector(0,0,-500)
	trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
	trace.filter = ent

	local tr = util.TraceLine(trace)
	
	if tr.Hit then
	
		if tr.MatType == MAT_SLOSH then
			ent.loop = ent.loop + 1
			if ent.loop >= 50 then 
				ent:SetPos(SGS.shopent3.spawn)
				return
			end
			SGS_MoveHatNPC(ent)
		else
			local newpos = tr.HitPos
			ent.loop = 0
			ent:SetLastPosition(newpos)
			ent:SetSchedule( SCHED_FORCED_GO )
		end
	end
end

function SGS_VortPlantSeed()
	if not IsValid(SGS.shopent) then return end
	
	if not (SGS.shopent.status == "wander") then return end
	
	if math.random(1,3) == 1 then return end
	
	local explants = ents.FindInSphere(SGS.shopent:GetPos(), 3000)
	
	local epnum = 0
	for k, v in pairs(explants) do
		if v:GetClass() == "gms_seed" or v:GetClass() == "gms_plant" or v:GetClass() == "gms_foodseed" or v:GetClass() == "gms_wheat"then
			epnum = epnum + 1
		end
	end
	
	if epnum >= 15 then return end
	
	local explants = ents.FindInSphere(SGS.shopent:GetPos(), 50)
	
	local epnum = 0
	for k, v in pairs(explants) do
		if v:GetClass() == "gms_seed" or v:GetClass() == "gms_plant" then
			epnum = epnum + 1
		end
	end
	
	if epnum > 0 then return end
	
	local wtp = math.random(1,10)
	
	if wtp >= 1 and wtp < 6 then
		local ent = ents.Create("gms_seed")
			ent:SetPos( SGS.shopent:GetPos() + Vector(0,0,-2))
			ent.pType = "pypa_seed"
			ent.GrowTime = math.random( 45 * 0.8, 45 * 1.2 )
			ent.fColor = Color(255,0,255,255)
			ent.fMaterial = "models/debug/debugwhite"
			ent.fEatHeal = 100
			ent.lvl = 1
			ent.model = "models/hunter/misc/sphere025x025.mdl"
			ent.owner = worldspawn
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:SetNetworkedString("Owner", "World")
			-------------------------
	elseif wtp >= 6 and wtp < 9 then
		local ent = ents.Create("gms_seed")
			ent:SetPos( SGS.shopent:GetPos() + Vector(0,0,-2))
			ent.pType = "guacca_seed"
			ent.GrowTime = math.random( 90 * 0.8, 90 * 1.2 )
			ent.fColor = Color(255,0,0,255)
			ent.fMaterial = "models/debug/debugwhite"
			ent.fEatHeal = 200
			ent.lvl = 2
			ent.model = "models/hunter/misc/sphere025x025.mdl"
			ent.owner = worldspawn
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:SetNetworkedString("Owner", "World")
			-------------------------
	else
		local ent = ents.Create("gms_foodseed")
			ent:SetPos( SGS.shopent:GetPos() + Vector(0,0,-2) )
			ent.pType = "wheat_seed"
			ent.GrowTime = math.random( 120 * 0.8, 120 * 1.2 )
			ent.entity = "gms_wheat"
			ent.harvest = "wheat"
			ent.seed = "wheat_seed"
			ent.owner = worldspawn
			ent:Spawn()
			--SPP MAKE PLAYER OWNER--
			ent:SetNetworkedString("Owner", "World")
			-------------------------
	end
end
timer.Create("SGS_VortPlantSeed", 60, 0, SGS_VortPlantSeed)


function SGS_VortFindPlant()
	if not IsValid(SGS.shopent) then return end
	
	local npc = SGS.shopent

	npc.status = "findfruit"

	local explants = ents.FindInSphere(SGS.shopent:GetPos(), 650)
	
	local eligfruit = {}
	
	for k, v in pairs(explants) do
		if v:GetClass() == "gms_fruit" then
			table.insert(eligfruit, v)
		end
	end
	
	if #eligfruit == 0 then 
		npc.status = "wander"
		return 
	end
	
	local winner = table.Random(eligfruit)
	
	npc:SetLastPosition(winner:GetPos())
	npc:SetSchedule( SCHED_FORCED_GO )
	
	timer.Create("shopwanderreset", 30, 1, SGS_VortWander)
	timer.Create("shopeatfruit", 3, 0, SGS_VortEatPlant)

end
timer.Create("shop_npc_eatcycle", 120, 0, SGS_VortFindPlant)

function SGS_VortWander()
	if not IsValid(SGS.shopent) then return end
	local npc = SGS.shopent	
	npc.status = "wander"
	timer.Destroy("shopwanderreset")
	timer.Destroy("shopeatfruit")
end

function SGS_VortEatPlant()
	if not IsValid(SGS.shopent) then return end

	local npc = SGS.shopent

	npc.status = "eating"

	local explants = ents.FindInSphere(SGS.shopent:GetPos(), 50)
	
	local eligfruit = {}
	
	for k, v in pairs(explants) do
		if v:GetClass() == "gms_fruit" then
			table.insert(eligfruit, v)
		end
	end
	
	if #eligfruit == 0 then 
		return 
	end
	
	local winner = table.Random(eligfruit)
	
	winner.parent.tfruit = winner.parent.tfruit - 1
	winner:Remove()
	
	local sound = {"npc/barnacle/barnacle_crunch2.wav", "npc/barnacle/barnacle_crunch3.wav"}
	npc:EmitSound(sound[math.random(#sound)], 60, math.random(80,120))
	
	SGS_VortWander()
end

function SGS_VortTalkChat()

	if math.random(1,4) == 1 then
		--[[if math.random(1,10) == 1 then
			SGS_VortyBickerAtBreen()
			return
		end]]

		local ptarget = table.Random(player.GetAll())
		if not IsValid( ptarget ) then return end
		
		local tosay = table.Random(SGS.VortChatMessages)
		
		local substring = string.Replace(tosay, "%P", ptarget:Nick())
		
		SGS_VortChat( substring )
		--[[if tosay == "Do you really call THAT a base, %P? I've seen better latrines on Xen." then
			if math.random(1,3) == 1 then
				timer.Simple(5, function() if IsValid(ptarget) then SGS_BreenChat( "Don't worry "..ptarget:Nick()..", I rather like your base." ) end end )
			end
		end]]
		
	end
	
end
timer.Create("shop_npc_talkrandom", 150, 0, SGS_VortTalkChat)
--timer.Create("shop_npc_talkrandom", 2, 0, SGS_VortTalkChat)

function SGS_BreenTalkChat()

	if math.random(1,7) == 1 then
		if math.random(1,10) == 1 then
			SGS_BreenBickerAtVorty()
			return
		end

		local ptarget = table.Random(player.GetAll())
		if not IsValid( ptarget ) then return end
		
		local tosay = table.Random(SGS.BreenChatMessages)
		
		local substring = string.Replace(tosay, "%P", ptarget:Nick())
		
		SGS_BreenChat( substring )
		if tosay == "%P, Where did you get that shirt... from Vorty? Bah!" then
			if math.random(1,3) == 1 then
				timer.Simple(4, function() if IsValid(ptarget) then SGS_VortChat( "I rather like that shirt!" ) end end )
			end
		end
		
	end
	
end
--timer.Create("shop2_npc_talkrandom", 90, 0, SGS_BreenTalkChat)
--timer.Create("shop2_npc_talkrandom", 4, 0, SGS_BreenTalkChat)

function SGS_VortChat( message )

	GAMEMODE.colorSay(_, { Color(0,0,0), "(", Color(255, 150, 255), "BOT", Color(0,0,0), ")", Color(100,200,200), " Vorty", Color(255,255,255), ": ", message } )

end

function SGS_BreenChat( message )

	GAMEMODE.colorSay(_, { Color(0,0,0), "(", Color(255, 150, 255), "BOT", Color(0,0,0), ")", Color(100,200,200), " Dr. Breen", Color(255,255,255), ": ", message } )

end

function SGS_KlienerChat( message )

	GAMEMODE.colorSay(_, { Color(0,0,0), "(", Color(255, 150, 255), "BOT", Color(0,0,0), ")", Color(100,200,200), " Dr. K", Color(255,255,255), ": ", message } )

end

function SGS_SniperChat( message )

	GAMEMODE.colorSay(_, { Color(0,0,0), "(", Color(255, 150, 255), "BOT", Color(0,0,0), ")", Color(100,200,200), " Guard", Color(255,255,255), ": ", message } )

end

function SGS_VortyBickerAtBreen()

	SGS_VortChat( "Hey Dr. Breen.. I still can't believe that you tried to have me deported..." )
	timer.Simple( 3, function() SGS_BreenChat( "Shut up, you one eyed freak! You think you're safe?" ) end )
	timer.Simple( 5, function() SGS_BreenChat( "I'm still working on how to get you out of here." ) end )
	timer.Simple( 8, function() SGS_VortChat( "Why can't we just be friends..." ) end )
	
end

function SGS_BreenBickerAtVorty()

	if math.random(1,3) >= 2 then
		SGS_BreenChat( "Hey, Walking lizard..." )
		timer.Simple( 3, function() SGS_VortChat( "I know you're not talking to me..." ) end )
		timer.Simple( 6, function() SGS_BreenChat( "Guess what has three arms, one eye and no home?" ) end )
		timer.Simple( 8, function() SGS_VortChat( "... ... ..." ) end )
		timer.Simple( 12, function() SGS_BreenChat( "Bahahahahahaha!!!! I hate you..." ) end )
	else
		SGS_VortChat( "Now selling.. " )
		timer.Simple( 1, function() SGS_BreenChat( "Shut Up!!" ) end )
		timer.Simple( 3, function() SGS_VortChat( "I'm sorry.. what?" ) end )
		timer.Simple( 6, function() SGS_BreenChat( "Just shut up.. noone cares..." ) end )
	end
	
end



function SGS_VortReplies( ply, text, public )


	if CurTime() > SGS.lastvorttalk + 10 then
		if CurTime() < ply.lastvorttalk + 120 then return end
		for k, v in pairs(SGS.VortHelper) do
			if ( string.find( string.lower( text ), string.lower( v.trigger ) ) ) then
				local vsay = string.Replace( v.response, "%P", ply:Nick())
				timer.Simple(1, function() SGS_VortChat( vsay ) end)
				SGS.lastvorttalk = CurTime()
				ply.lastvorttalk = CurTime()
				break
			end
		end
	end
	
end
--hook.Add( "PlayerSay", "SGS_VortReplies", SGS_VortReplies )

function SGS_VortyDamage( ent, dmginfo )
	local ply = dmginfo:GetInflictor()
	if ent:IsNPC() then
		if ent == SGS.shopent then
			dmginfo:ScaleDamage(0)
			SGS_VortySetHostile( SGS.shopent, ply )
			return false
		end
	end
end
hook.Add("EntityTakeDamage", "SGS_VortyDamage", SGS_VortyDamage)

--[[function SGS_BreenDamage( ent, dmginfo )
	local ply = dmginfo:GetInflictor()
	if ent:IsNPC() then
		if ent == SGS.shopent2 then
			dmginfo:ScaleDamage(0)
			return false
		end
	end
end
hook.Add("EntityTakeDamage", "SGS_BreenDamage", SGS_BreenDamage)]]

function SGS_KlienerDamage( ent, dmginfo )
	local ply = dmginfo:GetInflictor()
	if ent:IsNPC() then
		if ent == SGS.shopent3 then
			dmginfo:ScaleDamage(0)
			SGS_KlienerSetHostile( SGS.shopent3, ply )
			return false
		end
	end
end
hook.Add("EntityTakeDamage", "SGS_KlienerDamage", SGS_KlienerDamage)

function SGS_VortySetHostile( npc, ply )

	if SGS.shopent:GetNPCState( ) == 1 then
		SGS_VortChat( "Why would you attack me " .. ply:Nick() .. ". Now I'm angry..." )
	end

	npc:AddEntityRelationship(ply, D_HT, 999 )
	npc:SetNPCState(3)
	timer.Create( "resethostile_" .. ply:EntIndex(), 30, 1, function() SGS_VortySetNeutral( npc, ply ) end)
	
end

function SGS_VortySetNeutral( npc, ply )

	if !IsValid(npc) then return end
	if !IsValid(ply) then return end
	
	SGS_VortChat( "Alright " .. ply:Nick() .. ". Let's just be friends now..." )

	npc:AddEntityRelationship(ply, D_LI, 999 )
	npc:SetNPCState(1)
	
end

function SGS_VortyKillsPlayer( ply, weapon, npc )
 
	if npc == SGS.shopent then
	
		SGS_VortChat( "Maybe next time," .. ply:Nick() .. ", you'll know not to mess with me..." )
		timer.Destroy("resethostile_" .. ply:EntIndex())
		npc:AddEntityRelationship(ply, D_LI, 999 )
		npc:SetNPCState(1)
		npc:PlayScene ('scenes/npc/vortigaunt/cavechant.vcd', 100 )
		
		local vort_kills = util.GetPData( "Vorty", "vorty_kills", 0 )
		vort_kills = vort_kills + 1
		util.SetPData( "Vorty", "vorty_kills", vort_kills )
		
		if math.random( 3 ) == 1 then
			timer.Simple( 3, function()
				SGS_VortChat( "Let's see.. that makes " .. vort_kills .. " kills now." )
			end )
		end

		
	end
	
end
hook.Add( "PlayerDeath", "SGS_VortyKillsPlayer", SGS_VortyKillsPlayer )


function SGS_KlienerSetHostile( npc, ply )

	if not npc.engaged then
		SGS_KlienerChat( "My My..." )
		timer.Simple( 1, function()
			SGS_SniperChat( "Stand down citizen!" )
			
			newpos = ply:GetPos() + Vector(0, 400, 300)
			local trace = {}
			trace.start = newpos
			trace.endpos = trace.start + Vector(0,0,-600)
			trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
			local tr = util.TraceLine(trace)
			if tr.Hit then
				SGS_SpawnSniper( ply, tr.HitPos )
			end
			
			newpos2 = ply:GetPos() + Vector(400, 0, 300)
			local trace = {}
			trace.start = newpos2
			trace.endpos = trace.start + Vector(0,0,-600)
			trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
			local tr = util.TraceLine(trace)
			if tr.Hit then
				SGS_SpawnSniper( ply, tr.HitPos )
			end
			
			newpos3 = ply:GetPos() + Vector(-400, 0, 300)
			local trace = {}
			trace.start = newpos3
			trace.endpos = trace.start + Vector(0,0,-600)
			trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
			local tr = util.TraceLine(trace)
			if tr.Hit then
				SGS_SpawnSniper( ply, tr.HitPos )
			end
			
			newpos4 = ply:GetPos() + Vector(0, -400, 300)
			local trace = {}
			trace.start = newpos4
			trace.endpos = trace.start + Vector(0,0,-600)
			trace.mask = bit.bor(MASK_WATER , MASK_SOLID)
			local tr = util.TraceLine(trace)
			if tr.Hit then
				SGS_SpawnSniper( ply, tr.HitPos )
			end
		end )
		
		npc.engaged = true
		npc.attacking = ply
	end
		

	
	timer.Create( "resetklienerhostile", 30, 1, function() SGS_KlienerSetNeutral( npc ) end)
	
end

function SGS_KlienerSetNeutral( npc )

	if !IsValid(npc) then return end
	npc.engaged = false
	npc.attacking = nil
	
	SGS_KlienerChat( "Alright Gentlemen, stand down." )

	for k, v in pairs( ents.FindByClass("npc_sniper") ) do
		v:Remove()
	end
	
end

function SGS_SpawnSniper( ply, pos )
	if not IsValid(ply) then return end
	
	local sniper = ents.Create( "npc_sniper" )
	sniper:SetPos( pos )
	sniper.dmg = 1000
	sniper:Spawn()
	local aimAngle = ((ply:GetPos() + ply:GetAngles():Forward()) - sniper:GetPos()):Angle()
	aimAngle.p = 0
	aimAngle.r = 0
	sniper:SetAngles( aimAngle )
	sniper:AddRelationship("player D_NU 999")
			
	sniper:AddRelationship("npc_alyx D_LI 99")
	sniper:AddRelationship("npc_antlion D_LI 99")
	sniper:AddRelationship("npc_antlionguard D_LI 99")
	sniper:AddRelationship("npc_barney D_LI 99")
	sniper:AddRelationship("npc_breen D_LI 99")
	sniper:AddRelationship("npc_citizen D_LI 99")
	sniper:AddRelationship("npc_combine_s D_LI 99")
	sniper:AddRelationship("npc_crow D_LI 99")
	sniper:AddRelationship("npc_dog D_LI 99")
	sniper:AddRelationship("npc_eli D_LI 99")
	sniper:AddRelationship("npc_fastzombie D_LI 99")
	sniper:AddRelationship("npc_fastzombie_torso D_LI 99")
	sniper:AddRelationship("npc_gman D_LI 99")
	sniper:AddRelationship("npc_headcrab D_LI 99")
	sniper:AddRelationship("npc_headcrab_black D_LI 99")
	sniper:AddRelationship("npc_headcrab_fast D_LI 99")
	sniper:AddRelationship("npc_kleiner D_LI 99")
	sniper:AddRelationship("npc_metropolice D_LI 99")
	sniper:AddRelationship("npc_monk D_LI 99")
	sniper:AddRelationship("npc_mossman D_LI 99")
	sniper:AddRelationship("npc_pigeon D_LI 99")
	sniper:AddRelationship("npc_poisonzombie D_LI 99")
	sniper:AddRelationship("npc_strider D_LI 99")
	sniper:AddRelationship("npc_stalker D_LI 99")
	sniper:AddRelationship("npc_vortigaunt D_LI 99")
	sniper:AddRelationship("npc_zombie D_LI 99")
	sniper:AddRelationship("npc_zombie_torso D_LI 99")
	sniper:AddRelationship("npc_seagull D_LI 99")
	sniper:AddRelationship("npc_hunter D_LI 99")
	
	sniper:SetNetworkedString("Owner", "World")
	
	sniper:AddEntityRelationship(ply, D_HT, 999 )
end

function SGS_KlienerKillsPlayer( ply, weapon, npc )
 
	if npc:GetClass() == "npc_sniper" then
	
		SGS_KlienerChat( "Boom! Headshot!" )
		timer.Destroy("resetklienerhostile")

		SGS_KlienerSetNeutral( SGS.shopent3 )
		
	end
	
end
hook.Add( "PlayerDeath", "SGS_KlienerKillsPlayer", SGS_KlienerKillsPlayer )

function SGS_ChatVorty( ply, text, public )
    if ( string.sub( string.lower(text), 1, 6 ) == "!vorty" ) then
    	-- We need this damnit...
		if not ply:IsAdmin() then
			ply:SendMessage("This is an admin command.", 60, Color(255, 0, 0, 255))
			return false
		end
		if ply:GetUserGroup() == "moderator" then
			ply:SendMessage("This is an admin command.", 60, Color(255, 0, 0, 255))
			return false		
		end
		
		 SGS_VortChat(text:sub(8))
		 
		 return false
	end
end
hook.Add( "PlayerSay", "SGS_ChatVorty", SGS_ChatVorty )