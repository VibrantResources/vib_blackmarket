RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local launderLocations = lib.callback.await('blackmarket:server:GetLaunderInfo', false)

    for k, v in pairs(launderLocations) do
        Wait(300)
        local clientEntity = NetworkGetEntityFromNetworkId(v.networkId)

        exports.ox_target:addLocalEntity(clientEntity, {
            {
                label = 'Speak',
                event = 'blackmarket:LaunderMenu',
                args = {
                    launderInfo = v,
                    entity = clientEntity,
                },
                icon = 'fa-solid fa-comment-dots',
                iconColor = 'yellow',
                distance = 2,
            },
        })
    end
end)

RegisterNetEvent('blackmarket:client:LaunderInput', function()
    local player = cache.ped
    local moneyAmount = exports.ox_inventory:Search('count', Config.DirtyMoneyItem)

    local input = lib.inputDialog("Laundering", {
        {
            type = "input",
            label = "Choose how much money to launder",
            min = 1,
            max = moneyAmount,
            required = true,
            icon = "fa-solid fa-question",
            iconColor = "yellow",
        },
    })

    if not input or not input[1] then
        return
    end
end)