RegisterNetEvent('blackmarket:client:ResprayVehicle', function()
    local player = cache.ped
    local playerVehicle = GetVehiclePedIsIn(player, false)
    local vehicleCoords = GetEntityCoords(playerVehicle)
    local isSpraying = false
    local resprayDuration = (Config.Experts.Vehicles.respray.LengthOfResprayInSeconds * 1000)

    if not playerVehicle or playerVehicle == 0 then
        lib.notify({
            title = 'Missing',
            description = "Where's your vehicle?",
            type = 'error'
        })

        return
    end

    local isVehicleAttached = lib.callback.await('blackmarket:server:AttachCar', false, playerVehicle)

    if not isVehicleAttached then
        lib.notify({
            title = 'Failed',
            description = "Failed to attach a vehicle",
            type = 'error'
        })

        return
    end

    FreezeEntityPosition(playerVehicle, true) -- Freeze the vehicle in place
    TaskLeaveVehicle(player, playerVehicle, 0) -- Make the player leave the vehicle normally

    SmoothChangeVehicleColorWithSmoke(playerVehicle, 15000)
end)