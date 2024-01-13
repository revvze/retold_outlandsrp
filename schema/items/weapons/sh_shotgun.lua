-- Item Statistics

ITEM.name = "Franchi SPAS-12"
ITEM.description = "A powerful pump-action shotgun utilising 12 gauge buckshot."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/w_shotgun.mdl"
ITEM.skin = 0

ITEM.illegal = true

-- Item Inventory Size Configuration

ITEM.width = 3
ITEM.height = 1

-- Item Custom Configuration

ITEM.class = "ix_spas12"
ITEM.weaponCategory = "primary"

ITEM.iconCam = {
    pos = Vector(0, 200, 1),
    ang = Angle(0, 270, 0),
    fov = 10,
}

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