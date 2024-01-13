--[[---------------------------------------------------------------------------
    ** License: https://creativecommons.org/licenses/by-nc-nd/4.0/

    ** Copryright 2022 Riggs.mackay
    ** This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 4.0 Unported License.
---------------------------------------------------------------------------]]--

local PLUGIN = PLUGIN

PLUGIN.name = "Intro System"
PLUGIN.description = "A system for introducing players to the server."
PLUGIN.author = "Riggs.mackay"

-- Define tables
ix.intro = ix.intro or {}
ix.intro.config = ix.intro.config or {}

ix.intro.config.music = "litenetwork/music/2020.wav"
ix.intro.config.transitionSounds = {
    "ui/buttonclickrelease.wav",
}

-- Map Config for Intro System
ix.util.IncludeDir(PLUGIN.folder.."/maps", true)

-- Include Core Files for Intro System, don't touch these files.
ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")