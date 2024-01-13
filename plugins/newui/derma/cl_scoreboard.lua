local PANEL = {}
local playerData = {}

function PANEL:Init()
    local ply = LocalPlayer()
    self:Dock(FILL)

    local players = player.GetAll()
    table.sort(players, function(k, v) return k:Team() > v:Team() end)

    for k, v in pairs(players) do
        playerData[v] = {
            name = (ply:IsAdmin() and v:SteamName().." ("..v:Nick()..")") or v:SteamName(),
            team = team.GetName(v:Team()),
            ping = v:Ping(),
            steamname = v:SteamName(),
            teamColor = team.GetColor(v:Team()),
            steamid64 = v:SteamID64()
        }

        self.playerPanel = self:Add("ixMenuButton")
        self.playerPanel:Dock(TOP)
        self.playerPanel:SetText("")
        self.playerPanel:DockMargin(0, 0, 0, 0)
        self.playerPanel:SetTall(80)
        self.playerPanel.Paint = function(self, w, h)
            surface.SetDrawColor(ix.config.Get("color"))
            surface.DrawRect(0, 0, w, 5)
            surface.SetDrawColor(0, 0, 0, 150)
            surface.DrawRect(0, 0, w, 80)

            draw.DrawText(playerData[v].name, "Font-Elements40", 80, 5, color_white, TEXT_ALIGN_LEFT)
            draw.DrawText(playerData[v].team, "Font-Elements30", 80, 50, playerData[v].teamColor, TEXT_ALIGN_LEFT)
            draw.DrawText(playerData[v].ping.."ms", "Font-Elements30", w - 10, 50, color_white, TEXT_ALIGN_RIGHT)
        end
        self.playerPanel.DoClick = function()
            gui.OpenURL("http://steamcommunity.com/profiles/"..playerData[v].steamid64)
        end
        self.playerPanel.DoRightClick = function()
            local dmenu = DermaMenu()

            dmenu:AddOption("Copy SteamID", function()
                SetClipboardText(v:SteamID())
            end)

            dmenu:AddOption("Copy SteamID64", function()
                SetClipboardText(v:SteamID64())
            end)

            dmenu:AddOption("Copy Steam Name", function()
                SetClipboardText(v:SteamName())
            end)

            dmenu:Open(gui.MouseX(), gui.MouseY(), false)
        end

        local avt = self.playerPanel:Add("AvatarImage")
        avt:SetSize(65, 65)
        avt:SetPos(5, 10)
        avt:SetPlayer(v, 65)
    end
end


vgui.Register("ixScoreboard", PANEL, "DScrollPanel")