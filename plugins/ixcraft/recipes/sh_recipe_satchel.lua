// Project Paradigm Gang was here lel.


RECIPE.name = "Satchel"
RECIPE.description = "A small bag. Featuring small compartments for storage of items, as well as being very comfortable."
RECIPE.model = "models/willardnetworks/clothingitems/satchel.mdl"
RECIPE.category = "Storage"

RECIPE.requirements = {
	["cloth"] = 5,
	["glue"] = 5,
}
RECIPE.results = {
	["satchel"] = 1,
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