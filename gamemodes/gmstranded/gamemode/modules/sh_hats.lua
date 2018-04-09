if SERVER then
	local files, dirs = file.Find("gmstranded/gamemode/modules/hats/*.lua", "LUA")
	for k, v in pairs( files ) do
		AddCSLuaFile( "gmstranded/gamemode/modules/hats/" .. v )
	end
end

SGS.hatsettings = {}
function RegisterHatSetting( hat, tbl )
	SGS.hatsettings[hat] = tbl
end

local files, dirs = file.Find("gmstranded/gamemode/modules/hats/*.lua", "LUA")
for k, v in pairs( files ) do
	print("Stranded: Including Hat: (" .. v .. ")")
	include( "gmstranded/gamemode/modules/hats/" .. v )
end

local STR_NETMESSAGE = "HatEquip"
local Entity = FindMetaTable( "Entity" )

function Entity:GetEquippedHat()
	return self.m_strEquippedHat
end
	
if SERVER then

	util.AddNetworkString( STR_NETMESSAGE )
	
	function Entity:EquipHat( name )
		self.m_strEquippedHat = name
		
		if name == "mininghat" then
			if self:IsPlayer() then
				self:Flashlight(true)
			end
		else
			if self:IsPlayer() then
				if self:FlashlightIsOn() then
					self:Flashlight(false)
				end
			end
		end
		net.Start( STR_NETMESSAGE )
			net.WriteEntity( self )
			net.WriteString( name or "" )
		net.Broadcast()
	end
	
	local function PlayerInitialSpawn( ply )
		timer.Simple( 10, function()
			for _, v in ipairs(ents.GetAll()) do
				if v.m_strEquippedHat then
					net.Start( STR_NETMESSAGE )
						net.WriteEntity( v )
						net.WriteString( v.m_strEquippedHat or "" )
					net.Send( ply )
				end
			end
		end )
	end
	hook.Add( "PlayerInitialSpawn", "SendHats", PlayerInitialSpawn )
	
elseif CLIENT then
	
	function Entity:EquipHat( name )
		if not IsValid(self) then return end
		if IsValid( self.m_entEquippedHat ) and self.m_strEquippedHat ~= name then
			self.m_entEquippedHat:Remove()
			self.m_entEquippedHat, self.m_strEquippedHat, self.m_tblEquippedHat = nil, nil, nil
		end
		
		local settings = SGS.hatsettings[name]
		local offsets = settings and settings.offsets[self:GetModel()] or nil
		if settings and offsets then
			self.m_entEquippedHat, self.m_strEquippedHat, self.m_tblEquippedHat = ClientsideModel( settings.model ), name, offsets
			
			for i=0, self.m_entEquippedHat:GetBoneCount()-1 do
				self.m_entEquippedHat:ManipulateBoneScale( i, offsets.scale )
			end
			self.m_entEquippedHat:SetNoDraw( true )
			
			self:CallOnRemove( "RemoveHat", function(ent) if IsValid(ent) and IsValid(ent.m_entEquippedHat) then ent.m_entEquippedHat:Remove() end end )
		end
	end
	
	local function DrawHat( ent )
		if not IsValid( ent.m_entEquippedHat ) or (ent:Health() <= 0 and ent:IsPlayer() and not IsValid(ent:GetRagdollEntity())) then return end
		
		-- Get tables
		local offsets = ent.m_tblEquippedHat
		local check = SGS.hatsettings[ent.m_strEquippedHat].offsets[ent:GetModel()]
		if check == nil then return end
		
		-- Update?
		local update = check ~= offsets
		local offsets = update and check or offsets
		
		if ent:Health() > 0 then
			if ent.m_entEquippedHat:GetParent() ~= ent or update then
				ent.m_entEquippedHat:SetParent()

				local pos, ang = ent:GetBonePosition(ent:LookupBone(offsets.bone))
				ent.m_entEquippedHat:SetPos(pos + (ang:Forward() * offsets.pos.x) + (ang:Right() * offsets.pos.y) + (ang:Up() * offsets.pos.z))
				local x, y, z = ang:Forward(), ang:Right(), ang:Up()
				ang:RotateAroundAxis(z, offsets.ang.y) 
				ang:RotateAroundAxis(y, offsets.ang.p) 
				ang:RotateAroundAxis(x, offsets.ang.r)
				ent.m_entEquippedHat:SetAngles(ang)
				
				ent.m_tblEquippedHat = offsets
			end
		else
			local ragdoll = ent:GetRagdollEntity()
			
			ent.m_entEquippedHat:SetParent()

			local pos, ang = ragdoll:GetBonePosition(ragdoll:LookupBone(offsets.bone))
			ent.m_entEquippedHat:SetPos(pos + (ang:Forward() * offsets.pos.x) + (ang:Right() * offsets.pos.y) + (ang:Up() * offsets.pos.z))
			local x, y, z = ang:Forward(), ang:Right(), ang:Up()
			ang:RotateAroundAxis(z, offsets.ang.y) 
			ang:RotateAroundAxis(y, offsets.ang.p) 
			ang:RotateAroundAxis(x, offsets.ang.r)
			ent.m_entEquippedHat:SetAngles(ang)
		end

		for i=0, ent.m_entEquippedHat:GetBoneCount()-1 do
			ent.m_entEquippedHat:ManipulateBoneScale( i, offsets.scale )
		end
		
		if ent == LocalPlayer() then
			local should = hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, ent )
			if should ~= true then
				return
			end
		end
		
		local swap, scale = false, offsets.scale
		if scale.x < 0 then swap = not swap end
		if scale.y < 0 then swap = not swap end
		
		if not swap then
			ent.m_entEquippedHat:DrawModel()
		else
			render.CullMode( MATERIAL_CULLMODE_CW )
			ent.m_entEquippedHat:DrawModel()
			render.CullMode( MATERIAL_CULLMODE_CCW )
		end
	end
	
	local function PostDrawOpaqueRenderables()
		for _, ent in ipairs(player.GetAll()) do
			DrawHat( ent )
		end
		for _, ent in ipairs(ents.FindByClass("npc_*")) do
			DrawHat( ent )
		end
	end
	hook.Add( "PostDrawOpaqueRenderables", "DrawHats", PostDrawOpaqueRenderables )
	
	local function RecieveHatEquip( size )
		local ent = net.ReadEntity()
		ent:EquipHat( net.ReadString() )
	end
	net.Receive( STR_NETMESSAGE, RecieveHatEquip )
	
end