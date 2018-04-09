SGS.Smelting = {}
function Shop_RegisterSmelting( category, recipe )
	if not SGS.Smelting[category] then SGS.Smelting[category] = {} end
	SGS.Smelting[category][#SGS.Smelting[category] + 1] = recipe
end


//--Misc--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/wood2coal_x1.png"
RECIPE.title = "Wood to Coal"
RECIPE.uid = "misc11"
RECIPE.description = "Turns wood into coal"
RECIPE.cost = { wood = 5}
RECIPE.reqlvl = { smithing = 25}
RECIPE.gives = { coal = 1}
RECIPE.xp = 30
Shop_RegisterSmelting( "misc", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/wood2coal_x5.png"
RECIPE.title = "Wood to Coal (x5)"
RECIPE.uid = "misc12"
RECIPE.description = "Turns wood into coal"
RECIPE.cost = { wood = 25}
RECIPE.reqlvl = { smithing = 25}
RECIPE.gives = { coal = 5}
RECIPE.xp = 130
Shop_RegisterSmelting( "misc", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/wood2coal_x10.png"
RECIPE.title = "Wood to Coal (x10)"
RECIPE.uid = "misc13"
RECIPE.description = "Turns wood into coal"
RECIPE.cost = { wood = 50}
RECIPE.reqlvl = { smithing = 25}
RECIPE.gives = { coal = 10}
RECIPE.xp = 250
Shop_RegisterSmelting( "misc", RECIPE )


//--Iron--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/iron_x1.png"
RECIPE.title = "Iron"
RECIPE.uid = "iron1"
RECIPE.description = "Smelts Iron Ore into something more useful"
RECIPE.cost = { iron_ore = 1}
RECIPE.reqlvl = { smithing = 5}
RECIPE.gives = { iron = 1}
RECIPE.xp = 10
Shop_RegisterSmelting( "iron", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/iron_x5.png"
RECIPE.title = "Iron x5"
RECIPE.uid = "iron2"
RECIPE.description = "Smelts Iron Ore into something more useful"
RECIPE.cost = { iron_ore = 5}
RECIPE.reqlvl = { smithing = 5}
RECIPE.gives = { iron = 5}
RECIPE.xp = 45
Shop_RegisterSmelting( "iron", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/iron_x10.png"
RECIPE.title = "Iron x10"
RECIPE.uid = "iron3"
RECIPE.description = "Smelts Iron Ore into something more useful"
RECIPE.cost = { iron_ore = 10}
RECIPE.reqlvl = { smithing = 5}
RECIPE.gives = { iron = 10}
RECIPE.xp = 90
Shop_RegisterSmelting( "iron", RECIPE )

//--Steel--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/steel_x1.png"
RECIPE.title = "Steel"
RECIPE.uid = "steel1"
RECIPE.description = "Smelts Iron and Coal into the tougher steel resource"
RECIPE.cost = { iron_ore = 1, coal = 2}
RECIPE.reqlvl = { smithing = 15}
RECIPE.gives = { steel = 1 }
RECIPE.xp = 20
Shop_RegisterSmelting( "steel", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/steel_x5.png"
RECIPE.title = "Steel x5"
RECIPE.uid = "steel2"
RECIPE.description = "Smelts Iron and Coal into the tougher steel resource"
RECIPE.cost = { iron_ore = 5, coal = 10}
RECIPE.reqlvl = { smithing = 15}
RECIPE.gives = { steel = 5 }
RECIPE.xp = 90
Shop_RegisterSmelting( "steel", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/steel_x10.png"
RECIPE.title = "Steel x10"
RECIPE.uid = "steel3"
RECIPE.description = "Smelts Iron and Coal into the tougher steel resource"
RECIPE.cost = { iron_ore = 10, coal = 20}
RECIPE.reqlvl = { smithing = 15}
RECIPE.gives = { steel = 10 }
RECIPE.xp = 180
Shop_RegisterSmelting( "steel", RECIPE )

//--Silver--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/silver_x1.png"
RECIPE.title = "Silver"
RECIPE.uid = "silver1"
RECIPE.description = "Smelts Silver Ore and Coal into Silver"
RECIPE.cost = { silver_ore = 1, coal = 4}
RECIPE.reqlvl = { smithing = 25}
RECIPE.gives = { silver = 1 }
RECIPE.xp = 30
Shop_RegisterSmelting( "silver", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/silver_x5.png"
RECIPE.title = "Silver x5"
RECIPE.uid = "silver2"
RECIPE.description = "Smelts Silver Ore and Coal into Silver"
RECIPE.cost = { silver_ore = 5, coal = 20}
RECIPE.reqlvl = { smithing = 25}
RECIPE.gives = { silver = 5 }
RECIPE.xp = 140
Shop_RegisterSmelting( "silver", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/silver_x10.png"
RECIPE.title = "Silver x10"
RECIPE.uid = "silver3"
RECIPE.description = "Smelts Silver Ore and Coal into Silver"
RECIPE.cost = { silver_ore = 10, coal = 40}
RECIPE.reqlvl = { smithing = 25}
RECIPE.gives = { silver = 10 }
RECIPE.xp = 275
Shop_RegisterSmelting( "silver", RECIPE )

//--Trinium--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/trin_x1.png"
RECIPE.title = "Trinium"
RECIPE.uid = "trinium1"
RECIPE.description = "Smelts Trinium Ore and Coal into Trinium"
RECIPE.cost = { trinium_ore = 1, coal = 6}
RECIPE.reqlvl = { smithing = 40}
RECIPE.gives = { trinium = 1 }
RECIPE.xp = 50
Shop_RegisterSmelting( "trinium", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/trin_x5.png"
RECIPE.title = "Trinium x5"
RECIPE.uid = "trinium2"
RECIPE.description = "Smelts Trinium Ore and Coal into Trinium"
RECIPE.cost = { trinium_ore = 5, coal = 30}
RECIPE.reqlvl = { smithing = 40}
RECIPE.gives = { trinium = 5 }
RECIPE.xp = 230
Shop_RegisterSmelting( "trinium", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/trin_x10.png"
RECIPE.title = "Trinium x10"
RECIPE.uid = "trinium3"
RECIPE.description = "Smelts Trinium Ore and Coal into Trinium"
RECIPE.cost = { trinium_ore = 10, coal = 60}
RECIPE.reqlvl = { smithing = 40}
RECIPE.gives = { trinium = 10 }
RECIPE.xp = 450
Shop_RegisterSmelting( "trinium", RECIPE )


//--Naquadah--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/naq_x1.png"
RECIPE.title = "Naquadah"
RECIPE.uid = "naquadah1"
RECIPE.description = "Smelts Naquadah Ore and Coal into Naquadah"
RECIPE.cost = { naquadah_ore = 1, coal = 8}
RECIPE.reqlvl = { smithing = 53}
RECIPE.gives = { naquadah = 1 }
RECIPE.xp = 110
Shop_RegisterSmelting( "naquadah", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/naq_x5.png"
RECIPE.title = "Naquadah x5"
RECIPE.uid = "naquadah2"
RECIPE.description = "Smelts Naquadah Ore and Coal into Naquadah"
RECIPE.cost = { naquadah_ore = 5, coal = 40}
RECIPE.reqlvl = { smithing = 53}
RECIPE.gives = { naquadah = 5 }
RECIPE.xp = 460
Shop_RegisterSmelting( "naquadah", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/naq_x10.png"
RECIPE.title = "Naquadah x10"
RECIPE.uid = "naquadah3"
RECIPE.description = "Smelts Naquadah Ore and Coal into Naquadah"
RECIPE.cost = { naquadah_ore = 10, coal = 80}
RECIPE.reqlvl = { smithing = 53}
RECIPE.gives = { naquadah = 10 }
RECIPE.xp = 850
Shop_RegisterSmelting( "naquadah", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/reinnaq_x1.png"
RECIPE.title = "Reinforced Naquadah"
RECIPE.uid = "naquadah4"
RECIPE.description = "Combines Naquadah and Trinium to make\nReinforced Naquadah"
RECIPE.cost = { naquadah = 1, trinium = 10}
RECIPE.reqlvl = { smithing = 55}
RECIPE.gives = { reinforced_naquadah = 1 }
RECIPE.xp = 1000
Shop_RegisterSmelting( "naquadah", RECIPE )

//--Mithril--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/mith_x1.png"
RECIPE.title = "Mithril"
RECIPE.uid = "mithril1"
RECIPE.description = "Smelts Mithril Ore and Coal into Mithril"
RECIPE.cost = { mithril_ore = 1, coal = 10}
RECIPE.reqlvl = { smithing = 65}
RECIPE.gives = { mithril = 1 }
RECIPE.xp = 160
Shop_RegisterSmelting( "mithril", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/mith_x5.png"
RECIPE.title = "Mithril x5"
RECIPE.uid = "mithril2"
RECIPE.description = "Smelts Mithril Ore and Coal into Mithril"
RECIPE.cost = { mithril_ore = 5, coal = 50}
RECIPE.reqlvl = { smithing = 65}
RECIPE.gives = { mithril = 5 }
RECIPE.xp = 700
Shop_RegisterSmelting( "mithril", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/mith_x10.png"
RECIPE.title = "Mithril x10"
RECIPE.uid = "mithril3"
RECIPE.description = "Smelts Mithril Ore and Coal into Mithril"
RECIPE.cost = { mithril_ore = 10, coal = 100}
RECIPE.reqlvl = { smithing = 65}
RECIPE.gives = { mithril = 10 }
RECIPE.xp = 1300
Shop_RegisterSmelting( "mithril", RECIPE )

//--Gold--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/gold_x1.png"
RECIPE.title = "Gold"
RECIPE.uid = "gold1"
RECIPE.description = "Smelts Gold Ore and Coal into Gold"
RECIPE.cost = { gold_ore = 1, coal = 2}
RECIPE.reqlvl = { smithing = 65}
RECIPE.gives = { gold = 1 }
RECIPE.xp = 160
Shop_RegisterSmelting( "gold", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/gold_x5.png"
RECIPE.title = "Gold x5"
RECIPE.uid = "gold2"
RECIPE.description = "Smelts Gold Ore and Coal into Gold"
RECIPE.cost = { gold_ore = 5, coal = 10}
RECIPE.reqlvl = { smithing = 65}
RECIPE.gives = { gold = 5 }
RECIPE.xp = 700
Shop_RegisterSmelting( "gold", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/gold_x10.png"
RECIPE.title = "Gold x10"
RECIPE.uid = "gold3"
RECIPE.description = "Smelts Gold Ore and Coal into Gold"
RECIPE.cost = { gold_ore = 10, coal = 20}
RECIPE.reqlvl = { smithing = 65}
RECIPE.gives = { gold = 10 }
RECIPE.xp = 1300
Shop_RegisterSmelting( "gold", RECIPE )

//--Platinum--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/silver_x1.png"
RECIPE.title = "Platinum"
RECIPE.uid = "platinum1"
RECIPE.description = "Smelts Platinum Ore and Coal into Platinum"
RECIPE.cost = { platinum_ore = 1, coal = 12}
RECIPE.reqlvl = { smithing = 71}
RECIPE.gives = { platinum = 1 }
RECIPE.xp = 210
Shop_RegisterSmelting( "platinum", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/silver_x5.png"
RECIPE.title = "Platinum x5"
RECIPE.uid = "platinum2"
RECIPE.description = "Smelts Platinum Ore and Coal into Platinum"
RECIPE.cost = { platinum_ore = 5, coal = 60}
RECIPE.reqlvl = { smithing = 71}
RECIPE.gives = { platinum = 5 }
RECIPE.xp = 1000
Shop_RegisterSmelting( "platinum", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/silver_x10.png"
RECIPE.title = "Platinum x10"
RECIPE.uid = "platinum3"
RECIPE.description = "Smelts Platinum Ore and Coal into Platinum"
RECIPE.cost = { platinum_ore = 10, coal = 120}
RECIPE.reqlvl = { smithing = 71}
RECIPE.gives = { platinum = 10 }
RECIPE.xp = 1800
Shop_RegisterSmelting( "platinum", RECIPE )

//--Meteoric--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/meteoriciron.png"
RECIPE.title = "Meteoric Iron"
RECIPE.uid = "meteoriciron1"
RECIPE.description = "Smelts Meteoric Iron Ore and Coal into Meteoric Iron"
RECIPE.cost = { meteoric_iron_ore = 1, coal = 30}
RECIPE.reqlvl = { smithing = 65}
RECIPE.gives = { meteoric_iron = 1 }
RECIPE.xp = 450
Shop_RegisterSmelting( "meteoric", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/refinedmeteoriciron.png"
RECIPE.title = "Refined Meteoric Iron"
RECIPE.uid = "meteoriciron2"
RECIPE.description = "Refines Meteoric Iron and Enchanted Metal together."
RECIPE.cost = { meteoric_iron_ore = 4, enchanted_metal = 2}
RECIPE.reqlvl = { smithing = 75}
RECIPE.gives = { refined_meteoric_iron = 1 }
RECIPE.xp = 1200
Shop_RegisterSmelting( "meteoric", RECIPE )

//--Construction--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/metal_x5.png"
RECIPE.title = "Metal x5"
RECIPE.uid = "construction1"
RECIPE.description = "Converts Iron into a metal usable in constructing props"
RECIPE.cost = { iron = 1}
RECIPE.reqlvl = { smithing = 5}
RECIPE.gives = { metal = 5 }
RECIPE.xp = 10
Shop_RegisterSmelting( "construction", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/metal_x25.png"
RECIPE.title = "Metal x25"
RECIPE.uid = "construction2"
RECIPE.description = "Converts Iron into a metal usable in constructing props"
RECIPE.cost = { iron = 5}
RECIPE.reqlvl = { smithing = 5}
RECIPE.gives = { metal = 25 }
RECIPE.xp = 45
Shop_RegisterSmelting( "construction", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/glass_x1.png"
RECIPE.title = "Glass"
RECIPE.uid = "construction3"
RECIPE.description = "Melt sand into glass for use in construction"
RECIPE.cost = { sand = 2}
RECIPE.reqlvl = { smithing = 10}
RECIPE.gives = { glass = 1 }
RECIPE.xp = 20
Shop_RegisterSmelting( "construction", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/glass_x5.png"
RECIPE.title = "Glass x5"
RECIPE.uid = "construction4"
RECIPE.description = "Melt sand into glass for use in construction"
RECIPE.cost = { sand = 10}
RECIPE.reqlvl = { smithing = 10}
RECIPE.gives = { glass = 5 }
RECIPE.xp = 50
Shop_RegisterSmelting( "construction", RECIPE )

//--Alchemy--//

RECIPE = {}
RECIPE.material = "vgui/furnace/new/vial.png"
RECIPE.title = "Glass Vial"
RECIPE.uid = "alchemy1"
RECIPE.description = "Creates a glass vial used in potion brewing"
RECIPE.cost = { glass = 2}
RECIPE.reqlvl = { smithing = 1}
RECIPE.gives = { vial = 1 }
RECIPE.xp = 10
Shop_RegisterSmelting( "alchemy", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/flask.png"
RECIPE.title = "Glass Flask"
RECIPE.uid = "alchemy2"
RECIPE.description = "Creates a glass flask used in potion brewing"
RECIPE.cost = { glass = 5, stone = 2}
RECIPE.reqlvl = { smithing = 12}
RECIPE.gives = { flask = 1 }
RECIPE.xp = 60
Shop_RegisterSmelting( "alchemy", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/heavy_flask.png"
RECIPE.title = "Heavy Glass Flask"
RECIPE.uid = "alchemy3"
RECIPE.description = "Creates a heavy glass flask used in potion brewing"
RECIPE.cost = { glass = 5, iron_ore = 2}
RECIPE.reqlvl = { smithing = 25}
RECIPE.gives = { heavy_flask = 1 }
RECIPE.xp = 120
Shop_RegisterSmelting( "alchemy", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/furnace/new/imbued_flask.png"
RECIPE.title = "Imbued Glass Flask"
RECIPE.uid = "alchemy4"
RECIPE.description = "Creates an imbued glass flask used in potion brewing"
RECIPE.cost = { glass = 5, silver_ore = 2}
RECIPE.reqlvl = { smithing = 36}
RECIPE.gives = { imbued_flask = 1 }
RECIPE.xp = 160
Shop_RegisterSmelting( "alchemy", RECIPE )