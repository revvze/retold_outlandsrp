EVENT.name = "City Battle"
EVENT.description = ""

EVENT.onStart = function()
    ix.event.PlaySoundGlobal({
        sound = "music/hl1_song9.mp3",
        volume = 0.3,
    })
    ix.event.PlaySoundGlobal({
        sound = "ambient/levels/streetwar/city_riot2.wav",
    })
    ix.event.PlaySoundGlobal({
        sound = "ambient/levels/streetwar/gunship_distant2.wav",
        delay = 2,
    })
    ix.event.PlaySoundGlobal({
        sound = "ambient/explosions/battle_loop1.wav",
        volume = 0.1,
        delay = 2,
    })
    ix.event.PlaySoundGlobal({
        sound = "ambient/explosions/battle_loop2.wav",
        volume = 0.2,
        delay = 2,
    })
    ix.event.PlaySoundGlobal({
        sound = "ambient/levels/streetwar/city_chant1.wav",
        delay = 3,
    })
    ix.event.PlaySoundGlobal({
        sound = "ambient/alarms/city_siren_loop2.wav",
        volume = 0.1,
        delay = 5,
    })

    timer.Create("ixCityBattleAmbience1", 3, 0, function()
        ix.event.PlaySoundGlobal({
            sound = "ambient/levels/streetwar/city_battle"..math.random(1, 19)..".wav",
            volume = math.random(0.10, 0.30),
            delay = math.random(0, 2.0),
        })
    end)

    timer.Create("ixCityBattleAmbience2", 8, 0, function()
        ix.event.PlaySoundGlobal({
            sound = "ambient/levels/streetwar/building_rubble"..math.random(1, 5)..".wav",
            volume = math.random(0.10, 0.20),
            delay = math.random(0, 2.0),
        })
    end)

    timer.Create("ixCityBattleAmbience3", 20, 0, function()
        ix.event.PlaySoundGlobal({
            sound = table.Random({
                "npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav",
                "npc/overwatch/cityvoice/f_anticivil1_5_spkr.wav",
                "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav",
                "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav",
                "npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav",
                "npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav",
                "npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav",
                "npc/overwatch/cityvoice/f_localunrest_spkr.wav",
            }),
            volume = 0.1,
            delay = math.random(0, 2.0),
        })
    end)

    timer.Create("ixCityBattleAmbience4", 60, 0, function()
        ix.event.PlaySoundGlobal({
            sound = "ambient/alarms/citadel_alert_loop2.wav",
            volume = 0.2,
        })
    end)
end

EVENT.onStop = function()
    ix.event.StopSoundGlobal("music/hl1_song9.mp3")
    ix.event.StopSoundGlobal("ambient/explosions/battle_loop1.wav")
    ix.event.StopSoundGlobal("ambient/explosions/battle_loop2.wav")
    ix.event.StopSoundGlobal("ambient/alarms/city_siren_loop2.wav")
    timer.Remove("ixCityBattleAmbience1")
    timer.Remove("ixCityBattleAmbience2")
    timer.Remove("ixCityBattleAmbience3")
    timer.Remove("ixCityBattleAmbience4")
end

EVENT_CITYBATTLE = EVENT.index