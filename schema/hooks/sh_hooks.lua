function Schema:CanDrive(ply, ent)
    return false
end

function Schema:PlayerFootstep(ply, pos, foot, sound, volume)
    if ( ply:GetModel():find("combine_heavy_trooper") ) then
        ply:EmitSound("interlock/player/combine/footsteps/charger/foley_step_0"..math.random(1,9)..".ogg", 60, math.random(90, 110), 0.7)
        ply:EmitSound("interlock/player/combine/footsteps/charger/step_layer_bass_0"..math.random(1,5)..".ogg", 90, math.random(90, 110), 0.8)
        ply:EmitSound("interlock/player/combine/footsteps/charger/step_layer_clink_0"..math.random(1,5)..".ogg", 80, math.random(90, 110), 0.6)
        ply:EmitSound(sound, 70, math.random(90, 110), 0.5)

        util.ScreenShake(pos, 1, 1, 1, 512)

        return true
    end
	
    local pitch = math.random(90.0, 110.0)
    local newVolume = volume / 1
	local newSound = ""

    if ( ply:KeyDown(IN_SPEED) ) then
        newVolume = volume * 1
    end

    if ( ply:IsCP() ) then
		newSound = "interlock/player/combine/footsteps/metrocop/foley_step_"..Schema:ZeroNumber(math.random(1,9), 2)..".ogg"
    elseif ( ply:IsIRT() ) then
		newSound = "interlock/player/combine/footsteps/combine/foley_step_"..Schema:ZeroNumber(math.random(1,9), 2)..".ogg"
        pitch = math.random(80.0, 90.0)
    elseif ( ply:IsOW() ) then
		newSound = "interlock/player/combine/footsteps/combine/foley_step_"..Schema:ZeroNumber(math.random(1,9), 2)..".ogg"
    elseif ( ply:IsConscript() ) then
        sound = "npc/conscript2/gear"..math.random(1,6)..".wav"
        pitch = math.random(80.0, 90.0)
    elseif ( ply:IsVortigaunt() ) then
        sound = "npc/vort/vort_foot"..math.random(1,4)..".wav"
    end

    if ( sound:find("dirt") or sound:find("grass") or sound:find("mud") or sound:find("sand") or sound:find("snow") ) then
        sound = "interlock/player/combine/footsteps/common/combine_dirt_step_"..Schema:ZeroNumber(math.random(1,10), 2)..".ogg"
    elseif ( sound:find("gravel") ) then
        sound = "interlock/player/combine/footsteps/common/combine_gravel_step_"..Schema:ZeroNumber(math.random(1,12), 2)..".ogg"
    elseif ( sound:find("chainlink") or sound:find("metalgrate") ) then
        sound = "interlock/player/combine/footsteps/common/combine_metal_walkway_step_"..Schema:ZeroNumber(math.random(1,10), 2)..".ogg"
    elseif ( sound:find("duct") or sound:find("metal") or sound:find("ladder") ) then
        sound = "interlock/player/combine/footsteps/common/combine_metal_solid_step_"..Schema:ZeroNumber(math.random(1,10), 2)..".ogg"
    elseif ( sound:find("wood") ) then
        sound = "interlock/player/combine/footsteps/common/combine_wood_step_"..Schema:ZeroNumber(math.random(1,8), 2)..".ogg"
    else
        sound = "interlock/player/combine/footsteps/common/combine_concrete_step_"..Schema:ZeroNumber(math.random(1,9), 2)..".ogg"
    end

    if not ( ply:WaterLevel() == 0 ) then
        newSound = "ambient/water/water_splash"..math.random(1,3)..".wav"
        sound = "ambient/water/rain_drip"..math.random(1,4)..".wav"
    end

    if ( SERVER ) then
        ply:EmitSound(newSound, 70, pitch, newVolume)
        ply:EmitSound(sound, 70, pitch, newVolume)
    end

    return true
end

function Schema:OnEntityCreated(ent)
    if ( IsValid(ent) ) then
        if ( ent:GetClass() == "prop_door_rotating" ) then
            ent:DrawShadow(false)
        elseif ( ent:GetClass() == "prop_ragdoll" ) then
            ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
        end
    end
end

function Schema:PlayerButtonDown(ply, key)
    if ( key == KEY_SPACE ) then
        if ( ply:GetNetVar("ixCurrentCamera", false) ) then
            if ( SERVER ) then
                ply:SetNetVar("ixCurrentCamera", false)
                ply:SetViewEntity(ply)
                ply:Freeze(false)
            else
                net.Start("ixScenePVSOff")
                net.SendToServer()
            end
        end
    end
end

function Schema:OnPlayerHitGround(ply)
    local vel = ply:GetVelocity()
    ply:SetVelocity(Vector(- ( vel.x * 0.4 ), - ( vel.y * 0.4 ), 0))
end

function Schema:IsCharacterRecognized()
    return true
end

function Schema:CanPlayerUseBusiness(ply)
    return false
end

function Schema:CanPlayerJoinClass()
    return false
end