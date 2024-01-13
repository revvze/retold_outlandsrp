RECIPE.name = "Glock 17"
RECIPE.description = "Craft a Glock 17."
RECIPE.model = "models/weapons/w_pist_glock18.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 1,
	["glue"] = 2,
	["gear"] = 1,
	["plastic"] = 3,
	["metalplate"] = 2,
}
RECIPE.results = {
	["glock17"] = 1,
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