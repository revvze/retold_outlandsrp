ITEM.name = "Molotov"
ITEM.description = "A molotov that can be thrown, it is a small incendiary device that can be used to burn medium areas."
ITEM.model = "models/props_junk/glassbottle01a.mdl"
ITEM.category = "Weapons"
ITEM.class = "ls_grenade"
ITEM.width = 1
ITEM.height = 1

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
    OnRun = function(item)
        item.player:Give("ls_molotov")
        item.player:SelectWeapon("ls_molotov")
    end,
}