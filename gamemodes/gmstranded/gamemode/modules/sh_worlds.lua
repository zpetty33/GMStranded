GM.Worlds = GM.Worlds or {}
GM.Worlds.tblWorlds = GM.Worlds.tblWorlds or {}

function GM.Worlds:RegisterWorld( world )
	table.insert( self.tblWorlds, world )
end

local files, dirs = file.Find("gmstranded/gamemode/modules/worlds/*.lua", "LUA")
for k, v in pairs( files ) do
	print("Stranded: Loading World (" .. v .. ")")
	include( "gmstranded/gamemode/modules/worlds/" .. v )
	if SERVER then
		AddCSLuaFile( "gmstranded/gamemode/modules/worlds/" .. v )
	end
end

function GM.Worlds:GetEntityWorldSpace( ent )
	local Pos = ent:GetPos()

	for _, World in pairs( self.tblWorlds ) do
		for _, Bound in pairs( World.Bounds ) do
			if self:VecInBounds( Pos, Bound.Min, Bound.Max ) then
				return World
			end
		end
	end
	
	return nil
end

function GM.Worlds:GetVectorWorldSpace( Pos )
	for _, World in pairs( self.tblWorlds ) do
		for _, Bound in pairs( World.Bounds ) do
			if self:VecInBounds( Pos, Bound.Min, Bound.Max ) then
				return World
			end
		end
	end
end

function GM.Worlds:GetEntityWorldSpaceID( ent )
	local Pos = ent:GetPos()

	for id, World in pairs( self.tblWorlds ) do
		for _, Bound in pairs( World.Bounds ) do
			if self:VecInBounds( Pos, Bound.Min, Bound.Max ) then
				return id
			end
		end
	end
end

function GM.Worlds:GetVectorWorldSpaceID( Pos )
	for id, World in pairs( self.tblWorlds ) do
		for _, Bound in pairs( World.Bounds ) do
			if self:VecInBounds( Pos, Bound.Min, Bound.Max ) then
				return id
			end
		end
	end
end

function GM.Worlds:VecInBounds( vecPos, vecMin, vecMax )
	local bInBounds = true

	if vecPos.x <= vecMin.x or vecPos.x >= vecMax.x then
		bInBounds = false
	end

	if vecPos.y <= vecMin.y or vecPos.y >= vecMax.y then
		bInBounds = false
	end
	
	if vecPos.z <= vecMin.z or vecPos.z >= vecMax.z then
		bInBounds = false
	end

	return bInBounds
end

function GM.Worlds:GetWorld( ent )
	return self:GetEntityWorldSpace( ent )
end

function GM.Worlds:OnWorldChanged( ply, world )
	if world == nil then return end
	ply.world = world
	
	if world.OnWorldChanged then
		world:OnWorldChanged( ply )
	end
	
	if SERVER then
		ply:SendMessage("Welcome to World: " .. world.Name, 60, Color(128, 255, 128, 255))
	end
	hook.Call( "SGSPlayerChangedWorld", GAMEMODE, ply, world )
end

function GM.Worlds:CheckEmptyWorlds()
	for k, _ in pairs( self.tblWorlds ) do
		self.tblWorlds[k].occupied = false
		for _, v in pairs( player.GetAll() ) do
			if self:GetEntityWorldSpaceID( v ) == k then
				self.tblWorlds[k].occupied = true
				break
			end
		end
	end
end

if CLIENT then

	net.Receive( "sgs_updatebloodmoon", function( len )
		local bloodmoon = net.ReadBool()
		
		hook.Call( "sgs_updatebloodmoon", GAMEMODE, bloodmoon )
	end )

end

function GM.Worlds:Think()
	if CurTime() < ( self.nextworldcheck or CurTime() - 1 ) then return end
	
	for k, v in pairs( self.tblWorlds ) do
		if v.Think then v:Think() end
	end
	
	local world
	for k, v in pairs( player.GetAll() ) do
		world = self:GetWorld( v )
		
		if world ~= v.world then
			self:OnWorldChanged( v, world )
		end
	end
	self.nextworldcheck = CurTime() + 0.2
end
hook.Add( "Think", "GMS_Think", function( ... ) GAMEMODE.Worlds:Think( ... ) end )

if SERVER then
        util.AddNetworkString "gms_w_wth"
        function GM.Worlds:BroadcastWeatherStatus( pPlayer, strWorldName, intWeatherID, intStartTime, intStopTime )
                net.Start( "gms_w_wth" )
                        net.WriteString( strWorldName )
                        net.WriteBit( intWeatherID ~= nil )
 
                        if intWeatherID then
                                net.WriteUInt( intWeatherID, 4 )
                                net.WriteFloat( intStartTime or 0 )
                                net.WriteFloat( intStopTime or 0 )
                        end
                if pPlayer then
                        net.Send( pPlayer )
                else
                        net.Broadcast()
                end
        end
 
        hook.Add( "PlayerInitialSpawn", "UpdateWorldStatus", function( pPlayer )
                timer.Simple( 5, function()
                        if not IsValid( pPlayer ) then return end
                       
                        for k, v in pairs( GAMEMODE.Worlds.tblWorlds ) do
                                GAMEMODE.Worlds:BroadcastWeatherStatus( pPlayer, v.Name, v.Weather.Current, v.Weather.StartTime, v.Weather.StopTime )
                        end
                end )
        end )
 
        concommand.Add( "sgs_weather", function( pPlayer, _, tblArgs )
				if not pPlayer:IsSuperAdmin() then return end
                local world = GAMEMODE.Worlds:GetEntityWorldSpace( pPlayer )
                if not world then return end
               
                world.Weather.Current = (tblArgs[1] and tonumber(tblArgs[1])) or table.Random( world.Weather.Types )
                world.Weather.StartTime = CurTime()
                world.Weather.StopTime = CurTime() +(tblArgs[2] and tonumber(tblArgs[2])) or 120
 
                GAMEMODE.Worlds:BroadcastWeatherStatus( nil, world.Name, world.Weather.Current, world.Weather.StartTime, world.Weather.StopTime )
        end )
else
        function GM.Worlds:ApplyWorldWeather( tblWorld )
                WHM:ForceStopAll()
               
                if tblWorld.Weather.Current then
                        local duration = tblWorld.Weather.StopTime -tblWorld.Weather.StartTime
                        local timeOffset = CurTime() -tblWorld.Weather.StartTime
 
                        WHM:Start( tblWorld.Weather.Current, duration, timeOffset )
                end
        end
       
        net.Receive( "gms_w_wth", function()
                local worldID = net.ReadString()
                local world
 
                for k, v in pairs( GAMEMODE.Worlds.tblWorlds ) do
                        if v.Name == worldID then world = v break end
                end
 
                if not world then return end
                if net.ReadBit() == 1 then
                        world.Weather.Current = net.ReadUInt( 4 )
                        world.Weather.StartTime = net.ReadFloat()
                        world.Weather.StopTime = net.ReadFloat()
                else
                        world.Weather.Current = nil
                        world.Weather.StartTime = nil
                        world.Weather.StopTime = nil
                end
 
                --if the player is also in this world, force an update
                for _, Bound in pairs( world.Bounds ) do
                        if GAMEMODE.Worlds:VecInBounds( LocalPlayer():GetPos(), Bound.Min, Bound.Max ) then
                                GAMEMODE.Worlds:ApplyWorldWeather( world )
                                break
                        end
                end
        end )
 
        hook.Add( "SGSPlayerChangedWorld", "WorldWeather", function( pPlayer, tblWorld )
                if pPlayer ~= LocalPlayer() then return end
                GAMEMODE.Worlds:ApplyWorldWeather( tblWorld )
        end )
end