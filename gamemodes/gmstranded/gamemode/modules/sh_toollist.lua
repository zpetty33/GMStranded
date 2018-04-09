SGS.Tools = {}
function Menu_RegisterTool( category, recipe )
	if not SGS.Tools[category] then SGS.Tools[category] = {} end
	SGS.Tools[category][#SGS.Tools[category] + 1] = recipe
end

------------
----main----
------------

RECIPE = {}
RECIPE.model = "models/weapons/w_Physics.mdl"
RECIPE.skin = 1
RECIPE.title = "Physics Gun"
RECIPE.description = "Used to manipulate objects!"
RECIPE.entity = "weapon_physgun"
RECIPE.color = Vector(0,1,1)
RECIPE.icon = "vgui/tools/physgun.png"
Menu_RegisterTool( "main", RECIPE )

RECIPE = {}
RECIPE.model = "models/Weapons/w_physics.mdl"
RECIPE.skin = 2
RECIPE.title = "Gravity Gun"
RECIPE.description = "Throw things!"
RECIPE.entity = "weapon_physcannon"
RECIPE.icon = "vgui/tools/gravitygun.png"
Menu_RegisterTool( "main", RECIPE )

RECIPE = {}
RECIPE.model = "models/MaxOfS2D/camera.mdl"
RECIPE.skin = 1
RECIPE.title = "Camera"
RECIPE.description = "How touristy!"
RECIPE.entity = "gmod_camera"
RECIPE.icon = "vgui/tools/camera.png"
Menu_RegisterTool( "main", RECIPE )

---------------------
-------combat-------
---------------------

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/woodenrod.mdl"
RECIPE.skin = 0
RECIPE.title = "Wooden Club"
RECIPE.description = "Use with caution!\nRequired Combat Level: 1"
RECIPE.cost = { wood = 15}
RECIPE.reqlvl = { smithing = 1}
RECIPE.xp = 12
RECIPE.entity = "weapon_melee1"
RECIPE.icon = "vgui/tools/wood_melee.png"
Menu_RegisterTool( "combat", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/ironrod.mdl"
RECIPE.skin = 0
RECIPE.title = "Iron Rod"
RECIPE.description = "Use with caution!\nRequired Combat Level: 10"
RECIPE.cost = { iron = 10, wood = 10}
RECIPE.reqlvl = { smithing = 10 }
RECIPE.xp = 25
RECIPE.entity = "weapon_melee2"
RECIPE.icon = "vgui/tools/iron_melee.png"
Menu_RegisterTool( "combat", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/smallmace.mdl"
RECIPE.skin = 0
RECIPE.title = "Steel Rod"
RECIPE.description = "Use with caution!\nRequired Combat Level: 20"
RECIPE.cost = { steel = 10, oak_wood = 10}
RECIPE.reqlvl = { smithing = 25 }
RECIPE.xp = 40
RECIPE.entity = "weapon_melee3"
RECIPE.icon = "vgui/tools/steel_melee.png"
Menu_RegisterTool( "combat", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/smallmace.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Rod"
RECIPE.description = "Use with caution!\nRequired Combat Level: 30"
RECIPE.cost = { silver = 10, oak_wood = 15}
RECIPE.reqlvl = { smithing = 35 }
RECIPE.xp = 60
RECIPE.entity = "weapon_melee4"
RECIPE.icon = "vgui/tools/silver_melee.png"
Menu_RegisterTool( "combat", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/largemace.mdl"
RECIPE.skin = 0
RECIPE.title = "Trinium Rod"
RECIPE.description = "Use with caution!\nRequired Combat Level: 40"
RECIPE.cost = { trinium = 10, maple_wood = 10}
RECIPE.reqlvl = { smithing = 45 }
RECIPE.xp = 90
RECIPE.entity = "weapon_melee5"
RECIPE.icon = "vgui/tools/trinium_melee.png"
RECIPE.color = Vector(.16, .61, .02)
Menu_RegisterTool( "combat", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/largemace.mdl"
RECIPE.skin = 0
RECIPE.title = "Naquadah Rod"
RECIPE.description = "Use with caution!\nRequired Combat Level: 50"
RECIPE.cost = { naquadah = 10, yew_wood = 10}
RECIPE.reqlvl = { smithing = 58 }
RECIPE.xp = 180
RECIPE.entity = "weapon_melee6"
RECIPE.icon = "vgui/tools/naquadah_melee.png"
RECIPE.color = Vector(1, .12, 0)
Menu_RegisterTool( "combat", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/highendmace.mdl"
RECIPE.skin = 0
RECIPE.title = "Mithril Rod"
RECIPE.description = "Use with caution!\nRequired Combat Level: 60"
RECIPE.cost = { mithril = 10, buckeye_wood = 10}
RECIPE.reqlvl = { smithing = 65 }
RECIPE.xp = 250
RECIPE.entity = "weapon_melee7"
RECIPE.icon = "vgui/tools/mithril_melee.png"
Menu_RegisterTool( "combat", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/highendmace.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Rod"
RECIPE.description = "Use with caution!\nRequired Combat Level: 70"
RECIPE.cost = { platinum = 10, palm_wood = 10}
RECIPE.reqlvl = { smithing = 71 }
RECIPE.xp = 400
RECIPE.entity = "weapon_melee8"
RECIPE.icon = "vgui/tools/platinum_melee.png"
Menu_RegisterTool( "combat", RECIPE )

------------------
---construction---
------------------

RECIPE = {}
RECIPE.model = "models/weapons/w_toolgun.mdl"
RECIPE.skin = 1
RECIPE.title = "Remover Tool"
RECIPE.description = "Primary: Remove props and items you own!"
RECIPE.entity = "gms_remover"
RECIPE.icon = "vgui/tools/remover.png"
Menu_RegisterTool( "construction", RECIPE )

RECIPE = {}
RECIPE.model = "models/weapons/w_toolgun.mdl"
RECIPE.skin = 1
RECIPE.title = "Prop Share Tool"
RECIPE.description = "Primary: Disowns an item allowing someone else to own it!\nSecondary: Take control of an ownerless item!\nReload: Allow anyone to use the structure without sharing ownership."
RECIPE.entity = "gms_sppshare"
RECIPE.icon = "vgui/tools/propshare.png"
Menu_RegisterTool( "construction", RECIPE )

RECIPE = {}
RECIPE.model = "models/weapons/w_toolgun.mdl"
RECIPE.skin = 1
RECIPE.title = "Structure Packager"
RECIPE.description = "Primary: Packs a structure you own for later use or trade!"
RECIPE.entity = "gms_packager"
RECIPE.icon = "vgui/tools/packager.png"
Menu_RegisterTool( "construction", RECIPE )

RECIPE = {}
RECIPE.model = "models/weapons/w_toolgun.mdl"
RECIPE.skin = 1
RECIPE.title = "Prop Locker"
RECIPE.description = "Primary: Select up to 10 items.\nSecondary: Locks all selected props, making them unmovable\nReload: Unlocks all selected props"
RECIPE.entity = "gms_proplocker"
RECIPE.icon = "vgui/tools/welder.png"
Menu_RegisterTool( "construction", RECIPE )


---------------------
-----woodcutting-----
---------------------

RECIPE = {}
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Hatchet"
RECIPE.description = "Makes cutting down trees easy!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { stone = 5, wood = 6}
RECIPE.reqlvl = { smithing = 1}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 12
RECIPE.entity = "gms_hatchet1"
RECIPE.color = Vector(.6, .6, .6)
RECIPE.icon = "vgui/tools/stone_hatchet.png"
Menu_RegisterTool( "woodcutting", RECIPE )

RECIPE = {}
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Hatchet"
RECIPE.description = "Makes cutting down trees easy!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { iron = 5, wood = 8}
RECIPE.reqlvl = { smithing = 10}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 25
RECIPE.entity = "gms_hatchet2"
RECIPE.color = Vector(.45, .3, .3)
RECIPE.icon = "vgui/tools/iron_hatchet.png"
Menu_RegisterTool( "woodcutting", RECIPE )

RECIPE = {}
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Hatchet"
RECIPE.description = "Makes cutting down trees easy!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 15"
RECIPE.cost = { steel = 5, oak_wood = 10}
RECIPE.reqlvl = { smithing = 25}
RECIPE.uselevel = { woodcutting = 15}
RECIPE.xp = 40
RECIPE.entity = "gms_hatchet3"
RECIPE.color = Vector(.6, .6, .8)
RECIPE.icon = "vgui/tools/steel_hatchet.png"
Menu_RegisterTool( "woodcutting", RECIPE )

RECIPE = {}
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Hatchet"
RECIPE.description = "Makes cutting down trees easy!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 25"
RECIPE.cost = { silver = 5, maple_wood = 12}
RECIPE.reqlvl = { smithing = 40}
RECIPE.uselevel = { woodcutting = 25}
RECIPE.xp = 60
RECIPE.entity = "gms_hatchet4"
RECIPE.color = Vector(1, 1, 1)
RECIPE.icon = "vgui/tools/silver_hatchet.png"
Menu_RegisterTool( "woodcutting", RECIPE )

RECIPE = {}
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Hatchet"
RECIPE.description = "Makes cutting down trees easy!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 35"
RECIPE.cost = { trinium = 5, pine_wood = 14}
RECIPE.reqlvl = { smithing = 50}
RECIPE.uselevel = { woodcutting = 35}
RECIPE.xp = 90
RECIPE.entity = "gms_hatchet5"
RECIPE.color = Vector(.1, .3, .1)
RECIPE.icon = "vgui/tools/trinium_hatchet.png"
Menu_RegisterTool( "woodcutting", RECIPE )

RECIPE = {}
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Hatchet"
RECIPE.description = "Makes cutting down trees easy!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 45"
RECIPE.cost = { naquadah = 5, yew_wood = 12}
RECIPE.reqlvl = { smithing = 53}
RECIPE.uselevel = { woodcutting = 45}
RECIPE.xp = 115
RECIPE.entity = "gms_hatchet6"
RECIPE.color = Vector(.3, .1, .1)
RECIPE.icon = "vgui/tools/naquadah_hatchet.png"
Menu_RegisterTool( "woodcutting", RECIPE )

RECIPE = {}
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Hatchet"
RECIPE.description = "Makes cutting down trees easy!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 55"
RECIPE.cost = { mithril = 5, buckeye_wood = 12}
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { woodcutting = 55}
RECIPE.xp = 230
RECIPE.entity = "gms_hatchet7"
RECIPE.color = Vector(.1, .1, .4)
RECIPE.icon = "vgui/tools/mithril_hatchet.png"
Menu_RegisterTool( "woodcutting", RECIPE )

RECIPE = {}
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Hatchet"
RECIPE.description = "Makes cutting down trees easy!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 65"
RECIPE.cost = { platinum = 5, palm_wood = 12}
RECIPE.reqlvl = { smithing = 71}
RECIPE.uselevel = { woodcutting = 65}
RECIPE.xp = 320
RECIPE.entity = "gms_hatchet8"
RECIPE.color = Vector(.8, .8, .8)
RECIPE.icon = "vgui/tools/platinum_hatchet.png"
Menu_RegisterTool( "woodcutting", RECIPE )



------------------
------mining------
------------------

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Pickaxe"
RECIPE.description = "Makes mining ore easy!\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { stone = 6, wood = 6}
RECIPE.reqlvl = { smithing = 1}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 12
RECIPE.entity = "gms_pickaxe1"
RECIPE.color = Vector(.6, .6, .6)
RECIPE.icon = "vgui/tools/stone_pickaxe.png"
Menu_RegisterTool( "mining", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Pickaxe"
RECIPE.description = "Makes mining ore easy!\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { iron = 6, oak_wood = 8}
RECIPE.reqlvl = { smithing = 15}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 32
RECIPE.entity = "gms_pickaxe2"
RECIPE.color = Vector(.45, .3, .3)
RECIPE.icon = "vgui/tools/iron_pickaxe.png"
Menu_RegisterTool( "mining", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Pickaxe"
RECIPE.description = "Makes mining ore easy!\nPrimary: Mine Ore\nRequired Mining Lvl: 15"
RECIPE.cost = { steel = 6, maple_wood = 10}
RECIPE.reqlvl = { smithing = 30}
RECIPE.uselevel = { mining = 15}
RECIPE.xp = 46
RECIPE.entity = "gms_pickaxe3"
RECIPE.color = Vector(.6, .6, .8)
RECIPE.icon = "vgui/tools/steel_pickaxe.png"
Menu_RegisterTool( "mining", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Pickaxe"
RECIPE.description = "Makes mining ore easy!\nPrimary: Mine Ore\nRequired Mining Lvl: 25"
RECIPE.cost = { silver = 6, pine_wood = 12}
RECIPE.reqlvl = { smithing = 45}
RECIPE.uselevel = { mining = 25}
RECIPE.xp = 75
RECIPE.entity = "gms_pickaxe4"
RECIPE.color = Vector(1, 1, 1)
RECIPE.icon = "vgui/tools/silver_pickaxe.png"
Menu_RegisterTool( "mining", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Pickaxe"
RECIPE.description = "Makes mining ore easy!\nPrimary: Mine Ore\nRequired Mining Lvl: 35"
RECIPE.cost = { trinium = 6, pine_wood = 14}
RECIPE.reqlvl = { smithing = 50}
RECIPE.uselevel = { mining = 35}
RECIPE.xp = 90
RECIPE.entity = "gms_pickaxe5"
RECIPE.color = Vector(.1, .3, .1)
RECIPE.icon = "vgui/tools/trinium_pickaxe.png"
Menu_RegisterTool( "mining", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Pickaxe"
RECIPE.description = "Makes mining ore easy!\nPrimary: Mine Ore\nRequired Mining Lvl: 45"
RECIPE.cost = { naquadah = 6, yew_wood = 10}
RECIPE.reqlvl = { smithing = 55}
RECIPE.uselevel = { mining = 45}
RECIPE.xp = 150
RECIPE.entity = "gms_pickaxe6"
RECIPE.color = Vector(.3, .1, .1)
RECIPE.icon = "vgui/tools/naquadah_pickaxe.png"
Menu_RegisterTool( "mining", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Pickaxe"
RECIPE.description = "Makes mining ore easy!\nPrimary: Mine Ore\nRequired Mining Lvl: 55"
RECIPE.cost = { mithril = 6, buckeye_wood = 10}
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { mining = 55}
RECIPE.xp = 230
RECIPE.entity = "gms_pickaxe7"
RECIPE.color = Vector(.1, .1, .4)
RECIPE.icon = "vgui/tools/mithril_pickaxe.png"
Menu_RegisterTool( "mining", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Pickaxe"
RECIPE.description = "Makes mining ore easy!\nPrimary: Mine Ore\nRequired Mining Lvl: 65"
RECIPE.cost = { platinum = 6, palm_wood = 10}
RECIPE.reqlvl = { smithing = 71}
RECIPE.uselevel = { mining = 65}
RECIPE.xp = 320
RECIPE.entity = "gms_pickaxe8"
RECIPE.color = Vector(.8, .8, .8)
RECIPE.icon = "vgui/tools/platinum_pickaxe.png"
Menu_RegisterTool( "mining", RECIPE )




-----------------
-----fishing-----
-----------------

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Wooden Fishing Rod"
RECIPE.description = "Makes fishing easy!\nPrimary: Fish\nRequired Fishing Lvl: 1"
RECIPE.cost = { wood = 12}
RECIPE.reqlvl = { smithing = 1}
RECIPE.xp = 12
RECIPE.entity = "gms_fishingrod1"
RECIPE.icon = "vgui/tools/wood_rod.png"
RECIPE.color = Vector(.4, .2, .0)
Menu_RegisterTool( "fishing", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Fishing Rod"
RECIPE.description = "Makes fishing easy!\nPrimary: Fish\nRequired Fishing Lvl: 1"
RECIPE.cost = { iron = 4, wood = 8}
RECIPE.reqlvl = { smithing = 10}
RECIPE.xp = 32
RECIPE.entity = "gms_fishingrod2"
RECIPE.icon = "vgui/tools/iron_rod.png"
RECIPE.color = Vector(.45, .3, .3)
Menu_RegisterTool( "fishing", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Fishing Rod"
RECIPE.description = "Makes fishing easy!\nPrimary: Fish\nRequired Fishing Lvl: 15"
RECIPE.cost = { steel = 4, oak_wood = 10}
RECIPE.reqlvl = { smithing = 25}
RECIPE.xp = 46
RECIPE.entity = "gms_fishingrod3"
RECIPE.icon = "vgui/tools/steel_rod.png"
RECIPE.color = Vector(.6, .6, .8)
Menu_RegisterTool( "fishing", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Fishing Rod"
RECIPE.description = "Makes fishing easy!\nPrimary: Fish\nRequired Fishing Lvl: 25"
RECIPE.cost = { silver = 4, maple_wood = 12}
RECIPE.reqlvl = { smithing = 41}
RECIPE.xp = 75
RECIPE.entity = "gms_fishingrod4"
RECIPE.icon = "vgui/tools/silver_rod.png"
RECIPE.color = Vector(1, 1, 1)
Menu_RegisterTool( "fishing", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Fishing Rod"
RECIPE.description = "Makes fishing easy!\nPrimary: Fish\nRequired Fishing Lvl: 35"
RECIPE.cost = { trinium = 4, pine_wood = 14}
RECIPE.reqlvl = { smithing = 50}
RECIPE.xp = 90
RECIPE.entity = "gms_fishingrod5"
RECIPE.icon = "vgui/tools/trinium_rod.png"
RECIPE.color = Vector(.1, .3, .1)
Menu_RegisterTool( "fishing", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Fishing Rod"
RECIPE.description = "Makes fishing easy!\nPrimary: Fish\nRequired Fishing Lvl: 45"
RECIPE.cost = { naquadah = 4, yew_wood = 10}
RECIPE.reqlvl = { smithing = 58}
RECIPE.xp = 180
RECIPE.entity = "gms_fishingrod6"
RECIPE.icon = "vgui/tools/naquadah_rod.png"
RECIPE.color = Vector(.3, .1, .1)
Menu_RegisterTool( "fishing", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Fishing Rod"
RECIPE.description = "Makes fishing easy!\nPrimary: Fish\nRequired Fishing Lvl: 55"
RECIPE.cost = { mithril = 4, buckeye_wood = 10}
RECIPE.reqlvl = { smithing = 65}
RECIPE.xp = 230
RECIPE.entity = "gms_fishingrod7"
RECIPE.icon = "vgui/tools/mithril_rod.png"
RECIPE.color = Vector(.1, .1, .4)
Menu_RegisterTool( "fishing", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Fishing Rod"
RECIPE.description = "Makes fishing easy!\nPrimary: Fish\nRequired Fishing Lvl: 65"
RECIPE.cost = { platinum = 4, palm_wood = 10}
RECIPE.reqlvl = { smithing = 71}
RECIPE.xp = 320
RECIPE.entity = "gms_fishingrod8"
RECIPE.icon = "vgui/tools/platinum_rod.png"
RECIPE.color = Vector(.8, .8, .8)
Menu_RegisterTool( "fishing", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Advanced Fishing Rod"
RECIPE.description = "For the more advanced fishers!\nPrimary: Fish\nRequired Fishing Lvl: 50"
RECIPE.cost = { naquadah = 6, pine_wood = 10}
RECIPE.reqlvl = { smithing = 54}
RECIPE.xp = 140
RECIPE.entity = "gms_afishingrod"
RECIPE.icon = "vgui/tools/adv_rod.png"
RECIPE.color = Vector(.1, .1, .8)
Menu_RegisterTool( "fishing", RECIPE )



-------------------
------farming------
-------------------

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hoe.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Hoe"
RECIPE.description = "Makes farming easy!\nPrimary: Forage\nRequired Farming Lvl: 1"
RECIPE.cost = { stone = 5, wood = 6}
RECIPE.reqlvl = { smithing = 1}
RECIPE.xp = 12
RECIPE.entity = "gms_hoe1"
RECIPE.icon = "vgui/tools/stone_hoe.png"
RECIPE.color = Vector(.6, .6, .6)
Menu_RegisterTool( "farming", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hoe.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Hoe"
RECIPE.description = "Makes farming easy!\nPrimary: Forage\nRequired Farming Lvl: 1"
RECIPE.cost = { iron = 5, oak_wood = 8}
RECIPE.reqlvl = { smithing = 15}
RECIPE.xp = 32
RECIPE.entity = "gms_hoe2"
RECIPE.icon = "vgui/tools/iron_hoe.png"
RECIPE.color = Vector(.45, .3, .3)
Menu_RegisterTool( "farming", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hoe.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Hoe"
RECIPE.description = "Makes farming easy!\nPrimary: Forage\nRequired Farming Lvl: 15"
RECIPE.cost = { steel = 5, oak_wood = 10}
RECIPE.reqlvl = { smithing = 28}
RECIPE.xp = 55
RECIPE.entity = "gms_hoe3"
RECIPE.icon = "vgui/tools/steel_hoe.png"
RECIPE.color = Vector(.6, .6, .8)
Menu_RegisterTool( "farming", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hoe.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Hoe"
RECIPE.description = "Makes farming easy!\nPrimary: Forage\nRequired Farming Lvl: 25"
RECIPE.cost = { silver = 5, maple_wood = 12}
RECIPE.reqlvl = { smithing = 38}
RECIPE.xp = 60
RECIPE.entity = "gms_hoe4"
RECIPE.icon = "vgui/tools/silver_hoe.png"
RECIPE.color = Vector(1, 1, 1)
Menu_RegisterTool( "farming", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hoe.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Hoe"
RECIPE.description = "Makes farming easy!\nPrimary: Forage\nRequired Farming Lvl: 35"
RECIPE.cost = { trinium = 5, pine_wood = 14}
RECIPE.reqlvl = { smithing = 50}
RECIPE.xp = 90
RECIPE.entity = "gms_hoe5"
RECIPE.icon = "vgui/tools/trinium_hoe.png"
RECIPE.color = Vector(.1, .3, .1)
Menu_RegisterTool( "farming", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hoe.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Hoe"
RECIPE.description = "Makes farming easy!\nPrimary: Forage\nRequired Farming Lvl: 45"
RECIPE.cost = { naquadah = 5, yew_wood = 10}
RECIPE.reqlvl = { smithing = 56}
RECIPE.xp = 150
RECIPE.entity = "gms_hoe6"
RECIPE.icon = "vgui/tools/naquadah_hoe.png"
RECIPE.color = Vector(.3, .1, .1)
Menu_RegisterTool( "farming", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hoe.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Hoe"
RECIPE.description = "Makes farming easy!\nPrimary: Forage\nRequired Farming Lvl: 55"
RECIPE.cost = { mithril = 5, buckeye_wood = 10}
RECIPE.reqlvl = { smithing = 65}
RECIPE.xp = 230
RECIPE.entity = "gms_hoe7"
RECIPE.icon = "vgui/tools/mithril_hoe.png"
RECIPE.color = Vector(.1, .1, .4)
Menu_RegisterTool( "farming", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hoe.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Hoe"
RECIPE.description = "Makes farming easy!\nPrimary: Forage\nRequired Farming Lvl: 65"
RECIPE.cost = { platinum = 5, palm_wood = 10}
RECIPE.reqlvl = { smithing = 71}
RECIPE.xp = 320
RECIPE.entity = "gms_hoe8"
RECIPE.icon = "vgui/tools/platinum_hoe.png"
RECIPE.color = Vector(.8, .8, .8)
Menu_RegisterTool( "farming", RECIPE )


---------------------
-------sifting-------
---------------------

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/sifter.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Sifter"
RECIPE.description = "Sift the ground to collect sand!\nPrimary: Sift"
RECIPE.cost = { iron = 5, stone = 10}
RECIPE.reqlvl = { smithing = 5}
RECIPE.xp = 25
RECIPE.entity = "gms_sifter"
RECIPE.icon = "vgui/tools/iron_sifter.png"
RECIPE.color = Vector(.45, .3, .3)
Menu_RegisterTool( "sifting", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/sifter.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Sifter"
RECIPE.description = "Sift the ground to collect sand!\nPrimary: Sift"
RECIPE.cost = { steel = 5, stone = 20}
RECIPE.reqlvl = { smithing = 30}
RECIPE.xp = 65
RECIPE.entity = "gms_sifter2"
RECIPE.icon = "vgui/tools/steel_sifter.png"
RECIPE.color = Vector(.6, .6, .8)
Menu_RegisterTool( "sifting", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/sifter.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Sifter"
RECIPE.description = "Sift the ground to collect sand!\nPrimary: Sift"
RECIPE.cost = { trinium = 5, stone = 30}
RECIPE.reqlvl = { smithing = 53}
RECIPE.xp = 140
RECIPE.entity = "gms_sifter3"
RECIPE.icon = "vgui/tools/trinium_sifter.png"
RECIPE.color = Vector(.1, .3, .1)
Menu_RegisterTool( "sifting", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/sifter.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Sifter"
RECIPE.description = "Sift the ground to collect sand!\nPrimary: Sift"
RECIPE.cost = { mithril = 5, stone = 30}
RECIPE.reqlvl = { smithing = 65}
RECIPE.xp = 230
RECIPE.entity = "gms_sifter4"
RECIPE.icon = "vgui/tools/mithril_sifter.png"
RECIPE.color = Vector(.1, .1, .4)
Menu_RegisterTool( "sifting", RECIPE )

--------------------
--------misc--------
--------------------

RECIPE = {}
RECIPE.model = "models/props_foliage/rock_forest01.mdl"
RECIPE.skin = 1
RECIPE.title = "Grinding Stone"
RECIPE.description = "Used to grind ores into dust!\nPrimary: Open Grinding Menu"
RECIPE.cost = { stone = 20 }
RECIPE.reqlvl = { smithing = 5}
RECIPE.xp = 80
RECIPE.entity = "gms_grindingstone"
RECIPE.icon = "vgui/tools/grindingstone.png"
RECIPE.scale = 0.216
Menu_RegisterTool( "misc", RECIPE )

RECIPE = {}
RECIPE.model = "models/Weapons/w_crowbar.mdl"
RECIPE.skin = 1
RECIPE.title = "Alchemist's Stone"
RECIPE.description = "Used for transmutations!\nPrimary: Open Transmutation Menu"
RECIPE.cost = { emerald = 1, sapphire = 1, burned_fish = 10}
RECIPE.reqlvl = { smithing = 5}
RECIPE.xp = 100
RECIPE.entity = "gms_alchemystone"
RECIPE.icon = "vgui/tools/alchstone.png"
Menu_RegisterTool( "misc", RECIPE )

RECIPE = {}
RECIPE.model = "models/props_c17/metalPot002a.mdl"
RECIPE.skin = 1
RECIPE.title = "Frying Pan"
RECIPE.description = "Equip while cooking for better results!"
RECIPE.cost = { iron = 10, oak_wood = 10}
RECIPE.reqlvl = { smithing = 12}
RECIPE.xp = 140
RECIPE.entity = "gms_fryingpan"
RECIPE.icon = "vgui/tools/fryingpan.png"
Menu_RegisterTool( "misc", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/torch.mdl"
RECIPE.skin = 1
RECIPE.title = "Handheld Torch"
RECIPE.description = "Light!\nRight click to place torch."
RECIPE.cost = { wood = 20 }
RECIPE.reqlvl = { smithing = 1}
RECIPE.xp = 20
RECIPE.entity = "gms_handtorch"
RECIPE.icon = "vgui/tools/torch.png"
Menu_RegisterTool( "misc", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hammer.mdl"
RECIPE.skin = 1
RECIPE.title = "Construction Hammer"
RECIPE.description = "Equip while building for better results!\nLeft Click: Deconstructs a prop, returning a portion of the materials used to make it.\nRight Click: Repairs the damage to a prop or structure."
RECIPE.cost = { iron = 12, oak_wood = 8}
RECIPE.reqlvl = { smithing = 8}
RECIPE.xp = 120
RECIPE.entity = "gms_hammer"
RECIPE.icon = "vgui/tools/hammer.png"
Menu_RegisterTool( "misc", RECIPE )


-------------------------
--------extractor--------
-------------------------

RECIPE = {}
RECIPE.model = "models/Weapons/w_crowbar.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Seed Extractor"
RECIPE.description = "Remove the seeds from a fruit\nThis process destroys the fruit!"
RECIPE.cost = { iron = 8, oak_wood = 6}
RECIPE.reqlvl = { smithing = 16}
RECIPE.xp = 30
RECIPE.entity = "gms_seedextractor"
RECIPE.icon = "vgui/tools/iron_seedextractor.png"
Menu_RegisterTool( "extractor", RECIPE )

RECIPE = {}
RECIPE.model = "models/Weapons/w_crowbar.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Seed Extractor"
RECIPE.description = "Remove the seeds from a fruit\nThis process destroys the fruit!"
RECIPE.cost = { silver = 8, maple_wood = 6}
RECIPE.reqlvl = { smithing = 41}
RECIPE.xp = 90
RECIPE.entity = "gms_seedextractor2"
RECIPE.icon = "vgui/tools/silver_seedextractor.png"
Menu_RegisterTool( "extractor", RECIPE )

RECIPE = {}
RECIPE.model = "models/Weapons/w_crowbar.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Seed Extractor"
RECIPE.description = "Remove the seeds from a fruit\nThis process destroys the fruit!"
RECIPE.cost = { trinium = 8, pine_wood = 6}
RECIPE.reqlvl = { smithing = 52}
RECIPE.xp = 160
RECIPE.entity = "gms_seedextractor3"
RECIPE.icon = "vgui/tools/trinium_seedextractor.png"
Menu_RegisterTool( "extractor", RECIPE )

RECIPE = {}
RECIPE.model = "models/Weapons/w_crowbar.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Seed Extractor"
RECIPE.description = "Remove the seeds from a fruit\nThis process destroys the fruit!"
RECIPE.cost = { mithril = 8, buckeye_wood = 6}
RECIPE.reqlvl = { smithing = 65}
RECIPE.xp = 230
RECIPE.entity = "gms_seedextractor4"
RECIPE.icon = "vgui/tools/mithril_seedextractor.png"
Menu_RegisterTool( "extractor", RECIPE )

-------------------
-----enchanted-----
-------------------

RECIPE = {}
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Hatchet"
RECIPE.description = "Very powerful tree cutting tool!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { enchanted_wood = 12, enchanted_axehead = 1}
RECIPE.reqlvl = { smithing = 50}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 350
RECIPE.entity = "gms_ehatchet"
RECIPE.color = Vector(.6, .1, .6)
RECIPE.icon = "vgui/tools/enchanted_hatchet.png"
Menu_RegisterTool( "enchanted", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Pickaxe"
RECIPE.description = "Very powerful mining tool!\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { enchanted_wood = 12, enchanted_pickhead = 1}
RECIPE.reqlvl = { smithing = 50}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 350
RECIPE.entity = "gms_epickaxe"
RECIPE.color = Vector(.6, .1, .6)
RECIPE.icon = "vgui/tools/enchanted_pickaxe.png"
Menu_RegisterTool( "enchanted", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Fishing Rod"
RECIPE.description = "Very powerful fishing rod!\nPrimary: Cast Line\nRequired Fishing Lvl: 1"
RECIPE.cost = { enchanted_wood = 12, enchanted_reel = 1}
RECIPE.reqlvl = { smithing = 50}
RECIPE.uselevel = { fishing = 1}
RECIPE.xp = 350
RECIPE.entity = "gms_efishingrod"
RECIPE.icon = "vgui/tools/enchanted_rod.png"
RECIPE.color = Vector(.6, .1, .6)
Menu_RegisterTool( "enchanted", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hoe.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Hoe"
RECIPE.description = "Very powerful farming tool!\nPrimary: Forage/Harvest\nRequired Farming Lvl: 1"
RECIPE.cost = { enchanted_wood = 12, enchanted_hoe_blade = 1}
RECIPE.reqlvl = { smithing = 50}
RECIPE.uselevel = { farming = 1}
RECIPE.xp = 350
RECIPE.entity = "gms_ehoe"
RECIPE.icon = "vgui/tools/enchanted_hoe.png"
RECIPE.color = Vector(.6, .1, .6)
Menu_RegisterTool( "enchanted", RECIPE )


--------------------------------
------woodcutting-sapphire------
--------------------------------

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Hatchet (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { sapphire = 1 }
RECIPE.reqlvl = { smithing = 40}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 110
RECIPE.entity = "gms_hatchet1s"
RECIPE.entity2 = "gms_hatchet1"
RECIPE.color = Vector(.6, .6, .6)
RECIPE.icon = "vgui/tools/stone_hatchet_s.png"
Menu_RegisterTool( "woodcutting-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Hatchet (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { sapphire = 2 }
RECIPE.reqlvl = { smithing = 44}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 140
RECIPE.entity = "gms_hatchet2s"
RECIPE.entity2 = "gms_hatchet2"
RECIPE.color = Vector(.45, .3, .3)
RECIPE.icon = "vgui/tools/iron_hatchet_s.png"
Menu_RegisterTool( "woodcutting-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Hatchet (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 15"
RECIPE.cost = { sapphire = 3 }
RECIPE.reqlvl = { smithing = 48}
RECIPE.uselevel = { woodcutting = 15}
RECIPE.xp = 190
RECIPE.entity = "gms_hatchet3s"
RECIPE.entity2 = "gms_hatchet3"
RECIPE.color = Vector(.6, .6, .8)
RECIPE.icon = "vgui/tools/steel_hatchet_s.png"
Menu_RegisterTool( "woodcutting-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Hatchet (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 25"
RECIPE.cost = { sapphire = 4 }
RECIPE.reqlvl = { smithing = 52}
RECIPE.uselevel = { woodcutting = 25}
RECIPE.xp = 220
RECIPE.entity = "gms_hatchet4s"
RECIPE.entity2 = "gms_hatchet4"
RECIPE.color = Vector(1, 1, 1)
RECIPE.icon = "vgui/tools/silver_hatchet_s.png"
Menu_RegisterTool( "woodcutting-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Hatchet (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 35"
RECIPE.cost = { sapphire = 5 }
RECIPE.reqlvl = { smithing = 56}
RECIPE.uselevel = { woodcutting = 35}
RECIPE.xp = 260
RECIPE.entity = "gms_hatchet5s"
RECIPE.entity2 = "gms_hatchet5"
RECIPE.color = Vector(.1, .3, .1)
RECIPE.icon = "vgui/tools/trinium_hatchet_s.png"
Menu_RegisterTool( "woodcutting-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Hatchet (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 45"
RECIPE.cost = { sapphire = 6 }
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { woodcutting = 45}
RECIPE.xp = 300
RECIPE.entity = "gms_hatchet6s"
RECIPE.entity2 = "gms_hatchet6"
RECIPE.color = Vector(.3, .1, .1)
RECIPE.icon = "vgui/tools/naquadah_hatchet_s.png"
Menu_RegisterTool( "woodcutting-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Hatchet (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 55"
RECIPE.cost = { sapphire = 8 }
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { woodcutting = 55}
RECIPE.xp = 450
RECIPE.entity = "gms_hatchet7s"
RECIPE.entity2 = "gms_hatchet7"
RECIPE.color = Vector(.1, .1, .4)
RECIPE.icon = "vgui/tools/mithril_hatchet_s.png"
Menu_RegisterTool( "woodcutting-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Hatchet (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 65"
RECIPE.cost = { sapphire = 8 }
RECIPE.reqlvl = { smithing = 71}
RECIPE.uselevel = { woodcutting = 65}
RECIPE.xp = 550
RECIPE.entity = "gms_hatchet8s"
RECIPE.entity2 = "gms_hatchet8"
RECIPE.color = Vector(.8, .8, .8)
RECIPE.icon = "vgui/tools/platinum_hatchet_s.png"
Menu_RegisterTool( "woodcutting-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Hatchet (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { sapphire = 24 }
RECIPE.reqlvl = { smithing = 70}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 600
RECIPE.entity = "gms_ehatchets"
RECIPE.entity2 = "gms_ehatchet"
RECIPE.color = Vector(.6, .1, .6)
RECIPE.icon = "vgui/tools/enchanted_hatchet_s.png"
Menu_RegisterTool( "woodcutting-sapphire", RECIPE )


-------------------------------
------woodcutting-emerald------
-------------------------------

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Hatchet (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { emerald = 1 }
RECIPE.reqlvl = { smithing = 40}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 110
RECIPE.entity = "gms_hatchet1e"
RECIPE.entity2 = "gms_hatchet1"
RECIPE.color = Vector(.6, .6, .6)
RECIPE.icon = "vgui/tools/stone_hatchet_e.png"
Menu_RegisterTool( "woodcutting-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Hatchet (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { emerald = 2 }
RECIPE.reqlvl = { smithing = 44}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 140
RECIPE.entity = "gms_hatchet2e"
RECIPE.entity2 = "gms_hatchet2"
RECIPE.color = Vector(.45, .3, .3)
RECIPE.icon = "vgui/tools/iron_hatchet_e.png"
Menu_RegisterTool( "woodcutting-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Hatchet (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 15"
RECIPE.cost = { emerald = 3 }
RECIPE.reqlvl = { smithing = 48}
RECIPE.uselevel = { woodcutting = 15}
RECIPE.xp = 190
RECIPE.entity = "gms_hatchet3e"
RECIPE.entity2 = "gms_hatchet3"
RECIPE.color = Vector(.6, .6, .8)
RECIPE.icon = "vgui/tools/steel_hatchet_e.png"
Menu_RegisterTool( "woodcutting-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Hatchet (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 25"
RECIPE.cost = { emerald = 4 }
RECIPE.reqlvl = { smithing = 52}
RECIPE.uselevel = { woodcutting = 25}
RECIPE.xp = 220
RECIPE.entity = "gms_hatchet4e"
RECIPE.entity2 = "gms_hatchet4"
RECIPE.color = Vector(1, 1, 1)
RECIPE.icon = "vgui/tools/silver_hatchet_e.png"
Menu_RegisterTool( "woodcutting-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Hatchet (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 35"
RECIPE.cost = { emerald = 5 }
RECIPE.reqlvl = { smithing = 56}
RECIPE.uselevel = { woodcutting = 35}
RECIPE.xp = 260
RECIPE.entity = "gms_hatchet5e"
RECIPE.entity2 = "gms_hatchet5"
RECIPE.color = Vector(.1, .3, .1)
RECIPE.icon = "vgui/tools/trinium_hatchet_e.png"
Menu_RegisterTool( "woodcutting-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Hatchet (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 45"
RECIPE.cost = { emerald = 6 }
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { woodcutting = 45}
RECIPE.xp = 300
RECIPE.entity = "gms_hatchet6e"
RECIPE.entity2 = "gms_hatchet6"
RECIPE.color = Vector(.3, .1, .1)
RECIPE.icon = "vgui/tools/naquadah_hatchet_e.png"
Menu_RegisterTool( "woodcutting-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Hatchet (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 55"
RECIPE.cost = { emerald = 8 }
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { woodcutting = 55}
RECIPE.xp = 450
RECIPE.entity = "gms_hatchet7e"
RECIPE.entity2 = "gms_hatchet7"
RECIPE.color = Vector(.1, .1, .4)
RECIPE.icon = "vgui/tools/mithril_hatchet_e.png"
Menu_RegisterTool( "woodcutting-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Hatchet (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 65"
RECIPE.cost = { emerald = 8 }
RECIPE.reqlvl = { smithing = 71}
RECIPE.uselevel = { woodcutting = 65}
RECIPE.xp = 550
RECIPE.entity = "gms_hatchet8e"
RECIPE.entity2 = "gms_hatchet8"
RECIPE.color = Vector(.8, .8, .8)
RECIPE.icon = "vgui/tools/platinum_hatchet_e.png"
Menu_RegisterTool( "woodcutting-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Hatchet (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { emerald = 24 }
RECIPE.reqlvl = { smithing = 70}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 600
RECIPE.entity = "gms_ehatchete"
RECIPE.entity2 = "gms_ehatchet"
RECIPE.color = Vector(.6, .1, .6)
RECIPE.icon = "vgui/tools/enchanted_hatchet_e.png"
Menu_RegisterTool( "woodcutting-emerald", RECIPE )


----------------------------
------woodcutting-ruby------
----------------------------

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Hatchet (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { ruby = 1 }
RECIPE.reqlvl = { smithing = 40}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 110
RECIPE.entity = "gms_hatchet1r"
RECIPE.entity2 = "gms_hatchet1"
RECIPE.color = Vector(.6, .6, .6)
RECIPE.icon = "vgui/tools/stone_hatchet_r.png"
Menu_RegisterTool( "woodcutting-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Hatchet (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { ruby = 2 }
RECIPE.reqlvl = { smithing = 44}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 140
RECIPE.entity = "gms_hatchet2r"
RECIPE.entity2 = "gms_hatchet2"
RECIPE.color = Vector(.45, .3, .3)
RECIPE.icon = "vgui/tools/iron_hatchet_r.png"
Menu_RegisterTool( "woodcutting-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Hatchet (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 15"
RECIPE.cost = { ruby = 3 }
RECIPE.reqlvl = { smithing = 48}
RECIPE.uselevel = { woodcutting = 15}
RECIPE.xp = 190
RECIPE.entity = "gms_hatchet3r"
RECIPE.entity2 = "gms_hatchet3"
RECIPE.color = Vector(.6, .6, .8)
RECIPE.icon = "vgui/tools/steel_hatchet_r.png"
Menu_RegisterTool( "woodcutting-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Hatchet (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 25"
RECIPE.cost = { ruby = 4 }
RECIPE.reqlvl = { smithing = 52}
RECIPE.uselevel = { woodcutting = 25}
RECIPE.xp = 220
RECIPE.entity = "gms_hatchet4r"
RECIPE.entity2 = "gms_hatchet4"
RECIPE.color = Vector(1, 1, 1)
RECIPE.icon = "vgui/tools/silver_hatchet_r.png"
Menu_RegisterTool( "woodcutting-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Hatchet (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 35"
RECIPE.cost = { ruby = 5 }
RECIPE.reqlvl = { smithing = 56}
RECIPE.uselevel = { woodcutting = 35}
RECIPE.xp = 260
RECIPE.entity = "gms_hatchet5r"
RECIPE.entity2 = "gms_hatchet5"
RECIPE.color = Vector(.1, .3, .1)
RECIPE.icon = "vgui/tools/trinium_hatchet_r.png"
Menu_RegisterTool( "woodcutting-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Hatchet (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 45"
RECIPE.cost = { ruby = 6 }
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { woodcutting = 45}
RECIPE.xp = 300
RECIPE.entity = "gms_hatchet6r"
RECIPE.entity2 = "gms_hatchet6"
RECIPE.color = Vector(.3, .1, .1)
RECIPE.icon = "vgui/tools/naquadah_hatchet_r.png"
Menu_RegisterTool( "woodcutting-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Hatchet (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 55"
RECIPE.cost = { ruby = 8 }
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { woodcutting = 55}
RECIPE.xp = 450
RECIPE.entity = "gms_hatchet7r"
RECIPE.entity2 = "gms_hatchet7"
RECIPE.color = Vector(.1, .1, .4)
RECIPE.icon = "vgui/tools/mithril_hatchet_r.png"
Menu_RegisterTool( "woodcutting-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Hatchet (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 65"
RECIPE.cost = { ruby = 8 }
RECIPE.reqlvl = { smithing = 71}
RECIPE.uselevel = { woodcutting = 65}
RECIPE.xp = 550
RECIPE.entity = "gms_hatchet8r"
RECIPE.entity2 = "gms_hatchet8"
RECIPE.color = Vector(.8, .8, .8)
RECIPE.icon = "vgui/tools/platinum_hatchet_r.png"
Menu_RegisterTool( "woodcutting-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Hatchet (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { ruby = 24 }
RECIPE.reqlvl = { smithing = 70}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 600
RECIPE.entity = "gms_ehatchetr"
RECIPE.entity2 = "gms_ehatchet"
RECIPE.color = Vector(.6, .1, .6)
RECIPE.icon = "vgui/tools/enchanted_hatchet_r.png"
Menu_RegisterTool( "woodcutting-ruby", RECIPE )

-------------------------------
------woodcutting-diamond------
-------------------------------

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Hatchet (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { diamond = 1 }
RECIPE.reqlvl = { smithing = 40}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 110
RECIPE.entity = "gms_hatchet1d"
RECIPE.entity2 = "gms_hatchet1"
RECIPE.color = Vector(.6, .6, .6)
RECIPE.icon = "vgui/tools/stone_hatchet_d.png"
Menu_RegisterTool( "woodcutting-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Hatchet (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { diamond = 2 }
RECIPE.reqlvl = { smithing = 44}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 140
RECIPE.entity = "gms_hatchet2d"
RECIPE.entity2 = "gms_hatchet2"
RECIPE.color = Vector(.45, .3, .3)
RECIPE.icon = "vgui/tools/iron_hatchet_d.png"
Menu_RegisterTool( "woodcutting-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Hatchet (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 15"
RECIPE.cost = { diamond = 3 }
RECIPE.reqlvl = { smithing = 48}
RECIPE.uselevel = { woodcutting = 15}
RECIPE.xp = 190
RECIPE.entity = "gms_hatchet3d"
RECIPE.entity2 = "gms_hatchet3"
RECIPE.color = Vector(.6, .6, .8)
RECIPE.icon = "vgui/tools/steel_hatchet_d.png"
Menu_RegisterTool( "woodcutting-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Hatchet (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 25"
RECIPE.cost = { diamond = 4 }
RECIPE.reqlvl = { smithing = 52}
RECIPE.uselevel = { woodcutting = 25}
RECIPE.xp = 220
RECIPE.entity = "gms_hatchet4d"
RECIPE.entity2 = "gms_hatchet4"
RECIPE.color = Vector(1, 1, 1)
RECIPE.icon = "vgui/tools/silver_hatchet_d.png"
Menu_RegisterTool( "woodcutting-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Hatchet (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 35"
RECIPE.cost = { diamond = 5 }
RECIPE.reqlvl = { smithing = 56}
RECIPE.uselevel = { woodcutting = 35}
RECIPE.xp = 260
RECIPE.entity = "gms_hatchet5d"
RECIPE.entity2 = "gms_hatchet5"
RECIPE.color = Vector(.1, .3, .1)
RECIPE.icon = "vgui/tools/trinium_hatchet_d.png"
Menu_RegisterTool( "woodcutting-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Hatchet (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 45"
RECIPE.cost = { diamond = 6 }
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { woodcutting = 45}
RECIPE.xp = 300
RECIPE.entity = "gms_hatchet6d"
RECIPE.entity2 = "gms_hatchet6"
RECIPE.color = Vector(.3, .1, .1)
RECIPE.icon = "vgui/tools/naquadah_hatchet_d.png"
Menu_RegisterTool( "woodcutting-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Hatchet (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 55"
RECIPE.cost = { diamond = 8 }
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { woodcutting = 55}
RECIPE.xp = 450
RECIPE.entity = "gms_hatchet7d"
RECIPE.entity2 = "gms_hatchet7"
RECIPE.color = Vector(.1, .1, .4)
RECIPE.icon = "vgui/tools/mithril_hatchet_d.png"
Menu_RegisterTool( "woodcutting-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Hatchet (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 65"
RECIPE.cost = { diamond = 8 }
RECIPE.reqlvl = { smithing = 71}
RECIPE.uselevel = { woodcutting = 65}
RECIPE.xp = 550
RECIPE.entity = "gms_hatchet8d"
RECIPE.entity2 = "gms_hatchet8"
RECIPE.color = Vector(.8, .8, .8)
RECIPE.icon = "vgui/tools/platinum_hatchet_d.png"
Menu_RegisterTool( "woodcutting-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Hatchet (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { diamond = 24 }
RECIPE.reqlvl = { smithing = 70}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 600
RECIPE.entity = "gms_ehatchetd"
RECIPE.entity2 = "gms_ehatchet"
RECIPE.color = Vector(.6, .1, .6)
RECIPE.icon = "vgui/tools/enchanted_hatchet_d.png"
Menu_RegisterTool( "woodcutting-diamond", RECIPE )




---------------------------
------mining-sapphire------
---------------------------

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Pickaxe (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { sapphire = 1 }
RECIPE.reqlvl = { smithing = 40}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 110
RECIPE.entity = "gms_pickaxe1s"
RECIPE.entity2 = "gms_pickaxe1"
RECIPE.color = Vector(.6, .6, .6)
RECIPE.icon = "vgui/tools/stone_pickaxe_s.png"
Menu_RegisterTool( "mining-sapphire", RECIPE )


RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Pickaxe (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { sapphire = 2 }
RECIPE.reqlvl = { smithing = 44}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 140
RECIPE.entity = "gms_pickaxe2s"
RECIPE.entity2 = "gms_pickaxe2"
RECIPE.color = Vector(.45, .3, .3)
RECIPE.icon = "vgui/tools/iron_pickaxe_s.png"
Menu_RegisterTool( "mining-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Pickaxe (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Mine Ore\nRequired Mining Lvl: 15"
RECIPE.cost = { sapphire = 3 }
RECIPE.reqlvl = { smithing = 48}
RECIPE.uselevel = { mining = 15}
RECIPE.xp = 190
RECIPE.entity = "gms_pickaxe3s"
RECIPE.entity2 = "gms_pickaxe3"
RECIPE.color = Vector(.6, .6, .8)
RECIPE.icon = "vgui/tools/steel_pickaxe_s.png"
Menu_RegisterTool( "mining-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Pickaxe (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Mine Ore\nRequired Mining Lvl: 25"
RECIPE.cost = { sapphire = 4 }
RECIPE.reqlvl = { smithing = 52}
RECIPE.uselevel = { mining = 25}
RECIPE.xp = 220
RECIPE.entity = "gms_pickaxe4s"
RECIPE.entity2 = "gms_pickaxe4"
RECIPE.color = Vector(1, 1, 1)
RECIPE.icon = "vgui/tools/silver_pickaxe_s.png"
Menu_RegisterTool( "mining-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Pickaxe (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Mine Ore\nRequired Mining Lvl: 35"
RECIPE.cost = { sapphire = 5 }
RECIPE.reqlvl = { smithing = 56}
RECIPE.uselevel = { mining = 35}
RECIPE.xp = 260
RECIPE.entity = "gms_pickaxe5s"
RECIPE.entity2 = "gms_pickaxe5"
RECIPE.color = Vector(.1, .3, .1)
RECIPE.icon = "vgui/tools/trinium_pickaxe_s.png"
Menu_RegisterTool( "mining-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Pickaxe (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Mine Ore\nRequired Mining Lvl: 45"
RECIPE.cost = { sapphire = 6 }
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { mining = 45}
RECIPE.xp = 300
RECIPE.entity = "gms_pickaxe6s"
RECIPE.entity2 = "gms_pickaxe6"
RECIPE.color = Vector(.3, .1, .1)
RECIPE.icon = "vgui/tools/naquadah_pickaxe_s.png"
Menu_RegisterTool( "mining-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Pickaxe (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Mine Ore\nRequired Mining Lvl: 55"
RECIPE.cost = { sapphire = 8 }
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { mining = 55}
RECIPE.xp = 450
RECIPE.entity = "gms_pickaxe7s"
RECIPE.entity2 = "gms_pickaxe7"
RECIPE.color = Vector(.1, .1, .4)
RECIPE.icon = "vgui/tools/mithril_pickaxe_s.png"
Menu_RegisterTool( "mining-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Pickaxe (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Mine Ore\nRequired Mining Lvl: 65"
RECIPE.cost = { sapphire = 8 }
RECIPE.reqlvl = { smithing = 71}
RECIPE.uselevel = { mining = 65}
RECIPE.xp = 550
RECIPE.entity = "gms_pickaxe8s"
RECIPE.entity2 = "gms_pickaxe8"
RECIPE.color = Vector(.8, .8, .8)
RECIPE.icon = "vgui/tools/platinum_pickaxe_s.png"
Menu_RegisterTool( "mining-sapphire", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Pickaxe (s)"
RECIPE.description = "This tool has the sapphire enchantment\nSometimes will earn you more experience\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { sapphire = 24 }
RECIPE.reqlvl = { smithing = 70}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 600
RECIPE.entity = "gms_epickaxes"
RECIPE.entity2 = "gms_epickaxe"
RECIPE.color = Vector(.6, .1, .6)
RECIPE.icon = "vgui/tools/enchanted_pickaxe_s.png"
Menu_RegisterTool( "mining-sapphire", RECIPE )

--------------------------
------mining-emerald------
--------------------------

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Pickaxe (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { emerald = 1 }
RECIPE.reqlvl = { smithing = 40}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 110
RECIPE.entity = "gms_pickaxe1e"
RECIPE.entity2 = "gms_pickaxe1"
RECIPE.color = Vector(.6, .6, .6)
RECIPE.icon = "vgui/tools/stone_pickaxe_e.png"
Menu_RegisterTool( "mining-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Pickaxe (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { emerald = 2 }
RECIPE.reqlvl = { smithing = 44}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 140
RECIPE.entity = "gms_pickaxe2e"
RECIPE.entity2 = "gms_pickaxe2"
RECIPE.color = Vector(.45, .3, .3)
RECIPE.icon = "vgui/tools/iron_pickaxe_e.png"
Menu_RegisterTool( "mining-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Pickaxe (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Mine Ore\nRequired Mining Lvl: 15"
RECIPE.cost = { emerald = 3 }
RECIPE.reqlvl = { smithing = 48}
RECIPE.uselevel = { mining = 15}
RECIPE.xp = 190
RECIPE.entity = "gms_pickaxe3e"
RECIPE.entity2 = "gms_pickaxe3"
RECIPE.color = Vector(.6, .6, .8)
RECIPE.icon = "vgui/tools/steel_pickaxe_e.png"
Menu_RegisterTool( "mining-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Pickaxe (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Mine Ore\nRequired Mining Lvl: 25"
RECIPE.cost = { emerald = 4 }
RECIPE.reqlvl = { smithing = 52}
RECIPE.uselevel = { mining = 25}
RECIPE.xp = 220
RECIPE.entity = "gms_pickaxe4e"
RECIPE.entity2 = "gms_pickaxe4"
RECIPE.color = Vector(1, 1, 1)
RECIPE.icon = "vgui/tools/silver_pickaxe_e.png"
Menu_RegisterTool( "mining-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Pickaxe (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Mine Ore\nRequired Mining Lvl: 35"
RECIPE.cost = { emerald = 5 }
RECIPE.reqlvl = { smithing = 56}
RECIPE.uselevel = { mining = 35}
RECIPE.xp = 260
RECIPE.entity = "gms_pickaxe5e"
RECIPE.entity2 = "gms_pickaxe5"
RECIPE.color = Vector(.1, .3, .1)
RECIPE.icon = "vgui/tools/trinium_pickaxe_e.png"
Menu_RegisterTool( "mining-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Pickaxe (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Mine Ore\nRequired Mining Lvl: 45"
RECIPE.cost = { emerald = 6 }
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { mining = 45}
RECIPE.xp = 300
RECIPE.entity = "gms_pickaxe6e"
RECIPE.entity2 = "gms_pickaxe6"
RECIPE.color = Vector(.3, .1, .1)
RECIPE.icon = "vgui/tools/naquadah_pickaxe_e.png"
Menu_RegisterTool( "mining-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Pickaxe (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Mine Ore\nRequired Mining Lvl: 55"
RECIPE.cost = { emerald = 8 }
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { mining = 55}
RECIPE.xp = 450
RECIPE.entity = "gms_pickaxe7e"
RECIPE.entity2 = "gms_pickaxe7"
RECIPE.color = Vector(.1, .1, .4)
RECIPE.icon = "vgui/tools/mithril_pickaxe_e.png"
Menu_RegisterTool( "mining-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Pickaxe (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Mine Ore\nRequired Mining Lvl: 65"
RECIPE.cost = { emerald = 8 }
RECIPE.reqlvl = { smithing = 71}
RECIPE.uselevel = { mining = 65}
RECIPE.xp = 550
RECIPE.entity = "gms_pickaxe8e"
RECIPE.entity2 = "gms_pickaxe8"
RECIPE.color = Vector(.8, .8, .8)
RECIPE.icon = "vgui/tools/platinum_pickaxe_e.png"
Menu_RegisterTool( "mining-emerald", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Pickaxe (e)"
RECIPE.description = "This tool has the emerald enchantment\nOccasionally will be faster\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { emerald = 24 }
RECIPE.reqlvl = { smithing = 70}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 600
RECIPE.entity = "gms_epickaxee"
RECIPE.entity2 = "gms_epickaxe"
RECIPE.color = Vector(.6, .1, .6)
RECIPE.icon = "vgui/tools/enchanted_pickaxe_e.png"
Menu_RegisterTool( "mining-emerald", RECIPE )

-----------------------
------mining-ruby------
-----------------------

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Pickaxe (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { ruby = 1 }
RECIPE.reqlvl = { smithing = 40}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 110
RECIPE.entity = "gms_pickaxe1r"
RECIPE.entity2 = "gms_pickaxe1"
RECIPE.color = Vector(.6, .6, .6)
RECIPE.icon = "vgui/tools/stone_pickaxe_r.png"
Menu_RegisterTool( "mining-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Pickaxe (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { ruby = 2 }
RECIPE.reqlvl = { smithing = 44}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 140
RECIPE.entity = "gms_pickaxe2r"
RECIPE.entity2 = "gms_pickaxe2"
RECIPE.color = Vector(.45, .3, .3)
RECIPE.icon = "vgui/tools/iron_pickaxe_r.png"
Menu_RegisterTool( "mining-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Pickaxe (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Mine Ore\nRequired Mining Lvl: 15"
RECIPE.cost = { ruby = 3 }
RECIPE.reqlvl = { smithing = 48}
RECIPE.uselevel = { mining = 15}
RECIPE.xp = 190
RECIPE.entity = "gms_pickaxe3r"
RECIPE.entity2 = "gms_pickaxe3"
RECIPE.color = Vector(.6, .6, .8)
RECIPE.icon = "vgui/tools/steel_pickaxe_r.png"
Menu_RegisterTool( "mining-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Pickaxe (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Mine Ore\nRequired Mining Lvl: 25"
RECIPE.cost = { ruby = 4 }
RECIPE.reqlvl = { smithing = 52}
RECIPE.uselevel = { mining = 25}
RECIPE.xp = 220
RECIPE.entity = "gms_pickaxe4r"
RECIPE.entity2 = "gms_pickaxe4"
RECIPE.color = Vector(1, 1, 1)
RECIPE.icon = "vgui/tools/silver_pickaxe_r.png"
Menu_RegisterTool( "mining-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Pickaxe (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Mine Ore\nRequired Mining Lvl: 35"
RECIPE.cost = { ruby = 5 }
RECIPE.reqlvl = { smithing = 56}
RECIPE.uselevel = { mining = 35}
RECIPE.xp = 260
RECIPE.entity = "gms_pickaxe5r"
RECIPE.entity2 = "gms_pickaxe5"
RECIPE.color = Vector(.1, .3, .1)
RECIPE.icon = "vgui/tools/trinium_pickaxe_r.png"
Menu_RegisterTool( "mining-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Pickaxe (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Mine Ore\nRequired Mining Lvl: 45"
RECIPE.cost = { ruby = 6 }
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { mining = 45}
RECIPE.xp = 300
RECIPE.entity = "gms_pickaxe6r"
RECIPE.entity2 = "gms_pickaxe6"
RECIPE.color = Vector(.3, .1, .1)
RECIPE.icon = "vgui/tools/naquadah_pickaxe_r.png"
Menu_RegisterTool( "mining-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Pickaxe (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Mine Ore\nRequired Mining Lvl: 55"
RECIPE.cost = { ruby = 8 }
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { mining = 55}
RECIPE.xp = 450
RECIPE.entity = "gms_pickaxe7r"
RECIPE.entity2 = "gms_pickaxe7"
RECIPE.color = Vector(.1, .1, .4)
RECIPE.icon = "vgui/tools/mithril_pickaxe_r.png"
Menu_RegisterTool( "mining-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Pickaxe (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Mine Ore\nRequired Mining Lvl: 65"
RECIPE.cost = { ruby = 8 }
RECIPE.reqlvl = { smithing = 71}
RECIPE.uselevel = { mining = 65}
RECIPE.xp = 550
RECIPE.entity = "gms_pickaxe8r"
RECIPE.entity2 = "gms_pickaxe8"
RECIPE.color = Vector(.8, .8, .8)
RECIPE.icon = "vgui/tools/platinum_pickaxe_r.png"
Menu_RegisterTool( "mining-ruby", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Pickaxe (r)"
RECIPE.description = "This tool has the ruby enchantment\nSometimes you'll receive twice the drops\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { ruby = 24 }
RECIPE.reqlvl = { smithing = 70}
RECIPE.xp = 600
RECIPE.entity = "gms_epickaxer"
RECIPE.entity2 = "gms_epickaxe"
RECIPE.color = Vector(.6, .1, .6)
RECIPE.icon = "vgui/tools/enchanted_pickaxe_r.png"
Menu_RegisterTool( "mining-ruby", RECIPE )


--------------------------
------mining-diamond------
--------------------------

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Stone Pickaxe (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { diamond = 1 }
RECIPE.reqlvl = { smithing = 40}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 110
RECIPE.entity = "gms_pickaxe1d"
RECIPE.entity2 = "gms_pickaxe1"
RECIPE.color = Vector(.6, .6, .6)
RECIPE.icon = "vgui/tools/stone_pickaxe_d.png"
Menu_RegisterTool( "mining-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Iron Pickaxe (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { diamond = 2 }
RECIPE.reqlvl = { smithing = 44}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 140
RECIPE.entity = "gms_pickaxe2d"
RECIPE.entity2 = "gms_pickaxe2"
RECIPE.color = Vector(.45, .3, .3)
RECIPE.icon = "vgui/tools/iron_pickaxe_d.png"
Menu_RegisterTool( "mining-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Steel Pickaxe (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Mine Ore\nRequired Mining Lvl: 15"
RECIPE.cost = { diamond = 3 }
RECIPE.reqlvl = { smithing = 48}
RECIPE.uselevel = { mining = 15}
RECIPE.xp = 190
RECIPE.entity = "gms_pickaxe3d"
RECIPE.entity2 = "gms_pickaxe3"
RECIPE.color = Vector(.6, .6, .8)
RECIPE.icon = "vgui/tools/steel_pickaxe_d.png"
Menu_RegisterTool( "mining-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Silver Pickaxe (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Mine Ore\nRequired Mining Lvl: 25"
RECIPE.cost = { diamond = 4 }
RECIPE.reqlvl = { smithing = 52}
RECIPE.uselevel = { mining = 25}
RECIPE.xp = 220
RECIPE.entity = "gms_pickaxe4d"
RECIPE.entity2 = "gms_pickaxe4"
RECIPE.color = Vector(1, 1, 1)
RECIPE.icon = "vgui/tools/silver_pickaxe_d.png"
Menu_RegisterTool( "mining-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Trinium Pickaxe (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Mine Ore\nRequired Mining Lvl: 35"
RECIPE.cost = { diamond = 5 }
RECIPE.reqlvl = { smithing = 56}
RECIPE.uselevel = { mining = 35}
RECIPE.xp = 260
RECIPE.entity = "gms_pickaxe5d"
RECIPE.entity2 = "gms_pickaxe5"
RECIPE.color = Vector(.1, .3, .1)
RECIPE.icon = "vgui/tools/trinium_pickaxe_d.png"
Menu_RegisterTool( "mining-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Naquadah Pickaxe (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Mine Ore\nRequired Mining Lvl: 45"
RECIPE.cost = { diamond = 6 }
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { mining = 45}
RECIPE.xp = 300
RECIPE.entity = "gms_pickaxe6d"
RECIPE.entity2 = "gms_pickaxe6"
RECIPE.color = Vector(.3, .1, .1)
RECIPE.icon = "vgui/tools/naquadah_pickaxe_d.png"
Menu_RegisterTool( "mining-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Mithril Pickaxe (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Mine Ore\nRequired Mining Lvl: 55"
RECIPE.cost = { diamond = 8 }
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { mining = 55}
RECIPE.xp = 450
RECIPE.entity = "gms_pickaxe7d"
RECIPE.entity2 = "gms_pickaxe7"
RECIPE.color = Vector(.1, .1, .4)
RECIPE.icon = "vgui/tools/mithril_pickaxe_d.png"
Menu_RegisterTool( "mining-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Platinum Pickaxe (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Mine Ore\nRequired Mining Lvl: 65"
RECIPE.cost = { diamond = 8 }
RECIPE.reqlvl = { smithing = 71}
RECIPE.uselevel = { mining = 65}
RECIPE.xp = 550
RECIPE.entity = "gms_pickaxe8d"
RECIPE.entity2 = "gms_pickaxe8"
RECIPE.color = Vector(.8, .8, .8)
RECIPE.icon = "vgui/tools/platinum_pickaxe_d.png"
Menu_RegisterTool( "mining-diamond", RECIPE )

RECIPE = {}
RECIPE.nosmith = true
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Enchanted Pickaxe (d)"
RECIPE.description = "This tool has the diamond enchantment\nFinding rare items is a little easier!\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { diamond = 24 }
RECIPE.reqlvl = { smithing = 70}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 600
RECIPE.entity = "gms_epickaxed"
RECIPE.entity2 = "gms_epickaxe"
RECIPE.color = Vector(.6, .1, .6)
RECIPE.icon = "vgui/tools/enchanted_pickaxe_d.png"
Menu_RegisterTool( "mining-diamond", RECIPE )



--------------
-----boss-----
--------------

RECIPE = {}
RECIPE.model = "models/world_hatchet/world_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Boss Hatchet"
RECIPE.description = "Very powerful tree cutting tool!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { boss_hatchet_head = 1, yew_wood = 10}
RECIPE.reqlvl = { smithing = 50}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 1200
RECIPE.entity = "gms_bosshatchet"
RECIPE.color = Vector(.2, .9, .2)
RECIPE.icon = "vgui/tools/boss_hatchet.png"
Menu_RegisterTool( "boss", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Boss Pickaxe"
RECIPE.description = "Very powerful mining tool!\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { boss_pick_head = 1, yew_wood = 10}
RECIPE.reqlvl = { smithing = 50}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 1200
RECIPE.entity = "gms_bosspickaxe"
RECIPE.color = Vector(.2, .9, .2)
RECIPE.icon = "vgui/tools/boss_pickaxe.png"
Menu_RegisterTool( "boss", RECIPE )

RECIPE = {}
RECIPE.model = "models/rods/c_boss_rod/c_boss_rod.mdl"
RECIPE.skin = 1
RECIPE.title = "Boss Rod"
RECIPE.description = "Very powerful combat weapon!\nPrimary: Attack\nRequired Combat Lvl: 35"
RECIPE.cost = { boss_rod_core = 1, yew_wood = 10}
RECIPE.reqlvl = { smithing = 50}
RECIPE.uselevel = { combat = 35}
RECIPE.xp = 1200
RECIPE.entity = "weapon_bossmelee"
RECIPE.icon = "vgui/tools/boss_melee.png"
Menu_RegisterTool( "boss", RECIPE )

--------------
-----Void-----
--------------

RECIPE = {}
RECIPE.model = "models/c_void_hatchet/c_void_hatchet.mdl"
RECIPE.skin = 1
RECIPE.title = "Void Hatchet"
RECIPE.description = "Very powerful tree cutting tool!\nPrimary: Chop Tree\nRequired Woodcutting Lvl: 1"
RECIPE.cost = { void_hatchet_head = 1, buckeye_wood = 50}
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { woodcutting = 1}
RECIPE.xp = 2400
RECIPE.entity = "gms_voidhatchet"
RECIPE.color = Vector(0, 0, 0)
RECIPE.icon = "vgui/tools/void_hatchet.png"
Menu_RegisterTool( "void", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Void Pickaxe"
RECIPE.description = "Very powerful mining tool!\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { void_pickaxe_head = 1, buckeye_wood = 50}
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 2400
RECIPE.entity = "gms_voidpickaxe"
RECIPE.color = Vector(0, 0, 0)
RECIPE.icon = "vgui/tools/void_pickaxe.png"
Menu_RegisterTool( "void", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/fishingrod.mdl"
RECIPE.skin = 1
RECIPE.title = "Void Fishing Rod"
RECIPE.description = "Very powerful fishing tool!\nPrimary: Fish\nRequired Fishing Lvl: 1"
RECIPE.cost = { void_fishing_reel = 1, buckeye_wood = 50}
RECIPE.reqlvl = { smithing = 60}
RECIPE.uselevel = { fishing = 1}
RECIPE.xp = 2400
RECIPE.entity = "gms_voidfishingrod"
RECIPE.icon = "vgui/tools/void_rod.png"
RECIPE.color = Vector(0, 0, 0)
Menu_RegisterTool( "void", RECIPE )

RECIPE = {}
RECIPE.model = "models/devonjones/stranded/hoe.mdl"
RECIPE.skin = 1
RECIPE.title = "Void Hoe"
RECIPE.description = "Very powerful farming tool!\nPrimary: Forage/Harvest\nRequired Farming Lvl: 1"
RECIPE.cost = { void_hoe_blade = 1, buckeye_wood = 50}
RECIPE.reqlvl = { smithing = 50}
RECIPE.uselevel = { farming = 1}
RECIPE.xp = 2400
RECIPE.entity = "gms_voidhoe"
RECIPE.icon = "vgui/tools/void_hoe.png"
RECIPE.color = Vector(0, 0, 0)
Menu_RegisterTool( "void", RECIPE )

------------------
-----Meteoric-----
------------------

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Meteoric Pickaxe"
RECIPE.description = "Very powerful mining tool!\nPrimary: Mine Ore\nRequired Mining Lvl: 1"
RECIPE.cost = { meteoric_iron = 5, palm_wood = 50}
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 9000
RECIPE.entity = "gms_mpickaxe"
RECIPE.color = Vector(1, .5, 0)
RECIPE.icon = "vgui/tools/meteoric_pickaxe.png"
Menu_RegisterTool( "meteoric", RECIPE )

RECIPE = {}
RECIPE.model = "models/c_pickaxe/c_pickaxe.mdl"
RECIPE.skin = 1
RECIPE.title = "Refined Meteoric Pick"
RECIPE.description = "Very powerful mining tool!\nPrimary: Mine Ore\nRequired Mining Lvl: 1\nUnbreakable!"
RECIPE.cost = { refined_meteoric_iron = 6, enchanted_wood = 12}
RECIPE.reqlvl = { smithing = 65}
RECIPE.uselevel = { mining = 1}
RECIPE.xp = 9000
RECIPE.entity = "gms_rmpickaxe"
RECIPE.color = Vector(0.8, .4, 0)
RECIPE.icon = "vgui/tools/meteoric_pickaxe.png"
Menu_RegisterTool( "meteoric", RECIPE )