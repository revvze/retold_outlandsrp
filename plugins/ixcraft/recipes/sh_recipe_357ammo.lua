RECIPE.name = "357 Ammo"
RECIPE.description = "Craft some 357 Revolver Bullets."
RECIPE.model = "models/Items/357ammo.mdl"
RECIPE.category = "Ammunition"

RECIPE.requirements = {
	["bulletcasing"] = 2,
	["gunpowder"] = 2,
}
RECIPE.results = {
	["ammo_357"] = 1,
}

RECIPE.station = "ix_station_weaponbench"
RECIPE.craftSound = "willardnetworks/skills/skill_crafting.wav"

RECIPE:PostHook("OnCanCraft", function(recipeTable, ply)
    if ( recipeTable.station ) then
        for _, v in pairs(ents.FindByClass(recipeTable.station)) do
            if (ply:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
                return true
            end
        end

        return false, "You need to be near a weapon workbench."
    end
end)

RECIPE:PostHook("OnCraft", function(recipeTable, ply)
	ply:EmitSound(recipeTable.craftSound or "")
end)