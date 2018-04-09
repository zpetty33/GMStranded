SGS.Grind = {}
function Menu_RegisterGrind( category, recipe )
	if not SGS.Grind[category] then SGS.Grind[category] = {} end
	SGS.Grind[category][#SGS.Grind[category] + 1] = recipe
end

//--Ore Grinding--//


RECIPE = {}
RECIPE.material = "vgui/powder/StonePowder.png"
RECIPE.title = "Grind Stone"
RECIPE.stitle = "Stone Powder"
RECIPE.uid = "stone1"
RECIPE.description = "Grind Stone"
RECIPE.cost = { stone = 1}
RECIPE.reqlvl = { smithing = 1}
RECIPE.gives = { stone_powder = 1}
RECIPE.xp = 5
Menu_RegisterGrind( "ore grinding", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/StonePowderx5.png"
RECIPE.title = "Grind Stone x5"
RECIPE.stitle = "Stone Powder x5"
RECIPE.uid = "stone15"
RECIPE.description = "Grind Stone x5"
RECIPE.cost = { stone = 5}
RECIPE.reqlvl = { smithing = 1}
RECIPE.gives = { stone_powder = 5}
RECIPE.xp = 20
Menu_RegisterGrind( "ore grinding - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/IronPowder.png"
RECIPE.title = "Grind Iron"
RECIPE.stitle = "Iron Powder"
RECIPE.uid = "iron1"
RECIPE.description = "Grind Iron"
RECIPE.cost = { iron_ore = 1}
RECIPE.reqlvl = { smithing = 5}
RECIPE.gives = { iron_powder = 1}
RECIPE.xp = 15
Menu_RegisterGrind( "ore grinding", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/IronPowderx5.png"
RECIPE.title = "Grind Iron x5"
RECIPE.stitle = "Iron Powder x5"
RECIPE.uid = "iron15"
RECIPE.description = "Grind Iron x5"
RECIPE.cost = { iron_ore = 5}
RECIPE.reqlvl = { smithing = 5}
RECIPE.gives = { iron_powder = 5}
RECIPE.xp = 60
Menu_RegisterGrind( "ore grinding - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/CoalPowder.png"
RECIPE.title = "Grind Coal"
RECIPE.stitle = "Coal Powder"
RECIPE.uid = "coal1"
RECIPE.description = "Grind Coal"
RECIPE.cost = { coal = 1}
RECIPE.reqlvl = { smithing = 15}
RECIPE.gives = { coal_powder = 1}
RECIPE.xp = 30
Menu_RegisterGrind( "ore grinding", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/CoalPowderx5.png"
RECIPE.title = "Grind Coal x5"
RECIPE.stitle = "Coal Powder x5"
RECIPE.uid = "coal15"
RECIPE.description = "Grind Coal x5"
RECIPE.cost = { coal = 5}
RECIPE.reqlvl = { smithing = 15}
RECIPE.gives = { coal_powder = 5}
RECIPE.xp = 120
Menu_RegisterGrind( "ore grinding - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/SilverPowder.png"
RECIPE.title = "Grind Silver"
RECIPE.stitle = "Silver Powder"
RECIPE.uid = "silver1"
RECIPE.description = "Grind Silver"
RECIPE.cost = { silver_ore = 1}
RECIPE.reqlvl = { smithing = 25}
RECIPE.gives = { silver_powder = 1}
RECIPE.xp = 45
Menu_RegisterGrind( "ore grinding", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/SilverPowderx5.png"
RECIPE.title = "Grind Silver x5"
RECIPE.stitle = "Silver Powder x5"
RECIPE.uid = "silver15"
RECIPE.description = "Grind Silver x5"
RECIPE.cost = { silver_ore = 5}
RECIPE.reqlvl = { smithing = 25}
RECIPE.gives = { silver_powder = 5}
RECIPE.xp = 180
Menu_RegisterGrind( "ore grinding - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/TriniumPowder.png"
RECIPE.title = "Grind Trinium"
RECIPE.stitle = "Trinium Powder"
RECIPE.uid = "trinium1"
RECIPE.description = "Grind Trinium"
RECIPE.cost = { trinium_ore = 1}
RECIPE.reqlvl = { smithing = 40}
RECIPE.gives = { trinium_powder = 1}
RECIPE.xp = 60
Menu_RegisterGrind( "ore grinding", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/TriniumPowderx5.png"
RECIPE.title = "Grind Trinium x5"
RECIPE.stitle = "Trinium Powder x5"
RECIPE.uid = "trinium15"
RECIPE.description = "Grind Trinium x5"
RECIPE.cost = { trinium_ore = 5}
RECIPE.reqlvl = { smithing = 40}
RECIPE.gives = { trinium_powder = 5}
RECIPE.xp = 240
Menu_RegisterGrind( "ore grinding - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/NaquadahPowder.png"
RECIPE.title = "Grind Naquadah"
RECIPE.stitle = "Naquadah Powder"
RECIPE.uid = "naquadah1"
RECIPE.description = "Grind Naquadah"
RECIPE.cost = { naquadah_ore = 1}
RECIPE.reqlvl = { smithing = 55}
RECIPE.gives = { naquadah_powder = 1}
RECIPE.xp = 130
Menu_RegisterGrind( "ore grinding", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/NaquadahPowderx5.png"
RECIPE.title = "Grind Naquadah x5"
RECIPE.stitle = "Naquadah Powder x5"
RECIPE.uid = "naquadah15"
RECIPE.description = "Grind Naquadah x5"
RECIPE.cost = { naquadah_ore = 5}
RECIPE.reqlvl = { smithing = 55}
RECIPE.gives = { naquadah_powder = 5}
RECIPE.xp = 520
Menu_RegisterGrind( "ore grinding - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/MithrilPowder.png"
RECIPE.title = "Grind Mithril"
RECIPE.stitle = "Mithril Powder"
RECIPE.uid = "mithril1"
RECIPE.description = "Grind Mithril"
RECIPE.cost = { mithril_ore = 1}
RECIPE.reqlvl = { smithing = 60}
RECIPE.gives = { mithril_powder = 1}
RECIPE.xp = 180
Menu_RegisterGrind( "ore grinding", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/MithrilPowderx5.png"
RECIPE.title = "Grind Mithril x5"
RECIPE.stitle = "Mithril Powder x5"
RECIPE.uid = "mithril15"
RECIPE.description = "Grind Mithril x5"
RECIPE.cost = { mithril_ore = 5}
RECIPE.reqlvl = { smithing = 60}
RECIPE.gives = { mithril_powder = 5}
RECIPE.xp = 720
Menu_RegisterGrind( "ore grinding - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/GoldPowder.png"
RECIPE.title = "Grind Gold"
RECIPE.stitle = "Gold Powder"
RECIPE.uid = "gold1"
RECIPE.description = "Grind Gold"
RECIPE.cost = { gold_ore = 1}
RECIPE.reqlvl = { smithing = 60}
RECIPE.gives = { gold_powder = 1}
RECIPE.xp = 180
Menu_RegisterGrind( "ore grinding", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/GoldPowderx5.png"
RECIPE.title = "Grind Gold x5"
RECIPE.stitle = "Gold Powder x5"
RECIPE.uid = "gold15"
RECIPE.description = "Grind Gold x5"
RECIPE.cost = { gold_ore = 5}
RECIPE.reqlvl = { smithing = 60}
RECIPE.gives = { gold_powder = 5}
RECIPE.xp = 720
Menu_RegisterGrind( "ore grinding - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/PlatinumPowder.png"
RECIPE.title = "Grind Platinum"
RECIPE.stitle = "Platinum Powder"
RECIPE.uid = "platinum1"
RECIPE.description = "Grind Platinum"
RECIPE.cost = { platinum_ore = 1}
RECIPE.reqlvl = { smithing = 70}
RECIPE.gives = { platinum_powder = 1}
RECIPE.xp = 260
Menu_RegisterGrind( "ore grinding", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/powder/PlatinumPowderx5.png"
RECIPE.title = "Grind Platinum x5"
RECIPE.stitle = "Platinum Powder x5"
RECIPE.uid = "platinum15"
RECIPE.description = "Grind Platinum x5"
RECIPE.cost = { platinum_ore = 5}
RECIPE.reqlvl = { smithing = 70}
RECIPE.gives = { platinum_powder = 5}
RECIPE.xp = 1040
Menu_RegisterGrind( "ore grinding - 5x", RECIPE )