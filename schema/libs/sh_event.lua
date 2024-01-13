ix.event = ix.event or {}
ix.event.list = {}

function ix.event.LoadFromDir(directory)
    for _, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
        -- Get the name without the "sh_" prefix and ".lua" suffix.
        local niceName = v:sub(4, -5)
        -- Determine a numeric identifier for this event.
        local index = #ix.event.list + 1
        local halt

        for _, v2 in ipairs(ix.event.list) do
            if (v2.uniqueID == niceName) then
                halt = true
            end
        end

        if (halt == true) then
            continue
        end

        -- Set up a global table so the file has access to the event table.
        EVENT = {index = index, uniqueID = niceName}
            EVENT.name = "Unknown"
            EVENT.description = "No description available."
            
            ix.util.Include(directory.."/"..v, "shared")

            ix.event.list[niceName] = EVENT
        EVENT = nil
    end
end

if ( SERVER ) then
    util.AddNetworkString("ixEvent.PlaySound")
    util.AddNetworkString("ixEvent.StopSound")
        
    function ix.event.PlaySound(caller, soundData)
        if not ( IsValid(caller) ) then return end
        if not ( soundData.sound ) then return end
    
        net.Start("ixEvent.PlaySound")
            net.WriteTable({
                sound = soundData.sound,
                db = soundData.db or 75,
                pitch = soundData.pitch or 100,
                volume = soundData.volume or 1,
                delay = soundData.delay or nil,
            })
        net.Send(caller)
    end
    
    function ix.event.PlaySoundGlobal(soundData)
        if not ( soundData.sound ) then return end
    
        net.Start("ixEvent.PlaySound")
            net.WriteTable({
                sound = soundData.sound,
                db = soundData.db or 75,
                pitch = soundData.pitch or 100,
                volume = soundData.volume or 1,
                delay = soundData.delay or nil,
            })
        net.Broadcast()
    end
    
    function ix.event.StopSoundGlobal(soundString)
        if not ( soundString ) then return end
    
        net.Start("ixEvent.StopSound")
            net.WriteString(soundString)
        net.Broadcast()
    end
    
    function ix.event.EmitShake(amplitute, frequency, duration, delay)
        timer.Simple(delay or 0, function()
            for k, v in ipairs(player.GetAll()) do
                if ( IsValid(v) ) then
                    util.ScreenShake(v:GetPos(), amplitute, frequency, duration, 64)
                end
            end
        end)
    end

    concommand.Add("ix_event_stopsoundall", function(ply, cmd, args)
        if ( ply:IsEventAdmin() ) then
            for k, v in pairs(player.GetAll()) do
                v:ConCommand("stopsound")
            end

            ply:Notify("You ran the stopsound command on everyone.")
        end
    end)
    
    concommand.Add("ix_event_playsound", function(ply, cmd, args)
        if ( ply:IsEventAdmin() and args[1] ) then
            local target = ix.util.FindPlayer(args[1])
            if ( target ) then
                ix.event.PlaySoundGlobal(target, {sound = args[1]})

                ply:Notify("You played the sound '"..args[1].."' on everyone.")
            else
                ply:Notify("Invalid Target: "..args[1])
            end
        end
    end)
    
    concommand.Add("ix_event_playsoundall", function(ply, cmd, args)
        if ( ply:IsEventAdmin() and args[1] ) then
            ix.event.PlaySoundGlobal({sound = args[1]})

            ply:Notify("You played the sound '"..args[1].."' on everyone.")
        end
    end)
    
    concommand.Add("ix_event_start", function(ply, cmd, args)
        if ( ply:IsEventAdmin() and args[1] ) then
            if not ( ix.event.list[args[1]]) then
                ply:Notify("This Event type does not exist!")
                return false
            end

            if ( ix.event.active ) then
                ply:Notify("There already is a Event executed.")
                return false
            end

            ix.event.list[args[1]].onStart()
            ix.event.active = args[1]
        end
    end)
    
    concommand.Add("ix_event_stop", function(ply, cmd, args)
        if ( ply:IsEventAdmin() and args[1] ) then
            if not ( ix.event.list[args[1]]) then
                ply:Notify("This Event type does not exist!")
                return false
            end

            if not ( ix.event.active ) then
                ply:Notify("There is no Event executed.")
                return false
            end

            ix.event.list[args[1]].onStop()
            ix.event.active = nil
        end
    end)
else
    net.Receive("ixEvent.PlaySound", function()
        local soundData = net.ReadTable()
        if not ( soundData.sound ) then return end
    
        if ( soundData.delay and isnumber(soundData.delay) ) then
            timer.Simple(soundData.delay, function()
                LocalPlayer():EmitSound(soundData.sound, soundData.db, soundData.pitch, soundData.volume)
            end)
        else
            LocalPlayer():EmitSound(soundData.sound, soundData.db, soundData.pitch, soundData.volume)
        end
    end)
    
    net.Receive("ixEvent.StopSound", function()
        local soundString = net.ReadString()
        if not ( soundString ) then return end
    
        LocalPlayer():StopSound(soundString)
    end)
end

ix.event.LoadFromDir(engine.ActiveGamemode().."/schema/events")