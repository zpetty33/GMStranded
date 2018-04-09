HaloTable = {}

util.AddNetworkString("Halo_SendTable")

function Halo_AddStar( ply, skill )
	if not HaloTable[ply] then HaloTable[ply] = {} end
	if Halo_IsStarDisplayed( ply, skill ) then return end
	if skill == "all" then
		--if ply:GetLevel("survival") >= SGS.maxlevelsurvival then
		if ply:GetLevel("survival") >= 1 then
			HaloTable[ply] = {}
			table.insert( HaloTable[ply], { sk = skill } )
		end
	else
		local sk_col = SGS.colors[skill]
		table.insert( HaloTable[ply], { sk = skill, color = Color(sk_col.r, sk_col.g, sk_col.b, 200) } )
	end
	Halo_NetworkTable()
end

function Halo_RemoveStar( ply, skill )
	if not HaloTable[ply] then return end
	for k, v in pairs( HaloTable[ply] ) do
		if v.sk == skill then 
			HaloTable[ply][k] = nil
			if #HaloTable[ply] <= 0 then
				HaloTable[ply] = nil
			end
		end
	end
	Halo_NetworkTable()
end

function Halo_IsStarDisplayed( ply, skill )
	if not HaloTable[ply] then return false end
	for k, v in pairs( HaloTable[ply] ) do
		if v.sk == skill then 
			return true
		end
	end
	return false
end

function Halo_CleanTable()
	for k, v in pairs( HaloTable ) do
		if not IsValid(k) then
			HaloTable[k] = nil
		else
			HaloTable[k] = table.ClearKeys(HaloTable[k])
		end
	end
end

function Halo_NetworkTable( ply )
	Halo_CleanTable()
	net.Start( "Halo_SendTable" )
	net.WriteTable( HaloTable )
	
	if IsValid(ply) then
		net.Send( ply )
	else
		net.Broadcast()
	end
end

function Halo_ToggleHaloCon( ply, com, args )
	local skill = args[1]
	if not IsValid( ply ) then return end
	if ply:GetLevel( skill ) < SGS.maxlevel then return end
	
	if Halo_IsStarDisplayed( ply, skill ) then
		Halo_RemoveStar( ply, skill )
	else
		Halo_AddStar( ply, skill )
	end	
end
concommand.Add( "sgs_toggleskill", Halo_ToggleHaloCon )