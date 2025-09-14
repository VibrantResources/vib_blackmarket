RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local launderLocations = lib.callback.await('blackmarket:server:GetLaunderInfo', false)

    for k, v in pairs(launderLocations) do
        Wait(300)
        exports.ox_target:addSphereZone({
            coords = vector3(v.location.x, v.location.y, v.location.z+1),
            radius = 0.8,
            debug = Config.Debug,
            options = {
                {
                    label = 'Speak',
                    onSelect = function()
                        Wait(300)
                        local clientEntity = NetworkGetEntityFromNetworkId(v.networkId)
                        SetBlockingOfNonTemporaryEvents(clientEntity, true)
                        SetEntityInvincible(clientEntity, true)

                        TriggerEvent('blackmarket:LaunderMenu', v, clientEntity)
                    end,
                    icon = "fa-solid fa-brain",
                    iconColor = "green",
                    distance = 2.0,
                },
            }
        })
    end
end)