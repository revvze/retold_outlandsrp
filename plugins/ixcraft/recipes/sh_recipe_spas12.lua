RECIPE.name = "Spas-12"
RECIPE.description = "Craft a Spas-12 shotgun."
RECIPE.model = "models/weapons/tfa_ins2/w_spas12_bri.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 4,
	["glue"] = 2,
	["gear"] = 2,
	["plastic"] = 2,
	["refinedmetal"] = 3,
}
RECIPE.results = {
	["shotgun"] = 1,
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