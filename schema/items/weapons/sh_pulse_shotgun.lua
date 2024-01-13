-- Item Statistics

ITEM.name = "Pulse Shotgun"
ITEM.description = "A Prototype Pulse Shotgun."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/w_heavyshotgun.mdl"
ITEM.skin = 0

ITEM.illegal = true

-- Item Inventory Size Configuration

ITEM.width = 4
ITEM.height = 2

-- Item Custom Configuration

ITEM.class = "ix_pulse_shotgun"
ITEM.weaponCategory = "primary"

ITEM:Hook("drop", function(item)
    local ply = item.player
    if ( IsValid(ply) ) and ( ply:IsCombine() or ( ply:IsConscript() and ply:GetCharacter():GetClass() == CLASS_CONSCRIPT_C ) ) then
        ply:EmitSound("npc/scanner/scanner_scan1.wav", 40, 75)
        return false
    end
end)
