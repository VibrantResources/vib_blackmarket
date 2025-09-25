RegisterNetEvent('blackmarket:client:LaunderInput', function(data, clientEntity)
    local player = cache.ped
    local moneyAmount = exports.ox_inventory:Search('count', Config.DirtyMoneyItem)

    if moneyAmount <= 0 then
        lib.notify({
            title = 'Unable',
            description = "You don't have any money for me",
            type = 'error'
        })

        return
    end

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

    TriggerServerEvent('blackmarket:server:BeginLaundering', data.launderInfo, input[1], clientEntity)
end)