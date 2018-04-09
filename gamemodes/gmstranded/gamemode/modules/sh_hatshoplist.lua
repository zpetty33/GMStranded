SGS.HatShop = {}
function Shop_RegisterHat( category, hat )
	if not SGS.HatShop[category] then SGS.HatShop[category] = {} end
	SGS.HatShop[category][#SGS.HatShop[category] + 1] = hat
end

//-=structures--//


local HAT = {}
HAT.model = "models/player/items/all_class/hm_disguisehat_demo.mdl"
HAT.price = 1000
HAT.name = "Flat Cap"
HAT.ach = "flathat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/all_class/treasure_hat_01_demo.mdl"
HAT.price = 2500
HAT.name = "Treasure Hat"
HAT.ach = "treasurehat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/all_class/treasure_hat_02_demo.mdl"
HAT.price = 5000
HAT.name = "Treasure Hat 2"
HAT.ach = "treasurehat2"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/demo/crown.mdl"
HAT.price = 2000
HAT.name = "Crown"
HAT.ach = "crownhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/workshop/player/items/soldier/cloud_crasher/cloud_crasher.mdl"
HAT.price = 1200
HAT.name = "Soldier Helmet"
HAT.ach = "soldierhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/workshop/player/items/soldier/jul13_helicopter_helmet/jul13_helicopter_helmet.mdl"
HAT.price = 1200
HAT.name = "Pilot Helmet"
HAT.ach = "pilothelmethat"
HAT.description = "*Click for more info*"
HAT.roll = true
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/workshop/player/items/soldier/jul13_ol_jack/jul13_ol_jack.mdl"
HAT.price = 1000
HAT.name = "Civil War Cap"
HAT.ach = "civilwarhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/heavy/skyrim_helmet.mdl"
HAT.price = 3250
HAT.name = "Dragonborn Helmet"
HAT.ach = "dragonbornhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/soldier/dappertopper.mdl"
HAT.price = 1000
HAT.name = "Dr. Seuss Hat"
HAT.ach = "drseusshat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/all_class/notch_head_demo.mdl"
HAT.price = 750
HAT.name = "Notch Head"
HAT.ach = "notchhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/all_class/world_traveller_demo.mdl"
HAT.price = 1000
HAT.name = "Captain's Hat"
HAT.ach = "captainshat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/demo/veteran_hat.mdl"
HAT.price = 1000
HAT.name = "Old Army Hat"
HAT.ach = "oldarmyhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/engineer/mbsf_engineer.mdl"
HAT.price = 1000
HAT.name = "Russian Hat"
HAT.ach = "russianhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/engineer/engineer_cowboy_hat.mdl"
HAT.price = 1500
HAT.name = "Cowboy Hat"
HAT.ach = "cowboyhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/heavy/heavy_big_chief.mdl"
HAT.price = 1000
HAT.name = "Indian Chief Hat"
HAT.ach = "chiefhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/pyro/fwk_pyro_flamenco.mdl"
HAT.price = 1000
HAT.name = "Flaminco Hat"
HAT.ach = "flamincohat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/sniper/c_bet_brinkhood.mdl"
HAT.price = 1000
HAT.name = "Hooded Mask"
HAT.ach = "hoodedmaskhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/sniper/larrikin_robin.mdl"
HAT.price = 2000
HAT.name = "Robin Hood Hat"
HAT.ach = "robinhoodhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/soldier/armored_authority.mdl"
HAT.price = 2000
HAT.name = "General's Hat"
HAT.ach = "generalhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/spy/spy_beret.mdl"
HAT.price = 750
HAT.name = "Beret"
HAT.ach = "berethat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/spy/spy_charmers_chapeau.mdl"
HAT.price = 1000
HAT.name = "Feathered Hat"
HAT.ach = "featherhat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/spy/spy_private_eye.mdl"
HAT.price = 1000
HAT.name = "Detective Hat"
HAT.ach = "detectivehat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

local HAT = {}
HAT.model = "models/player/items/soldier/soldier_sargehat.mdl"
HAT.price = 1000
HAT.name = "Drill Sergeant Hat"
HAT.ach = "drillsergeanthat"
HAT.description = "*Click for more info*"
Shop_RegisterHat( "hats", HAT )

