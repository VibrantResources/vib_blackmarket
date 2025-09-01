RegisterNetEvent('blackmarket:LaunderMenu', function(data)
    local player = cache.ped
    local headerMenu = {}

    PlayPedAmbientSpeechNative(data.args.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')

    headerMenu[#headerMenu + 1] = {
        title = "Launder Money",
        description = "How much do you want to launder",
        event = 'blackmarket:client:LaunderInput',
        args = {
            entity = data.args.entity,
            launderInfo = data.args.launderInfo,
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