AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local allowed_rocks = {
	"gms_stonenode",
	"gms_ironnode",
	"gms_coalnode",
	"gms_silvernode",
	"gms_naquadahnode",
	"gms_triniumnode",
	"gms_goldnode",
	"gms_mithrilnode",
	"gms_platinumnode",
}

local rock_chances = {}
rock_chances["gms_stonenode"] = 1
rock_chances["gms_ironnode"] = 2
rock_chances["gms_coalnode"] = 3
rock_chances["gms_silvernode"] = 5
rock_chances["gms_naquadahnode"] = 5
rock_chances["gms_triniumnode"] = 7
rock_chances["gms_goldnode"] = 9
rock_chances["gms_mithrilnode"] = 10
rock_chances["gms_platinumnode"] = 12

function ENT:Initialize()
	self:SetModel(SGS.proplist["harvester"])
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor(Color(255, 255, 255, 255))
	self:DrawShadow(true)
	self:SetUseType(3)
	
	self.fuel = 0
	self.broken = false
	self:ResetInventory()
	self.maxinventory = 80
end

function ENT:ResetInventory()
	self.inventory = {}
	self.inventory["stone"] = 0
	self.inventory["iron_ore"] = 0
	self.inventory["coal"] = 0
	self.inventory["silver_ore"] = 0
	self.inventory["gold_ore"] = 0
	self.inventory["trinium_ore"] = 0
	self.inventory["mithril_ore"] = 0
	self.inventory["naquadah_ore"] = 0
	self.inventory["platinum_ore"] = 0
	self.inventory["total"] = 0
	
end

function ENT:Use( ply )

	ply:SendMessage("The miner has (" .. self.fuel .. ") fuel remaining", 60, Color(0, 255, 255, 255))
	self:ExtractResources( ply )
	if self.fuel == 0 then
		ply:SendMessage("To add fuel touch a box of coal/charcoal to the miner.", 60, Color(0, 255, 255, 255))
	end
	if self.broken then
		ply:AddResource("meteoric_iron", math.random(2))
		self:Remove()
	end	
	
end

function ENT:GetAttachedEnt()
	local tr = util.TraceLine( {
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetAngles():Up() * -10,
		filter = self
	} )
	if tr.Entity == NULL then
		return game.GetWorld()
	else
		return tr.Entity
	end
end

function ENT:Mine( rock )
	local res = rock.rgives
	self.inventory[res] = self.inventory[res] + 1
	self.inventory["total"] = self.inventory["total"] + 1
	rock.rtotal = rock.rtotal - 1
	if rock.rtotal <= 0 then
		rock.depleted = true
		rock:RespawnTimer()
		rock:EmitSound("physics/concrete/concrete_break3.wav", 60, math.random(80,120))
		rock:SetColor(Color(20, 20, 20, 255))
	end
	
	if math.random(100) == 1 then
		print("BROKE!")
		self.broken = true
	end
end

function ENT:GetInventoryTotal()
	return self.inventory["total"]
end

function ENT:ExtractResources( ply )
	if self:GetInventoryTotal() > 0 then
		for k, v in pairs(self.inventory) do
			if not (k == "total") then
				if v > 0 then
					ply:AddResource( k, v )
				end
			end
		end
		self:ResetInventory()
	end
end

function ENT:Think()
	if self.broken then
		self:EmitSound( "ambient/energy/spark2.wav", 75, math.random(90,110), 1, CHAN_AUTO )
		self:Spark()
	else
		if self.fuel > 0 then
			if self:GetInventoryTotal() >= self.maxinventory then
				self:EmitSound( "buttons/blip1.wav", 75, 90, 1, CHAN_AUTO )
			else
				local att_ent = self:GetAttachedEnt():GetClass()
				if table.HasValue( allowed_rocks, att_ent ) then
					if self:GetAttachedEnt().rtotal <= 0 then
						self:EmitSound( "physics/cardboard/cardboard_box_impact_soft2.wav", 75, math.random(90,110), 1, CHAN_AUTO )
					else
						if math.random( rock_chances[ att_ent ] ) == 1 then
							self:EmitSound( "physics/concrete/rock_impact_hard3.wav", 75, math.random(70,110), 1, CHAN_AUTO )
							self:Mine( self:GetAttachedEnt() )
						else
							self:EmitSound( "physics/metal/metal_grenade_impact_hard3.wav", 75, math.random(40,70), 1, CHAN_AUTO )
						end
					end
				else
					self:EmitSound( "physics/cardboard/cardboard_box_impact_soft2.wav", 75, math.random(90,110), 1, CHAN_AUTO )
				end
			end
			self.fuel = self.fuel - 1
		end
	end
	
	
	self:NextThink( CurTime() + 1 )
	return true
end


function ENT:Spark()
	local fx = EffectData();
	fx:SetOrigin(self:GetPos());
	fx:SetNormal(Vector(0,0,1));
	fx:SetEntity(self.Entity);
	fx:SetScale(-1);
	fx:SetAngles(Angle(self.Entity:GetColor()));
	util.Effect("cball_explode",fx,true,true);
end

function ENT:StartTouch(ent2)
	if self.broken then return end
	if self.fuel >= 900 then return end

	if ent2:GetClass() == "gms_resourcedrop" then
		if ( not ent2.rType == "coal" ) or ( not ent2.rType == "charcoal" ) then return end
		if ent2.rType == "coal" then
			local max_coal = math.ceil(( 900 - self.fuel ) / 10)
			if ent2.rAmt > max_coal then
				local nn = ent2.rAmt - max_coal
				ent2:SetResourceDropInfo( "coal", nn )
				SGS_SetupDrop( ent2, "coal", nn )
				self.fuel = 900
			else
				self.fuel = self.fuel + ent2.rAmt * 10
				if self.fuel > 900 then self.fuel = 900 end
				ent2:Remove()
			end
		elseif ent2.rType == "charcoal" then
			local max_coal = math.ceil(( 900 - self.fuel ) / 25)
			if ent2.rAmt > max_coal then
				local nn = ent2.rAmt - max_coal
				ent2:SetResourceDropInfo( "charcoal", nn )
				SGS_SetupDrop( ent2, "charcoal", nn )
				self.fuel = 900
			else
				self.fuel = self.fuel + ent2.rAmt * 25
				if self.fuel > 900 then self.fuel = 900 end
				ent2:Remove()
			end
		
		end
		
	end
end