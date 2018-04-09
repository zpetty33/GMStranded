function SGS_StatsPanel( who )
	local tabletoview = {}
	local name = "Yourself"

	if who == "me" then
		tabletoview = SGS.mystats
	else
		tabletoview = SGS.theirstats
		name = SGS.theirname
	end

	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetSize( 600, ScrH() * 0.75 )
	DermaPanel:SetPos( ( ScrW() / 2 ) - 300, ( ScrH() / 2 ) - ( ( ScrH() * 0.75 ) / 2 ) )
	DermaPanel:SetTitle( "Statistics Tracker - Viewing Statistics for: " .. name )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()
	
	local PanelList = vgui.Create( "DPanelList", DermaPanel)
	PanelList:SetPos(10, 30)
	PanelList:SetSize( 580,  ScrH() * 0.75 - 50)
	PanelList:SetDrawBackground( true )
	PanelList:SetSpacing( 2 )
	PanelList:EnableVerticalScrollbar( true )
	
	local BottomLabel = vgui.Create( "DLabel", DermaPanel )
	BottomLabel:SetPos( 10, DermaPanel:GetTall() - 20 )
	BottomLabel:SetColor( Color(255,0,80) )
	BottomLabel:SetFont( "GModNotify" )
	BottomLabel:SetText( "All stats are as of November 1st, 2013 (or whenever the stat was added)" )
	BottomLabel:SizeToContents()
	
	for k, v in pairs( SGS.stats ) do
	
		local Category = vgui.Create( "DPanel" )
		Category:SetSize( 580, 20 )
		Category.Paint = function()
			surface.SetDrawColor( Color(80,80,80) )
			surface.DrawRect( 0, 0, Category:GetWide(), Category:GetTall() )
			surface.SetFont("GModNotify")
			local w, h = surface.GetTextSize(CapAll(k) .. " Statistics")
			draw.SimpleText(CapAll(k) .. " Statistics", "GModNotify", ( (Category:GetWide() / 2) - (w / 2) ), 1, Color(255,255,255,255), 0, 0)
		end
		PanelList:AddItem( Category )

		local ListView = vgui.Create( "DListView" )
		ListView:SetSize( 580, ( table.Count(SGS.stats[k]) * 18 ) + 15 )
		ListView:SetMultiSelect( false )
		ListView:AddColumn( "Statistic" )
		ListView:AddColumn( "Amount" )
		for k2, v2 in pairs( SGS.stats[k] ) do
			ListView:AddLine( v2, tabletoview[k2] or 0 )
		end
		PanelList:AddItem( ListView )

	end
end


function SGS_OpenStatsMenu()
	if input.IsKeyDown(99) then
		if SGS.nextpress then
			if CurTime() > SGS.nextpress then
				--SGS_StatsPanel( "me" )
				RunConsoleCommand( "sgs_viewplayerstats", LocalPlayer():Nick() )
				SGS.nextpress = CurTime() + 3
			end
		else
			SGS.nextpress = CurTime()
		end
	end
end
hook.Add( "Think", "SGS_OpenStatsMenu", SGS_OpenStatsMenu )