util.AddNetworkString("cl_chooserewardskill")

local PlayerMeta = FindMetaTable("Player")

function PlayerMeta:CheckLastDaily()
	local lastdaily = self:GetSetting( "last_daily" )
	if not lastdaily then lastdaily = 0 end
	local current_day = math.floor(os.time() / 86400)
	if lastdaily < current_day then
		return true
	else
		return false
	end
end

function PlayerMeta:SetLastDaily()
	self:SetSetting( "last_daily", math.floor(os.time() / 86400) )
end

net.Receive( "cl_chooserewardskill", function(len, ply)
    if not IsValid(ply) then return end
    local skill = net.ReadString()
    if not ( skill == "all" ) and not table.HasValue( SGS.skills, skill ) then return end
    print(skill)

    if ply:GetResource( "quest_reward" ) <= 0 then
        ply:SendMessage("You don't have any Quest Rewards to redeem.", 60, Color(255, 0, 0, 255))
        return
    end

    if skill == "all" then
        for k, v in pairs( SGS.skills ) do
            ply:AddExp2(v, 500)
        end
    else
        ply:AddExp2(skill, 2500)
    end

    ply:SubResource( "quest_reward", 1 )
end )