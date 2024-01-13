RECIPE.name = "Stunstick"
RECIPE.description = "Breakdown a Stunstick."
RECIPE.model = "models/weapons/w_stunbaton.mdl"
RECIPE.category = "Scrap (Melee)"

RECIPE.requirements = {
	["stunstick"] = 1,
}
RECIPE.results = {
	["pipe"] = 1,
	["metalplate"] = 1,
	["refinedmetal"] = 1,
}

RECIPE.station = "ix_station_scrappingbench"
RECIPE.craftSound = "willardnetworks/skills/skill_crafting.wav"

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