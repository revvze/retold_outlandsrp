local PUGIN = PLUGIN

PLUGIN.name = "Item Cleaner"
PLUGIN.description = "Adds a timer to clean up all dropped items in the map."
PLUGIN.author = "Riggs.mackay"

ix.itemCleaner = {}

if ( SERVER ) then
    function ix.itemCleaner:CleanItems()
        print("[item cleaner] Detected "..#ents.FindByClass("ix_item").." items.")

        for _, v in pairs(ents.FindByClass("ix_item")) do
            if ( IsValid(v) ) then
                v:EmitSound("physics/cardboard/cardboard_box_break"..math.random(1, 3)..".wav")

                local position = v:LocalToWorld(v:OBBCenter())
                local effect = EffectData()
                    effect:SetStart(position)
                    effect:SetOrigin(position)
                    effect:SetScale(3)
                util.Effect("GlassImpact", effect)

                SafeRemoveEntity(v)
            end
        end

        for _, v in pairs(player.GetAll()) do
            if ( IsValid(v) ) then
                v:Notify("All dropped items have been removed automatically.")
            end
        end
    end

    function ix.itemCleaner:CreateTimer()
        timer.Create("ixItemCleaner", ix.config.Get("itemCleanerTimer", 1800), 0, function()
            timer.Simple(10, function()
                ix.itemCleaner:CleanItems()
            end)

            for _, v in pairs(player.GetAll()) do
                if ( IsValid(v) ) then
                    v:Notify("All dropped items will be removed automatically, in 10 seconds.")
                end
            end
        end)
    end

    function PLUGIN:InitPostEntity()
        if ( timer.Exists("ixItemCleaner") ) then return end

        ix.itemCleaner:CreateTimer()
    end
end

ix.config.Add("itemCleanerTimer", 1800, "Depends how long it should take for dropped items to be removed automatically in the map.", function()
    if ( timer.Exists("ixItemCleaner") ) then
        timer.Remove("ixItemCleaner")

        if ( SERVER ) then
            if ( ix.itemCleaner ) then
                ix.itemCleaner:CreateTimer()
            else
                print("[item cleaner] ix.itemCleaner is not loaded.")
            end
        end

        print("[item cleaner] Removed old timer and created new one.")
    end
end, {
    category = PLUGIN.name,
    data = {
        decimals = 0,
        min = 60,
        max = 3600,
    },
})