RECIPE.name = "Radio Frequency IED"
RECIPE.description = "Craft a explosive IED."
RECIPE.model = "models/weapons/w_c4_planted.mdl"
RECIPE.category = "Tools"

RECIPE.requirements = {
	["plastic"] = 16,
	["glue"] = 6,
	["electronics"] = 6,
	["gunpowder"] = 45,
}
RECIPE.results = {
	["item_radioied"] = 1,
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