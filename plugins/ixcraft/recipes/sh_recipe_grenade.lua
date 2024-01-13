RECIPE.name = "Grenade"
RECIPE.description = "Craft a grenade."
RECIPE.model = "models/items/grenadeammo.mdl"
RECIPE.category = "Throwables"

RECIPE.requirements = {
	["metalplate"] = 5,
	["gunpowder"] = 5,
	["plastic"] = 3,
	["glue"] = 3,
	["gear"] = 1,
}
RECIPE.results = {
	["wep_grenade"] = 1,
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