local PLUGIN = PLUGIN

PLUGIN.name = "Ammo Crate"
PLUGIN.description = "Self-Explanatory. Just a ammo crate."
PLUGIN.author = "Riggs.mackay"

PLUGIN.ammo = {
    ["AR2"] = 300,
    ["Pistol"] = 150,
    ["357"] = 32,
    ["Buckshot"] = 64,
    ["SMG1"] = 500,
}

if ( SERVER ) then
    function PLUGIN:SaveData()
        local data = {}
    
        for _, v in ipairs(ents.FindByClass("ix_ammocrate")) do
            data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetModel()}
        end
    
        ix.data.Set("ammoCrates", data)

        local data = {}
    
        for _, v in ipairs(ents.FindByClass("ix_ammocrate_combine")) do
            data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetModel()}
        end
    
        ix.data.Set("ammoCratesCombine", data)
    end

    function PLUGIN:LoadData()
        for _, v in ipairs(ix.data.Get("ammoCrates") or {}) do
            local ammoCrate = ents.Create("ix_ammocrate")
    
            ammoCrate:SetPos(v[1])
            ammoCrate:SetAngles(v[2])
            ammoCrate:SetModel(v[3])
            ammoCrate:Spawn()
        end

        for _, v in ipairs(ix.data.Get("ammoCratesCombine") or {}) do
            local ammoCrate = ents.Create("ix_ammocrate_combine")
    
            ammoCrate:SetPos(v[1])
            ammoCrate:SetAngles(v[2])
            ammoCrate:SetModel(v[3])
            ammoCrate:Spawn()
        end
    end
end