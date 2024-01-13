local PLUGIN = PLUGIN

PLUGIN.name = "New Notify"
PLUGIN.author = "Riggs.mackay"
PLUGIN.description = ""

if ( SERVER ) then
    util.AddNetworkString("ixNotify")
end

if ( CLIENT ) then
    function notification.AddLegacy(text, _, __)
        local ply = LocalPlayer()
        ply:Notify(tostring(text))
    end
    
    net.Receive("ixNotify", function(len)
        local message = net.ReadString()
    
        if not LocalPlayer() or not LocalPlayer().Notify then
            return
        end
        
        LocalPlayer():Notify(message)
    end)
end

ix.notices = ix.notices or {}

local function OrganizeNotices(i)
    local scrW = ScrW()
    local lastHeight = ScrH() - 100

    for k, v in ipairs(ix.notices) do
        local height = lastHeight - v:GetTall() - 10
        v:MoveTo(scrW - (v:GetWide()), height, 0.15, (k / #ix.notices) * 0.25, nil)
        lastHeight = height
    end
end

local PLAYER = FindMetaTable("Player")

function PLAYER:Notify(message)
    if ( CLIENT ) then
        local notice = vgui.Create("ixNotify")
        local i = table.insert(ix.notices, notice)

        notice:SetMessage(message)
        notice:SetPos(ScrW(), ScrH() - (i - 1) * (notice:GetTall() + 4) + 4) -- needs to be recoded to support variable heights
        notice:MoveToFront() 
        OrganizeNotices(i)

        timer.Simple(10, function()
            if IsValid(notice) then
                notice:AlphaTo(0, 1, 0, function() 
                    notice:Remove()

                    for v,k in pairs(ix.notices) do
                        if k == notice then
                            table.remove(ix.notices, v)
                        end
                    end

                    OrganizeNotices(i)
                end)
            end
        end)

        MsgN(message)
    else
        net.Start("ixNotify")
            net.WriteString(message)
        net.Send(self)
    end
end