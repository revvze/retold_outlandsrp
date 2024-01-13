--[[---------------------------------------------------------------------------
    ** License: https://creativecommons.org/licenses/by-nc-nd/4.0/

    ** Copryright 2022 Riggs.mackay
    ** This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 4.0 Unported License.
---------------------------------------------------------------------------]]--

local PLUGIN = PLUGIN

ix.command.Add("Doorkick", {
    description = "Kick the door.",
    OnRun = function(self, ply)
        local ent = ply:GetEyeTrace().Entity

        if ( ( ply.nextKickdoor or 0 ) > CurTime() ) then return end

        if not ( ix.anim.GetModelClass(ply:GetModel()) == "metrocop" ) then
            ply:Notify("Your model is not allowed to use this command!")
            return
        end

        if ( ent:GetClass() == "func_door" ) then
            return ply:Notify("You cannot kick down these type of doors!")
        end

        if not ( IsValid(ent) and ent:IsDoor() ) or ent:GetNetVar("disabled") then
            return ply:Notify("You are not looking at a door!")
        end

        if not ( ply:GetPos():Distance(ent:GetPos()) < 100 ) then
            return ply:Notify("You are not close enough!")
        end

        if ( IsValid(ent.ixLock) ) then
            ply:Notify("You cannot kick down a combine lock!")
            return false
        end        

        ply:ForceSequence("kickdoorbaton", function()
            if ( IsValid(ply) ) then
                ply:Freeze(false)
            end
        end, 1.7)
        
        timer.Simple(1, function()
            if ( IsValid(ent) ) then 
                ent:EmitSound("physics/wood/wood_plank_break1.wav", 100)
                ent:Fire("unlock")
                ent:Fire("openawayfrom", ply:SteamID64())
            end
        end)
        
        timer.Simple(2, function()
            if ( IsValid(ply) ) then
                ply:EmitSound("npc/metropolice/vo/dontmove.wav", 100)
            end
        end)

        ply.nextKickdoor = CurTime() + 2
    end
})

ix.command.Add("ToggleGate", {
    description = "Toggles the gate of the Overwatch Nexus.",
    OnRun = function(self, ply)
        if not ( ply:IsDispatch() or ply:IsCombineCommand() ) then
            ply:Notify("You don't have access to this command.")
            return
        end

        for k, v in pairs(ents.FindByName("blastdoors_toggle_1")) do
            v:Fire("trigger")
        end
    end
})

ix.command.Add("ChangeCityCode", {
    description = "Change City Code.",
    arguments = ix.type.text,
    OnRun = function(self, ply, code)
        if not ( ix.cityCode.codes[code] ) then
            for k, v in SortedPairs(ix.cityCode.codes) do
                ply:ChatNotify(k.." < "..v.name)
            end

            ply:Notify("You have provided a non-existent code. (All codes printed in chat)")
            return false
        end

        if not ( ix.cityCode.codes[code].OnCheckAccess ) then
            ply:Notify("You don't have access to change the specified city code.")
            return false
        end

        ply:SendLua("RunConsoleCommand('ix_code_set', '"..code.."')")
    end
})

ix.command.Add("ChangeSocioStatus", {
    description = "Change Socio Status.",
    arguments = ix.type.text,
    OnRun = function(self, ply, sociostatus)
        if not ( ix.socioStatus.codes[sociostatus] ) then
            for k, v in SortedPairs(ix.socioStatus.codes) do
                ply:ChatNotify(k.." < "..v.name)
            end

            ply:Notify("You have provided a non-existent socio status. (All socio statuses printed in chat)")
            return false
        end

        if not ( ix.socioStatus.codes[sociostatus].OnCheckAccess ) then
            ply:Notify("You don't have access to change the specified socio status.")
            return false
        end

        ply:SendLua("RunConsoleCommand('ix_status_set', '"..sociostatus.."')")
    end
})