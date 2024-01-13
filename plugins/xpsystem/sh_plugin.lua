local PLUGIN = PLUGIN

PLUGIN.name = "XP System"
PLUGIN.description = "A XP System, inspired from impulse."
PLUGIN.author = "Riggs.mackay"

PLUGIN.time = 600
PLUGIN.gain = 10
PLUGIN.donatorGain = 15

ix.util.Include("sh_meta.lua")
ix.util.Include("sv_plugin.lua")

ix.command.Add("GetXP", {
    description = "Get's a player's XP",
    arguments = {
        bit.bor(ix.type.player, ix.type.optional),
    },
    OnRun = function(self, ply, target)
        if ( target ) then
            ply:Notify(target:SteamName().." XP count is "..target:GetXP()..".")
        elseif ( !target ) then
            ply:Notify("Your XP count is "..ply:GetXP()..".")
        end
    end,
})

ix.command.Add("SetXP", {
    description = "Set's a player's XP",
    superAdminOnly = true,
    arguments = {
        ix.type.number,
        bit.bor(ix.type.player, ix.type.optional),
    },
    OnRun = function(self, ply, amount, target)
        if ( target and amount ) then
            target:SetXP(amount)
            ply:Notify("You have set "..target:SteamName().."("..target:Nick()..") XP to "..amount)
        elseif ( !target and amount ) then
            ply:SetXP(amount)
            ply:Notify("You have set your own XP to "..amount)
        end
    end,
})
