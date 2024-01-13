-- Item Statistics

ITEM.name = "Stun Baton"
ITEM.description = "A baton with a sturdy grip, it is able to be turned on for a stun mode or beating mode."
ITEM.category = "Weapons"

-- Item Configuration

ITEM.model = "models/weapons/w_stunbaton.mdl"
ITEM.skin = 0

ITEM.illegal = true

-- Item Inventory Size Configuration

ITEM.width = 2
ITEM.height = 1

-- Item Custom Configuration

ITEM.class = "ix_stunstick"
ITEM.weaponCategory = "melee"

ITEM.iconCam = {
    pos = Vector(0, 200, 0),
    ang = Angle(-0.23955784738064, 270.44906616211, 0),
    fov = 10.780103254469,
}

ITEM:Hook("drop", function(item)
    local ply = item.player
    if ( IsValid(ply) ) and ( ply:IsCombine() or ( ply:IsConscript() and ply:GetCharacter():GetClass() == CLASS_CONSCRIPT_C ) ) then
        ply:EmitSound("npc/scanner/scanner_scan1.wav", 40, 75)
        return false
    end
end)