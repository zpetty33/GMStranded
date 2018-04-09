local PlayerMeta = FindMetaTable("Player")


function PlayerMeta:Question()
	if self.amode then return end
	local q = math.random(1, table.Count(SGS.speech["question"]))
	self:PlayScene(SGS.speech["question"][q], 100)
	
	local ap = player.GetAll()
	local closeplayers = {}
	for _, ply in pairs(ap) do
		if ply:GetPos():DistToSqr(self:GetPos()) <= 62500 then
			if self == ply then
			else
				table.insert(closeplayers, ply)
			end
		end
	end
	if table.Count(closeplayers) == 0 then return end
	local totalk = math.random(1, table.Count(closeplayers))
	timer.Simple(3, function()
		closeplayers[totalk]:Answer()
		end
	)
end

function PlayerMeta:Answer()
	local a = math.random(1, table.Count(SGS.speech["answer"]))
	if IsValid(self) then
		self:PlayScene(SGS.speech["answer"][a], 100)
	end
end

function PlayerMeta:Exclaim()
end

function PlayerMeta:Disappointment()
end

function PlayerMeta:ObserveDeath()
	local a = math.random(1, table.Count(SGS.speech["observedeath"]))
	self:PlayScene(SGS.speech["observedeath"][a], 100)
end

function PlayerObserveDeath(ply, _, _)

	local ap = player.GetAll()
	local closeplayers = {}
	for _, v in pairs(ap) do
		if v:GetPos():DistToSqr(ply:GetPos()) <= 160000 then
			if ply == v then
			else
				table.insert(closeplayers, v)
			end
		end
	end
	for _, v in pairs(closeplayers) do
		if v:IsPlayer() and IsValid(v) then
			timer.Simple(1, function()
				v:ObserveDeath()
				end
			)
		end
	end

end
hook.Add( "PlayerDeath", "PlayerObserveDeath", PlayerObserveDeath )

function PlayerMeta:Sick()
end

function PlayerMeta:Hungry()
end



function SGS_RandomSay(ply)
	
	if IsValid(ply) then
		if ply:IsPlayer() and ply:IsConnected() then
			if math.random(1,3) == 1 then
				ply:Question()
			end
			timer.Simple(300, function() SGS_RandomSay(ply) end)
		end
	end

end