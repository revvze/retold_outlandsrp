local PLAYER = FindMetaTable("Player")

function PLAYER:CanBecomeTeamClass(classID, bNotify)
    local teamData = ix.faction.Get(self:Team())
    local classData = teamData.classes[classID]
    local classPlayers = 0

    if not ( self:Alive() ) then
        return false
    end

    if ( classData.whitelistUID ) and not ( self:ixHasWhitelist(classData.whitelistUID) ) then
        if ( self:IsSuperAdmin() ) then
            self:Notify("You bypassed the whitelist restriction.")
            return true
        end

        local add = classData.whitelistFailMessage or ""
        if ( bNotify ) then
            self:Notify("You must be whitelisted to play as this class. "..add)
        end

        return false
    end

    if ( classData.xp ) and ( classData.xp > self:GetXP() ) then
        if ( self:IsSuperAdmin() ) then
            self:Notify("You bypassed the XP limit.")
            return true
        end

        if ( bNotify ) then
            self:Notify("You don't have the XP required to play as this class.")
        end

        return false
    end

    if ( classData.limit ) then
        local classPlayers = 0 

        for k, v in pairs(team.GetPlayers(self:Team())) do
            if ( v:GetTeamRank() == classID ) then
                classPlayers = classPlayers + 1
            end
        end

        if ( classData.percentLimit ) and ( classData.percentLimit == true ) then
            local percentRank = classPlayers / #player.GetAll()

            if ( percentRank ) > ( classData.limit ) then
                if ( bNotify ) then
                    self:Notify(classData.name .. " is full.")
                end

                return false
            end
        else
            if ( classPlayers ) > ( classData.limit ) then
                if ( bNotify ) then
                    self:Notify(classData.name .. " is full.")
                end

                return false
            end
        end
    end

    if ( classData.customCheck ) then
        local results = classData.customCheck(self, classData)

        if ( results == false ) then
            return false
        end
    end

    return true
end

function PLAYER:CanBecomeTeamRank(rankID, bNotify)
    local teamData = ix.faction.Get(self:Team())
    local rankData = teamData.ranks[rankID]
    local rankPlayers = 0

    if not ( self:Alive() ) then
        return false
    end

    if ( rankData.whitelistUID ) and not ( self:ixHasWhitelist(rankData.whitelistUID) ) then
        if ( self:IsSuperAdmin() ) then
            self:Notify("You bypassed the whitelist restriction.")
            return true
        end

        local add = rankData.whitelistFailMessage or ""
        if ( bNotify ) then
            self:Notify("You must be whitelisted to play as this rank. "..add)
        end

        return false
    end

    if ( rankData.xp ) and ( rankData.xp > self:GetXP() ) then
        if ( self:IsSuperAdmin() ) then
            self:Notify("You bypassed the XP limit.")
            return true
        end

        if ( bNotify ) then
            self:Notify("You don't have the XP required to play as this rank.")
        end

        return false
    end

    if ( rankData.limit ) then
        local rankPlayers = 0 

        for k, v in pairs(team.GetPlayers(self:Team())) do
            if ( v:GetTeamRank() == rankID ) then
                rankPlayers = rankPlayers + 1
            end
        end

        if ( rankData.percentLimit ) and ( rankData.percentLimit == true ) then
            local percentRank = rankPlayers / #player.GetAll()

            if ( percentRank ) > ( rankData.limit ) then
                if ( bNotify ) then
                    self:Notify(rankData.name .. " is full.")
                end

                return false
            end
        else
            if ( rankPlayers ) > ( rankData.limit ) then
                if ( bNotify ) then
                    self:Notify(rankData.name .. " is full.")
                end

                return false
            end
        end
    end

    if ( rankData.customCheck ) then
        local results = rankData.customCheck(self, rankData.name)

        if ( results == false ) then
            return false
        end
    end

    return true
end

function PLAYER:GetTeamClass()
    return self:GetLocalVar("ixClass", 0)
end

function PLAYER:GetTeamRank()
    return self:GetLocalVar("ixRank", 0)
end

if ( SERVER ) then
    local PLAYER = FindMetaTable("Player")

    function PLAYER:ixGiveWhitelist(uid)
        self:SetPData("whitelist-"..tostring(uid), true)
    end

    function PLAYER:ixTakeWhitelist(uid)
        self:SetPData("whitelist-"..tostring(uid), nil)
    end

    function PLAYER:ixHasWhitelist(uid)
        return self:GetPData("whitelist-"..tostring(uid), false)
    end
end