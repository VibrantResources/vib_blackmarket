RegisterNetEvent('blackmarket:VehiclesMenu', function(data)
    local player = cache.ped
    local playerJob = lib.callback.await('blackmarket:server:GetPlayerJob', false)
    
    if playerJob == "police" then
        PlayPedAmbientSpeechNative(data.entity, 'GENERIC_FUCK_YOU', 'Speech_Params_Force')
        QBCore.Functions.Notify("I don't talk to cops", "error", 3500)
        
        return
    end

    local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Vehicle Respray",
        event = "blackmarket:client:ResprayVehicle",
        description = "Respray your car",
        args = {
            info = data,
        },
    }

    lib.registerContext({
        id = 'vehicle_main_menu',
        title = "Vehicle Respray",
        options = headerMenu
    })

    lib.showContext('vehicle_main_menu')
end)