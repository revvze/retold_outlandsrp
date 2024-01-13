RECIPE.name = "Dirty Bandage"
RECIPE.description = "Craft some dirty bandages with 2 pieces of cloth."
RECIPE.model = "models/stuff/bandages_dirty.mdl"
RECIPE.category = "Medical Items"

RECIPE.requirements = {
	["cloth"] = 2,
}
RECIPE.results = {
	["bandage"] = 1,
}

RECIPE.station = "ix_station_workbench"
RECIPE.craftStartSound = "willardnetworks/inventory/inv_bandage.wav"

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