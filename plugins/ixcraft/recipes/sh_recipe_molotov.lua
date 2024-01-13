RECIPE.name = "Molotov"
RECIPE.description = "Craft a molotov."
RECIPE.model = "models/props_junk/GlassBottle01a.mdl"
RECIPE.category = "Throwables"

RECIPE.requirements = {
	["cloth"] = 1,
	["drink_alcohol"] = 1,
}
RECIPE.results = {
	["wep_molotov"] = 1,
}

RECIPE.station = "ix_station_weaponbench"
RECIPE.craftSound = "willardnetworks/skills/skill_medicine.wav"

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