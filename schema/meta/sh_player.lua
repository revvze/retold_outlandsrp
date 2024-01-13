local PLAYER = FindMetaTable("Player")

function PLAYER:IsCitizen()
    return ( self:Team() == FACTION_CITIZEN )
end

function PLAYER:IsRebel()
    return ( self:IsCitizen() ) and ( self:GetBodygroup(1) == 5 or self:GetBodygroup(1) == 6 )
end

function PLAYER:IsCWU()
    return ( self:Team() == FACTION_CWU )
end

function PLAYER:IsCombine()
    return ( self:Team() == FACTION_CP or self:Team() == FACTION_IRT or self:Team() == FACTION_OW )
end

function PLAYER:IsCP()
    return ( self:Team() == FACTION_CP )
end

function PLAYER:IsIRT()
    return ( self:Team() == FACTION_IRT )
end

function PLAYER:IsOW()
    return ( self:Team() == FACTION_OW )
end

function PLAYER:IsCA()
    return ( self:Team() == FACTION_CA )
end

function PLAYER:IsVortigaunt()
    return ( self:Team() == FACTION_VORTIGAUNT )
end

function PLAYER:IsDispatch()
    return ( self:Team() == FACTION_DISPATCH )
end

function PLAYER:IsConscript()
    return ( self:Team() == FACTION_CONSCRIPT )
end

local devIDs = {}
devIDs["76561198373309941"] = true -- Homie: Skay
devIDs["76561197963057641"] = true -- Homie: Riggs.mackay

function PLAYER:IsDeveloper()
    return ( self:GetUserGroup() == "developer" or devIDs[self:SteamID64()] )
end

function PLAYER:IsDonator()
    return ( self:GetUserGroup() == "donator" or self:IsAdmin() )
end

function PLAYER:SurfacePlaySound(sound)
    net.Start("ixSurfaceSound")
        net.WriteString(sound)
    net.Send(self)
end

function PLAYER:OpenVGUI(panel)
    if not ( isstring(panel) ) then
        ErrorNoHalt("Warning argument is required to be a string! Instead is "..type(panel).."\n")
        return
    end

    if ( SERVER ) then
        net.Start("ixOpenVGUI")
            net.WriteString(panel)
        net.Send(self)
    else
        vgui.Create(panel)
    end
end

net.Receive("ixOpenVGUI", function()
    local panel = net.ReadString()
    if not ( isstring(panel) ) then
        ErrorNoHalt("Warning argument is required to be a string! Instead is "..type(panel).."\n")
        return
    end
    
    vgui.Create(panel)
end)

function PLAYER:IsCombineCommand()
    if ( self:IsCP() and ( self:GetLocalVar("ixRank") == 7 or self:GetLocalVar("ixRank") == 8 ) ) then
        return true
    end

    if ( self:IsOW() and self:GetLocalVar("ixRank") == 3 ) then
        return true
    end

    return false
end

function PLAYER:IsCombineSupervisor()
    if ( self:IsCP() and self:GetLocalVar("ixRank") == 8 ) then
        return true
    end

    if ( self:IsOW() and self:GetLocalVar("ixRank") == 3 ) then
        return true
    end

    return false
end