RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local launderLocations = lib.callback.await('blackmarket:server:GetLaunderInfo', false)

    print(json.encode(launderLocations, {indent = true}))
    for k, v in pairs(launderLocations) do
        local clientEntity = NetworkGetEntityFromNetworkId(v.networkId)
        print(k, ": ", clientEntity)
    end
end)