local PLUGIN = PLUGIN

PLUGIN.name = "IED"
PLUGIN.description = ""
PLUGIN.author = "Riggs.mackay & Skay"

PLUGIN.frequencies = {
    82.4,
    87.9,
    104.4,
    115.4,
    54.2,
    95.2,
    108.4,
    12.9,
}

ix.util.ieds = ix.util.ieds or {}

ix.util.Include("sv_plugin.lua")