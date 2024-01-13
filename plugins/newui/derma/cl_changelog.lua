
local PANEL = {}

-- changelogs panel

AccessorFunc(PANEL, "animationTime", "AnimationTime", FORCE_NUMBER)
AccessorFunc(PANEL, "backgroundFraction", "BackgroundFraction", FORCE_NUMBER)

function PANEL:Init()
    local parent = self:GetParent()
    local padding = self:GetPadding()
    local halfWidth = parent:GetWide() * 0.5 - (padding * 2)
    local halfHeight = parent:GetTall() * 0.5 - (padding * 2)

    self.animationTime = 1
    self.backgroundFraction = 1

    -- main panel
    self.panel = self:AddSubpanel("main")
    self.panel:SetTitle("changelogs")
    self.panel.OnSetActive = function()
        self:CreateAnimation(self.animationTime, {
            index = 2,
            target = {backgroundFraction = 1},
            easing = "outQuint",
        })
    end

    -- button list
    local controlList = self.panel:Add("Panel")
    controlList:Dock(LEFT)
    controlList:SetSize(halfWidth, halfHeight)

    local back = controlList:Add("ixMenuButton")
    back:Dock(BOTTOM)
    back:SetText("return")
    back:SizeToContents()
    back.DoClick = function()
        self:SlideDown()
        parent.mainPanel:Undim()
    end

    local scrollPanel = self.panel:Add("DScrollPanel")
    scrollPanel:Dock(FILL)

    for k, v in pairs(Schema.changelogs) do
        local changelogTitle = scrollPanel:Add("DLabel")
        changelogTitle:SetText(k)
        changelogTitle:SetFont("Font-Elements60-Shadow")
        changelogTitle:SizeToContents()
        changelogTitle:Dock(TOP)

        for _, i in pairs(v) do
            local changelogText = scrollPanel:Add("DLabel")
            changelogText:SetText("        "..i)
            changelogText:SetFont("Font-Elements30-Light")
            changelogText:SetContentAlignment(1)
            changelogText:SizeToContents()
            changelogText:Dock(TOP)
        end
    end
end

function PANEL:OnSlideUp()
    self.bActive = true
end

function PANEL:OnSlideDown()
    self.bActive = false
end

local gradient = surface.GetTextureID("vgui/gradient-d")
function PANEL:Paint(width, height)
	surface.SetDrawColor(20, 20, 20, 255)
	surface.DrawRect(0, 0, width, height)

	surface.SetTexture(gradient)
	surface.SetDrawColor(ColorAlpha(ix.config.Get("color"), 10))
	surface.DrawTexturedRect(0, ScrH() - height, width, height)

	if (!ix.option.Get("cheapBlur", false)) then
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawTexturedRect(0, 0, width, height)
		ix.util.DrawBlur(self, Lerp((self.currentAlpha - 200) / 200, 0, 10))
	end
end

vgui.Register("ixCharMenuChangelogs", PANEL, "ixCharMenuPanel") 