SGS.Ach = {}
function Achievement_RegisterAchievement( ach )
	SGS.Ach[#SGS.Ach + 1] = ach
end

local ACH = {}
ACH.short = "santahat"
ACH.long = "Naughty or Nice?"
ACH.cc = "sgs_equiphat santahat"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.show = true
ACH.displaytext = "Obtained during the Christmas Event"
ACH.reward = "Santa Hat"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "3yearhat"
ACH.long = "G4P Stranded 3 Year Anniversary"
ACH.cc = "sgs_equiphat 3yearhat"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.show = true
ACH.displaytext = "Play during the 3 year anniversary event"
ACH.reward = "3 Year Anniversary Hat"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "inventory1"
ACH.long = "Inventory Cap Increase - Level 1"
ACH.cc = "sgs_recalculatemaxinv"
ACH.show = true
ACH.displaytext = "Purchased from Vorty"
ACH.reward = "Increases max inventory by 50"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "inventory2"
ACH.long = "Inventory Cap Increase - Level 2"
ACH.cc = "sgs_recalculatemaxinv"
ACH.show = true
ACH.displaytext = "Purchased from Vorty"
ACH.reward = "Increases max inventory by 100"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "maxpets1"
ACH.long = "Pet House Upgrade - Level 1"
ACH.cc = "sgs_recalculatemaxpets"
ACH.show = true
ACH.displaytext = "Purchased from Vorty"
ACH.reward = "Increases pet house capacity by 5"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "maxpets2"
ACH.long = "Pet House Upgrade - Level 2"
ACH.cc = "sgs_recalculatemaxpets"
ACH.show = true
ACH.displaytext = "Purchased from Vorty"
ACH.reward = "Increases pet house capacity by 5"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "planting1"
ACH.long = "Max Plant Increase - Level 1"
ACH.cc = "sgs_recalculatemaxplants"
ACH.show = true
ACH.displaytext = "Purchased from Vorty"
ACH.reward = "Raises max plant cap by 3"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "planting2"
ACH.long = "Max Plant Increase - Level 2"
ACH.cc = "sgs_recalculatemaxplants"
ACH.show = true
ACH.displaytext = "Purchased from Vorty"
ACH.reward = "Raises max plant cap by 6"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "bunnyears"
ACH.long = "The Ears Are The Best Part"
ACH.cc = "sgs_equiphat bunnyears"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.show = true
ACH.displaytext = "Obtained from the Easter Event."
ACH.reward = "Bunny Ears Hat"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "headcrabhat"
ACH.long = "They Grow Up So Fast"
ACH.cc = "sgs_equiphat headcrabhat"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.show = true
ACH.displaytext = "Hatch one of each color egg."
ACH.reward = "Headcrab Hat"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "chefhat"
ACH.long = "Cooking for Two ... Thousand"
ACH.cc = "sgs_equiphat chefhat"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.show = true
ACH.displaytext = "Cook 2000 items on the stove."
ACH.reward = "Chef Hat"
ACH.associatedstat = "cooking9"
ACH.statneeded = "2000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "farminghat"
ACH.long = "Farming Hat"
ACH.cc = "sgs_equiphat farminghat"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.show = true
ACH.displaytext = "Eat 25 Golden Melons."
ACH.reward = "Farming Hat"
ACH.associatedstat = "farming3"
ACH.statneeded = "25"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "goggleshat"
ACH.long = "Assassinate the President"
ACH.cc = "sgs_equiphat goggleshat"
ACH.show = true
ACH.displaytext = "Kill the President in PvP."
ACH.reward = "Special Hat"
ACH.associatedstat = "combat7"
ACH.statneeded = "1"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "squirrelhat"
ACH.long = "Caretaker"
ACH.cc = "sgs_equiphat squirrelhat"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.show = true
ACH.displaytext = "Raise 30 pets to fully grown."
ACH.reward = "Squirrel Buddy"
ACH.associatedstat = "pets11"
ACH.statneeded = "30"
Achievement_RegisterAchievement( ACH )


local ACH = {}
ACH.short = "robotbuddy"
ACH.long = "Robot Buddy"
ACH.cc = "sgs_equiphat robotbuddy"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "crownhat"
ACH.long = "It's Good To Be King!"
ACH.cc = "sgs_equiphat crownhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "billycockhat"
ACH.long = "Billycock Hat"
ACH.cc = "sgs_equiphat billycockhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "treasurehat"
ACH.long = "Treasure Hat"
ACH.cc = "sgs_equiphat treasurehat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "mininghat"
ACH.long = "Oooo... Shiny!"
ACH.cc = "sgs_equiphat mininghat"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.show = true
ACH.displaytext = "Mine 500+ Gems."
ACH.reward = "Mining Helmet"
ACH.associatedstat = "mining8"
ACH.statneeded = "500"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "flathat"
ACH.long = "Flat Hat"
ACH.cc = "sgs_equiphat flathat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "presshat"
ACH.long = "Stop The Presses!"
ACH.cc = "sgs_equiphat presshat"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.show = true
ACH.displaytext = "Find 10000 GTokens."
ACH.reward = "Press Hat"
ACH.associatedstat = "general13"
ACH.statneeded = "10000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "treasurehat2"
ACH.long = "Treasure Hat 2"
ACH.cc = "sgs_equiphat treasurehat2"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "wizardhat"
ACH.long = "I Put On My Robe And Wizard Hat"
ACH.cc = "sgs_equiphat wizardhat"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.show = true
ACH.displaytext = "Use 2500 Arcane Stones casting spells."
ACH.reward = "Wizard Hat"
ACH.associatedstat = "arcane3"
ACH.statneeded = "2500"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "soldierhat"
ACH.long = "Soldier Hat"
ACH.cc = "sgs_equiphat soldierhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "pilothelmethat"
ACH.long = "Pilot Helmet Hat"
ACH.cc = "sgs_equiphat pilothelmethat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "civilwarhat"
ACH.long = "Civil War Hat"
ACH.cc = "sgs_equiphat civilwarhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "dragonbornhat"
ACH.long = "Dragonborn Hat"
ACH.cc = "sgs_equiphat dragonbornhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "drseusshat"
ACH.long = "Dr. Seuss Hat"
ACH.cc = "sgs_equiphat drseusshat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "notchhat"
ACH.long = "Notch Head Hat"
ACH.cc = "sgs_equiphat notchhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "captainshat"
ACH.long = "Captain's Hat"
ACH.cc = "sgs_equiphat captainshat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "oldarmyhat"
ACH.long = "Old Army Hat"
ACH.cc = "sgs_equiphat oldarmyhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "russianhat"
ACH.long = "Russian Hat"
ACH.cc = "sgs_equiphat russianhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "cowboyhat"
ACH.long = "Cowboy Hat"
ACH.cc = "sgs_equiphat cowboyhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "chiefhat"
ACH.long = "Cowboy Hat"
ACH.cc = "sgs_equiphat chiefhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "flamincohat"
ACH.long = "Flaminco Hat"
ACH.cc = "sgs_equiphat flamincohat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "hoodedmaskhat"
ACH.long = "Hooded Mask Hat"
ACH.cc = "sgs_equiphat hoodedmaskhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "robinhoodhat"
ACH.long = "Robin Hood Hat"
ACH.cc = "sgs_equiphat robinhoodhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "generalhat"
ACH.long = "General's Hat"
ACH.cc = "sgs_equiphat generalhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "berethat"
ACH.long = "Beret hat"
ACH.cc = "sgs_equiphat berethat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "featherhat"
ACH.long = "Feathered Hat"
ACH.cc = "sgs_equiphat featherhat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "detectivehat"
ACH.long = "Detective Hat"
ACH.cc = "sgs_equiphat detectivehat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "drillsergeanthat"
ACH.long = "Drill Sergeant Hat"
ACH.cc = "sgs_equiphat drillsergeanthat"
ACH.at = "Access Q > Options menu to equip your new hat."
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "betaprogram"
ACH.long = "Beta Program Participant"
ACH.at = "You can now perform actions reserved for beta program participants."
Achievement_RegisterAchievement( ACH )


--[[
TIME ACHIEVEMENTS
]]

local ACH = {}
ACH.short = "time1"
ACH.long = "How did I get here?"
ACH.show = true
ACH.displaytext = "Play on the server for 1 hour."
ACH.associatedstat = "time1"
ACH.statneeded = "60"
ACH.stat_divisor = 60
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "time2"
ACH.long = "I guess it's not so bad."
ACH.show = true
ACH.displaytext = "Play on the server for 10 hours."
ACH.associatedstat = "time1"
ACH.statneeded = "600"
ACH.stat_divisor = 60
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "time3"
ACH.long = "Maybe I was never really stranded..."
ACH.show = true
ACH.displaytext = "Play on the server for 50 hours."
ACH.associatedstat = "time1"
ACH.statneeded = "3000"
ACH.stat_divisor = 60
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "time4"
ACH.long = "What am I doing with my life?"
ACH.show = true
ACH.displaytext = "Play on the server for 100 hours."
ACH.associatedstat = "time1"
ACH.statneeded = "6000"
ACH.stat_divisor = 60
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "time5"
ACH.long = "King of the Island!"
ACH.show = true
ACH.displaytext = "Play on the server for 150 hours."
ACH.associatedstat = "time1"
ACH.statneeded = "9000"
ACH.stat_divisor = 60
ACH.reward = "Veteran Rank"
Achievement_RegisterAchievement( ACH )

--[[
	MISC ACHIEVEMENTS
]]

local ACH = {}
ACH.short = "steamgroup"
ACH.long = "Community Member"
ACH.show = true
ACH.displaytext = "Join the G4P Group on Steam (Requires Survival Level 5+)"
ACH.cc = "sgs_equiphat steamgroup"
ACH.at = "Access Q > Options menu to equip your new hat."
ACH.reward = "Community Hat / 2500 GTokens"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "secretworld"
ACH.long = "Been there, Done that!"
ACH.show = true
ACH.displaytext = "Visit the secret world to unlock this achievement"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "voidcache1"
ACH.long = "Keeper of the Void"
ACH.show = true
ACH.displaytext = "Find 100 Void Caches"
ACH.associatedstat = "general17"
ACH.statneeded = "100"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "voidcache2"
ACH.long = "Void Gambler"
ACH.show = true
ACH.displaytext = "Open 50 Void Caches"
ACH.associatedstat = "general18"
ACH.statneeded = "50"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "zombieslayer"
ACH.long = "Zombie Slayer!"
ACH.show = true
ACH.displaytext = "Kill 1000 Zombies"
ACH.associatedstat = "combat8"
ACH.statneeded = "1000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "bloodchampion"
ACH.long = "Blood Champion!"
ACH.show = true
ACH.displaytext = "Survive 100 Blood Moons"
ACH.associatedstat = "bloodmoon1"
ACH.statneeded = "100"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "fishmaster"
ACH.long = "Master Fisherman"
ACH.show = true
ACH.displaytext = "Catch 10000 Fish"
ACH.associatedstat = "fishing1"
ACH.statneeded = "10000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "woodcuttingmaster"
ACH.long = "Master Lumberjack"
ACH.show = true
ACH.displaytext = "Fell 10000 Trees"
ACH.associatedstat = "woodcutting2"
ACH.statneeded = "10000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "miningmaster"
ACH.long = "Master Miner"
ACH.show = true
ACH.displaytext = "Deplete 10000 Ore Rocks"
ACH.associatedstat = "mining7"
ACH.statneeded = "10000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "constructionmaster"
ACH.long = "Master Craftsman"
ACH.show = true
ACH.displaytext = "Construct 10000 Props"
ACH.associatedstat = "construction1"
ACH.statneeded = "10000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "farmingmaster"
ACH.long = "Master Farmer"
ACH.show = true
ACH.displaytext = "Plant 10000 Seeds"
ACH.associatedstat = "farming1"
ACH.statneeded = "10000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "smithingmaster"
ACH.long = "Master Blacksmith"
ACH.show = true
ACH.displaytext = "Smelt 10000 Ore"
ACH.associatedstat = "smithing2"
ACH.statneeded = "10000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "arcanemaster"
ACH.long = "Master Arcanist"
ACH.show = true
ACH.displaytext = "Cast 10000 Bolt Spells"
ACH.associatedstat = "arcane1"
ACH.statneeded = "10000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "alchemymaster"
ACH.long = "Master Alchemist"
ACH.show = true
ACH.displaytext = "Perform 10000 Transmutations"
ACH.associatedstat = "alchemy4"
ACH.statneeded = "10000"
Achievement_RegisterAchievement( ACH )

local ACH = {}
ACH.short = "cookingmaster"
ACH.long = "Master Chef"
ACH.show = true
ACH.displaytext = "Cook 10000 Food Items"
ACH.associatedstat = "cooking9"
ACH.statneeded = "10000"
Achievement_RegisterAchievement( ACH )