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
    local ptfxAsset = lib.requestNamedPtfxAsset('core')
    isSpraying = true
    FreezeEntityPosition(playerVehicle, true)
    TaskLeaveVehicle(player, playerVehicle, 0)

    -- Find correct PTFX to cover the car changing colours

    CreateThread(function()
        while true do
            Wait(250)

            if not isSpraying then
                break
            end

            UseParticleFxAssetNextCall(ptfxAsset)
            local ptfx = StartNetworkedParticleFxNonLoopedAtCoord('ent_amb_smoke_general', vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
        end
    end)

    Wait(resprayDuration)

    SetVehicleColours(playerVehicle, math.random(1, 159), math.random(1, 159))
    RemovePtfxAsset(ptfxAsset)
    isSpraying = false
    FreezeEntityPosition(playerVehicle, false)
end)