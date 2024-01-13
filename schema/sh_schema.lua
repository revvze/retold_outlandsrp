-- Schema info
Schema.name = "Division II"
Schema.author = "Butt Aches"
Schema.description = "An Open World, Survival, RPG"

Schema.build = "Division 2"
Schema.currentVersion = "1.0.0"
Schema.changelogs = {
    ["1.0.0"] = {
        "Final Release",
    },
}

-- Schema includes
ix.util.Include("cl_schema.lua")
ix.util.Include("sv_schema.lua")

ix.util.IncludeDir("hooks")
ix.util.IncludeDir("meta")
ix.util.IncludeDir("voices")

-- Schema config
ix.currency.plural = "tokens"
ix.currency.singular = "token"
ix.currency.symbol = "T"

local function ixConfigSet(key, value)
    ix.config.SetDefault(key, value)
    ix.config.Set(key, value)
end

ixConfigSet("color", Color(130, 0, 0))
ixConfigSet("allowVoice", true)
ixConfigSet("thirdperson", true)
ixConfigSet("weaponRaiseTime", 0.2)
ixConfigSet("walkSpeed", 100)
ixConfigSet("runSpeed", 200)
ixConfigSet("communityText", "Discord")
ixConfigSet("communityURL", "https://npcs.gg/discord")
ixConfigSet("music", "rp_ravenholm/music/the path integral.mp3")
ixConfigSet("experimentalModeVC", true)
ixConfigSet("radioVCVolume", 50)
ixConfigSet("separatorVC", "|")
ixConfigSet("allowPush", false)
ixConfigSet("loocDelay", 2)
ixConfigSet("oocDelay", 5)
ixConfigSet("staminaCrouchRegeneration", 10)
ixConfigSet("staminaDrain", 0)
ixConfigSet("staminaRegeneration", 10)
ixConfigSet("inventoryHeight", 6)
ixConfigSet("inventoryWidth", 8)

local models = {
    ["metrocop"] = {
        "models/police_sentient.mdl",
	"models/police_super.mdl",
	"models/police_hunter.mdl",
    },
    ["overwatch"] = {
	"models/combine_hunter_a.mdl",
	"models/combine_hunter_sa.mdl",
	"models/combine_ground_sa.mdl",
	"models/combine_ground_a.mdl",
	"models/combine_prison_a.mdl",
	"models/combine_prison_sa.mdl",
	"models/combine_shotgun_a.mdl",
	"models/combine_shotgun_sa.mdl",
	"models/combine_super_sa.mdl",
	"models/combine_super_a.mdl",
	"models/combine_watch_sa.mdl",
	"models/combine_watch_a.mdl",
		
    },
    ["player"] = {
        "models/hlvr/characters/hazmat_worker/hazmat_worker_player.mdl",
		"models/litenetwork/conscript_gasmask.mdl",
		"models/daemon_alyx/players/male_citizen_01.mdl",
		"models/daemon_alyx/players/male_citizen_02.mdl",
		"models/daemon_alyx/players/male_citizen_03.mdl",
		"models/daemon_alyx/players/male_citizen_04.mdl",
		"models/daemon_alyx/players/male_citizen_05.mdl",
		"models/daemon_alyx/players/male_citizen_06.mdl",
		"models/daemon_alyx/players/male_citizen_07.mdl",
		"models/daemon_alyx/players/male_citizen_08.mdl",
		"models/daemon_alyx/players/male_citizen_09.mdl",
		"models/daemon_alyx/players/male_citizen_10.mdl",
		"models/daemon_alyx/players/male_citizen_11.mdl",
		"models/daemon_alyx/players/male_citizen_12.mdl",
		"models/daemon_alyx/players/male_citizen_13.mdl",
		"models/hlvr/characters/worker/worker_player.mdl",
		"models/ludex/mmod_tactical/pmc_gordon/pmc_gordon_freeman_pm.mdl",
    },
    ["vortigaunt"] = {
        "models/willardnetworks/vortigaunt.mdl",
	"models/vortigaunt_synth/vortigaunt_synth.mdl",
    },
}

for i, j in pairs(models) do
    for k, v in pairs(models[i]) do
        ix.anim.SetModelClass(v, i)
    end
end

player_manager.AddValidHands("player", "models/weapons/c_arms_conscript.mdl", 0, "00000000")
player_manager.AddValidHands("metrocop", "models/weapons/c_arms_pilot.mdl", 0, "00000000")
player_manager.AddValidHands("overwatch", "models/weapons/c_arms_combine_ground_sa.mdl", 0, "00000000")
player_manager.AddValidHands("overwatchShotgun", "models/weapons/c_arms_combine_shotgun_sa.mdl", 0, "00000000")
player_manager.AddValidHands("overwatchLongRange", "models/weapons/c_arms_combine_watch_sa.mdl", 0, "00000000")
player_manager.AddValidHands("overwatchAirwatch", "models/weapons/c_arms_pilot.mdl", 0, "00000000")
player_manager.AddValidHands("overwatchElite", "models/weapons/c_arms_combine_super_sa.mdl", 0, "00000000")

for k, v in pairs(models["metrocop"]) do
    player_manager.AddValidModel("metrocop", v)
end

player_manager.AddValidModel("overwatch", "models/combine_ground_sa.mdl")
player_manager.AddValidModel("overwatch", "models/combine_ground_a.mdl")
player_manager.AddValidModel("overwatchShotgun", "models/combine_shotgun_sa.mdl")
player_manager.AddValidModel("overwatchShotgun", "models/combine_shotgun_a.mdl")
player_manager.AddValidModel("overwatchLongRange", "models/combine_watch_sa.mdl")
player_manager.AddValidModel("overwatchLongRange", "models/combine_watch_a.mdl")
player_manager.AddValidModel("overwatchAirwatch", "models/plummy_sh_civ_pro/plummy_pilot_cp.mdl")
player_manager.AddValidModel("overwatchElite", "models/combine_super_sa.mdl")
player_manager.AddValidModel("overwatchElite", "models/combine_super_a.mdl")

ALWAYS_RAISED["swep_construction_kit"] = true

function ix.util.angleToBearing(ang)
    return math.Round(360 - (ang.y % 360))
end

function Schema:ZeroNumber(number, length)
    local amount = math.max(0, length - string.len(number))
    return string.rep("0", amount)..tostring(number)
end

-- taken from DarkRP
local ent = FindMetaTable("Entity")
function ent:IsInRoom(target)
    local tracedata = {}
    tracedata.start = self:GetPos()
    tracedata.endpos = target:GetPos()
    local trace = util.TraceLine(tracedata)

    return not trace.HitWorld
end
