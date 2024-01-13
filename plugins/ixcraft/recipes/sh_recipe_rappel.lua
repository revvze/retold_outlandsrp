RECIPE.name = "Rappel Gear"
RECIPE.description = "Craft Rappel Gear."
RECIPE.model = "models/props_c17/TrapPropeller_Lever.mdl"
RECIPE.category = "Tools"

RECIPE.requirements = {
	["metalplate"] = 2,
	["glue"] = 2,
	["gear"] = 1,
}
RECIPE.results = {
	["wep_rappel"] = 1,
}

RECIPE.station = "ix_station_workbench"
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
