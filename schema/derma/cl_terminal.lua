local PANEL = {}

function PANEL:Init()
    local ply = LocalPlayer()

    self:SetSize(800, 500)
    self:Center()
    self:SetTitle("Combine Terminal")
    self:MakePopup()

    self.sheet = self:Add("DColumnSheet")
    self.sheet:Dock(FILL)

    self.combineCameras = self.sheet:Add("DScrollPanel")
    self.combineCameras:Dock(FILL)
    self.combineCameras.Paint = function(self, w, h)
    end

    for k, v in pairs(ents.FindByClass("npc_combine_camera")) do
        local button = self.combineCameras:Add("DButton")
        button:SetText(v:EntIndex())
        button:SetFont("Font-Elements18")
        button:SetTall(30)
        button:Dock(TOP)
        button.DoClick = function()
            net.Start("ixViewCamera")
                net.WriteEntity(v)
            net.SendToServer()

            net.Start("ixScenePVS")
                net.WriteVector(v:GetPos())
            net.SendToServer()
        end
    end

    self.cityCodes = self.sheet:Add("DScrollPanel")
    self.cityCodes:Dock(FILL)
    self.cityCodes.Paint = function(self, w, h)
    end

    for k, v in pairs(ix.cityCode.codes) do
        local button = self.cityCodes:Add("DButton")
        button:SetText(v.name)
        button:SetFont("Font-Elements18")
        button:SetTall(30)
        button:Dock(TOP)
        button.DoClick = function()
            net.Start("ixTerminalCodeSet")
                net.WriteString(k)
            net.SendToServer()
        end
    end

    self.sheet:AddSheet("Cameras", self.combineCameras)
    self.sheet:AddSheet("City Codes", self.cityCodes)
end

vgui.Register("ixCombineTerminal", PANEL, "DFrame")