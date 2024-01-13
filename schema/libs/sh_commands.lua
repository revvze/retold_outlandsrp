ix.command.Add("citizenclothes", {
    description = "Forcefully equip someone into citizen clothing.",
    arguments = {
        ix.type.player,
    },
    OnCheckAccess = function(self, ply)
        return ply:IsAdmin()
    end,
    OnRun = function(self, ply, target)
        target:SetBodygroup(1, 0)
        target:SetBodygroup(2, 0)

        hook.Run("HL2RPRebelState", target, false)

        ply:Notify("You set "..target:Nick().." clothes to citizen clothing.")
    end,
})

ix.command.Add("rebelclothes", {
    description = "Forcefully equip someone into rebel clothing.",
    arguments = {
        ix.type.player,
    },
    OnCheckAccess = function(self, ply)
        return ply:IsAdmin()
    end,
    OnRun = function(self, ply, target)
        target:SetBodygroup(1, math.random(5, 6))
        target:SetBodygroup(2, math.random(3, 4))

        hook.Run("HL2RPRebelState", target, true)

        ply:Notify("You set "..target:Nick().." clothes to rebel clothing.")
    end,
})

ix.command.Add("ChangeRoleplayName", {
    description = "Change your roleplay name, but as a cost of 50 XP.",
    arguments = {
        ix.type.text,
    },
    OnCheckAccess = function(self, ply)
        return ply:GetXP() >= 50
    end,
    OnRun = function(self, ply, newName)
        local char = ply:GetCharacter()
        char:SetName(newName)
        char:SetData("originalName", newName)

        ply:SetXP(ply:GetXP() - 50)
        ply:Notify("You changed your roleplay name to "..newName..".")
    end,
})

ix.command.Add("ForceRoleplayName", {
    description = "Forcefully change a roleplay name of someone.",
    arguments = {
        ix.type.player,
        ix.type.text,
    },
    OnCheckAccess = function(self, ply)
        return ply:IsAdmin()
    end,
    OnRun = function(self, ply, target, newName)
        target:GetCharacter():SetName(newName)
        target:GetCharacter():SetData("originalName", newName)

        ply:Notify("You forced "..target:Nick().." to change their roleplay name to "..newName..".")
        target:Notify("You were forced to change your roleplay name to "..newName..".")
    end,
})

-- SetPermaModel
ix.command.Add("SetPermaModel", {
    description = "Set a player's permanent model.",
    arguments = {
        ix.type.player,
        ix.type.text,
    },
    OnCheckAccess = function(self, ply)
        return ply:IsAdmin()
    end,
    OnRun = function(self, ply, target, newModel)
        target:GetCharacter():SetModel(newModel)
        target:GetCharacter():SetData("originalModel", newModel)

        ply:Notify("You set "..target:Nick().."'s permanent model to "..model..".")
    end,
})

ix.command.Add("CHands", {
    description = "Change a player's hands.",
    arguments = {
        ix.type.player,
        ix.type.text,
    },
    OnCheckAccess = function(self, ply)
        return ply:IsAdmin()
    end,
    OnRun = function(self, ply, target, chandModel)
        target:SetHands(chandModel)
        target:SetupHands()
        ply:Notify("You changed "..target:Nick().."'s hands to "..chandModel..".")
    end,
})

ix.command.Add("dispatch", {
    description = "Dispatch something to the city.",
    arguments = {
        ix.type.text,
    },
    OnCheckAccess = function(self, ply)
        return ply:IsCombineSupervisor() or ply:IsAdmin()
    end,
    OnRun = function(self, ply, text)
        ix.dispatch.announce(text)
    end,
})

ix.command.Add("discord", {
    description = "Join our Discord Server!",
    OnCanRun = function(_, ply)
        return true
    end,
    OnRun = function(_, ply)
        ply:SendLua([[gui.OpenURL("https://npcs.gg/discord")]])
    end
})

ix.command.Add("content", {
    description = "Get our Server's Content Pack.",
    OnCanRun = function(_, ply)
        return true
    end,
    OnRun = function(_, ply)
        ply:SendLua([[gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2836833518")]])
    end
})

ix.command.Add("rules", {
    description = "Read our server's rules.",
    OnCanRun = function(_, ply)
        return true
    end,
    OnRun = function(_, ply)
        ply:SendLua([[gui.OpenURL("https://docs.google.com/document/d/1t_6vcR2TnFs47iofjQhSPU2liKUeXNhoZvVKV3sxOUU6")]])
    end
})

