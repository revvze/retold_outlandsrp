FACTION.name = "Conscript"
FACTION.description = ""
FACTION.color = Color(0, 50, 0)
FACTION.isDefault = true

FACTION.models = {
    "models/litenetwork/conscript_masked.mdl",
}

FACTION.xp = 800

FACTION.ranks = {
    {
        abbreviation = "PVT",
        name = "Private",
        description = "",
        xp = 800,
    },
    {
        abbreviation = "PFC",
        name = "Private First Class",
        description = "",
        xp = 1200,
    },
    {
        abbreviation = "SPC",
        name = "Specialist",
        description = "",
        xp = 1600,
    },
    {
        abbreviation = "CPL",
        name = "Corporal",
        description = "",
        xp = 2200,
    },
    {
        abbreviation = "SGT",
        name = "Sergeant",
        description = "",
        xp = 2600,
    },
    {
        abbreviation = "SGM",
        name = "Sergeant Major",
        description = "",
        xp = 3000,
    },
    {
        abbreviation = "LT",
        name = "Lieutenant",
        description = "",
        xp = 3200,
    },
    {
        abbreviation = "CPT",
        name = "Captain",
        description = "",
        xp = 4000,
    },
}

FACTION.classes = {
    {
        name = "Soldier",
        description = "",
        xp = 800,
        model = "models/litenetwork/conscript_masked.mdl",
        skin = 0,
        limit = nil,
        onBecome = function(ply, char, inv, rank)
            local rankWeaponTable = {
                ["PVT"] = {
                    "glock17",
                },
                ["PFC"] = {
                    "smg1",
                },
                ["SPC"] = {
                    "glock17",
                    "smg1",
                },
                ["CPL"] = {
                    "glock17",
                    "smg1",
                },
                ["SGT"] = {
                    "mk32",
                    "smg1",
					"wep_flashbang",
                },
                ["SGM"] = {
                    "mk32",
                    "m16a2",
					"wep_flashbang",
                },
                ["LT"] = {
                    "mk32",
                    "m16a2",
					"wep_flashbang",
                },
                ["CPT"] = {
                    "mk32",
                    "m16a2",
					"wep_flashbang",
                },
            }

            if ( rankWeaponTable[rank.abbreviation] ) then
                for k, v in pairs(rankWeaponTable[rank.abbreviation]) do
                    inv:Add(v)
                end
            end
            inv:Add("wep_rappel")
			inv:Add("flaregun")

            if ( char:GetClass() == CLASS_CONSCRIPT_C ) then
                ply:SetModel("models/ddok1994/1980_hazmat.mdl")
            end
        end,
    },
    {
        name = "Medic",
        description = "",
        xp = 1600,
        model = "models/yukon/conscripts/conscript_bms_friendly.mdl",
        skin = 0,
        limit = 2,
        onBecome = function(ply, char, inv, rank)
            inv:Add("smg1")
            inv:Add("wep_rappel")
            ply:Give("weapon_medkit")
			inv:Add("flaregun")

            if ( char:GetClass() == CLASS_CONSCRIPT_C ) then
                ply:SetModel("models/ddok1994/1980_hazmat.mdl")
            end
        end,
    },
    {
        name = "Breacher",
        description = "",
        xp = 2600,
        model = "models/litenetwork/conscript_gasmask.mdl",
        skin = 0,
        limit = 1,
        onBecome = function(ply, char, inv, rank)
            inv:Add("shotgun")
            inv:Add("wep_grenade")
            inv:Add("wep_rappel")
			inv:Add("wep_flashbang")
			inv:Add("flaregun")

            if ( char:GetClass() == CLASS_CONSCRIPT_C ) then
                ply:SetModel("models/ddok1994/1980_hazmat.mdl")
            end
        end,
    },
}

if ( SERVER ) then
    util.AddNetworkString("ixConscriptClassPick")
    util.AddNetworkString("ixConscriptClassBecome")

    net.Receive("ixConscriptClassBecome", function(len, ply)
        local char = ply:GetCharacter()

        if ( char and char:GetClass() == nil ) then
            local class = net.ReadString()
            if ( class == "rebel" ) then
                char:SetClass(CLASS_CONSCRIPT_R)
            elseif ( class == "combine" ) then
                char:SetClass(CLASS_CONSCRIPT_C)
            end 

            ply:Spawn()
            ply:SetupHands()

            hook.Run("PlayerTeamChanged", ply)
        end
    end)
else
    net.Receive("ixConscriptClassPick", function()
        Derma_Query("Which side would you like to be on?", "", "Rebel", function()
            net.Start("ixConscriptClassBecome")
                net.WriteString("rebel")
            net.SendToServer()
        end, "Combine", function()
            net.Start("ixConscriptClassBecome")
                net.WriteString("combine")
            net.SendToServer()
        end)
    end)
end

FACTION.onBecome = function(ply, char)
    net.Start("ixConscriptClassPick")
    net.Send(ply)
end

FACTION_CONSCRIPT = FACTION.index
