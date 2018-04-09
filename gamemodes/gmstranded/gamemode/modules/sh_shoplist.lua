SGS.Shop = {}
function Shop_RegisterShopItem( category, item )
	if not SGS.Shop[category] then SGS.Shop[category] = {} end
	SGS.Shop[category][#SGS.Shop[category] + 1] = item
end

//-=structures--//

ITEM = {}
ITEM.title = "Advanced Persistant Cache"
ITEM.uid = "structure1"
ITEM.description = "Holds 3x the normal amount"
ITEM.cost = 2500
ITEM.gives = { gms_pcache2 = 1}
ITEM.material = "vgui/SGS/test1.vmt"
Shop_RegisterShopItem( "structures", ITEM )


ITEM = {}
ITEM.title = "Radio"
ITEM.uid = "structure2"
ITEM.description = "Powered by hopes and dreams."
ITEM.cost = 2500
ITEM.gives = { gms_radio = 1}
ITEM.material = "vgui/SGS/test1.vmt"
Shop_RegisterShopItem( "structures", ITEM )

--[[
ITEM = {}
ITEM.title = "Television"
ITEM.uid = "structure3"
ITEM.description = "Somehow it actually works?"
ITEM.cost = 5000
ITEM.gives = { gms_tv = 1}
ITEM.material = "vgui/SGS/test1.vmt"
Shop_RegisterShopItem( "structures", ITEM )
]]

//-=relics--//

ITEM = {}
ITEM.title = "Mining Relic Lv. 1"
ITEM.uid = "relic1"
ITEM.description = "Gives Mining Experience"
ITEM.cost = 75
ITEM.gives = { mining_relic_1 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Woodcutting Relic Lv. 1"
ITEM.uid = "relic2"
ITEM.description = "Gives Woodcutting Experience"
ITEM.cost = 75
ITEM.gives = { woodcutting_relic_1 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Fishing Relic Lv. 1"
ITEM.uid = "relic3"
ITEM.description = "Gives Fishing Experience"
ITEM.cost = 75
ITEM.gives = { fishing_relic_1 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Farming Relic Lv. 1"
ITEM.uid = "relic4"
ITEM.description = "Gives Farming Experience"
ITEM.cost = 75
ITEM.gives = { farming_relic_1 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Construction Relic Lv. 1"
ITEM.uid = "relic5"
ITEM.description = "Gives Construction Experience"
ITEM.cost = 75
ITEM.gives = { construction_relic_1 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Smithing Relic Lv. 1"
ITEM.uid = "relic6"
ITEM.description = "Gives Smithing Experience"
ITEM.cost = 75
ITEM.gives = { smithing_relic_1 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Cooking Relic Lv. 1"
ITEM.uid = "relic7"
ITEM.description = "Gives Cooking Experience"
ITEM.cost = 75
ITEM.gives = { cooking_relic_1 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Alchemy Relic Lv. 1"
ITEM.uid = "relic8"
ITEM.description = "Gives Alchemy Experience"
ITEM.cost = 75
ITEM.gives = { alchemy_relic_1 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Combat Relic Lv. 1"
ITEM.uid = "relic9"
ITEM.description = "Gives Combat Experience"
ITEM.cost = 75
ITEM.gives = { combat_relic_1 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Mining Relic Lv. 2"
ITEM.uid = "relic21"
ITEM.description = "Gives Mining Experience"
ITEM.cost = 250
ITEM.gives = { mining_relic_2 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Woodcutting Relic Lv. 2"
ITEM.uid = "relic22"
ITEM.description = "Gives Woodcutting Experience"
ITEM.cost = 250
ITEM.gives = { woodcutting_relic_2 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Fishing Relic Lv. 2"
ITEM.uid = "relic23"
ITEM.description = "Gives Fishing Experience"
ITEM.cost = 250
ITEM.gives = { fishing_relic_2 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Farming Relic Lv. 2"
ITEM.uid = "relic24"
ITEM.description = "Gives Farming Experience"
ITEM.cost = 250
ITEM.gives = { farming_relic_2 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Construction Relic Lv. 2"
ITEM.uid = "relic25"
ITEM.description = "Gives Construction Experience"
ITEM.cost = 250
ITEM.gives = { construction_relic_2 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Smithing Relic Lv. 2"
ITEM.uid = "relic26"
ITEM.description = "Gives Smithing Experience"
ITEM.cost = 250
ITEM.gives = { smithing_relic_2 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Cooking Relic Lv. 2"
ITEM.uid = "relic27"
ITEM.description = "Gives Cooking Experience"
ITEM.cost = 250
ITEM.gives = { cooking_relic_2 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Combat Relic Lv. 2"
ITEM.uid = "relic28"
ITEM.description = "Gives Combat Experience"
ITEM.cost = 250
ITEM.gives = { combat_relic_2 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )

ITEM = {}
ITEM.title = "Alchemy Relic Lv. 2"
ITEM.uid = "relic29"
ITEM.description = "Gives Alchemy Experience"
ITEM.cost = 250
ITEM.gives = { alchemy_relic_2 = 1}
ITEM.material = "vgui/relic_png.png"
Shop_RegisterShopItem( "relics", ITEM )


//-=seeds--//

ITEM = {}
ITEM.title = "Pypa Seed Pack (50x)"
ITEM.uid = "seeds1"
ITEM.description = "Bundle of seeds"
ITEM.cost = 350
ITEM.gives = { pypa_seed = 50}
ITEM.material = "vgui/farming/pypa_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )

ITEM = {}
ITEM.title = "Guacca Seed Pack (30x)"
ITEM.uid = "seeds2"
ITEM.description = "Bundle of seeds"
ITEM.cost = 350
ITEM.gives = { guacca_seed = 30}
ITEM.material = "vgui/farming/guacca_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )

ITEM = {}
ITEM.title = "Arctus Seed Pack (20x)"
ITEM.uid = "seeds3"
ITEM.description = "Bundle of seeds"
ITEM.cost = 350
ITEM.gives = { arctus_seed = 20}
ITEM.material = "vgui/farming/arctus_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )

ITEM = {}
ITEM.title = "Liechi Seed Pack (10x)"
ITEM.uid = "seeds4"
ITEM.description = "Bundle of seeds"
ITEM.cost = 350
ITEM.gives = { liechi_seed = 10}
ITEM.material = "vgui/farming/liechi_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )

ITEM = {}
ITEM.title = "Lum Seed Pack (5x)"
ITEM.uid = "seeds5"
ITEM.description = "Bundle of seeds"
ITEM.cost = 350
ITEM.gives = { lum_seed = 5}
ITEM.material = "vgui/farming/lum_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )

ITEM = {}
ITEM.title = "Wheat Seed Pack (30x)"
ITEM.uid = "seeds6"
ITEM.description = "Bundle of seeds"
ITEM.cost = 350
ITEM.gives = { wheat_seed = 30}
ITEM.material = "vgui/farming/wheat_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )

ITEM = {}
ITEM.title = "Liferoot Seed Pack (20x)"
ITEM.uid = "seeds7"
ITEM.description = "Bundle of seeds"
ITEM.cost = 450
ITEM.gives = { liferoot_seed = 20}
ITEM.material = "vgui/farming/liferoot_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )

ITEM = {}
ITEM.title = "Tree Seed Pack (20x)"
ITEM.uid = "seeds8"
ITEM.description = "Bundle of seeds"
ITEM.cost = 450
ITEM.gives = { tree_seed = 20}
ITEM.material = "vgui/farming/tree_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )

ITEM = {}
ITEM.title = "Oak Seed Pack (15x)"
ITEM.uid = "seeds9"
ITEM.description = "Bundle of seeds"
ITEM.cost = 450
ITEM.gives = { oak_seed = 15}
ITEM.material = "vgui/farming/oak_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )

ITEM = {}
ITEM.title = "Maple Seed Pack (10x)"
ITEM.uid = "seeds10"
ITEM.description = "Bundle of seeds"
ITEM.cost = 450
ITEM.gives = { maple_seed = 10}
ITEM.material = "vgui/farming/maple_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )

ITEM = {}
ITEM.title = "Pine Seed Pack (5x)"
ITEM.uid = "seeds11"
ITEM.description = "Bundle of seeds"
ITEM.cost = 450
ITEM.gives = { pine_seed = 5}
ITEM.material = "vgui/farming/pine_seed.png"
Shop_RegisterShopItem( "seeds", ITEM )



//-=gems--//


ITEM = {}
ITEM.title = "Sapphires (2x)"
ITEM.uid = "gems1"
ITEM.description = "Shiny!"
ITEM.cost = 250
ITEM.gives = { sapphire = 2}
ITEM.material = "vgui/gems/sapphire_new.png"
Shop_RegisterShopItem( "gems", ITEM )

ITEM = {}
ITEM.title = "Emeralds (2x)"
ITEM.uid = "gems2"
ITEM.description = "Shiny!"
ITEM.cost = 350
ITEM.gives = { emerald = 2}
ITEM.material = "vgui/gems/emerald_new.png"
Shop_RegisterShopItem( "gems", ITEM )

ITEM = {}
ITEM.title = "Rubies (2x)"
ITEM.uid = "gems3"
ITEM.description = "Shiny!"
ITEM.cost = 500
ITEM.gives = { ruby = 2}
ITEM.material = "vgui/gems/ruby_new.png"
Shop_RegisterShopItem( "gems", ITEM )

ITEM = {}
ITEM.title = "Diamonds (2x)"
ITEM.uid = "gems4"
ITEM.description = "Shiny!"
ITEM.cost = 850
ITEM.gives = { diamond = 2}
ITEM.material = "vgui/gems/diamond_new.png"
Shop_RegisterShopItem( "gems", ITEM )


//-=Pet Food--//


ITEM = {}
ITEM.title = "Pet Food x10"
ITEM.uid = "petfood1"
ITEM.description = "I wouldn't try and eat this..."
ITEM.cost = 150
ITEM.gives = { pet_food = 10}
ITEM.material = "vgui/farming/liferoot_seed.png"
Shop_RegisterShopItem( "pet_food", ITEM )

ITEM = {}
ITEM.title = "Pet Food x25"
ITEM.uid = "petfood2"
ITEM.description = "I wouldn't try and eat this..."
ITEM.cost = 300
ITEM.gives = { pet_food = 25}
ITEM.material = "vgui/farming/liferoot_seed.png"
Shop_RegisterShopItem( "pet_food", ITEM )

ITEM = {}
ITEM.title = "Pet Food x50"
ITEM.uid = "petfood3"
ITEM.description = "I wouldn't try and eat this..."
ITEM.cost = 600
ITEM.gives = { pet_food = 50}
ITEM.material = "vgui/farming/liferoot_seed.png"
Shop_RegisterShopItem( "pet_food", ITEM )


//-=Other--//


ITEM = {}
ITEM.title = "Inter-Dimensional Core"
ITEM.uid = "other1"
ITEM.description = "It looks very unstable.\nWhat could this be for?"
ITEM.cost = 3000
ITEM.gives = { inter_dimensional_core = 1}
ITEM.material = "vgui/other/sapphire_new.png"
Shop_RegisterShopItem( "other", ITEM )

ITEM = {}
ITEM.title = "Permanent Inventory Increase 1"
ITEM.uid = "other2"
ITEM.description = "Permanently increases your maximum inventory by 50."
ITEM.cost = 2500
ITEM.gives = { max_inventory_buff_1 = 1}
ITEM.material = "vgui/gems/diamond_new.png"
Shop_RegisterShopItem( "other", ITEM )

ITEM = {}
ITEM.title = "Permanent Inventory Increase 2"
ITEM.uid = "other3"
ITEM.description = "Permanently increases your maximum inventory by 100."
ITEM.cost = 5000
ITEM.gives = { max_inventory_buff_2 = 1}
ITEM.material = "vgui/gems/diamond_new.png"
Shop_RegisterShopItem( "other", ITEM )

ITEM = {}
ITEM.title = "Permanent Max Plants Increase 1"
ITEM.uid = "other4"
ITEM.description = "Permanently increases your maximum plants by 3."
ITEM.cost = 1000
ITEM.gives = { max_plant_buff_1 = 1}
ITEM.material = "vgui/gems/emerald_new.png"
Shop_RegisterShopItem( "other", ITEM )

ITEM = {}
ITEM.title = "Permanent Max Plants Increase 2"
ITEM.uid = "other5"
ITEM.description = "Permanently increases your maximum plants by 6."
ITEM.cost = 2500
ITEM.gives = { max_plant_buff_2 = 1}
ITEM.material = "vgui/gems/emerald_new.png"
Shop_RegisterShopItem( "other", ITEM )

ITEM = {}
ITEM.title = "Void Cache Tuning Crystal"
ITEM.uid = "other6"
ITEM.description = "This crystal opens a Void Cache. The Crystal is consumed in the process.\nImported From: Xen"
ITEM.cost = 1000
ITEM.gives = { void_crystal = 1}
ITEM.material = "vgui/gems/void_new.png"
Shop_RegisterShopItem( "other", ITEM )

ITEM = {}
ITEM.title = "Pet House Upgrade 1"
ITEM.uid = "other7"
ITEM.description = "Permanently increases max pet storage by 5."
ITEM.cost = 1500
ITEM.gives = { pethouse_upgrade_1 = 1}
ITEM.material = "vgui/gems/ruby_new.png"
Shop_RegisterShopItem( "other", ITEM )

ITEM = {}
ITEM.title = "Pet House Upgrade 2"
ITEM.uid = "other8"
ITEM.description = "Permanently increases max pet storage by 5."
ITEM.cost = 2500
ITEM.gives = { pethouse_upgrade_2 = 1}
ITEM.material = "vgui/gems/ruby_new.png"
Shop_RegisterShopItem( "other", ITEM )

ITEM = {}
ITEM.title = "Persistent Tribe Upgrade"
ITEM.uid = "other9"
ITEM.description = "Upgrades your tribe to level 1\nMakes your tribe Persistent\nPersistent tribes can level up and have tribe perks.\nThis is supposed to be 'expensive'. Go in with your friends to purchase."
ITEM.cost = 10000
ITEM.gives = { tribe_upgrade = 1}
ITEM.material = "vgui/gems/ruby_new.png"
Shop_RegisterShopItem( "other", ITEM )

//-=fireworks--//

ITEM = {}
ITEM.title = "Red Fireworks Pack"
ITEM.uid = "fw1"
ITEM.description = "Pack of 5 Red Fireworks"
ITEM.cost = 100
ITEM.gives = { gms_firework_red = 5}
ITEM.material = "vgui/fireworks/red.png"
Shop_RegisterShopItem( "fireworks", ITEM )

ITEM = {}
ITEM.title = "Green Fireworks Pack"
ITEM.uid = "fw2"
ITEM.description = "Pack of 5 Green Fireworks"
ITEM.cost = 100
ITEM.gives = { gms_firework_green = 5}
ITEM.material = "vgui/fireworks/green.png"
Shop_RegisterShopItem( "fireworks", ITEM )

ITEM = {}
ITEM.title = "Blue Fireworks Pack"
ITEM.uid = "fw3"
ITEM.description = "Pack of 5 Blue Fireworks"
ITEM.cost = 100
ITEM.gives = { gms_firework_blue = 5}
ITEM.material = "vgui/fireworks/blue.png"
Shop_RegisterShopItem( "fireworks", ITEM )

ITEM = {}
ITEM.title = "Yellow Fireworks Pack"
ITEM.uid = "fw4"
ITEM.description = "Pack of 5 Yellow Fireworks"
ITEM.cost = 100
ITEM.gives = { gms_firework_yellow = 5}
ITEM.material = "vgui/fireworks/yellow.png"
Shop_RegisterShopItem( "fireworks", ITEM )

ITEM = {}
ITEM.title = "Cyan Fireworks Pack"
ITEM.uid = "fw5"
ITEM.description = "Pack of 5 Cyan Fireworks"
ITEM.cost = 100
ITEM.gives = { gms_firework_cyan = 5}
ITEM.material = "vgui/fireworks/cyan.png"
Shop_RegisterShopItem( "fireworks", ITEM )

ITEM = {}
ITEM.title = "Purple Fireworks Pack"
ITEM.uid = "fw6"
ITEM.description = "Pack of 5 Purple Fireworks"
ITEM.cost = 100
ITEM.gives = { gms_firework_purple = 5}
ITEM.material = "vgui/fireworks/purple.png"
Shop_RegisterShopItem( "fireworks", ITEM )

ITEM = {}
ITEM.title = "White Fireworks Pack"
ITEM.uid = "fw7"
ITEM.description = "Pack of 5 White Fireworks"
ITEM.cost = 100
ITEM.gives = { gms_firework_white = 5}
ITEM.material = "vgui/fireworks/white.png"
Shop_RegisterShopItem( "fireworks", ITEM )

ITEM = {}
ITEM.title = "Rainbow Fireworks Pack"
ITEM.uid = "fw8"
ITEM.description = "Pack of 3 Rainbow Fireworks"
ITEM.cost = 100
ITEM.gives = { gms_firework_rainbow = 3}
ITEM.material = "vgui/fireworks/rainbow.png"
Shop_RegisterShopItem( "fireworks", ITEM )


--[[
//\\//\\//\\//\\
  SPECIAL SHOP
\\//\\//\\//\\//
]]

SGS.SpecialShop = {}
function Shop_RegisterSpecialShopItem( category, item )
	if not SGS.SpecialShop[category] then SGS.SpecialShop[category] = {} end
	SGS.SpecialShop[category][#SGS.SpecialShop[category] + 1] = item
end