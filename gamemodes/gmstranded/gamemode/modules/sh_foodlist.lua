SGS.Food = {}
function Menu_RegisterFood( category, recipe )
	if not SGS.Food[category] then SGS.Food[category] = {} end
	SGS.Food[category][#SGS.Food[category] + 1] = recipe
end




RECIPE = {}
RECIPE.name = "cooked_herring"
RECIPE.title = "Cooked Herring"
RECIPE.sname = "fish"
RECIPE.material = "vgui/fish/cooked_herring.png"
RECIPE.description = "A cooked fish!"
RECIPE.cost = { herring = 1 }
RECIPE.reqlvl = { cooking = 1 }
RECIPE.eatheal = 200
RECIPE.xp = 30
Menu_RegisterFood( "fish", RECIPE )

RECIPE = {}
RECIPE.name = "cooked_trout"
RECIPE.title = "Cooked Trout"
RECIPE.sname = "fish"
RECIPE.material = "vgui/fish/cooked_trout.png"
RECIPE.description = "A cooked fish!"
RECIPE.cost = { trout = 1 }
RECIPE.reqlvl = { cooking = 1 }
RECIPE.eatheal = 200
RECIPE.xp = 30
Menu_RegisterFood( "fish", RECIPE )

RECIPE = {}
RECIPE.name = "cooked_cod"
RECIPE.title = "Cooked Cod"
RECIPE.sname = "fish"
RECIPE.material = "vgui/fish/cooked_cod.png"
RECIPE.description = "A cooked fish!"
RECIPE.cost = { cod = 1 }
RECIPE.reqlvl = { cooking = 10 }
RECIPE.eatheal = 300
RECIPE.xp = 60
Menu_RegisterFood( "fish", RECIPE )

RECIPE = {}
RECIPE.name = "cooked_salmon"
RECIPE.title = "Cooked Salmon"
RECIPE.sname = "fish"
RECIPE.material = "vgui/fish/cooked_salmon.png"
RECIPE.description = "A cooked fish!"
RECIPE.cost = { salmon = 1 }
RECIPE.reqlvl = { cooking = 15 }
RECIPE.eatheal = 400
RECIPE.xp = 70
Menu_RegisterFood( "fish", RECIPE )

RECIPE = {}
RECIPE.name = "cooked_tuna"
RECIPE.title = "Cooked Tuna"
RECIPE.sname = "fish"
RECIPE.material = "vgui/fish/cooked_tuna.png"
RECIPE.description = "A cooked fish!"
RECIPE.cost = { tuna = 1 }
RECIPE.reqlvl = { cooking = 20 }
RECIPE.eatheal = 500
RECIPE.xp = 80
Menu_RegisterFood( "fish", RECIPE )

RECIPE = {}
RECIPE.name = "cooked_lobster"
RECIPE.title = "Cooked Lobster"
RECIPE.sname = "fish"
RECIPE.material = "vgui/fish/cooked_lobster.png"
RECIPE.description = "A cooked fish!"
RECIPE.cost = { lobster = 1 }
RECIPE.reqlvl = { cooking = 30 }
RECIPE.eatheal = 600
RECIPE.xp = 100
Menu_RegisterFood( "fish", RECIPE )

RECIPE = {}
RECIPE.name = "cooked_bass"
RECIPE.title = "Cooked Bass"
RECIPE.sname = "fish"
RECIPE.material = "vgui/fish/cooked_bass.png"
RECIPE.description = "A cooked fish!"
RECIPE.cost = { bass = 1 }
RECIPE.reqlvl = { cooking = 40 }
RECIPE.eatheal = 700
RECIPE.xp = 120
Menu_RegisterFood( "fish", RECIPE )

RECIPE = {}
RECIPE.name = "cooked_swordfish"
RECIPE.title = "Cooked Swordfish"
RECIPE.sname = "fish"
RECIPE.material = "vgui/fish/cooked_swordfish.png"
RECIPE.description = "A cooked fish!"
RECIPE.cost = { swordfish = 1 }
RECIPE.reqlvl = { cooking = 50 }
RECIPE.eatheal = 800
RECIPE.xp = 140
Menu_RegisterFood( "fish", RECIPE )

RECIPE = {}
RECIPE.name = "cooked_shark"
RECIPE.title = "Cooked Shark"
RECIPE.sname = "fish"
RECIPE.material = "vgui/fish/cooked_shark2.png"
RECIPE.description = "A cooked fish!"
RECIPE.cost = { shark = 1 }
RECIPE.reqlvl = { cooking = 60 }
RECIPE.eatheal = 1200
RECIPE.xp = 200
Menu_RegisterFood( "fish", RECIPE )

RECIPE = {}
RECIPE.name = "cooked_eel"
RECIPE.title = "Cooked Eel"
RECIPE.sname = "fish"
RECIPE.material = "vgui/fish/cooked_eel.png"
RECIPE.description = "A cooked fish!"
RECIPE.cost = { eel = 1 }
RECIPE.reqlvl = { cooking = 71 }
RECIPE.eatheal = 1600
RECIPE.xp = 380
Menu_RegisterFood( "fish", RECIPE )



RECIPE = {}
RECIPE.name = "bread"
RECIPE.title = "Bread"
RECIPE.sname = "bread"
RECIPE.material = "vgui/cooking/cooked_bread.png"
RECIPE.description = "Cooked Bread!"
RECIPE.cost = { wheat = 5 }
RECIPE.reqlvl = { cooking = 4 }
RECIPE.eatheal = 250
RECIPE.xp = 20
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "apple_pie"
RECIPE.title = "Apple Pie"
RECIPE.sname = "pie"
RECIPE.material = "vgui/pie/cooked_guacca_pie2.png"
RECIPE.description = "Fresh from the oven!"
RECIPE.cost = { wheat = 5, red_apple = 1 }
RECIPE.reqlvl = { cooking = 5 }
RECIPE.eatheal = 500
RECIPE.xp = 800
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "pypa_pie"
RECIPE.title = "Pypa Pie"
RECIPE.sname = "pie"
RECIPE.material = "vgui/pie/cooked_pypa_pie2.png"
RECIPE.description = "Fresh from the oven!"
RECIPE.cost = { wheat = 5, pypa_seed = 5 }
RECIPE.reqlvl = { cooking = 8 }
RECIPE.eatheal = 300
RECIPE.xp = 40
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "guacca_pie"
RECIPE.title = "Guacca Pie"
RECIPE.sname = "pie"
RECIPE.material = "vgui/pie/cooked_guacca_pie2.png"
RECIPE.description = "Fresh from the oven!"
RECIPE.cost = { wheat = 5, guacca_seed = 5 }
RECIPE.reqlvl = { cooking = 15 }
RECIPE.eatheal = 450
RECIPE.xp = 80
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "arctus_pie"
RECIPE.title = "Arctus Pie"
RECIPE.sname = "pie"
RECIPE.material = "vgui/pie/cooked_arctus_pie2.png"
RECIPE.description = "Fresh from the oven!"
RECIPE.cost = { wheat = 5, arctus_seed = 5 }
RECIPE.reqlvl = { cooking = 24 }
RECIPE.eatheal = 500
RECIPE.xp = 120
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "liechi_pie"
RECIPE.title = "Liechi Pie"
RECIPE.sname = "pie"
RECIPE.material = "vgui/pie/cooked_liechi_pie2.png"
RECIPE.description = "Fresh from the oven!"
RECIPE.cost = { wheat = 5, liechi_seed = 5 }
RECIPE.reqlvl = { cooking = 32 }
RECIPE.eatheal = 600
RECIPE.xp = 160
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "lum_pie"
RECIPE.title = "Lum Pie"
RECIPE.sname = "pie"
RECIPE.material = "vgui/pie/cooked_lum_pie2.png"
RECIPE.description = "Fresh from the oven!"
RECIPE.cost = { wheat = 5, lum_seed = 5 }
RECIPE.reqlvl = { cooking = 41 }
RECIPE.eatheal = 750
RECIPE.xp = 200
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "perriot_pie"
RECIPE.title = "Perriot Pie"
RECIPE.sname = "pie"
RECIPE.material = "vgui/pie/cooked_perriot_pie2.png"
RECIPE.description = "Fresh from the oven!"
RECIPE.cost = { wheat = 5, perriot_seed = 3 }
RECIPE.reqlvl = { cooking = 50 }
RECIPE.eatheal = 900
RECIPE.xp = 320
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "pallie_pie"
RECIPE.title = "Pallie Pie"
RECIPE.sname = "pie"
RECIPE.material = "vgui/pie/cooked_pallie_pie2.png"
RECIPE.description = "Fresh from the oven!"
RECIPE.cost = { wheat = 5, pallie_seed = 3 }
RECIPE.reqlvl = { cooking = 55 }
RECIPE.eatheal = 1100
RECIPE.xp = 450
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "moly_pie"
RECIPE.title = "Moly Pie"
RECIPE.sname = "pie"
RECIPE.material = "vgui/pie/cooked_moly_pie2.png"
RECIPE.description = "Fresh from the oven!"
RECIPE.cost = { wheat = 5, moly_seed = 3 }
RECIPE.reqlvl = { cooking = 62 }
RECIPE.eatheal = 1500
RECIPE.xp = 550
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "pizza"
RECIPE.title = "Pizza"
RECIPE.sname = "pizza"
RECIPE.material = "vgui/cooking/cooked_pizza.png"
RECIPE.description = "It's not delivery!"
RECIPE.cost = { wheat = 5 }
RECIPE.reqlvl = { cooking = 35 }
RECIPE.eatheal = 500
RECIPE.xp = 220
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "antlion_pizza"
RECIPE.title = "Antlion Pizza"
RECIPE.sname = "pizza"
RECIPE.material = "vgui/cooking/cooked_antlion_pizza.png"
RECIPE.description = "It's not delivery!"
RECIPE.cost = { wheat = 5, antlion_meat = 2 }
RECIPE.reqlvl = { cooking = 45 }
RECIPE.eatheal = 800
RECIPE.xp = 300
Menu_RegisterFood( "baked", RECIPE )

RECIPE = {}
RECIPE.name = "lobster_pizza"
RECIPE.title = "Lobster Pizza"
RECIPE.sname = "pizza"
RECIPE.material = "vgui/cooking/cooked_lobster_pizza.png"
RECIPE.description = "It's not delivery!"
RECIPE.cost = { wheat = 5, lobster = 2 }
RECIPE.reqlvl = { cooking = 55 }
RECIPE.eatheal = 1200
RECIPE.xp = 450
Menu_RegisterFood( "baked", RECIPE )






RECIPE = {}
RECIPE.name = "antlion_steak"
RECIPE.title = "Antlion Steak"
RECIPE.sname = "meat"
RECIPE.material = "vgui/cooking/cooked_meat.png"
RECIPE.description = "Antlion Steak!"
RECIPE.cost = { antlion_meat = 1 }
RECIPE.reqlvl = { cooking = 4 }
RECIPE.eatheal = 300
RECIPE.xp = 25
Menu_RegisterFood( "meat", RECIPE )

RECIPE = {}
RECIPE.name = "fried_antlion_legs"
RECIPE.title = "Fried Antlion Legs"
RECIPE.sname = "meat"
RECIPE.material = "vgui/cooking/cooked_meat.png"
RECIPE.description = "Fried Antlion Legs!"
RECIPE.cost = { antlion_leg = 2 }
RECIPE.reqlvl = { cooking = 8 }
RECIPE.eatheal = 500
RECIPE.xp = 50
Menu_RegisterFood( "meat", RECIPE )

RECIPE = {}
RECIPE.name = "scrambled_brains"
RECIPE.title = "Scrambled Antlion Brains"
RECIPE.sname = "meat"
RECIPE.material = "vgui/cooking/cooked_meat.png"
RECIPE.description = "Antlion Brains!"
RECIPE.cost = { antlion_head = 1 }
RECIPE.reqlvl = { cooking = 40 }
RECIPE.eatheal = 1000
RECIPE.xp = 140
Menu_RegisterFood( "meat", RECIPE )

RECIPE = {}
RECIPE.name = "surf_and_turf"
RECIPE.title = "Surf and Turf"
RECIPE.sname = "meat"
RECIPE.material = "vgui/cooking/cooked_meat.png"
RECIPE.description = "Surf and Turf!"
RECIPE.cost = { antlion_meat = 1, lobster = 1 }
RECIPE.reqlvl = { cooking = 35 }
RECIPE.eatheal = 900
RECIPE.xp = 120
Menu_RegisterFood( "meat", RECIPE )





RECIPE = {}
RECIPE.name = "scrambled_white_eggs"
RECIPE.title = "Scrambled Eggs"
RECIPE.sname = "egg"
RECIPE.material = "vgui/cooking/scrambled_white_egg.png"
RECIPE.description = "Scrambled Eggs!"
RECIPE.cost = { white_pet_egg = 1 }
RECIPE.reqlvl = { cooking = 1 }
RECIPE.eatheal = 2000
RECIPE.xp = 1000
Menu_RegisterFood( "delicacy", RECIPE )

RECIPE = {}
RECIPE.name = "scrambled_yellow_eggs"
RECIPE.title = "Scrambled Eggs"
RECIPE.sname = "egg"
RECIPE.material = "vgui/cooking/scrambled_yellow_egg.png"
RECIPE.description = "Scrambled Eggs!"
RECIPE.cost = { yellow_pet_egg = 1 }
RECIPE.reqlvl = { cooking = 1 }
RECIPE.eatheal = 2000
RECIPE.xp = 1000
Menu_RegisterFood( "delicacy", RECIPE )

RECIPE = {}
RECIPE.name = "scrambled_black_eggs"
RECIPE.title = "Scrambled Eggs"
RECIPE.sname = "egg"
RECIPE.material = "vgui/cooking/scrambled_black_egg.png"
RECIPE.description = "Scrambled Eggs!"
RECIPE.cost = { black_pet_egg = 1 }
RECIPE.reqlvl = { cooking = 1 }
RECIPE.eatheal = 2000
RECIPE.xp = 1000
Menu_RegisterFood( "delicacy", RECIPE )

/*
RELICS
*/

RECIPE = {}
RECIPE.name = "cooking_relic_1"
RECIPE.sname = "relic"
RECIPE.title = "Cooking Relic"
RECIPE.description = "Level 1"
RECIPE.xp = 160
RECIPE.skill = "cooking"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "cooking_relic_2"
RECIPE.sname = "relic"
RECIPE.title = "Cooking Relic"
RECIPE.description = "Level 2"
RECIPE.xp = 560
RECIPE.skill = "cooking"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "cooking_relic_3"
RECIPE.sname = "relic"
RECIPE.title = "Cooking Relic"
RECIPE.description = "Level 3"
RECIPE.xp = 880
RECIPE.skill = "cooking"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "smithing_relic_1"
RECIPE.sname = "relic"
RECIPE.title = "Smithing Relic"
RECIPE.description = "Level 1"
RECIPE.xp = 160
RECIPE.skill = "smithing"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "smithing_relic_2"
RECIPE.sname = "relic"
RECIPE.title = "Smithing Relic"
RECIPE.description = "Level 2"
RECIPE.xp = 560
RECIPE.skill = "smithing"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "smithing_relic_3"
RECIPE.sname = "relic"
RECIPE.title = "Smithing Relic"
RECIPE.description = "Level 3"
RECIPE.xp = 880
RECIPE.skill = "smithing"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "mining_relic_1"
RECIPE.sname = "relic"
RECIPE.title = "Mining Relic"
RECIPE.description = "Level 1"
RECIPE.xp = 160
RECIPE.skill = "mining"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "mining_relic_2"
RECIPE.sname = "relic"
RECIPE.title = "Mining Relic"
RECIPE.description = "Level 2"
RECIPE.xp = 560
RECIPE.skill = "mining"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "mining_relic_3"
RECIPE.sname = "relic"
RECIPE.title = "Mining Relic"
RECIPE.description = "Level 3"
RECIPE.xp = 880
RECIPE.skill = "mining"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "woodcutting_relic_1"
RECIPE.sname = "relic"
RECIPE.title = "Woodcutting Relic"
RECIPE.description = "Level 1"
RECIPE.xp = 160
RECIPE.skill = "woodcutting"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "woodcutting_relic_2"
RECIPE.sname = "relic"
RECIPE.title = "Woodcutting Relic"
RECIPE.description = "Level 2"
RECIPE.xp = 560
RECIPE.skill = "woodcutting"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "woodcutting_relic_3"
RECIPE.sname = "relic"
RECIPE.title = "Woodcutting Relic"
RECIPE.description = "Level 3"
RECIPE.xp = 880
RECIPE.skill = "woodcutting"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "fishing_relic_1"
RECIPE.sname = "relic"
RECIPE.title = "Fishing Relic"
RECIPE.description = "Level 1"
RECIPE.xp = 160
RECIPE.skill = "fishing"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "fishing_relic_2"
RECIPE.sname = "relic"
RECIPE.title = "Fishing Relic"
RECIPE.description = "Level 2"
RECIPE.xp = 560
RECIPE.skill = "fishing"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "fishing_relic_3"
RECIPE.sname = "relic"
RECIPE.title = "Fishing Relic"
RECIPE.description = "Level 3"
RECIPE.xp = 880
RECIPE.skill = "fishing"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "construction_relic_1"
RECIPE.sname = "relic"
RECIPE.title = "Construction Relic"
RECIPE.description = "Level 1"
RECIPE.xp = 160
RECIPE.skill = "construction"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "construction_relic_2"
RECIPE.sname = "relic"
RECIPE.title = "Construction Relic"
RECIPE.description = "Level 2"
RECIPE.xp = 560
RECIPE.skill = "construction"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "construction_relic_3"
RECIPE.sname = "relic"
RECIPE.title = "Construction Relic"
RECIPE.description = "Level 3"
RECIPE.xp = 880
RECIPE.skill = "construction"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "farming_relic_1"
RECIPE.sname = "relic"
RECIPE.title = "Farming Relic"
RECIPE.description = "Level 1"
RECIPE.xp = 160
RECIPE.skill = "farming"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "farming_relic_2"
RECIPE.sname = "relic"
RECIPE.title = "Farming Relic"
RECIPE.description = "Level 2"
RECIPE.xp = 560
RECIPE.skill = "farming"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "farming_relic_3"
RECIPE.sname = "relic"
RECIPE.title = "Farming Relic"
RECIPE.description = "Level 3"
RECIPE.xp = 880
RECIPE.skill = "farming"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "alchemy_relic_1"
RECIPE.sname = "relic"
RECIPE.title = "Alchemy Relic"
RECIPE.description = "Level 1"
RECIPE.xp = 160
RECIPE.skill = "alchemy"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "alchemy_relic_2"
RECIPE.sname = "relic"
RECIPE.title = "Alchemy Relic"
RECIPE.description = "Level 2"
RECIPE.xp = 560
RECIPE.skill = "alchemy"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "alchemy_relic_3"
RECIPE.sname = "relic"
RECIPE.title = "Alchemy Relic"
RECIPE.description = "Level 3"
RECIPE.xp = 880
RECIPE.skill = "alchemy"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "combat_relic_1"
RECIPE.sname = "relic"
RECIPE.title = "Combat Relic"
RECIPE.description = "Level 1"
RECIPE.xp = 160
RECIPE.skill = "combat"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "combat_relic_2"
RECIPE.sname = "relic"
RECIPE.title = "Combat Relic"
RECIPE.description = "Level 2"
RECIPE.xp = 560
RECIPE.skill = "combat"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "combat_relic_3"
RECIPE.sname = "relic"
RECIPE.title = "Combat Relic"
RECIPE.description = "Level 3"
RECIPE.xp = 880
RECIPE.skill = "combat"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "arcane_relic_1"
RECIPE.sname = "relic"
RECIPE.title = "Arcane Relic"
RECIPE.description = "Level 1"
RECIPE.xp = 160
RECIPE.skill = "arcane"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "arcane_relic_2"
RECIPE.sname = "relic"
RECIPE.title = "Arcane Relic"
RECIPE.description = "Level 2"
RECIPE.xp = 560
RECIPE.skill = "arcane"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )

RECIPE = {}
RECIPE.name = "arcane_relic_3"
RECIPE.sname = "relic"
RECIPE.title = "Arcane Relic"
RECIPE.description = "Level 3"
RECIPE.xp = 880
RECIPE.skill = "arcane"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "relic", RECIPE )


RECIPE = {}
RECIPE.name = "cooking_artifact_1"
RECIPE.sname = "artifact"
RECIPE.title = "Cooking Artifact"
RECIPE.description = "Level 1"
RECIPE.xp = 950
RECIPE.skill = "cooking"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "cooking_artifact_2"
RECIPE.sname = "artifact"
RECIPE.title = "Cooking Artifact"
RECIPE.description = "Level 2"
RECIPE.xp = 1350
RECIPE.skill = "cooking"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "woodcutting_artifact_1"
RECIPE.sname = "artifact"
RECIPE.title = "Woodcutting Artifact"
RECIPE.description = "Level 1"
RECIPE.xp = 950
RECIPE.skill = "woodcutting"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "woodcutting_artifact_2"
RECIPE.sname = "artifact"
RECIPE.title = "Woodcutting Artifact"
RECIPE.description = "Level 2"
RECIPE.xp = 1350
RECIPE.skill = "woodcutting"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "fishing_artifact_1"
RECIPE.sname = "artifact"
RECIPE.title = "Fishing Artifact"
RECIPE.description = "Level 1"
RECIPE.xp = 950
RECIPE.skill = "fishing"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "fishing_artifact_2"
RECIPE.sname = "artifact"
RECIPE.title = "Fishing Artifact"
RECIPE.description = "Level 2"
RECIPE.xp = 1350
RECIPE.skill = "fishing"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "farming_artifact_1"
RECIPE.sname = "artifact"
RECIPE.title = "Farming Artifact"
RECIPE.description = "Level 1"
RECIPE.xp = 950
RECIPE.skill = "farming"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "farming_artifact_2"
RECIPE.sname = "artifact"
RECIPE.title = "Farming Artifact"
RECIPE.description = "Level 2"
RECIPE.xp = 1350
RECIPE.skill = "farming"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "combat_artifact_1"
RECIPE.sname = "artifact"
RECIPE.title = "Combat Artifact"
RECIPE.description = "Level 1"
RECIPE.xp = 950
RECIPE.skill = "combat"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "combat_artifact_2"
RECIPE.sname = "artifact"
RECIPE.title = "Combat Artifact"
RECIPE.description = "Level 2"
RECIPE.xp = 1350
RECIPE.skill = "combat"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "mining_artifact_1"
RECIPE.sname = "artifact"
RECIPE.title = "Mining Artifact"
RECIPE.description = "Level 1"
RECIPE.xp = 950
RECIPE.skill = "mining"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "mining_artifact_2"
RECIPE.sname = "artifact"
RECIPE.title = "Mining Artifact"
RECIPE.description = "Level 2"
RECIPE.xp = 1350
RECIPE.skill = "mining"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "smithing_artifact_1"
RECIPE.sname = "artifact"
RECIPE.title = "Smithing Artifact"
RECIPE.description = "Level 1"
RECIPE.xp = 950
RECIPE.skill = "smithing"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "smithing_artifact_2"
RECIPE.sname = "artifact"
RECIPE.title = "Smithing Artifact"
RECIPE.description = "Level 2"
RECIPE.xp = 1350
RECIPE.skill = "smithing"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "construction_artifact_1"
RECIPE.sname = "artifact"
RECIPE.title = "Construction Artifact"
RECIPE.description = "Level 1"
RECIPE.xp = 950
RECIPE.skill = "construction"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "construction_artifact_2"
RECIPE.sname = "artifact"
RECIPE.title = "Construction Artifact"
RECIPE.description = "Level 2"
RECIPE.xp = 1350
RECIPE.skill = "construction"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "alchemy_artifact_1"
RECIPE.sname = "artifact"
RECIPE.title = "Alchemy Artifact"
RECIPE.description = "Level 1"
RECIPE.xp = 950
RECIPE.skill = "alchemy"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "alchemy_artifact_2"
RECIPE.sname = "artifact"
RECIPE.title = "Alchemy Artifact"
RECIPE.description = "Level 2"
RECIPE.xp = 1350
RECIPE.skill = "alchemy"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "arcane_artifact_1"
RECIPE.sname = "artifact"
RECIPE.title = "Arcane Artifact"
RECIPE.description = "Level 1"
RECIPE.xp = 950
RECIPE.skill = "arcane"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )

RECIPE = {}
RECIPE.name = "arcane_artifact_2"
RECIPE.sname = "artifact"
RECIPE.title = "Arcane Artifact"
RECIPE.description = "Level 2"
RECIPE.xp = 1350
RECIPE.skill = "arcane"
RECIPE.material = "vgui/relic_png.png"
Menu_RegisterFood( "artifact", RECIPE )


/*Easter Eggs*/


RECIPE = {}
RECIPE.name = "easter_egg"
RECIPE.sname = "easteregg"
Menu_RegisterFood( "easteregg", RECIPE )


/*MISC Non-Cookable Food*/
RECIPE = {}
RECIPE.name = "red_apple"
RECIPE.title = "Red Apple"
RECIPE.sname = "miscfood"
RECIPE.material = "vgui/cooking/cooked_bread.png"
RECIPE.description = "Juicy Red Apple!"
RECIPE.heal = 5
RECIPE.eatheal = 100
Menu_RegisterFood( "specialfood", RECIPE )


/*Special Non-Cookable Food*/

//2014 Easter Candy
RECIPE = {}
RECIPE.name = "jelly_beans"
RECIPE.title = "Jelly Beans"
RECIPE.sname = "specialfood"
RECIPE.material = "vgui/cooking/cooked_bread.png"
RECIPE.description = "Jelly Beans!\nEaster Event 2014"
RECIPE.heal = 25
RECIPE.eatheal = 250
Menu_RegisterFood( "specialfood", RECIPE )

RECIPE = {}
RECIPE.name = "chocolate_bunny"
RECIPE.title = "Chocolate Bunny"
RECIPE.sname = "specialfood"
RECIPE.material = "vgui/cooking/cooked_bread.png"
RECIPE.description = "Chocolate Bunny!\nEaster Event 2014"
RECIPE.heal = 25
RECIPE.eatheal = 250
Menu_RegisterFood( "specialfood", RECIPE )

//2015 Easter Candy

RECIPE = {}
RECIPE.name = "chocolate_egg"
RECIPE.title = "Chocolate Egg"
RECIPE.sname = "specialfood"
RECIPE.material = "vgui/cooking/cooked_bread.png"
RECIPE.description = "Milk Chocolate Easter Egg!\nEaster Event 2015"
RECIPE.heal = 25
RECIPE.eatheal = 250
Menu_RegisterFood( "specialfood", RECIPE )

RECIPE = {}
RECIPE.name = "salt_water_taffy"
RECIPE.title = "Salt Water Taffy"
RECIPE.sname = "specialfood"
RECIPE.material = "vgui/cooking/cooked_bread.png"
RECIPE.description = "Salt Water Taffy!\nEaster Event 2015"
RECIPE.heal = 25
RECIPE.eatheal = 250
Menu_RegisterFood( "specialfood", RECIPE )

//2016 Easter Candy

RECIPE = {}
RECIPE.name = "red_liquorice"
RECIPE.title = "Red Liquorice"
RECIPE.sname = "specialfood"
RECIPE.material = "vgui/cooking/cooked_bread.png"
RECIPE.description = "Chewy Red Liquorice!\nEaster Event 2016"
RECIPE.heal = 25
RECIPE.eatheal = 250
Menu_RegisterFood( "specialfood", RECIPE )

RECIPE = {}
RECIPE.name = "cotton_candy"
RECIPE.title = "Cotton Candy"
RECIPE.sname = "specialfood"
RECIPE.material = "vgui/cooking/cooked_bread.png"
RECIPE.description = "Cotton Candy!\nEaster Event 2016"
RECIPE.heal = 25
RECIPE.eatheal = 250
Menu_RegisterFood( "specialfood", RECIPE )

//2017 Easter Candy

RECIPE = {}
RECIPE.name = "gummy_bears"
RECIPE.title = "Gummy Bears"
RECIPE.sname = "specialfood"
RECIPE.material = "vgui/cooking/cooked_bread.png"
RECIPE.description = "Colorful!\nEaster Event 2017"
RECIPE.heal = 25
RECIPE.eatheal = 250
Menu_RegisterFood( "specialfood", RECIPE )

RECIPE = {}
RECIPE.name = "marshmallow_peeps"
RECIPE.title = "Marshmallow Peeps"
RECIPE.sname = "specialfood"
RECIPE.material = "vgui/cooking/cooked_bread.png"
RECIPE.description = "They look like little rabbits!\nEaster Event 2017"
RECIPE.heal = 25
RECIPE.eatheal = 250
Menu_RegisterFood( "specialfood", RECIPE )