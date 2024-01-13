-- Rank NPC
function Schema:SaveRankNPCs()
    local data = {}

    for _, v in ipairs(ents.FindByClass("ix_npc_*")) do
        data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetModel(), v:GetClass()}
    end

    ix.data.Set("rankNPCs", data)
end

function Schema:LoadRankNPCs()
    for _, v in ipairs(ix.data.Get("rankNPCs") or {}) do
        local rankNPCs = ents.Create(v[4])

        rankNPCs:SetPos(v[1])
        rankNPCs:SetAngles(v[2])
        rankNPCs:SetModel(v[3])
        rankNPCs:Spawn()
    end
end

-- Combine Terminal
function Schema:SaveCombineTerminals()
    local data = {}

    for _, v in ipairs(ents.FindByClass("ix_terminal")) do
        data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetModel()}
    end

    ix.data.Set("combineTerminal", data)
end

function Schema:LoadCombineTerminals()
    for _, v in ipairs(ix.data.Get("combineTerminal") or {}) do
        local combineTerminal = ents.Create("ix_terminal")

        combineTerminal:SetPos(v[1])
        combineTerminal:SetAngles(v[2])
        combineTerminal:SetModel(v[3])
        combineTerminal:Spawn()
    end
end

-- Rebel Locker
function Schema:SaveRebelLockers()
    local data = {}

    for _, v in ipairs(ents.FindByClass("ix_rebel_locker")) do
        data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetModel()}
    end

    ix.data.Set("rebelLocker", data)
end

function Schema:LoadRebelLockers()
    for _, v in ipairs(ix.data.Get("rebelLocker") or {}) do
        local rebelLocker = ents.Create("ix_rebel_locker")

        rebelLocker:SetPos(v[1])
        rebelLocker:SetAngles(v[2])
        rebelLocker:SetModel(v[3])
        rebelLocker:Spawn()
    end
end

-- Ration Machine
function Schema:SaveRationMachines()
    local data = {}

    for _, v in ipairs(ents.FindByClass("ix_ration_machine")) do
        data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetModel()}
    end

    ix.data.Set("rationMachines", data)
end

function Schema:LoadRationMachines()
    for _, v in ipairs(ix.data.Get("rationMachines") or {}) do
        local rationMachine = ents.Create("ix_ration_machine")

        rationMachine:SetPos(v[1])
        rationMachine:SetAngles(v[2])
        rationMachine:SetModel(v[3])
        rationMachine:Spawn()
    end
end

-- Campfire
function Schema:SaveCampfire()
    local data = {}

    for _, v in pairs(ents.FindByClass("ix_campfire")) do
        data[#data + 1] = {v:GetPos(), v:GetAngles()}
    end

    ix.data.Set("campfires", data)
end

function Schema:LoadCampfire()
    for _, v in pairs(ix.data.Get("campfires")) do
        local miningEntity = ents.Create("ix_campfire")
        miningEntity:SetPos(v[1])
        miningEntity:SetAngles(v[2])
        miningEntity:Spawn()
    end
end

-- Data Saving
function Schema:SaveData()
    self:SaveRankNPCs()
    self:SaveCombineTerminals()
    self:SaveRebelLockers()
    self:SaveRationMachines()
    self:SaveCampfire()
end

-- Data Loading
function Schema:LoadData()
    self:LoadRankNPCs()
    self:LoadCombineTerminals()
    self:LoadRebelLockers()
    self:LoadRationMachines()
    self:LoadCampfire()
end