--[[---------------------------------------------------------------------------
    ** License: https://creativecommons.org/licenses/by-nc-nd/4.0/

    ** Copryright 2022 Riggs.mackay
    ** This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 4.0 Unported License.
---------------------------------------------------------------------------]]--

local PLUGIN = PLUGIN

net.Receive("ixIntroStart", function()
    local mapconfig = ix.intro.config[game.GetMap()]
    LocalPlayer().ixIntroState = true
    ix.scenes.PlaySet(mapconfig, ix.intro.config.music, function()
        LocalPlayer().ixIntroState = nil
    end)
end)

concommand.Add("ix_intro_getpos", function(ply)
    local pos = ply:EyePos()
    local introDetails = "Vector("..pos.x..", "..pos.y..", "..pos.z..")"
    
    SetClipboardText(introDetails)
end)

concommand.Add("ix_intro_getang", function(ply)
    local ang = ply:GetAngles()
    local introDetails = "Angle("..ang.p..", "..ang.y..", "..ang.r..")"

    SetClipboardText(introDetails)
end)

concommand.Add("ix_intro_getposang", function(ply, cmd, args)
    local pos = ply:EyePos()
    local ang = ply:GetAngles()
    local introDetails = "pos = Vector("..pos.x..", "..pos.y..", "..pos.z.."),\nang = Angle("..ang.p..", "..ang.y..", "..ang.r.."),"
    if ( args[1] ) then
        introDetails = "endpos = Vector("..pos.x..", "..pos.y..", "..pos.z.."),\nendang = Angle("..ang.p..", "..ang.y..", "..ang.r.."),"
    end

    SetClipboardText(introDetails)
end)

concommand.Add("ix_intro_end", function(ply)
    ply.ixIntroState = nil
end)