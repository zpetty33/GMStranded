function SGS_SetUpTablesShared()

	SGS.savedentities = { 	
		"gms_tree", 
		"gms_tree2", 
		"gms_tree3", 
		"gms_tree4",
		"gms_tree5",
		"gms_tree6",
		"gms_tree7",
		"gms_ironnode", 
		"gms_stonenode", 
		"gms_coalnode", 
		"gms_silvernode", 
		"gms_naquadahnode",
		"gms_triniumnode",
		"gms_goldnode",
		"gms_mithrilnode",
		"gms_platinumnode",
		"npc_vortigaunt",
		"npc_breen",
		"npc_kleiner",
		"gms_antlionspawner"
	}
						
	SGS.trees = {
		"gms_tree",
		"gms_tree2",
		"gms_tree3",
		"gms_tree4",
		"gms_tree5",
		"gms_tree6",
		"gms_tree7"
	}
						
	SGS.rocks = {
		"gms_stonenode",
		"gms_ironnode",
		"gms_coalnode",
		"gms_silvernode",
		"gms_triniumnode",
		"gms_naquadahnode",
		"gms_goldnode",
		"gms_mithrilnode",
		"gms_platinumnode",
		"gms_meteornode",
	}
					
						
	SGS.restrictedphysgun = { 	
		"gms_tree", 
		"gms_tree2", 
		"gms_tree3", 
		"gms_tree4",
		"gms_tree5",
		"gms_tree6",
		"gms_tree7",
		"gms_ironnode", 
		"gms_stonenode", 
		"gms_coalnode", 
		"gms_silvernode", 
		"gms_naquadahnode",
		"gms_triniumnode",
		"gms_goldnode",
		"gms_mithrilnode",
		"gms_platinumnode",
		"gms_fruit", 
		"gms_seed",
		"gms_treeseed",
		"gms_foodseed",
		"gms_egg",
		"npc_breen",
		"npc_kleiner",
		"gms_pan"
	}
							
	SGS.collectibles = {
		"gms_wood",
		"gms_stone",
		"gms_iron",
		"gms_coal",
		"gms_silver",
		"gms_trinium",
		"gms_naquadah",
		"gms_gold",
		"gms_platinum",
		"gms_mithril"
	}

	SGS.skills = { 	
		"mining",
		"woodcutting",
		"farming",
		"fishing",
		"smithing",
		"cooking",
		"construction",
		"combat",
		"alchemy",
		"arcane"
	}

	SGS.startinginventory = {
		"weapon_physgun",
		"weapon_physcannon",
		"gms_remover",
		"gms_proplocker",
		"gms_nocollider",
		"gms_sppshare",
		"gms_packager",
		"gmod_camera"
	}

	SGS.AllowedRemove = {
		"gms_prop",
		"gms_furnace",
		"gms_stove",
		"gms_workbench",
		"gms_aidbench",
		"gms_workbench2",
		"gms_gemtable",
		"gms_grindingstone",
		"gms_rcache",
		"gms_tcache",
		"gms_ptcache",
		"gms_resourcedrop",
		"gms_spawnpoint",
		"gms_miner",
		"gms_torch",
		"gms_firebrazier",
		"gms_walllantern",
		"gms_firelamp",
		"gms_lamp",
		"gms_lamp2",
		"gms_lamp3",
		"gms_lamp4",
		"gms_beacon",
		"gms_beacon2",
		"gms_beacon3",
		"gms_door1",
		"gms_door2",
		"gms_door3",
		"gms_door4",
		"gms_door5",
		"gms_doorbeta",
		"gms_pcache",
		"gms_pcache2",
		"gms_pcache3",
		"gms_pcache4",
		"gms_pcacheboss",
		"gms_tribecache",
		"gms_alchlab",
		"prop_vehicle_prisoner_pod",
		"gms_sign",
		"gms_sink",
		"gms_bed",
		"gms_radio",
		"gms_tv",
		"gms_gardenblock",
		"gms_gardengnome",
		"gms_pethouse",
		"gms_incubator",
		"gms_firework_red",
		"gms_firework_green",
		"gms_firework_blue",
		"gms_firework_yellow",
		"gms_firework_cyan",
		"gms_firework_purple",
		"gms_firework_white",
		"gms_firework_rainbow",
		"gms_bossspawner",
		"gms_bossspawner_hunter",
		"gms_arcaneforge",
		"gms_totem_mining",
		"gms_totem_woodcutting",
		"gms_totem_farming",
		"gms_totem_fishing",
		"gms_totem_smithing",
		"gms_totem_cooking",
		"gms_totem_construction",
		"gms_totem_combat",
		"gms_totem_alchemy",
		"gms_totem_arcane",
		"gms_antlionheadtrophy"
	}
						
	SGS.AllowedPackage = {	
		"gms_firebrazier",
		"gms_walllantern",
		"gms_firelamp",
		"gms_lamp",
		"gms_lamp2",
		"gms_lamp3",
		"gms_lamp4",
		"gms_workbench",
		"gms_aidbench",
		"gms_stove",
		"gms_furnace",
		"gms_workbench2",
		"gms_gemtable",
		"gms_alchlab",
		"gms_rcache",
		"gms_pcache",
		"gms_pcache2",
		"gms_pcache3",
		"gms_pcache4",
		"gms_pcacheboss",
		"gms_tcache",
		"gms_ptcache",
		"gms_spawnpoint",
		"gms_miner",
		"gms_door1",
		"gms_door2",
		"gms_door3",
		"gms_door4",
		"gms_door5",
		"gms_doorbeta",
		"gms_beacon",
		"gms_beacon2",
		"gms_beacon3",
		"gms_sign",
		"gms_sink",
		"gms_bed",
		"gms_radio",
		"gms_tv",
		"gms_gardenblock",
		"gms_gardengnome",
		"gms_pethouse",
		"gms_incubator",
		"gms_firework_red",
		"gms_firework_green",
		"gms_firework_blue",
		"gms_firework_yellow",
		"gms_firework_cyan",
		"gms_firework_purple",
		"gms_firework_white",
		"gms_firework_rainbow",
		"gms_bossspawner",
		"gms_bossspawner_hunter",
		"gms_arcaneforge",
		"gms_totem_mining",
		"gms_totem_woodcutting",
		"gms_totem_farming",
		"gms_totem_fishing",
		"gms_totem_smithing",
		"gms_totem_cooking",
		"gms_totem_construction",
		"gms_totem_combat",
		"gms_totem_alchemy",
		"gms_totem_arcane",
		"gms_antlionheadtrophy"
	}
						
	SGS.MotivationalPosters = {
		"models/props/cs_office/offinspa.mdl",
		"models/props/cs_office/offinspb.mdl",
		"models/props/cs_office/offinspc.mdl",
		"models/props/cs_office/offinspd.mdl",
		"models/props/cs_office/offinspf.mdl"
	}
							
	SGS.Paintings = {
		"models/props/cs_office/offpaintinga.mdl",
		"models/props/cs_office/offpaintingb.mdl",
		"models/props/cs_office/offpaintingd.mdl",
		"models/props/cs_office/offpaintinge.mdl",
		"models/props/cs_office/offpaintingf.mdl",
		"models/props/cs_office/offpaintingg.mdl",
		"models/props/cs_office/offpaintingh.mdl",
		"models/props/cs_office/offpaintingi.mdl",
		"models/props/cs_office/offpaintingj.mdl",
		"models/props/cs_office/offpaintingk.mdl",
		"models/props/cs_office/offpaintingl.mdl",
		"models/props/cs_office/offpaintingm.mdl",
		"models/props/cs_office/offpaintingo.mdl"
	}
							
	SGS.RadioSongs = {
		"music/HL2_song16.mp3",
		"music/HL2_song14.mp3",
		"music/HL2_song31.mp3",
		"music/HL2_song12_long.mp3",
		"music/HL2_song15.mp3",
		"music/VLVX_song22.mp3",
		"music/VLVX_song23.mp3",
		"music/VLVX_song24.mp3",
		"music/VLVX_song28.mp3"
	}
						

	SGS.VortSounds = {
		"vo/npc/vortigaunt/affirmed.wav",
		"vo/npc/vortigaunt/allinoneinall.wav",
		"vo/npc/vortigaunt/allwehave.wav",
		"vo/npc/vortigaunt/asyouwish.wav",
		"vo/npc/vortigaunt/beofservice.wav",
		"vo/npc/vortigaunt/canconvince.wav",
		"vo/npc/vortigaunt/certainly.wav",
		"vo/npc/vortigaunt/dedicate.wav",
		"vo/npc/vortigaunt/gladly.wav",
		"vo/npc/vortigaunt/yes.wav"
	}


	SGS.BreenSounds = {
		"vo/Breencast/br_tofreeman02.wav",
		"vo/Breencast/br_tofreeman06.wav",
		"vo/Breencast/br_tofreeman12.wav",
		"vo/Breencast/br_welcome07.wav"
	}
					
	SGS.KleinerSounds = {
		"vo/k_lab/kl_almostforgot.wav",
		"vo/k_lab/kl_dearme.wav",
		"vo/k_lab/kl_excellent.wav",
		"vo/k_lab/kl_heremypet01.wav",
		"vo/k_lab/kl_mygoodness01.wav",
		"vo/k_lab/kl_ohdear.wav",
		"vo/k_lab/kl_whatisit.wav",
		"vo/k_lab/kl_cantleavelamarr.wav",
		"vo/k_lab/kl_howandwhen02.wav",
		"vo/k_lab/kl_notallhopeless_b.wav"
	}

					

	SGS.VortChatMessages = {
		"Come find me on my island, I've got loads of hot deals!",
		"Try and not eat the berries.. I hear they're sometimes deadly.",
		"Did you find a Void Cache? I will sell you the crystal to open it. Only 1k GTokens!",
		"I hear that Dr.K has a secret service protection detail. Who knew hats were so lucrative.",
		"I sell lots of useful stuff, but my buddy Dr.K on the main Island sells hats!",
		"I've been stuck on this island for over 3 years now. I've kind of given up all hope.",
		"In case of emergency, I've usually got a pretty steady supply of fruit berries growing on my island. Help yourself!",
		"Be extra careful with merchandise purchased from my store. I don't typically give refunds for any reason.",
		"The server restarts every Wednesday and Saturday at 10pm PST. Saturday restarts are a full map wipe!"
	}
							
	SGS.BreenChatMessages = {
		"Where am I? This isn't right. ",
		"Tis the season... for savings! Come see me for holiday specials!",
		"Bring your Candy Canes to me! I'll trade them for some fun stuff!",
		"One free trip to Xen for the first 5000 customers!",
		"Did you know G4P has a Facebook page? www.facebook.com/g4pcommunity",
		"Hey.. Hey %P... Hey... Hey! Hey... Hey..",
		"%P, Where did you get that shirt? From Vorty? Bah!"
	}
							
	SGS.ProtectedItems = { 
		"gms_pcache2", 
		"gms_pcache3",
		"gms_radio",
		"gms_tv",
		"inter_dimensional_core",
		"max_inventory_buff_1", 
		"max_inventory_buff_2" 
	}
							
	SGS.PetsList = { 
		"npc_headcrab", 
		"npc_headcrab_black", 
		"npc_headcrab_fast" 
	}

	SGS.adtext = "To report bugs or make suggestions, please visit our site at www.g4p.org"
	SGS.adcolors = {
			Color(255,255,0,255),
			Color(255,0,255,255),
			Color(0,255,255,255),
			Color(255,255,255,255),
			Color(0,255,0,255),
			Color(255,0,0,255),
			Color(0,0,255,255)
			}
			
	SGS.menuedible = {}
	for k, v in pairs(SGS.Food["fish"]) do
		table.insert(SGS.menuedible, v.name)
	end

	for k, v in pairs(SGS.Food["baked"]) do
		table.insert(SGS.menuedible, v.name)
	end

	for k, v in pairs(SGS.Food["meat"]) do
		table.insert(SGS.menuedible, v.name)
	end

	for k, v in pairs(SGS.Food["relic"]) do
		table.insert(SGS.menuedible, v.name)
	end

	for k, v in pairs(SGS.Food["artifact"]) do
		table.insert(SGS.menuedible, v.name)
	end

	for k, v in pairs(SGS.Food["easteregg"]) do
		table.insert(SGS.menuedible, v.name)
	end

	for k, v in pairs(SGS.Food["specialfood"]) do
		table.insert(SGS.menuedible, v.name)
	end

	for k, v in pairs(SGS.Food["delicacy"]) do
		table.insert(SGS.menuedible, v.name)
	end

	SGS.menuseeds = {}
	for k, v in pairs(SGS.Seeds["fruit"]) do
		table.insert(SGS.menuseeds, v.resource)
	end

	for k, v in pairs(SGS.Seeds["trees"]) do
		table.insert(SGS.menuseeds, v.resource)
	end

	for k, v in pairs(SGS.Seeds["food"]) do
		table.insert(SGS.menuseeds, v.resource)
	end

	for k, v in pairs(SGS.Seeds["alchemy"]) do
		table.insert(SGS.menuseeds, v.resource)
	end
		

	SGS.menupotions = {}
	for k, v in pairs(SGS.Brewing["healing"]) do
		table.insert(SGS.menupotions, v.mname)
	end

	for k, v in pairs(SGS.Brewing["curing"]) do
		table.insert(SGS.menupotions, v.mname)
	end

	for k, v in pairs(SGS.Brewing["elixir"]) do
		table.insert(SGS.menupotions, v.mname)
	end

	for k, v in pairs(SGS.Brewing["strong-elixir"]) do
		table.insert(SGS.menupotions, v.mname)
	end
	for k, v in pairs(SGS.Brewing["special_potions"]) do
		table.insert(SGS.menupotions, v.mname)
	end

	for k, v in pairs(SGS.Brewing["achievement"]) do
		table.insert(SGS.menupotions, v.mname)
	end

	for k, v in pairs(SGS.Brewing["firstaid"]) do
		table.insert(SGS.menupotions, v.mname)
	end
	
	SGS.proplist = {}

	SGS.drops = {}

	SGS.maxlevel = 90
	SGS.maxlevelsurvival = math.floor( (SGS.maxlevel * 10 - 10) / 20 ) + 1
	

	SGS.colors = {
		woodcutting		= Color(255, 0, 0, 255),
		mining			= Color(255, 255, 0, 255),
		farming			= Color(0, 255, 0, 255),
		fishing			= Color(0, 255, 255, 255),
		smithing		= Color(0, 0, 255, 255),
		cooking			= Color(255, 0, 255, 255),
		construction	= Color(225, 225, 225, 255),
		combat			= Color(255, 120, 255, 255),
		alchemy			= Color(120, 225, 120, 255),
		arcane			= Color(255, 128, 0, 255)
	}



	SGS.PanVectors = {
		{pos=Vector(23,5,22), yaw=-135},
		{pos=Vector(23,-18,22), yaw=135},
		{pos=Vector(2,7,22), yaw=-90},
		{pos=Vector(2,-20,22), yaw=90},
		{pos=Vector(-20,5,22), yaw=-45},
		{pos=Vector(-20,-18,22), yaw=45},
	}



	--ROCKS--
	SGS.proplist["rock"] = "models/caverock/caverock.mdl"
	SGS.proplist["rock2"] = "models/props_wasteland/rockcliff01J.mdl"
	SGS.proplist["rock3"] = "models/props_wasteland/rockcliff_cluster03c.mdl"
	SGS.proplist["rock_chunk1"] = "models/props_foliage/rock_forest01b.mdl"
	SGS.proplist["rock_chunk2"] = "models/props_foliage/rock_forest01c.mdl"
	SGS.proplist["rock_chunk3"] = "models/props_foliage/rock_forest01d.mdl"

	--TREES--
	SGS.proplist["tree1"] = "models/props/de_inferno/tree_small.mdl"
	SGS.proplist["tree2"] = "models/props/de_inferno/tree_large.mdl"
	SGS.proplist["tree3"] = "models/props/CS_militia/tree_large_militia.mdl"
	SGS.proplist["tree4"] = "models/props_foliage/tree_pine04.mdl"
	SGS.proplist["tree5"] = "models/props_foliage/tree_deciduous_01a.mdl"
	SGS.proplist["tree6"] = "models/props_foliage/mall_tree_medium01.mdl"
	SGS.proplist["tree7"] = "models/props_foliage/tree_palm_dust01.mdl"
	SGS.proplist["tree_chunk1"] = "models/props_foliage/tree_slice_chunk02.mdl"
	SGS.proplist["tree_chunk2"] = "models/props_foliage/tree_slice_chunk01.mdl"
	SGS.proplist["tree_chunk3"] = "models/props_foliage/tree_slice_chunk03.mdl"

	--STRUCTURES--
	SGS.proplist["wood_workbench"] = "models/devonjones/stranded/workbench.mdl"
	SGS.proplist["first_aid_workbench"] = "models/props_c17/FurnitureTable003a.mdl"
	SGS.proplist["stove"] = "models/stove/stove.mdl"
	SGS.proplist["furnace"] = "models/furnace/furnace.mdl"
	SGS.proplist["metal_workbench"] = "models/enchanttable/enchanttable.mdl"
	SGS.proplist["gemtable"] = "models/gemstation/gemstation.mdl"


	--FARMING--
	SGS.proplist["fruitbush"] = "models/props/de_dust/palm_tree_head_skybox.mdl"
	SGS.proplist["specialbush"] = "models/props_foliage/bush2.mdl"
	SGS.proplist["melon"] = "models/props_junk/watermelon01.mdl"
	SGS.proplist["fruit_small"] = "models/props/cs_italy/orange.mdl"
	SGS.proplist["seed"] = "models/props_phx/misc/potato.mdl"
	SGS.proplist["wheat"] = "models/props_foliage/cattails.mdl"
	SGS.proplist["liferoot"] = "models/props_foliage/ferns03.mdl"

	--MISC--
	SGS.proplist["levelup"] = "models/Weapons/w_bugbait.mdl"
	SGS.proplist["resourcedrop"] = "models/hunter/blocks/cube05x05x05.mdl"
	SGS.proplist["rcache"] = "models/props_junk/wood_crate001a.mdl"
	SGS.proplist["tcache"] = "models/Items/ammoCrate_Rockets.mdl"
	SGS.proplist["harvester"] = "models/props_combine/combine_mine01.mdl"
	SGS.proplist["torch"] =  "models/weapons/W_stunbaton.mdl"
	SGS.proplist["pcache"] = "models/MaxOfS2D/hover_rings.mdl"
	SGS.proplist["alchlab"] = "models/devonjones/stranded/still.mdl"
	SGS.proplist["arcaneforge"] = "models/arcane_forge/arcane_forge.mdl"
	SGS.proplist["incubator"] = "models/props_lab/miniteleport.mdl"
	SGS.proplist["zeropoint"] = "models/Combine_Helicopter/helicopter_bomb01.mdl"
	SGS.proplist["garden_block"] = "models/props/stranded/gardenblock.mdl"
	SGS.proplist["garden_gnome"] = "models/props_junk/gnome.mdl"
	SGS.proplist["meat"] = "models/props_junk/garbage_bag001a.mdl"
	SGS.proplist["egg"] = "models/props_junk/watermelon01.mdl"
	SGS.proplist["petfood"] = "models/props_phx/misc/potato.mdl"
	SGS.proplist["pethouse"] = "models/props_lab/kennel.mdl"
	SGS.proplist["campfire"] = "models/campfire/campfire.mdl"
	SGS.proplist["firebrazier"] = "models/brazier/brazier.mdl"
	SGS.proplist["firelamp"] = "models/lamp/lamp.mdl"
	SGS.proplist["sconce"] = "models/sconce/sconce.mdl"
	SGS.proplist["easteregg"] = "models/props_phx/misc/egg.mdl"
	SGS.proplist["totem"] = "models/props_rooftop/roof_vent003.mdl"
	SGS.proplist["bed"] = "models/bed/bed.mdl"

	--WEP MODELS--
	SGS.proplist["fishingrod_w"] = "models/Weapons/w_crowbar.mdl"
	SGS.proplist["fishingrod_v"] = "models/Weapons/v_crowbar.mdl"
	SGS.proplist["hatchet_w"] = "models/world_hatchet/world_hatchet.mdl"
	SGS.proplist["hatchet_v"] = "models/weapons/v_rc_hatchet.mdl"
	SGS.proplist["pickaxe_w"] = "models/c_pickaxe/c_pickaxe.mdl"
	SGS.proplist["pickaxe_v"] = "models/c_pickaxe/c_pickaxe.mdl"
	SGS.proplist["hoe_w"] = "models/Weapons/w_crowbar.mdl"
	SGS.proplist["hoe_v"] = "models/Weapons/v_crowbar.mdl"
	SGS.proplist["sifter_w"] = "models/Weapons/w_crowbar.mdl"
	SGS.proplist["sifter_v"] = "models/Weapons/v_crowbar.mdl"
	SGS.proplist["alchstone_w"] = "models/Weapons/w_crowbar.mdl"
	SGS.proplist["alchstone_v"] = "models/Weapons/v_crowbar.mdl"
	SGS.proplist["fryingpan_w"] = "models/Weapons/w_crowbar.mdl"
	SGS.proplist["fryingpan_v"] = "models/Weapons/v_crowbar.mdl"
	SGS.proplist["hammer_w"] = "models/Weapons/w_crowbar.mdl"
	SGS.proplist["hammer_v"] = "models/Weapons/v_crowbar.mdl"
	SGS.proplist["extractor_w"] = "models/Weapons/w_crowbar.mdl"
	SGS.proplist["extractor_v"] = "models/Weapons/v_crowbar.mdl"

	--EXPERIENCE TABLE--
	SGS.explist = {
		0,				-- 1
		83,				-- 2
		174,			-- 3
		276,			-- 4
		388,			-- 5
		512,			-- 6
		650,			-- 7
		801,			-- 8
		969,			-- 9
		1154,			-- 10
		1358,			-- 11
		1584,			-- 12
		1833,			-- 13
		2107,			-- 14
		2411,			-- 15
		2746,			-- 16
		3115,			-- 17
		3523,			-- 18
		3973,			-- 19
		4470,			-- 20
		5018,			-- 21
		5624,			-- 22
		6291,			-- 23
		7028,			-- 24
		7842,			-- 25
		8740,			-- 26
		9730,			-- 27
		10824,			-- 28
		12031,			-- 29
		13363,			-- 30
		14833,			-- 31
		16456,			-- 32
		18247,			-- 33
		20224,			-- 34
		22406,			-- 35
		24815,			-- 36
		27473,			-- 37
		30408,			-- 38
		33648,			-- 39
		37224,			-- 40
		41171,			-- 41
		45529,			-- 42
		50339,			-- 43
		55649,			-- 44
		61512,			-- 45
		67983,			-- 46
		75127,			-- 47
		83014,			-- 48
		91721,			-- 49
		101333,			-- 50
		111945,			-- 51
		123660,			-- 52
		136594,			-- 53
		150872,			-- 54
		166636,			-- 55
		184040,			-- 56
		203254,			-- 57
		224466,			-- 58
		247886,			-- 59
		273742,			-- 60
		302288,			-- 61
		333804,			-- 62
		368599,			-- 63
		407015,			-- 64
		449428,			-- 65
		496254,			-- 66
		547953,			-- 67
		605032,			-- 68
		668051,			-- 69
		737627,			-- 70
		814445,			-- 71
		899257,			-- 72
		992895,			-- 73
		1096278,		-- 74
		1210421,		-- 75
		1336443,		-- 76
		1475581,		-- 77
		1629200,		-- 78
		1798808,		-- 79
		1986068,		-- 80
		2192818,		-- 81
		2421087,		-- 82
		2673114,		-- 83
		2951373,		-- 84
		3258594,		-- 85
		3597792,		-- 86
		3972294,		-- 87
		4385776,		-- 88
		4842295,		-- 89
		5346332,		-- 90
		5902831,		-- 91
		6517253,		-- 92
		7195629,		-- 93
		7944614,		-- 94
		8771558,		-- 95
		9684577,		-- 96
		10692629,		-- 97
		11805606,		-- 98
		13034431,		-- 99
		14391160,		-- 100
	}

	SGS.pm1 = {"female01", "female02", "female03", "female04", "female05", "female06", "male01", "male02", "male03", "male04", "male05", "male06", "male07", "male08", "male09"}
	SGS.pm2 = {"female01", "female02", "female03", "female04", "female05", "female06", "female07", "female08", "female09", "female10", "female11", "female12", "male01", "male02", "male03", "male04", "male05", "male06", "male07", "male08", "male09", "male10", "male11", "male12", "male13", "male14", "male15", "male16", "male17", "male18"}
	SGS.pm3 = {"female01", "female02", "female03", "female04", "female05", "female06", "female07", "female08", "female09", "female10", "female11", "female12", "male01", "male02", "male03", "male04", "male05", "male06", "male07", "male08", "male09", "male10", "male11", "male12", "male13", "male14", "male15", "male16", "male17", "male18", "medic01", "medic02", "medic03", "medic04", "medic05", "medic06", "medic07", "medic08", "medic09", "medic10", "medic11", "medic12", "medic13", "medic14", "medic15"}
	SGS.pm4 = {"female01", "female02", "female03", "female04", "female05", "female06", "female07", "female08", "female09", "female10", "female11", "female12", "male01", "male02", "male03", "male04", "male05", "male06", "male07", "male08", "male09", "male10", "male11", "male12", "male13", "male14", "male15", "male16", "male17", "male18", "medic01", "medic02", "medic03", "medic04", "medic05", "medic06", "medic07", "medic08", "medic09", "medic10", "medic11", "medic12", "medic13", "medic14", "medic15", "monk", "mossman", "eli", "alyx", "odessa", "hostage01", "hostage02", "hostage03"}
	SGS.pmd = {"female01", "female02", "female03", "female04", "female05", "female06", "female07", "female08", "female09", "female10", "female11", "female12", "male01", "male02", "male03", "male04", "male05", "male06", "male07", "male08", "male09", "male10", "male11", "male12", "male13", "male14", "male15", "male16", "male17", "male18", "medic01", "medic02", "medic03", "medic04", "medic05", "medic06", "medic07", "medic08", "medic09", "medic10", "medic11", "medic12", "medic13", "medic14", "medic15", "monk", "mossman", "eli", "alyx", "odessa", "hostage01", "hostage02", "hostage03", "css_arctic", "css_guerilla", "css_leet", "css_phoenix", "css_riot", "css_swat", "css_gasmask", "css_urban"}
	SGS.pmm = {"female01", "female02", "female03", "female04", "female05", "female06", "female07", "female08", "female09", "female10", "female11", "female12", "male01", "male02", "male03", "male04", "male05", "male06", "male07", "male08", "male09", "male10", "male11", "male12", "male13", "male14", "male15", "male16", "male17", "male18", "medic01", "medic02", "medic03", "medic04", "medic05", "medic06", "medic07", "medic08", "medic09", "medic10", "medic11", "medic12", "medic13", "medic14", "medic15", "monk", "mossman", "eli", "alyx", "odessa", "hostage01", "hostage02", "hostage03", "css_arctic", "css_guerilla", "css_leet", "css_phoenix", "css_riot", "css_swat", "css_gasmask", "css_urban", "combine", "combineelite", "combineprison", "police", "policefem", "barney"}
	SGS.pma = {"female01", "female02", "female03", "female04", "female05", "female06", "female07", "female08", "female09", "female10", "female11", "female12", "male01", "male02", "male03", "male04", "male05", "male06", "male07", "male08", "male09", "male10", "male11", "male12", "male13", "male14", "male15", "male16", "male17", "male18", "medic01", "medic02", "medic03", "medic04", "medic05", "medic06", "medic07", "medic08", "medic09", "medic10", "medic11", "medic12", "medic13", "medic14", "medic15", "monk", "mossman", "eli", "alyx", "odessa", "hostage01", "hostage02", "hostage03", "css_arctic", "css_guerilla", "css_leet", "css_phoenix", "css_riot", "css_swat", "css_gasmask", "css_urban", "combine", "combineelite", "combineprison", "police", "policefem", "barney", "mossmanarctic", "breen", "gman", "hostage04"}


	SGS.pmlist1 = {"female01", "female02", "female03", "female04", "female05", "female06", "male01", "male02", "male03", "male04", "male05", "male06", "male07", "male08", "male09"}
	SGS.pmlist2 = {"female08", "female09", "female10", "female11", "female12", "male10", "male11", "male12", "male13", "male14", "male15", "male16", "male17", "male18"}
	SGS.pmlist3 = {"medic01", "medic02", "medic03", "medic04", "medic05", "medic06", "medic07", "medic08", "medic09", "medic10", "medic11", "medic12", "medic13", "medic14", "medic15"}
	SGS.pmlist4 = {"monk", "mossman", "eli", "alyx"}
	SGS.pmlistd = {"css_arctic", "css_guerilla", "css_leet", "css_phoenix", "css_riot", "css_swat", "css_gasmask", "css_urban", "hostage01", "hostage02", "hostage03"}
	SGS.pmlistm = {"combine", "combineelite", "combineprison", "police", "policefem", "barney"}
	SGS.pmlista = {"mossmanarctic", "breen", "gman", "hostage04"}

	SGS.cache_entities = { "gms_rcache", "gms_pcache", "gms_pcache2", "gms_pcache3", "gms_pcache4", "gms_pcacheboss", "gms_tribecache" }
end