RECIPE.name = "Health Kit"
RECIPE.description = "A red packet filled with medication."
RECIPE.model = "models/willardnetworks/skills/medkit.mdl"
RECIPE.category = "Medical Items"

RECIPE.requirements = {
	["clean_bandage"] = 2,
	["water"] = 2,
}
RECIPE.results = {
	["health_kit"] = 1,
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