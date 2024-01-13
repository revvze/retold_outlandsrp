AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Ration Machine"
ENT.Author = "Riggs.mackay"
ENT.Category = "HL2 RP"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.bNoPersist = true

if ( SERVER ) then
    function ENT:Initialize()
        self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
        self:PhysicsInit(SOLID_VPHYSICS) 
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)

        self.dummy = ents.Create("prop_dynamic")
        self.dummy:SetPos(self:GetPos())
        self.dummy:SetAngles(self:GetAngles())
        self.dummy:SetModel("models/props_combine/combine_dispenser.mdl")
        self.dummy:SetParent(self)
        self.dummy:Spawn()

        local phys = self:GetPhysicsObject()
        if ( phys:IsValid() ) then
            phys:Wake()
            phys:EnableMotion(false)
        end
    end

    function ENT:Use(ply)
        local sequencedispense = self.dummy:LookupSequence("dispense_package")
       
        local pos = self.dummy:GetPos() + self.dummy:GetForward() * 15 + self.dummy:GetRight() * -6 + self.dummy:GetUp() * -6
        local ang = self.dummy:GetAngles()

        if not ( timer.Exists("ixRationMachine."..ply:SteamID64()) ) then
            ply:Notify("Dispensing ration...")
            self.dummy:EmitSound("ambient/machines/combine_terminal_idle4.wav")

            self.dummy:Fire("SetAnimation", "dispense_package", 0)

            timer.Simple(1.5, function()
                ix.item.Spawn("ration", pos, nil, ang)
            end)
            
            timer.Create("ixRationMachine."..ply:SteamID64(), 3600, 1, function()
                ply:Notify("You are now able to retrieve your ration.")
            end)
        else
            ply:Notify("You can get your next ration in "..string.NiceTime(timer.TimeLeft("ixRationMachine."..ply:SteamID64())).." seconds.")
            
            self.dummy:EmitSound("buttons/combine_button2.wav")
        end
    end

    function ENT:SpawnFunction(ply, trace)
        local angles = ply:GetAngles()

        local entity = ents.Create("ix_ration_machine")
        entity:SetPos(trace.HitPos)
        entity:SetAngles(Angle(0, (entity:GetPos() - ply:GetPos()):Angle().y - 180, 0))
        entity:Spawn()
        entity:Activate()

        Schema:SaveData()
        return entity
    end

    function ENT:OnRemove()
        Schema:SaveData()
    end
else
    function ENT:Draw()
    end
end