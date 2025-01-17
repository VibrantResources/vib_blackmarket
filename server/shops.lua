local swapHook = exports.ox_inventory:registerHook('swapItems', function(payload)
    if payload.toType == 'player' then
        return
    end

    if payload.toInventory == GetStoreName(payload.toInventory) then
        local itemName = payload.fromSlot.name
        local itemInfo = getItemPrice(itemName, payload)

        if not itemInfo then
            return
        end

        CreateThread(function()
            Wait(250)
            if exports.ox_inventory:RemoveItem(payload.toInventory, itemInfo.name, payload.count, false, payload.fromSlot.slot) then  
                exports.ox_inventory:AddItem(payload.source, Config.DirtyMoneyItem, (itemInfo.value * payload.count))
            end 
        end)
    end
end)

function getItemPrice(itemName, payload)
    local store = nil
    local itemInfo = nil

    for _, v in pairs(Config.Shops) do
        if v.Name == payload.toInventory then
            
            store = v
        end
    end

    for _, v in pairs(store.SellableItems) do
        if v.name == itemName then
            itemInfo = v
        end
    end

    if itemInfo == nil then
        lib.notify(payload.source,{
            title = payload.toInventory.." seller",
            description = "I'm not willing to buy that from you, come back when you have something I can use",
            type = 'error'
        }) 

        return
    end

    return itemInfo
end

function GetStoreName(storeName)
    for k, v in pairs(Config.Shops) do
        if v.Name == storeName then
            
            return storeName
        end
    end
end