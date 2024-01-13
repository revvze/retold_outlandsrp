local CHAR = ix.meta.character

function CHAR:IsCitizen()
    return ( self:GetFaction() == FACTION_CITIZEN and not self:GetNWBool("isRebel") )
end

function CHAR:IsRebel()
    return ( self:GetFaction() ) and ( self:GetPlayer():GetBodygroup(1) == 5 or self:GetPlayer():GetBodygroup(1) == 6 )
end

function CHAR:IsCWU()
    return ( self:GetFaction() == FACTION_CWU )
end

function CHAR:IsCombine()
    return ( self:GetFaction() == FACTION_CP or self:GetFaction() == FACTION_OW )
end

function CHAR:IsCP()
    return ( self:GetFaction() == FACTION_CP )
end

function CHAR:IsConscript()
    return ( self:GetFaction() == FACTION_CONSCRIPT )
end

function CHAR:IsOW()
    return ( self:GetFaction() == FACTION_OW )
end

function CHAR:IsCA()
    return ( self:GetFaction() == FACTION_CA )
end

function CHAR:IsVortigaunt()
    return ( self:GetFaction() == FACTION_VORTIGAUNT )
end

function CHAR:IsDispatch()
    return ( self:GetFaction() == FACTION_DISPATCH )
end

function CHAR:GiveMoney(value)
    self:SetMoney(self:GetMoney() + value)
end