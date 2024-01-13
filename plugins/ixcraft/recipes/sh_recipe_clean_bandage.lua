RECIPE.name = "Clean Bandage"
RECIPE.description = "Clean a dirty bandage with some water."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Medical Items"

RECIPE.requirements = {
	["bandage"] = 1,
	["drink_water"] = 1
}
RECIPE.results = {
	["clean_bandage"] = 1,
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