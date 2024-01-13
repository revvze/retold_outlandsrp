// Project Paradigm Gang was here lel.


RECIPE.name = "Small Pouch"
RECIPE.description = "A small Pouch. Featuring small compartments for storage of items."
RECIPE.model = "models/willardnetworks/skills/surgicalkit.mdl"
RECIPE.category = "Storage"

RECIPE.requirements = {
	["cloth"] = 3,
	["glue"] = 1,
}
RECIPE.results = {
	["smallpouch"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftSound = "willardnetworks/inventory/inv_bandage.wav"

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