ITEM.name = "Flashbang"
ITEM.description = "A flashbang that can be thrown, it is a small explosive device that can be used to blind your enemies."
ITEM.model = "models/weapons/w_eq_flashbang.mdl"
ITEM.category = "Weapons"
ITEM.class = "ls_grenade"
ITEM.width = 1
ITEM.height = 1

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
    OnRun = function(item)
        item.player:Give("ls_flashbang")
        item.player:SelectWeapon("ls_flashbang")
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