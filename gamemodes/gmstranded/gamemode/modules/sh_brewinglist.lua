SGS.Brewing = {}
function Menu_RegisterBrewing( category, recipe )
	if not SGS.Brewing[category] then SGS.Brewing[category] = {} end
	
	SGS.Brewing[category][#SGS.Brewing[category] + 1] = recipe
end

//-=Healing Potions--//

RECIPE = {}
RECIPE.material = "vgui/potions/new/heal_minor.png"
RECIPE.title = "Minor Healing Potion"
RECIPE.uid = "healing1"
RECIPE.description = "Heals 40hp"
RECIPE.cost = { vial = 1, liferoot = 3}
RECIPE.reqlvl = { alchemy = 1}
RECIPE.gives = { minor_healing_potion = 1}
RECIPE.mname = "minor_healing_potion"
RECIPE.ptype = "healing"
RECIPE.value = 40
RECIPE.xp = 10
RECIPE.salvage = "vial"
Menu_RegisterBrewing( "healing", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/heal.png"
RECIPE.title = "Healing Potion"
RECIPE.uid = "healing2"
RECIPE.description = "Heals 80hp"
RECIPE.cost = { vial = 1, liferoot = 5}
RECIPE.reqlvl = { alchemy = 12}
RECIPE.gives = { healing_potion = 1}
RECIPE.mname = "healing_potion"
RECIPE.ptype = "healing"
RECIPE.value = 80
RECIPE.xp = 60
RECIPE.salvage = "vial"
Menu_RegisterBrewing( "healing", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/heal_major.png"
RECIPE.title = "Major Healing Potion"
RECIPE.uid = "healing3"
RECIPE.description = "Heals 120hp"
RECIPE.cost = { flask = 1, liferoot = 7}
RECIPE.reqlvl = { alchemy = 24}
RECIPE.gives = { major_healing_potion = 1}
RECIPE.mname = "major_healing_potion"
RECIPE.ptype = "healing"
RECIPE.value = 120
RECIPE.xp = 120
RECIPE.salvage = "flask"
Menu_RegisterBrewing( "healing", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/heal_superior.png"
RECIPE.title = "Super Healing Potion"
RECIPE.uid = "healing4"
RECIPE.description = "Heals 180hp"
RECIPE.cost = { heavy_flask = 1, liferoot = 8}
RECIPE.reqlvl = { alchemy = 32}
RECIPE.gives = { super_healing_potion = 1}
RECIPE.mname = "super_healing_potion"
RECIPE.ptype = "healing"
RECIPE.value = 160
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "healing", RECIPE )

//-=Curing Potions--//

RECIPE = {}
RECIPE.material = "vgui/potions/new/thecure.png"
RECIPE.title = "The Cure"
RECIPE.uid = "curing1"
RECIPE.description = "Cures Food Bourne Illness"
RECIPE.cost = { vial = 1, liferoot = 3, pypa_seed = 5}
RECIPE.reqlvl = { alchemy = 1}
RECIPE.gives = { the_cure = 1}
RECIPE.mname = "the_cure"
RECIPE.ptype = "curing"
RECIPE.value = "illness"
RECIPE.xp = 15
RECIPE.salvage = "vial"
Menu_RegisterBrewing( "curing", RECIPE )

//-=EXP Elixirs--//

RECIPE = {}
RECIPE.material = "vgui/potions/new/farming.png"
RECIPE.title = "Minor Farming Elixir"
RECIPE.description = "Boost Farming Experience by 25%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 5, guacca_seed = 10}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_farming_elixir = 1}
RECIPE.mname = "minor_farming_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "farming"
RECIPE.time = 120
RECIPE.level = 1
RECIPE.mod = 1.25
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/farming_major.png"
RECIPE.title = "Major Farming Elixir"
RECIPE.description = "Boost Farming Experience by 75%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 8, liechi_seed = 10}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { farming_elixir = 1}
RECIPE.mname = "farming_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "farming"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.75
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/woodcutting.png"
RECIPE.title = "Minor Woodcutting Elixir"
RECIPE.description = "Boost Woodcutting Experience by 25%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 5, tree_seed = 2}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_woodcutting_elixir = 1}
RECIPE.mname = "minor_woodcutting_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "woodcutting"
RECIPE.time = 120
RECIPE.level = 1
RECIPE.mod = 1.25
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/woodcutting_major.png"
RECIPE.title = "Major Woodcutting Elixir"
RECIPE.description = "Boost Woodcutting Experience by 75%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 8, maple_seed = 2}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { woodcutting_elixir = 1}
RECIPE.mname = "woodcutting_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "woodcutting"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.75
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/fishing.png"
RECIPE.title = "Minor Fishing Elixir"
RECIPE.description = "Boost Fishing Experience by 25%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 5, salmon = 5}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_fishing_elixir = 1}
RECIPE.mname = "minor_fishing_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "fishing"
RECIPE.time = 120
RECIPE.level = 1
RECIPE.mod = 1.25
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/fishing_major.png"
RECIPE.title = "Major Fishing Elixir"
RECIPE.description = "Boost Fishing Experience by 75%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 8, bass = 5}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { fishing_elixir = 1}
RECIPE.mname = "fishing_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "fishing"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.75
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/mining.png"
RECIPE.title = "Minor Mining Elixir"
RECIPE.description = "Boost Mining Experience by 25%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 5, iron_ore = 5}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_mining_elixir = 1}
RECIPE.mname = "minor_mining_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "mining"
RECIPE.time = 120
RECIPE.level = 1
RECIPE.mod = 1.25
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/mining_major.png"
RECIPE.title = "Major Mining Elixir"
RECIPE.description = "Boost Mining Experience by 75%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 8, silver_ore = 5}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { mining_elixir = 1}
RECIPE.mname = "mining_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "mining"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.75
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/cooking.png"
RECIPE.title = "Minor Cooking Elixir"
RECIPE.description = "Boost Cooking Experience by 25%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 5, guacca_pie = 5}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_cooking_elixir = 1}
RECIPE.mname = "minor_cooking_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "cooking"
RECIPE.time = 120
RECIPE.level = 1
RECIPE.mod = 1.25
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/cooking_major.png"
RECIPE.title = "Major Cooking Elixir"
RECIPE.description = "Boost Cooking Experience by 75%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 8, lum_pie = 3}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { cooking_elixir = 1}
RECIPE.mname = "cooking_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "cooking"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.75
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/smithing.png"
RECIPE.title = "Minor Smithing Elixir"
RECIPE.description = "Boost Smithing Experience by 25%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 5, steel = 5}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_smithing_elixir = 1}
RECIPE.mname = "minor_smithing_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "smithing"
RECIPE.time = 120
RECIPE.level = 1
RECIPE.mod = 1.25
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/smithing_major.png"
RECIPE.title = "Major Smithing Elixir"
RECIPE.description = "Boost Smithing Experience by 75%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 8, silver = 5}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { smithing_elixir = 1}
RECIPE.mname = "smithing_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "smithing"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.75
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )


RECIPE = {}
RECIPE.material = "vgui/potions/new/construction.png"
RECIPE.title = "Minor Construction Elixir"
RECIPE.description = "Boost Construction Experience by 25%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 5, oak_wood = 5}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_construction_elixir = 1}
RECIPE.mname = "minor_construction_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "construction"
RECIPE.time = 120
RECIPE.level = 1
RECIPE.mod = 1.25
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/construction_major.png"
RECIPE.title = "Major Construction Elixir"
RECIPE.description = "Boost Construction Experience by 75%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 8, pine_wood = 5}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { construction_elixir = 1}
RECIPE.mname = "construction_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "construction"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.75
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )


RECIPE = {}
RECIPE.material = "vgui/potions/new/alchemy.png"
RECIPE.title = "Minor Alchemy Elixir"
RECIPE.description = "Boost Alchemy Experience by 25%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 5, oak_wood = 5}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_alchemy_elixir = 1}
RECIPE.mname = "minor_alchemy_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "alchemy"
RECIPE.time = 120
RECIPE.level = 1
RECIPE.mod = 1.25
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/alchemy_major.png"
RECIPE.title = "Major Alchemy Elixir"
RECIPE.description = "Boost Alchemy Experience by 75%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 8, pine_wood = 5}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { alchemy_elixir = 1}
RECIPE.mname = "alchemy_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "alchemy"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.75
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/combat.png"
RECIPE.title = "Minor Combat Elixir"
RECIPE.description = "Boost Combat Experience by 25%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 5, antlion_meat = 5}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_combat_elixir = 1}
RECIPE.mname = "minor_combat_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "combat"
RECIPE.time = 120
RECIPE.level = 1
RECIPE.mod = 1.25
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/combat_major.png"
RECIPE.title = "Major Combat Elixir"
RECIPE.description = "Boost Combat Experience by 75%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 8, antlion_meat = 10}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { combat_elixir = 1}
RECIPE.mname = "combat_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "combat"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.75
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/arcane.png"
RECIPE.title = "Minor Arcane Elixir"
RECIPE.description = "Boost Arcane Experience by 25%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 5, inert_stone = 5}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_arcane_elixir = 1}
RECIPE.mname = "minor_arcane_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "arcane"
RECIPE.time = 120
RECIPE.level = 1
RECIPE.mod = 1.25
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/arcane_major.png"
RECIPE.title = "Major Arcane Elixir"
RECIPE.description = "Boost Arcane Experience by 75%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 8, inert_stone = 10}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { arcane_elixir = 1}
RECIPE.mname = "arcane_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "arcane"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.75
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/misc_diarrhea_brown.png"
RECIPE.title = "Minor Leveling Elixir"
RECIPE.description = "Boost All Experience by 15%\nEffect Lasts: 2 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 15, sapphire = 1}
RECIPE.reqlvl = { alchemy = 30}
RECIPE.gives = { minor_exp_elixir = 1}
RECIPE.mname = "minor_exp_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "all"
RECIPE.time = 90
RECIPE.level = 1
RECIPE.mod = 1.15
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/misc_diarrhea_brown_major.png"
RECIPE.title = "Major Leveling Elixir"
RECIPE.description = "Boost All Experience by 30%\nEffect Lasts: 2 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 30, ruby = 1}
RECIPE.reqlvl = { alchemy = 40}
RECIPE.gives = { exp_elixir = 1}
RECIPE.mname = "exp_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "all"
RECIPE.time = 120
RECIPE.level = 2
RECIPE.mod = 1.3
RECIPE.xp = 300
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "elixir", RECIPE )


//-=Strong Elixirs--//

RECIPE = {}
RECIPE.material = "vgui/potions/new/farming_major.png"
RECIPE.title = "Strong Farming Elixir"
RECIPE.description = "Boost Farming Experience by 100%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 16, liechi_seed = 20}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { strong_farming_elixir = 1}
RECIPE.mname = "strong_farming_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "farming"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 2
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/woodcutting_major.png"
RECIPE.title = "Strong Woodcutting Elixir"
RECIPE.description = "Boost Woodcutting Experience by 100%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 16, maple_seed = 5}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { strong_woodcutting_elixir = 1}
RECIPE.mname = "strong_woodcutting_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "woodcutting"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 2
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/fishing_major.png"
RECIPE.title = "Strong Fishing Elixir"
RECIPE.description = "Boost Fishing Experience by 100%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 16, swordfish = 5}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { strong_fishing_elixir = 1}
RECIPE.mname = "strong_fishing_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "fishing"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 2
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/mining_major.png"
RECIPE.title = "Strong Mining Elixir"
RECIPE.description = "Boost Mining Experience by 100%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 16, trinium_ore = 10}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { strong_mining_elixir = 1}
RECIPE.mname = "strong_mining_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "mining"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 2
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/cooking_major.png"
RECIPE.title = "Strong Cooking Elixir"
RECIPE.description = "Boost Cooking Experience by 100%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 16, lum_pie = 6}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { strong_cooking_elixir = 1}
RECIPE.mname = "strong_cooking_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "cooking"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 2
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/smithing_major.png"
RECIPE.title = "Strong Smithing Elixir"
RECIPE.description = "Boost Smithing Experience by 100%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 16, trinium = 10}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { strong_smithing_elixir = 1}
RECIPE.mname = "strong_smithing_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "smithing"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 2
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/construction_major.png"
RECIPE.title = "Strong Construction Elixir"
RECIPE.description = "Boost Construction Experience by 100%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 16, yew_wood = 10}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { strong_construction_elixir = 1}
RECIPE.mname = "strong_construction_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "construction"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 2
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/alchemy_major.png"
RECIPE.title = "Strong Alchemy Elixir"
RECIPE.description = "Boost Alchemy Experience by 100%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 16, burned_fish = 10}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { strong_alchemy_elixir = 1}
RECIPE.mname = "strong_alchemy_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "alchemy"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 2
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/combat_major.png"
RECIPE.title = "Strong Combat Elixir"
RECIPE.description = "Boost Combat Experience by 100%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 16, antlion_head = 10}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { strong_combat_elixir = 1}
RECIPE.mname = "strong_combat_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "combat"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 2
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/arcane_major.png"
RECIPE.title = "Strong Arcane Elixir"
RECIPE.description = "Boost Arcane Experience by 100%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 16, inert_stone = 10}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { strong_arcane_elixir = 1}
RECIPE.mname = "strong_arcane_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "arcane"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 2
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/misc_diarrhea_brown_major.png"
RECIPE.title = "Strong Leveling Elixir"
RECIPE.description = "Boost All Experience by 50%\nEffect Lasts: 3 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 30, diamond = 1}
RECIPE.reqlvl = { alchemy = 65}
RECIPE.gives = { strong_exp_elixir = 1}
RECIPE.mname = "strong_exp_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "all"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 1.5
RECIPE.xp = 600
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "strong-elixir", RECIPE )


//-=Special Effects Potions--//

RECIPE = {}
RECIPE.material = "vgui/potions/new/misc_diarrhea_brown.png"
RECIPE.title = "Speed Potion"
RECIPE.description = "Run 30% faster!\nEffect Lasts: 3 minutes"
RECIPE.cost = { flask = 1, liferoot = 5, tuna = 5}
RECIPE.reqlvl = { alchemy = 20}
RECIPE.gives = { speed_potion = 1}
RECIPE.mname = "speed_potion"
RECIPE.ptype = "elixir"
RECIPE.value = "speed"
RECIPE.time = 180
RECIPE.level = 1
RECIPE.mod = 1.3
RECIPE.xp = 120
RECIPE.salvage = "flask"
Menu_RegisterBrewing( "special_potions", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/misc_diarrhea_brown_major.png"
RECIPE.title = "Quick Speed Potion"
RECIPE.description = "Run 50% faster!\nEffect Lasts: 3 minutes"
RECIPE.cost = { heavy_flask = 1, liferoot = 8, lobster = 5}
RECIPE.reqlvl = { alchemy = 35}
RECIPE.gives = { quick_speed_potion = 1}
RECIPE.mname = "quick_speed_potion"
RECIPE.ptype = "elixir"
RECIPE.value = "speed"
RECIPE.time = 180
RECIPE.level = 2
RECIPE.mod = 1.5
RECIPE.xp = 180
RECIPE.salvage = "heavy_flask"
Menu_RegisterBrewing( "special_potions", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/misc_diarrhea_brown.png"
RECIPE.title = "Water Breathing Potion"
RECIPE.description = "Breathe Underwater!\nEffect Lasts: 5 minutes"
RECIPE.cost = { flask = 1, liferoot = 8, cod = 5}
RECIPE.reqlvl = { alchemy = 15}
RECIPE.gives = { water_breathing_potion = 1}
RECIPE.mname = "water_breathing_potion"
RECIPE.ptype = "elixir"
RECIPE.value = "waterbreathing"
RECIPE.time = 300
RECIPE.level = 2
RECIPE.mod = 1.6
RECIPE.xp = 80
RECIPE.salvage = "flask"
Menu_RegisterBrewing( "special_potions", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/arcane.png"
RECIPE.title = "Luck Potion"
RECIPE.description = "Finding things just got easier!\nIncreases Luck by: 50%\nEffect Lasts: 5 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 30, gold_powder = 20}
RECIPE.reqlvl = { alchemy = 60}
RECIPE.gives = { luck_elixir = 1}
RECIPE.mname = "luck_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "luck"
RECIPE.time = 300
RECIPE.level = 2
RECIPE.mod = 0.5
RECIPE.xp = 580
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "special_potions", RECIPE )

RECIPE = {}
RECIPE.material = "vgui/potions/new/arcane_major.png"
RECIPE.title = "Strong Luck Potion"
RECIPE.description = "Finding things just got even easier!\nIncreases Luck by: 100%\nEffect Lasts: 5 minutes"
RECIPE.cost = { imbued_flask = 1, liferoot = 50, platinum_powder = 20}
RECIPE.reqlvl = { alchemy = 70}
RECIPE.gives = { strong_luck_elixir = 1}
RECIPE.mname = "strong_luck_elixir"
RECIPE.ptype = "elixir"
RECIPE.value = "luck"
RECIPE.time = 300
RECIPE.level = 3
RECIPE.mod = 1
RECIPE.xp = 720
RECIPE.salvage = "imbued_flask"
Menu_RegisterBrewing( "special_potions", RECIPE )

//-=Achievement Elixir--//

RECIPE = {}
RECIPE.title = "Inventory Increasement 1"
RECIPE.material = "vgui/error.png"
RECIPE.ptype = "achievement"
RECIPE.uid = "inventory1"
RECIPE.mname = "max_inventory_buff_1"
RECIPE.description = "Permanently Increases Max Inventory by 50"
RECIPE.achievement = "inventory1"
RECIPE.alttext = "Unlocking Achievement..."
Menu_RegisterBrewing( "achievement", RECIPE )

RECIPE = {}
RECIPE.title = "Inventory Increasement 2"
RECIPE.material = "vgui/error.png"
RECIPE.ptype = "achievement"
RECIPE.uid = "inventory2"
RECIPE.mname = "max_inventory_buff_2"
RECIPE.description = "Permanently Increases Max Inventory by 100"
RECIPE.achievement = "inventory2"
RECIPE.alttext = "Unlocking Achievement..."
Menu_RegisterBrewing( "achievement", RECIPE )

RECIPE = {}
RECIPE.title = "Member Upgrade Token"
RECIPE.material = "vgui/error.png"
RECIPE.ptype = "upgrade"
RECIPE.uid = "mut"
RECIPE.mname = "member_upgrade_token"
RECIPE.description = "Makes you a donator for 1 month"
RECIPE.alttext = "Unlocking Achievement..."
Menu_RegisterBrewing( "achievement", RECIPE )

RECIPE = {}
RECIPE.title = "Max Plant Increasement 1"
RECIPE.material = "vgui/error.png"
RECIPE.ptype = "achievement"
RECIPE.uid = "planting1"
RECIPE.mname = "max_plant_buff_1"
RECIPE.description = "Permanently Increases Max Plants by 3"
RECIPE.achievement = "planting1"
RECIPE.alttext = "Unlocking Achievement..."
Menu_RegisterBrewing( "achievement", RECIPE )

RECIPE = {}
RECIPE.title = "Max Plant Increasement 2"
RECIPE.material = "vgui/error.png"
RECIPE.ptype = "achievement"
RECIPE.uid = "planting2"
RECIPE.mname = "max_plant_buff_2"
RECIPE.description = "Permanently Increases Max Plants by 6"
RECIPE.achievement = "planting2"
RECIPE.alttext = "Unlocking Achievement..."
Menu_RegisterBrewing( "achievement", RECIPE )

RECIPE = {}
RECIPE.title = "Pet House Upgrade 1"
RECIPE.material = "vgui/error.png"
RECIPE.ptype = "achievement"
RECIPE.uid = "maxpets1"
RECIPE.mname = "pethouse_upgrade_1"
RECIPE.description = "Permanently increases max pet storage by 5."
RECIPE.achievement = "maxpets1"
RECIPE.alttext = "Unlocking Achievement..."
Menu_RegisterBrewing( "achievement", RECIPE )

RECIPE = {}
RECIPE.title = "Pet House Upgrade 2"
RECIPE.material = "vgui/error.png"
RECIPE.ptype = "achievement"
RECIPE.uid = "maxpets2"
RECIPE.mname = "pethouse_upgrade_2"
RECIPE.description = "Permanently increases max pet storage by 5."
RECIPE.achievement = "maxpets2"
RECIPE.alttext = "Unlocking Achievement..."
Menu_RegisterBrewing( "achievement", RECIPE )

RECIPE = {}
RECIPE.title = "Persistent Tribe Upgrade"
RECIPE.material = "vgui/error.png"
RECIPE.ptype = "upgrade"
RECIPE.uid = "tribe_upgrade"
RECIPE.mname = "tribe_upgrade"
RECIPE.description = "Upgrades your tribe to be persistent and take advantage of tribe perks."
RECIPE.alttext = "Upgrading Tribe..."
Menu_RegisterBrewing( "achievement", RECIPE )

//-=First Aid--//

RECIPE = {}
RECIPE.title = "Aid Pack"
RECIPE.material = "vgui/firstaid/health_lg.png"
RECIPE.ptype = "firstaid"
RECIPE.uid = "aid1"
RECIPE.mname = "aid_pack"
RECIPE.description = "Heals 20% HP"
RECIPE.gives = { aid_pack = 1}
RECIPE.cost = { pypa_seed = 5 }
RECIPE.reqlvl = { alchemy = 1}
RECIPE.xp = 10
RECIPE.alttext = "Applying Kit..."
Menu_RegisterBrewing( "firstaid", RECIPE )

RECIPE = {}
RECIPE.title = "Large Aid Pack"
RECIPE.material = "vgui/firstaid/health_sm.png"
RECIPE.ptype = "firstaid"
RECIPE.uid = "aid2"
RECIPE.mname = "large_aid_pack"
RECIPE.description = "Heals 50% HP"
RECIPE.gives = { large_aid_pack = 1}
RECIPE.cost = { liferoot = 5, cloth = 2 }
RECIPE.reqlvl = { alchemy = 15}
RECIPE.xp = 60
RECIPE.alttext = "Applying Kit..."
Menu_RegisterBrewing( "firstaid", RECIPE )

RECIPE = {}
RECIPE.title = "Tourniquet"
RECIPE.material = "vgui/firstaid/tourniquet.png"
RECIPE.ptype = "firstaid"
RECIPE.uid = "aid3"
RECIPE.mname = "tourniquet"
RECIPE.description = "Stops Bleeding"
RECIPE.gives = { tourniquet = 1}
RECIPE.cost = { liferoot = 10, cloth = 2 }
RECIPE.reqlvl = { alchemy = 25}
RECIPE.xp = 135
RECIPE.alttext = "Applying Tourniquet..."
Menu_RegisterBrewing( "firstaid", RECIPE )

RECIPE = {}
RECIPE.title = "Wooden Splint"
RECIPE.material = "vgui/firstaid/splint.png"
RECIPE.ptype = "firstaid"
RECIPE.uid = "aid4"
RECIPE.mname = "wooden_splint"
RECIPE.description = "Heals Broken Bones"
RECIPE.gives = { wooden_splint = 1}
RECIPE.cost = { wood = 10 }
RECIPE.reqlvl = { alchemy = 1}
RECIPE.xp = 15
RECIPE.alttext = "Applying Splint..."
Menu_RegisterBrewing( "firstaid", RECIPE )