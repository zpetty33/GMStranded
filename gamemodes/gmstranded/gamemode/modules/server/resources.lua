/*
Models
*/
resource.AddFile("models/props_foliage/mall_tree_medium01.mdl")
resource.AddFile("materials/models/props_foliage/mall_trees_barks01.vtf")
resource.AddFile("materials/models/props_foliage/mall_trees_barks01.vmf")
resource.AddFile("materials/models/props_foliage/mall_trees_branches02.vtf")
resource.AddFile("materials/models/props_foliage/mall_trees_branches02.vmf")


/*
Sounds
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/sound/sounds/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("sound/sounds/" .. v)
end

/*
Fireworks Shit
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/fireworks/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/fireworks/" .. v)
end

/*
Sprites
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/sprites/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/sprites/" .. v)
end

/*
Hud Idons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/hud/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/hud/" .. v)
end

/*
Cooking Icons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/cooking/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/cooking/" .. v)
end
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/pie/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/pie/" .. v)
end
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/fish/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/fish/" .. v)
end

/*
Grinding Powder Icons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/powder/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/powder/" .. v)
end

/*
Spell Icons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/spells/new/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/spells/new/" .. v)
end

/*
Stone Icons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/stones/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/stones/" .. v)
end

/*
Shop Icons
*/
resource.AddFile("materials/vgui/relic_png.png")
resource.AddFile("materials/vgui/seed.png")
resource.AddFile("materials/vgui/gems/diamond_new.png")
resource.AddFile("materials/vgui/gems/sapphire_new.png")
resource.AddFile("materials/vgui/gems/ruby_new.png")
resource.AddFile("materials/vgui/gems/emerald_new.png")
resource.AddFile("materials/vgui/gems/void_new.png")
resource.AddFile("materials/vgui/gems/prismatic_new.png")

/*
Alchemy Icons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/potions/new/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/potions/new/" .. v)
end
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/transmute/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/transmute/" .. v)
end

/*
First Aid Icons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/firstaid/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/firstaid/" .. v)
end

/*
Furnace Icons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/furnace/new/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/furnace/new/" .. v)
end

/*
Tool Materials
*/
resource.AddFile("materials/models/hatchet/hatchet.vtf")
resource.AddFile("materials/models/hatchet/hatchet.vmt")
resource.AddFile("materials/models/hatchet/hatchet_bmp.vtf")

/*
Egg Icons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/eggs/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/eggs/" .. v)
end


/*
Farming Seed Icons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/farming/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/farming/" .. v)
end


/*
Tool Icons
*/
local files, dirs = file.Find("gamemodes/gmstranded/content/materials/vgui/tools/*", "GAME")
for k, v in pairs( files ) do
	resource.AddFile("materials/vgui/tools/" .. v)
end

resource.AddFile("materials/vgui/banner.png")
resource.AddFile("materials/vgui/slotdonator_s.png")
resource.AddFile("materials/vgui/slotmember_s.png")