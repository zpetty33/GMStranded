SGS.Commands = {}

function Menu_RegisterCommand( category, cmd )
	if not SGS.Commands[category] then SGS.Commands[category] = {} end
	
	SGS.Commands[category][#SGS.Commands[category] + 1] = cmd
end

--[[*****************************************************
*********************************************************
						Game Menu
*********************************************************
*****************************************************]]--

local CMD = {}
CMD.title = "Sleep"
CMD.description = "Sleep to restore fatigue!"
CMD.command = {"sgs_sleep"}
Menu_RegisterCommand( "game", CMD )

local CMD = {}
CMD.title = "Save"
CMD.description = "Save early! Save often!"
CMD.command = {"sgs_save"}
Menu_RegisterCommand( "game", CMD )

local CMD = {}
CMD.title = "Unstuck"
CMD.description = "Returns you to spawn in case you get stuck!"
CMD.command = {"sgs_unstuck"}
Menu_RegisterCommand( "game", CMD )

local CMD = {}
CMD.title = "Bottle Water"
CMD.description = "Bottles water for later use!"
CMD.command = {"sgs_bottlewater"}
Menu_RegisterCommand( "game", CMD )

local CMD = {}
CMD.title = "Drink Water Bottle"
CMD.description = "Drinks a bottled water from your inventory!"
CMD.command = {"sgs_drinkbottle"}
Menu_RegisterCommand( "game", CMD )


--[[*****************************************************
*********************************************************
						Toggles
*********************************************************
*****************************************************]]--

local CMD = {}
CMD.title = "Toggle PvP"
CMD.description = "Toggles PvP!\nYou must wait 5 minutes after enabling PvP before you can disable it.\nThis is to prevent players simply toggling off PvP to stop from being killed."
CMD.command = {"sgs_togglepvp"}
Menu_RegisterCommand( "toggles", CMD )

local CMD = {}
CMD.title = "Gather Toggle"
CMD.description = "Toggles if pressing E will gather things. (Trees, Rocks, Seeds, etc)"
CMD.command = {"sgs_foragetoggle"}
Menu_RegisterCommand( "toggles", CMD )

local CMD = {}
CMD.title = "Toggle Perspective"
CMD.description = "Switch between first and third person view!"
CMD.command = {"sgs_toggleperson"}
Menu_RegisterCommand( "toggles", CMD )

local CMD = {}
CMD.title = "Toggle Grind Mode"
CMD.description = "With grind mode on, most farming actions won't drop resources"
CMD.command = {"sgs_togglegrindmode"}
Menu_RegisterCommand( "toggles", CMD )

local CMD = {}
CMD.title = "Toggle AFK"
CMD.description = "Sets you as AFK, your stats won't go down but you can't move or do anything."
CMD.command = {"sgs_afk"}
Menu_RegisterCommand( "toggles", CMD )

local CMD = {}
CMD.title = "Hide From Team"
CMD.description = "This will hide your name tag from teammates while you and they are in PVP."
CMD.command = {"sgs_togglehidefromteam"}
Menu_RegisterCommand( "toggles", CMD )

local CMD = {}
CMD.title = "Toggle View Distance"
CMD.description = "This will draw resources further away. Be warned.. this WILL lower your FPS."
CMD.command = {"sgs_toggleviewdistance"}
Menu_RegisterCommand( "toggles", CMD )


--[[*****************************************************
*********************************************************
					Client Options
*********************************************************
*****************************************************]]--

local CMD = {}
CMD.title = "Toggle Particles"
CMD.description = "Toggles Particles!"
CMD.command = {"sgs_toggleparticles"}
Menu_RegisterCommand( "client", CMD )

local CMD = {}
CMD.title = "Toggle Lighting"
CMD.description = "Toggles Dynamic Lighting!"
CMD.command = {"sgs_togglelighting"}
Menu_RegisterCommand( "client", CMD )


--[[*****************************************************
*********************************************************
						Special
*********************************************************
*****************************************************]]--

local CMD = {}
CMD.title = "Open Void Cache"
CMD.description = "Consume a void crystal to open a void cache"
CMD.command = {"sgs_openvoidcache"}
Menu_RegisterCommand( "special", CMD )

local CMD = {}
CMD.title = "Woodcutting Halo"
CMD.description = "Toggle display of your Max Skill Halo Effect"
CMD.command = {"sgs_toggleskill", "woodcutting"}
CMD.skillreq = "woodcutting"
Menu_RegisterCommand( "special", CMD )

local CMD = {}
CMD.title = "Mining Halo"
CMD.description = "Toggle display of your Max Skill Halo Effect"
CMD.command = {"sgs_toggleskill", "mining"}
CMD.skillreq = "mining"
Menu_RegisterCommand( "special", CMD )

local CMD = {}
CMD.title = "Cooking Halo"
CMD.description = "Toggle display of your Max Skill Halo Effect"
CMD.command = {"sgs_toggleskill", "cooking"}
CMD.skillreq = "cooking"
Menu_RegisterCommand( "special", CMD )

local CMD = {}
CMD.title = "Construction Halo"
CMD.description = "Toggle display of your Max Skill Halo Effect"
CMD.command = {"sgs_toggleskill", "construction"}
CMD.skillreq = "construction"
Menu_RegisterCommand( "special", CMD )

local CMD = {}
CMD.title = "Combat Halo"
CMD.description = "Toggle display of your Max Skill Halo Effect"
CMD.command = {"sgs_toggleskill", "combat"}
CMD.skillreq = "combat"
Menu_RegisterCommand( "special", CMD )

local CMD = {}
CMD.title = "Alchemy Halo"
CMD.description = "Toggle display of your Max Skill Halo Effect"
CMD.command = {"sgs_toggleskill", "alchemy"}
CMD.skillreq = "alchemy"
Menu_RegisterCommand( "special", CMD )

local CMD = {}
CMD.title = "Arcane Halo"
CMD.description = "Toggle display of your Max Skill Halo Effect"
CMD.command = {"sgs_toggleskill", "arcane"}
CMD.skillreq = "arcane"
Menu_RegisterCommand( "special", CMD )

local CMD = {}
CMD.title = "Smithing Halo"
CMD.description = "Toggle display of your Max Skill Halo Effect"
CMD.command = {"sgs_toggleskill", "smithing"}
CMD.skillreq = "smithing"
Menu_RegisterCommand( "special", CMD )

local CMD = {}
CMD.title = "Farming Halo"
CMD.description = "Toggle display of your Max Skill Halo Effect"
CMD.command = {"sgs_toggleskill", "farming"}
CMD.skillreq = "farming"
Menu_RegisterCommand( "special", CMD )

local CMD = {}
CMD.title = "Fishing Halo"
CMD.description = "Toggle display of your Max Skill Halo Effect"
CMD.command = {"sgs_toggleskill", "fishing"}
CMD.skillreq = "fishing"
Menu_RegisterCommand( "special", CMD )



--[[*****************************************************
*********************************************************
						Hats Menu
*********************************************************
*****************************************************]]--

local CMD = {}
CMD.title = "Equip Santa Hat"
CMD.description = "Requires the 'Christmas' Achievement."
CMD.command = {"sgs_equiphat", "santahat"}
CMD.achreq = "santahat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip 3 Year Hat"
CMD.description = "Requires the '3 Year Anniversary' Achievement."
CMD.command = {"sgs_equiphat", "3yearhat"}
CMD.achreq = "3yearhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Community Hat"
CMD.description = "Requires the 'Community Member' Achievement."
CMD.command = {"sgs_equiphat", "steamgroup"}
CMD.achreq = "steamgroup"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Bunny Ears"
CMD.description = "Requires the 'Easter' Achievement."
CMD.command = {"sgs_equiphat", "bunnyears"}
CMD.achreq = "bunnyears"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Chef Hat"
CMD.description = "Requires the 'Cooking for Two...Thousand' Achievement."
CMD.command = {"sgs_equiphat", "chefhat"}
CMD.achreq = "chefhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Farming Hat"
CMD.description = "Requires the 'Farming Hat' Achievement."
CMD.command = {"sgs_equiphat", "farminghat"}
CMD.achreq = "farminghat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Crown Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "crownhat"}
CMD.achreq = "crownhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Treasure Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "treasurehat"}
CMD.achreq = "treasurehat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Treasure Hat 2"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "treasurehat2"}
CMD.achreq = "treasurehat2"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Mining Hat"
CMD.description = "Requires the 'Oooo... Shiny!' Achievement."
CMD.command = {"sgs_equiphat", "mininghat"}
CMD.achreq = "mininghat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Flat Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "flathat"}
CMD.achreq = "flathat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Press Hat"
CMD.description = "Requires the 'Stop The Presses!' Achievement."
CMD.command = {"sgs_equiphat", "presshat"}
CMD.achreq = "presshat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Wizard Hat"
CMD.description = "Requires the 'I Put On My Robe And Wizard Hat' Achievement."
CMD.command = {"sgs_equiphat", "wizardhat"}
CMD.achreq = "wizardhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Soldier Helmet"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "soldierhat"}
CMD.achreq = "soldierhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Pilot Helmet"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "pilothelmethat"}
CMD.achreq = "pilothelmethat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Civil War Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "civilwarhat"}
CMD.achreq = "civilwarhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Dragonborn Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "dragonbornhat"}
CMD.achreq = "dragonbornhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Dr. Seuss Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "drseusshat"}
CMD.achreq = "drseusshat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Notch Head"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "notchhat"}
CMD.achreq = "notchhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Captain's Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "captainshat"}
CMD.achreq = "captainshat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Old Army Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "oldarmyhat"}
CMD.achreq = "oldarmyhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Russian Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "russianhat"}
CMD.achreq = "russianhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Cowboy Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "cowboyhat"}
CMD.achreq = "cowboyhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Chief Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "chiefhat"}
CMD.achreq = "chiefhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Flaminco Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "flamincohat"}
CMD.achreq = "flamincohat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Hooded Mask"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "hoodedmaskhat"}
CMD.achreq = "hoodedmaskhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Robin Hood Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "robinhoodhat"}
CMD.achreq = "robinhoodhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip General's Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "generalhat"}
CMD.achreq = "generalhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Beret"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "berethat"}
CMD.achreq = "berethat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Feathered Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "featherhat"}
CMD.achreq = "featherhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Detective Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "detectivehat"}
CMD.achreq = "detectivehat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Drill Sergeant Hat"
CMD.description = "Purchased from Doctor K."
CMD.command = {"sgs_equiphat", "drillsergeanthat"}
CMD.achreq = "drillsergeanthat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Goggles"
CMD.description = "Earned from the Assasinate the President Achievement."
CMD.command = {"sgs_equiphat", "goggleshat"}
CMD.achreq = "goggleshat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Robot Buddy"
CMD.description = "Dropped from Void Caches."
CMD.command = {"sgs_equiphat", "robotbuddy"}
CMD.achreq = "robotbuddy"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Squirrel"
CMD.description = "Dropped from Void Caches."
CMD.command = {"sgs_equiphat", "squirrelhat"}
CMD.achreq = "squirrelhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "Equip Headcrab Hat"
CMD.description = "Hatch one of each egg."
CMD.command = {"sgs_equiphat", "headcrabhat"}
CMD.achreq = "headcrabhat"
Menu_RegisterCommand( "hats", CMD )

local CMD = {}
CMD.title = "UnEquip Hat"
CMD.description = "Unequips any equipped hat"
CMD.command = {"sgs_unequiphat"}
CMD.achreq = "none"
Menu_RegisterCommand( "hats", CMD )





--[[*****************************************************
*********************************************************
						Pets Menu
*********************************************************
*****************************************************]]--

local CMD = {}
CMD.title = "Place Pet Food"
CMD.description = "Place this food near your pet and he will eat it."
CMD.command = {"sgs_placepetfood"}
Menu_RegisterCommand( "pets", CMD )