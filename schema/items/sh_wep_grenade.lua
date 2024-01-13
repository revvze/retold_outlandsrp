ITEM.name = "Grenade"
ITEM.description = "A small, green colored MK3A2 grenade that explodes a few seconds after it is thrown."
ITEM.model = "models/weapons/w_grenade.mdl"
ITEM.category = "Weapons"
ITEM.class = "weapon_frag"
ITEM.width = 1
ITEM.height = 1

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
    OnRun = function(item)
        item.player:Give("weapon_frag")
        item.player:SelectWeapon("weapon_frag")
    end,
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