local PlayerMeta = FindMetaTable("Player")

SGS.voicechannels = {}
SGS.voicechannelid = 1


function GM:PlayerCanHearPlayersVoice( plOne, plTwo )
	if not (plOne:GetInitialized() == INITSTATE_OK) then return end
	if not (plTwo:GetInitialized() == INITSTATE_OK) then return end

	if plOne.adminoverride then return true end
	if plTwo.adminoverride then return true end

	if plOne.voiceid == nil then plOne.voiceid = "A" end
	if plTwo.voiceid == nil then plTwo.voiceid = "A" end
	
	if plOne.voiceid == "A" or plTwo.voiceid == "A" then
		if plOne.voiceid == plTwo.voiceid then
			return true
		else
			return false
		end
	elseif plOne.voiceid == "W" or plTwo.voiceid == "W" then
		if plOne.voiceid == plTwo.voiceid then
			if plOne.world == plTwo.world then
				return true
			else
				return false
			end
		else
			return false
		end	
	elseif plOne.voiceid == "T" or plTwo.voiceid == "T" then
		if plOne.voiceid == plTwo.voiceid then
			if plOne.tribe == plTwo.tribe then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		if plOne.voiceid == plTwo.voiceid then
			return true
		else
			return false
		end
	end
end

function PlayerMeta:SetVoiceGroup( groupid )

	local oldchannel = self.voiceid
	
	if oldchannel ~= "A" then
		for k, v in pairs(player.GetAll()) do
			if v == self then continue end
			if v.voiceid == oldchannel then
				v:SendMessage(self:Nick() .. " has left your voice channel.", 60, Color(255, 100, 100, 255))
			end
		end
	end
	
	self.voiceid = tostring(groupid)
	self:SetNWString("voicechannel", self.voiceid)
end

function SGS_CreateVoiceChannel( name, password, ply )

	local newchan = {}
	
	newchan.name = name
	newchan.id = tostring(SGS.voicechannelid)
	SGS.voicechannelid = SGS.voicechannelid + 1
	
	if password == nil then
		newchan.ispassworded = false
	else
		newchan.ispassworded = true
		newchan.password = password
	end
	
	newchan.creator = ply:Nick()
	newchan.creatorid = ply:SteamID()
	
	table.insert(SGS.voicechannels, newchan )
	
	local tbl = table.Copy( SGS.voicechannels )
	for k, v in pairs( tbl ) do
		tbl[k].password = "**HIDDEN**"
	end
	
	net.Start("UpdateVoiceChannels")
		net.WriteTable( tbl )
	net.Broadcast()

end

function PlayerMeta:RequestUpdatedVCList()

	net.Start("UpdateVoiceChannels")
		net.WriteTable( SGS.voicechannels )
	net.Send( self )

end

function PlayerMeta:VCAdminOverride()

	if self.adminoverride then
		self.adminoverride = false
		self:SetNWString("voicechannel", tostring(self.voiceid))
		SGS_SendMessage(self, "Admin override deactivated. You can only speak with players in your channel!")
	else
		self.adminoverride = true
		self:SetNWString("voicechannel", tostring("ALL"))
		SGS_SendMessage(self, "Admin override activated. You can hear all players and all players can hear you!")
	end

end

function SGS_ConVCAdminOverride( ply, com, args )

	if not ply:IsAdmin() then
		SGS_SendMessage(self, "This command is for admins only!")
		return
	end
	
	ply:VCAdminOverride()

end
concommand.Add( "sgs_vcadminoverride", SGS_ConVCAdminOverride )

function SGS_ConRequestVCList( ply, com, args )

	ply:RequestUpdatedVCList()

end
concommand.Add( "sgs_requestvclist", SGS_ConRequestVCList )

function SGS_ConCreateVoiceChannel( ply, com, args )

	if #args < 1 or #args > 2 then
		SGS_SendMessage(ply, "Wrong number of arguements!")
		return
	end
	
	if string.len(args[1]) > 50 then
		ply:SendMessage("Channel names must be less than 50 characters!", 60, Color(255, 0, 0, 255))
		return
	end
	
	SGS_CreateVoiceChannel( args[1], args[2], ply )
	SGS_SendMessage(ply, "New voice channel ( " .. args[1] .. " ) created!")
	
	if args[2] then
		SGS_SendMessage(ply, "This channel was created with the password: " ..args[2])
	end

end
concommand.Add( "sgs_createvoicechannel", SGS_ConCreateVoiceChannel )

function SGS_ConListVoiceChannels( ply, com, args )

	SGS_SendMessage(ply, "G4P VOICE CHANNEL DIRECTORY")
	SGS_SendMessage(ply, " ")
	SGS_SendMessage(ply, " ")
	SGS_SendMessage(ply, " ")
	
	for k, v in pairs(SGS.voicechannels) do
		if v.ispassworded then
			SGS_SendMessage(ply, "Channel: " .. k .. " :: " .. v.name .. "     ***PASSWORDED***")
		else
			SGS_SendMessage(ply, "Channel: " .. k .. " :: " .. v.name)
		end
	end
	SGS_SendMessage(ply, " ")
	SGS_SendMessage(ply, " ")
	SGS_SendMessage(ply, "To join a voice channel type the following into your console:")
	SGS_SendMessage(ply, "sgs_joinvoicechannel <ChannelID> <password>")
	SGS_SendMessage(ply, " ")
	SGS_SendMessage(ply, "sgs_joinvoicechannel 0        --Will bring you back to the default public channel.")
	SGS_SendMessage(ply, " ")
	SGS_SendMessage(ply, " ")
	SGS_SendMessage(ply, " ")

end
concommand.Add( "sgs_listvoicechannels", SGS_ConListVoiceChannels )

function SGS_ConJoinVoiceChannel( ply, com, args )

	print(tonumber(args[1]))

	if #args < 1 or #args > 2 then
		SGS_SendMessage(ply, "Wrong number of arguements!")
		return
	end
	
	if tostring(args[1]) == "A" then
		ply:SetVoiceGroup( "A" )
		ply:SendMessage("You are now in voice channel: Default AllTalk", 60, Color(0, 255, 255, 255))
		return
	end
	
	if tostring(args[1]) == "T" then
		ply:SetVoiceGroup( "T" )
		ply:SendMessage("You are now in voice channel: Tribe Channel", 60, Color(0, 255, 255, 255))
		return
	end
	
	if tostring(args[1]) == "W" then
		ply:SetVoiceGroup( "W" )
		ply:SendMessage("You are now in voice channel: Local World", 60, Color(0, 255, 255, 255))
		return
	end
	
	if SGS.voicechannels[tonumber(args[1])] == nil then
		SGS_SendMessage(ply, "This channel does not exist! To create it type sgs_createvoicechannel <name> <password(optional)>")
		return
	end
	
	if SGS.voicechannels[tonumber(args[1])].ispassworded then
		if args[2] != SGS.voicechannels[tonumber(args[1])].password then
			SGS_SendMessage(ply, "Invalid password for this channel. Please contact the channel owner for the correct password.")
			return
		end
	end
	
	if SGS.voicechannels[tonumber(args[1])].banned then
		SGS_SendMessage(ply, "This channel is banned and can not be joined.")
		return
	end
	
	ply:SetVoiceGroup( tostring(tonumber(args[1])) )
	ply:SendMessage("You are now in voice channel: " .. SGS.voicechannels[tonumber(args[1])].name, 60, Color(0, 255, 255, 255))
	
	for k, v in pairs(player.GetAll()) do
		if ( v.voiceid == tostring(tonumber(args[1])) ) and ( v != ply ) then
			v:SendMessage(ply:Nick() .. " has joined your voice channel.", 60, Color(0, 255, 255, 255))
		end
	end

end
concommand.Add( "sgs_joinvoicechannel", SGS_ConJoinVoiceChannel )

function SGS_RemoveVoiceChannel( ply, com, args )

	if not ply:IsAdmin() then
		SGS_SendMessage(self, "This command is for admins only!")
		return
	end
	
	if not #args == 1 then
		SGS_SendMessage(ply, "Wrong number of arguements!")
		return
	end
	
	SGS.voicechannels[tonumber(args[1])].banned = true
	table.insert(SGS.voicechannels, newchan )
	net.Start("UpdateVoiceChannels")
		net.WriteTable( SGS.voicechannels )
	net.Broadcast()
	
	for k, v in pairs( player.GetAll() ) do
		if v.voiceid == tostring(tonumber(args[1])) then
			v.voiceid = 0
			v:SetNWString("voicechannel", "A")
			v:SendMessage("Your channel has been disbanded by an admin", 60, Color(255,0,0))
		end
	end

end
concommand.Add( "sgs_removevc", SGS_RemoveVoiceChannel )

function SGS_ChatRemoveVC( ply, text, public )

    if ( string.sub( string.lower(text), 1, 9 ) == "!removevc" ) then
		local args = string.Explode(" ", text)
		if args[2] == nil then
			ply:SendMessage("Wrong number of arguements. !removevc <Channel ID>.", 60, Color(0, 255, 0, 255))
			return false
		end

        SGS_RemoveVoiceChannel( ply, _, { args[2] } )
		return false
    end
	
end
hook.Add( "PlayerSay", "SGS_ChatRemoveVC", SGS_ChatRemoveVC )