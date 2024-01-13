util.AddNetworkString("ixRankNPC.Become")

net.Receive("ixRankNPC.Become", function(len, ply)
    if ( ( ply.ixRankNPCdelay or 0 ) >= CurTime() ) then
        ply:Notify("You need to wait before switching classes or ranks!")
        return
    end

    local char = ply:GetCharacter()

    local classID = net.ReadUInt(8)
    local rankID = net.ReadUInt(8)

    local classs = ix.faction.Get(ply:Team()).classes
    local ranks = ix.faction.Get(ply:Team()).ranks

    local class = classs[classID]
    local rank = ranks[rankID]

    if not ( ply:CanBecomeTeamClass(classID, true) ) then
        return
    end
    
    if not ( ply:CanBecomeTeamRank(rankID, true) ) then
        return
    end

    if ( class.name == "Elite" and rank.name == "OWS" ) then
        ply:Notify("You cannot become an OWS in the Elite class!")
        return false
    end

    local model = class.model or table.Random(ix.faction.Get(ply:Team()).models)
    local skin = class.skin or 0
    local onBecomeRank = rank.onBecome or nil
    local onBecomeClass = class.onBecome or nil

    local randomNumber = math.random(1, 9)
    local randomTagline = table.Random(ix.faction.Get(ply:Team()).taglines or {})
    
    local abbreviation = "UU"
    if ( ply:IsCP() ) then
        abbreviation = "CP"
    elseif ( ply:IsIRT() ) then
        abbreviation = "IRT"
    elseif ( ply:IsOW() ) then
        abbreviation = "OW"
    end

    local newName = ""
    if ( ply:IsCP() ) then
        newName = abbreviation..":"..class.name.."."..rank.name.."."..randomTagline.."-"..randomNumber
    elseif ( ply:IsIRT() ) then
        newName = abbreviation..":"..class.name.."."..rank.name.."."..randomTagline.."-"..randomNumber
    elseif ( ply:IsOW() ) then
        newName = abbreviation..":"..randomTagline.."."..rank.name.."-"..randomNumber
    elseif ( ply:IsConscript() ) then
        newName = rank.abbreviation..". "..char:GetData("originalName", "John Doe")
    end

    ply:ResetBodygroups()

    char:SetName(newName)
    ply:Notify("You have become a "..rank.name.." "..class.name..".")

    if ( model ) then
        char:SetModel(model)
    end

    if ( skin ) then
        ply:SetSkin(skin)
    end

    for i = 0, 30 do
        ply:SetSubMaterial(i, "")
    end

    for k, v in pairs(char:GetInventory():GetItems()) do
        v:Remove()
    end

    ply:StripWeapons()
    ply:StripAmmo()

    ply:SetHealth(100)
    ply:SetArmor(0)

    if ( onBecomeRank ) then
        onBecomeRank(ply, char, char:GetInventory(), class)
    end

    if ( onBecomeClass ) then
        onBecomeClass(ply, char, char:GetInventory(), rank)
    end

    ply:SetMaxHealth(ply:Health())
    ply:SetMaxArmor(ply:Armor())

    Schema:GiveWeapons(ply, {"ix_hands", "ix_keys", "weapon_physgun", "gmod_tool"})

    ply:SetLocalVar("ixClass", classID)
    ply:SetLocalVar("ixRank", rankID)

    ply:SetupHands()

    local delay = 30
    if ( ply:IsAdmin() ) then
        delay = 5
    end

    ply.ixRankNPCdelay = CurTime() + delay
end)

util.AddNetworkString("ixRankNPC.BecomeNoRank")

net.Receive("ixRankNPC.BecomeNoRank", function(len, ply)
    if ( ( ply.ixRankNPCdelay or 0 ) >= CurTime() ) then
        ply:Notify("You need to wait before switching classes!")
        return
    end

    local char = ply:GetCharacter()

    local classID = net.ReadUInt(8)
    local classs = ix.faction.Get(ply:Team()).classes
    local class = classs[classID]

    if not ( ply:CanBecomeTeamClass(classID, true) ) then
        return
    end
    
    local model = class.model or table.Random(ix.faction.Get(ply:Team()).models)
    local skin = class.skin or 0
    local onBecomeClass = class.onBecome or nil

    local randomNumber = math.random(1, 9)
    local randomTagline = table.Random(ix.faction.Get(ply:Team()).taglines or {})
    
    local abbreviation = "UU"
    if ( ply:IsIRT() ) then
        abbreviation = "IRT"
    end

    local newName = ""
    if ( ply:IsIRT() ) then
        newName = abbreviation..":"..class.name.."-"..randomNumber
    end

    ply:ResetBodygroups()

    char:SetName(newName)
    ply:Notify("You have become a "..class.name..".")

    if ( model ) then
        char:SetModel(model)
    end

    if ( skin ) then
        ply:SetSkin(skin)
    end

    for i = 0, 10 do
        ply:SetSubMaterial(i, "")
    end

    for k, v in pairs(char:GetInventory():GetItems()) do
        v:Remove()
    end

    ply:StripWeapons()
    ply:StripAmmo()

    ply:SetHealth(100)
    ply:SetArmor(0)

    ply:SetModelScale(1)

    if ( onBecomeClass ) then
        onBecomeClass(ply, char, char:GetInventory(), nil)
    end

    ply:SetMaxHealth(ply:Health())
    ply:SetMaxArmor(ply:Armor())

    Schema:GiveWeapons(ply, {"ix_hands", "ix_keys", "weapon_physgun", "gmod_tool"})

    ply:SetLocalVar("ixClass", classID)
    ply:SetLocalVar("ixRank", 0)

    ply:SetupHands()

    local delay = 30
    if ( ply:IsAdmin() ) then
        delay = 5
    end

    ply.ixRankNPCdelay = CurTime() + delay
end)