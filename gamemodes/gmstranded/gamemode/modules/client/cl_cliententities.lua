SGS.halos = {}

SGS.ballmat = Material("sprites/star.png")
SGS.frame = 1

hook.Add( "PostDrawTranslucentRenderables", "DrawOrbs", function( ... )
	for k, v in pairs( SGS.halos ) do
		if IsValid(k) then
			if LocalPlayer():GetPos():DistToSqr( k:GetPos() ) <= 1440000 and k:GetAttachment(1) then
				for p, ply in pairs( SGS.halos[k] ) do
					pos = k:GetAttachment(1).Pos + Vector( TimedCos(1, 0, 1.2, ( ( math.pi * 2 ) / table.Count(SGS.halos[k]) ) * p-1 ) * 20, TimedSin(1, 0, 1.2, ( ( math.pi * 2 ) / table.Count(SGS.halos[k]) ) * p-1) * 20, TimedSin(1.2, -5, -1, 0) + 15 )
					local col = Color(255,255,255,200)
					if ply.color then
						col = ply.color
						render.SetMaterial( SGS.ballmat );
						render.DrawSprite( pos, 1, 1, col )
					else
						col = Color( math.random(255), math.random(255), math.random(255), 200 )
						render.SetMaterial( SGS.ballmat );
						render.DrawSprite( pos, 1.5, 1.5, col )
					end
					
					if math.random(5) == 3 then
						local ED = EffectData()
						local bc = col
						ED:SetOrigin( pos )
						ED:SetStart(Vector(bc.r,bc.g,bc.b))
						local effect = util.Effect( 'particle_showskill', ED, true, true )
					end
				end
			end
		else
			SGS.halos[k] = nil
		end
	end
end )

net.Receive( "Halo_SendTable", function( len )
	SGS.halos = net.ReadTable()
end )