RECIPE.name = "Crowbar"
RECIPE.description = "Craft a crowbar."
RECIPE.model = "models/weapons/w_crowbar.mdl"
RECIPE.category = "Melee"

RECIPE.requirements = {
	["metalplate"] = 1,
	["refinedmetal"] = 2,
	["glue"] = 1,
}
RECIPE.results = {
	["wep_crowbar"] = 1,
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