function SGS_PetNameMenu()
	
	PetNameMenu = vgui.Create( "DFrame" )
	PetNameMenu:ShowCloseButton(false)
	PetNameMenu:SetDraggable(false)
	PetNameMenu:SetSize( 200, 110 )
	PetNameMenu:SetTitle("")
	PetNameMenu:SetPos( ScrW() / 2 - 75, ScrH() / 2 - 75 )
	PetNameMenu:MakePopup()
	
	local label = vgui.Create("DLabel", PetNameMenu)
	label:SetPos( 10, 25 )
	label:SetText("Your egg has hatched!")
	label:SizeToContents()
	
	local label2 = vgui.Create("DLabel", PetNameMenu)
	label2:SetPos( 10, 40 )
	label2:SetText("Please name your new pet.")
	label2:SizeToContents()
	
	local line1 = vgui.Create("DTextEntry", PetNameMenu)
	line1:SetSize( 180, 20 )
	line1:SetPos( 10, 60 )
	
	local button = vgui.Create( "DButton", PetNameMenu )
	button:SetSize( 50, 15 )
	button:SetPos( 10, 90 )
	button:SetText( "Submit" )
	button.DoClick = function( button )
		if line1:GetValue() == "" then
			
		else
			RunConsoleCommand("sgs_namepet", line1:GetValue())
			PetNameMenu:SetVisible(false)
		end
	end
		
	PetNameMenu:SetVisible(true)

end


local enablenames = true
local enabletitles = true
local textalign = 1
local distancemulti = 0.3
function DrawPetTitle()

	local vStart = LocalPlayer():GetPos()
	local vEnd

	for k, v in pairs( ents.FindInSphere( LocalPlayer():GetPos(), 2000 ) ) do
	
		if v:GetNWBool("ispet") == true then
		
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
					draw.RoundedBoxEx( 2, pos.x - 4, pos.y - 4, 8, 8, Color(80,80,190,255), true, true, true, true )

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
						draw.SimpleTextOutlined( v:GetNWString("petname"), "SGS_HUD3", pos.x, pos.y - 35, Color(80,80,190,255), textalign, 1,1,Color(0,0,0,255))
						draw.SimpleTextOutlined("<" .. v:GetNWString("ownername") .. "'s Pet" .. ">", "SGS_HUD3", pos.x, pos.y - 20, Color(80,80,190,255), textalign,1,1,Color(0,0,0,255))
						draw.SimpleTextOutlined("<Age: " ..v:GetNWInt("age", 1).. ">", "SGS_HUD3", pos.x, pos.y - 5, Color(60,220,60,255), textalign,1,1,Color(0,0,0,255))
						if v:GetNWBool("famished", false) then
							draw.SimpleTextOutlined("**FAMISHED**", "SGS_HUD3", pos.x, pos.y + 10, Color(255,80,50,255), textalign,1,1,Color(0,0,0,255))
						end
					end
				elseif tdist > 600 and tdist <= 2000 then
				
					local zadj = 0.03334 * tdist
					local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
					pos = pos:ToScreen()
					draw.RoundedBoxEx( 2, pos.x - 4, pos.y - 4, 8, 8, Color(80,80,190,255) , true, true, true, true )

				end
			end
		end
	end
end
hook.Add("HUDPaint", "DrawPetTitle", DrawPetTitle)

function SGS_PetsDieKeepSize( npc, ragdoll )

	if npc:GetNWBool("ispet") then
		ragdoll:SetModelScale( npc:GetNWFloat("size", 1.0), 0 )
	end

end
hook.Add("CreateClientsideRagdoll", "SGS_PetsDieKeepSize", SGS_PetsDieKeepSize)