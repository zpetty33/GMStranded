concommand.Add( "sgs_fueltotem", function( ply, com, args )
	if #args ~= 2 then return end
	if not IsValid(Entity(tonumber(args[2]))) then return end
	local totem = Entity(tonumber(args[2]))
	
	if args[1] == "sapphire" then
		if ply:GetResource( "sapphire" ) >= 1 then
			ply:SubResource( "sapphire", 1 )
			ply:SendMessage("1x Sapphire fed into the totem. 30 Seconds Added.", 60, Color(0, 255, 0, 255))
			totem.power = totem.power + 30
			totem:Menu( ply )
		else
			ply:SendMessage("You do not have any sapphires.", 60, Color(255, 0, 0, 255))
		end
	elseif args[1] == "emerald" then
		if ply:GetResource( "emerald" ) >= 1 then
			ply:SubResource( "emerald", 1 )
			ply:SendMessage("1x Emerald fed into the totem. 60 Seconds Added.", 60, Color(0, 255, 0, 255))
			totem.power = totem.power + 60
			totem:Menu( ply )
		else
			ply:SendMessage("You do not have any emeralds.", 60, Color(255, 0, 0, 255))
		end
	elseif args[1] == "ruby" then
		if ply:GetResource( "ruby" ) >= 1 then
			ply:SubResource( "ruby", 1 )
			ply:SendMessage("1x Ruby fed into the totem. 120 Seconds Added.", 60, Color(0, 255, 0, 255))
			totem.power = totem.power + 120
			totem:Menu( ply )
		else
			ply:SendMessage("You do not have any rubies.", 60, Color(255, 0, 0, 255))
		end
	elseif args[1] == "diamond" then
		if ply:GetResource( "diamond" ) >= 1 then
			ply:SubResource( "diamond", 1 )
			ply:SendMessage("1x Diamond fed into the totem. 240 Seconds Added.", 60, Color(0, 255, 0, 255))
			totem.power = totem.power + 240
			totem:Menu( ply )
		else
			ply:SendMessage("You do not have any diamonds.", 60, Color(255, 0, 0, 255))
		end
	end
end )
	
concommand.Add( "sgs_enabletotem", function( ply, com, args )

	if #args ~= 1 then return end
	if not IsValid(Entity(tonumber(args[1]))) then return end
	local totem = Entity(tonumber(args[1]))
	
	if totem.power > 0 then
		totem:Enable()
	end
end )
	
concommand.Add( "sgs_disabletotem", function( ply, com, args )

	if #args ~= 1 then return end
	if not IsValid(Entity(tonumber(args[1]))) then return end
	local totem = Entity(tonumber(args[1]))
	
	totem:Disable()
end )
	
function SGS_SetTotemTable( ply )
	ply.totems = {}
	for k, v in pairs( SGS.skills ) do
		ply.totems[v] = false
	end
end

function SGS_CheckTotemRanges()
	for k, v in pairs( player.GetAll() ) do
		local stable = { woodcutting = 0, mining = 0, fishing = 0, smithing = 0, farming = 0, combat = 0, alchemy = 0, arcane = 0, construction = 0, cooking = 0 }
		if not v.totems then SGS_SetTotemTable( v ) end
		
		for _, totem in pairs( ents.FindByClass("gms_totem_*") ) do
			if totem.enabled then
				if totem:GetPos():DistToSqr( v:GetPos() ) <= 1000000 then
					stable[totem.skill] = stable[totem.skill] + 1
				end
			end
		end
		
		for k2, v2 in pairs( stable ) do
			if v2 > 0 then
				v.totems[k2] = true
			else
				v.totems[k2] = false
			end
			
		end
	end
end
timer.Create("sgs_checktotemranges", 1, 0, SGS_CheckTotemRanges)