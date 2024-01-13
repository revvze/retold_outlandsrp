RECIPE.name = "MP7"
RECIPE.description = "Craft an MP7."
RECIPE.model = "models/weapons/v_mp7_sandstorm.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 2,
	["glue"] = 1,
	["gear"] = 1,
	["plastic"] = 2,
	["refinedmetal"] = 3,
}
RECIPE.results = {
	["smg1"] = 1,
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