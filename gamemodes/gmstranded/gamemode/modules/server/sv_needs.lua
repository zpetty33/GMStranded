local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")

hook.Add( "Think", "NeedsThink", function()
	if CurTime() < ( GAMEMODE.nextneedsthink or CurTime() - 1 ) then return end
	if SGS.noneeds or SGS.inedit then return end
	for _, ply in pairs( player.GetAll() ) do
		if !ply.amode then
			if ply:Alive() then
				if ply.afk == false then
					if ply.tosaccept then
						if ply.needs then
							local thirst_multi = 1
							local hunger_multi = 1
							if ply.sleeping and ply.sheltered then thirst_multi = 5 hunger_multi = 5 end
							if ply.sleeping and not ply.sheltered then thirst_multi = 15 hunger_multi = 15 end
							if GAMEMODE.Worlds:GetEntityWorldSpaceID( ply ) == 4 and not ply:Sheltered() then 
								thirst_multi = thirst_multi * 3 
								hunger_multi = hunger_multi * 3
							end
							if ply.needs["hunger"] >= ( 2 * hunger_multi ) then
								ply.needs["hunger"] = ply.needs["hunger"] - ( 2 * hunger_multi )
							else
								ply.needs["hunger"] = 0
							end
							if not ply.sleeping then
								if ply.needs["fatigue"] >= 1.5 then
									ply.needs["fatigue"] = ply.needs["fatigue"] - 1.5
								else
									ply.needs["fatigue"] = 0
								end
							end
							if ply.needs["thirst"] >= ( 3 * thirst_multi ) then
								ply.needs["thirst"] = ply.needs["thirst"] - ( 3 * thirst_multi )
							else
								ply.needs["thirst"] = 0
							end
							ply:SendNeeds()
						end
					end
				end
			end
		end
	end
	SGS_CheckNeeds()
	GAMEMODE.nextneedsthink = CurTime() + 2
end )

function SGS_CheckNeeds()
	
	for _, ply in pairs( player.GetAll() ) do
		if not ply:Alive() then continue end
		if not ply.tosaccept then continue end
		if not ply.needs then continue end
		local PERCENT_90 = ply.maxneeds * 0.9
		if ply.needs["hunger"] == 0 then
			ply:NeedsHurt(4)
			ply:SendLua("util.ScreenShake( LocalPlayer():GetPos(), 5, 5, 0.5, 0 )")
		end
		if ply.needs["thirst"] == 0 then
			ply:NeedsHurt(8)
			ply:SendLua("util.ScreenShake( LocalPlayer():GetPos(), 50, 50, 0.5, 0 )")
		end
		if ply.needs["fatigue"] == 0 then
			ply.needs["fatigue"] = 1
			SGS_CancelProcess(ply, _, _)
			ply:Sleep(15, false)
			ply.passedout = true
		end
		if ply.o2 <= 0 then
			ply:NeedsHurt(10)
			ply:SendLua("util.ScreenShake( LocalPlayer():GetPos(), 20, 20, 0.5, 0 )")
		end
		
		
		if ply.needs["hunger"] >= PERCENT_90 and ply.needs["thirst"] >= PERCENT_90 then
			if ply:Health() < ply:GetMaxHealth() / 2 then
				ply:Heal(1)
			end
		end
	end
	
end

function PlayerMeta:NeedsHurt(amt)
	self:SetHealth(self:Health() - amt)
	self:EmitSound(Sound("player/pl_pain5.wav"), 60, math.random(70, 130))
	if ( self.needs["thirst"] == 0 ) and ( self:Health() <= 0 ) then
		self.killstring = "Thirst"
		self:Kill()
		SGS_Log( self:Nick() .. " died of dehydration." )
		self:AddStat( "general7", 1 )
		for _, v in pairs( player.GetAll() ) do
			v:SendMessage("" .. self:Nick() .. " died of dehydration.. :(", 60, Color(255, 0, 255, 255))
		end
		return
	end
	if ( self.needs["hunger"] == 0 ) and ( self:Health() <= 0 ) then
		self.killstring = "Starvation"
		self:Kill()
		SGS_Log( self:Nick() .. " died of starvation." )
		self:AddStat( "general6", 1 )
		for _, v in pairs( player.GetAll() ) do
			v:SendMessage("" .. self:Nick() .. " died of starvation.. :(", 60, Color(255, 0, 255, 255))
		end
		return
	end
	if ( self.o2 <= 0 ) and ( self:Health() <= 0 ) then
		self.killstring = "Drowning"
		self:Kill()
		SGS_Log( self:Nick() .. " died of asphyxiation." )
		self:AddStat( "general10", 1 )
		for _, v in pairs( player.GetAll() ) do
			v:SendMessage("" .. self:Nick() .. " died of asphyxiation.. :(", 60, Color(255, 0, 255, 255))
		end
		return
	end
end

function PlayerMeta:SendNeeds()

	net.Start("sgs_updateneeds")
		net.WriteInt( self.needs["fatigue"], 32 )
		net.WriteInt( self.needs["hunger"], 32 )
		net.WriteInt( self.needs["thirst"], 32 )
	net.Send( self )

end