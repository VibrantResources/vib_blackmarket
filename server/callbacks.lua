lib.callback.register('blackmarket:server:GetPlayerJob', function(source)
    local player = QBCore.Functions.GetPlayer(source)
    if not player then
        return
    end
    
    local playerJob = player.PlayerData.job.name

    return playerJob
end)

lib.callback.register('blackmarket:server:GetRandomEntranceLocation', function(source)
    local player = QBCore.Functions.GetPlayer(source)

    if not player then
        return
    end

    return entranceLocation
end)

lib.callback.register('blackmarket:server:AttachCar', function(source, vehicleToAttach)
    local player = QBCore.Functions.GetPlayer(source)

    if not player then
        return
    end

    if not isCarAttached then
        isCarAttached = vehicleToAttach

        return true
    end

    if isCarAttached then
        lib.notify(source, {
            title = 'Unable',
            description = "Wait your turn like everyone else",
            type = 'error'
        })

        return false
    end
end)