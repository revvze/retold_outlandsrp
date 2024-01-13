local PLUGIN = PLUGIN

PLUGIN.name = "Improved Loot Containers"
PLUGIN.descriptions = "Adds Improved Loot Containers which can be easily configured."
PLUGIN.author = "Riggs.mackay"

CAMI.RegisterPrivilege({
    Name = "Helix - Manage Loot Containers",
    MinAccess = "admin"
})

ix.loot = ix.loot or {}
ix.loot.containers = ix.loot.containers or {}

ix.loot.containers = {
    ["crate"] = {
        name = "Wooden Crate",
        description = "A crate made of wood.",
        model = "models/props_junk/wood_crate001a_damaged.mdl",
        skin = 1,
        delay = 180, -- time in seconds before it can be looted again
        lootTime = {3, 4, 5, 6}, -- can be a table for random time, example: lootTime = {2, 5, 7, 8, 10},
        maxItems = {1, 2, 3}, -- how many items can be in the container
        items = {
            "metalplate",
            "metalplate",
            "metalplate",
            "cloth",
            "cloth",
            "cloth",
            "wood",
            "wood",
            "plastic",
            "glue",
            "pipe",
            "gear",
            "drink_water",
            "gunpowder",
	    "fruit_watermelon",
	    "comfort_beans",
	    "comfort_noodles",
		"orange",
			"pineapple",
			"glass"
        },
        rareItems = {
            "bulletcasing",
            "bulletcasing",
            "refinedmetal",
            "refinedmetal",
	    "suitcase",
	    "ration",
            "ammo_pistol",
            "bandage",
            "electronics",
			"bread",
			"apple",
			"canned1",
			"canned2",
			"canned3",
			"drink_alcohol1",
			"drink_alcohol2",
			"drink_alcohol3",
			"meth",
        },
        onStart = function(ply, ent) -- when you press e on the container
        end,
        onEnd = function(ply, ent) -- when you finished looting the container
        end,
    },
    ["barrel"] = {
        name = "Barrel",
        description = "A rusty, metal barrel",
        model = "models/props_c17/oildrum001.mdl",
        skin = 1,
        delay = 180, -- time in seconds before it can be looted again
        lootTime = {3, 4, 5, 6}, -- can be a table for random time, example: lootTime = {2, 5, 7, 8, 10},
        maxItems = {1, 2, 3}, -- how many items can be in the container
        items = {
            "metalplate",
            "metalplate",
            "metalplate",
            "cloth",
            "cloth",
            "cloth",
            "wood",
            "wood",
            "plastic",
            "glue",
            "pipe",
            "gear",
            "drink_water",
            "gunpowder",
	    "fruit_watermelon",
	    "comfort_beans",
	    "comfort_noodles",
		"orange",
			"pineapple",
			"glass"
        },
        rareItems = {
            "bulletcasing",
            "bulletcasing",
            "refinedmetal",
            "refinedmetal",
	    "suitcase",
	    "ration",
            "ammo_pistol",
            "bandage",
            "electronics",
			"bread",
			"apple",
			"canned1",
			"canned2",
			"canned3",
			"drink_alcohol1",
			"drink_alcohol2",
			"drink_alcohol3",
			"meth",
        },
        onStart = function(ply, ent) -- when you press e on the container
        end,
        onEnd = function(ply, ent) -- when you finished looting the container
        end,
    },
    ["dumpster"] = {
        name = "Dumpster",
        description = "A dumpster.",
        model = "models/props_junk/TrashDumpster01a.mdl",
        skin = 0,
        delay = 180, -- time in seconds before it can be looted again
        lootTime = {3, 4, 5, 6}, -- can be a table for random time, example: lootTime = {2, 5, 7, 8, 10},
        maxItems = {1, 2, 3}, -- how many items can be in the container
        items = {
            "metalplate",
            "metalplate",
            "metalplate",
            "cloth",
            "cloth",
            "cloth",
            "wood",
            "wood",
            "plastic",
            "glue",
            "pipe",
            "gear",
            "drink_water",
            "gunpowder",
	    "fruit_watermelon",
	    "comfort_beans",
	    "comfort_noodles",
		"orange",
			"pineapple",
			"glass"
        },
        rareItems = {
            "bulletcasing",
            "bulletcasing",
            "refinedmetal",
            "refinedmetal",
	    "suitcase",
	    "ration",
            "ammo_pistol",
            "bandage",
            "electronics",
			"bread",
			"apple",
			"canned1",
			"canned2",
			"canned3",
			"drink_alcohol1",
			"drink_alcohol2",
			"drink_alcohol3",
			"meth",
        },
        onStart = function(ply, ent) -- when you press e on the container
        end,
        onEnd = function(ply, ent) -- when you finished looting the container
        end,
    },
	["bookshelf"] = {
        name = "Bookshelf",
        description = "A bookshelf for reading.",
        model = "models/props/cs_office/bookshelf1.mdl",
        skin = 0,
        delay = 180, -- time in seconds before it can be looted again
        lootTime = {3, 4, 5, 6}, -- can be a table for random time, example: lootTime = {2, 5, 7, 8, 10},
        maxItems = {1, 2, 3}, -- how many items can be in the container
        items = {
            "blackcat",
            "book_3601",
            "book_aa",
            "book_absj",
            "book_anticivilbeliefs",
            "book_armada1",
            "book_armada2",
            "book_audit",
            "book_ba",
            "book_bible_thing",
            "book_c",
            "book_ch",
            "book_chel",
            "book_chel_song",
			"book_clexo",
			"book_clexo3",
			"book_clexo4",
			"book_clexo5",
			"book_creep_1",
			"book_creep_2",
			"book_cwu",
			"book_darkenergy",
			"book_ep",
			"book_fha",
			"book_fio",
			"book_fk",
			"book_glory_union",
			"book_great_gift",
			"book_ha",
			"book_itn",
			"book_lastdragon",
			"book_loveages",
			"book_lr",
			"book_mr_tiny",
			"book_npc",
			"book_orr",
			"book_pandora",
			"book_pha",
			"book_poemsofwar",
			"book_railwaymania",
			"book_raven",
			"book_req",
			"book_resist",
			"book_rev",
			"book_stillirise",
			"book_suntzuone",
			"book_tapeworm",
			"book_tas",
			"book_tcs",
			"book_telltaleheart",
			"book_terminalnewspaper10august2010",
			"book_tfoy",
			"book_tfw",
			"book_tradedominance",
			"book_tsod",
			"book_two_timer",
			"book_usp",
			"book_va",
			"book_versailleswasright",
			"book_vietnamdisaster",
			"book_wisdom",
			"book_wonkacollab",
			"book_zotu",
			"newspaper_born10august2010",
			"newspaper_borncombinedecimstesentinelese09august2009",
			"newspaper_borncombineheadcrabbioweapons18december2008",
			"newspaper_terminal25jan2009",
			"newspaper_terminal26july2009",
			"newspaper_timessurrender",
			"propaganda_maozedong",
        },
        rareItems = {
        },
        onStart = function(ply, ent) -- when you press e on the container
        end,
        onEnd = function(ply, ent) -- when you finished looting the container
        end,
    },
	    ["trash"] = {
        name = "Trash",
        description = "A pile of trash bags.",
        model = "models/willardnetworks/props/trash03.mdl",
        skin = 0,
        delay = 180, -- time in seconds before it can be looted again
        lootTime = {3, 4, 5, 6}, -- can be a table for random time, example: lootTime = {2, 5, 7, 8, 10},
        maxItems = {1, 2, 3}, -- how many items can be in the container
        items = {
            "metalplate",
            "metalplate",
            "metalplate",
            "cloth",
            "cloth",
            "cloth",
            "wood",
            "wood",
            "plastic",
            "glue",
            "pipe",
            "gear",
            "drink_water",
            "gunpowder",
	    "fruit_watermelon",
	    "comfort_beans",
	    "comfort_noodles",
		"orange",
			"pineapple",
			"glass"
        },
        rareItems = {
            "bulletcasing",
            "bulletcasing",
            "refinedmetal",
            "refinedmetal",
	    "suitcase",
	    "ration",
            "ammo_pistol",
            "bandage",
            "electronics",
			"bread",
			"apple",
			"canned1",
			"canned2",
			"canned3",
			"drink_alcohol1",
			"drink_alcohol2",
			"drink_alcohol3",
			"meth",
        },
        onStart = function(ply, ent) -- when you press e on the container
        end,
        onEnd = function(ply, ent) -- when you finished looting the container
        end,
    },
  ["vehicle"] = {
        name = "Vehicle",
        description = "A run down, pre-war vehicle.",
        model = "models/props_vehicles/car001a_hatchback.mdl",
        skin = 0,
        delay = 180, -- time in seconds before it can be looted again
        lootTime = {3, 4, 5, 6}, -- can be a table for random time, example: lootTime = {2, 5, 7, 8, 10},
        maxItems = {1, 2, 3}, -- how many items can be in the container
        items = {
            "metalplate",
            "metalplate",
            "metalplate",
            "cloth",
            "cloth",
            "cloth",
            "plastic",
            "glue",
            "pipe",
            "gear",
            "drink_water",
			"glass"
        },
        rareItems = {
            "refinedmetal",
            "refinedmetal",
	    	"suitcase",
            "electronics",
			"drink_alcohol1",
			"drink_alcohol2",
			"drink_alcohol3",
			"meth",
        },
        onStart = function(ply, ent) -- when you press e on the container
        end,
        onEnd = function(ply, ent) -- when you finished looting the container
        end,
    },
   	["wood_barrel"] = {
        name = "Brewing Barrel",
        description = "A brewing barrel.",
        model = "models/mosi/fallout4/props/fortifications/woodenbarrel.mdl",
        skin = 0,
        delay = 180, -- time in seconds before it can be looted again
        lootTime = {3, 4, 5, 6}, -- can be a table for random time, example: lootTime = {2, 5, 7, 8, 10},
        maxItems = {1}, -- how many items can be in the container
        items = {
            "drink_alcohol",
      		"drink_alcohol3",
        },
        rareItems = {
            "drink_alcohol2",
        },
        onStart = function(ply, ent) -- when you press e on the container
        end,
        onEnd = function(ply, ent) -- when you finished looting the container
        end,
    },
}
properties.Add("loot_setclass", {
    MenuLabel = "Set Loot Class",
    MenuIcon = "icon16/wrench.png",
    Order = 5,

    Filter = function(self, ent, ply)
        if not ( IsValid(ent) and ent:GetClass() == "ix_loot_container" ) then return false end

        return CAMI.PlayerHasAccess(ply, "Helix - Manage Loot Containers", nil)
    end,

    Action = function(self, ent)
    end,

    LootClassSet = function(self, ent, class)
        self:MsgStart()
            net.WriteEntity(ent)
            net.WriteString(class)
        self:MsgEnd()
    end,

    MenuOpen = function(self, option, ent, trace)
        local subMenu = option:AddSubMenu()

        for k, v in SortedPairs(ix.loot.containers) do
            subMenu:AddOption(v.name.." ("..k..")", function()
                self:LootClassSet(ent, k)
            end)
        end
    end,

    Receive = function(self, len, ply)
        local ent = net.ReadEntity()

        if not ( IsValid(ent) ) then return end
        if not ( self:Filter(ent, ply) ) then return end

        local class = net.ReadString()
        local loot = ix.loot.containers[class]

        -- safety check, just to make sure if it really exists in both realms.
        if not ( class or loot ) then
            ply:Notify("You did not specify a valid container class!")
            return
        end

        ent:SetContainerClass(tostring(class))
        ent:SetModel(loot.model)
        ent:SetSkin(loot.skin or 0)
        ent:PhysicsInit(SOLID_VPHYSICS) 
        ent:SetSolid(SOLID_VPHYSICS)
        ent:SetUseType(SIMPLE_USE)
        ent:DropToFloor()

        PLUGIN:SaveData()
    end
})

if ( SERVER ) then
    function PLUGIN:SaveData()
        local data = {}
    
        for _, v in pairs(ents.FindByClass("ix_loot_container")) do
            data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetContainerClass(), v:GetModel(), v:GetSkin()}
        end
    
        ix.data.Set("lootContainer", data)
    end

    function PLUGIN:LoadData()
        for _, v in pairs(ix.data.Get("lootContainer")) do
            local lootContainer = ents.Create("ix_loot_container")
            lootContainer:SetPos(v[1])
            lootContainer:SetAngles(v[2])
            lootContainer:SetContainerClass(v[3])
            timer.Simple(1, function()
                if ( IsValid(lootContainer) ) then
                    lootContainer:SetModel(v[4])
                    lootContainer:SetSkin(v[5])
                end
            end)
            lootContainer:Spawn()
        end
    end
end
