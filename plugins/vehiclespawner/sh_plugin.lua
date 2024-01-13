local PLUGIN = PLUGIN

PLUGIN.name = "Vehicle Spawner"
PLUGIN.description = "Spawns random selected vehicles around certain specific locations."
PLUGIN.author = "Riggs.mackay"

ix.config.Add("vehicleSpawnerTime", 120, "Time in seconds between vehicle spawns.", nil, {
    category = PLUGIN.name,
    data = {
        decimals = 0,
        min = 10,
        max = 3600,
    },
})

ix.config.Add("vehicleSpawnerMax", 4, "How many vehicles there should be spawned in the map.", nil, {
    category = PLUGIN.name,
    data = {
        decimals = 0,
        min = 1,
        max = 20,
    },
})

ix.vehicleSpawner = ix.vehicleSpawner or {}
ix.vehicleSpawner.Config = {
    vehicles = { -- simfphys vehicles only!
        "hatchback_a01al",
        "Volga Gaz 24",
        "hatchback_a03al",
    	"sim_fphys_pwgaz52",
    },
    spawnVectors = {
        {
            pos = Vector(7911.75, 1380.52, -2265.55),
            ang = Angle(1.88, -44.96, 0)
        },
   		{
            pos = Vector(-4614.42, 4703.04, -2359.45),
            ang = Angle(1.35, 91.27, 0)
        },
    	{
            pos = Vector(8434.47, 9463.53, -1994.59),
            ang = Angle(-0.89, 82.95, 0)
        },
   		{
            pos = Vector(-10921.61, -257.07, -2643.24),
            ang = Angle(0.82, 69.26, 0)
        },
    	{
            pos = Vector(-4510.805664, -307.781921, -2327.199219),
            ang = Angle(5.439913, 103.451721, 0)
        },
    	{
            pos = Vector(1693.618042, -9646.289063, -1322.169434),
            ang = Angle(5.703932, 87.971748, 0)
        },
    },
}

ix.util.Include("sv_plugin.lua")
