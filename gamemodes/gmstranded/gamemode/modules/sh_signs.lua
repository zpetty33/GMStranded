--[[
	Name: Sign System
	File: sh_signs.lua
	By: Ultra

	Put Signs in <GAMEMODE>/gamemode/maps/<CURRENT MAP>/signs/cl_*.lua
]]--

Signs = {}
Signs.Sign = {}
Signs.GamemodeFolder = "sandbox" --Gamemode folder name

Signs.MinRenderDist = 2250000 --Min sign render distance
Signs.CVarDistance = CreateClientConVar( "sh_max_signdist", 4000, true, false )

-- Functions
-- ------------------------------
function Signs.Register( SIGN )
	if Signs.Sign[SIGN.Name] then
		if Signs.Sign[SIGN.Name].HTML then
			Signs.Sign[SIGN.Name].HTML:Remove()
		end
	end
	
	Signs.Sign[SIGN.Name] = SIGN
end

function Signs.Draw()
	local pl = LocalPlayer()
	
	for name, SIGN in pairs( Signs.Sign ) do
		if pl:GetPos():DistToSqr( SIGN.Pos ) > math.max( Signs.CVarDistance:GetFloat() * Signs.CVarDistance:GetFloat(), Signs.MinRenderDist ) then continue end
		SIGN:Draw()
	end
end
hook.Add( "PostDrawTranslucentRenderables", "Signs_Draw", Signs.Draw )