AddCSLuaFile()

SWEP.Base = "ls_base_projectile"

SWEP.PrintName = "Grenade"
SWEP.Category = "HL2 RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "slam"

SWEP.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.ViewModelFOV = 60

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.Primary.Sound = ""
SWEP.Primary.Recoil = 0
SWEP.Primary.Delay = 0.8
SWEP.Primary.HitDelay = 0.1

SWEP.Primary.Ammo = "Grenade"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1

SWEP.Projectile = {}
SWEP.Projectile.Model = "models/weapons/w_grenade.mdl"
SWEP.Projectile.HitSound = "Weapon_Greande.Bounce"
SWEP.Projectile.Touch = false
SWEP.Projectile.ForceMod = 0.5
SWEP.Projectile.Timer = 3
SWEP.Projectile.RemoveWait = 2

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
end

function SWEP:ProjectileFire()
    local pos = self:GetPos()
    local owner = self:GetOwner()

    if not ( IsValid(owner) ) then return end

    if ( SERVER ) then
        if not ( IsValid(self) ) then
            return
        end

        local explodeEnt = ents.Create("env_explosion")
        explodeEnt:SetPos(self:GetPos())

        if IsValid(self.placer) then
            explodeEnt:SetOwner(self.placer)
        end 

        explodeEnt:Spawn()
        explodeEnt:SetKeyValue("iMagnitude", "150")
        explodeEnt:SetKeyValue("iRadiusOverride", "384")
        explodeEnt:Fire("explode", "", 0)

        local fire = ents.Create("env_fire")
        fire:SetPos(self:GetPos())
        fire:Spawn()
        fire:Fire("StartFire")

        timer.Simple(60, function()
            if ( IsValid(fire) ) then
                fire:Remove()
            end
        end)

        local effectData = EffectData()
        effectData:SetOrigin(self:GetPos())
        util.Effect("Explosion", effectData)

        util.ScreenShake(self:GetPos(), 4, 2, 2.5, 1000)

        for k, v in pairs(ents.FindInSphere(self:GetPos(), 256)) do
            if ( v:GetClass() == "prop_door_rotating" ) and ( self:IsInRoom(v) ) then
                local Door = ents.Create("prop_physics")
                local TargetDoorsPos = v:GetPos()
                Door:SetAngles(v:GetAngles())
                Door:SetPos(v:GetPos() + v:GetUp())
                Door:SetModel(v:GetModel())
                Door:SetSkin(v:GetSkin())
                Door:SetCollisionGroup(0)
                Door:SetRenderMode(RENDERMODE_TRANSALPHA)
                v:Fire("unlock")
                v:Fire("openawayfrom", self.Owner:UniqueID()..CurTime())
                v:SetCollisionGroup(20)
                v:SetRenderMode(10)
                Door:Spawn()
                Door:EmitSound("/physics/wood/wood_crate_break"..math.random(1, 4)..".wav" , 80, 50, 1)
                Door:GetPhysicsObject():ApplyForceCenter(Door:GetForward() * 1000)
                v.canbeshot = false
                v:SetPos(v:GetPos() + Vector(0,0,-1000))
                timer.Simple(ix.config.Get("Respawn Timer", 60), function()
                    if ( IsValid(v) and IsValid(Door) ) then
                        v:SetCollisionGroup(0)
                        v:SetRenderMode(0)
                        v.bHindge2 = false
                        v.bHindge1 = false
                        v:SetPos(v:GetPos() - Vector(0,0,-1000))
                        if ( Door ) then
                            Door:Remove()
                            v.canbeshot = true
                        end
                    end
                end)
            end
        end
    end
    
    self:Remove()
end

sound.Add({
    name = "Weapon_Greande.Explode",
    sound = {
        "weapons/explode3.wav",
        "weapons/explode4.wav",
        "weapons/explode5.wav",
    },
    channel = CHAN_WEAPON,
    level = 80,
    pitch = {85, 115}
})

sound.Add({
    name = "Weapon_Greande.Bounce",
    sound = {
        "physics/metal/metal_grenade_impact_hard1.wav",
        "physics/metal/metal_grenade_impact_hard2.wav",
        "physics/metal/metal_grenade_impact_hard3.wav",
    },
    channel = CHAN_WEAPON,
    level = 70
})