RegisterNetEvent('moneywash:client:CreateTargetForMachine', function(machineInfo)
    Wait(250)
    local player = cache.ped
    local cEntity = NetworkGetEntityFromNetworkId(machineInfo.cEntity)

    exports.ox_target:addLocalEntity(cEntity,  {
        {
            name = machineInfo.id,
            label = "Count Money",
            icon = 'fa-solid fa-cart-shopping',
            onSelect = function()
                Wait(100)
                exports.ox_inventory:openInventory('stash', machineInfo.id)
            end,
            distance = 1.5,
        }
    })
end)