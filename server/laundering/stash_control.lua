local activeCleaners = {}

local swapHook = exports.ox_inventory:registerHook('swapItems', function(payload)
    if payload.toType == 'player' then
        return
    end

    local machine = placedMachines[payload.toInventory]
    if not machine then
        return
    end

    local itemName = payload.fromSlot.name
    if itemName ~= Config.DirtyMoneyItem then
        return
    end

    local itemInfo = payload.fromSlot
    if not itemInfo then
        return
    end

    if activeCleaners[machine.machineId] then
        return
    end
    activeCleaners[machine.machineId] = true
    TriggerClientEvent('moneywash:client:TriggerWashingPTFX', payload.source, true, machine.coords)

    CreateThread(function()
        while true do
            Wait(math.random(3000, 8000))

            if not placedMachines[machine.machineId] then
                print("The money machine doesn't exist in the table anymore")

                return
            end

            local dirtyMoneyFound = exports.ox_inventory:Search(payload.toInventory, 'slots', Config.DirtyMoneyItem)

            if not dirtyMoneyFound then
                TriggerClientEvent('moneywash:client:TriggerWashingPTFX', payload.source, false, machine.coords)
                activeCleaners[machine.machineId] = nil

                lib.notify(payload.source, {
                    title = 'Finished',
                    description = "Your machine has no more "..Config.DirtyMoneyItem.." to wash",
                    type = 'success'
                })

                return
            end
            local randomAmount = math.random(2, 4)
            if exports.ox_inventory:RemoveItem(payload.toInventory, Config.DirtyMoneyItem, randomAmount, false) then
                local placed = false
                local machineInventory = exports.ox_inventory:GetInventoryItems(payload.toInventory)

                for _, v in pairs(machineInventory) do
                    if v.name == Config.CleanMoneyItem then
                        exports.ox_inventory:AddItem(payload.toInventory, Config.CleanMoneyItem, 2, nil, v.slot)
                        placed = true
                        break
                    end
                end

                if not placed then
                    local emptySlot = exports.ox_inventory:GetEmptySlot(payload.toInventory)
                    if not emptySlot then
                        activeCleaners[machine.machineId] = nil

                        lib.notify(payload.source, {
                            title = 'Finished',
                            description = "There's no space left in your machine",
                            type = 'inform'
                        })

                        return
                    end
                    exports.ox_inventory:AddItem(payload.toInventory, Config.CleanMoneyItem, 2, nil, emptySlot)
                end
            else
                TriggerClientEvent('moneywash:client:TriggerWashingPTFX', payload.source, false, machine.coords)
                activeCleaners[machine.machineId] = nil

                return
            end
        end
    end)
end)