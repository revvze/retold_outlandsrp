local PANEL = {}

function PANEL:Init()
    local ply = LocalPlayer()

    self:SetSize(250, 150)
    self:SetTitle("IED Detonation Menu")
    self:Center()
    self:MakePopup()

    self.scroll = self:Add("ixTextEntry")
    self.scroll:SetValue("Select an IED Frequency.")
    self.scroll:Dock(TOP)
    self.scroll:SetFont("Font-Elements20")

    self.detonate = self:Add("ixMenuButton")
    self.detonate:Dock(BOTTOM)
    self.detonate:SetSize(self:GetWide(), 50)
    self.detonate:SetText("Detonate")
    self.detonate:SetFont("Font-Elements30")
    self.detonate:SetContentAlignment(5)
    self.detonate.DoClick = function(but, w, h)
        if ( self.scroll:GetValue() == "Select an IED Frequency." ) then
            ply:Notify("You haven't selected an IED Frequency!")
            return
        end

        net.Start("ixIEDStartClientside")
            net.WriteString(self.scroll:GetValue())
        net.SendToServer()

        self.scroll:SetValue("Select an IED Frequency.")

        self:Close()
    end
end

vgui.Register("ixIEDMenu", PANEL, "DFrame")