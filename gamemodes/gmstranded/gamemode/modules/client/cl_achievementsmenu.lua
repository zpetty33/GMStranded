surface.CreateFont( "achtitle1", {
		font	=	"tahoma",
		size	=	18,
		weight	=	600
		}
	)
surface.CreateFont( "achtitle2", {
		font	=	"tahoma",
		size	=	14,
		weight	=	600
		}
	)
	
function SGS_AchievementsMenu()

	if ValidPanel(SGS.achmenu) then SGS.achmenu:Remove() end

	SGS.achmenu = vgui.Create( "DFrame" )
	SGS.achmenu:ShowCloseButton(true)
	SGS.achmenu:SetDraggable(false)
	SGS.achmenu:SetSize( 600,600 )
	SGS.achmenu:Center()
	SGS.achmenu:SetTitle( "Achievements Menu" )
	
	local Scroll = vgui.Create( "DScrollPanel", SGS.achmenu )
	Scroll:SetSize( SGS.achmenu:GetWide() - 10, SGS.achmenu:GetTall() - 35 )
	Scroll:SetPos( 5, 30 )

	local List = vgui.Create( "DIconLayout", Scroll )
	List:SetSize( Scroll:GetWide() - 15, Scroll:GetTall() )
	List:SetPos( 0, 0 )
	List:SetSpaceY(5)
	
	for k, v in pairs( SGS.Ach ) do
		if v.show == true then
	
			local item = vgui.Create( "DPanel" )
			item:SetSize( Scroll:GetWide() - 20, 60 )
			item.Paint = function(self)
				draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color(240,240,240,255) )
				if SGS_GetAch( v.short ) then
					draw.RoundedBox( 4, 2, 2, 56, 56, Color(50,255,50,255) )
				else
					draw.RoundedBox( 4, 2, 2, 56, 56, Color(255,50,50,255) )
				end
				
				draw.DrawText( v.long, "achtitle1", 65, 0, Color(0,0,0,255), 0 )
				draw.DrawText( v.displaytext, "achtitle2", 65, 18, Color(120,120,120,255), 0 )
				
				if v.associatedstat then
					local divisor = v.stat_divisor or 1 
					draw.DrawText( "Progress: " .. tostring(math.Clamp(math.floor(SGS_GetStat(v.associatedstat)/divisor), 0, tonumber(v.statneeded)/divisor)) .. " / " .. tostring(tonumber(v.statneeded)/divisor), "achtitle2", 65, 40, Color(0,0,0,255), 0 )
				end
				if v.reward then
					local w, h  = surface.GetTextSize( "Reward: " .. v.reward )
					local w2, h2  = surface.GetTextSize( v.reward )
					draw.DrawText( "Reward: ", "achtitle2", self:GetWide() - w - 10, 40, Color(150,25,25,255), 0 )
					draw.DrawText( v.reward, "achtitle2", self:GetWide() - w2 - 10, 40, Color(25,150,25,255), 0 )
				end
					
			end
			
			List:Add( item )
		end
	end

	SGS.achmenu:MakePopup()
end