SGS.props = {}
function Shop_RegisterProp( category, recipe )
	if not SGS.props[category] then SGS.props[category] = {} end
	SGS.props[category][#SGS.props[category] + 1] = recipe
end



-------------------------------------
---------------Seating---------------
-------------------------------------

PROP = {}
PROP.model = "models/props_c17/FurnitureChair001a.mdl"
PROP.title = "Wooden Chair"
PROP.cost = { wood = 10 }
PROP.xp = 16
PROP.reqlvl = { construction = 1 }
PROP.uid = "seating1"
PROP.ischair = true
PROP.description = ""
Shop_RegisterProp( "seating", PROP )

PROP = {}
PROP.model = "models/props_interiors/Furniture_chair03a.mdl"
PROP.title = "Blue Metal Chair"
PROP.cost = { metal = 10 }
PROP.xp = 22
PROP.reqlvl = { construction = 10 }
PROP.uid = "seating2"
PROP.ischair = true
PROP.description = ""
Shop_RegisterProp( "seating", PROP )

PROP = {}
PROP.model = "models/props_interiors/Furniture_chair01a.mdl"
PROP.title = "Fancy Wooden Chair"
PROP.cost = { wood = 32 }
PROP.xp = 16
PROP.reqlvl = { construction = 16 }
PROP.uid = "seating3"
PROP.ischair = true
PROP.description = ""
Shop_RegisterProp( "seating", PROP )

PROP = {}
PROP.model = "models/props_c17/FurnitureChair001a.mdl"
PROP.title = "Tan Chair"
PROP.cost = { wood = 24, metal = 24 }
PROP.xp = 60
PROP.reqlvl = { construction = 32 }
PROP.uid = "seating4"
PROP.ischair = true
PROP.description = ""
Shop_RegisterProp( "seating", PROP )

PROP = {}
PROP.model = "models/props_c17/FurnitureCouch001a.mdl"
PROP.title = "Red Couch"
PROP.cost = { wood = 24 }
PROP.xp = 24
PROP.reqlvl = { construction = 4 }
PROP.uid = "seating5"
PROP.ischair = true
PROP.description = ""
Shop_RegisterProp( "seating", PROP )

PROP = {}
PROP.model = "models/props_c17/FurnitureCouch002a.mdl"
PROP.title = "Green Couch"
PROP.cost = { wood = 32 }
PROP.xp = 32
PROP.reqlvl = { construction = 12 }
PROP.uid = "seating6"
PROP.ischair = true
PROP.description = ""
Shop_RegisterProp( "seating", PROP )

PROP = {}
PROP.model = "models/props_interiors/Furniture_Couch01a.mdl"
PROP.title = "Blue Couch"
PROP.cost = { wood = 38 }
PROP.xp = 50
PROP.reqlvl = { construction = 24 }
PROP.uid = "seating7"
PROP.ischair = true
PROP.description = ""
Shop_RegisterProp( "seating", PROP )

-------------------------------------
-------------DECOR PROPS-------------
-------------------------------------
PROP = {}
PROP.model = "models/props_interiors/BathTub01a.mdl"
PROP.title = "Bathtub"
PROP.description = ""
PROP.cost = { stone = 32 }
PROP.xp = 32
PROP.reqlvl = { construction = 8 }
PROP.uid = "decor1"
Shop_RegisterProp( "decor", PROP )

PROP = {}
PROP.model = "models/props_c17/FurnitureDrawer001a.mdl"
PROP.title = "Dresser"
PROP.description = ""
PROP.cost = { oak_wood = 40 }
PROP.xp = 56
PROP.reqlvl = { construction = 16 }
PROP.uid = "decor5"
Shop_RegisterProp( "decor", PROP )

PROP = {}
PROP.model = "models/props_c17/FurnitureDresser001a.mdl"
PROP.title = "Closet"
PROP.description = ""
PROP.cost = { maple_wood = 12 }
PROP.xp = 60
PROP.reqlvl = { construction = 24 }
PROP.uid = "decor6"
Shop_RegisterProp( "decor", PROP )

PROP = {}
PROP.model = "models/props/CS_militia/mailbox01.mdl"
PROP.title = "Mail Box"
PROP.description = ""
PROP.cost = { wood = 10, metal = 12 }
PROP.xp = 32
PROP.reqlvl = { construction = 8 }
PROP.uid = "decor7"
Shop_RegisterProp( "decor", PROP )

PROP = {}
PROP.model = "models/props/CS_militia/television_console01.mdl"
PROP.title = "Television"
PROP.description = "All survival reality shows 24/7!"
PROP.cost = { wood = 24, glass = 12 }
PROP.xp = 50
PROP.reqlvl = { construction = 12 }
PROP.uid = "decor8"
Shop_RegisterProp( "decor", PROP )

PROP = {}
PROP.model = "models/props/cs_office/offinspa.mdl"
PROP.title = "Motivational Poster"
PROP.description = "Random Variety"
PROP.cost = { wood = 12, glass = 8 }
PROP.xp = 90
PROP.reqlvl = { construction = 24 }
PROP.uid = "decor9"
Shop_RegisterProp( "decor", PROP )

PROP = {}
PROP.model = "models/props/cs_office/offpaintinga.mdl"
PROP.title = "Painting"
PROP.description = "Random Variety"
PROP.cost = { wood = 24, glass = 12 }
PROP.xp = 120
PROP.reqlvl = { construction = 30 }
PROP.uid = "decor10"
Shop_RegisterProp( "decor", PROP )

PROP = {}
PROP.model = "models/props/cs_office/TV_plasma.mdl"
PROP.title = "Plasma Television"
PROP.description = "All survival reality shows 24/7!\nNow with brighter colors!"
PROP.cost = { silver = 24, glass = 12 }
PROP.xp = 200
PROP.reqlvl = { construction = 40 }
PROP.uid = "decor11"
Shop_RegisterProp( "decor", PROP )

------------------------------------
-----------BETA WOOD PROPS----------
------------------------------------

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1.mdl"
PROP.title = "Wood Panel - 1x1"
PROP.description = ""
PROP.cost = { wood = 1 }
PROP.xp = 2
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood1"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x2.mdl"
PROP.title = "Wood Panel - 1x2"
PROP.description = ""
PROP.cost = { wood = 2 }
PROP.xp = 4
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood2"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x3.mdl"
PROP.title = "Wood Panel - 1x3"
PROP.description = ""
PROP.cost = { wood = 3 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood3"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1tri.mdl"
PROP.title = "Wood Panel - 1x1 Triangle"
PROP.description = ""
PROP.cost = { wood = 1 }
PROP.xp = 2
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood4"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x1.mdl"
PROP.title = "Wood Panel - 2x1"
PROP.description = ""
PROP.cost = { wood = 2 }
PROP.xp = 4
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood5"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2.mdl"
PROP.title = "Wood Panel - 2x2"
PROP.description = ""
PROP.cost = { wood = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood6"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x3.mdl"
PROP.title = "Wood Panel - 2x3"
PROP.description = ""
PROP.cost = { wood = 6 }
PROP.xp = 12
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood7"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2tri.mdl"
PROP.title = "Wood Panel - 2x2 Triangle"
PROP.description = ""
PROP.cost = { wood = 2 }
PROP.xp = 4
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood8"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x1.mdl"
PROP.title = "Wood Panel - 3x1"
PROP.description = ""
PROP.cost = { wood = 3 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood9"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x2.mdl"
PROP.title = "Wood Panel - 3x2"
PROP.description = ""
PROP.cost = { wood = 6 }
PROP.xp = 12
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood10"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3.mdl"
PROP.title = "Wood Panel - 3x3"
PROP.description = ""
PROP.cost = { wood = 9 }
PROP.xp = 18
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood11"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3tri.mdl"
PROP.title = "Wood Panel - 3x3 Triangle"
PROP.description = ""
PROP.cost = { wood = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood12"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x1.mdl"
PROP.title = "Wood Panel - 6x1"
PROP.description = ""
PROP.cost = { wood = 6 }
PROP.xp = 12
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood13"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x2.mdl"
PROP.title = "Wood Panel - 6x2"
PROP.description = ""
PROP.cost = { wood = 12 }
PROP.xp = 24
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood14"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x3.mdl"
PROP.title = "Wood Panel - 6x3"
PROP.description = ""
PROP.cost = { wood = 18 }
PROP.xp = 36
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood15"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6.mdl"
PROP.title = "Wood Panel - 6x6"
PROP.description = ""
PROP.cost = { wood = 36 }
PROP.xp = 72
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood16"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6tri.mdl"
PROP.title = "Wood Panel - 6x6 Triangle"
PROP.description = ""
PROP.cost = { wood = 18 }
PROP.xp = 32
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood17"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe2x3.mdl"
PROP.title = "Wood Door Frame - 2x3"
PROP.description = ""
PROP.cost = { wood = 3 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood18"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe3x3.mdl"
PROP.title = "Wood Door Frame - 3x3"
PROP.description = ""
PROP.cost = { wood = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood19"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank1.mdl"
PROP.title = "Wooden Plank - 1x"
PROP.description = ""
PROP.cost = { wood = 1 }
PROP.xp = 2
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood20"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank2.mdl"
PROP.title = "Wooden Plank - 2x"
PROP.description = ""
PROP.cost = { wood = 2 }
PROP.xp = 4
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood21"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank4.mdl"
PROP.title = "Wooden Plank - 4x"
PROP.description = ""
PROP.cost = { wood = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood22"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank6.mdl"
PROP.title = "Wooden Plank - 6x"
PROP.description = ""
PROP.cost = { wood = 6 }
PROP.xp = 12
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood23"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank10.mdl"
PROP.title = "Wooden Plank - 10x"
PROP.description = ""
PROP.cost = { wood = 10 }
PROP.xp = 20
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood24"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe2x3.mdl"
PROP.title = "Wooden Window Frame - 2x3"
PROP.description = ""
PROP.cost = { wood = 3 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood25"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x2.mdl"
PROP.title = "Wooden Window Frame - 3x2"
PROP.description = ""
PROP.cost = { wood = 3 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood26"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3.mdl"
PROP.title = "Wooden Window Frame - 3x3"
PROP.description = ""
PROP.cost = { wood = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood27"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3b.mdl"
PROP.title = "Wooden Window Frame - 3x3b"
PROP.description = ""
PROP.cost = { wood = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood28"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/glass/window1x1.mdl"
PROP.title = "Glass Window - 1x1"
PROP.description = ""
PROP.cost = { glass = 2 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood29"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/glass/window3x1.mdl"
PROP.title = "Glass Window - 3x1"
PROP.description = ""
PROP.cost = { glass = 6 }
PROP.xp = 18
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood30"
Shop_RegisterProp( "wood", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/glass/window3x3.mdl"
PROP.title = "Glass Window - 3x3"
PROP.description = ""
PROP.cost = { glass = 18 }
PROP.xp = 54
PROP.reqlvl = { construction = 1 }
PROP.uid = "betawood31"
Shop_RegisterProp( "wood", PROP )

-----------------------------------
-----------OAK WOOD PROPS----------
-----------------------------------

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1.mdl"
PROP.title = "Oak Panel - 1x1"
PROP.description = ""
PROP.cost = { oak_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood1"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x2.mdl"
PROP.title = "Oak Panel - 1x2"
PROP.description = ""
PROP.cost = { oak_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood2"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x3.mdl"
PROP.title = "Oak Panel - 1x3"
PROP.description = ""
PROP.cost = { oak_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood3"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1tri.mdl"
PROP.title = "Oak Panel - 1x1 Triangle"
PROP.description = ""
PROP.cost = { oak_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood4"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x1.mdl"
PROP.title = "Oak Panel - 2x1"
PROP.description = ""
PROP.cost = { oak_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood5"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2.mdl"
PROP.title = "Oak Panel - 2x2"
PROP.description = ""
PROP.cost = { oak_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood6"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x3.mdl"
PROP.title = "Oak Panel - 2x3"
PROP.description = ""
PROP.cost = { oak_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood7"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2tri.mdl"
PROP.title = "Oak Panel - 2x2 Triangle"
PROP.description = ""
PROP.cost = { oak_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood8"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x1.mdl"
PROP.title = "Oak Panel - 3x1"
PROP.description = ""
PROP.cost = { oak_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood9"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x2.mdl"
PROP.title = "Oak Panel - 3x2"
PROP.description = ""
PROP.cost = { oak_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood10"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3.mdl"
PROP.title = "Oak Panel - 3x3"
PROP.description = ""
PROP.cost = { oak_wood = 9 }
PROP.xp = 36
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood11"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3tri.mdl"
PROP.title = "Oak Panel - 3x3 Triangle"
PROP.description = ""
PROP.cost = { oak_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood12"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x1.mdl"
PROP.title = "Oak Panel - 6x1"
PROP.description = ""
PROP.cost = { oak_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood13"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x2.mdl"
PROP.title = "Oak Panel - 6x2"
PROP.description = ""
PROP.cost = { oak_wood = 12 }
PROP.xp = 48
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood14"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x3.mdl"
PROP.title = "Oak Panel - 6x3"
PROP.description = ""
PROP.cost = { oak_wood = 18 }
PROP.xp = 72
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood15"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6.mdl"
PROP.title = "Oak Panel - 6x6"
PROP.description = ""
PROP.cost = { oak_wood = 36 }
PROP.xp = 144
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood16"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6tri.mdl"
PROP.title = "Oak Panel - 6x6 Triangle"
PROP.description = ""
PROP.cost = { oak_wood = 18 }
PROP.xp = 64
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood17"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe2x3.mdl"
PROP.title = "Oak Door Frame - 2x3"
PROP.description = ""
PROP.cost = { oak_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood18"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe3x3.mdl"
PROP.title = "Oak Door Frame - 3x3"
PROP.description = ""
PROP.cost = { oak_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood19"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank1.mdl"
PROP.title = "Oak Plank - 1x"
PROP.description = ""
PROP.cost = { oak_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood20"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank2.mdl"
PROP.title = "Oak Plank - 2x"
PROP.description = ""
PROP.cost = { oak_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood21"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank4.mdl"
PROP.title = "Oak Plank - 4x"
PROP.description = ""
PROP.cost = { oak_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood22"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank6.mdl"
PROP.title = "Oak Plank - 6x"
PROP.description = ""
PROP.cost = { oak_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood23"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank10.mdl"
PROP.title = "Oak Plank - 10x"
PROP.description = ""
PROP.cost = { oak_wood = 10 }
PROP.xp = 40
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood24"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe2x3.mdl"
PROP.title = "Oak Window Frame - 2x3"
PROP.description = ""
PROP.cost = { oak_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood25"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x2.mdl"
PROP.title = "Oak Window Frame - 3x2"
PROP.description = ""
PROP.cost = { oak_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood26"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3.mdl"
PROP.title = "Oak Window Frame - 3x3"
PROP.description = ""
PROP.cost = { oak_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood27"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3b.mdl"
PROP.title = "Oak Window Frame - 3x3b"
PROP.description = ""
PROP.cost = { oak_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 15 }
PROP.uid = "oakwood28"
PROP.color = Color(255,228,156,255)
Shop_RegisterProp( "oak", PROP )

-------------------------------------
-----------MAPLE WOOD PROPS----------
-------------------------------------

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1.mdl"
PROP.title = "Maple Panel - 1x1"
PROP.description = ""
PROP.cost = { maple_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood1"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x2.mdl"
PROP.title = "Maple Panel - 1x2"
PROP.description = ""
PROP.cost = { maple_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood2"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x3.mdl"
PROP.title = "Maple Panel - 1x3"
PROP.description = ""
PROP.cost = { maple_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood3"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1tri.mdl"
PROP.title = "Maple Panel - 1x1 Triangle"
PROP.description = ""
PROP.cost = { maple_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood4"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x1.mdl"
PROP.title = "Maple Panel - 2x1"
PROP.description = ""
PROP.cost = { maple_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood5"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2.mdl"
PROP.title = "Maple Panel - 2x2"
PROP.description = ""
PROP.cost = { maple_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood6"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x3.mdl"
PROP.title = "Maple Panel - 2x3"
PROP.description = ""
PROP.cost = { maple_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood7"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2tri.mdl"
PROP.title = "Maple Panel - 2x2 Triangle"
PROP.description = ""
PROP.cost = { maple_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood8"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x1.mdl"
PROP.title = "Maple Panel - 3x1"
PROP.description = ""
PROP.cost = { maple_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood9"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x2.mdl"
PROP.title = "Maple Panel - 3x2"
PROP.description = ""
PROP.cost = { maple_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood10"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3.mdl"
PROP.title = "Maple Panel - 3x3"
PROP.description = ""
PROP.cost = { maple_wood = 9 }
PROP.xp = 36
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood11"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3tri.mdl"
PROP.title = "Maple Panel - 3x3 Triangle"
PROP.description = ""
PROP.cost = { maple_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood12"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x1.mdl"
PROP.title = "Maple Panel - 6x1"
PROP.description = ""
PROP.cost = { maple_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood13"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x2.mdl"
PROP.title = "Maple Panel - 6x2"
PROP.description = ""
PROP.cost = { maple_wood = 12 }
PROP.xp = 48
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood14"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x3.mdl"
PROP.title = "Maple Panel - 6x3"
PROP.description = ""
PROP.cost = { maple_wood = 18 }
PROP.xp = 72
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood15"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6.mdl"
PROP.title = "Maple Panel - 6x6"
PROP.description = ""
PROP.cost = { maple_wood = 36 }
PROP.xp = 144
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood16"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6tri.mdl"
PROP.title = "Maple Panel - 6x6 Triangle"
PROP.description = ""
PROP.cost = { maple_wood = 18 }
PROP.xp = 64
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood17"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe2x3.mdl"
PROP.title = "Maple Door Frame - 2x3"
PROP.description = ""
PROP.cost = { maple_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood18"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe3x3.mdl"
PROP.title = "Maple Door Frame - 3x3"
PROP.description = ""
PROP.cost = { maple_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood19"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank1.mdl"
PROP.title = "Maple Plank - 1x"
PROP.description = ""
PROP.cost = { maple_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood20"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank2.mdl"
PROP.title = "Maple Plank - 2x"
PROP.description = ""
PROP.cost = { maple_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood21"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank4.mdl"
PROP.title = "Maple Plank - 4x"
PROP.description = ""
PROP.cost = { maple_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood22"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank6.mdl"
PROP.title = "Maple Plank - 6x"
PROP.description = ""
PROP.cost = { maple_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood23"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank10.mdl"
PROP.title = "Maple Plank - 10x"
PROP.description = ""
PROP.cost = { maple_wood = 10 }
PROP.xp = 40
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood24"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe2x3.mdl"
PROP.title = "Maple Window Frame - 2x3"
PROP.description = ""
PROP.cost = { maple_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood25"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x2.mdl"
PROP.title = "Maple Window Frame - 3x2"
PROP.description = ""
PROP.cost = { maple_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood26"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3.mdl"
PROP.title = "Maple Window Frame - 3x3"
PROP.description = ""
PROP.cost = { maple_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood27"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3b.mdl"
PROP.title = "Maple Window Frame - 3x3b"
PROP.description = ""
PROP.cost = { maple_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 25 }
PROP.uid = "maplewood28"
PROP.color = Color(255,189,156,255)
Shop_RegisterProp( "maple", PROP )

------------------------------------
-----------PINE WOOD PROPS----------
------------------------------------

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1.mdl"
PROP.title = "Pine Panel - 1x1"
PROP.description = ""
PROP.cost = { pine_wood = 1 }
PROP.xp = 2
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood1"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x2.mdl"
PROP.title = "Pine Panel - 1x2"
PROP.description = ""
PROP.cost = { pine_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood2"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x3.mdl"
PROP.title = "Pine Panel - 1x3"
PROP.description = ""
PROP.cost = { pine_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood3"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1tri.mdl"
PROP.title = "Pine Panel - 1x1 Triangle"
PROP.description = ""
PROP.cost = { pine_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood4"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x1.mdl"
PROP.title = "Pine Panel - 2x1"
PROP.description = ""
PROP.cost = { pine_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood5"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2.mdl"
PROP.title = "Pine Panel - 2x2"
PROP.description = ""
PROP.cost = { pine_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood6"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x3.mdl"
PROP.title = "Pine Panel - 2x3"
PROP.description = ""
PROP.cost = { pine_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood7"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2tri.mdl"
PROP.title = "Pine Panel - 2x2 Triangle"
PROP.description = ""
PROP.cost = { pine_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood8"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x1.mdl"
PROP.title = "Pine Panel - 3x1"
PROP.description = ""
PROP.cost = { pine_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood9"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x2.mdl"
PROP.title = "Pine Panel - 3x2"
PROP.description = ""
PROP.cost = { pine_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood10"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3.mdl"
PROP.title = "Pine Panel - 3x3"
PROP.description = ""
PROP.cost = { pine_wood = 9 }
PROP.xp = 36
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood11"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3tri.mdl"
PROP.title = "Pine Panel - 3x3 Triangle"
PROP.description = ""
PROP.cost = { pine_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood12"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x1.mdl"
PROP.title = "Pine Panel - 6x1"
PROP.description = ""
PROP.cost = { pine_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood13"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x2.mdl"
PROP.title = "Pine Panel - 6x2"
PROP.description = ""
PROP.cost = { pine_wood = 12 }
PROP.xp = 48
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood14"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x3.mdl"
PROP.title = "Pine Panel - 6x3"
PROP.description = ""
PROP.cost = { pine_wood = 18 }
PROP.xp = 72
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood15"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6.mdl"
PROP.title = "Pine Panel - 6x6"
PROP.description = ""
PROP.cost = { pine_wood = 36 }
PROP.xp = 144
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood16"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6tri.mdl"
PROP.title = "Pine Panel - 6x6 Triangle"
PROP.description = ""
PROP.cost = { pine_wood = 18 }
PROP.xp = 64
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood17"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe2x3.mdl"
PROP.title = "Pine Door Frame - 2x3"
PROP.description = ""
PROP.cost = { pine_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood18"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe3x3.mdl"
PROP.title = "Pine Door Frame - 3x3"
PROP.description = ""
PROP.cost = { pine_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood19"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank1.mdl"
PROP.title = "Pine Plank - 1x"
PROP.description = ""
PROP.cost = { pine_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood20"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank2.mdl"
PROP.title = "Pine Plank - 2x"
PROP.description = ""
PROP.cost = { pine_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood21"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank4.mdl"
PROP.title = "Pine Plank - 4x"
PROP.description = ""
PROP.cost = { pine_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood22"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank6.mdl"
PROP.title = "Pine Plank - 6x"
PROP.description = ""
PROP.cost = { pine_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood23"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank10.mdl"
PROP.title = "Pine Plank - 10x"
PROP.description = ""
PROP.cost = { pine_wood = 10 }
PROP.xp = 40
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood24"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe2x3.mdl"
PROP.title = "Pine Window Frame - 2x3"
PROP.description = ""
PROP.cost = { pine_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood25"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x2.mdl"
PROP.title = "Pine Window Frame - 3x2"
PROP.description = ""
PROP.cost = { pine_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood26"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3.mdl"
PROP.title = "Pine Window Frame - 3x3"
PROP.description = ""
PROP.cost = { pine_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood27"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3b.mdl"
PROP.title = "Pine Window Frame - 3x3b"
PROP.description = ""
PROP.cost = { pine_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 35 }
PROP.uid = "pinewood28"
PROP.color = Color(255,250,156,255)
Shop_RegisterProp( "pine", PROP )

-----------------------------------
-----------YEW WOOD PROPS----------
-----------------------------------

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1.mdl"
PROP.title = "Yew Panel - 1x1"
PROP.description = ""
PROP.cost = { yew_wood = 1 }
PROP.xp = 2
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood1"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x2.mdl"
PROP.title = "Yew Panel - 1x2"
PROP.description = ""
PROP.cost = { yew_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood2"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x3.mdl"
PROP.title = "Yew Panel - 1x3"
PROP.description = ""
PROP.cost = { yew_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood3"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1tri.mdl"
PROP.title = "Yew Panel - 1x1 Triangle"
PROP.description = ""
PROP.cost = { yew_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood4"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x1.mdl"
PROP.title = "Yew Panel - 2x1"
PROP.description = ""
PROP.cost = { yew_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood5"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2.mdl"
PROP.title = "Yew Panel - 2x2"
PROP.description = ""
PROP.cost = { yew_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood6"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x3.mdl"
PROP.title = "Yew Panel - 2x3"
PROP.description = ""
PROP.cost = { yew_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood7"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2tri.mdl"
PROP.title = "Yew Panel - 2x2 Triangle"
PROP.description = ""
PROP.cost = { yew_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood8"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x1.mdl"
PROP.title = "Yew Panel - 3x1"
PROP.description = ""
PROP.cost = { yew_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood9"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x2.mdl"
PROP.title = "Yew Panel - 3x2"
PROP.description = ""
PROP.cost = { yew_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood10"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3.mdl"
PROP.title = "Yew Panel - 3x3"
PROP.description = ""
PROP.cost = { yew_wood = 9 }
PROP.xp = 36
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood11"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3tri.mdl"
PROP.title = "Yew Panel - 3x3 Triangle"
PROP.description = ""
PROP.cost = { yew_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood12"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x1.mdl"
PROP.title = "Yew Panel - 6x1"
PROP.description = ""
PROP.cost = { yew_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood13"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x2.mdl"
PROP.title = "Yew Panel - 6x2"
PROP.description = ""
PROP.cost = { yew_wood = 12 }
PROP.xp = 48
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood14"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x3.mdl"
PROP.title = "Yew Panel - 6x3"
PROP.description = ""
PROP.cost = { yew_wood = 18 }
PROP.xp = 72
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood15"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6.mdl"
PROP.title = "Yew Panel - 6x6"
PROP.description = ""
PROP.cost = { yew_wood = 36 }
PROP.xp = 144
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood16"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6tri.mdl"
PROP.title = "Yew Panel - 6x6 Triangle"
PROP.description = ""
PROP.cost = { yew_wood = 18 }
PROP.xp = 64
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood17"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe2x3.mdl"
PROP.title = "Yew Door Frame - 2x3"
PROP.description = ""
PROP.cost = { yew_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood18"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe3x3.mdl"
PROP.title = "Yew Door Frame - 3x3"
PROP.description = ""
PROP.cost = { yew_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood19"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank1.mdl"
PROP.title = "Yew Plank - 1x"
PROP.description = ""
PROP.cost = { yew_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood20"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank2.mdl"
PROP.title = "Yew Plank - 2x"
PROP.description = ""
PROP.cost = { yew_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood21"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank4.mdl"
PROP.title = "Yew Plank - 4x"
PROP.description = ""
PROP.cost = { yew_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood22"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank6.mdl"
PROP.title = "Yew Plank - 6x"
PROP.description = ""
PROP.cost = { yew_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood23"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank10.mdl"
PROP.title = "Yew Plank - 10x"
PROP.description = ""
PROP.cost = { yew_wood = 10 }
PROP.xp = 40
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood24"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe2x3.mdl"
PROP.title = "Yew Window Frame - 2x3"
PROP.description = ""
PROP.cost = { yew_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood25"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x2.mdl"
PROP.title = "Yew Window Frame - 3x2"
PROP.description = ""
PROP.cost = { yew_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood26"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3.mdl"
PROP.title = "Yew Window Frame - 3x3"
PROP.description = ""
PROP.cost = { yew_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood27"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3b.mdl"
PROP.title = "Yew Window Frame - 3x3b"
PROP.description = ""
PROP.cost = { yew_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 45 }
PROP.uid = "yewwood28"
PROP.color = Color(253,179,119,255)
Shop_RegisterProp( "yew", PROP )

---------------------------------------
-----------BUCKEYE WOOD PROPS----------
---------------------------------------

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1.mdl"
PROP.title = "Buckeye Panel - 1x1"
PROP.description = ""
PROP.cost = { buckeye_wood = 1 }
PROP.xp = 2
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood1"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x2.mdl"
PROP.title = "Buckeye Panel - 1x2"
PROP.description = ""
PROP.cost = { buckeye_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood2"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x3.mdl"
PROP.title = "Buckeye Panel - 1x3"
PROP.description = ""
PROP.cost = { buckeye_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood3"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1tri.mdl"
PROP.title = "Buckeye Panel - 1x1 Triangle"
PROP.description = ""
PROP.cost = { buckeye_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood4"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x1.mdl"
PROP.title = "Buckeye Panel - 2x1"
PROP.description = ""
PROP.cost = { buckeye_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood5"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2.mdl"
PROP.title = "Buckeye Panel - 2x2"
PROP.description = ""
PROP.cost = { buckeye_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood6"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x3.mdl"
PROP.title = "Buckeye Panel - 2x3"
PROP.description = ""
PROP.cost = { buckeye_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood7"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2tri.mdl"
PROP.title = "Buckeye Panel - 2x2 Triangle"
PROP.description = ""
PROP.cost = { buckeye_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood8"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x1.mdl"
PROP.title = "Buckeye Panel - 3x1"
PROP.description = ""
PROP.cost = { buckeye_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood9"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x2.mdl"
PROP.title = "Buckeye Panel - 3x2"
PROP.description = ""
PROP.cost = { buckeye_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood10"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3.mdl"
PROP.title = "Buckeye Panel - 3x3"
PROP.description = ""
PROP.cost = { buckeye_wood = 9 }
PROP.xp = 36
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood11"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3tri.mdl"
PROP.title = "Buckeye Panel - 3x3 Triangle"
PROP.description = ""
PROP.cost = { buckeye_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood12"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x1.mdl"
PROP.title = "Buckeye Panel - 6x1"
PROP.description = ""
PROP.cost = { buckeye_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood13"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x2.mdl"
PROP.title = "Buckeye Panel - 6x2"
PROP.description = ""
PROP.cost = { buckeye_wood = 12 }
PROP.xp = 48
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood14"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x3.mdl"
PROP.title = "Buckeye Panel - 6x3"
PROP.description = ""
PROP.cost = { buckeye_wood = 18 }
PROP.xp = 72
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood15"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6.mdl"
PROP.title = "Buckeye Panel - 6x6"
PROP.description = ""
PROP.cost = { buckeye_wood = 36 }
PROP.xp = 144
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood16"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6tri.mdl"
PROP.title = "Buckeye Panel - 6x6 Triangle"
PROP.description = ""
PROP.cost = { buckeye_wood = 18 }
PROP.xp = 64
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood17"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe2x3.mdl"
PROP.title = "Buckeye Door Frame - 2x3"
PROP.description = ""
PROP.cost = { buckeye_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood18"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe3x3.mdl"
PROP.title = "Buckeye Door Frame - 3x3"
PROP.description = ""
PROP.cost = { buckeye_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood19"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank1.mdl"
PROP.title = "Buckeye Plank - 1x"
PROP.description = ""
PROP.cost = { buckeye_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood20"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank2.mdl"
PROP.title = "Buckeye Plank - 2x"
PROP.description = ""
PROP.cost = { buckeye_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood21"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank4.mdl"
PROP.title = "Buckeye Plank - 4x"
PROP.description = ""
PROP.cost = { buckeye_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood22"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank6.mdl"
PROP.title = "Buckeye Plank - 6x"
PROP.description = ""
PROP.cost = { buckeye_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood23"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank10.mdl"
PROP.title = "Buckeye Plank - 10x"
PROP.description = ""
PROP.cost = { buckeye_wood = 10 }
PROP.xp = 40
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood24"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe2x3.mdl"
PROP.title = "Buckeye Window Frame - 2x3"
PROP.description = ""
PROP.cost = { buckeye_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood25"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x2.mdl"
PROP.title = "Buckeye Window Frame - 3x2"
PROP.description = ""
PROP.cost = { buckeye_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood26"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3.mdl"
PROP.title = "Buckeye Window Frame - 3x3"
PROP.description = ""
PROP.cost = { buckeye_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood27"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3b.mdl"
PROP.title = "Buckeye Window Frame - 3x3b"
PROP.description = ""
PROP.cost = { buckeye_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 55 }
PROP.uid = "buckeyewood28"
PROP.color = Color(63,41,3,255)
Shop_RegisterProp( "buckeye", PROP )

--------------------------------------
------------PALM WOOD PROPS-----------
--------------------------------------

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1.mdl"
PROP.title = "Palm Panel - 1x1"
PROP.description = ""
PROP.cost = { palm_wood = 1 }
PROP.xp = 2
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood1"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x2.mdl"
PROP.title = "Palm Panel - 1x2"
PROP.description = ""
PROP.cost = { palm_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood2"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x3.mdl"
PROP.title = "Palm Panel - 1x3"
PROP.description = ""
PROP.cost = { palm_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood3"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/1x1tri.mdl"
PROP.title = "Palm Panel - 1x1 Triangle"
PROP.description = ""
PROP.cost = { palm_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood4"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x1.mdl"
PROP.title = "Palm Panel - 2x1"
PROP.description = ""
PROP.cost = { palm_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood5"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2.mdl"
PROP.title = "Palm Panel - 2x2"
PROP.description = ""
PROP.cost = { palm_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood6"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x3.mdl"
PROP.title = "Palm Panel - 2x3"
PROP.description = ""
PROP.cost = { palm_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood7"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/2x2tri.mdl"
PROP.title = "Palm Panel - 2x2 Triangle"
PROP.description = ""
PROP.cost = { palm_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood8"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x1.mdl"
PROP.title = "Palm Panel - 3x1"
PROP.description = ""
PROP.cost = { palm_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood9"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x2.mdl"
PROP.title = "Palm Panel - 3x2"
PROP.description = ""
PROP.cost = { palm_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood10"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3.mdl"
PROP.title = "Palm Panel - 3x3"
PROP.description = ""
PROP.cost = { palm_wood = 9 }
PROP.xp = 36
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood11"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/3x3tri.mdl"
PROP.title = "Palm Panel - 3x3 Triangle"
PROP.description = ""
PROP.cost = { palm_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood12"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x1.mdl"
PROP.title = "Palm Panel - 6x1"
PROP.description = ""
PROP.cost = { palm_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood13"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x2.mdl"
PROP.title = "Palm Panel - 6x2"
PROP.description = ""
PROP.cost = { palm_wood = 12 }
PROP.xp = 48
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood14"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x3.mdl"
PROP.title = "Palm Panel - 6x3"
PROP.description = ""
PROP.cost = { palm_wood = 18 }
PROP.xp = 72
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood15"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6.mdl"
PROP.title = "Palm Panel - 6x6"
PROP.description = ""
PROP.cost = { palm_wood = 36 }
PROP.xp = 144
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood16"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/6x6tri.mdl"
PROP.title = "Palm Panel - 6x6 Triangle"
PROP.description = ""
PROP.cost = { palm_wood = 18 }
PROP.xp = 64
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood17"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe2x3.mdl"
PROP.title = "Palm Door Frame - 2x3"
PROP.description = ""
PROP.cost = { palm_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood18"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/doorframe3x3.mdl"
PROP.title = "Palm Door Frame - 3x3"
PROP.description = ""
PROP.cost = { palm_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood19"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank1.mdl"
PROP.title = "Palm Plank - 1x"
PROP.description = ""
PROP.cost = { palm_wood = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood20"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank2.mdl"
PROP.title = "Palm Plank - 2x"
PROP.description = ""
PROP.cost = { palm_wood = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood21"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank4.mdl"
PROP.title = "Palm Plank - 4x"
PROP.description = ""
PROP.cost = { palm_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood22"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank6.mdl"
PROP.title = "Palm Plank - 6x"
PROP.description = ""
PROP.cost = { palm_wood = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood23"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/plank10.mdl"
PROP.title = "Palm Plank - 10x"
PROP.description = ""
PROP.cost = { palm_wood = 10 }
PROP.xp = 40
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood24"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe2x3.mdl"
PROP.title = "Palm Window Frame - 2x3"
PROP.description = ""
PROP.cost = { palm_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood25"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x2.mdl"
PROP.title = "Palm Window Frame - 3x2"
PROP.description = ""
PROP.cost = { palm_wood = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood26"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3.mdl"
PROP.title = "Palm Window Frame - 3x3"
PROP.description = ""
PROP.cost = { palm_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood27"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/wood/windowframe3x3b.mdl"
PROP.title = "Palm Window Frame - 3x3b"
PROP.description = ""
PROP.cost = { palm_wood = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 65 }
PROP.uid = "palmwood28"
PROP.color = Color(200,200,230,255)
Shop_RegisterProp( "palm", PROP )


-------------------------------------
-----------BETA STONE PROPS----------
-------------------------------------

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/1x1.mdl"
PROP.title = "Stone Panel - 1x1"
PROP.description = ""
PROP.cost = { stone = 1 }
PROP.xp = 2
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone1"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/1x2.mdl"
PROP.title = "Stone Panel - 1x2"
PROP.description = ""
PROP.cost = { stone = 2 }
PROP.xp = 4
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone2"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/1x3.mdl"
PROP.title = "Stone Panel - 1x3"
PROP.description = ""
PROP.cost = { stone = 3 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone3"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/1x1tri.mdl"
PROP.title = "Stone Panel - 1x1 Triangle"
PROP.description = ""
PROP.cost = { stone = 1 }
PROP.xp = 2
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone4"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/2x1.mdl"
PROP.title = "Stone Panel - 2x1"
PROP.description = ""
PROP.cost = { stone = 2 }
PROP.xp = 4
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone5"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/2x2.mdl"
PROP.title = "Stone Panel - 2x2"
PROP.description = ""
PROP.cost = { stone = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone6"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/2x3.mdl"
PROP.title = "Stone Panel - 2x3"
PROP.description = ""
PROP.cost = { stone = 6 }
PROP.xp = 12
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone7"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/2x2tri.mdl"
PROP.title = "Stone Panel - 2x2 Triangle"
PROP.description = ""
PROP.cost = { stone = 2 }
PROP.xp = 4
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone8"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/3x1.mdl"
PROP.title = "Stone Panel - 3x1"
PROP.description = ""
PROP.cost = { stone = 3 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone9"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/3x2.mdl"
PROP.title = "Stone Panel - 3x2"
PROP.description = ""
PROP.cost = { stone = 6 }
PROP.xp = 12
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone10"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/3x3.mdl"
PROP.title = "Stone Panel - 3x3"
PROP.description = ""
PROP.cost = { stone = 9 }
PROP.xp = 18
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone11"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/3x3tri.mdl"
PROP.title = "Stone Panel - 3x3 Triangle"
PROP.description = ""
PROP.cost = { stone = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone12"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/6x1.mdl"
PROP.title = "Stone Panel - 6x1"
PROP.description = ""
PROP.cost = { stone = 6 }
PROP.xp = 12
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone13"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/6x2.mdl"
PROP.title = "Stone Panel - 6x2"
PROP.description = ""
PROP.cost = { stone = 12 }
PROP.xp = 24
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone14"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/6x3.mdl"
PROP.title = "Stone Panel - 6x3"
PROP.description = ""
PROP.cost = { stone = 18 }
PROP.xp = 36
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone15"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/6x6.mdl"
PROP.title = "Stone Panel - 6x6"
PROP.description = ""
PROP.cost = { stone = 36 }
PROP.xp = 72
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone16"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/6x6tri.mdl"
PROP.title = "Stone Panel - 6x6 Triangle"
PROP.description = ""
PROP.cost = { stone = 18 }
PROP.xp = 36
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone17"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/doorframe2x3.mdl"
PROP.title = "Stone Door Frame - 2x3"
PROP.description = ""
PROP.cost = { stone = 3 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone18"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/doorframe3x3.mdl"
PROP.title = "Stone Door Frame - 3x3"
PROP.description = ""
PROP.cost = { stone = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone19"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/windowframe2x3.mdl"
PROP.title = "Stone Window Frame - 2x3"
PROP.description = ""
PROP.cost = { stone = 3 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone25"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/windowframe3x2.mdl"
PROP.title = "Stone Window Frame - 3x2"
PROP.description = ""
PROP.cost = { stone = 3 }
PROP.xp = 6
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone26"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/windowframe3x3.mdl"
PROP.title = "Stone Window Frame - 3x3"
PROP.description = ""
PROP.cost = { stone = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone27"
Shop_RegisterProp( "stone", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/stone/windowframe3x3b.mdl"
PROP.title = "Stone Window Frame - 3x3b"
PROP.description = ""
PROP.cost = { stone = 4 }
PROP.xp = 8
PROP.reqlvl = { construction = 1 }
PROP.uid = "betastone28"
Shop_RegisterProp( "stone", PROP )

-------------------------------------
-----------BETA METAL PROPS----------
-------------------------------------

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/1x1.mdl"
PROP.title = "Metal Panel - 1x1"
PROP.description = ""
PROP.cost = { metal = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal1"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/1x2.mdl"
PROP.title = "Metal Panel - 1x2"
PROP.description = ""
PROP.cost = { metal = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal2"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/1x3.mdl"
PROP.title = "Metal Panel - 1x3"
PROP.description = ""
PROP.cost = { metal = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal3"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/1x1tri.mdl"
PROP.title = "Metal Panel - 1x1 Triangle"
PROP.description = ""
PROP.cost = { metal = 1 }
PROP.xp = 4
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal4"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/2x1.mdl"
PROP.title = "Metal Panel - 2x1"
PROP.description = ""
PROP.cost = { metal = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal5"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/2x2.mdl"
PROP.title = "Metal Panel - 2x2"
PROP.description = ""
PROP.cost = { metal = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal6"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/2x3.mdl"
PROP.title = "Metal Panel - 2x3"
PROP.description = ""
PROP.cost = { metal = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal7"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/2x2tri.mdl"
PROP.title = "Metal Panel - 2x2 Triangle"
PROP.description = ""
PROP.cost = { metal = 2 }
PROP.xp = 8
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal8"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/3x1.mdl"
PROP.title = "Metal Panel - 3x1"
PROP.description = ""
PROP.cost = { metal = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal9"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/3x2.mdl"
PROP.title = "Metal Panel - 3x2"
PROP.description = ""
PROP.cost = { metal = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal10"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/3x3.mdl"
PROP.title = "Metal Panel - 3x3"
PROP.description = ""
PROP.cost = { metal = 9 }
PROP.xp = 36
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal11"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/3x3tri.mdl"
PROP.title = "Metal Panel - 3x3 Triangle"
PROP.description = ""
PROP.cost = { metal = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal12"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/6x1.mdl"
PROP.title = "Metal Panel - 6x1"
PROP.description = ""
PROP.cost = { metal = 6 }
PROP.xp = 24
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal13"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/6x2.mdl"
PROP.title = "Metal Panel - 6x2"
PROP.description = ""
PROP.cost = { metal = 12 }
PROP.xp = 48
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal14"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/6x3.mdl"
PROP.title = "Metal Panel - 6x3"
PROP.description = ""
PROP.cost = { metal = 18 }
PROP.xp = 72
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal15"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/6x6.mdl"
PROP.title = "Metal Panel - 6x6"
PROP.description = ""
PROP.cost = { metal = 36 }
PROP.xp = 144
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal16"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/6x6tri.mdl"
PROP.title = "Metal Panel - 6x6 Triangle"
PROP.description = ""
PROP.cost = { metal = 18 }
PROP.xp = 72
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal17"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/doorframe2x3.mdl"
PROP.title = "Metal Door Frame - 2x3"
PROP.description = ""
PROP.cost = { metal = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal18"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/doorframe3x3.mdl"
PROP.title = "Metal Door Frame - 3x3"
PROP.description = ""
PROP.cost = { metal = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal19"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/windowframe2x3.mdl"
PROP.title = "Metal Window Frame - 2x3"
PROP.description = ""
PROP.cost = { metal = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal25"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/windowframe3x2.mdl"
PROP.title = "Metal Window Frame - 3x2"
PROP.description = ""
PROP.cost = { metal = 3 }
PROP.xp = 12
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal26"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/windowframe3x3.mdl"
PROP.title = "Metal Window Frame - 3x3"
PROP.description = ""
PROP.cost = { metal = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal27"
Shop_RegisterProp( "metal", PROP )

PROP = {}
PROP.model = "models/props/g4pmodelpack/metal/windowframe3x3b.mdl"
PROP.title = "Metal Window Frame - 3x3b"
PROP.description = ""
PROP.cost = { metal = 4 }
PROP.xp = 16
PROP.reqlvl = { construction = 5 }
PROP.uid = "betametal28"
Shop_RegisterProp( "metal", PROP )