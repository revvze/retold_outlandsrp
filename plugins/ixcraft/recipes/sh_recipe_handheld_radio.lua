RECIPE.name = "Handheld Radio"
RECIPE.description = "Long range communication with other people."
RECIPE.model = "models/willardnetworks/skills/handheld_radio.mdl"
RECIPE.category = "Tools"

RECIPE.requirements = {
	["metalplate"] = 3,
	["plastic"] = 10,
	["electronics"] = 6,
	["glue"] = 10,
}
RECIPE.results = {
	["handheld_radio"] = 1,
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