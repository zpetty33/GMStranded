SGS.stats = {}
function SGS_RegisterStat( category, statid, desc )

	if not SGS.stats[category] then
		SGS.stats[category] = {}
	end
	SGS.stats[category][statid] = desc

end




/* === General Stats === */
SGS_RegisterStat( "general", "general1", "Water Drank" ) --Done
SGS_RegisterStat( "general", "general2", "Berries Eaten" ) --Done
SGS_RegisterStat( "general", "general3", "Times Slept" ) --Done
SGS_RegisterStat( "general", "general4", "Melonaids Contracted" ) --Done
SGS_RegisterStat( "general", "general5", "Deaths" ) --Done
SGS_RegisterStat( "general", "general6", "Deaths by Hunger" ) --Done
SGS_RegisterStat( "general", "general7", "Deaths by Thirst" ) --Done
SGS_RegisterStat( "general", "general8", "Deaths by Falling" ) --Done
SGS_RegisterStat( "general", "general9", "Deaths by Melonaids" ) --Done
SGS_RegisterStat( "general", "general10", "Deaths by Drowning" ) --Done
SGS_RegisterStat( "general", "general11", "Relics Used" ) --Done
SGS_RegisterStat( "general", "general12", "Artifacts Used" ) --Done
SGS_RegisterStat( "general", "general13", "GTokens Found" ) --Done
SGS_RegisterStat( "general", "general14", "GTokens Spent" ) --Done
SGS_RegisterStat( "general", "general15", "Pet Eggs Found" ) --Done
SGS_RegisterStat( "general", "general16", "Pet Eggs Hatched" )
SGS_RegisterStat( "general", "general17", "Void Caches Found" )
SGS_RegisterStat( "general", "general18", "Void Caches Opened" )

/* === Time Stats === */
SGS_RegisterStat( "time played", "time1", "Time Played (Minutes)" )
SGS_RegisterStat( "time played", "time2", "Time Spent AFK (Minutes)" )
SGS_RegisterStat( "time played", "time3", "Times Connected" )

/* === Pet Stats === */
SGS_RegisterStat( "pets", "pets1", "Red Eggs Hatched" ) --Done
SGS_RegisterStat( "pets", "pets2", "Pink Eggs Hatched" ) --Done
SGS_RegisterStat( "pets", "pets3", "White Eggs Hatched" ) --Done
SGS_RegisterStat( "pets", "pets4", "Yellow Eggs Hatched" ) --Done
SGS_RegisterStat( "pets", "pets5", "Black Eggs Hatched" ) --Done
SGS_RegisterStat( "pets", "pets6", "Orange Eggs Hatched" ) --Done
SGS_RegisterStat( "pets", "pets7", "Green Eggs Hatched" ) --Done
SGS_RegisterStat( "pets", "pets8", "Blue Eggs Hatched" ) --Done
SGS_RegisterStat( "pets", "pets9", "Brown Eggs Hatched" ) --Done
SGS_RegisterStat( "pets", "pets10", "Gray Eggs Hatched" ) --Done
SGS_RegisterStat( "pets", "pets11", "Pet Raised to Old Age" )
SGS_RegisterStat( "pets", "pets12", "Teal Eggs Hatched" ) --Done

/* === Woodcutting Stats === */
SGS_RegisterStat( "woodcutting", "woodcutting1", "Wood Collected" ) --Done
SGS_RegisterStat( "woodcutting", "woodcutting2", "Trees Felled" ) --Done
SGS_RegisterStat( "woodcutting", "woodcutting3", "Enchanted Wood Found" ) --Done

/* === Mining Stats === */
SGS_RegisterStat( "mining", "mining1", "Stone Collected" ) --Done
SGS_RegisterStat( "mining", "mining2", "Iron Collected" ) --Done
SGS_RegisterStat( "mining", "mining3", "Coal Collected" ) --Done
SGS_RegisterStat( "mining", "mining4", "Silver Collected" ) --Done
SGS_RegisterStat( "mining", "mining5", "Trinium Collected" ) --Done
SGS_RegisterStat( "mining", "mining6", "Naquadah Collected" ) --Done
SGS_RegisterStat( "mining", "mining7", "Ore Rocks Depleted" ) --Done
SGS_RegisterStat( "mining", "mining8", "Gems Found" ) --Done
SGS_RegisterStat( "mining", "mining9", "Enchanted Metal Found" ) --Done
SGS_RegisterStat( "mining", "mining10", "Mithril Collected" ) --Done
SGS_RegisterStat( "mining", "mining11", "Gold Collected" ) --Done
SGS_RegisterStat( "mining", "mining12", "Platinum Collected" ) --Done

/* === Farming Stats === */
SGS_RegisterStat( "farming", "farming1", "Seeds Planted" ) --Done
SGS_RegisterStat( "farming", "farming2", "Seeds Foraged" ) --Done
SGS_RegisterStat( "farming", "farming3", "Golden Melons Eaten" ) --Done

/* === Fishing Stats === */
SGS_RegisterStat( "fishing", "fishing1", "Fish Caught" ) --Done
SGS_RegisterStat( "fishing", "fishing2", "Fish Lost" ) --Done

/* === Smithing Stats === */
SGS_RegisterStat( "smithing", "smithing1", "Tools Created" ) --Done
SGS_RegisterStat( "smithing", "smithing2", "Ore Smelted" ) --Done
SGS_RegisterStat( "smithing", "smithing3", "Ore Impure" ) --Done
SGS_RegisterStat( "smithing", "smithing4", "Ore Crushed" ) --Done

/* === Cooking Stats === */
SGS_RegisterStat( "cooking", "cooking1", "Fish Cooked" ) --Done
SGS_RegisterStat( "cooking", "cooking2", "Pies Cooked" ) --Done
SGS_RegisterStat( "cooking", "cooking3", "Pizzas Cooked" ) --Done
SGS_RegisterStat( "cooking", "cooking4", "Meat Cooked" ) --Done
SGS_RegisterStat( "cooking", "cooking5", "Fish Burned" ) --Done
SGS_RegisterStat( "cooking", "cooking6", "Pies Burned" ) --Done
SGS_RegisterStat( "cooking", "cooking7", "Pizzas Burned" ) --Done
SGS_RegisterStat( "cooking", "cooking8", "Steak Burned" ) --Done
SGS_RegisterStat( "cooking", "cooking9", "Total Food Cooked" ) --Done


/* === Construction Stats === */
SGS_RegisterStat( "construction", "construction1", "Props Constructed" ) --Done
SGS_RegisterStat( "construction", "construction2", "Props Deconstructed" ) --Done
SGS_RegisterStat( "construction", "construction3", "Structures Constructed" ) --Done

/* === Combat Stats === */
SGS_RegisterStat( "combat", "combat1", "Antlion Kills" ) --Done
SGS_RegisterStat( "combat", "combat2", "Antlion Deaths" ) --Done
SGS_RegisterStat( "combat", "combat3", "Boss Kills" ) --Done
SGS_RegisterStat( "combat", "combat4", "Boss Deaths" ) --Done
SGS_RegisterStat( "combat", "combat5", "PvP Kills" ) --Done
SGS_RegisterStat( "combat", "combat6", "PvP Deaths" ) --Done
SGS_RegisterStat( "combat", "combat7", "Times killed MrPresident" )
SGS_RegisterStat( "combat", "combat8", "Zombie Kills" ) --Done


/* === Alchemy Stats === */
SGS_RegisterStat( "alchemy", "alchemy1", "Potions Brewed" ) --Done
SGS_RegisterStat( "alchemy", "alchemy2", "Potions Drank" ) --Done
SGS_RegisterStat( "alchemy", "alchemy3", "Artifacts Identified" ) --Done
SGS_RegisterStat( "alchemy", "alchemy4", "Alchemy Transmutations" ) --Done

/* === Arcane Stats === */
SGS_RegisterStat( "arcane", "arcane1", "Bolts Cast" ) --Done
SGS_RegisterStat( "arcane", "arcane2", "Teleports Cast" ) --Done
SGS_RegisterStat( "arcane", "arcane3", "Stones Used" ) --Done
SGS_RegisterStat( "arcane", "arcane4", "Stones Crafted" ) --Done

/* === Bloodmoon Stats === */
SGS_RegisterStat( "bloodmoon", "bloodmoon1", "Blood Moons Survived" ) --Done
SGS_RegisterStat( "bloodmoon", "bloodmoon2", "Blood Zombies Killed" ) --Done
SGS_RegisterStat( "bloodmoon", "bloodmoon3", "Deaths by Blood Zombies" ) --Done
SGS_RegisterStat( "bloodmoon", "bloodmoon4", "Times bled to death" ) --Done