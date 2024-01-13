util.AddNetworkString("ixFactionMenuBecome")

function ix.util.FactionBecome(ply, factionID)
    local char = ply:GetCharacter()
    local model = table.Random(ix.faction.Get(factionID).models)
    if ( factionID == FACTION_CITIZEN or factionID == FACTION_CWU ) then
        model = char:GetData("originalModel", table.Random(ix.faction.Get(factionID).models))
    end
    
    ply:ResetBodygroups()

    char:SetFaction(factionID)
    char:SetClass(nil)
    char:SetModel(model)
    ply:Spawn()

    for k, v in pairs(char:GetInventory():GetItems()) do
        if ( v:GetData("equip") ) then
            v:SetData("equip", nil)
        end
        v:Remove()
    end

    ply:StripWeapons()
    ply:StripAmmo()

    ply:SetHealth(100)
    ply:SetArmor(0)

    ply:SetModelScale(1)

    for i = 0, 30 do
        ply:SetSubMaterial(i, "")
    end

    Schema:GiveWeapons(ply, {"ix_hands", "weapon_physgun", "gmod_tool"})
    if ( ix.faction.Get(factionID).weapons ) then
        Schema:GiveWeapons(ply, ix.faction.Get(factionID).weapons)
    end

    ply:SetLocalVar("ixClass", nil)
    ply:SetLocalVar("ixRank", nil)

    ply:SetupHands()

    if ( ix.faction.Get(factionID).onBecome ) then
        ix.faction.Get(factionID).onBecome(ply, char)
    end

    hook.Run("PlayerTeamChanged", ply)
end

net.Receive("ixFactionMenuBecome", function(len, ply)
    if not ( IsValid(ply) and ply:Alive() and ply:GetCharacter() ) then
        return
    end

    local factionID = net.ReadUInt(8)
    local char = ply:GetCharacter()
    
    if ( ix.quiz and ix.quiz.questions[factionID] and ix.quiz.questions[factionID].quiz ) then
        local data = char:GetData("ixQuizCompleted."..ix.quiz.questions[factionID].uid, false)

        if not ( data ) then
            if not ( ix.quiz.enabled == true ) then return end

            if ( timer.Exists("ixNextQuiz") ) then
                print(timer.TimeLeft("ixNextQuiz"))
                ply:Notify("Wait "..string.NiceTime(timer.TimeLeft("ixNextQuiz")).." before attempting to retry the quiz.")
                return
            end

            ply.quizzing = true
            net.Start("ixQuizForce")
                net.WriteUInt(factionID, 8)
            net.Send(ply)

            return
        end
    end

    ix.util.FactionBecome(ply, factionID)
end)