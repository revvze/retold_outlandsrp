--[[---------------------------------------------------------------------------
    ** License: https://creativecommons.org/licenses/by-nc-nd/4.0/

    ** Copryright 2022 Riggs.mackay
    ** This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 4.0 Unported License.
---------------------------------------------------------------------------]]--

local PLUGIN = PLUGIN

local colors = {
    ["white"] = Color(200, 200, 200),
    ["blue"] = Color(100, 160, 250),
    ["yellow"] = Color(200, 200, 0),
    ["red"] = Color(250, 50, 50),
    ["orange"] = Color(250, 100, 0),
    ["green"] = Color(100, 250, 100),
}

local direction = {
    [0] = "N",
    [45] = "NE",
    [90] = "E",
    [135] = "SE",
    [180] = "S",
    [225] = "SW",
    [270] = "W",
    [315] = "NW",
    [360] = "N",
}

ix.display = ix.display or {}
ix.display.messages = ix.display.messages or {}
ix.display.messageID = ix.display.messageID or 0
ix.display.randomMessages = {
    "Updating biosignal co-ordinates...",
    "Parsing heads-up display and data arrays...",
    "Working deconfliction with other ground assets...",
    "Transmitting physical transition vector...",
    "Sending commdata to dispatch...",
    "Sensoring proximity...",
    "Regaining equalization modules...",
    "Encoding network messages...",
    "Idle connection...",
    "Pinging loopback...",
    "Analyzing Overwatch protocols...",
    "Filtering incoming messages...",
    "Synchronizing database records...",
    "Appending all data to black box...",
    "Establishing DC link...",
    "Checking exodus protocol status...",
    "Updating data connections...",
    "Looking up main protocols...",
    "Updating Translation Matrix...",
    "Establishing connection with overwatch...",
    "Opening up aura scanners...",
    "Establishing Clockwork protocols...",
    "Looking up active fireteam control centers...",
    "Command uplink established...",
    "Inititaing self-maintenance scan...",
    "Scanning for active biosignals...",
    "Updating cid registry link...",
    "Establishing variables for connection hooks...",
    "Creating socket for incoming connection...",
    "Updating squad uplink interface...",
    "Validating memory replacement integrity...",
    "Visual uplink status code: GREEN...",
    "Refreshing primary database connections...",
    "Creating ID's for internal structs...",
    "Dumping cache data and renewing from external memory...",
    "Updating squad statuses...",
    "Looking up front end codebase changes...",
    "Software status nominal...",
    "Querying database for new recruits... RESPONSE: OK",
    "Establishing connection to long term maintenance procedures...",
    "Looking up CP-5 Main...",
    "Updating railroad activity monitors...",
    "Caching new response protocols...",
    "Calculating the duration of patrol...",
    "Caching internal watch protocols...",
}

function ix.display.AddDisplay(message, color, soundBool, soundString)
    local ply = LocalPlayer()

    if not ( ply:GetCharacter() ) then return end
    if not ( ply:IsCombine() or ply:IsDispatch() ) then return end

    ix.display.messageID = ix.display.messageID + 1
    message = "<:: "..string.upper(message)

    local data = {
        message = "",
        bgCol = color or colors["white"],
    }

    table.insert(ix.display.messages, data)

    if ( #ix.display.messages > 4 ) then
        table.remove(ix.display.messages, 1)
    end

    local i = 1
    local id = "ix.display.messages.ID."..ix.display.messageID

    timer.Create(id, 0.01, #message + 1, function()
        data.message = string.sub(message, 1, i + 2)
        i = i + 3

        if ( data.message == #message ) then
            timer.Remove(id)
        end
    end)

    if ( soundBool == true ) then
        ply:EmitSound(soundString or "npc/roller/code2.wav")
    end
end

local nextMessage = 0
local lastMessage = ""
function PLUGIN:Think()
    local ply, char = LocalPlayer(), LocalPlayer():GetCharacter()
    if not ( IsValid(ply) and ply:Alive() and char ) then return end

    if ( IsValid(ix.display.menu) or IsValid(ix.display.characterMenu) ) then return end

    if ( ( nextMessage or 0 ) < CurTime() ) then
        local message = ix.display.randomMessages[math.random(1, #ix.display.randomMessages)]

        if not ( message == ( lastMessage or "" ) ) then
            ix.display.AddDisplay(message, nil, false)
            lastMessage = message
        end

        nextMessage = CurTime() + 10
    end
end

local scanLineData = {}
local unitData = {}
local oaskID = Schema:ZeroNumber(math.random(1,99999), 5)
local staticDelay = 0
local deathValid = false

local otasquadcols = {
    ["SUNDOWN"] = Color(255, 0, 0),
    ["MONSOON"] = Color(0, 140, 255),
    ["SWORD"] = Color(255, 255, 255),
    ["HUNTER"] = Color(0, 255, 0)
}
function PLUGIN:HUDPaint()
    local ply, char = LocalPlayer(), LocalPlayer():GetCharacter()
    
    if not ( ix.util.ShouldDrawHud(ply, char) ) then return end
    if not ( ply:IsCombine() or ply:IsDispatch() ) then return end

    -- Death Screen
    if not ( ply:Alive() ) then
        if not ( deathValid == true ) then
            surface.PlaySound("ambient/energy/whiteflash.wav")
            surface.PlaySound("ambient/energy/powerdown2.wav")
            deathValid = true
        end
        draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), color_black)
        draw.SimpleText("SIGNAL LOST", "CombineHudFontMedium", ScrW() / 2, ScrH() / 2 + math.random(-1.0,1.0), colors["red"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("UNIT "..ply:Nick().." DOWN", "CombineHudFontMedium", ScrW() / 2, ScrH() / 2 + 40 + math.random(-1.0,1.0), colors["red"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        if ( ( staticDelay or 0 ) < CurTime() ) then
            surface.PlaySound("ambient/levels/prison/radio_random"..math.random(1,15)..".wav")
            staticDelay = CurTime() + math.random(1.0,2.0)
        end
        return
    else
        deathValid = false
    end

    -- Compass
    if ( ix.option.Get("compass", true) ) then
        local ang = ply:EyeAngles()
        local width = ScrW() * 0.25
        local m = 1
        local spacing = (width * m) / 360
        local lines = width / spacing
        local rang = math.Round(ang.y)
        local comX = ScrW() / 2

        for i = (rang - (lines / 2)) % 360, ((rang - (lines / 2)) % 360) + lines do
            local x = (comX + (width / 2)) - ((i - ang.y - 180) % 360) * spacing

            if i % 30 == 0 and i > 0 then
                local text = direction[360 - (i % 360)] and direction[360 - (i % 360)] or 360 - (i % 360)

                draw.DrawText(text, "CombineHudFontMedium", x, 5, colors["white"], TEXT_ALIGN_CENTER)
            end
        end
    end

    -- Top Left Corner
    for i = 1, #ix.display.messages do
        local msgData = ix.display.messages[i]
        msgData.y = msgData.y or 0

        surface.SetFont("CombineHudFontMedium")
        local w, h = surface.GetTextSize(msgData.message)

        x, y = 10, ((i - 1) * h) + 5

        msgData.y = Lerp(0.05, msgData.y, y)

        draw.DrawText(msgData.message, "CombineHudFontMedium", x, msgData.y, msgData.bgCol or color_white)
    end

    local ccode = ix.cityCode.Get(ix.cityCode.GetCurrent()).name or "Unknown"
    local ccodeclr = ix.cityCode.Get(ix.cityCode.GetCurrent()).color or color_white
    local sstatus = ix.socioStatus.Get(ix.socioStatus.GetCurrent()).name or "Unknown"
    local sstatusclr = ix.socioStatus.Get(ix.socioStatus.GetCurrent()).color or color_white

    draw.DrawText("<::", "CombineHudFontMedium", 10, 200, colors["white"], TEXT_ALIGN_LEFT)
    draw.DrawText("<::", "CombineHudFontMedium", 10, 220, colors["white"], TEXT_ALIGN_LEFT)

    draw.DrawText(ccode, "CombineHudFontMedium", 45, 200, ccodeclr, TEXT_ALIGN_LEFT)
    draw.DrawText(sstatus, "CombineHudFontMedium", 45, 220, sstatusclr, TEXT_ALIGN_LEFT)

    local id = LocalPlayer():GetArea()
    if ( id ) then
        local area = ix.area.stored[id]
        local aclr = area.properties.color or color_white
        
        draw.DrawText("<::", "CombineHudFontMedium", 10, 180, colors["white"], TEXT_ALIGN_LEFT)
        draw.DrawText(id, "CombineHudFontMedium", 45, 180, aclr, TEXT_ALIGN_LEFT)
    end

    -- Top Right Corner
    if ( ix.option.Get("unitStatus", true) ) then
        local unitSpacing = 0
        for k, v in pairs(player.GetAll()) do
            if ( v:IsValid() and char and v:IsCombine() ) then
                if ( LocalPlayer():Team() == v:Team() ) then
                    local nick = v:Nick()
                    nick = string.Replace(nick, "CP:", "")
                    nick = string.Replace(nick, "OW:", "")

                    unitData[v] = {
                        name = nick,
                        steamid = v:SteamID64(),
                        color = colors["white"],
                    }

                    draw.DrawText("::>", "CombineHudFontMedium", ScrW() - 10, 5 + unitSpacing, colors["white"], TEXT_ALIGN_RIGHT)
                    if not ( v:Alive() ) then
                        draw.DrawText("K.I.A", "CombineHudFontMedium", ScrW() - 40, 5 + unitSpacing, colors["red"], TEXT_ALIGN_RIGHT)
                    else
                        draw.DrawText("ACTIVE", "CombineHudFontMedium", ScrW() - 40, 5 + unitSpacing, colors["green"], TEXT_ALIGN_RIGHT)
                    end

                    draw.DrawText(unitData[v].name.." | ", "CombineHudFontMedium", ScrW() - 100, 5 + unitSpacing, colors["white"], TEXT_ALIGN_RIGHT)
                    unitSpacing = unitSpacing + 20
                end
            end
        end
    end

    -- Bottom Left Corner
    if ( ix.option.Get("unitInformation", true) ) then
        draw.DrawText("<:: ", "CombineHudFontMedium", 10, 240, colors["white"], TEXT_ALIGN_LEFT)
        draw.DrawText(ply:Nick(), "CombineHudFontMedium", 45, 240, colors["white"], TEXT_ALIGN_LEFT)

        draw.DrawText("<:: ", "CombineHudFontMedium", 10, 260, colors["white"], TEXT_ALIGN_LEFT)
        draw.DrawText(math.Clamp(ply:Health(), 0, 999).." VITALS", "CombineHudFontMedium", 45, 260, colors["red"], TEXT_ALIGN_LEFT)

        draw.DrawText("<:: ", "CombineHudFontMedium", 10, 280, colors["white"], TEXT_ALIGN_LEFT)
        draw.DrawText(math.Clamp(ply:Armor(), 0, 999).." BODYPACK", "CombineHudFontMedium", 45, 280, colors["blue"], TEXT_ALIGN_LEFT)

        if not ( ply:Team() == FACTION_OTA ) then
            draw.DrawText("<:: ", "CombineHudFontMedium", 10, 300, colors["white"], TEXT_ALIGN_LEFT)
            draw.DrawText(math.Clamp(char:GetHunger(), 0, 100).." NUTRITION", "CombineHudFontMedium", 45, 300, colors["green"], TEXT_ALIGN_LEFT)
        end
    end
end