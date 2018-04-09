--[[
	Copyright 2014-2015 Cro-Tek International do not steal
]]--

local meta = debug.getregistry().Player
local Anims = {
	["models/crow.mdl"]	= {
		ACT_CROW_FLY 	= 0,
		ACT_CROW_IDLE 	= 1,
		ACT_CROW_WALK 	= 2,
		ACT_CROW_RUN 	= 3,
		ACT_CROW_TAKEOFF = 6,
		ACT_CROW_SOAR 	= 7,
		ACT_CROW_LAND	= 8,
		ACT_CROW_HOP	= 10,
	},
	["models/seagull.mdl"]	= {
		ACT_CROW_FLY 	= 1,
		ACT_CROW_IDLE 	= 2,
		ACT_CROW_WALK 	= 3,
		ACT_CROW_RUN 	= 4,
		ACT_CROW_TAKEOFF = 5,
		ACT_CROW_SOAR 	= 9,
		ACT_CROW_LAND	= 8,
		ACT_CROW_HOP	= 6,
	},
	["models/pigeon.mdl"] = {
		ACT_CROW_FLY 	= 0,
		ACT_CROW_IDLE 	= 1,
		ACT_CROW_WALK 	= 2,
		ACT_CROW_RUN 	= 3,
		ACT_CROW_TAKEOFF = 6,
		ACT_CROW_SOAR 	= 7,
		ACT_CROW_LAND	= 8,
		ACT_CROW_HOP	= 10,
	},
}


--[[ Player Meta Functions ]]--
-- Shared
function meta:GetCrowMode()
	return SERVER and (self.m_tblCrowMode and self.m_tblCrowMode.Enabled or false) or self:GetNWBool( "IsCrow" )
end

-- Server-Side
function meta:SetCrowMode( bEnabled, strModel )
	if CLIENT then return end
	
	--Setup a tiny bit of crow related metadata
	if not self.m_tblCrowMode then
		self.m_tblCrowMode = { Enabled = false, OldModel = self:GetModel() }
	end

	if bEnabled then
		if not self.m_tblCrowMode.Enabled then
			--Save our player model when we turn on crow mode
			self.m_tblCrowMode.OldModel = self:GetModel()
		end
		
		--Make us the size of a crow too!
		self:SetHull( Vector(-5, -5, 0), Vector(5, 5, 8) )
		self:SetHullDuck( Vector(-5, -5, 0), Vector(5, 5, 8) )
	else
		self:ResetHull() --Make us normal sized again.
	end

	--Save our enable state
	self.m_tblCrowMode.Enabled = bEnabled

	self:SetModel( (bEnabled and (strModel and strModel or "models/crow.mdl")) or self.m_tblCrowMode.OldModel )
	self:SetNWBool( "IsCrow", bEnabled )
end

--[[ Animation Overrides ]]--
local function HandleCrowVaulting( pPlayer, vecVel )
	if pPlayer:IsOnGround() or not Anims[pPlayer:GetModel()] then return end
	pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_SOAR
	pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_SOAR

	return true
end

local function HandleCrowLanding( pPlayer, vecVel, bWasOnGround ) 
	if pPlayer:GetMoveType() == MOVETYPE_NOCLIP or not Anims[pPlayer:GetModel()] then return end
	if pPlayer.m_intCrowLandingTime or (pPlayer:IsOnGround() and not bWasOnGround) or pPlayer.m_bWasNoclipping then
		pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_LAND
		pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_LAND

		if not pPlayer.m_intCrowLandingTime then
			pPlayer.m_intCrowLandingTime = CurTime() +0.1
			return true
		elseif CurTime() > pPlayer.m_intCrowLandingTime then
			pPlayer.m_intCrowLandingTime = nil
		else
			return true
		end
	end
end

local function HandleCrowNoClipping( pPlayer, vecVel )
	if not Anims[pPlayer:GetModel()] then return end
	if pPlayer:GetMoveType() ~= MOVETYPE_NOCLIP then
		if pPlayer.m_bNoClipStarted or pPlayer.m_intNoClipStartTime then
			if not pPlayer.m_intNoClipEndTime then
				pPlayer.m_intNoClipEndTime = CurTime() +0.4
			end

			if CurTime() > pPlayer.m_intNoClipEndTime then
				pPlayer.m_intNoClipStartTime = nil
				pPlayer.m_intNoClipEndTime = nil
				pPlayer.m_bNoClipStarted = false	
				return
			else
				pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_LAND
				pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_LAND	
				return true
			end
		end

		return
	end

	if not pPlayer.m_intNoClipStartTime and not pPlayer.m_bNoClipStarted and pPlayer.m_bWasOnGround then
		pPlayer.m_intNoClipStartTime = CurTime() +0.6
		pPlayer.m_bNoClipStarted = false
		pPlayer:AnimRestartMainSequence()
	elseif pPlayer.m_intNoClipStartTime and CurTime() > pPlayer.m_intNoClipStartTime then
		pPlayer.m_bNoClipStarted = true
		pPlayer.m_intNoClipStartTime = nil
		pPlayer:AnimRestartMainSequence()
	elseif not pPlayer.m_bWasOnGround and not pPlayer.m_bNoClipStarted and not pPlayer.m_intNoClipStartTime then
		pPlayer.m_bNoClipStarted = true
		pPlayer:AnimRestartMainSequence()
	end
	
	if pPlayer.m_intNoClipStartTime and not pPlayer.m_bNoClipStarted then
		pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_TAKEOFF
		pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_TAKEOFF
	elseif pPlayer.m_bNoClipStarted then
		pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_FLY
		pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_FLY		
	end

	return true
end

local function HandleCrowDucking( pPlayer, vecVel )
	if not pPlayer:Crouching() or not Anims[pPlayer:GetModel()] then return false end
	if vecVel:Length2D() > 0.5 then
		pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_WALK
		pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_WALK
	else
		pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_IDLE
		pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_IDLE
	end
	
	return true
end

local function HandleCrowJumping( pPlayer, vecVel )
	if not Anims[pPlayer:GetModel()] then return end
	if pPlayer:GetMoveType() == MOVETYPE_NOCLIP then
		pPlayer.m_bJumping = false
		return
	end

	if not pPlayer.m_bJumping and not pPlayer:OnGround() and pPlayer:WaterLevel() <= 0 then
		if not pPlayer.m_fGroundTime then
			pPlayer.m_fGroundTime = CurTime()
		elseif (CurTime() -pPlayer.m_fGroundTime) > 0 and vecVel:Length2D() < 0.5 then
			pPlayer.m_bJumping = true
			pPlayer.m_bFirstJumpFrame = false
			pPlayer.m_flJumpStartTime = 0
		end
	end
	
	if pPlayer.m_bJumping then
		if pPlayer.m_bFirstJumpFrame then
			pPlayer.m_bFirstJumpFrame = false
			pPlayer:AnimRestartMainSequence()
		end
		
		if pPlayer:WaterLevel() >= 2 or ( (CurTime() - pPlayer.m_flJumpStartTime) > 0.2 and pPlayer:OnGround() ) then
			pPlayer.m_bJumping = false
			pPlayer.m_fGroundTime = nil
			pPlayer:AnimRestartMainSequence()
		end
		
		if pPlayer.m_bJumping then
			pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_HOP
			pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_HOP	
			return true
		end
	end
	
	return false
end

if SERVER then
	crow_caws = { "crow/alert2", "crow/alert3", "crow/pain1", "crow/pain2" }
	gull_caws = { "ambient/creatures/seagull_idle3", "ambient/creatures/seagull_pain2", "ambient/creatures/seagull_pain3" }
	pigeon_caws = { "ambient/creatures/pigeon_idle1", "ambient/creatures/pigeon_idle2", "ambient/creatures/pigeon_idle3", "ambient/creatures/pigeon_idle4" }
	
	function SGS_Caw( ply, key )
		if ply.amode and key == IN_ATTACK then
			if ply:GetModel() == "models/crow.mdl" then
				ply:EmitSound("npc/" .. crow_caws[math.random(#crow_caws)] .. ".wav", 400, math.random(90,110))
			elseif ply:GetModel() == "models/seagull.mdl" then
				ply:EmitSound(gull_caws[math.random(#gull_caws)] .. ".wav", 400, math.random(90,110))
			elseif ply:GetModel() == "models/pigeon.mdl" then
				ply:EmitSound(pigeon_caws[math.random(#pigeon_caws)] .. ".wav", 400, math.random(90,110))
			end
		end
	end
	hook.Add( "KeyPress", "Caw_KeyPress", SGS_Caw )
end

if CLIENT then
	hook.Add( "Think", "CrowMode", function()
		local ply = LocalPlayer()
		if not IsValid( ply ) then return end
		
		if not ply:GetCrowMode() then 
			if ply.m_bCrowFirstFrame then
				ply:ResetHull() --Make us normal sized again.
				ply.m_bCrowFirstFrame = nil
			end

			return
		end

		if not ply.m_bCrowFirstFrame then
			--Make us the size of a crow too!
			ply:SetHull( Vector(-5, -5, 0), Vector(5, 5, 8) )
			ply:SetHullDuck( Vector(-5, -5, 0), Vector(5, 5, 8) )
			ply.m_bCrowFirstFrame = true
		end
	end )
end

hook.Add( "CalcMainActivity", "CrowMode", function( pPlayer, vecVel )
	if not pPlayer:GetCrowMode() then return end
	if not Anims[pPlayer:GetModel()] then return end
	pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_IDLE
	pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_IDLE

	if HandleCrowNoClipping( pPlayer, vecVel ) or
		HandleCrowJumping( pPlayer, vecVel ) or
		HandleCrowVaulting( pPlayer, vecVel ) or
		HandleCrowLanding( pPlayer, vecVel, pPlayer.m_bWasOnGround ) or
		HandleCrowDucking( pPlayer, vecVel ) then
	else
		local len2d = vecVel:Length2D()
		if len2d > 120 then
			pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_RUN
			pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_RUN
		elseif len2d > 0.5 then
			pPlayer.CalcIdeal = Anims[pPlayer:GetModel()].ACT_CROW_WALK
			pPlayer.CalcSeqOverride = Anims[pPlayer:GetModel()].ACT_CROW_WALK			
		end
	end

	pPlayer.m_bWasOnGround = pPlayer:IsOnGround()
	pPlayer.m_bWasNoclipping = ( pPlayer:GetMoveType() == MOVETYPE_NOCLIP and not pPlayer:InVehicle() )
	return pPlayer.CalcIdeal, pPlayer.CalcSeqOverride
end )