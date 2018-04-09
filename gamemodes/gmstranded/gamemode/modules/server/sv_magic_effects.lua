
function SGS_Magic_HealEffect( ply )

	local ED = EffectData()
	ED:SetOrigin( ply:GetPos() )
	local effect = util.Effect( 'magic_heal', ED, true, true )

end

function SGS_Potion_HealEffect( ply )

	local ED = EffectData()
	ED:SetOrigin( ply:GetPos() )
	local effect = util.Effect( 'potion_healing', ED, true, true )

end

function SGS_TeleportEffect( ply )

	local ED = EffectData()
	ED:SetOrigin( ply:GetPos() )
	local effect = util.Effect( 'magic_teleport', ED, true, true )

end

function SGS_SetTeleportEffect( ply )

	local ED = EffectData()
	ED:SetOrigin( ply:GetPos() )
	local effect = util.Effect( 'magic_teleportset', ED, true, true )

end

function SGS_SpawnTribeCacheEffect( ent )

	local ED = EffectData()
	ED:SetOrigin( ent:GetPos() )
	local effect = util.Effect( 'magic_spawncache', ED, true, true )
	ent:EmitSound( "weapons/stunstick/alyx_stunner1.wav", 125, 100, 1 )

end

function SGS_CallRainEffect( ply )

	local ED = EffectData()
	ED:SetOrigin( ply:GetPos() )
	local effect = util.Effect( 'magic_rainstart', ED, true, true )

end

function SGS_StopRainEffect( ply )

	local ED = EffectData()
	ED:SetOrigin( ply:GetPos() )
	local effect = util.Effect( 'magic_rainstop', ED, true, true )

end

function SGS_KillFruitEffect( ply )

	local ED = EffectData()
	ED:SetOrigin( ply:GetPos() )
	local effect = util.Effect( 'magic_killfruit', ED, true, true )

end

function SGS_MassResurrectEffect( ply )

	local ED = EffectData()
	ED:SetOrigin( ply:GetPos() )
	local effect = util.Effect( 'magic_massresurrection', ED, true, true )

end

function SGS_GrowSeedEffect( ply )

	local trace = ply:TraceFromEyes(400)
	
	local ED = EffectData()
	ED:SetOrigin( trace.HitPos + Vector(0,0,5))
	ED:SetStart(Vector(0,255,0))
	local effect = util.Effect( 'magic_growseed', ED, true, true )

end
concommand.Add("sgs_test5", SGS_TestMagic5)

function SGS_ConsumeTree( ply, tree )
	for k, v in pairs(SGS.trees) do
		if v == tree:GetClass() then
			if timer.Exists("tree_consume_"..tostring(ply:GetPlayerID())) then
				timer.Destroy("tree_consume_"..tostring(ply:GetPlayerID()))
			end
			
			local mult = 1
			timer.Create("tree_consume_"..tostring(ply:GetPlayerID()), 0.4, 6, function()
				if not IsValid( tree ) then
					timer.Destroy("tree_consume_"..tostring(ply:GetPlayerID()))
				end
				if tree.rtotal <= 1 then
					timer.Destroy("tree_consume_"..tostring(ply:GetPlayerID()))
				end
				
				local ED = EffectData()
				ED:SetOrigin( tree:GetPos() + Vector(0,0,7 * mult))
				mult = mult + 1
				local effect = util.Effect( 'magic_pickupdrops', ED, true, true )
				
				local ent = ents.Create( "gms_wood" )
				ent.level = math.random(1,3)
				ent.wtype = tree.lvl
				tree.rtotal = tree.rtotal - ent.level
				ent:SetPos( tree:GetPos() + Vector(math.random(-100,100),math.random(-100,100),( 7 * mult) + 25) )
				ent:Spawn()
				--SPP MAKE PLAYER OWNER--
				ent:CPPISetOwner(ply)
				-------------------------
				
				local npo = ent:GetPhysicsObject()
				npo:Wake()
				
				if tree.rtotal <= 0 then
					if IsValid(tree.owner) and tree.owner:IsPlayer() then
						tree.owner.tplants = tree.owner.tplants - 1
						tree.owner:UpdatePlantCount()
					end
					SGS_RemoveAResource(tree)
					tree:EmitSound("physics/wood/wood_box_break2.wav", 60, math.random(80,120))		
					timer.Destroy("tree_consume_"..tostring(ply:GetPlayerID()))					
				end
			end )
		break
		end
	end

end



function SGS_TestMagic0( ply, _, args )

	if not ply:IsSuperAdmin() then return end

	local ED = EffectData()
	
	ED:SetOrigin( ply:GetPos() )
	
	local effect = util.Effect( 'magic_test', ED, true, true )
end
concommand.Add("sgs_test0", SGS_TestMagic0)

function SGS_TestMagic1( ply, _, args )

	if not ply:IsSuperAdmin() then return end

	SGS_Magic_HealEffect( ply )
	
end
concommand.Add("sgs_test1", SGS_TestMagic1)

function SGS_TestMagic2( ply, _, args )

	if not ply:IsSuperAdmin() then return end

	local bolt = ents.Create("gms_bolt_air")
	bolt:SetPos(ply:GetPos() + Vector(0,0,60))
	bolt.Direction = ply:GetAimVector()
	bolt.Speed = 1000
	bolt.Size = 2
	bolt:SetOwner( ply )
	
	bolt:Spawn()

end
concommand.Add("sgs_test2", SGS_TestMagic2)

function SGS_TestMagic2_1( ply, _, args )

	if not ply:IsSuperAdmin() then return end

	local bolt = ents.Create("gms_bolt_water")
	bolt:SetPos(ply:GetPos() + Vector(0,0,60))
	bolt.Direction = ply:GetAimVector()
	bolt.Speed = 1000
	bolt.Size = 2
	bolt:SetOwner( ply )
	
	bolt:Spawn()

end
concommand.Add("sgs_test2_1", SGS_TestMagic2_1)

function SGS_TestMagic3( ply, _, args )

	if not ply:IsSuperAdmin() then return end

	for k, v in pairs(ents.FindInSphere(ply:GetPos(), 300)) do
		for k2, v2 in pairs( SGS.collectibles ) do
			if v:GetClass() == v2 then
				if v:CPPICanTool(ply, true) then
					local ED = EffectData()
					ED:SetOrigin( v:GetPos() )
					local effect = util.Effect( 'magic_pickupdrops', ED, true, true )
				end
			end
		end
	end

end
concommand.Add("sgs_test3", SGS_TestMagic3)

function SGS_TestMagic4( ply, _, args )

	if not ply:IsSuperAdmin() then return end

	local ED = EffectData()
	
	ED:SetOrigin( ply:GetPos() )
	
	local effect = util.Effect( 'magic_teleportset', ED, true, true )

end
concommand.Add("sgs_test4", SGS_TestMagic4)

function SGS_TestMagic5( ply, _, args )

	if not ply:IsSuperAdmin() then return end

	local trace = ply:TraceFromEyes(300)
	
	local ED = EffectData()
	ED:SetOrigin( trace.HitPos + Vector(0,0,5))
	ED:SetStart(Vector(0,255,0))
	local effect = util.Effect( 'magic_growseed', ED, true, true )

end
concommand.Add("sgs_test5", SGS_TestMagic5)

function SGS_TestMagic6( ply, _, args )

	if not ply:IsSuperAdmin() then return end

	local ED = EffectData()
	
	ED:SetOrigin( ply:GetPos() )
	
	local effect = util.Effect( 'test_particle', ED, true, true )

end
concommand.Add("sgs_test6", SGS_TestMagic6)