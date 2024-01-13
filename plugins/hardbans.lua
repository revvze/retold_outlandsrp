local PLUGIN = PLUGIN

PLUGIN.name = "Player Hard Bans"
PLUGIN.description = "Hard Bans players from the server."
PLUGIN.author = "Riggs.mackay"

PLUGIN.hardbans = {
    -- Unknown
    "STEAM_0:0:152575886",      -- mattnmad
    "STEAM_0:0:76866999",       -- [FN] Eagle
    "STEAM_0:0:234298798",      -- bob dobbs
    "STEAM_0:0:80074268",       -- Keegar123 The Fiery One
    "STEAM_0:0:200886160",      -- Hardway
    "STEAM_0:0:191441547",      -- Gado
    "STEAM_0:1:108198228",      -- Candyexin
    "STEAM_0:1:100301670",      -- Phosgene
    "STEAM_0:0:537995060",      -- Simulation
    "STEAM_0:0:503985107",      -- S-P
    "STEAM_0:0:132187220",      -- TheUsualClassic/SyphO
    "STEAM_0:0:99198023",       -- altillicious/SpeedeWand
    "STEAM_0:1:92733650",       -- Nick
    "STEAM_0:1:95921723",       -- vin
    "STEAM_0:1:502447260",      -- indari
    "STEAM_0:0:455782278",      -- wackly
    --"STEAM_0:1:191957510",      -- Gremanik (im gonna regret unbanning him)
    "STEAM_0:1:197823805",      -- Ghost of Texas
    "STEAM_0:1:459989763",      -- rimmy
    "STEAM_0:0:617208442",      -- (blue)
    "STEAM_0:1:197470921",      -- Soritus
    "STEAM_0:0:198636477",      -- Klaus Schneider
    
    -- Sneedwaffen
    "STEAM_0:0:156780497",      -- Puggo
    "STEAM_0:0:457706317",      -- Dimon
    "STEAM_0:1:599395506",      -- Dimon (Alt)
    "STEAM_0:1:100458617",      -- The_Guardian
    "STEAM_0:0:141559090",      -- Bread
    "STEAM_0:1:37576216",       -- Jera
    "STEAM_0:0:535100462",      -- valyy
    "STEAM_0:1:104758607",      -- valyy (First Alt)
    "STEAM_0:0:675708948",      -- valyy (Second Alt)
    "STEAM_0:0:57815069",       -- Satou
    "STEAM_0:0:81926067",       -- Abiy Ahmad Ali 5
    "STEAM_0:0:420930237",      -- Flames
    "STEAM_0:1:197868698",      -- Degenerate
    "STEAM_0:0:222696076",      -- Blitzo
    "STEAM_0:1:196566827",      -- Criminal
    "STEAM_0:1:526501347",      -- Purplexde
    "STEAM_0:0:143804480",      -- highyeenah
    "STEAM_0:1:427293255",      -- Banshee
    "STEAM_0:0:119456821",      -- Bennyfridge
    "STEAM_0:0:213189960",      -- Central Intelligence Agency (lite network 2020 backdoorer)
    "STEAM_0:1:124421662",      -- Coach
    "STEAM_0:0:21778026",       -- Dr Coomer
    "STEAM_0:1:177728214",      -- ENIGMA
    "STEAM_0:1:103669717",      -- Oil
    "STEAM_0:0:63306763",       -- Oil (Alt)
    "STEAM_0:0:104209528",      -- PostTac
    "STEAM_0:0:232361329",      -- Xhorinhas
    "STEAM_0:0:100835231",      -- ping man
    "STEAM_0:0:176358061",      -- Gritz
    "STEAM_0:0:84061843",       -- Josh
    "STEAM_0:0:447565677",      -- Yes (Clientside Lua Grabber)
    "STEAM_0:1:62272239",       -- Didde
    "STEAM_0:1:224501183",      -- ¿¿¿
    "STEAM_0:0:548044167",      -- Ivan04
    "STEAM_0:0:569498588",      -- Emperor Trollface
    "STEAM_0:1:623044600",      -- Blackface Steve
    "STEAM_0:1:629121405",      -- Gangweed
    "STEAM_0:1:166201392",      -- CZ
    "STEAM_0:1:185133649",      -- Shadow
    "STEAM_0:1:98525620",       -- v44su
    "STEAM_0:0:87998391",       -- DLEtna258
    "STEAM_0:1:197341404",      -- Alfreeed
    "STEAM_0:1:240356511",      -- Qas / Qaz
    "STEAM_0:0:23501876",       -- Harland
    "STEAM_0:1:220466457",      -- Diablo
    "STEAM_0:0:108381801",      -- Hannibal
    "STEAM_0:0:46973366",       -- Vivini
    "STEAM_0:1:75893677",       -- BoxsAndSocks
    "STEAM_0:1:168580379",      -- Kirtsteep
    "STEAM_0:1:35521054",       -- Winter
    "STEAM_0:0:447065614",      -- Galaxy Man
    "STEAM_0:1:55189590",       -- Benkku
    "STEAM_0:0:224154486",      -- bornaorange
    "STEAM_0:1:168213231",      -- bathdoge
    "STEAM_0:1:63837056",       -- Quantum
    "STEAM_0:1:55664955",       -- WinComp
    "STEAM_0:1:69735327",       -- Whiplash
}

file.CreateDir("helix/"..Schema.folder.."/hardbans")

local bans = {}
for k, v in ipairs(PLUGIN.hardbans) do
    bans[v] = true
end

if ( SERVER ) then
    function PLUGIN:PlayerAuthed(ply, steamID)
        local realId = util.SteamIDFrom64(ply:OwnerSteamID64())

        if not ( bans[steamID] and bans[realId] ) then
            return
        end

        ply:Kick("You are hard-banned from Retold: Half-Life 2 Roleplay.\nYou are unable to appeal your ban in any form.")
        print(ply:SteamName().." ("..steamID..") tried to join, but is hard-banned IP: "..ply:IPAddress())
        local logTable = {
            steamName = ply:SteamName(),
            ip = ply:IPAddress(),
            steamid = steamID,
            steamid64 = ply:SteamID64(),
        }
        file.Write("helix/"..Schema.folder.."/hardbans/"..ply:SteamID64()..".txt", util.TableToJSON(logTable, true))

        for k, v in ipairs(player.GetAll()) do
            if not ( v:IsAdmin() ) then
                continue
            end

            v:ChatNotify(ply:SteamName().." tried to join the server but is hard-banned. Check RCON for details.") -- RCON MEANS REMOTE CONSOLE.
        end
    end
end
