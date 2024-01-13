local PANEL = {}

function PANEL:Init()
    self:SetSize(ScrW() / 2, ScrH() / 1.5)
    self:Center()
    self:SetTitle("ops event manager")
    self:MakePopup()

    self.sheet = vgui.Create("DColumnSheet", self)
    self.sheet:Dock(FILL)

    self.seqEdit = vgui.Create("DPanel", self.sheet)
    self.seqEdit:Dock(FILL)

    self.sheet:AddSheet("Seq. Editor", self.seqEdit, "icon16/arrow_branch.png")

    self.seqEdit.menu = vgui.Create("DMenuBar", self.seqEdit)
    self.seqEdit.menu:Dock(TOP)

    local panel = self

    local menuFile = self.seqEdit.menu:AddMenu("File")
    menuFile:AddOption("New sequence", function()
        Derma_StringRequest("ix ops",
            "Enter sequence name:",
            nil, 
            function(text)
                ix.ops.eventManager.sequences[text] = {
                    Name = text, 
                    FileName = text,
                    Events = {}, 
                    VersionHash = ix.ops.eventManager.GetVersionHash()
                }
                self:ReloadSequences()
            end, nil, "Create", "Cancel")
    end)
    menuFile:AddOption("Load sequence", function()
        local fb = vgui.Create("DFrame")
        fb:SetSize(600, 400)
        fb:SetSizable(true)
        fb:Center()
        fb:MakePopup()
        fb:SetTitle("ops event manager load sequence")

        local browser = vgui.Create("DFileBrowser", fb)
        browser:SetTall(380)
        browser:Dock(FILL)
        browser:SetPath("DATA")
        browser:SetBaseFolder("helix/"..Schema.folder.."/ops/eventmanager")
        browser:SetOpen(true)
        browser:SetCurrentFolder("helix/"..Schema.folder.."/ops/eventmanager")
        browser:SetName("eventmanager")
        browser:SetFileTypes("*.json")

        function browser:OnSelect(path)
            local result, msg = ix.ops.eventManager.SequenceLoad(path)

            if not result then
                surface.PlaySound("common/bugreporter_failed.wav")
                LocalPlayer():Notify(msg..".")
                return
            end

            panel:ReloadSequences()

            fb:Remove()
        end
    end)
    menuFile:AddOption("Save all", function()
        for v,k in pairs(ix.ops.eventManager.sequences) do
            ix.ops.eventManager.SequenceSave(v)
        end

        LocalPlayer():Notify("All sequences saved.")
    end)
    menuFile:AddOption("Close all", function()
        ix.ops.eventManager.sequences = {}
        panel:ReloadSequences()

        LocalPlayer():Notify("All sequences closed.")
    end)

    self:ReloadSequences()

    self.seqPlayer = vgui.Create("DPanel", self.sheet)
    self.seqPlayer:Dock(FILL)
    self.sheet:AddSheet("Seq. Player", self.seqPlayer, "icon16/control_play_blue.png")
end

function PANEL:ReloadSequences()
    if self.seqScroll and IsValid(self.seqScroll) then
        self.seqScroll:Remove()
    end

    self.seqScroll = vgui.Create("DScrollPanel", self.seqEdit)
    self.seqScroll:Dock(FILL)

    self.Sequences = {}

    for v,k in pairs(ix.ops.eventManager.sequences) do
        local seqPanel = self.seqScroll:Add("ixSequenceCard")
        seqPanel:SetSequence(v, k)
        seqPanel:DockMargin(0, 0, 0, 3)
        seqPanel:Dock(TOP)
        seqPanel.Dad = self
    end
end

function PANEL:SetupPlayer(sequences)
    local scroll = vgui.Create("DScrollPanel", self.seqPlayer)
    scroll:Dock(FILL)

    for v,k in pairs(sequences) do
        local sequence = scroll:Add("DPanel")
        sequence:SetTall(35)
        sequence:Dock(TOP)
        sequence:DockMargin(0, 0, 0, 3)

        local normal = Color(90, 90, 90, 255)
        function sequence:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, normal)

            if ix.ops.eventManager.GetSequence() and ix.ops.eventManager.GetSequence() == k then
                draw.SimpleText("LIVE", "ChatFont", 6, 16, Color(255, 0, 0))
            end
        end

        local name = vgui.Create("DLabel", sequence)
        name:SetText(k)
        name:SizeToContents()
        name:SetPos(5, 5)

        local play = vgui.Create("DButton", sequence)
        play:SetPos(500, 0)
        play:SetSize(150, 35)
        play:SetText("PLAY")

        function play:Think()
            if ix.ops.eventManager.GetSequence() and ix.ops.eventManager.GetSequence() == k then
                self:SetDisabled(true)
            else
                self:SetDisabled(false)
            end
        end

        function play:DoClick()
            net.Start("ixOpsEMPlaySequence")
            net.WriteString(k)
            net.SendToServer()
        end

        local stop = vgui.Create("DButton", sequence)
        stop:SetPos(350, 0)
        stop:SetSize(150, 35)
        stop:SetText("STOP")

        function stop:Think()
            if ix.ops.eventManager.GetSequence() and ix.ops.eventManager.GetSequence() == k then
                self:SetDisabled(false)
            else
                self:SetDisabled(true)
            end
        end

        function stop:DoClick()
            net.Start("ixOpsEMStopSequence")
            net.WriteString(k)
            net.SendToServer()
        end
    end
end

vgui.Register("ixEventManager", PANEL, "DFrame")