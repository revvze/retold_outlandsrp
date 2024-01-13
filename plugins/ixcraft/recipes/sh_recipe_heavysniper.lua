RECIPE.name = "Heavy Sniper"
RECIPE.description = "Craft a heavy sniper."
RECIPE.model = "models/tnb/weapons/w_sniper_new.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 4,
	["glue"] = 3,
	["gear"] = 2,
	["plastic"] = 2,
	["refinedmetal"] = 4,
}
RECIPE.results = {
	["heavysniper"] = 1,
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