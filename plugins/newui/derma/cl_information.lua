local PANEL = {}

function PANEL:Init()
end

vgui.Register("ixCharacterInfo", PANEL, "DScrollPanel")

hook.Add("CreateMenuButtons", "ixCharInfo", function(tabs)
    tabs["you"] = nil
end)
