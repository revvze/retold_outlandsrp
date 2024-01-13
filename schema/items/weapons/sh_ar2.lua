ITEM.name = "Pulse Rifle"
ITEM.description = "A Dark Energy powered Pulse Rifle."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/w_irifle.mdl"
ITEM.skin = 0

-- Item Inventory Size Configuration

ITEM.width = 3
ITEM.height = 2

-- Item Custom Configuration

ITEM.class = "ix_ar2"
ITEM.weaponCategory = "primary"

ITEM:Hook("drop", function(item)
    local ply = item.player
    if ( IsValid(ply) ) and ( ply:IsCombine() or ( ply:IsConscript() and ply:GetCharacter():GetClass() == CLASS_CONSCRIPT_C ) ) then
        ply:EmitSound("npc/scanner/scanner_scan1.wav", 40, 75)
        return false
    end
end)
