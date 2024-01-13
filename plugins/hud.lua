local PLUGIN = PLUGIN

PLUGIN.name = "Lite Network HUD"
PLUGIN.description = ""
PLUGIN.author = "Riggs.mackay"

PLUGIN.designs = {
    impulse = "impulse",
    litenetwork = "Lite Network 2021",
    apex = "Apex Roleplay",
    helix = "Base Helix",
    disabled = "None",
}

PLUGIN.crosshairGap = 5
PLUGIN.crosshairLength = PLUGIN.crosshairGap + 5

ix.lang.AddTable("english", {
    optHudDesign = "Hud Design",
    optHudIconColor = "Hud Icon Color",
    optCrosshairColor = "HUD Color",
})

ix.config.Add("hudEnabled", true, "Wether or not the global hud shoulw show.", nil, {category = PLUGIN.name})

ix.option.Add("crosshairColor", ix.type.color, Color(255, 255, 255), {
    category = PLUGIN.name
})

ix.option.Add("hudDesign", ix.type.array, "impulse", {
    category = PLUGIN.name,
	populate = function()
        local entries = {}

        for k, v in SortedPairs(PLUGIN.designs) do
            entries[k] = v
        end

        return entries
	end
})

ix.option.Add("hudIconColor", ix.type.bool, false, {
    category = PLUGIN.name,
})

if not ( CLIENT ) then return end

BAR_HEIGHT = 15

ix.bar.Remove("health")
ix.bar.Remove("armor")
ix.bar.Remove("stm")

do
	ix.bar.Add(function()
        local status = LocalPlayer():Health() or 100
        local var = math.max(LocalPlayer():Health() / LocalPlayer():GetMaxHealth(), 0)

		return var, tostring(status)
	end, Color(200, 0, 0), nil, "newHealth")

	ix.bar.Add(function()
        local status = LocalPlayer():GetCharacter():GetHunger() or 100
        local var = LocalPlayer():GetCharacter():GetHunger()

		return var, tostring(status)
	end, Color(205, 133, 63), nil, "newHunger")

	--[[ix.bar.Add(function()
        local status = LocalPlayer():GetCharacter():GetMoney() or 0
        local var = 100

		return var, tostring(status)
	end, Color(133, 227, 91), nil, "newMoney")]]

	ix.bar.Add(function()
        local status = LocalPlayer():GetXP() or 0
        local var = 100

		return var, tostring(status)
	end, Color(205, 190, 0), nil, "newXP")
end

function ix.util.ShouldDrawHud(ply, char)
    if not ( IsValid(ply) and ply:Alive() and char ) then return end
    if ( IsValid(ix.gui.characterMenu) and not ix.gui.characterMenu:IsClosing() ) then return end
    if ( ix.util.hudDisabled or ix.ops.cinematicIntro or not ix.config.Get("hudEnabled", true) ) then return end
    if ( Schema:IsViewingCamera() ) then return end

    return true
end

local lastBodygroups = {}
local function DrawPlayerIcon(ply, char, x, y, w, h)
    if not ( IsValid(PlayerIcon) ) then
        PlayerIcon = vgui.Create("ixSpawnIcon")
        PlayerIcon:SetModel(ply:GetModel(), ply:GetSkin())

        timer.Simple(0, function()
            if not ( IsValid(PlayerIcon) ) then
                return
            end

            local ent = PlayerIcon.Entity

            if not ( ent:GetModel() == ply:GetModel() ) then
                PlayerIcon:SetModel(ply:GetModel())
            end

            if ( IsValid(ent) ) then
                for k, v in pairs(ply:GetBodyGroups()) do
                    ent:SetBodygroup(v.id, ply:GetBodygroup(v.id))
                end
            end
        end)
    else
        timer.Simple(0, function()
            if not ( IsValid(PlayerIcon) ) then
                return
            end

            local ent = PlayerIcon.Entity

            if not ( ent:GetModel() == ply:GetModel() ) then
                PlayerIcon:SetModel(ply:GetModel())
            end

            if ( ix.util.ShouldDrawHud(ply, char) ) then
                PlayerIcon:SetPos(x, y)
                PlayerIcon:SetSize(w, h)
            else
                PlayerIcon:SetPos(0, 0)
                PlayerIcon:SetSize(0, 0)
            end

            if ( IsValid(ent) ) then
                for k, v in pairs(ply:GetBodyGroups()) do
                    ent:SetBodygroup(v.id, ply:GetBodygroup(v.id))
                    ent:SetSkin(ply:GetSkin())
                end
            end
        end)
    end
end

local function DrawCrosshair(x, y)
	surface.SetDrawColor(ix.option.Get("crosshairColor", color_white))

	surface.DrawLine(x - PLUGIN.crosshairLength, y, x - PLUGIN.crosshairGap, y)
	surface.DrawLine(x + PLUGIN.crosshairLength, y, x + PLUGIN.crosshairGap, y)
	surface.DrawLine(x, y - PLUGIN.crosshairLength, x, y - PLUGIN.crosshairGap)
	surface.DrawLine(x, y + PLUGIN.crosshairLength, x, y + PLUGIN.crosshairGap)
end

function PLUGIN:HUDPaint()
    local ply, char = LocalPlayer(), LocalPlayer():GetCharacter()
    local curWep = ply:GetActiveWeapon()

    if not ( ix.util.ShouldDrawHud(ply, char) ) then
        DrawPlayerIcon(ply, char, 0, 0, 0, 0)
        return
    end

    local showIconColors = ix.option.Get("hudIconColor", false)

    local healthColor = color_white
    local hungerColor = color_white
    --local moneyColor = color_white
    local xpColor = color_white

    if ( showIconColors == true ) then
        healthColor = Color(200, 0, 0, 255)
        hungerColor = Color(205, 133, 63, 255)
        --moneyColor = Color(133, 227, 91, 255)
        xpColor = Color(205, 190, 0, 255)
    end

    -- huds
    if ( ix.option.Get("hudDesign") == "impulse" ) then
        ix.util.DrawBlurAt(5, ScrH() - 205, 360, 200)
        draw.RoundedBox(0, 5, ScrH() - 205, 360, 200, Color(30, 30, 30, 200))

        draw.DrawText(ply:Nick(), "Font-Elements30", 15, ScrH() - 200, color_white, TEXT_ALIGN_LEFT)
        draw.DrawText(team.GetName(ply:Team()), "Font-Elements30", 15, ScrH() - 170, team.GetColor(ply:Team()), TEXT_ALIGN_LEFT)

        draw.DrawText("Health: "..ply:Health(), "Font-Elements20", 140, ScrH() - 115, color_white, TEXT_ALIGN_LEFT)
        draw.DrawText("Hunger: "..char:GetHunger(), "Font-Elements20", 140, ScrH() - 95, color_white, TEXT_ALIGN_LEFT)

        draw.DrawText(ply:GetXP().."XP", "Font-Elements20", 40, ScrH() - 30, color_white, TEXT_ALIGN_LEFT)

        ix.util.DrawTexture("litenetwork/icons/health.png", healthColor, 115, ScrH() - 115, 20, 20)
        ix.util.DrawTexture("litenetwork/icons/hunger.png", hungerColor, 115, ScrH() - 95, 20, 20)
        ix.util.DrawTexture("litenetwork/icons/xp.png", xpColor, 15, ScrH() - 30, 20, 20)

        DrawPlayerIcon(ply, char, 25, ScrH() - 135, 80, 80)

        local ccode = ix.cityCode.Get(ix.cityCode.GetCurrent()).name or "Unknown"
        local ccodeclr = ix.cityCode.Get(ix.cityCode.GetCurrent()).color or color_white

        if not ( ccode == "Civil" ) then
            draw.DrawText(ccode, "Font-Elements20", ScrW() / 2, ScrH() - 60, ccodeclr, TEXT_ALIGN_CENTER)
        end
    elseif ( ix.option.Get("hudDesign") == "litenetwork" ) then
        ix.util.DrawBlurAt(10, ScrH() - 210, 365, 200)
    
        surface.SetDrawColor(ColorAlpha(team.GetColor(ply:Team()), 25))
        surface.DrawRect(10, ScrH() - 210, 365, 200)
    
        surface.SetDrawColor(Color(30, 30, 30, 100))
        surface.DrawRect(10, ScrH() - 210, 365, 200)

        draw.DrawText(team.GetName(ply:Team()), "Font-Elements32-Light", 20, ScrH() - 200, team.GetColor(ply:Team()), TEXT_ALIGN_LEFT)
        draw.DrawText(ply:Nick(), "Font-Elements32-Light", 20, ScrH() - 50, color_white, TEXT_ALIGN_LEFT)
        draw.DrawText("Health: "..ply:Health(), "Font-Elements24-Light", 160, ScrH() - 210 + 70, color_white, TEXT_ALIGN_LEFT)
        draw.DrawText("Hunger: "..char:GetHunger(), "Font-Elements24-Light", 160, ScrH() - 210 + 90, color_white, TEXT_ALIGN_LEFT)
        draw.DrawText("XP: "..ply:GetXP(), "Font-Elements24-Light", 160, ScrH() - 210 + 110, color_white, TEXT_ALIGN_LEFT)

        ix.util.DrawTexture("litenetwork/icons/health.png", healthColor, 130, ScrH() - 210 + 70, 23, 23)
        ix.util.DrawTexture("litenetwork/icons/hunger.png", hungerColor, 130, ScrH() - 210 + 90, 23, 23)
        ix.util.DrawTexture("litenetwork/icons/star.png", xpColor, 130, ScrH() - 210 + 110, 23, 23)

        DrawPlayerIcon(ply, char, 20, ScrH() - 210 + 50, 100, 100)

        local ccode = ix.cityCode.Get(ix.cityCode.GetCurrent()).name or "Unknown"
        local ccodeclr = ix.cityCode.Get(ix.cityCode.GetCurrent()).color or color_white

        if not ( ccode == "Civil" ) then
            draw.DrawText(ccode, "Font-Elements24-Light", ScrW() / 2, ScrH() - 60, ccodeclr, TEXT_ALIGN_CENTER)
        end
    elseif ( ix.option.Get("hudDesign") == "apex" ) then
        local HUDWidth, HUDHeight = 260, 115
        local RelativeX, RelativeY = 0, ScrH()

        ix.util.DrawBlurAt(10, ScrH() - HUDHeight - 65, HUDWidth, 30, 3)
        ix.util.DrawBlurAt(10, ScrH() - HUDHeight - 34, HUDWidth, 110, 3)
        ix.util.DrawBlurAt(10, ScrH() - HUDHeight + 77, HUDWidth, 30, 3)

        draw.RoundedBox(0, 10, ScrH() - HUDHeight - 65, HUDWidth, 30, Color(0, 0, 0, 230))
        draw.RoundedBox(0, 10, ScrH() - HUDHeight - 34, HUDWidth, 110, Color(0, 0, 0, 230))
        draw.RoundedBox(0, 10, ScrH() - HUDHeight + 77, HUDWidth, 30, Color(0, 0, 0, 230))

        draw.DrawText("Name: "..ply:Nick(), "Font-Elements16", RelativeX + 40, RelativeY - HUDHeight - 57, color_white, TEXT_ALIGN_LEFT)

        draw.DrawText("Health: "..ply:Health(), "Font-Elements16", RelativeX + 125, ScrH() - 120, color_white, TEXT_ALIGN_LEFT)
        draw.DrawText("XP: "..ply:GetXP(), "Font-Elements16", RelativeX + 125, ScrH() - 100, color_white, TEXT_ALIGN_LEFT)
        draw.DrawText("Food: "..char:GetHunger(), "Font-Elements16", RelativeX + 125, ScrH() - 80, color_white, TEXT_ALIGN_LEFT)

        draw.DrawText("Job: "..team.GetName(ply:Team()), "Font-Elements16", RelativeX + 40, RelativeY - HUDHeight + 85, color_white, TEXT_ALIGN_LEFT)

        ix.util.DrawTexture("icon16/user.png", color_white, 18, ScrH() - 173, 16, 16)

        ix.util.DrawTexture("icon16/heart.png", color_white, RelativeX + 100, ScrH() - 120, 16, 16)
        ix.util.DrawTexture("icon16/star.png", color_white, RelativeX + 100, ScrH() - 100, 16, 16)
        ix.util.DrawTexture("icon16/cake.png", color_white, RelativeX + 100, ScrH() - 80, 16, 16)

        ix.util.DrawTexture("icon16/group.png", color_white, 18, ScrH() - 31, 16, 16)

        DrawPlayerIcon(ply, char, 25, ScrH() - 125, 60, 60)

        local ccode = ix.cityCode.Get(ix.cityCode.GetCurrent()).name or "Unknown"
        local ccodeclr = ix.cityCode.Get(ix.cityCode.GetCurrent()).color or color_white

        if not ( ccode == "Civil" ) then
            draw.DrawText(ccode, "Font-Elements16", ScrW() / 2, ScrH() - 60, ccodeclr, TEXT_ALIGN_CENTER)
        end
    else
        DrawPlayerIcon(ply, char, 0, 0, 0, 0)
    end

    -- crosshair
    local x, y
	if not curWep or not curWep.ShouldDrawCrosshair or (curWep.ShouldDrawCrosshair and curWep.ShouldDrawCrosshair(curWep) != false) then
		if ( ix.option.Get("thirdpersonEnabled") ) then
			local p = ply:GetEyeTrace().HitPos:ToScreen()
			x, y = p.x, p.y
		else
			x, y = ScrW() / 2, ScrH() / 2
		end

		DrawCrosshair(x, y)
	end

    -- developer hud
    --[[ix.util.DrawTexture("litenetwork/text.png", color_white, ScrW() / 2 - 200, ScrH() - 175, 400, 100)
    draw.DrawText("Everything you see may be subject to change.", "Font-Elements28-Shadow", ScrW() / 2, ScrH() - 70, color_white, TEXT_ALIGN_CENTER)]]

    draw.DrawText(GAMEMODE.Name.." "..GAMEMODE.Version, "Font-Elements18-Shadow", ScrW() -75, 20, ColorAlpha(color_white, 75), TEXT_ALIGN_CENTER)
    draw.DrawText(Schema.build.." Release", "Font-Elements18-Shadow", ScrW() -75, 40, ColorAlpha(color_white, 75), TEXT_ALIGN_CENTER)
    draw.DrawText("Version "..Schema.currentVersion, "Font-Elements18-Shadow", ScrW() -75, 60, ColorAlpha(color_white, 75), TEXT_ALIGN_CENTER)
end

function PLUGIN:ShouldHideBars()
    if not ( ix.option.Get("hudDesign") == "helix" ) then
        return true
    end
end

function PLUGIN:ShouldDrawCrosshair()
    return false
end