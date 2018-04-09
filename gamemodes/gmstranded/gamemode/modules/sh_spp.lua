------------------------------------
--	Simple Prop Protection
--	By Spacetech
-- 	http://code.google.com/p/simplepropprotection
------------------------------------

SPropProtection.Version = 1.51 -- "SVN"

Msg("==========================================================\n")
Msg("Simple Prop Protection Version "..SPropProtection.Version.." by Spacetech has loaded\n")
Msg("==========================================================\n")



function GM:CalcMainActivity( ply, velocity )	

	ply.CalcIdeal = ACT_MP_STAND_IDLE
	ply.CalcSeqOverride = -1

	self:HandlePlayerLanding( ply, velocity, ply.m_bWasOnGround );
	
	if ( self:HandlePlayerNoClipping( ply, velocity ) ||
		self:HandlePlayerDriving( ply ) ||
		self:HandlePlayerVaulting( ply, velocity ) ||
		self:HandlePlayerJumping( ply, velocity ) ||
		self:HandlePlayerDucking( ply, velocity ) ||
		self:HandlePlayerSwimming( ply, velocity ) ) then
		
	else

		local len2d = velocity:Length2D()
		if ( len2d > 150 ) then ply.CalcIdeal = ACT_MP_RUN elseif ( len2d > 0.5 ) then ply.CalcIdeal = ACT_MP_WALK end

	end
	
	-- a bit of a hack because we're missing ACTs for a couple holdtypes
	local weapon = ply:GetActiveWeapon()
	local ht = "pistol"

	--if ( IsValid( weapon ) ) then ht = weapon:GetHoldType() end
	
	if ( ply.CalcIdeal == ACT_MP_CROUCH_IDLE &&	( ht == "knife" || ht == "melee2" ) ) then
		ply.CalcSeqOverride = ply:LookupSequence("cidle_" .. ht)
	end

	ply.m_bWasOnGround = ply:IsOnGround()
	ply.m_bWasNoclipping = (ply:GetMoveType() == MOVETYPE_NOCLIP)

	return ply.CalcIdeal, ply.CalcSeqOverride

end
