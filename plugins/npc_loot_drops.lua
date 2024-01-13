PLUGIN.name = "NPC Loot Drops"
PLUGIN.author = "ZeMysticalTaco"
PLUGIN.description = "Adds in NPC loot drops."

PLUGIN.LootTable = {
    [ "npc_vj_hla_zombieclassic" ] = {
        minItems = 0, --Minimum amount of items this NPC will drop.
        maxItems = 2, --Maximum amount of items this NPC will drop.
        name = 'Mutilated Corpse', --What this NPC's name is whenever someone looks at the corpse.
		description = 'A corpse mangled by a headcrab. It can be searched.', --The text under the name when someone looks at the corpse.
        items = { "cloth", "plastic", "metalplate", "bandage" } --The list of items this NPC will drop if it will drop any items.
    },
    [ "npc_vj_hla_zombiearmored" ] = {
        minItems = 0,
        maxItems = 2,
        name = 'Mutilated Corpse',
		description = 'A corpse mangled by a headcrab then cut in half. It can be searched.',
        items = { "cloth", "plastic", "metalplate", "bandage" }
	},
	[ "npc_vj_hla_zombiereviver" ] = {
        minItems = 0,
        maxItems = 2,
        name = 'Mutilated Corpse',
		description = 'A corpse mangled by a headcrab then cut in half. It can be searched.',
        items = { "cloth", "plastic", "metalplate", "bandage" }
    },
    [ "npc_vj_hla_hcrab" ] = { 
        minItems = 1,
        maxItems = 1,
        name = 'Headcrab Corpse',
		description = 'A small deceased alien creature.',
        items = { "headcrab_meat" }
    },
	[ "npc_vj_hla_bcrab" ] = { 
        minItems = 1,
        maxItems = 1,
        name = 'Headcrab Corpse',
		description = 'A small deceased alien creature.',
        items = { "headcrab_meat" }
	},
    [ "npc_vj_hla_rcrab" ] = { 
        minItems = 1,
        maxItems = 1,
        name = 'Headcrab Corpse',
		description = 'A small deceased alien creature.',
        items = { "headcrab_meat" }
	},
	[ "npc_bullsquid_amphibious" ] = { 
        minItems = 1,
        maxItems = 1,
        name = 'Bullsquid Corpse',
		description = 'A large deceased alien creature.',
        items = { "bullsquid_meat" }
	},
   	[ "npc_bullsquid" ] = { 
        minItems = 1,
        maxItems = 1,
        name = 'Bullsquid Corpse',
		description = 'A large deceased alien creature.',
        items = { "bullsquid_meat" }
	},
   	[ "npc_vj_hl2beta_houndeye" ] = { 
        minItems = 1,
        maxItems = 1,
        name = 'Houndeye Corpse',
		description = 'A large deceased alien creature.',
        items = { "houndeye_meat" }
	}
    
}

ix.config.Add("corpseSearchTime", 8, "How long it takes to search a body.", nil, { --Added since we aren't using the persistant_corpses plugin 
	data = {min = 0, max = 30},
	category = "Interaction"
})

if ( SERVER ) then
    util.AddNetworkString( "ixLootRagdollCreated" )
end

ix.inventory.Register( "NPCLootStorage", 4, 3 )

function PLUGIN:PlayerSpawnedNPC( player, npc )
    --so.... NPC created ragdolls don't exist on the server by default.
    --This makes them create an entity when they die, and calls 'CreateEntityRagdoll', those two, in tandem with OnNPCKilled are the core tickers in this plugin.
    npc:SetShouldServerRagdoll( true )
end

function PLUGIN:PlayerUse( player, entity )
    --do all these checks because PlayerUse tends to be pretty pricey sometimes.
    if not ( IsValid( entity ) ) then return end
    if ( entity:GetClass( ) ~= "prop_ragdoll" ) then return end
    if not ( entity:GetNetVar( "loot", false ) ) then return end
    if not ( entity:GetNetVar( "ixInventory", false ) ) then return end

    if ( entity.nextUse and entity.nextUse < CurTime( ) ) or not entity.nextUse then
        entity.nextUse = CurTime( ) + 2
        local inventory = ix.item.inventories[ entity:GetNetVar( "ixInventory" ) ]

        ix.storage.Open( player, inventory, {
            entity = entity,
            name = "Corpse",
            searchText = "@searchingCorpse",
            searchTime = ix.config.Get( "corpseSearchTime", 1 )
        } )
        --bMultipleUsers = true
    end
end

function PLUGIN:CreateEntityRagdoll(owner, ragdoll)
    if not ( owner:IsNPC() ) then return end
    if not ( IsValid( ragdoll ) ) then return end
    local plg = ix.plugin.list[ 'npc_loot_drops' ] -- fuck you
    local cacheNPC = owner:GetClass( ) --the NPC object itself is irrelevant, it's class is.
    if not ( plg.LootTable[ cacheNPC ] ) then return end --pce
    ragdoll:SetCollisionGroup( COLLISION_GROUP_WEAPON ) --Allow players to pick them up, don't collide with each other, don't collide with players.

    ix.inventory.New( 0, "NPCLootStorage", function( inventory )
        ragdoll:SetNetVar( "ixInventory", inventory:GetID( ) )
        ragdoll:SetNetVar( "loot", true )
        ragdoll:SetNetVar( "npcClass", cacheNPC )
        local lootTable = plg.LootTable[ cacheNPC ]
        local items = ( lootTable.maxItems ~= 0 and math.random( lootTable.minItems, lootTable.maxItems ) or 0 )

        if ( items > 0 ) then
            for i = 1, items do
                local item = table.Random( lootTable.items )
                inventory:Add( item )
            end
        end

        net.Start( "ixLootRagdollCreated" )
        net.WriteEntity( ragdoll )
        net.Broadcast()
    end )
end

if ( CLIENT ) then
    function PLUGIN:PopulateEntityInfo( entity, tooltip )
        if not ( entity:IsRagdoll() ) then return end
        if not ( entity:GetNetVar( "loot", false ) ) then return end
        local corpseName = tooltip:AddRow( 'name' )
        corpseName:SetText( self.LootTable[ entity:GetNetVar( "npcClass", "???" ) ].name )
        corpseName:SetImportant( true )
        corpseName:SizeToContents( )
        local corpseCanLoot = tooltip:AddRow( "description" )
        corpseCanLoot:SetText( self.LootTable[ entity:GetNetVar( "npcClass", "???" ) ].description )
        corpseCanLoot:SizeToContents( )
    end
end
