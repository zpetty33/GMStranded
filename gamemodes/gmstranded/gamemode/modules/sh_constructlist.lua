SGS.structures = {}

function Menu_RegisterStructure( category, recipe )
	if not SGS.structures[category] then SGS.structures[category] = {} end
	
	SGS.structures[category][#SGS.structures[category] + 1] = recipe
end

/*
Main Construction
*/

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/workbench.mdl"
RECIPE.title = "Workbench"
RECIPE.description = "Used to craft tools!"
RECIPE.cost = { wood = 15 }
RECIPE.reqlvl = { construction = 1 }
RECIPE.ent = "gms_workbench"
RECIPE.spawntime = 5
RECIPE.xp = 24
Menu_RegisterStructure( "main", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_c17/FurnitureTable003a.mdl"
RECIPE.title = "First Aid Workbench"
RECIPE.description = "Used to craft first aid items!"
RECIPE.cost = { wood = 15 }
RECIPE.reqlvl = { construction = 1 }
RECIPE.ent = "gms_aidbench"
RECIPE.spawntime = 5
RECIPE.xp = 24
Menu_RegisterStructure( "main", RECIPE )

RECIPE = {}
RECIPE.model = "models/Stove/stove.mdl"
RECIPE.title = "Stove"
RECIPE.description = "Used to cook food!"
RECIPE.cost = { wood = 10, stone = 10 }
RECIPE.reqlvl = { construction = 1 }
RECIPE.ent = "gms_stove"
RECIPE.spawntime = 5
RECIPE.xp = 35
Menu_RegisterStructure( "main", RECIPE )

RECIPE = {}
RECIPE.model = "models/furnace/furnace.mdl"
RECIPE.title = "Furnace"
RECIPE.description = "Used to smelt ores!"
RECIPE.cost = { wood = 10, stone = 20 }
RECIPE.reqlvl = { construction = 5 }
RECIPE.ent = "gms_furnace"
RECIPE.spawntime = 8
RECIPE.xp = 55
Menu_RegisterStructure( "main", RECIPE )

RECIPE = {}
RECIPE.model = "models/EnchantTable/enchanttable.mdl"
RECIPE.title = "Enchanted Workbench"
RECIPE.description = "Used to craft enchanted tools!"
RECIPE.cost = { silver = 50 }
RECIPE.reqlvl = { construction = 45 }
RECIPE.ent = "gms_workbench2"
RECIPE.spawntime = 6
RECIPE.xp = 400
Menu_RegisterStructure( "main", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/still.mdl"
RECIPE.title = "Alchemy Potions Lab"
RECIPE.description = "Used to brew potions!"
RECIPE.cost = { iron = 20, metal = 20 }
RECIPE.reqlvl = { construction = 10 }
RECIPE.ent = "gms_alchlab"
RECIPE.spawntime = 5
RECIPE.xp = 120
Menu_RegisterStructure( "main", RECIPE )

RECIPE = {}
RECIPE.model = "models/gemstation/gemstation.mdl"
RECIPE.title = "Tool Gemming Table"
RECIPE.description = "Create Gemmed Tools!"
RECIPE.cost = { trinium = 5, pine_wood = 12 }
RECIPE.reqlvl = { construction = 40 }
RECIPE.ent = "gms_gemtable"
RECIPE.spawntime = 5
RECIPE.xp = 320
Menu_RegisterStructure( "main", RECIPE )

RECIPE = {}
RECIPE.model = "models/arcane_forge/arcane_forge.mdl"
RECIPE.title = "Arcane Forge"
RECIPE.description = "Allows the creation of arcane stones!"
RECIPE.cost = { naquadah = 25, yew_wood = 25, prismatic_gem = 2 }
RECIPE.reqlvl = { construction = 45 }
RECIPE.ent = "gms_arcaneforge"
RECIPE.spawntime = 5
RECIPE.xp = 700
Menu_RegisterStructure( "main", RECIPE )

/*
Caches Construction
*/


RECIPE = {}
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.title = "Resource Cache"
RECIPE.description = "Store resources!"
RECIPE.cost = { wood = 30, stone = 20 }
RECIPE.reqlvl = { construction = 3 }
RECIPE.ent = "gms_rcache"
RECIPE.spawntime = 4
RECIPE.xp = 70
Menu_RegisterStructure( "cache", RECIPE )

RECIPE = {}
RECIPE.model = "models/MaxOfS2D/hover_rings.mdl"
RECIPE.title = "Persistent Cache"
RECIPE.description = "Stores resources across sessions!\nCapacity: 500"
RECIPE.cost = { oak_wood = 20, iron = 20 }
RECIPE.reqlvl = { construction = 15 }
RECIPE.ent = "gms_pcache"
RECIPE.spawntime = 6
RECIPE.xp = 250
Menu_RegisterStructure( "cache", RECIPE )

RECIPE = {}
RECIPE.model = "models/MaxOfS2D/hover_rings.mdl"
RECIPE.title = "Mystic Persistent Cache"
RECIPE.description = "Stores resources across sessions!\nCapacity: 2500"
RECIPE.cost = { stable_core = 1, reinforced_naquadah = 10 }
RECIPE.reqlvl = { construction = 55 }
RECIPE.ent = "gms_pcache3"
RECIPE.spawntime = 6
RECIPE.xp = 1200
Menu_RegisterStructure( "cache", RECIPE )

RECIPE = {}
RECIPE.model = "models/MaxOfS2D/hover_rings.mdl"
RECIPE.title = "Forged Persistent Cache"
RECIPE.description = "Stores resources across sessions!\nCapacity: 2000"
RECIPE.cost = { enchanted_metal = 5, gms_pcache = 4 }
RECIPE.reqlvl = { construction = 65 }
RECIPE.ent = "gms_pcache4"
RECIPE.spawntime = 6
RECIPE.xp = 4000
Menu_RegisterStructure( "cache", RECIPE )

RECIPE = {}
RECIPE.model = "models/MaxOfS2D/hover_rings.mdl"
RECIPE.title = "Boss Persistent Cache"
RECIPE.description = "Stores resources across sessions!\nCapacity: 4000"
RECIPE.cost = { boss_pcache_core = 1, mithril = 100 }
RECIPE.reqlvl = { construction = 65 }
RECIPE.ent = "gms_pcacheboss"
RECIPE.spawntime = 6
RECIPE.xp = 4000
Menu_RegisterStructure( "cache", RECIPE )

RECIPE = {}
RECIPE.model = "models/Items/ammoCrate_Rockets.mdl"
RECIPE.title = "Tools Cache"
RECIPE.description = "Store Tools!\nCapacity: 50"
RECIPE.cost = { wood = 30, stone = 20 }
RECIPE.reqlvl = { construction = 3 }
RECIPE.ent = "gms_tcache"
RECIPE.spawntime = 6
RECIPE.xp = 70
Menu_RegisterStructure( "cache", RECIPE )

RECIPE = {}
RECIPE.model = "models/Items/ammoCrate_Rockets.mdl"
RECIPE.title = "Persistent Tools Cache"
RECIPE.description = "Store Tools!\nNow with more persistiness!\nCapacity: 25"
RECIPE.cost = { wood = 20, iron = 10 }
RECIPE.reqlvl = { construction = 6 }
RECIPE.ent = "gms_ptcache"
RECIPE.spawntime = 5
RECIPE.xp = 150
Menu_RegisterStructure( "cache", RECIPE )

/*
Misc Construction
*/

RECIPE = {}
RECIPE.model = "models/props_combine/combine_mine01.mdl"
RECIPE.title = "Mobile Spawn"
RECIPE.description = "Change your spawn!"
RECIPE.cost = { stone = 30 }
RECIPE.reqlvl = { construction = 1 }
RECIPE.ent = "gms_spawnpoint"
RECIPE.spawntime = 2
RECIPE.xp = 40
Menu_RegisterStructure( "other", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_c17/Frame002a.mdl"
RECIPE.title = "Sign"
RECIPE.description = "Up to 5 lines of text!"
RECIPE.cost = { oak_wood = 10, glass = 10 }
RECIPE.reqlvl = { construction = 5 }
RECIPE.ent = "gms_sign"
RECIPE.spawntime = 2
RECIPE.xp = 60
Menu_RegisterStructure( "other", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_interiors/SinkKitchen01a.mdl"
RECIPE.title = "Kitchen Sink"
RECIPE.description = "We remembered to bring it!"
RECIPE.cost = { metal = 12, bottled_water = 50 }
RECIPE.reqlvl = { construction = 8 }
RECIPE.ent = "gms_sink"
RECIPE.spawntime = 2
RECIPE.xp = 46
Menu_RegisterStructure( "other", RECIPE )

RECIPE = {}
RECIPE.model = "models/bed/bed.mdl"
RECIPE.title = "Bed"
RECIPE.description = "Only half the amount of fleas\nas the next leading brand!"
RECIPE.cost = { wood = 35 }
RECIPE.reqlvl = { construction = 14 }
RECIPE.ent = "gms_bed"
RECIPE.spawntime = 3
RECIPE.xp = 64
Menu_RegisterStructure( "other", RECIPE )

RECIPE = {}
RECIPE.model = "models/props/stranded/gardenblock.mdl"
RECIPE.title = "Gardening Block"
RECIPE.description = "Allows you to plant seeds on a movable dirt patch"
RECIPE.cost = { sand = 15, oak_wood = 15 }
RECIPE.reqlvl = { construction = 24 }
RECIPE.ent = "gms_gardenblock"
RECIPE.spawntime = 2
RECIPE.xp = 230
Menu_RegisterStructure( "other", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_junk/gnome.mdl"
RECIPE.title = "Gardening Gnome"
RECIPE.description = "This little guy will speed up all plant growth\nfor all plants near it."
RECIPE.cost = { iron = 12, oak_wood = 12 }
RECIPE.reqlvl = { construction = 16 }
RECIPE.ent = "gms_gardengnome"
RECIPE.spawntime = 3
RECIPE.xp = 80
Menu_RegisterStructure( "other", RECIPE )

/*
Doors Construction
*/

RECIPE = {}
RECIPE.model = "models/props_phx/construct/wood/wood_panel1x2.mdl"
RECIPE.title = "Wooden Door"
RECIPE.description = "Not a window!, Press [Use] to open!"
RECIPE.cost = { wood = 30 }
RECIPE.reqlvl = { construction = 3 }
RECIPE.ent = "gms_door1"
RECIPE.spawntime = 2
RECIPE.xp = 50
Menu_RegisterStructure( "door", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_phx/construct/wood/wood_panel2x2.mdl"
RECIPE.title = "Large Wooden Door"
RECIPE.description = "Not a window!, Press [Use] to open!"
RECIPE.cost = { wood = 45 }
RECIPE.reqlvl = { construction = 5 }
RECIPE.ent = "gms_door3"
RECIPE.spawntime = 2
RECIPE.xp = 75
Menu_RegisterStructure( "door", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_phx/construct/metal_plate1x2.mdl"
RECIPE.title = "Metal Door"
RECIPE.description = "Not a window!, Press [Use] to open!"
RECIPE.cost = { iron = 10, metal = 20 }
RECIPE.reqlvl = { construction = 8 }
RECIPE.ent = "gms_door2"
RECIPE.spawntime = 2
RECIPE.xp = 100
Menu_RegisterStructure( "door", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_phx/construct/metal_plate2x2.mdl"
RECIPE.title = "Large Metal Door"
RECIPE.description = "Not a window!, Press [Use] to open!"
RECIPE.cost = { iron = 15, metal = 26 }
RECIPE.reqlvl = { construction = 8 }
RECIPE.ent = "gms_door4"
RECIPE.spawntime = 2
RECIPE.xp = 130
Menu_RegisterStructure( "door", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_c17/fence01b.mdl"
RECIPE.title = "Fence Door"
RECIPE.description = "Not a window!, Press [Use] to open!"
RECIPE.cost = { iron = 30 }
RECIPE.reqlvl = { construction = 8 }
RECIPE.ent = "gms_door5"
RECIPE.spawntime = 2
RECIPE.xp = 80
Menu_RegisterStructure( "door", RECIPE )

RECIPE = {}
RECIPE.model = "models/props/g4pmodelpack/wood/door.mdl"
RECIPE.title = "Beta Props Door"
RECIPE.description = "Not a window!, Press [Use] to open!"
RECIPE.cost = { wood = 30 }
RECIPE.reqlvl = { construction = 3 }
RECIPE.ent = "gms_doorbeta"
RECIPE.spawntime = 2
RECIPE.xp = 50
Menu_RegisterStructure( "door", RECIPE )

/*
Lamps Construction
*/

RECIPE = {}
RECIPE.model = "models/campfire/campfire.mdl"
RECIPE.title = "Camp Fire"
RECIPE.description = "Nice and cozy!\nLasts 10 minutes."
RECIPE.cost = { wood = 8, stone = 6 }
RECIPE.reqlvl = { construction = 1 }
RECIPE.ent = "gms_campfire"
RECIPE.spawntime = 1
RECIPE.xp = 10
Menu_RegisterStructure( "lamp", RECIPE )

RECIPE = {}
RECIPE.model = "models/brazier/brazier.mdl"
RECIPE.title = "Fire Brazier"
RECIPE.description = "Nice and cozy!"
RECIPE.cost = { metal = 10, coal = 10 }
RECIPE.reqlvl = { construction = 12 }
RECIPE.ent = "gms_firebrazier"
RECIPE.spawntime = 1
RECIPE.xp = 200
Menu_RegisterStructure( "lamp", RECIPE )

RECIPE = {}
RECIPE.model = "models/sconce/sconce.mdl"
RECIPE.title = "Wall Lantern"
RECIPE.description = "Nice and cozy!"
RECIPE.cost = { metal = 5, coal = 5 }
RECIPE.reqlvl = { construction = 16 }
RECIPE.ent = "gms_walllantern"
RECIPE.spawntime = 1
RECIPE.xp = 220
Menu_RegisterStructure( "lamp", RECIPE )

RECIPE = {}
RECIPE.model = "models/lamp/lamp.mdl"
RECIPE.title = "Hanging Lamp"
RECIPE.description = "Nice and cozy!"
RECIPE.cost = { metal = 15, coal = 15 }
RECIPE.reqlvl = { construction = 24 }
RECIPE.ent = "gms_firelamp"
RECIPE.spawntime = 1
RECIPE.xp = 280
Menu_RegisterStructure( "lamp", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_c17/pottery03a.mdl"
RECIPE.title = "Sapphire Lamp"
RECIPE.description = "Creates Light, Toggle on and off!"
RECIPE.cost = { iron = 30, glass = 10, sapphire = 1 }
RECIPE.reqlvl = { construction = 6 }
RECIPE.ent = "gms_lamp"
RECIPE.spawntime = 2
RECIPE.xp = 150
Menu_RegisterStructure( "lamp", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_c17/pottery03a.mdl"
RECIPE.title = "Emerald Lamp"
RECIPE.description = "Creates Green Light, Toggle on and off!"
RECIPE.cost = { iron = 30, glass = 10, emerald = 1 }
RECIPE.reqlvl = { construction = 12 }
RECIPE.ent = "gms_lamp2"
RECIPE.spawntime = 2
RECIPE.xp = 250
Menu_RegisterStructure( "lamp", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_c17/pottery03a.mdl"
RECIPE.title = "Ruby Lamp"
RECIPE.description = "Creates Red Light, Toggle on and off!"
RECIPE.cost = { iron = 30, glass = 10, ruby = 1 }
RECIPE.reqlvl = { construction = 18 }
RECIPE.ent = "gms_lamp3"
RECIPE.spawntime = 2
RECIPE.xp = 350
Menu_RegisterStructure( "lamp", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_c17/pottery03a.mdl"
RECIPE.title = "Diamond Lamp"
RECIPE.description = "Creates White Light, Toggle on and off!"
RECIPE.cost = { iron = 30, glass = 10, diamond = 1 }
RECIPE.reqlvl = { construction = 24 }
RECIPE.ent = "gms_lamp4"
RECIPE.spawntime = 2
RECIPE.xp = 450
Menu_RegisterStructure( "lamp", RECIPE )


/*
Beacon Construction
*/

RECIPE = {}
RECIPE.model = "models/props_c17/pottery03a.mdl"
RECIPE.title = "Sapphire Beacon"
RECIPE.description = "Show the way, Toggle on and off!"
RECIPE.cost = { iron = 30, glass = 20, sapphire = 1 }
RECIPE.reqlvl = { construction = 10 }
RECIPE.ent = "gms_beacon"
RECIPE.spawntime = 2
RECIPE.xp = 200
Menu_RegisterStructure( "beacon", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_c17/pottery03a.mdl"
RECIPE.title = "Emerald Beacon"
RECIPE.description = "Show the way, Toggle on and off!"
RECIPE.cost = { steel = 20, glass = 20, emerald = 1 }
RECIPE.reqlvl = { construction = 15 }
RECIPE.ent = "gms_beacon2"
RECIPE.spawntime = 2
RECIPE.xp = 300
Menu_RegisterStructure( "beacon", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_c17/pottery03a.mdl"
RECIPE.title = "Ruby Beacon"
RECIPE.description = "Show the way, Toggle on and off!"
RECIPE.cost = { silver = 20, glass = 20, ruby = 1 }
RECIPE.reqlvl = { construction = 25 }
RECIPE.ent = "gms_beacon3"
RECIPE.spawntime = 2
RECIPE.xp = 400
Menu_RegisterStructure( "beacon", RECIPE )

/*
Pets Construction
*/

RECIPE = {}
RECIPE.model = "models/props_lab/miniteleport.mdl"
RECIPE.title = "Pet Egg Incubator"
RECIPE.description = "This is used to incubate and hatch pet eggs!"
RECIPE.cost = { stone = 20, wood = 20, sapphire = 1 }
RECIPE.reqlvl = { construction = 6 }
RECIPE.ent = "gms_incubator"
RECIPE.spawntime = 4
RECIPE.xp = 120
Menu_RegisterStructure( "pets", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_lab/kennel.mdl"
RECIPE.title = "Pet Kennel"
RECIPE.description = "Store one of every kind of pet.\nSaves them across sessions.\nTo store a pet, simply drop them on the kennel."
RECIPE.cost = { wood = 30, iron = 10 }
RECIPE.reqlvl = { construction = 9 }
RECIPE.ent = "gms_pethouse"
RECIPE.spawntime = 4
RECIPE.xp = 230
Menu_RegisterStructure( "pets", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_combine/combine_mine01.mdl"
RECIPE.title = "Antlion Boss Summoner"
RECIPE.description = "Place on the ground and get ready for a fight."
RECIPE.cost = { trinium = 20, bugbait = 1 }
RECIPE.reqlvl = { construction = 40 }
RECIPE.ent = "gms_bossspawner"
RECIPE.spawntime = 3
RECIPE.xp = 800
Menu_RegisterStructure( "pets", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_combine/combine_mine01.mdl"
RECIPE.title = "Hunter Boss Summoner"
RECIPE.description = "Place on the ground and get ready for a fight."
RECIPE.cost = { platinum = 20, metal_scraps = 2 }
RECIPE.reqlvl = { construction = 70 }
RECIPE.ent = "gms_bossspawner_hunter"
RECIPE.spawntime = 3
RECIPE.xp = 2000
Menu_RegisterStructure( "pets", RECIPE )

/*
Totems Construction
*/

RECIPE = {}
RECIPE.model = "models/props_rooftop/roof_vent003.mdl"
RECIPE.title = "Woodcutting Totem"
RECIPE.description = "Grants all players in a radius 25% bonus woodcutting experience!"
RECIPE.cost = { woodcutting_relic_3 = 2, enchanted_metal = 2, enchanted_wood = 1, gold = 50, mithril = 30 }
RECIPE.reqlvl = { construction = 60 }
RECIPE.ent = "gms_totem_woodcutting"
RECIPE.spawntime = 3
RECIPE.xp = 3000
Menu_RegisterStructure( "totem", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_rooftop/roof_vent003.mdl"
RECIPE.title = "Mining Totem"
RECIPE.description = "Grants all players in a radius 25% bonus mining experience!"
RECIPE.cost = { mining_relic_3 = 2, enchanted_metal = 2, enchanted_wood = 1, gold = 50, mithril = 30 }
RECIPE.reqlvl = { construction = 60 }
RECIPE.ent = "gms_totem_mining"
RECIPE.spawntime = 3
RECIPE.xp = 3000
Menu_RegisterStructure( "totem", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_rooftop/roof_vent003.mdl"
RECIPE.title = "Farming Totem"
RECIPE.description = "Grants all players in a radius 25% bonus farming experience!"
RECIPE.cost = { farming_relic_3 = 2, enchanted_metal = 2, enchanted_wood = 1, gold = 50, mithril = 30 }
RECIPE.reqlvl = { construction = 60 }
RECIPE.ent = "gms_totem_farming"
RECIPE.spawntime = 3
RECIPE.xp = 3000
Menu_RegisterStructure( "totem", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_rooftop/roof_vent003.mdl"
RECIPE.title = "Fishing Totem"
RECIPE.description = "Grants all players in a radius 25% bonus fishing experience!"
RECIPE.cost = { fishing_relic_3 = 2, enchanted_metal = 2, enchanted_wood = 1, gold = 50, mithril = 30 }
RECIPE.reqlvl = { construction = 60 }
RECIPE.ent = "gms_totem_fishing"
RECIPE.spawntime = 3
RECIPE.xp = 3000
Menu_RegisterStructure( "totem", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_rooftop/roof_vent003.mdl"
RECIPE.title = "Smithing Totem"
RECIPE.description = "Grants all players in a radius 25% bonus smithing experience!"
RECIPE.cost = { smithing_relic_3 = 2, enchanted_metal = 2, enchanted_wood = 1, gold = 50, mithril = 30 }
RECIPE.reqlvl = { construction = 60 }
RECIPE.ent = "gms_totem_smithing"
RECIPE.spawntime = 3
RECIPE.xp = 3000
Menu_RegisterStructure( "totem", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_rooftop/roof_vent003.mdl"
RECIPE.title = "Cooking Totem"
RECIPE.description = "Grants all players in a radius 25% bonus cooking experience!"
RECIPE.cost = { cooking_relic_3 = 2, enchanted_metal = 2, enchanted_wood = 1, gold = 50, mithril = 30 }
RECIPE.reqlvl = { construction = 60 }
RECIPE.ent = "gms_totem_cooking"
RECIPE.spawntime = 3
RECIPE.xp = 3000
Menu_RegisterStructure( "totem", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_rooftop/roof_vent003.mdl"
RECIPE.title = "Construction Totem"
RECIPE.description = "Grants all players in a radius 25% bonus construction experience!"
RECIPE.cost = { construction_relic_3 = 2, enchanted_metal = 2, enchanted_wood = 1, gold = 50, mithril = 30 }
RECIPE.reqlvl = { construction = 60 }
RECIPE.ent = "gms_totem_construction"
RECIPE.spawntime = 3
RECIPE.xp = 3000
Menu_RegisterStructure( "totem", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_rooftop/roof_vent003.mdl"
RECIPE.title = "Combat Totem"
RECIPE.description = "Grants all players in a radius 25% bonus combat experience!"
RECIPE.cost = { combat_relic_3 = 2, enchanted_metal = 2, enchanted_wood = 1, gold = 50, mithril = 30 }
RECIPE.reqlvl = { construction = 60 }
RECIPE.ent = "gms_totem_combat"
RECIPE.spawntime = 3
RECIPE.xp = 3000
Menu_RegisterStructure( "totem", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_rooftop/roof_vent003.mdl"
RECIPE.title = "Alchemy Totem"
RECIPE.description = "Grants all players in a radius 25% bonus alchemy experience!"
RECIPE.cost = { alchemy_relic_3 = 2, enchanted_metal = 2, enchanted_wood = 1, gold = 50, mithril = 30 }
RECIPE.reqlvl = { construction = 60 }
RECIPE.ent = "gms_totem_alchemy"
RECIPE.spawntime = 3
RECIPE.xp = 3000
Menu_RegisterStructure( "totem", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_rooftop/roof_vent003.mdl"
RECIPE.title = "Arcane Totem"
RECIPE.description = "Grants all players in a radius 25% bonus arcane experience!"
RECIPE.cost = { arcane_relic_3 = 2, enchanted_metal = 2, enchanted_wood = 1, gold = 50, mithril = 30 }
RECIPE.reqlvl = { construction = 60 }
RECIPE.ent = "gms_totem_arcane"
RECIPE.spawntime = 3
RECIPE.xp = 3000
Menu_RegisterStructure( "totem", RECIPE )



/*
Meteoric Construction
*/

RECIPE = {}
RECIPE.model = "models/props_combine/combine_mine01.mdl"
RECIPE.title = "Auto Miner"
RECIPE.description = "This device will do some basic mining for you!"
RECIPE.cost = { meteoric_iron = 5, platinum = 10, palm_wood = 10 }
RECIPE.reqlvl = { construction = 65 }
RECIPE.ent = "gms_miner"
RECIPE.spawntime = 3
RECIPE.xp = 12000
Menu_RegisterStructure( "meteoric", RECIPE )