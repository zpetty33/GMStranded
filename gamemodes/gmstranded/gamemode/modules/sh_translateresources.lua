SGS.TranslatedResources = {}
function Resource_Register( resource )
	SGS.TranslatedResources[resource.entity] = resource
end

function SGS_LookupResourceTranslation( ent )

	if SGS.TranslatedResources[ ent ] then
		return SGS.TranslatedResources[ ent ]
	end
	return nil

end

RESOURCE = {}
RESOURCE.entity = "gms_tree"
RESOURCE.name = "Regular Tree"
RESOURCE.rlvl = 1
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_tree2"
RESOURCE.name = "Oak Tree"
RESOURCE.rlvl = 15
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_tree3"
RESOURCE.name = "Maple Tree"
RESOURCE.rlvl = 30
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_tree4"
RESOURCE.name = "Pine Tree"
RESOURCE.rlvl = 45
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_tree5"
RESOURCE.name = "Yew Tree"
RESOURCE.rlvl = 55
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_tree6"
RESOURCE.name = "Buckeye Tree"
RESOURCE.rlvl = 65
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_tree7"
RESOURCE.name = "Palm Tree"
RESOURCE.rlvl = 72
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_stonenode"
RESOURCE.name = "Stone Deposit"
RESOURCE.rlvl = 1
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_ironnode"
RESOURCE.name = "Iron Deposit"
RESOURCE.rlvl = 15
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_coalnode"
RESOURCE.name = "Coal Deposit"
RESOURCE.rlvl = 25
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_silvernode"
RESOURCE.name = "Silver Ore Vein"
RESOURCE.rlvl = 35
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_triniumnode"
RESOURCE.name = "Trinium Ore Vein"
RESOURCE.rlvl = 50
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_naquadahnode"
RESOURCE.name = "Naquadah Ore Vein"
RESOURCE.rlvl = 55
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_goldnode"
RESOURCE.name = "Gold Deposit"
RESOURCE.rlvl = 62
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_mithrilnode"
RESOURCE.name = "Mithril Ore Vein"
RESOURCE.rlvl = 62
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_platinumnode"
RESOURCE.name = "Platinum Ore Vein"
RESOURCE.rlvl = 72
Resource_Register( RESOURCE )

RESOURCE = {}
RESOURCE.entity = "gms_meteornode"
RESOURCE.name = "Meteorite"
RESOURCE.rlvl = 1
Resource_Register( RESOURCE )