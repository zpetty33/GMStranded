surface.CreateFont( "resource", {
	font	=	"tahoma",
	size	=	20,
	weight	=	600
	}
)
surface.CreateFont( "sign", {
	font	=	"tahoma",
	size	=	22,
	weight	=	800
	}
)
surface.CreateFont( "resource2", {
	font	=	"tahoma",
	size	=	12,
	weight	=	600
	}
)
surface.CreateFont( "proplisticons", {
	font	=	"tahoma",
	size	=	8,
	weight	=	400
	}
)
surface.CreateFont( "HotBarnumbers", {
	font	=	"tahoma",
	size	=	14,
	weight	=	600
	}
)
surface.CreateFont( "farmingoverlayicons", {
	font	=	"tahoma",
	size	=	10,
	weight	=	800
	}
)
surface.CreateFont( "SGS_HUD2", {
	font	=	"arial",
	size	=	14,
	weight	=	600
	}
)
surface.CreateFont( "SGS_NotAvailable2", {
	font	=	"tahoma",
	size	=	12,
	weight	=	600
	}
)
surface.CreateFont( "SGS_HUD3", {
	font	=	"tahoma",
	size	=	14,
	weight	=	600
	}
)
surface.CreateFont( "SGS_FarmText", {
	font	=	"tahoma",
	size	=	12,
	weight	=	600
	}
)
surface.CreateFont( "SGS_RCacheMenuText", {
	font	=	"tahoma",
	size	=	12,
	weight	=	600
	}
)
surface.CreateFont( "SGS_TCacheMenuText", {
	font	=	"tahoma",
	size	=	12,
	weight	=	600
	}
)
surface.CreateFont( "SGS_RCacheTitles", {
	font	=	"tahoma",
	size	=	18,
	weight	=	600
	}
)
surface.CreateFont( "SGS_SideInventoryFont2", {
	font	=	"courier",
	size	=	10,
	weight	=	600
	}
)

function SGS_SetDefaultClientVariables()
	
	SGS.HotBarcontents = {}
	SGS.resources = {}
	SGS.levels = {}
	SGS.exp = {}
	SGS.propmenucats = {}
	SGS.hudtimer = {}
	SGS.inventory = {}
	SGS.needs = {}
	SGS.pmodels = {}
	SGS.trees = {}
	SGS.drawdistance = 6000
	SGS.tier = "1"
	SGS.drawlights = 800
	SGS.voicechannels = {}
	SGS.plantcount = 0
	SGS.maxplants = 0
	SGS.ach = {}
	for k, v in pairs( SGS.props ) do
		SGS.propmenucats[ k ] = true
	end
	SGS.inventory = { "weapon_physgun", "weapon_physcannon", "gms_remover", "gms_welder", "gms_sppshare", "gms_packager", "gmod_camera" }
	SGS.dropmenu = ""
	SGS.fps = 0
	SGS.fnum = 0
	SGS.fnumcheck = CurTime()
	SGS.maxinv = 120
	SGS.maxneeds = 1000
	SGS.curinv = 0
	SGS.gtokens = 0
	SGS.showafk = false
	SGS.afktime = 0
	SGS.tostime = 0
	SGS.mstate = "hidden"
	SGS.person = "first"
	SGS.camhit = false
	SGS.showhudmain = true
	SGS.accepttos = false
	SGS.amode = false
	SGS.o2 = 1000
	SGS.o2show = false
	SGS.day = 1
	SGS.time = 1
	SGS.chp_next = CurTime()
	SGS.chp_dir = "up"
	SGS.chp = 5
	SGS.rcache = {}
	SGS.pethouse = {}
	SGS.hudtimer[ "display" ] = false
	SGS.hudtimer[ "etime" ] = 0
	SGS.hudtimer[ "len" ] = 0
	SGS.hudtimer[ "text" ] = ""
	SGS.inchat = false
	SGS.skillmenuopen = false
	SGS.inventoryopen = false
	SGS.commandsmenuopen = false
	SGS.adcolor = SGS.adcolors[math.random(#SGS.adcolors)]
	SGS.PendingRDrops = {}
end