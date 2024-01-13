RECIPE.name = "USP Match"
RECIPE.description = "Breakdown a USP Match pistol."
RECIPE.model = "models/weapons/w_pistol.mdl"
RECIPE.category = "Scrap (Firearms)"

RECIPE.base = "recipe_base"

RECIPE.requirements = {
	["pistol"] = 1,
}
RECIPE.results = {
	["weaponparts"] = 1,
}

RECIPE.station = "ix_station_scrappingbench"
RECIPE.craftStartSound = "willardnetworks/skills/skill_crafting.wav"
RECIPE.craftTime = 10
RECIPE.craftEndSound = "physics/metal/metal_box_strain3.wav"

RECIPE:PostHook("OnCanCraft", function(recipeTable, ply)
    if ( recipeTable.station ) then
        for _, v in pairs(ents.FindByClass(recipeTable.station)) do
            if (ply:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
                return true
            end
        end

        return false, "You need to be near a scrapping workbench."
    end
end)

RECIPE:PostHook("OnCraft", function(recipeTable, ply)
	ply:EmitSound(recipeTable.craftSound or "")
end)