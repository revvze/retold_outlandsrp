FACTION.name = "Refugee"
FACTION.description = "Escapies from the Universal Union's grasp within City-17. Now seeking refuge within what use to be a quiet and peaceful mining town, now infested with headcrabs and zombies with the urge to feast on every living thing. All there is to do now is take what you can to survive, establish a safe area, craft a weapon to defend yourself, but only fight if absolutely necessary, and tread lightly, for this is hallowed ground. Welcome to Ravenholm."
FACTION.color = Color(20, 120, 20)
FACTION.isDefault = true

FACTION.models = {
    "models/willardnetworks/citizens/female_01.mdl",
    "models/willardnetworks/citizens/female_02.mdl",
    "models/willardnetworks/citizens/female_03.mdl",
    "models/willardnetworks/citizens/female_04.mdl",
    "models/willardnetworks/citizens/female_06.mdl",
    "models/willardnetworks/citizens/female_07.mdl",
	"models/willardnetworks/citizens/male01.mdl",
	"models/willardnetworks/citizens/male02.mdl",
	"models/willardnetworks/citizens/male03.mdl",
	"models/willardnetworks/citizens/male04.mdl",
	"models/willardnetworks/citizens/male05.mdl",
	"models/willardnetworks/citizens/male06.mdl",
	"models/willardnetworks/citizens/male07.mdl",
	"models/willardnetworks/citizens/male08.mdl",
	"models/willardnetworks/citizens/male09.mdl",
	"models/willardnetworks/citizens/male10.mdl",
}

FACTION.xp = 0

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
    char:GiveFlags("pet")
end

FACTION_CITIZEN = FACTION.index
