function Schema:PopulateEntityInfo(ent, tooltip)
    local ply = LocalPlayer()
    local ent = ent:GetClass()

    -- elseif moment...
    if ( ent:find("ix_loot_container") ) then
        local title = tooltip:AddRow("loot")
        title:SetText("Lootable Container")
        title:SetImportant()
        title:SizeToContents()
    elseif ( ent:find("ix_mining_rock") ) then
        local title = tooltip:AddRow("loot")
        title:SetText("Minable Rock")
        title:SetImportant()
        title:SizeToContents()
    elseif ( ent:find("ix_mining_tree") ) then
        local title = tooltip:AddRow("loot")
        title:SetText("Minable Tree")
        title:SetImportant()
        title:SizeToContents()
    end
end

function Schema:IsViewingCamera()
    return LocalPlayer():GetNetVar("ixCurrentCamera", false)
end

function Schema:CalcView(ply, origin, angles, fov)
    if ( Schema:IsViewingCamera() ) then
        local camera = Schema:IsViewingCamera()
        local camPos, camAngles = camera:GetBonePosition(camera:LookupBone("Combine_Camera.Lens"))

        local view = {}
        view.origin = camPos + (camAngles:Forward() * 2.8)
        view.angles = camAngles + Angle(180, 0, 90)
        view.drawviewer = true

        return view
    end
end

local CameraOverlay1 = ix.util.GetMaterial("dev/dev_prisontvoverlay001")
local CameraOverlay2 = ix.util.GetMaterial("effects/combine_binocoverlay")
function Schema:HUDPaint()
    if ( Schema:IsViewingCamera() ) then
        surface.SetDrawColor(color_white)
        surface.SetMaterial(CameraOverlay1)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        
        surface.SetMaterial(CameraOverlay2)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

        draw.DrawText("Press Space to exit Camera", "ixTitleFont", ScrW() / 2, ScrH() / 8, color_white, TEXT_ALIGN_CENTER)
    end
end

function Schema:CharacterLoaded(char)
    if not ( char:GetFaction() == FACTION_CITIZEN ) then
        net.Start("ixFactionMenuBecome")
            net.WriteUInt(FACTION_CITIZEN, 8)
        net.SendToServer()
    end
end

function Schema:BuildBusinessMenu()
    return false
end

function Schema:PopulateCharacterInfo()
    return false
end

function Schema:PopulateImportantCharacterInfo()
    return false
end

function Schema:PopulateHelpMenu(tabs)
    tabs["voices"] = function(container)
        local classes = {}

        for k, v in pairs(Schema.voices.classes) do
            if ( v.condition(LocalPlayer()) ) then
                classes[#classes + 1] = k
            end
        end

        if ( #classes < 1 ) then
            local info = container:Add("DLabel")
            info:SetFont("ixSmallFont")
            info:SetText("You do not have access to any voice lines!")
            info:SetContentAlignment(5)
            info:SetTextColor(color_white)
            info:SetExpensiveShadow(1, color_black)
            info:Dock(TOP)
            info:DockMargin(0, 0, 0, 8)
            info:SizeToContents()
            info:SetTall(info:GetTall() + 16)

            info.Paint = function(_, width, height)
                surface.SetDrawColor(ColorAlpha(derma.GetColor("Error", info), 160))
                surface.DrawRect(0, 0, width, height)
            end

            return
        end

        table.sort(classes, function(a, b)
            return a < b
        end)

        local searchEntry = container:Add("ixIconTextEntry")
        searchEntry:Dock(TOP)
        searchEntry:SetEnterAllowed(false)

        local function ListVoices(filter)
            for _, class in ipairs(classes) do
                local category = container:Add("Panel")
                category:Dock(TOP)
                category:DockMargin(0, 0, 0, 8)
                category:DockPadding(8, 8, 8, 8)
                category.Paint = function(_, width, height)
                    surface.SetDrawColor(Color(0, 0, 0, 66))
                    surface.DrawRect(0, 0, width, height)
                end
                category.removeOnFilter = true

                local categoryLabel = category:Add("DLabel")
                categoryLabel:SetFont("Font-Elements24")
                categoryLabel:SetText(class:upper())
                categoryLabel:Dock(FILL)
                categoryLabel:SetTextColor(color_white)
                categoryLabel:SetExpensiveShadow(1, color_black)
                categoryLabel:SizeToContents()
                categoryLabel.removeOnFilter = true
                category:SizeToChildren(true, true)

                if ( self.voices and self.voices.stored and self.voices.stored[class] ) then
                    for command, info in SortedPairs(self.voices.stored[class]) do
                        if ( filter == nil ) or ( command:lower():find(filter:lower()) or info.text:lower():find(filter:lower()) ) then
                            local title = container:Add("ixMenuButton")
                            title:SetFont("Font-Elements16")
                            title:SetText(command:upper())
                            title:Dock(TOP)
                            title:SetTextColor(ix.config.Get("color"))
                            title:SetSize(container:GetWide(), 18)
                            title.DoClick = function()
                                ix.util.Notify("You have copied: "..tostring(command:upper()))
                                SetClipboardText(tostring(command:upper()))
                            end
                            title.removeOnFilter = true

                            local description = container:Add("DLabel")
                            description:SetFont("Font-Elements14")
                            description:SetText(info.text)
                            description:Dock(TOP)
                            description:SetTextColor(color_white)
                            description:SetExpensiveShadow(1, color_black)
                            description:SetWrap(true)
                            description:SetAutoStretchVertical(true)
                            description:SizeToContents()
                            description:DockMargin(0, 0, 0, 8)
                            description.removeOnFilter = true
                        end
                    end
                end
            end
        end

        searchEntry.OnChange = function(entry)
            local function deepRemove(panel)
                for k, v in pairs(panel:GetChildren()) do
                    if ( v.removeOnFilter == true ) then
                        v:Remove()
                    else
                        if v:HasChildren() then deepRemove(v) end
                    end
                end
            end

            deepRemove(container)
            ListVoices(searchEntry:GetValue())
        end

        ListVoices()
    end
end