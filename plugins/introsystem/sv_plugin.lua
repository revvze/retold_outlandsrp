--[[---------------------------------------------------------------------------
    ** License: https://creativecommons.org/licenses/by-nc-nd/4.0/

    ** Copryright 2022 Riggs.mackay
    ** This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 4.0 Unported License.
---------------------------------------------------------------------------]]--

local PLUGIN = PLUGIN

function PLUGIN:PlayerLoadedCharacter(ply, char, oldChar)
    if ( ix.intro.config[game.GetMap()] ) then
        if ( ply:GetPData("ixIntroLoaded."..game.GetMap(), false) ) then return end

        ix.intro:Start(ply)
        ply:SetPData("ixIntroLoaded."..game.GetMap(), true) -- Why tostring? It returns a string.
    end
end

util.AddNetworkString("ixIntroStart")
function ix.intro:Start(ply)
    if ( ix.intro.config[game.GetMap()] ) then
        net.Start("ixIntroStart")
        net.Send(ply)
    end
end

concommand.Add("ix_intro_start", function(ply)
    if not ( ply:IsSuperAdmin() ) then return end
    
    ix.intro:Start(ply)
end)