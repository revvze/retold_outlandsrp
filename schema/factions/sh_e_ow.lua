FACTION.name = "Overwatch Transhuman Arm"
FACTION.description = "The Overwatch Transhuman Arm are the military wing of the Universal Union's forces. They are highly trained and extensively modified super soldiers, far stronger than any normal human. They are entirely without fear or emotion of any kind, called into the Outlands only when circumstances are at their most dire. Otherwise, they remain in the outlands Nexus. They are completely obedient to their commander, following orders without regard to their own safety. Operating in small squads, the Overwatch Transhuman Arm are a force to be reckoned with, and haunt the dreams of any citizen with common sense."
FACTION.color = Color(150, 50, 50)
FACTION.isDefault = true

FACTION.models = {
    "models/player/soldier_stripped.mdl",
}

FACTION.xp = 1000

FACTION.ranks = {
    {
        name = "OWS",
        description = "",
        xp = 1000,
    },
    {
        name = "EOW",
        description = "",
        xp = 1600,
    },
    {
        name = "LDR",
        description = "",
        xp = 3000,
    },
}

FACTION.classes = {
     {
        name = "Civil Authority",
        description = "The Civil Authority is the last Civil Protection force that survived the uprising within City-17. They have been trained and equip for combat alongside the Overwatch Transhuman Arm.",
        xp = 1000,
        model = "models/police_sentient.mdl",
        skin = 0,
        onBecome = function(ply, char, inv, rank)
			inv:Add("stunstick")
			inv:Add("pistol")
			inv:Add("wep_flashbang")
			inv:Add("wep_rappel")
			inv:Add("flaregun")
			ply:SetBodygroup(1, 0)
			ply:SetBodygroup(2, 0)
			ply:SetBodygroup(3, 2)
            ply:SetBodygroup(4, 2)
			ply:SetBodygroup(5, 0)
			ply:SetBodygroup(6, 1)
			ply:SetBodygroup(7, 2)
			ply:SetBodygroup(8, 0)
			
            if ( rank.name == "EOW" or rank.name == "LDR" ) then
                inv:Add("smg1")
            else
			
            end

            if ( rank.name == "LDR" ) then
                ply:SetModel("models/police_super.mdl")
                ply:SetSkin(0)
            else
                ply:SetHealth(100)
                ply:SetArmor(100)
            end
        end,
    },
	{
        name = "Soldier",
        description = "Soldier units are highly trained medium-range combat units. Soldier units are a jack of all trades, master of none. They have access to a mix of close and medium range weaponry.",
        xp = 1600,
        model = "models/combine_ground_sa.mdl",
        skin = 0,
        onBecome = function(ply, char, inv, rank)
            inv:Add("wep_rappel")
			inv:Add("wep_flashbang")
			inv:Add("flaregun")
            
            if ( rank.name == "EOW" or rank.name == "LDR" ) then
                inv:Add("pulse_smg")
            else
                inv:Add("pulse_smg")
            end

            if ( rank.name == "LDR" ) then
                ply:SetModel("models/combine_ground_a.mdl")
                ply:SetSkin(0)
				
				inv:Add("pulse_rifle")
            else
                ply:SetHealth(100)
                ply:SetArmor(100)
            end
        end,
    },
    {
        name = "Shotgunner",
        description = "Shotgunner units are close-quaters engagement specialists. They are ineffective at medium and long ranges however they excel at close-quaters due to their SPAS-12 shotgun and heavy armour. Shotgunner units are un-efficient at performing raids and bruteforcing into enemy strongholds. Their strenght is to crouch down and shoot their targets.",
        xp = 2000,
        model = "models/combine_shotgun_sa.mdl",
        skin = 1,
        onBecome = function(ply, char, inv, rank)
            inv:Add("shotgun")
            inv:Add("wep_rappel")
			inv:Add("wep_grenade")
			inv:Add("flaregun")

            if ( rank.name == "LDR" ) then
		inv:Add("wep_flashbang")
                ply:SetModel("models/combine_shotgun_a.mdl")
                ply:SetSkin(1)

            else
                ply:SetHealth(150)
                ply:SetArmor(150)
            end
        end,
    },
    {
        name = "Long Range",
        description = "Long Range units are hand-picked from the units in overwatch. They are specialists in long range engagements with the advanced EVR scope attached to their Pulse Sniper. They also have the flexibility to remove this scope to fight efficiently in medium range engagements too. Long Range units are often considered overwatch's greatest strategic asset.",
        xp = 2600,
        model = "models/combine_watch_sa.mdl",
        skin = 0,
        onBecome = function(ply, char, inv, rank)
            inv:Add("pulse_sniper")
			inv:Add("mk32")
            inv:Add("wep_rappel")
			inv:Add("flaregun")

            if ( rank.name == "LDR" ) then
                ply:SetModel("models/combine_watch_a.mdl")
                ply:SetSkin(0)

            elseif ( rank.name == "EOW" ) then
            
			else
                ply:SetHealth(100)
                ply:SetArmor(100)
            end
        end,
    },
	{
        name = "Airwatch",
        description = "The Airwatch division is responsible for vehicles and aircrafts as well as assisting Overwatch in deadly situations.",
        xp = 3000,
        model = "models/plummy_sh_civ_pro/plummy_pilot_cp.mdl",
        skin = 0,
        onBecome = function(ply, char, inv, rank)
            inv:Add("pistol")
            inv:Add("wep_rappel")
			inv:Add("flaregun")

            if ( rank.name == "LDR" ) then
                ply:SetModel("models/plummy_sh_civ_pro/plummy_pilot_cp.mdl")
                ply:SetSkin(0)

            elseif ( rank.name == "EOW" ) then
            
			else
                ply:SetHealth(100)
                ply:SetArmor(100)
            end
        end,
    },
	{
        name = "Vortigaunt Synth",
        description = "Captured Vortigaunts that have been modified to become weapons.",
        xp = 3300,
        model = "models/vortigaunt_synth/vortigaunt_synth.mdl",
        skin = 0,
        onBecome = function(ply, char, inv, rank)
	
            if ( rank.name == "LDR" ) then
                ply:SetModel("models/vortigaunt_synth/vortigaunt_synth.mdl")

            elseif ( rank.name == "EOW" ) then
            
			else
                ply:SetHealth(100)
                ply:SetArmor(50)
            end
        end,
    },
    {
        name = "Elite",
        description = "Elite soldiers are the best of the best in the Overwatch Arsenal, they are equipped with a Pulse-Rifle or sometimes a SPAS-12. They've gone through so much advanced firearms training that no human can beat theam in a 1 to 1 combat. Their loyalty and advanced training allows them to lead any specific Overwatch Unit at any given time. You do not want to face them up close.",
        xp = 3600,
        model = "models/combine_super_sa.mdl",
        skin = 0,
        onBecome = function(ply, char, inv, rank)
            inv:Add("ar2")
      		inv:Add("shotgun")
			inv:Add("wep_rappel")
			inv:Add("wep_flashbang")
			inv:Add("wep_grenade")
			inv:Add("flaregun")

            if ( rank.name == "EOW" or rank.name == "LDR" ) then
		
            else
        
            end

            if ( rank.name == "LDR" ) then
                ply:SetModel("models/combine_super_a.mdl")
                ply:SetSkin(0)

            else
                ply:SetHealth(150)
                ply:SetArmor(150)
            end
        end,
    },
}

FACTION.taglines = {
    "FLUSH",
    "RANGER",
    "HUNTER",
    "BLADE",
    "SCAR",
    "HAMMER",
    "SWEEPER",
    "SWIFT",
    "FIST",
    "SWORD",
    "SAVAGE",
    "TRACKER",
    "SLASH",
    "RAZOR",
    "STAB",
    "SPEAR",
    "STRIKER",
    "DAGGER",
}

FACTION.canSeeWaypoints = true
FACTION.canAddWaypoints = true
FACTION.canRemoveWaypoints = true
FACTION.canUpdateWaypoints = true

FACTION_OW = FACTION.index
