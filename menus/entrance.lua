RegisterNetEvent('blackmarket:EntranceMenu', function(data)
    local playerJob = lib.callback.await('blackmarket:server:GetPlayerJob', false)
    
    if playerJob == "police" then
        PlayPedAmbientSpeechNative(data.entity, 'GENERIC_FUCK_YOU', 'Speech_Params_Force')
        lib.notify({
            title = 'Unable',
            description = 'I aint talking to no bitch ass cop',
            type = 'error',
        })
        return
    end

    PlayPedAmbientSpeechNative(data.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')

    local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Welcome",
        description = "Answer riddle",
        event = "blackmarket:RiddleInput",
        icon = 'fa-solid fa-question',
        iconColor = "yellow",
    }

    lib.registerContext({
        id = 'entrance_menu',
        title = "Market Entrance",
        options = headerMenu
    })

    lib.showContext('entrance_menu')
end)