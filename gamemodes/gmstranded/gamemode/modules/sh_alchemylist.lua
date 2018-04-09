SGS.Alch = {}

function Menu_RegisterAlch( category, alch )
	if not SGS.Alch[category] then SGS.Alch[category] = {} end
	
	SGS.Alch[category][#SGS.Alch[category] + 1] = alch
end

//--Ore Transmutes--//


local ALCH = {}
ALCH.material = "vgui/transmute/stone_to_iron.png"
ALCH.title = "Stone to Iron Ore"
ALCH.stitle = "Stone to Iron"
ALCH.uid = "iron1"
ALCH.description = "Transmute Stone into Iron Ore"
ALCH.cost = { stone = 5}
ALCH.reqlvl = { alchemy = 1}
ALCH.gives = { iron_ore = 1}
ALCH.xp = 10
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/iron_to_stone.png"
ALCH.title = "Iron Ore to Stone"
ALCH.stitle = "Iron to Stone"
ALCH.uid = "iron2"
ALCH.description = "Transmute Iron Ore into Stone"
ALCH.cost = { iron_ore = 1}
ALCH.reqlvl = { alchemy = 10}
ALCH.gives = { stone = 3}
ALCH.xp = 30
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/iron_to_coal.png"
ALCH.title = "Iron to Coal"
ALCH.stitle = "Iron to Coal"
ALCH.uid = "coal1"
ALCH.description = "Transmute Iron Ore into Coal"
ALCH.cost = { iron_ore = 5}
ALCH.reqlvl = { alchemy = 15}
ALCH.gives = { coal = 1}
ALCH.xp = 45
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/coal_to_iron.png"
ALCH.title = "Coal to Iron"
ALCH.stitle = "Coal to Iron"
ALCH.uid = "coal2"
ALCH.description = "Transmute Coal into Iron Ore"
ALCH.cost = { coal = 1}
ALCH.reqlvl = { alchemy = 20}
ALCH.gives = { iron_ore = 3}
ALCH.xp = 75
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/coal_to_silver.png"
ALCH.title = "Coal to Silver Ore"
ALCH.stitle = "Coal to Silver Ore"
ALCH.uid = "silver1"
ALCH.description = "Transmute Coal into Silver Ore"
ALCH.cost = { coal = 5, burned_fish = 1}
ALCH.reqlvl = { alchemy = 25}
ALCH.gives = { silver_ore = 1}
ALCH.xp = 90
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/silver_to_coal.png"
ALCH.title = "Silver Ore to Coal"
ALCH.stitle = "Silver Ore to Coal"
ALCH.uid = "silver2"
ALCH.description = "Transmute Silver Ore into Coal"
ALCH.cost = { silver_ore = 1, burned_fish = 1}
ALCH.reqlvl = { alchemy = 30}
ALCH.gives = { coal = 3}
ALCH.xp = 125
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/silver_to_trinium.png"
ALCH.title = "Silver Ore to Trinium Ore"
ALCH.stitle = "Silver Ore to Trinium Ore"
ALCH.uid = "trinium1"
ALCH.description = "Transmute Silver Ore into Trinium Ore"
ALCH.cost = { silver_ore = 5, burned_fish = 1}
ALCH.reqlvl = { alchemy = 35}
ALCH.gives = { trinium_ore = 1}
ALCH.xp = 140
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/trinium_to_silver.png"
ALCH.title = "Trinium Ore to Silver Ore"
ALCH.stitle = "Trinium Ore to Silver Ore"
ALCH.uid = "trinium2"
ALCH.description = "Transmute Trinium Ore into Silver Ore"
ALCH.cost = { trinium_ore = 1, burned_fish = 1}
ALCH.reqlvl = { alchemy = 40}
ALCH.gives = { silver_ore = 3}
ALCH.xp = 180
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/trinium_to_naquadah.png"
ALCH.title = "Trinium Ore to Naquadah Ore"
ALCH.stitle = "Trinium Ore to Naquadah Ore"
ALCH.uid = "naquadah1"
ALCH.description = "Transmute Trinium Ore into Naquadah Ore"
ALCH.cost = { trinium_ore = 5, burned_fish = 1}
ALCH.reqlvl = { alchemy = 50}
ALCH.gives = { naquadah_ore = 1}
ALCH.xp = 200
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/naquadah_to_trinium.png"
ALCH.title = "Naquadah Ore to Trinium Ore"
ALCH.stitle = "Naquadah Ore to Trinium Ore"
ALCH.uid = "naquadah2"
ALCH.description = "Transmute Naquadah Ore to Trinium Ore"
ALCH.cost = { naquadah_ore = 1, burned_fish = 1}
ALCH.reqlvl = { alchemy = 55}
ALCH.gives = { trinium_ore = 3}
ALCH.xp = 300
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/naquadah_to_mithril.png"
ALCH.title = "Naquadah Ore to Mithril Ore"
ALCH.stitle = "Naquadah Ore to Mithril Ore"
ALCH.uid = "mithril1"
ALCH.description = "Transmute Naquadah Ore into Mithril Ore"
ALCH.cost = { naquadah_ore = 5, burned_fish = 1}
ALCH.reqlvl = { alchemy = 60}
ALCH.gives = { mithril_ore = 1}
ALCH.xp = 350
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/mithril_to_naquadah.png"
ALCH.title = "Mithril Ore to Naquadah Ore"
ALCH.stitle = "Mithril Ore to Naquadah Ore"
ALCH.uid = "mithril2"
ALCH.description = "Transmute Mithril Ore to Naquadah Ore"
ALCH.cost = { mithril_ore = 1, burned_fish = 1}
ALCH.reqlvl = { alchemy = 65}
ALCH.gives = { naquadah_ore = 3}
ALCH.xp = 425
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/mithril_to_platinum.png"
ALCH.title = "Mithril Ore to Platinum Ore"
ALCH.stitle = "Mithril Ore to Platinum Ore"
ALCH.uid = "platinum1"
ALCH.description = "Transmute Mithril Ore into Platinum Ore"
ALCH.cost = { mithril_ore = 5, burned_fish = 1}
ALCH.reqlvl = { alchemy = 68 }
ALCH.gives = { platinum_ore = 1}
ALCH.xp = 460
Menu_RegisterAlch( "ore transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/platinum_to_mithril.png"
ALCH.title = "Platinum Ore to Mithril Ore"
ALCH.stitle = "Platinum Ore to Mithril Ore"
ALCH.uid = "platinum2"
ALCH.description = "Transmute Platinum Ore to Mithril Ore"
ALCH.cost = { platinum_ore = 1, burned_fish = 1}
ALCH.reqlvl = { alchemy = 72}
ALCH.gives = { mithril_ore = 3}
ALCH.xp = 620
Menu_RegisterAlch( "ore transmute", ALCH )

//--Seed Transmutes--//


local ALCH = {}
ALCH.material = "vgui/transmute/pypa_to_guacca.png"
ALCH.title = "Pypa Seeds to Guacca Seed"
ALCH.stitle = "Pypa to Guacca"
ALCH.uid = "pypa1"
ALCH.description = "Transmute Pypa Seeds into Guacca Seeds"
ALCH.cost = { pypa_seed = 5}
ALCH.reqlvl = { alchemy = 5}
ALCH.gives = { guacca_seed = 1}
ALCH.xp = 25
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/guacca_to_arctus.png"
ALCH.title = "Guacca Seeds to Arctus Seed"
ALCH.stitle = "Guacca to Arctus"
ALCH.uid = "guacca1"
ALCH.description = "Transmute Guacca Seeds into Arctus Seed"
ALCH.cost = { guacca_seed = 5}
ALCH.reqlvl = { alchemy = 10}
ALCH.gives = { arctus_seed = 1}
ALCH.xp = 30
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/arctus_to_liechi.png"
ALCH.title = "Arctus Seeds to Liechi Seed"
ALCH.stitle = "Arctus to Liechi"
ALCH.uid = "arctus1"
ALCH.description = "Transmute Arctus Seeds into Liechi Seeds"
ALCH.cost = { arctus_seed = 5}
ALCH.reqlvl = { alchemy = 20}
ALCH.gives = { liechi_seed = 1}
ALCH.xp = 75
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/liechi_to_lum.png"
ALCH.title = "Liechi Seeds to Lum Seed"
ALCH.stitle = "Liechi to Lum"
ALCH.uid = "liechi1"
ALCH.description = "Transmute Liechi Seeds into Lum Seeds"
ALCH.cost = { liechi_seed = 5}
ALCH.reqlvl = { alchemy = 30}
ALCH.gives = { lum_seed = 1}
ALCH.xp = 125
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/lum_to_perriot.png"
ALCH.title = "Lum Seeds to Perriot Seed"
ALCH.stitle = "Lum to Perriot"
ALCH.uid = "lum1"
ALCH.description = "Transmute Lum Seeds into Perriot Seeds"
ALCH.cost = { lum_seed = 3}
ALCH.reqlvl = { alchemy = 50}
ALCH.gives = { perriot_seed = 1}
ALCH.xp = 225
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/perriot_to_pallie.png"
ALCH.title = "Perriot Seeds to Pallie Seed"
ALCH.stitle = "Perriot to Pallie"
ALCH.uid = "perriot1"
ALCH.description = "Transmute Perriot Seeds into Pallie Seeds"
ALCH.cost = { perriot_seed = 3}
ALCH.reqlvl = { alchemy = 54}
ALCH.gives = { pallie_seed = 1}
ALCH.xp = 260
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/pallie_to_moly.png"
ALCH.title = "Pallie Seeds to Moly Seed"
ALCH.stitle = "Pallie to Moly"
ALCH.uid = "pallie1"
ALCH.description = "Transmute Pallie Seeds into Moly Seeds"
ALCH.cost = { pallie_seed = 3}
ALCH.reqlvl = { alchemy = 63}
ALCH.gives = { moly_seed = 1}
ALCH.xp = 350
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/moly_to_karopa.png"
ALCH.title = "Moly Seeds to Karopa Seed"
ALCH.stitle = "Moly to Karopa"
ALCH.uid = "moly1"
ALCH.description = "Transmute Moly Seeds into Karopa Seeds"
ALCH.cost = { moly_seed = 3}
ALCH.reqlvl = { alchemy = 68}
ALCH.gives = { karopa_seed = 1}
ALCH.xp = 418
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/normal_to_oak.png"
ALCH.title = "Tree Seeds to Oak Seed"
ALCH.stitle = "Tree to Oak"
ALCH.uid = "tree1"
ALCH.description = "Transmute Tree Seeds into Oak Seeds"
ALCH.cost = { tree_seed = 3}
ALCH.reqlvl = { alchemy = 10}
ALCH.gives = { oak_seed = 1}
ALCH.xp = 30
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/oak_to_maple.png"
ALCH.title = "Oak Seeds to Maple Seed"
ALCH.stitle = "Oak to Maple"
ALCH.uid = "oak1"
ALCH.description = "Transmute Oak Seeds into Maple Seeds"
ALCH.cost = { oak_seed = 3}
ALCH.reqlvl = { alchemy = 25}
ALCH.gives = { maple_seed = 1}
ALCH.xp = 110
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/maple_to_pine.png"
ALCH.title = "Maple Seeds to Pine Seed"
ALCH.stitle = "Maple to Pine"
ALCH.uid = "maple1"
ALCH.description = "Transmute Maple Seeds into Pine Seeds"
ALCH.cost = { maple_seed = 3}
ALCH.reqlvl = { alchemy = 40}
ALCH.gives = { pine_seed = 1}
ALCH.xp = 160
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/pine_to_yew.png"
ALCH.title = "Pine Seeds to Yew Seed"
ALCH.stitle = "Pine to Yew"
ALCH.uid = "pine1"
ALCH.description = "Transmute Pine Seeds into Yew Seeds"
ALCH.cost = { pine_seed = 3}
ALCH.reqlvl = { alchemy = 58}
ALCH.gives = { yew_seed = 1}
ALCH.xp = 340
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/yew_to_buckeye.png"
ALCH.title = "Yew Seeds to Buckeye Seed"
ALCH.stitle = "Yew to Buckeye"
ALCH.uid = "yew1"
ALCH.description = "Transmute Yew Seeds into Buckeye Seeds"
ALCH.cost = { yew_seed = 3}
ALCH.reqlvl = { alchemy = 65}
ALCH.gives = { buckeye_seed = 1}
ALCH.xp = 500
Menu_RegisterAlch( "seed transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/buckeye_to_palm.png"
ALCH.title = "Buckeye Seeds to Palm Seed"
ALCH.stitle = "Buckeye to Palm"
ALCH.uid = "buckeye1"
ALCH.description = "Transmute Buckeye Seeds into Palm Seeds"
ALCH.cost = { buckeye_seed = 3}
ALCH.reqlvl = { alchemy = 71}
ALCH.gives = { palm_seed = 1}
ALCH.xp = 610
Menu_RegisterAlch( "seed transmute", ALCH )

//--Gem Transmutes--//


local ALCH = {}
ALCH.material = "vgui/gems/sapphire_new.png"
ALCH.title = "Transmute Sapphire"
ALCH.stitle = "Sapphire"
ALCH.uid = "sapphire1"
ALCH.description = "Create a Sapphire"
ALCH.cost = { iron = 50, wood = 30}
ALCH.reqlvl = { alchemy = 10}
ALCH.gives = { sapphire = 1}
ALCH.xp = 30
Menu_RegisterAlch( "gem transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/gems/emerald_new.png"
ALCH.title = "Transmute Emerald"
ALCH.stitle = "Emerald"
ALCH.uid = "emerald1"
ALCH.description = "Create an Emerald"
ALCH.cost = { steel = 50, oak_wood = 30}
ALCH.reqlvl = { alchemy = 20}
ALCH.gives = { emerald = 1}
ALCH.xp = 70
Menu_RegisterAlch( "gem transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/gems/ruby_new.png"
ALCH.title = "Transmute Ruby"
ALCH.stitle = "Ruby"
ALCH.uid = "ruby1"
ALCH.description = "Create a Ruby"
ALCH.cost = { silver = 50, maple_wood = 30}
ALCH.reqlvl = { alchemy = 30}
ALCH.gives = { ruby = 1}
ALCH.xp = 110
Menu_RegisterAlch( "gem transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/gems/diamond_new.png"
ALCH.title = "Transmute Diamond"
ALCH.stitle = "Diamond"
ALCH.uid = "diamond1"
ALCH.description = "Create a Diamond"
ALCH.cost = { trinium = 50, pine_wood = 30}
ALCH.reqlvl = { alchemy = 40}
ALCH.gives = { diamond = 1}
ALCH.xp = 180
Menu_RegisterAlch( "gem transmute", ALCH )

local ALCH = {}
ALCH.material = "vgui/gems/prismatic_new.png"
ALCH.title = "Transmute Prismatic Gem"
ALCH.stitle = "Prismatic Gem"
ALCH.uid = "prismatic1"
ALCH.description = "Create a Prismatic Gem"
ALCH.cost = { sapphire = 2, emerald = 2, ruby = 2, diamond = 2}
ALCH.reqlvl = { alchemy = 50}
ALCH.gives = { prismatic_gem = 1}
ALCH.xp = 300
Menu_RegisterAlch( "gem transmute", ALCH )


//--Enchant Transmutes--//


local ALCH = {}
ALCH.material = "vgui/transmute/enchanted_pick_head.png"
ALCH.title = "Enchanted Pickhead"
ALCH.stitle = "Enchanted Pickhead"
ALCH.uid = "enchpick1"
ALCH.description = "Creates an enchanted pickaxe head for use in enchanted smithing"
ALCH.cost = { enchanted_metal = 12, mining_relic_3 = 5}
ALCH.reqlvl = { alchemy = 45}
ALCH.gives = { enchanted_pickhead = 1}
ALCH.xp = 650
Menu_RegisterAlch( "enchanted tools", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/enchanted_hatchet_head.png"
ALCH.title = "Enchanted Axehead"
ALCH.stitle = "Enchanted Axehead"
ALCH.uid = "enchaxe1"
ALCH.description = "Creates an enchanted Hatchet head for use in enchanted smithing"
ALCH.cost = { enchanted_metal = 12, woodcutting_relic_3 = 5}
ALCH.reqlvl = { alchemy = 45}
ALCH.gives = { enchanted_axehead = 1}
ALCH.xp = 650
Menu_RegisterAlch( "enchanted tools", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/enchanted_rod_reel.png"
ALCH.title = "Enchanted Reel"
ALCH.stitle = "Enchanted Reel"
ALCH.uid = "enchrod1"
ALCH.description = "Creates an enchanted Reel for use in enchanted smithing"
ALCH.cost = { enchanted_metal = 12, fishing_relic_3 = 5}
ALCH.reqlvl = { alchemy = 45}
ALCH.gives = { enchanted_reel = 1}
ALCH.xp = 650
Menu_RegisterAlch( "enchanted tools", ALCH )

local ALCH = {}
ALCH.material = "vgui/transmute/enchanted_hoe_blade.png"
ALCH.title = "Enchanted Hoe Blade"
ALCH.stitle = "Enchanted Hoe Blade"
ALCH.uid = "enchhoe1"
ALCH.description = "Creates an enchanted Hoe Blade for use in enchanted smithing"
ALCH.cost = { enchanted_metal = 12, farming_relic_3 = 5}
ALCH.reqlvl = { alchemy = 45}
ALCH.gives = { enchanted_hoe_blade = 1}
ALCH.xp = 650
Menu_RegisterAlch( "enchanted tools", ALCH )

//--Other Transmutes--//

local ALCH = {}
ALCH.material = "gui/SGS/test1.vmt"
ALCH.title = "Stable Core"
ALCH.stitle = "Stable Inter-Dimensional Core"
ALCH.uid = "core1"
ALCH.description = "Creates a Stable Inter-Dimensional Core"
ALCH.cost = { inter_dimensional_core = 1, diamond = 1, enchanted_metal = 1}
ALCH.reqlvl = { alchemy = 55}
ALCH.gives = { stable_core = 1}
ALCH.xp = 2000
Menu_RegisterAlch( "miscellaneous", ALCH )

local ALCH = {}
ALCH.material = "vgui/relic_png_png.png"
ALCH.title = "Identify Artifact"
ALCH.stitle = "Identify Artifact"
ALCH.uid = "artifact1"
ALCH.description = "Identifies an Unidentified Artifact from your inventory"
ALCH.cost = { burned_pie = 1, unidentified_artifact = 1}
ALCH.reqlvl = { alchemy = 50}
ALCH.gives = { burned_pie = 1, unidentified_artifact = 1}
ALCH.xp = 900
Menu_RegisterAlch( "miscellaneous", ALCH )