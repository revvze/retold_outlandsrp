RECIPE.name = "M16A2"
RECIPE.description = "Craft an M16A2."
RECIPE.model = "models/weapons/w_bocw_m16.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 3,
	["glue"] = 3,
	["gear"] = 2,
	["metalplate"] = 4,
	["plastic"] = 3,
	["refinedmetal"] = 3,
}
RECIPE.results = {
	["m16a2"] = 1,
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