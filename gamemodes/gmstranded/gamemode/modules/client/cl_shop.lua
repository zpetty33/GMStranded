local enablenames = true
local enabletitles = true
local textalign = 1
local distancemulti = 0.6
function DrawShopName()

	local vStart = LocalPlayer():GetPos()
	local vEnd

	for k, v in pairs(ents.FindByClass("npc_vortigaunt")) do
		if v:GetNWBool("ispet") == true then continue end
		local vStart = LocalPlayer():GetPos()
		local vEnd = v:GetPos() + Vector(0,0,25)
		local trace = {}
		
		trace.start = vStart
		trace.endpos = vEnd
		local trace = util.TraceLine( trace )
		
		if trace.HitWorld then
			local mepos = LocalPlayer():GetPos()
			local tpos = v:GetPos()
			local tdist = mepos:Distance(tpos)
			if tdist <= 2000 then
			
				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				draw.RoundedBoxEx( 2, pos.x - 4, pos.y - 4, 8, 8, Color(100,200,200,255), true, true, true, true )

			end
		else
			local mepos = LocalPlayer():GetPos()
			local tpos = v:GetPos()
			local tdist = mepos:Distance(tpos)
			
			if tdist <= 600 then
				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				
				if v != LocalPlayer() then
					draw.SimpleTextOutlined( "Vorty", "SGS_HUD3", pos.x, pos.y - 25, Color(100,200,200,255), textalign, 1,1,Color(0,0,0,255))
					draw.SimpleTextOutlined("[GToken Vendor]", "SGS_HUD3", pos.x, pos.y - 10, Color(100,200,200,255),textalign,1,1,Color(0,0,0,255))
				end
			elseif tdist > 600 and tdist <= 2000 then
			
				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				draw.RoundedBoxEx( 2, pos.x - 4, pos.y - 4, 8, 8, Color(100,200,200,255), true, true, true, true )

			end
		end
	end
	
	for k, v in pairs(ents.FindByClass("npc_breen")) do
		if v:GetNWBool("ispet") == true then continue end
		local vStart = LocalPlayer():GetPos()
		local vEnd = v:GetPos() + Vector(0,0,25)
		local trace = {}
		
		trace.start = vStart
		trace.endpos = vEnd
		local trace = util.TraceLine( trace )
		
		if trace.HitWorld then
			local mepos = LocalPlayer():GetPos()
			local tpos = v:GetPos()
			local tdist = mepos:Distance(tpos)
			if tdist <= 2000 then
			
				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				draw.RoundedBoxEx( 2, pos.x - 4, pos.y - 4, 8, 8, Color(100,200,200,255), true, true, true, true )

			end
		else
			local mepos = LocalPlayer():GetPos()
			local tpos = v:GetPos()
			local tdist = mepos:Distance(tpos)
			
			if tdist <= 600 then
				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				
				if v != LocalPlayer() then
					draw.SimpleTextOutlined( "Dr. Breen", "SGS_HUD3", pos.x, pos.y - 25, Color(100,200,200,255), textalign, 1,1,Color(0,0,0,255))
					draw.SimpleTextOutlined("[Holiday Vendor]", "SGS_HUD3", pos.x, pos.y - 10, Color(100,200,200,255),textalign,1,1,Color(0,0,0,255))
				end
			elseif tdist > 600 and tdist <= 2000 then
			
				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				draw.RoundedBoxEx( 2, pos.x - 4, pos.y - 4, 8, 8, Color(100,200,200,255), true, true, true, true )

			end
		end
	end
	
	for k, v in pairs(ents.FindByClass("npc_kleiner")) do
		if v:GetNWBool("ispet") == true then continue end
		local vStart = LocalPlayer():GetPos()
		local vEnd = v:GetPos() + Vector(0,0,25)
		local trace = {}
		
		trace.start = vStart
		trace.endpos = vEnd
		local trace = util.TraceLine( trace )
		
		if trace.HitWorld then
			local mepos = LocalPlayer():GetPos()
			local tpos = v:GetPos()
			local tdist = mepos:Distance(tpos)
			if tdist <= 2000 then
			
				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				draw.RoundedBoxEx( 2, pos.x - 4, pos.y - 4, 8, 8, Color(100,200,200,255), true, true, true, true )

			end
		else
			local mepos = LocalPlayer():GetPos()
			local tpos = v:GetPos()
			local tdist = mepos:Distance(tpos)
			
			if tdist <= 600 then
				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				
				if v != LocalPlayer() then
					draw.SimpleTextOutlined( "Dr. K", "SGS_HUD3", pos.x, pos.y - 25, Color(100,200,200,255), textalign, 1,1,Color(0,0,0,255))
					draw.SimpleTextOutlined("[Hat Salesman]", "SGS_HUD3", pos.x, pos.y - 10, Color(100,200,200,255),textalign,1,1,Color(0,0,0,255))
				end
			elseif tdist > 600 and tdist <= 2000 then
			
				local zadj = 0.03334 * tdist
				local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
				pos = pos:ToScreen()
				draw.RoundedBoxEx( 2, pos.x - 4, pos.y - 4, 8, 8, Color(100,200,200,255), true, true, true, true )

			end
		end
	end
end
hook.Add("HUDPaint", "DrawShopName", DrawShopName)