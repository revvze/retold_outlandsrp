RECIPE.name = "Refined Metal"
RECIPE.description = "Craft refined metal."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Resources"

RECIPE.requirements = {
	["metalplate"] = 2,
	["glue"] = 1,
}
RECIPE.results = {
	["refinedmetal"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "willardnetworks/skills/skill_crafting.wav"

RECIPE:PostHook("OnCanCraft", function(recipeTable, ply)
    if ( recipeTable.station ) then
        for _, v in pairs(ents.FindByClass(recipeTable.station)) do
            if (ply:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
                return true
            end
        end

        return false, "You need to be near a workbench."
    end
end)

RECIPE:PostHook("OnCraft", function(recipeTable, ply)
	ply:EmitSound(recipeTable.craftSound or "")
end)