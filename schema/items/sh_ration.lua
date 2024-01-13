ITEM.name = "Ration"
ITEM.model = Model("models/weapons/w_packatc.mdl")
ITEM.description = "A shrink-wrapped packet containing some food."

ITEM.functions.Open = {
    OnRun = function(itemTable)
        local ply = itemTable.player
        local char = ply:GetCharacter()

        for k, v in ipairs(ix.faction.indices[ply:Team()].rationItems or {"comfort_supplements", "drink_water"}) do
            if not ( char:GetInventory():Add(v) ) then
                ix.item.Spawn(v, ply)
            end
        end

        --char:GiveMoney(ix.faction.indices[ply:Team()].rationMoney or 50)
        ply:EmitSound("physics/cardboard/cardboard_box_break"..math.random(1,3)..".wav", nil, nil, 0.3)
    end
}
