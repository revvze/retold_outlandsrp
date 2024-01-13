--[[---------------------------------------------------------------------------
    ** License: https://creativecommons.org/licenses/by-nc-nd/4.0/

    ** void_alarmCopryright 2022 Riggs.mackay
    ** This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 4.0 Unported License.
---------------------------------------------------------------------------]]--

local PLUGIN = PLUGIN

PLUGIN.name = "Combine Improvements"
PLUGIN.description = "Adds alot of features, additions, updates to the Combine Factions."
PLUGIN.author = "Riggs.mackay"

PLUGIN.dispatchCooldown = 600
PLUGIN.dispatchLines = {
    {
        message = "Citizen reminder: Inaction is conspiracy. Report counter-behavior to a Civil-Protection team immediately.",
        soundFile = "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav",
    },
    {
        message = "Citizen notice: Failure to co-operate will result in permanent off-world relocation.",
        soundFile = "npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav",
    },
}

PLUGIN.digitsToWords = {
    [0] = "zero",
    [1] = "one",
    [2] = "two",
    [3] = "three",
    [4] = "four",
    [5] = "five",
    [6] = "six",
    [7] = "seven",
    [8] = "eight",
    [9] = "nine",
}

PLUGIN.taglines = {
    "APEX",
    "BLADE",
    "DASH",
    "DEFENDER",
    "GHOST",
    "GRID",
    "HELIX",
    "HUNTER",
    "HURRICANE",
    "ION",
    "JET",
    "JUDGE",
    "JURY",
    "MACE",
    "NOVA",
    "QUICKSAND",
    "RANGER",
    "RAZOR",
    "SAVAGE",
    "SPEAR",
    "SWIFT",
    "STINGER",
    "STORM",
    "SUNDOWN",
    "SWORD",
    "UNIFORM",
    "VAMP",
    "VICE",
    "VICTOR",
    "WINDER",
    "XRAY",
    "ZONE",
    "ECHO",
    "HERO",
    "KING",
    "QUICK",
    "ROLLER",
    "STICK",
    "UNION",
    "YELLOW",
    "LEADER",
    "HAMMER",
}

PLUGIN.locations = {
    ["metropolice"] = {
        ["404 Zone"] = "npc/metropolice/vo/404zone.wav",
        ["Canal Block"] = "npc/metropolice/vo/canalblock.wav",
        ["Condemned Zone"] = "npc/metropolice/vo/condemnedzone.wav",
        ["Control Section"] = "npc/metropolice/vo/controlsection.wav",
        ["Deserviced Area"] = "npc/metropolice/vo/deservicedarea.wav",
        ["Distribution Block"] = "npc/metropolice/vo/distributionblock.wav",
        ["External Jurisdiction"] = "npc/metropolice/vo/externaljurisdiction.wav",
        ["Stabilization Jurisdiction"] = "npc/metropolice/vo/stabilizationjurisdiction.wav",
        ["High Priority Region"] = "npc/metropolice/vo/highpriorityregion.wav",
        ["Industrial Zone"] = "npc/metropolice/vo/industrialzone.wav",
        ["Infested Zone"] = "npc/metropolice/vo/infestedzone.wav",
        ["Outland Zone"] = "npc/metropolice/vo/outlandzone.wav",
        ["Production Block"] = "npc/metropolice/vo/productionblock.wav",
        ["Politicontrol Section"] = "npc/metropolice/vo/politicontrol_section.wav",
        ["Repurposed Area"] = "npc/metropolice/vo/repurposedarea.wav",
        ["Residential Block"] = "npc/metropolice/vo/residentialblock.wav",
        ["Production Block"] = "npc/metropolice/vo/stormsystem.wav",
        ["Canal Block"] = "npc/metropolice/vo/terminalrestrictionzone.wav",
        ["Transit Block"] = "npc/metropolice/vo/transitblock.wav",
        ["Waste River"] = "npc/metropolice/vo/wasteriver.wav",
        ["Workforce Intake Hub"] = "npc/metropolice/vo/workforceintake.wav",
    },
    ["dispatch"] = {
        ["404 Zone"] = "npc/overwatch/radiovoice/404zone.wav",
        ["Canal Block"] = "npc/overwatch/radiovoice/canalblock.wav",
        ["Condemned Zone"] = "npc/overwatch/radiovoice/condemnedzone.wav",
        ["Control Section"] = "npc/overwatch/radiovoice/controlsection.wav",
        ["Deserviced Area"] = "npc/overwatch/radiovoice/deservicedarea.wav",
        ["Distribution Block"] = "npc/overwatch/radiovoice/distributionblock.wav",
        ["External Jurisdiction"] = "npc/overwatch/radiovoice/externaljurisdiction.wav",
        ["Stabilization Jurisdiction"] = "npc/overwatch/radiovoice/stabilizationjurisdiction.wav",
        ["High Priority Region"] = "npc/overwatch/radiovoice/highpriorityregion.wav",
        ["Industrial Zone"] = "npc/overwatch/radiovoice/industrialzone.wav",
        ["Infested Zone"] = "npc/overwatch/radiovoice/infestedzone.wav",
        ["Outland Zone"] = "npc/overwatch/radiovoice/outlandzone.wav",
        ["Production Block"] = "npc/overwatch/radiovoice/productionblock.wav",
        ["Politicontrol Section"] = "npc/overwatch/radiovoice/politicontrol_section.wav",
        ["Repurposed Area"] = "npc/overwatch/radiovoice/repurposedarea.wav",
        ["Residential Block"] = "npc/overwatch/radiovoice/residentialblock.wav",
        ["Production Block"] = "npc/overwatch/radiovoice/stormsystem.wav",
        ["Canal Block"] = "npc/overwatch/radiovoice/terminalrestrictionzone.wav",
        ["Transit Block"] = "npc/overwatch/radiovoice/transitblock.wav",
        ["Waste River"] = "npc/overwatch/radiovoice/wasteriver.wav",
        ["Workforce Intake Hub"] = "npc/overwatch/radiovoice/workforceintake.wav",
    },
}

ix.visor = ix.visor or {}
ix.dispatch = ix.dispatch or {}

ix.util.Include("cl_hooks.lua")
ix.util.Include("cl_hud.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sh_citycodes.lua")
ix.util.Include("sh_sociostatus.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("sv_citycodes.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("sv_sociostatus.lua")

ix.lang.AddTable("english", {
    optUnitStatus = "Unit Status",
    optdUnitStatus = "Wether or not you want to show the unit status on your hud.",

    optUnitInformation = "Unit Information",
    optdUnitInformation = "Wether or not you want to show the unit information on your hud.",

    optCompass = "Compass",
    optdCompass = "Wether or not you want to show the compass on your hud.",
})

ix.option.Add("unitStatus", ix.type.bool, true, {
    category = PLUGIN.name,
    default = true,
})

ix.option.Add("unitInformation", ix.type.bool, true, {
    category = PLUGIN.name,
    default = true,
})

ix.option.Add("compass", ix.type.bool, true, {
    category = PLUGIN.name,
    default = true,
})

local PLAYER = FindMetaTable("Player")

function PLAYER:AddDisplay(message, color, soundBool)
    if ( SERVER ) then
        net.Start("ixDisplaySend")
            net.WriteString(message)
            net.WriteColor(color or color_white)
            net.WriteBool(soundBool or false)
        net.Send(self)
    else
        ix.display.AddDisplay(message, color or color_white, soundBool or false)
    end
end

function ix.dispatch.announce(text, target, delay)
    if ( delay ) then
        if not ( isnumber(delay) ) then return end
        timer.Simple(delay, function()
            if ( CLIENT ) then
                chat.AddText(Color(255, 40, 40), "Overwatch broadcasts: "..text)
            elseif ( SERVER ) then
                if ( target and IsValid(target) ) then
                    net.Start("ixDispatchSend")
                        net.WriteString(text)
                    net.Send(target)
                else
                    net.Start("ixDispatchSend")
                        net.WriteString(text)
                    net.Broadcast()
                end
            end
        end)
    else
        if ( CLIENT ) then
            chat.AddText(Color(255, 40, 40), "Overwatch broadcasts: "..text)
        elseif ( SERVER ) then
            if ( target and IsValid(target) ) then
                net.Start("ixDispatchSend")
                    net.WriteString(text)
                net.Send(target)
            else
                net.Start("ixDispatchSend")
                    net.WriteString(text)
                net.Broadcast()
            end
        end
    end
end

function ix.util.GetAllCombine()
    local combine = {}

    for _, v in ipairs(player.GetAll()) do
        if ( v:IsCombine() ) then
            table.insert(combine, v)
        end
    end

    return combine
end

function ix.util.GetAllCommanders()
    local cmd = {}

    for k, v in ipairs(player.GetAll()) do
        if ( v:IsCombineCommand() ) then
            table.insert(cmd, v)
        end
    end

    return cmd
end

function ix.util.GetAllSupervisors()
    local svs = {}

    for k, v in ipairs(player.GetAll()) do
        if ( v:IsCombineSuperviors() ) then
            table.insert(svs, v)
        end
    end

    return svs
end

function ix.util.GetAllCPs()
    local cps = {}

    for _, v in ipairs(player.GetAll()) do
        if ( v:Team() == FACTION_CP ) then
            table.insert(cps, v)
        end
    end

    return cps
end

function ix.util.GetAllOTA()
    local irts = {}

    for _, v in ipairs(player.GetAll()) do
        if ( v:Team() == FACTION_OTA ) then
            table.insert(irts, v)
        end
    end

    return irts
end
