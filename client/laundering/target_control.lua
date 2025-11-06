RegisterNetEvent('moneywash:client:CreateTargetForMachine', function(machineInfo)
    local player = cache.ped

    exports.ox_target:addEntity(machineInfo.netId,  {
        {
            name = machineInfo.machineId,
            label = "Count Money",
            icon = 'fa-solid fa-cart-shopping',
            onSelect = function()
                Wait(100)
                exports.ox_inventory:openInventory('stash', machineInfo.machineId)
            end,
            distance = 1.5,
        },
        {
            name = machineInfo.machineId,
            label = "Pick up",
            icon = 'fa-solid fa-cart-shopping',
            serverEvent = 'moneywash:server:PickUpMachine',
            args = machineInfo,
            distance = 1.5,
        }
    })
end)

RegisterNetEvent('moneywash:client:RemoveEntityTarget', function(machineId)
    local player = cache.ped

    exports.ox_target:removeEntity(machineId.netId)
end)