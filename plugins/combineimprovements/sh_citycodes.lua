--[[---------------------------------------------------------------------------
    ** License: https://creativecommons.org/licenses/by-nc-nd/4.0/
    ** Copryright 2022 Riggs.mackay
    ** This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 4.0 Unported License.
---------------------------------------------------------------------------]]--

local PLUGIN = PLUGIN

ix.cityCode = ix.cityCode or {}
ix.cityCode.codes = ix.cityCode.codes or {}

--[[---------------------------------------------------------------------------
    City Code List
---------------------------------------------------------------------------]]--

ix.cityCode.codes = {
    ["event"] = {
        color = Color(250, 200, 0),
        name = "Event In Progress",
        description = [[]],
        OnCheckAccess = function(ply)
            return ( ply:IsAdmin() )
        end,
        OnStart = function()
        end,
        OnEnd = function()
        end,
    },
    ["shadow"] = {
        color = Color(150, 0, 0),
        name = "Shadow Raid",
        description = [[]],
        OnCheckAccess = function(ply)
            return ( ply:IsAdmin() )
        end,
        OnStart = function()
        end,
        OnEnd = function()
        end,
    },
    ["sweep"] = {
        color = Color(250, 200, 0),
        name = "Sweep",
        description = [[]],
        OnCheckAccess = function(ply)
            return ( ply:IsAdmin() )
        end,
        OnStart = function()
        end,
        OnEnd = function()
        end,
    },
    ["civil"] = {
        color = Color(0, 250, 0),
        name = "Civil",
        description = [[]],
        OnCheckAccess = function(ply)
            return ( ply:IsAdmin() )
        end,
        OnStart = function()
        end,
        OnEnd = function()
        end,
    },
}

-- You never know when you need it, Github copilot wrote this.
--[[---------------------------------------------------------------------------
    Name: ix.cityCode.GetAll()
    Desc: Returns a table of all codes.
---------------------------------------------------------------------------]]--

function ix.cityCode.GetAll()
    return ix.cityCode.codes
end

--[[---------------------------------------------------------------------------
    Name: ix.cityCode.GetCurrent()
    Desc: Returns the current code.
---------------------------------------------------------------------------]]--

function ix.cityCode.GetCurrent()
    return GetGlobalString("ixCityCode", "civil")
end

--[[---------------------------------------------------------------------------
    Name: ix.cityCode.Get()
    Desc: Returns a table of a specific code.
---------------------------------------------------------------------------]]--

function ix.cityCode.Get(id)
    return ix.cityCode.codes[id]
end

--[[---------------------------------------------------------------------------
    Name: ix.cityCode.GetColor()
    Desc: Returns a color of a specific code.
---------------------------------------------------------------------------]]--

function ix.cityCode.GetColor(id)
    return ix.cityCode.codes[id].color
end

--[[---------------------------------------------------------------------------
    Name: ix.cityCode.GetName()
    Desc: Returns a name of a specific code.
---------------------------------------------------------------------------]]--

function ix.cityCode.GetName(id)
    return ix.cityCode.codes[id].name
end

--[[---------------------------------------------------------------------------
    Name: ix.cityCode.GetDescription()
    Desc: Returns a description of a specific code.
---------------------------------------------------------------------------]]--

function ix.cityCode.GetDescription(id)
    return ix.cityCode.codes[id].description
end

--[[---------------------------------------------------------------------------
    Name: ix.cityCode.GetAccess()
    Desc: Returns a access function of a specific code.
---------------------------------------------------------------------------]]--

function ix.cityCode.GetAccess(id)
    return ix.cityCode.codes[id].OnCheckAccess
end
