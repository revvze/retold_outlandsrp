-- Item Statistics

ITEM.name = "H&K MP7"
ITEM.description = "A compact, fully automatic sub-machine gun utilising 4.6mm ammunition."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/w_mp7_sandstorm.mdl"
ITEM.skin = 0

ITEM.illegal = true

-- Item Inventory Size Configuration

ITEM.width = 3
ITEM.height = 2

-- Item Custom Configuration

ITEM.class = "ix_mp7"
ITEM.weaponCategory = "primary"

ITEM.iconCam = {
    pos = Vector(0, 200, 0),
    ang = Angle(0.31, 269.53, 0),
    fov = 7.36
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