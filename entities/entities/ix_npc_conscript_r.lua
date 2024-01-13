AddCSLuaFile()

ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Rebel Conscript NPC"
ENT.Author = "Riggs.mackay"
ENT.Category = "HL2 RP"
ENT.UIName = "Rebel Conscript Vendor"
ENT.UIDesc = "The Rebel Conscript vendor is used to get your rank and divison."

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.bNoPersist = true

if ( SERVER ) then
    util.AddNetworkString("ixRankNPC.OpenMenu")
    
    function ENT:Initialize()
        self:SetModel("models/litenetwork/conscript_masked.mdl")
        self:SetHullType(HULL_HUMAN)
        self:SetHullSizeNormal()
        self:SetSolid(SOLID_BBOX)
        self:SetUseType(SIMPLE_USE)
        self:DropToFloor()
    end

    function ENT:Use(ply)
        if ( ply:Team() == FACTION_CONSCRIPT ) then
            net.Start("ixRankNPC.OpenMenu")
            net.Send(ply)
        end
    end

    function ENT:SpawnFunction(ply, trace)
        local angles = ply:GetAngles()

        local entity = ents.Create("ix_npc_conscript_r")
        entity:SetPos(trace.HitPos)
        entity:SetAngles(Angle(0, (entity:GetPos() - ply:GetPos()):Angle().y - 180, 0))
        entity:Spawn()
        entity:Activate()

        Schema:SaveRankNPCs()
        return entity
    end

    function ENT:OnRemove(ent)
        Schema:SaveRankNPCs()
    end
end
