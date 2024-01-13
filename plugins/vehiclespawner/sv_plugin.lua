local PLUGIN = PLUGIN

function PLUGIN:Think()
    if not ( simfphys ) then return end
    if ( ( ix.vehicleSpawner.cooldown or 0 ) > CurTime() ) then return end

    if ( #ix.vehicleSpawner.Config.spawnVectors == 0 ) then return end
    if ( #ix.vehicleSpawner.Config.vehicles == 0 ) then return end
    if ( #ents.FindByClass("gmod_sent_vehicle_fphysics_base") >= ix.config.Get("vehicleSpawnerMax", 2) ) then return end

    print("Spawning vehicles...")

    local spawns = table.Random(ix.vehicleSpawner.Config.spawnVectors)
    local vehicle = simfphys.SpawnVehicleSimple(table.Random(ix.vehicleSpawner.Config.vehicles), spawns.pos, spawns.ang)

    ix.vehicleSpawner.cooldown = CurTime() + ix.config.Get("vehicleSpawnerTime", 120)
end