local hatname = "toweringhat"
local hat = {
	model="models/player/items/demo/hat_first_nr.mdl", 
	offsets={
		["models/kleiner.mdl"] = { pos=Vector(0.607328,-1.203880,0.000000), ang=Angle(-90.000000,0.000000,-90.000000), scale=Vector(1.000000,1.000000,1.000000), bone="ValveBiped.Bip01_Head1" },
	}
}

RegisterHatSetting( hatname, hat )