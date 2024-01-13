// Project Paradigm Gang was here lel.


RECIPE.name = "Suitcase"
RECIPE.description = "A suitcase. Featuring large compartments for storage of items."
RECIPE.model = "models/props_c17/suitcase_passenger_physics.mdl"
RECIPE.category = "Storage"

RECIPE.requirements = {
	["cloth"] = 10,
	["glue"] = 5,
	["plastic"] = 5,
}
RECIPE.results = {
	["suitcase"] = 1,
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