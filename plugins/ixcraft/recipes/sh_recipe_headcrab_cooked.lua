// Project Paradigm Gang was here lel.


RECIPE.name = "Cooked Headcrab Meat"
RECIPE.description = "Who knew that alien meat tasted like Chicken?"
RECIPE.model = "models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib04.mdl"
RECIPE.category = "Food"

RECIPE.requirements = {
	["headcrab_meat"] = 1,
}
RECIPE.results = {
	["headcrab_cooked"] = 1,
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