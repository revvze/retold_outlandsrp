local PLAYER = FindMetaTable("Player")

function PLAYER:GetXP()
    return self:GetNWInt("ixXP") or ( SERVER and self:GetPData("ixXP", 0) or 0 )
end

if ( SERVER ) then
    function PLAYER:SetXP(value)
        if not ( tonumber(value) ) then return end
        if ( tonumber(value) < 0 ) then return end

        self:SetPData("ixXP", tonumber(value))
        self:SetNWInt("ixXP", tonumber(value))
    end
end