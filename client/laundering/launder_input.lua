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