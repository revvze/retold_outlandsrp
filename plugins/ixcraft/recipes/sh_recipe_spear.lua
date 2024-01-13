RECIPE.name = "Spear Rifle"
RECIPE.description = "Craft a Spear Rifle."
RECIPE.model = "models/dpfilms/evilgarlic/beta/spear.mdl"
RECIPE.category = "Firearms"

RECIPE.requirements = {
	["pipe"] = 5,
	["glue"] = 7,
  ["cloth"] = 5,
	["metalplate"] = 10,
	["refinedmetal"] = 16,
}
RECIPE.results = {
	["spear"] = 1,
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
