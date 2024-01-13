// Project Paradigm Gang was here lel.


RECIPE.name = "Cooked Houndeye Meat"
RECIPE.description = "Should you feel bad for eating a dog?"
RECIPE.model = "models/willardnetworks/food/steak2.mdl"
RECIPE.category = "Food"

RECIPE.requirements = {
	["houndeye_meat"] = 1,
}
RECIPE.results = {
	["houndeye_cooked"] = 1,
}

RECIPE.station = "ix_station_stove"
RECIPE.craftSound = "willardnetworks/skills/skill_cooking.wav"

RECIPE:PostHook("OnCanCraft", function(recipeTable, ply)
    if ( recipeTable.station ) then
        for _, v in pairs(ents.FindByClass(recipeTable.station)) do
            if (ply:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
                return true
            end
        end

        return false, "You need to be near a stove."
    end
end)

RECIPE:PostHook("OnCraft", function(recipeTable, ply)
	ply:EmitSound(recipeTable.craftSound or "")
end)