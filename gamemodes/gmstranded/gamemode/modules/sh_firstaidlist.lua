SGS.FirstAid = {}

function Menu_RegisterAlch( category, firstAid )
	if not SGS.FirstAid[category] then SGS.FirstAid[category] = {} end
	
	SGS.FirstAid[category][#SGS.FirstAid[category] + 1] = firstAid
end



//--First Aid Items--//

local AID_ITEM = {}
AID_ITEM.material = "vgui/firstaid/health_sm.png"
AID_ITEM.title = "Aid Pack"
AID_ITEM.stitle = "Aid Pack"
AID_ITEM.uid = "aid1"
AID_ITEM.description = "Heals 20hp"
AID_ITEM.cost = { pypa_seed = 5 }
AID_ITEM.reqlvl = { alchemy = 1}
AID_ITEM.gives = { aid_pack = 1}
AID_ITEM.xp = 10
Menu_RegisterAlch( "first aid items", AID_ITEM )

local AID_ITEM = {}
AID_ITEM.material = "vgui/firstaid/health_lg.png"
AID_ITEM.title = "Large Aid Pack"
AID_ITEM.stitle = "Large Aid Pack"
AID_ITEM.uid = "aid2"
AID_ITEM.description = "Heals 50hp"
AID_ITEM.cost = { liferoot = 5 }
AID_ITEM.reqlvl = { alchemy = 15}
AID_ITEM.gives = { aid_pack = 1}
AID_ITEM.xp = 60
Menu_RegisterAlch( "first aid items", AID_ITEM )

local AID_ITEM = {}
AID_ITEM.material = "vgui/firstaid/tourniquet.png"
AID_ITEM.title = "Tourniquet"
AID_ITEM.stitle = "Tourniquet"
AID_ITEM.uid = "aid3"
AID_ITEM.description = "Stops Bleeding"
AID_ITEM.cost = { liferoot = 10, cloth = 2 }
AID_ITEM.reqlvl = { alchemy = 25 }
AID_ITEM.gives = { tourniquet = 1 }
AID_ITEM.xp = 135
Menu_RegisterAlch( "first aid items", AID_ITEM )

local AID_ITEM = {}
AID_ITEM.material = "vgui/firstaid/splint.png"
AID_ITEM.title = "Wooden Splint"
AID_ITEM.stitle = "Wooden Splint"
AID_ITEM.uid = "aid4"
AID_ITEM.description = "Cures Broken Bones"
AID_ITEM.cost = { wood = 10 }
AID_ITEM.reqlvl = { alchemy = 1 }
AID_ITEM.gives = { splint = 1 }
AID_ITEM.xp = 15
Menu_RegisterAlch( "first aid items", AID_ITEM )
