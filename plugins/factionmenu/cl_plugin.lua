local PLUGIN = PLUGIN

function PLUGIN:CreateMenuButtons(tabs)
    tabs["factions"] = {
        Create = function(info, container)
            local ply, char = LocalPlayer(), LocalPlayer():GetCharacter()

            container.selectedFaction = nil

            local leftPanel = container:Add("Panel")
            leftPanel:Dock(LEFT)
            leftPanel:SetWide(container:GetWide() / 3)
            leftPanel.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
            end

            local factionModel = leftPanel:Add("ixModelPanel")
            factionModel:Dock(FILL)
            factionModel:SetModel(ply:GetModel())
            factionModel:SetFOV(50)
            timer.Simple(0, function()
                if ( IsValid(factionModel) ) then
                    for k, v in pairs(ply:GetBodyGroups()) do
                        factionModel.Entity:SetBodygroup(v.id, ply:GetBodygroup(v.id))
                        factionModel.Entity:SetSkin(ply:GetSkin())
                    end
                end
            end)

            local rightPanel = container:Add("Panel")
            rightPanel:Dock(LEFT)
            rightPanel:SetWide(container:GetWide() / 1.5)
            rightPanel.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 50))
            end

            for k, v in pairs(ix.faction.indices) do
                if not ( v.noPopulate ) then
                    if ( not ply:IsAdmin() and v.adminOnly ) then return end
                    
                    local model = tostring(table.Random(v.models)) or ply:GetModel()
                    if ( v.index == FACTION_CITIZEN ) then
                        model = char:GetData("originalModel", table.Random(ix.faction.Get(v.index).models))
                    end

                    local factionButton = rightPanel:Add("ixMenuButton")
                    factionButton:Dock(TOP)
                    factionButton:SetTall(50)
                    factionButton:SetText("    "..tostring(v.name))
                    factionButton:SetFont("Font-Elements40")
                    if ( ply:GetXP() >= v.xp ) then
                        factionButton:SetTextColor(v.color)
                        factionButton.backgroundColor = Color(0, 255, 0)
                    else
                        factionButton:SetTextColor(v.color)
                        factionButton.backgroundColor = Color(255, 0, 0)
                    end
                    factionButton.DoClick = function(self)
                        container.selectedFaction = k
                        container.selectedFactionXP = v.xp

                        factionModel:SetModel(model)
                    end

                    local factionButtonModel = factionButton:Add("ixSpawnIcon")
                    factionButtonModel:Dock(LEFT)
                    factionButtonModel:SetWide(50)
                    factionButtonModel:SetModel(model)

                    -- add a label to the button to show the xp cost of the faction
                    local factionButtonLabel = factionButton:Add("DLabel")
                    factionButtonLabel:Dock(RIGHT)
                    factionButtonLabel:DockMargin(0, 0, 10, 0)
                    factionButtonLabel:SetText("XP: "..tostring(v.xp))
                    if ( ply:GetXP() >= v.xp ) then
                        factionButtonLabel:SetTextColor(Color(0, 200, 0))
                    else
                        factionButtonLabel:SetTextColor(Color(200, 0, 0))
                    end
                    factionButtonLabel:SetFont("Font-Elements20")
                    factionButtonLabel:SizeToContents()
                end
            end

            local factionBecomeButton = rightPanel:Add("ixMenuButton")
            factionBecomeButton:Dock(BOTTOM)
            factionBecomeButton:SetTall(50)
            factionBecomeButton:SetText("Become Faction")
            factionBecomeButton:SetFont("Font-Elements40")
            factionBecomeButton.DoClick = function(self)
                net.Start("ixFactionMenuBecome")
                    net.WriteUInt(container.selectedFaction, 8)
                net.SendToServer()
            end
            factionBecomeButton.Think = function(self)
                if ( container.selectedFaction and ply:GetXP() >= container.selectedFactionXP ) then
                    factionBecomeButton:SetText("Become Faction")
                    factionBecomeButton:SetEnabled(true)
                else
                    factionBecomeButton:SetText("Select a Faction")
                    factionBecomeButton:SetEnabled(false)
                end
            end
        end,
    }
end