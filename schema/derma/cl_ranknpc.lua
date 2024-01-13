local PANEL = {}

function PANEL:Init()
    local ply = LocalPlayer()

    self:SetSize(800, 500)
    self:Center()
    self:SetTitle(team.GetName(ply:Team()).." - Rank Menu")
    self:MakePopup()

    self.model = vgui.Create("ixModelPanel", self)
    self.model:SetModel(ply:GetModel())
    self.model:Dock(LEFT)
    self.model:SetWide(200)
    self.model:SetFOV(30)

    -- Ranks
    if not ( table.IsEmpty(ix.faction.Get(ply:Team()).ranks) ) then
        self.rank = vgui.Create("DComboBox", self)
        self.rank:Dock(TOP)
        self.rank:SetTall(20)
        self.rank:SetSortItems(false)
        self.rank:SetValue("Select a rank")
        self.rank:SetTextColor(Color(255, 255, 255))
        self.rank:SetFont("Font-Elements18")
        for k, v in pairs(ix.faction.Get(ply:Team()).ranks) do
            self.rank:AddChoice(v.name)
        end

        self.rankDescription = vgui.Create("RichText", self)
        self.rankDescription:Dock(TOP)
        self.rankDescription:SetTall(200)
        self.rankDescription:SetText("")

        self.rank.OnSelect = function(panel, index, value)
            self.selectedRank = index
            self.selectedRankData = value

            local rank = ix.faction.Get(ply:Team()).ranks[self.selectedRank]

            if ( rank.description ) then
                self.rankDescription:SetText(rank.description)
                self.rankDescription:SetFontInternal("Font-Elements24-Light")
            end
        end
    end

    -- Divisions
    self.division = vgui.Create("DComboBox", self)
    self.division:Dock(TOP)
    self.division:SetTall(20)
    self.division:SetSortItems(false)
    self.division:SetValue("Select a division")
    self.division:SetTextColor(Color(255, 255, 255))
    self.division:SetFont("Font-Elements18")
    for k, v in pairs(ix.faction.Get(ply:Team()).classes) do
        self.division:AddChoice(v.name)
    end

    self.divisionDescription = vgui.Create("RichText", self)
    self.divisionDescription:Dock(TOP)
    self.divisionDescription:SetTall(200)
    self.divisionDescription:SetText("")

    self.division.OnSelect = function(panel, index, value)
        self.selectedDivision = index
        self.selectedDivisionData = value

        local division = ix.faction.Get(ply:Team()).classes[self.selectedDivision]

        if ( division.model ) then
            self.model:SetModel(division.model)
        end

        if ( division.skin ) then
            self.model:SetSkin(division.skin)
        end

        if ( division.description ) then
            self.divisionDescription:SetText(division.description)
            self.divisionDescription:SetFontInternal("Font-Elements24-Light")
        end
    end

    -- become button
    self.become = vgui.Create("DButton", self)
    self.become:Dock(BOTTOM)
    self.become:SetTall(20)
    self.become:SetText("Become")
    self.become:SetFont("Font-Elements18")
    self.become.DoClick = function()
        if not ( table.IsEmpty(ix.faction.Get(ply:Team()).ranks) ) then
            net.Start("ixRankNPC.Become")
                net.WriteUInt(self.selectedDivision, 8)
                net.WriteUInt(self.selectedRank, 8)
            net.SendToServer()
        else
            net.Start("ixRankNPC.BecomeNoRank")
                net.WriteUInt(self.selectedDivision, 8)
            net.SendToServer()
        end

        self:Close()
    end

    self.become.Think = function(panel)
        -- if you wanna fix this pyramid, sure go on.
        if not ( table.IsEmpty(ix.faction.Get(ply:Team()).ranks) ) then
            if not ( self.selectedRank and self.selectedDivision ) then
                panel:SetDisabled(true)
                panel:SetText("Select a rank and a division first")
            else
                panel:SetDisabled(false)
                panel:SetText("Become")
            end
        else
            if not ( self.selectedDivision ) then
                panel:SetDisabled(true)
                panel:SetText("Select a division first")
            else
                panel:SetDisabled(false)
                panel:SetText("Become")
            end
        end
    end
end

vgui.Register("ixRankNPC", PANEL, "DFrame")

net.Receive("ixRankNPC.OpenMenu", function()
    vgui.Create("ixRankNPC")
end)