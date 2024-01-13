util.AddNetworkString("ixSurfaceSound")
util.AddNetworkString("ixOpenVGUI")
util.AddNetworkString("ixPlayerDeathFactionChange")
util.AddNetworkString("ixViewCamera")
util.AddNetworkString("ixRankNPC.Weapons.SoldierEOW.C")
util.AddNetworkString("ixRankNPC.Weapons.SoldierEOW.S")
util.AddNetworkString("ixRankNPC.Weapons.EliteEOW.C")
util.AddNetworkString("ixRankNPC.Weapons.EliteEOW.S")

function Schema:GiveWeapons(ply, weapons)
    for i, weapon in ipairs(weapons) do
        ply:Give(weapon)
    end
end

net.Receive("ixViewCamera", function(len, ply)
    local camera = net.ReadEntity()
    
    if ( camera:GetClass() == "npc_combine_camera" ) and ( camera:Health() > 0 ) then
        ply:SetNetVar("ixCurrentCamera", camera)
        ply:SetViewEntity(camera)
        ply:Freeze(true)
    end

    if ( camera:GetClass() == "npc_combine_camera" ) and ( camera:Health() <= 0 ) then
        ply:Notify("The camera is not in state to be viewed.")
    end
end)

net.Receive("ixRankNPC.Weapons.SoldierEOW.S", function(len, ply)
    if not ( IsValid(ply) and ply:Alive() and ply:GetCharacter() ) then return end
    if not ( ply:IsOW() ) then return end

    local weapon = net.ReadString()

    -- i facka yu!
    if not ( weapon == "wep_mp7" or weapon == "wep_ar2" ) then
        return
    end

    ply:GetCharacter():GetInventory():Add(weapon)
end)

net.Receive("ixRankNPC.Weapons.EliteEOW.S", function(len, ply)
    if not ( IsValid(ply) and ply:Alive() and ply:GetCharacter() ) then return end
    if not ( ply:IsOW() ) then return end

    local weapon = net.ReadString()

    -- i facka yu!
    if not ( weapon == "wep_spas12" or weapon == "wep_ar2" ) then
        return
    end

    ply:GetCharacter():GetInventory():Add(weapon)
end)