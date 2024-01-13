function ix.util.DrawTexture(material, color, x, y, w, h)
    surface.SetDrawColor(color or color_white)
    surface.SetMaterial(ix.util.GetMaterial(material))
    surface.DrawTexturedRect(x, y, w, h)
end

net.Receive("ixRankNPC.Weapons.SoldierEOW.C", function()
    local ply = LocalPlayer()

    if not ( IsValid(ply) and ply:Alive() and ply:GetCharacter() ) then return end
    if not ( ply:IsOW() ) then return end

    Derma_Query("What Weapon would you like being given?", team.GetName(ply:Team()).." - Supply Menu", "MP7", function()
        net.Start("ixRankNPC.Weapons.SoldierEOW.S")
            net.WriteString("wep_mp7")
        net.SendToServer()
    end, "Pulse-Rifle", function()
        net.Start("ixRankNPC.Weapons.SoldierEOW.S")
            net.WriteString("wep_ar2")
        net.SendToServer()
    end)
end)

net.Receive("ixRankNPC.Weapons.EliteEOW.C", function()
    local ply = LocalPlayer()

    if not ( IsValid(ply) and ply:Alive() and ply:GetCharacter() ) then return end
    if not ( ply:IsOW() ) then return end

    Derma_Query("What Weapon would you like being given?", team.GetName(ply:Team()).." - Supply Menu", "SPAS-12", function()
        net.Start("ixRankNPC.Weapons.EliteEOW.S")
            net.WriteString("wep_spas12")
        net.SendToServer()
    end, "Pulse-Rifle", function()
        net.Start("ixRankNPC.Weapons.EliteEOW.S")
            net.WriteString("wep_ar2")
        net.SendToServer()
    end)
end)