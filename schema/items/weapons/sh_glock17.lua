-- Item Statistics

ITEM.name = "Glock 17"
ITEM.description = "An Austrian sidearm utilising 9mm Ammunition."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/w_pist_glock18.mdl"
ITEM.skin = 0

ITEM.illegal = true

-- Item Inventory Size Configuration

ITEM.width = 2
ITEM.height = 1

-- Item Custom Configuration

ITEM.class = "ix_glock"
ITEM.weaponCategory = "secondary"

ITEM.iconCam = {
	pos = Vector(0, 200, 0),
	ang = Angle(-0.96, 270.59, 0),
	fov = 4.43
}

ITEM:Hook("drop", function(item)
    local ply = item.player
    if ( IsValid(ply) ) and ( ply:IsCombine() or ( ply:IsConscript() and ply:GetCharacter():GetClass() == CLASS_CONSCRIPT_R ) ) then
        ply:EmitSound("npc/scanner/scanner_scan1.wav", 40, 75)
        return false
    end
end)