local PLUGIN = PLUGIN

function PLUGIN:PlayerInitialSpawn(ply, char)
    ply:SetXP(ply:GetPData("ixXP", 0))

    timer.Create("ixXP.Timer."..ply:SteamID64(), PLUGIN.time, 0, function()
        PLUGIN.gainXP(ply, true)
    end)
end

function PLUGIN:PlayerDisconnected(ply)
    if ( timer.Exists("ixXP.Timer."..ply:SteamID64()) ) then
        timer.Remove("ixXP.Timer."..ply:SteamID64())
    end
end

function PLUGIN.gainXP(ply, bNotify)
    local gain = PLUGIN.gain or 5
    if ( ply:IsDonator() ) then
        gain = PLUGIN.donatorGain or 10
    end

    if ( bNotify ) then
        ply:Notify("You have gained "..gain.." XP for playing on the server for 10 Minutes!")
    end
    
    ply:SetXP(ply:GetPData("ixXP") + gain)
    ply:SetPData("ixXP", ply:GetXP())
end