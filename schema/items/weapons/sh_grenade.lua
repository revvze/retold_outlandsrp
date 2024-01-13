-- Item Statistics

ITEM.name = "MK3A2 Frag Grenade"
ITEM.description = "A small, green colored grenade that explodes a few seconds after it is thrown."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/w_grenade.mdl"
ITEM.skin = 0

ITEM.illegal = true

-- Item Inventory Size Configuration

ITEM.width = 1
ITEM.height = 1

-- Item Custom Configuration

ITEM.class = "weapon_frag"
ITEM.weaponCategory = "grenade"

ITEM:Hook("drop", function(item)
    local ply = item.player
    if ( IsValid(ply) ) and ( ply:IsCombine() or ( ply:IsConscript() and ply:GetCharacter():GetClass() == CLASS_CONSCRIPT_C ) ) then
        ply:EmitSound("npc/scanner/scanner_scan1.wav", 40, 75)
        return false
    end
end)

ITEM:Hook("drop", function(item)
    local ply = item.player
    if ( IsValid(ply) ) and ( ply:IsCombine() or ( ply:IsConscript() and ply:GetCharacter():GetClass() == CLASS_CONSCRIPT_R ) ) then
        ply:EmitSound("npc/scanner/scanner_scan1.wav", 40, 75)
        return false
    end
end)