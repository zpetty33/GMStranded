SGS.SpellList = {}
function Menu_RegisterSPell( spell )
	SGS.SpellList[#SGS.SpellList + 1] = spell
end

SPELL = {}
SPELL.name = "Wind Bolt"
SPELL.description = "Cast a bolt of wind at your enemies!"
SPELL.cost = { wind_stone = 2 }
SPELL.reqlvl = 1
SPELL.exp = 6
SPELL.material = "vgui/spells/new/windbolt.png"
SPELL.spell = "windbolt"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Water Bolt"
SPELL.description = "Cast a bolt of water at your enemies!"
SPELL.cost = { water_stone = 2 }
SPELL.reqlvl = 5
SPELL.exp = 8
SPELL.material = "vgui/spells/new/waterbolt.png"
SPELL.spell = "waterbolt"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Earth Bolt"
SPELL.description = "Cast a bolt of earth at your enemies!"
SPELL.cost = { earth_stone = 2 }
SPELL.reqlvl = 10
SPELL.exp = 20
SPELL.material = "vgui/spells/new/earthbolt.png"
SPELL.spell = "earthbolt"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Fire Bolt"
SPELL.description = "Cast a bolt of fire at your enemies!"
SPELL.cost = { fire_stone = 2 }
SPELL.reqlvl = 15
SPELL.exp = 25
SPELL.material = "vgui/spells/new/firebolt.png"
SPELL.spell = "firebolt"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Wind Blast"
SPELL.description = "Cast a blast of wind at your enemies!"
SPELL.cost = { wind_stone = 4, chaos_stone = 1 }
SPELL.reqlvl = 20
SPELL.exp = 30
SPELL.material = "vgui/spells/new/windblast.png"
SPELL.spell = "windblast"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Water Blast"
SPELL.description = "Cast a blast of water at your enemies!"
SPELL.cost = { water_stone = 4, chaos_stone = 1 }
SPELL.reqlvl = 26
SPELL.exp = 36
SPELL.material = "vgui/spells/new/waterblast.png"
SPELL.spell = "waterblast"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Earth Blast"
SPELL.description = "Cast a blast of earth at your enemies!"
SPELL.cost = { earth_stone = 4, chaos_stone = 1 }
SPELL.reqlvl = 33
SPELL.exp = 44
SPELL.material = "vgui/spells/new/earthblast.png"
SPELL.spell = "earthblast"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Fire Blast"
SPELL.description = "Cast a blast of fire at your enemies!"
SPELL.cost = { fire_stone = 4, chaos_stone = 1 }
SPELL.reqlvl = 40
SPELL.exp = 50
SPELL.material = "vgui/spells/new/fireblast.png"
SPELL.spell = "fireblast"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Wind Wave"
SPELL.description = "Cast a wave of wind at your enemies!"
SPELL.cost = { wind_stone = 8, chaos_stone = 2 }
SPELL.reqlvl = 45
SPELL.exp = 56
SPELL.material = "vgui/spells/new/windwave.png"
SPELL.spell = "windwave"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Water Wave"
SPELL.description = "Cast a wave of water at your enemies!"
SPELL.cost = { water_stone = 8, chaos_stone = 2 }
SPELL.reqlvl = 50
SPELL.exp = 60
SPELL.material = "vgui/spells/new/waterwave.png"
SPELL.spell = "waterwave"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Earth Wave"
SPELL.description = "Cast a wave of earth at your enemies!"
SPELL.cost = { earth_stone = 8, chaos_stone = 2 }
SPELL.reqlvl = 55
SPELL.exp = 65
SPELL.material = "vgui/spells/new/earthwave.png"
SPELL.spell = "earthwave"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Fire Wave"
SPELL.description = "Cast a wave of fire at your enemies!"
SPELL.cost = { fire_stone = 8, chaos_stone = 2 }
SPELL.reqlvl = 60
SPELL.exp = 70
SPELL.material = "vgui/spells/new/firewave.png"
SPELL.spell = "firewave"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Spawn Teleport"
SPELL.description = "Teleport back to the map spawn location."
SPELL.cost = { wind_stone = 1, water_stone = 1, cosmic_stone = 1 }
SPELL.reqlvl = 5
SPELL.exp = 10
SPELL.material = "vgui/spells/new/spawnteleport.png"
SPELL.spell = "spawnteleport"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Set Teleport Location"
SPELL.description = "Sets a custom teleport location. You can only have one."
SPELL.cost = { fire_stone = 5, water_stone = 2, cosmic_stone = 1 }
SPELL.reqlvl = 10
SPELL.exp =  25
SPELL.material = "vgui/spells/new/setteleportlocation.png"
SPELL.spell = "setteleportlocation"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Telport to Set Location"
SPELL.description = "Teleports you to a previously set location. If none found, will teleport you to spawn."
SPELL.cost = { earth_stone = 2, wind_stone = 4, cosmic_stone = 1 }
SPELL.reqlvl = 10
SPELL.exp = 25
SPELL.material = "vgui/spells/new/teleporttosetlocation.png"
SPELL.spell = "teleporttosetlocation"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Teleport to Cursor"
SPELL.description = "Teleport where your cursor is pointing. Beware, you might get stuck!"
SPELL.cost = { wind_stone = 1, water_stone = 1, earth_stone = 1, fire_stone = 1, cosmic_stone = 1 }
SPELL.reqlvl = 20
SPELL.exp = 35
SPELL.material = "vgui/spells/new/teleporttocursor.png"
SPELL.spell = "teleporttocursor"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Consume Tree"
SPELL.description = "Magically chops down a tree!"
SPELL.cost = { earth_stone = 5, fire_stone = 2, nature_stone = 1 }
SPELL.reqlvl = 30
SPELL.exp = 45
SPELL.material = "vgui/spells/new/consumetree.png"
SPELL.spell = "consumetree"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Gather Resources"
SPELL.description = "Magically collects items dropped from mining and foresting."
SPELL.cost = { earth_stone = 2, wind_stone = 2, nature_stone = 1 }
SPELL.reqlvl = 15
SPELL.exp = 30
SPELL.material = "vgui/spells/new/collectresources.png"
SPELL.spell = "collectresources"
Menu_RegisterSPell( SPELL )

--[[
SPELL = {}
SPELL.name = "Call Rain"
SPELL.description = "Calls forth a rain shower."
SPELL.cost = { water_stone = 30, wind_stone = 10, nature_stone = 2 }
SPELL.reqlvl = 50
SPELL.exp = 75
SPELL.material = "vgui/spells/new/callrain.png"
SPELL.spell = "callrain"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Stop Rain"
SPELL.description = "Stops an ongoing rain storm."
SPELL.cost = { fire_stone = 20, wind_stone = 10, nature_stone = 2 }
SPELL.reqlvl = 50
SPELL.exp = 75
SPELL.material = "vgui/spells/new/stoprain.png"
SPELL.spell = "stoprain"
Menu_RegisterSPell( SPELL )
]]

SPELL = {}
SPELL.name = "Set Time: Midnight"
SPELL.description = "Magically adjusts the time to midnight."
SPELL.cost = { earth_stone = 20, nature_stone = 5 }
SPELL.reqlvl = 55
SPELL.exp = 70
SPELL.material = "vgui/spells/new/setnight.png"
SPELL.spell = "setnight"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Set Time: Noon"
SPELL.description = "Magically adjusts the time to noon."
SPELL.cost = { water_stone = 20, nature_stone = 5 }
SPELL.reqlvl = 45
SPELL.exp = 60
SPELL.material = "vgui/spells/new/setday.png"
SPELL.spell = "setday"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Set Time: Dawn"
SPELL.description = "Magically adjusts the time to dawn."
SPELL.cost = { wind_stone = 20, nature_stone = 5 }
SPELL.reqlvl = 50
SPELL.exp = 70
SPELL.material = "vgui/spells/new/setdawn.png"
SPELL.spell = "setdawn"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Set Time: Dusk"
SPELL.description = "Magically adjusts the time to dusk."
SPELL.cost = { fire_stone = 20, nature_stone = 5 }
SPELL.reqlvl = 60
SPELL.exp = 80
SPELL.material = "vgui/spells/new/setdusk.png"
SPELL.spell = "setdusk"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Kill Berries"
SPELL.description = "Causes all berries in a radius around you to drop off their plants."
SPELL.cost = { fire_stone = 10, nature_stone = 3 }
SPELL.reqlvl = 50
SPELL.exp = 65
SPELL.material = "vgui/spells/new/killfruit.png"
SPELL.spell = "killfruit"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Grow Seeds"
SPELL.description = "Cause all seeds near where you cast to grow instantly."
SPELL.cost = { water_stone = 15, nature_stone = 3 }
SPELL.reqlvl = 35
SPELL.exp = 55
SPELL.material = "vgui/spells/new/growseeds.png"
SPELL.spell = "growseeds"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Personal Light"
SPELL.description = "A floating light will follow you around for a short time."
SPELL.cost = { fire_stone = 10, nature_stone = 2 }
SPELL.reqlvl = 10
SPELL.exp = 25
SPELL.material = "vgui/spells/new/selflight.png"
SPELL.spell = "selflight"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Heal: Self"
SPELL.description = "Heals yourself for an amount based on your arcane level."
SPELL.cost = { water_stone = 2, nature_stone = 1 }
SPELL.reqlvl = 5
SPELL.exp = 15
SPELL.material = "vgui/spells/new/healself.png"
SPELL.spell = "healself"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Heal: Other"
SPELL.description = "Heals your target for an amount based on your arcane level."
SPELL.cost = { water_stone = 2, wind_stone = 1, nature_stone = 1 }
SPELL.reqlvl = 35
SPELL.exp = 60
SPELL.material = "vgui/spells/new/healother.png"
SPELL.spell = "healother"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Cure: Self"
SPELL.description = "Cures yourself of any disease/illness."
SPELL.cost = { fire_stone = 5, earth_stone = 5, nature_stone = 2 }
SPELL.reqlvl = 15
SPELL.exp = 35
SPELL.material = "vgui/spells/new/cureself.png"
SPELL.spell = "cureself"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Cure: Other"
SPELL.description = "Cures your target of any disease/illness."
SPELL.cost = { fire_stone = 5, earth_stone = 5, wind_stone = 5, nature_stone = 2 }
SPELL.reqlvl = 50
SPELL.exp = 75
SPELL.material = "vgui/spells/new/cureother.png"
SPELL.spell = "cureother"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Resurrect"
SPELL.description = "Resurrect target dead player."
SPELL.cost = { cosmic_stone = 5, wind_stone = 5, nature_stone = 5 }
SPELL.reqlvl = 30
SPELL.exp = 55
SPELL.material = "vgui/spells/new/resurrect.png"
SPELL.spell = "resurrect"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Mass Resurrection"
SPELL.description = "Resurrects all tribe members who are near you"
SPELL.cost = { }
SPELL.reqlvl = 1
SPELL.tribelevel = 9
SPELL.exp = 0
SPELL.material = "vgui/spells/new/massresurrection.png"
SPELL.spell = "massres"
Menu_RegisterSPell( SPELL )

SPELL = {}
SPELL.name = "Summon Tribe Cache"
SPELL.description = "Summons your Tribe's Cache to you"
SPELL.cost = { }
SPELL.reqlvl = 1
SPELL.tribelevel = 5
SPELL.exp = 0
SPELL.material = "vgui/spells/new/tribecache.png"
SPELL.spell = "cache"
Menu_RegisterSPell( SPELL )