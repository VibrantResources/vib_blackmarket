RegisterNetEvent('blackmarket:LaunderMenu', function(launderInfo, clientEntity)
    local player = cache.ped
    local headerMenu = {}

    PlayPedAmbientSpeechNative(clientEntity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')

    headerMenu[#headerMenu + 1] = {
        title = "Launder Money",
        description = "How much do you want to launder",
        event = 'blackmarket:client:LaunderInput',
        args = {
            entity = clientEntity,
            launderInfo = launderInfo,
        },
        icon = 'fa-solid fa-question',
        iconColor = "yellow",
    }

    lib.registerContext({
        id = 'laundering_main_menu',
        title = "Laundering",
        options = headerMenu
    })

    lib.showContext('laundering_main_menu')
end)