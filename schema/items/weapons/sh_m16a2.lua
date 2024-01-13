-- Item Statistics

ITEM.name = "Colt M16A2"
ITEM.description = "An American service rifle bizarrely utilising 7.62x39 ammunition."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/w_rif_m4a1.mdl"
ITEM.skin = 0

ITEM.illegal = true

-- Item Inventory Size Configuration

ITEM.width = 3
ITEM.height = 2

-- Item Custom Configuration

ITEM.class = "ix_m16a2"
ITEM.weaponCategory = "primary"

ITEM.iconCam = {
	pos = Vector(0, 200, 0),
	ang = Angle(-1.44, 269.22, 0),
	fov = 11
}

ITEM:Hook("drop", function(item)
    local ply = item.player
    if ( IsValid(ply) ) and ( ply:IsCombine() or ( ply:IsConscript() and ply:GetCharacter():GetClass() == CLASS_CONSCRIPT_R ) ) then
        ply:EmitSound("npc/scanner/scanner_scan1.wav", 40, 75)
        return false
    end
end)