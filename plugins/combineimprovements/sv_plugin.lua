--[[---------------------------------------------------------------------------
    ** License: https://creativecommons.org/licenses/by-nc-nd/4.0/

    ** Copryright 2022 Riggs.mackay
    ** This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 4.0 Unported License.
---------------------------------------------------------------------------]]--

local PLUGIN = PLUGIN

util.AddNetworkString("ixChatterFinishChat")
util.AddNetworkString("ixChatterChatTextChanged")
util.AddNetworkString("ixDisplaySend")
util.AddNetworkString("ixDispatchSend")
util.AddNetworkString("ixTerminalCodeSet")

net.Receive("ixChatterFinishChat", function(len, ply)
    if ( ply:IsCombine() and ply.ixTypingBeep ) then
        local class = "NPC_MetroPolice"
        if ( ply:IsIRT() or ply:IsOW() ) then
            class = "NPC_Combine"
        end

        ply:EmitSound(class..".Radio.Off", 70)
        ply.ixTypingBeep = nil
    end
end)

net.Receive("ixChatterChatTextChanged", function(len, ply)
    local key = net.ReadString()
    if ( ply:IsCombine() and not ply.ixTypingBeep ) and ( key == "y" or key == "w" or key == "r" or key == "t" ) then
        local class = "NPC_MetroPolice"
        if ( ply:IsIRT() or ply:IsOW() ) then
            class = "NPC_Combine"
        end

        ply:EmitSound(class..".Radio.On", 70)
        ply.ixTypingBeep = true
    end
end)

net.Receive("ixTerminalCodeSet", function(len, ply)
    local code = net.ReadString()
    if not ( ply:IsCombine() ) then return end

    ix.cityCode.Set(ply, code)
end)