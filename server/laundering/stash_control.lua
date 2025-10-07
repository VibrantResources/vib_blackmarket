local activeCleaners = {}

local swapHook = exports.ox_inventory:registerHook('swapItems', function(payload)
    if payload.toType == 'player' then
        return
    end

    local machine = GetMachineId(payload.toInventory)
    if payload.toInventory ~= machine.id then
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

    if activeCleaners[machine.id] then
        return
    end
    activeCleaners[machine.id] = true
    TriggerClientEvent('moneywash:client:TriggerWashingPTFX', payload.source, true, machine.coords)

    CreateThread(function()
        while true do
            Wait(math.random(Config.MoneyMachine.waitTimeBetweenRemovalInSeconds.min, Config.MoneyMachine.waitTimeBetweenRemovalInSeconds.max) * 1000)

            local invItems = exports.ox_inventory:GetInventoryItems(payload.toInventory)
            local dirtyMoneyFound = false

            for _, v in pairs(invItems) do
                if v.name == Config.DirtyMoneyItem then
                    dirtyMoneyFound = true
                    break
                end
            end

            if not dirtyMoneyFound then
                TriggerClientEvent('moneywash:client:TriggerWashingPTFX', payload.source, false, machine.coords)
                activeCleaners[machine.id] = nil

                lib.notify(payload.source, {
                    title = 'Finished',
                    description = "Your machine has no more marked bills to wash",
                    type = 'success'
                })
                return
            end
            local amountToRemove = math.random(Config.MoneyMachine.amountToRemove.min, Config.MoneyMachine.amountToRemove.max)
            if exports.ox_inventory:RemoveItem(payload.toInventory, Config.DirtyMoneyItem, amountToRemove, false) then
                local placed = false
                local machineInventory = exports.ox_inventory:GetInventoryItems(payload.toInventory)

                for _, v in pairs(machineInventory) do
                    if v.name == 'money' then
                        local amountToAdd = math.random(Config.MoneyMachine.amountToGive.min, Config.MoneyMachine.amountToGive.max)
                        exports.ox_inventory:AddItem(payload.toInventory, Config.CleanMoneyItem, amountToAdd, nil, v.slot)
                        placed = true
                        break
                    end
                end

                if not placed then
                    local emptySlot = exports.ox_inventory:GetEmptySlot(payload.toInventory)
                    if not emptySlot then
                        activeCleaners[machine.id] = nil

                        lib.notify(payload.source, {
                            title = 'Finished',
                            description = "There's no space left in your machine",
                            type = 'inform'
                        })

                        return
                    end
                    local amountToAdd = math.random(Config.MoneyMachine.amountToGive.min, Config.MoneyMachine.amountToGive.max)
                    exports.ox_inventory:AddItem(payload.toInventory, Config.CleanMoneyItem, amountToAdd, nil, emptySlot)
                end
            else
                TriggerClientEvent('moneywash:client:TriggerWashingPTFX', payload.source, false, machine.coords)
                activeCleaners[machine.id] = nil

                lib.notify(payload.source, {
                    title = 'Finished',
                    description = "You should check your money machine",
                    type = 'inform'
                })
                return
            end
        end
    end)
end)

function GetMachineId(machineId)
    for k, v in pairs(placedMachines) do
        if v.id == machineId then
            
            return v
        end
    end
end