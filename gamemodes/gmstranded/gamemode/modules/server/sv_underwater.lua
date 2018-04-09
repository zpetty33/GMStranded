local PlayerMeta = FindMetaTable("Player")

function SGS_CheckUnderWater()
	if SGS.nextwatercheck == nil then SGS.nextwatercheck = CurTime() end
	if CurTime() < SGS.nextwatercheck then return end

	for k, v in pairs(player.GetAll()) do
		if not IsValid(v) then continue end
		if not v:IsConnected() then continue end
		if not v:Alive() then continue end
		if not v.tosaccept then continue end
		
		if v:WaterLevel() == 3 then
			if v.underwater == false then
				v.underwater = true
			end
			if v.elixir == "waterbreathing" then
				v.o2 = math.Clamp((v.o2 + 20), 0, v.maxneeds)
			else
				v.o2 = math.Clamp((v.o2 - 10), 0, v.maxneeds)
			end
			
			if v.o2 <= 0 then v.o2 = 0 end
			
			net.Start("sgs_sendo2")
				net.WriteInt( v.o2, 32 )
				net.WriteString( "yes" )
			net.Send( v )
			continue
		end
		
		if v:WaterLevel() < 3 and v.underwater == true then
			if v.o2 < v.maxneeds then
				v.o2 = math.Clamp((v.o2 + 20), 0, v.maxneeds)
				net.Start("sgs_sendo2")
					net.WriteInt( v.o2, 32 )
					net.WriteString( "yes" )
				net.Send( v )
			else
				v.underwater = false
				v.o2 = v.maxneeds
				net.Start("sgs_sendo2")
					net.WriteInt( v.o2, 32 )
					net.WriteString( "no" )
				net.Send( v )
			end
			continue
		end
	end
	
	SGS.nextwatercheck = CurTime() + 0.2
end
hook.Add("Think", "CheckUnderWater", SGS_CheckUnderWater)


function PlayerMeta:Drown()

	self:NeedsHurt(10)

end