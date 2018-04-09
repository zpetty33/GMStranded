SGS.MagicForge = {}
function Menu_RegisterForge( category, recipe )
	if not SGS.MagicForge[category] then SGS.MagicForge[category] = {} end
	
	SGS.MagicForge[category][#SGS.MagicForge[category] + 1] = recipe
end


RECIPE = {}
RECIPE.material = "vgui/stones/RuneWind2.png"
RECIPE.title = "Forge Wind Stone"
RECIPE.stitle = "Wind Stone"
RECIPE.uid = "forge1"
RECIPE.description = "Imbues airy magical properties into an inert stone."
RECIPE.cost = { inert_stone = 1, stone_powder = 1}
RECIPE.reqlvl = { arcane = 1}
RECIPE.spclvl = { double = 15, triple = 30}
RECIPE.gives = { wind_stone = 1}
RECIPE.xp = 6
Menu_RegisterForge( "1. stone forging", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneWater2.png"
RECIPE.title = "Forge Water Stone"
RECIPE.stitle = "Water Stone"
RECIPE.uid = "forge2"
RECIPE.description = "Imbues watery magical properties into an inert stone."
RECIPE.cost = { inert_stone = 1, stone_powder = 2}
RECIPE.reqlvl = { arcane = 10}
RECIPE.spclvl = { double = 25, triple = 35}
RECIPE.gives = { water_stone = 1}
RECIPE.xp = 20
Menu_RegisterForge( "1. stone forging", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneEarth2.png"
RECIPE.title = "Forge Earth Stone"
RECIPE.stitle = "Earth Stone"
RECIPE.uid = "forge3"
RECIPE.description = "Imbues rocky magical properties into an inert stone."
RECIPE.cost = { inert_stone = 1, iron_powder = 1}
RECIPE.reqlvl = { arcane = 15}
RECIPE.spclvl = { double = 35, triple = 45}
RECIPE.gives = { earth_stone = 1}
RECIPE.xp = 25
Menu_RegisterForge( "1. stone forging", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneFire2.png"
RECIPE.title = "Forge Fire Stone"
RECIPE.stitle = "Fire Stone"
RECIPE.uid = "forge4"
RECIPE.description = "Imbues fiery magical properties into an inert stone."
RECIPE.cost = { inert_stone = 1, coal_powder = 1}
RECIPE.reqlvl = { arcane = 20}
RECIPE.spclvl = { double = 40, triple = 50}
RECIPE.gives = { fire_stone = 1}
RECIPE.xp = 30
Menu_RegisterForge( "1. stone forging", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneChaos2.png"
RECIPE.title = "Forge Chaos Stone"
RECIPE.stitle = "Chaos Stone"
RECIPE.uid = "forge5"
RECIPE.description = "Imbues chaotic magical properties into an inert stone."
RECIPE.cost = { inert_stone = 1, silver_powder = 1}
RECIPE.reqlvl = { arcane = 30}
RECIPE.spclvl = { double = 45, triple = 60}
RECIPE.gives = { chaos_stone = 1}
RECIPE.xp = 40
Menu_RegisterForge( "1. stone forging", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneNature2.png"
RECIPE.title = "Forge Nature Stone"
RECIPE.stitle = "Nature Stone"
RECIPE.uid = "forge6"
RECIPE.description = "Imbues natural magical properties into an inert stone."
RECIPE.cost = { inert_stone = 1, trinium_powder = 1}
RECIPE.reqlvl = { arcane = 40}
RECIPE.gives = { nature_stone = 1}
RECIPE.spclvl = { double = 55, triple = 65}
RECIPE.xp = 50
Menu_RegisterForge( "1. stone forging", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneCosmic2.png"
RECIPE.title = "Forge Cosmic Stone"
RECIPE.stitle = "Cosmic Stone"
RECIPE.uid = "forge7"
RECIPE.description = "Imbues cosmic magical properties into an inert stone."
RECIPE.cost = { inert_stone = 1, naquadah_powder = 1}
RECIPE.reqlvl = { arcane = 50}
RECIPE.gives = { cosmic_stone = 1}
RECIPE.spclvl = { double = 60, triple = 75}
RECIPE.xp = 60
Menu_RegisterForge( "1. stone forging", RECIPE )





RECIPE = {}
RECIPE.material = "vgui/stones/RuneWind2.png"
RECIPE.title = "Forge Wind Stone x5"
RECIPE.stitle = "Wind Stone x5"
RECIPE.uid = "forge51"
RECIPE.description = "Imbues airy magical properties into an inert stone."
RECIPE.cost = { inert_stone = 5, stone_powder = 5}
RECIPE.reqlvl = { arcane = 1}
RECIPE.spclvl = { double = 15, triple = 30}
RECIPE.gives = { wind_stone = 5}
RECIPE.xp = 27
Menu_RegisterForge( "2. stone forging - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneWater2.png"
RECIPE.title = "Forge Water Stone x5"
RECIPE.stitle = "Water Stone x5"
RECIPE.uid = "forge52"
RECIPE.description = "Imbues watery magical properties into an inert stone."
RECIPE.cost = { inert_stone = 5, stone_powder = 10}
RECIPE.reqlvl = { arcane = 10}
RECIPE.spclvl = { double = 25, triple = 35}
RECIPE.gives = { water_stone = 5}
RECIPE.xp = 90
Menu_RegisterForge( "2. stone forging - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneEarth2.png"
RECIPE.title = "Forge Earth Stone x5"
RECIPE.stitle = "Earth Stone x5"
RECIPE.uid = "forge53"
RECIPE.description = "Imbues rocky magical properties into an inert stone."
RECIPE.cost = { inert_stone = 5, iron_powder = 5}
RECIPE.reqlvl = { arcane = 15}
RECIPE.spclvl = { double = 35, triple = 45}
RECIPE.gives = { earth_stone = 5}
RECIPE.xp = 112
Menu_RegisterForge( "2. stone forging - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneFire2.png"
RECIPE.title = "Forge Fire Stone x5"
RECIPE.stitle = "Fire Stone x5"
RECIPE.uid = "forge54"
RECIPE.description = "Imbues fiery magical properties into an inert stone."
RECIPE.cost = { inert_stone = 5, coal_powder = 5}
RECIPE.reqlvl = { arcane = 20}
RECIPE.spclvl = { double = 40, triple = 50}
RECIPE.gives = { fire_stone = 5}
RECIPE.xp = 135
Menu_RegisterForge( "2. stone forging - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneChaos2.png"
RECIPE.title = "Forge Chaos Stone x5"
RECIPE.stitle = "Chaos Stone x5"
RECIPE.uid = "forge55"
RECIPE.description = "Imbues chaotic magical properties into an inert stone."
RECIPE.cost = { inert_stone = 5, silver_powder = 5}
RECIPE.reqlvl = { arcane = 30}
RECIPE.spclvl = { double = 45, triple = 60}
RECIPE.gives = { chaos_stone = 5}
RECIPE.xp = 180
Menu_RegisterForge( "2. stone forging - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneNature2.png"
RECIPE.title = "Forge Nature Stone x5"
RECIPE.stitle = "Nature Stone x5"
RECIPE.uid = "forge56"
RECIPE.description = "Imbues natural magical properties into an inert stone."
RECIPE.cost = { inert_stone = 5, trinium_powder = 5}
RECIPE.reqlvl = { arcane = 40}
RECIPE.gives = { nature_stone = 5}
RECIPE.spclvl = { double = 55, triple = 65}
RECIPE.xp = 225
Menu_RegisterForge( "2. stone forging - 5x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneCosmic2.png"
RECIPE.title = "Forge Cosmic Stone x5"
RECIPE.stitle = "Cosmic Stone x5"
RECIPE.uid = "forge57"
RECIPE.description = "Imbues cosmic magical properties into an inert stone."
RECIPE.cost = { inert_stone = 5, naquadah_powder = 5}
RECIPE.reqlvl = { arcane = 50}
RECIPE.gives = { cosmic_stone = 5}
RECIPE.spclvl = { double = 60, triple = 75}
RECIPE.xp = 270
Menu_RegisterForge( "2. stone forging - 5x", RECIPE )





RECIPE = {}
RECIPE.material = "vgui/stones/RuneWind2.png"
RECIPE.title = "Forge Wind Stone 10x"
RECIPE.stitle = "Wind Stone 10x"
RECIPE.uid = "forge101"
RECIPE.description = "Imbues airy magical properties into an inert stone."
RECIPE.cost = { inert_stone = 10, stone_powder = 10}
RECIPE.reqlvl = { arcane = 1}
RECIPE.spclvl = { double = 15, triple = 30}
RECIPE.gives = { wind_stone = 10}
RECIPE.xp = 45
Menu_RegisterForge( "3. stone forging - 10x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneWater2.png"
RECIPE.title = "Forge Water Stone 10x"
RECIPE.stitle = "Water Stone 10x"
RECIPE.uid = "forge102"
RECIPE.description = "Imbues watery magical properties into an inert stone."
RECIPE.cost = { inert_stone = 10, stone_powder = 20}
RECIPE.reqlvl = { arcane = 10}
RECIPE.spclvl = { double = 25, triple = 35}
RECIPE.gives = { water_stone = 10}
RECIPE.xp = 150
Menu_RegisterForge( "3. stone forging - 10x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneEarth2.png"
RECIPE.title = "Forge Earth Stone 10x"
RECIPE.stitle = "Earth Stone 10x"
RECIPE.uid = "forge103"
RECIPE.description = "Imbues rocky magical properties into an inert stone."
RECIPE.cost = { inert_stone = 10, iron_powder = 10}
RECIPE.reqlvl = { arcane = 15}
RECIPE.spclvl = { double = 35, triple = 45}
RECIPE.gives = { earth_stone = 10}
RECIPE.xp = 187
Menu_RegisterForge( "3. stone forging - 10x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneFire2.png"
RECIPE.title = "Forge Fire Stone 10x"
RECIPE.stitle = "Fire Stone 10x"
RECIPE.uid = "forge104"
RECIPE.description = "Imbues fiery magical properties into an inert stone."
RECIPE.cost = { inert_stone = 10, coal_powder = 10}
RECIPE.reqlvl = { arcane = 20}
RECIPE.spclvl = { double = 40, triple = 50}
RECIPE.gives = { fire_stone = 10}
RECIPE.xp = 225
Menu_RegisterForge( "3. stone forging - 10x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneChaos2.png"
RECIPE.title = "Forge Chaos Stone 10x"
RECIPE.stitle = "Chaos Stone 10x"
RECIPE.uid = "forge105"
RECIPE.description = "Imbues chaotic magical properties into an inert stone."
RECIPE.cost = { inert_stone = 10, silver_powder = 10}
RECIPE.reqlvl = { arcane = 30}
RECIPE.spclvl = { double = 45, triple = 60}
RECIPE.gives = { chaos_stone = 10}
RECIPE.xp = 300
Menu_RegisterForge( "3. stone forging - 10x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneNature2.png"
RECIPE.title = "Forge Nature Stone 10x"
RECIPE.stitle = "Nature Stone 10x"
RECIPE.uid = "forge106"
RECIPE.description = "Imbues natural magical properties into an inert stone."
RECIPE.cost = { inert_stone = 10, trinium_powder = 10}
RECIPE.reqlvl = { arcane = 40}
RECIPE.gives = { nature_stone = 10}
RECIPE.spclvl = { double = 55, triple = 65}
RECIPE.xp = 375
Menu_RegisterForge( "3. stone forging - 10x", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/stones/RuneCosmic2.png"
RECIPE.title = "Forge Cosmic Stone 10x"
RECIPE.stitle = "Cosmic Stone 10x"
RECIPE.uid = "forge107"
RECIPE.description = "Imbues cosmic magical properties into an inert stone."
RECIPE.cost = { inert_stone = 10, naquadah_powder = 10}
RECIPE.reqlvl = { arcane = 50}
RECIPE.gives = { cosmic_stone = 10}
RECIPE.spclvl = { double = 60, triple = 75}
RECIPE.xp = 450
Menu_RegisterForge( "3. stone forging - 10x", RECIPE )