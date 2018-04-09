SGS.Seeds = {}
function Menu_RegisterSeed( category, seed )
	if not SGS.Seeds[category] then SGS.Seeds[category] = {} end
	SGS.Seeds[category][#SGS.Seeds[category] + 1] = seed
end


SEED = {}
SEED.title = "Pypa Seed"
SEED.buttontext = "Plant Pypa Seed"
SEED.resource = "pypa_seed"
SEED.entity = "gms_fruit"
SEED.experience = 16
SEED.reqlvl = { farming = 1 }
SEED.lvl = 1
SEED.color = Color(255,0,255,255)
SEED.material = "models/debug/debugwhite"
SEED.eatheal = 100
SEED.minfruit = 1
SEED.maxfruit = 3
SEED.growtime = 45
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/pypa_seed.png"
Menu_RegisterSeed( "fruit", SEED )

SEED = {}
SEED.title = "Guacca Seed"
SEED.buttontext = "Plant Guacca Seed"
SEED.resource = "guacca_seed"
SEED.entity = "gms_fruit"
SEED.experience = 22
SEED.reqlvl = { farming = 7 }
SEED.lvl = 2
SEED.color = Color(255,0,0,255)
SEED.material = "models/debug/debugwhite"
SEED.eatheal = 200
SEED.minfruit = 2
SEED.maxfruit = 4
SEED.growtime = 90
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/guacca_seed.png"
Menu_RegisterSeed( "fruit", SEED )

SEED = {}
SEED.title = "Arctus Seed"
SEED.buttontext = "Plant Arctus Seed"
SEED.resource = "arctus_seed"
SEED.entity = "gms_fruit"
SEED.experience = 37
SEED.reqlvl = { farming = 18 }
SEED.lvl = 3
SEED.color = Color(255,255,255,255)
SEED.material = "models/debug/debugwhite"
SEED.eatheal = 300
SEED.minfruit = 2
SEED.maxfruit = 5
SEED.growtime = 90
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/arctus_seed.png"
Menu_RegisterSeed( "fruit", SEED )

SEED = {}
SEED.title = "Liechi Seed"
SEED.buttontext = "Plant Liechi Seed"
SEED.resource = "liechi_seed"
SEED.entity = "gms_fruit"
SEED.experience = 50
SEED.reqlvl = { farming = 21 }
SEED.lvl = 4
SEED.color = Color(0,0,255,255)
SEED.material = "models/debug/debugwhite"
SEED.eatheal = 400
SEED.minfruit = 3
SEED.maxfruit = 6
SEED.growtime = 90
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/liechi_seed.png"
Menu_RegisterSeed( "fruit", SEED )

SEED = {}
SEED.title = "Lum Seed"
SEED.buttontext = "Plant Lum Seed"
SEED.resource = "lum_seed"
SEED.entity = "gms_fruit"
SEED.experience = 80
SEED.reqlvl = { farming = 28 }
SEED.lvl = 5
SEED.color = Color(0,255,0,255)
SEED.material = "models/flesh"
SEED.eatheal = 500
SEED.minfruit = 1
SEED.maxfruit = 4
SEED.growtime = 90
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/lum_seed.png"
Menu_RegisterSeed( "fruit", SEED )

SEED = {}
SEED.title = "Perriot Seed"
SEED.buttontext = "Plant Perriot Seed"
SEED.resource = "perriot_seed"
SEED.entity = "gms_fruit"
SEED.experience = 120
SEED.reqlvl = { farming = 50 }
SEED.lvl = 6
SEED.color = Color(255,255,0,255)
SEED.material = "models/flesh"
SEED.eatheal = 750
SEED.minfruit = 1
SEED.maxfruit = 3
SEED.growtime = 90
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/perriot_seed.png"
Menu_RegisterSeed( "fruit", SEED )

SEED = {}
SEED.title = "Pallie Seed"
SEED.buttontext = "Plant Pallie Seed"
SEED.resource = "pallie_seed"
SEED.entity = "gms_fruit"
SEED.experience = 180
SEED.reqlvl = { farming = 55 }
SEED.lvl = 7
SEED.color = Color(0,255,255,255)
SEED.material = "models/flesh"
SEED.eatheal = 900
SEED.minfruit = 1
SEED.maxfruit = 2
SEED.growtime = 90
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/pallie_seed.png"
Menu_RegisterSeed( "fruit", SEED )

SEED = {}
SEED.title = "Moly Seed"
SEED.buttontext = "Plant Moly Seed"
SEED.resource = "moly_seed"
SEED.entity = "gms_fruit"
SEED.experience = 220
SEED.reqlvl = { farming = 65 }
SEED.lvl = 8
SEED.color = Color(255,0,0,255)
SEED.material = "models/flesh"
SEED.eatheal = 1200
SEED.minfruit = 1
SEED.maxfruit = 2
SEED.growtime = 120
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/moly_seed.png"
Menu_RegisterSeed( "fruit", SEED )

SEED = {}
SEED.title = "Karopa Seed"
SEED.buttontext = "Plant Karopa Seed"
SEED.resource = "karopa_seed"
SEED.entity = "gms_fruit"
SEED.experience = 360
SEED.reqlvl = { farming = 72 }
SEED.lvl = 9
SEED.color = Color(255,255,255,255)
SEED.material = "models/props_combine/com_shield001a"
SEED.eatheal = 1500
SEED.minfruit = 1
SEED.maxfruit = 3
SEED.growtime = 180
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/karopa_seed.png"
Menu_RegisterSeed( "fruit", SEED )








SEED = {}
SEED.title = "Tree Seed"
SEED.buttontext = "Plant Tree Seed"
SEED.resource = "tree_seed"
SEED.entity = "gms_tree"
SEED.experience = 100
SEED.reqlvl = { farming = 32 }
SEED.lvl = 1
SEED.growtime = 90
SEED.icon = "vgui/farming/tree_seed.png"
Menu_RegisterSeed( "trees", SEED )

SEED = {}
SEED.title = "Oak Seed"
SEED.buttontext = "Plant Oak Seed"
SEED.resource = "oak_seed"
SEED.entity = "gms_tree2"
SEED.experience = 130
SEED.reqlvl = { farming = 38 }
SEED.lvl = 2
SEED.growtime = 150
SEED.icon = "vgui/farming/oak_seed.png"
Menu_RegisterSeed( "trees", SEED )

SEED = {}
SEED.title = "Maple Seed"
SEED.buttontext = "Plant Maple Seed"
SEED.resource = "maple_seed"
SEED.entity = "gms_tree3"
SEED.experience = 160
SEED.reqlvl = { farming = 45 }
SEED.lvl = 3
SEED.growtime = 210
SEED.icon = "vgui/farming/maple_seed.png"
Menu_RegisterSeed( "trees", SEED )

SEED = {}
SEED.title = "Pine Seed"
SEED.buttontext = "Plant Pine Seed"
SEED.resource = "pine_seed"
SEED.entity = "gms_tree4"
SEED.experience = 190
SEED.reqlvl = { farming = 50 }
SEED.lvl = 4
SEED.growtime = 270
SEED.icon = "vgui/farming/pine_seed.png"
Menu_RegisterSeed( "trees", SEED )

SEED = {}
SEED.title = "Yew Seed"
SEED.buttontext = "Plant Yew Seed"
SEED.resource = "yew_seed"
SEED.entity = "gms_tree5"
SEED.experience = 220
SEED.reqlvl = { farming = 55 }
SEED.lvl = 5
SEED.growtime = 300
SEED.icon = "vgui/farming/yew_seed.png"
Menu_RegisterSeed( "trees", SEED )

SEED = {}
SEED.title = "Buckeye Seed"
SEED.buttontext = "Plant Buckeye Seed"
SEED.resource = "buckeye_seed"
SEED.entity = "gms_tree6"
SEED.experience = 300
SEED.reqlvl = { farming = 65 }
SEED.lvl = 6
SEED.growtime = 420
SEED.icon = "vgui/farming/buckeye_seed.png"
Menu_RegisterSeed( "trees", SEED )

SEED = {}
SEED.title = "Palm Seed"
SEED.buttontext = "Plant Palm Seed"
SEED.resource = "palm_seed"
SEED.entity = "gms_tree7"
SEED.experience = 500
SEED.reqlvl = { farming = 74 }
SEED.lvl = 7
SEED.growtime = 600
SEED.icon = "vgui/farming/palm_seed.png"
Menu_RegisterSeed( "trees", SEED )





SEED = {}
SEED.title = "Wheat Seed"
SEED.buttontext = "Plant Wheat"
SEED.resource = "wheat_seed"
SEED.entity = "gms_wheat"
SEED.harvest = "wheat"
SEED.experience = 24
SEED.reqlvl = { farming = 8 }
SEED.growtime = 120
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/wheat_seed.png"
Menu_RegisterSeed( "food", SEED )




SEED = {}
SEED.title = "Liferoot Seed"
SEED.buttontext = "Plant Liferoot"
SEED.resource = "liferoot_seed"
SEED.entity = "gms_liferoot"
SEED.harvest = "liferoot"
SEED.experience = 24
SEED.reqlvl = { farming = 8 }
SEED.growtime = 120
SEED.model = "models/hunter/misc/sphere025x025.mdl"
SEED.icon = "vgui/farming/liferoot_seed.png"
Menu_RegisterSeed( "alchemy", SEED )