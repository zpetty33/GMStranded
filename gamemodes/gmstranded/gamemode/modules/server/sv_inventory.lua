local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")

local cantDrop = { "quest_reward" }

function PlayerMeta:RecalculateMaxInv()
	local pslvl = self.level[ "survival" ]

	local minv = ( (pslvl - 1) * 10 ) + 120 --Set Max Inventory
	self.maxinv = minv

	if self:GetAch("inventory1") then
		self.maxinv = self.maxinv + 50
	end

	if self:GetAch("inventory2") then
		self.maxinv = self.maxinv + 100
	end

	if self:IsMember() then
		self.maxinv = self.maxinv + math.floor(self.maxinv * 0.10)
	end

	if self:IsDonator() then
		self.maxinv = self.maxinv + math.floor(self.maxinv * 0.15)
	end

	self:SendLua("SGS.maxinv = " .. self.maxinv)
	self:ConCommand("sgs_refreshfarming")
end

function SGS_ConRelculateMaxInv(ply, com, args)
	ply:RecalculateMaxInv()
end
concommand.Add("sgs_recalculatemaxinv", SGS_ConRelculateMaxInv)

function PlayerMeta:RefreshMenus()
	if not (self:GetInitialized() == INITSTATE_OK) then return end
	self:ConCommand("sgs_refreshfarming")
	self:SendLua("CalculateCurrentInventory()")
end

function PlayerMeta:AddResource( res, amt, ent )

	local ovr = 0

	if amt <= 0 then
		self:SendMessage("You can't drop a negative amount!!!", 60, Color(255, 0, 0, 255))
		return
	end

	if self.curinv + amt <= self.maxinv then
		amt = amt
		ovr = 0
	end

	if self.curinv >= self.maxinv then
		self:SendMessage("Your inventory is full!", 60, Color(255, 0, 0, 255))
		self:DropResource( res, amt, true, false )
		return
	end

	if self.curinv + amt > self.maxinv then
		ovr = (self.curinv + amt) - self.maxinv
		amt = amt - ovr

		local nAmt = ( self.resource[ res ] or 0 ) + amt

		self:SendMessage("" .. amt .. "x " .. CapAll(string.gsub(res, "_", " ")) .. " added.", 60, Color(180, 255, 0, 255))
		self:SetResource( res, nAmt )

		self.curinv = self.curinv + amt
		self:DropResource( res, ovr, true, false )
		return
	end

	local nAmt = ( self.resource[ res ] or 0 ) + amt
	self.curinv = self.curinv + amt
	self:SendMessage("" .. amt .. "x " .. CapAll(string.gsub(res, "_", " ")) .. " added.", 60, Color(180, 255, 0, 255))
	self:SetResource( res, nAmt )
end

function PlayerMeta:GetResource( res )
	return self.resource[ res ] or 0
end

function PlayerMeta:AddResourceSilent( res, amt )

	local ovr = 0

	if amt <= 0 then
		self:SendMessage("You can't drop a negative amount!!!", 60, Color(255, 0, 0, 255))
		return
	end

	if self.curinv + amt <= self.maxinv then
		amt = amt
		ovr = 0
	end

	if self.curinv >= self.maxinv then
		self:SendMessage("Your inventory is full!", 60, Color(255, 0, 0, 255))
		self:DropResource( res, amt, true, false )
		return
	end

	if self.curinv + amt > self.maxinv then
		ovr = (self.curinv + amt) - self.maxinv
		amt = amt - ovr

		local nAmt = ( self.resource[ res ] or 0 ) + amt

		--self:SendMessage("" .. amt .. "x " .. CapAll(string.gsub(res, "_", " ")) .. " added.", 60, Color(180, 255, 0, 255))
		self:SetResource( res, nAmt )

		self.curinv = self.curinv + amt
		self:DropResource( res, ovr, true, false )
		return
	end

	local nAmt = ( self.resource[ res ] or 0 ) + amt
	self.curinv = self.curinv + amt
	--self:SendMessage("" .. amt .. "x " .. CapAll(string.gsub(res, "_", " ")) .. " added.", 60, Color(180, 255, 0, 255))
	self:SetResource( res, nAmt )
	
end

function PlayerMeta:SubResource( res, amt )
	local nAmt = ( self.resource[ res ] or 0 ) - amt
	if nAmt < 0 then
		nAmt = 0
	end
	self.curinv = self.curinv - amt
	self:SetResource( res, nAmt )
end

function PlayerMeta:SetResource( res, amt )
	if amt < 0 then
		amt = 0
	end
	self.resource[ res ] = amt

	net.Start("sgs_updateresource")
		net.WriteString( res )
		net.WriteInt( amt, 32 )
	net.Send(self)

	self:RefreshMenus()
end

function PlayerMeta:SetGTokens( amt )

	self.gtokens["tokens"] = amt
	net.Start("sgs_receivegtoken")
		net.WriteInt( amt, 32 )
	net.Send( self )

end

function PlayerMeta:GiveGTokens( amt )

	local cgt = self.gtokens["tokens"]
	local ngt = cgt + amt

	self:SetGTokens(ngt)
	self:SendMessage("You received " .. amt .. "x GTokens.", 60, Color(0, 255, 0, 255))

end

function PlayerMeta:RemoveGToken( amt, override )

	local cgt = self.gtokens["tokens"]
	local ngt = cgt - amt

	if override then
		self:SetGTokens(ngt)
	else
		if ngt < 0 then ngt = 0 end
		self:SetGTokens(ngt)
	end

end

function PlayerMeta:GTokens()

	return self.gtokens["tokens"]

end

function SGS_AddGTokenToSID(ply, com, args)

	if !IsValid( ply ) or ply:IsSuperAdmin() then

		if #args != 2 then
			SGS_SendMessage(ply, "Wrong number of arguements!")
			return
		end

		local SID = tostring(args[1])
		local toadd = tonumber(args[2])

		for k, v in pairs(player.GetAll()) do
			if v:GetPlayerID() == SID then
				v:GiveGTokens(toadd)
				v:SaveCharacter()
				SGS_SendMessage(ply, "User found and GTokens added")
				SGS.Log("** (CONSOLE) gave " .. toadd .. "x GTokens to " .. v:Nick() .. "!")
				return
			end
		end
		SGS_SendMessage(ply, "Player not connected. Checking save files...")
		if file.Exists("SGStranded/NewSaves/"..SID..".txt", "DATA") then
			local decode = util.JSONToTable( file.Read( "SGStranded/NewSaves/" .. SID .. ".txt", "DATA" ) )
			decode.gtokens.tokens = decode.gtokens.tokens + toadd

			file.Write( "SGStranded/NewSaves/" .. SID .. ".txt", util.TableToJSON( decode, true ) )
			SGS_SendMessage(ply, "User found and GTokens added")
			SGS.Log("** (CONSOLE) gave " .. toadd .. "x GTokens to " .. SID .. "!")
		else
			SGS_SendMessage(ply, "There was no user save for SID: " .. SID)
		end

	else
		SGS_SendMessage(ply, "This command is reserved for Administrators only!")
		return
	end

end
concommand.Add( "sgs_addgtokenbyid", SGS_AddGTokenToSID )

function PlayerMeta:SynchResources()

	local cinv = 0
	for k, v in pairs(self.resource) do
		cinv = cinv + v
	end
	self.curinv = cinv

	net.Start( "sgs_sendresourcestable" )
		net.WriteTable( self.resource )
	net.Send( self )

end

function PlayerMeta:ClearResources()
	self:SendLua("SGS_ClearResource()")
	self.resource = {}
	self.curinv = 0
end

function SGS_CanDropResource( rType )
	if table.HasValue( cantDrop, rType ) then
		return false
	else
		return true
	end
end

function PlayerMeta:DropResource2( rType, rAmt )
	if not SGS_CanDropResource(rType) then
		self:SendMessage( CapAll(string.gsub(rType, "_", " ")) .. " can not be dropped.", 60, Color(255, 0, 0, 255))
		return
	end
	local found = nil

	for k, v in pairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
		if v.cb == false then continue end
		if v.rType == rType then
			if v:GetClass() == "gms_resourcedrop" then
				found = v
				break
			end
		end
	end

	if IsValid(found) then

		found.rAmt = found.rAmt + rAmt
		found:SetResourceDropInfo( rType, found.rAmt )
		SGS_SetupDrop( found, rType, found.rAmt )
		self:SendMessage("" .. rAmt .. "x " .. CapAll(string.gsub(found.rType, "_", " ")) .. " added to nearby box.", 60, Color(0, 255, 0, 255))

	else

		local ent = ents.Create("gms_resourcedrop")
		ent:SetPos(self:TraceFromEyes(60).HitPos + Vector(0,0,15))
		ent:SetAngles(self:GetAngles() - Angle( 90, 0, 0 ))
		ent:Spawn()
		ent.die = CurTime() + 180
		ent:GetPhysicsObject():Wake()

		ent.rType = rType
		ent.rAmt = rAmt

		ent:SetResourceDropInfo( ent.rType, ent.rAmt )
		SGS_SetupDrop( ent, rType, rAmt )

	end
end

function PlayerMeta:DropResource( rType, rAmt, own, sub, combine )
	if not SGS_CanDropResource(rType) then
		self:SendMessage( CapAll(string.gsub(rType, "_", " ")) .. " can not be dropped.", 60, Color(255, 0, 0, 255))
		return
	end
	if sub then
		self:SubResource( rType, rAmt )
	end

	local found = nil

	if not combine then

		for k, v in pairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
			if v.cb == false then continue end

			if v.rType == rType then
				if v:GetClass() == "gms_resourcedrop" then
					found = v
					break
				end
			end

		end

	end

	if found and not ( found.rAmt == nil ) then

		found.rAmt = found.rAmt + rAmt
		found:SetResourceDropInfo( rType, found.rAmt )
		SGS_SetupDrop( found, rType, found.rAmt )
		self:SendMessage("" .. rAmt .. "x " .. CapAll(string.gsub(found.rType, "_", " ")) .. " added to nearby box.", 60, Color(0, 255, 0, 255))

	else
		local ent = ents.Create("gms_resourcedrop")
		ent:SetPos(self:TraceFromEyes(60).HitPos + Vector(0,0,15))
		ent:SetAngles(self:GetAngles() - Angle( 90, 0, 0 ))
		ent:Spawn()
		if own then
			--SPP MAKE PLAYER OWNER--
			ent:CPPISetOwner(self)
			-------------------------
		else
			ent:CPPISetOwnerless(true)
			ent.ownerless = true
			timer.Simple( 300, function() SGS_MarkForDeletionOwnerless( ent ) end )
		end

		ent:GetPhysicsObject():Wake()

		ent.rType = rType
		ent.rAmt = rAmt

		ent:SetResourceDropInfo( ent.rType, ent.rAmt )
		SGS_SetupDrop( ent, rType, rAmt )
		self:SendMessage("" .. ent.rAmt .. "x " .. CapAll(string.gsub(ent.rType, "_", " ")) .. " dropped.", 60, Color(0, 255, 0, 255))
	end
end

function SGS_MakeResourceDrop( rType, rAmt, pos )
	local ent = ents.Create("gms_resourcedrop")

	ent:SetPos(pos)
	ent:Spawn()
	ent:CPPISetOwnerless(true)
	ent.ownerless = true
	timer.Simple( 300, function() SGS_MarkForDeletionOwnerless( ent ) end )
	ent:GetPhysicsObject():Wake()

	ent.rType = rType
	ent.rAmt = rAmt

	ent:SetResourceDropInfo( ent.rType, ent.rAmt )
	SGS_SetupDrop( ent, rType, rAmt )
end

function PlayerMeta:DeathDropResources()

	local slvl = self.level[ "survival" ]
	local lvlmodi = slvl * 0.6

	local tbl_dropped = {}
	local tbl_destroy = {}

	for k, v in pairs(self.resource) do
		local dropamt = 0
		local destroyamt = 0

		if math.random(1,100) + lvlmodi > 45 then
			local amt = math.random( math.ceil( v / 2 ), v )
			if amt > 0 then
				self:DropResource( k, amt, false, true )
				dropamt = amt
			end
		end

		if not SGS_CanDropResource(rType) then
			dropamt = 0
		end

		destroyamt = v - dropamt

		tbl_dropped[k] = dropamt
		tbl_destroy[k] = destroyamt

	end

	self:ClearResources()

	return tbl_dropped, tbl_destroy

end

function SGS_ChatDropResource( ply, text, public )
    if ( string.sub( string.lower(text), 1, 5 ) == "!drop" ) then
		if ply.inprocess then
			ply:SendMessage("You can't do this while you are performing an action.", 60, Color(255, 0, 0, 255))
			return false
		end

		if not ply:Alive() then
			ply:SendMessage("You can't drop items while dead.", 60, Color(255, 0, 0, 255))
			return
		end

		local args = string.Explode(" ", text)
		if args[2] == nil or args[3] == nil then
			ply:SendMessage("Wrong number of arguements. !drop <resource> [amount].", 60, Color(0, 255, 0, 255))
			return false
		end

		if not ply.resource[ args[2] ] then
			ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[2], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
			return false
		end

		if ply.resource[ args[2] ] <= 0 then
			ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[2], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
			return false
		end

		if #args == 2 then
			args[3] = ply.resource[ args[2] ]
		end

		if not tonumber(args[3]) then
			args[3] = ply.resource[ args[2] ]
		end

		if tostring(tonumber(args[3])) == tostring(tonumber("nan")) then
			SGS_Log( "!!!!!!!!!!!" .. ply:Nick() .. " is trying to 'nan' dupe an item.")
			ply:SendMessage("This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
			return false
		end

		if tonumber(args[3]) <= 0 then
			ply:SendMessage("You can not drop an empty resource box.", 60, Color(0, 255, 0, 255))
			return false
		end

		if tonumber(args[3]) > ply.resource[ args[2] ] then
			args[3] = ply.resource[ args[2] ]
		end

        ply:DropResource( string.lower(args[ 2 ]), math.floor(tonumber(args[ 3 ])), true, true )
		return false
    end
end
hook.Add( "PlayerSay", "SGS_ChatDropResource", SGS_ChatDropResource )

function SGS_ConDropResource( ply, com, args )
	if ply.inprocess then
		ply:SendMessage("You can't do this while you are performing an action.", 60, Color(255, 0, 0, 255))
		return false
	end

	if not ply:Alive() then
		ply:SendMessage("You can't drop items while dead.", 60, Color(255, 0, 0, 255))
		return
	end

	if #args > 2 then
		ply:SendMessage("Too many arguements. gms_dropresource <resource> [amount].", 60, Color(0, 255, 0, 255))
		return
	end

	if not ply.resource[ args[1] ] then
		ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
		return
	end

	if ply.resource[ args[1] ] <= 0 then
		ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
		return
	end

	if #args == 1 then
		args[2] = ply.resource[ args[1] ]
	end

	if not tonumber(args[2]) then
		args[2] = ply.resource[ args[1] ]
	end

	if tostring(tonumber(args[2])) == tostring(tonumber("nan")) then
		SGS_Log( "!!!!!!!!!!!" .. ply:Nick() .. " is trying to 'nan' dupe an item.")
		ply:SendMessage("This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
		return false
	end

	if tonumber(args[2]) <= 0 then
		ply:SendMessage("You can not drop an empty resource box.", 60, Color(0, 255, 0, 255))
		return false
	end

	if tonumber(args[2]) > ply.resource[ args[1] ] then
		args[2] = ply.resource[ args[1] ]
	end

	ply:DropResource( string.lower(args[ 1 ]), math.floor(tonumber(args[ 2 ])), true, true )
end
concommand.Add( "sgs_dropresource", SGS_ConDropResource )

function SGS_ConDropResource2( ply, com, args )
	if ply.inprocess then
		ply:SendMessage("You can't do this while you are performing an action.", 60, Color(255, 0, 0, 255))
		return false
	end

	if not ply:Alive() then
		ply:SendMessage("You can't drop items while dead.", 60, Color(255, 0, 0, 255))
		return
	end

	if #args > 2 then
		ply:SendMessage("Too many arguements. gms_dropresource <resource> [amount].", 60, Color(0, 255, 0, 255))
		return
	end

	if not ply.resource[ args[1] ] then
		ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
		return
	end

	if ply.resource[ args[1] ] <= 0 then
		ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
		return
	end

	if #args == 1 then
		args[2] = ply.resource[ args[1] ]
	end

	if not tonumber(args[2]) then
		args[2] = ply.resource[ args[1] ]
	end

	if tostring(tonumber(args[2])) == tostring(tonumber("nan")) then
		SGS_Log( "!!!!!!!!!!!" .. ply:Nick() .. " is trying to 'nan' dupe an item.")
		ply:SendMessage("This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
		return false
	end

	if tonumber(args[2]) <= 0 then
		ply:SendMessage("You can not drop an empty resource box.", 60, Color(0, 255, 0, 255))
		return false
	end

	if tonumber(args[2]) > ply.resource[ args[1] ] then
		args[2] = ply.resource[ args[1] ]
	end

	ply:DropResource( string.lower(args[ 1 ]), math.floor(tonumber(args[ 2 ])), false, true )
end
concommand.Add( "sgs_dropresource2", SGS_ConDropResource2 )

function SGS_ConDestroyResource( ply, com, args )

		if #args > 2 then
			ply:SendMessage("Too many arguements. gms_destroyresource <resource> [amount].", 60, Color(0, 255, 0, 255))
			return
		end

		if not ply.resource[ args[1] ] then
			ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
			return
		end

		if ply.resource[ args[1] ] <= 0 then
			ply:SendMessage("You currently do not have any: " .. CapAll(string.gsub(args[1], "_", " ")) ..".", 60, Color(0, 255, 0, 255))
			return
		end

		if #args == 1 then
			args[2] = ply.resource[ args[1] ]
		end

		if not tonumber(args[2]) then
			args[2] = ply.resource[ args[1] ]
		end

		if tostring(tonumber(args[2])) == tostring(tonumber("nan")) then
			SGS_Log( "!!!!!!!!!!!" .. ply:Nick() .. " is trying to 'nan' dupe an item.")
			ply:SendMessage("This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
			return false
		end

		if tonumber(args[2]) <= 0 then
			ply:SendMessage("You can not destroy what you do not have.", 60, Color(0, 255, 0, 255))
			return false
		end

		if tonumber(args[2]) > ply.resource[ args[1] ] then
			args[2] = ply.resource[ args[1] ]
		end

		ply:SubResource( string.lower(args[ 1 ]), math.floor(tonumber(args[ 2 ])) )
		ply:SendMessage("" .. math.floor(tonumber(args[ 2 ])) .. "x " .. CapAll(string.gsub(args[1], "_", " ")) .. " destroyed.", 60, Color(0, 255, 255, 255))

end
concommand.Add( "sgs_destroyresource", SGS_ConDestroyResource )

function SGS_ConTakeResource( ply, com, args )

	if ply.inprocess then
		ply:SendMessage("You can't do this while you are performing an action.", 60, Color(255, 0, 0, 255))
		return false
	end

	local tr = ply:TraceFromEyes(180)
	local rbox = tr.Entity
	if tr.Entity == nil then
		ply:SendMessage("You need to be looking at a resource drop.", 60, Color(255, 0, 0, 255))
		return false
	end
	if not ( tr.Entity:GetClass() == "gms_resourcedrop" ) then
		ply:SendMessage("You need to be looking at a resource drop.", 60, Color(255, 0, 0, 255))
		return false
	end

	if not ( rbox:CPPICanTool(ply, true) ) then
		ply:SendMessage("You don't have permission to take from this box.", 60, Color(255, 0, 0, 255))
		return false
	end

	if args[1] == nil then
		args[1] = rbox.rAmt
	end

	if tostring(tonumber(args[1])) == tostring(tonumber("nan")) then
		SGS_Log( "!!!!!!!!!!!" .. ply:Nick() .. " is trying to 'nan' dupe an item.")
		ply:SendMessage("This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
		return false
	end

	if tonumber(args[1]) <= 0 then
		ply:SendMessage("You can't take nothing from this box.", 60, Color(0, 255, 0, 255))
		return false
	end

	if tonumber(args[1]) > rbox.rAmt then
		ply:SendMessage("You can't take more than the box has. Taking: " .. rbox.rAmt, 60, Color(0, 255, 0, 255))
		args[1] = rbox.rAmt
	end

	local new_amt = rbox.rAmt - tonumber(args[1])

	rbox:SetResourceDropInfo( rbox.rType, new_amt )
	SGS_SetupDrop( rbox, rbox.rType, new_amt )
	timer.Simple( 0.1, function() if rbox.rAmt <= 0 then rbox:Remove() end end )
	ply:AddResource( rbox.rType, tonumber(args[1]) )
	SGS.Log("** " .. tonumber(args[1]) .. "x of " .. rbox.rType .. " was taken from a resource box by " .. ply:Nick() .. "!")

	return false

end
concommand.Add( "sgs_take", SGS_ConTakeResource )

function SGS_ChatTakeResource( ply, text, public )

    if ( string.sub( string.lower(text), 1, 5 ) == "!take" ) then
		if ply.inprocess then
			ply:SendMessage("You can't do this while you are performing an action.", 60, Color(255, 0, 0, 255))
			return false
		end

		local tr = ply:TraceFromEyes(180)
		local rbox = tr.Entity
		if tr.Entity == nil then
			ply:SendMessage("You need to be looking at a resource drop.", 60, Color(255, 0, 0, 255))
			return false
		end
		if not ( tr.Entity:GetClass() == "gms_resourcedrop" ) then
			ply:SendMessage("You need to be looking at a resource drop.", 60, Color(255, 0, 0, 255))
			return false
		end

		if not ( rbox:CPPICanTool(ply, true) ) then
			ply:SendMessage("You don't have permission to take from this box.", 60, Color(255, 0, 0, 255))
			return false
		end

		local args = string.Explode(" ", text)
		if args[2] == nil then
			args[2] = rbox.rAmt
		end

		if tostring(tonumber(args[2])) == tostring(tonumber("nan")) then
			SGS_Log( "!!!!!!!!!!!" .. ply:Nick() .. " is trying to 'nan' dupe an item.")
			ply:SendMessage("This is a known exploit. This action has been logged!!", 60, Color(255, 0, 0, 255))
			return false
		end

		if tonumber(args[2]) <= 0 then
			ply:SendMessage("You can't take nothing from this box.", 60, Color(0, 255, 0, 255))
			return false
		end

		if tonumber(args[2]) > rbox.rAmt then
			ply:SendMessage("You can't take more than the box has. Taking: " .. rbox.rAmt, 60, Color(0, 255, 0, 255))
			args[2] = rbox.rAmt
		end

		local new_amt = rbox.rAmt - tonumber(args[2])

		rbox:SetResourceDropInfo( rbox.rType, new_amt )
		SGS_SetupDrop( rbox, rbox.rType, new_amt )
		timer.Simple( 0.1, function() if rbox.rAmt <= 0 then rbox:Remove() end end )
		ply:AddResource( rbox.rType, tonumber(args[2]) )
		SGS.Log("** " .. tonumber(args[2]) .. "x of " .. rbox.rType .. " was taken from a resource box by " .. ply:Nick() .. "!")

		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatTakeResource", SGS_ChatTakeResource )

function PlayerMeta:MakeResource( rType, rAmt )

		if not self:IsAdmin() then
			self:SendMessage("This is a developer command!", 60, Color(0, 255, 0, 255))
			return
		end

		local ent = ents.Create("gms_resourcedrop")
		ent:SetPos(self:TraceFromEyes(60).HitPos + Vector(0,0,15))
		ent:SetAngles(self:GetAngles() - Angle( 90, 0, 0 ))
		ent:Spawn()
		--SPP MAKE PLAYER OWNER--
		--ent:CPPISetOwner(self)
		-------------------------

		ent:GetPhysicsObject():Wake()

		ent.rType = rType
		ent.rAmt = rAmt

		ent:SetResourceDropInfo( ent.rType, ent.rAmt )
		SGS_SetupDrop( ent, rType, rAmt )
		self:SendMessage("" .. ent.rAmt .. "x " .. CapAll(string.gsub(ent.rType, "_", " ")) .. " dropped.", 60, Color(0, 255, 0, 255))

end


function SGS_ChatMakeResource( ply, text, public )

    if ( string.sub( string.lower(text), 1, 5 ) == "!make" ) then
    	-- We need this damnit...
		if not ply:IsSuperAdmin() then
			ply:SendMessage("This is a developer command.", 60, Color(255, 0, 0, 255))
			return false
		end

		local args = string.Explode(" ", text)
		if #args > 3 then
			ply:SendMessage("Too many arguements. !make <resource> [amount].", 60, Color(255, 0, 0, 255))
			return false
		end

		if #args == 2 then
			args[3] = 10
		end

		if not tonumber(args[3]) then
			args[3] = 10
		end

		if tonumber(args[3]) == 0 then
			args[3] = 10
			return false
		end

        ply:MakeResource( string.lower(args[ 2 ]), tonumber(args[ 3 ]) )
		return false
    end

end
hook.Add( "PlayerSay", "SGS_ChatMakeResource", SGS_ChatMakeResource )

function SGS_SetupDrop( ent, res, amt )

	local tbl = {}

	table.insert( tbl, ent )
	table.insert( tbl, CapAll(string.gsub(res,"_"," ")) )
	table.insert( tbl, amt )

	timer.Simple(0.1, function()
		net.Start("UpdateResourceCrate")
			net.WriteTable( tbl )
		net.Broadcast()
	end )

end

net.Receive( "sgs_updateresourcebox", function( len, ply )

	local ent = net.ReadEntity()
	ply:SetupDrop( ent, ent.rType, ent.rAmt )

end )

function SGS_SendAllDrops()
	for k, v in pairs(ents.FindByClass("gms_resourcedrop")) do
		SGS_SetupDrop( v, CapAll(string.gsub(v.rType,"_"," ")), v.rAmt )
	end
end

function PlayerMeta:SendAllDrops()
	for k, v in pairs(ents.FindByClass("gms_resourcedrop")) do
		self:SetupDrop( v, CapAll(string.gsub(v.rType,"_"," ")), v.rAmt )
	end
end

function PlayerMeta:SetupDrop( ent, res, amt )
	local tbl = {}

	table.insert( tbl, ent )
	table.insert( tbl, CapAll(string.gsub(res or "","_"," ")) )
	table.insert( tbl, amt )

	timer.Simple(0.1, function()
		net.Start("UpdateResourceCrate")
			net.WriteTable( tbl )
		net.Send( self )
	end )
end

