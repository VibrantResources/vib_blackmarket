MoneyLaundering = {}

CreateThread(function()
    for k, v in pairs(Config.Laundering) do
        local launderPed = CreatePed(1, v.pedModel, v.location.x, v.location.y, v.location.z, v.location.w, true, true)
        Wait(100)
        local serverEntity = NetworkGetNetworkIdFromEntity(launderPed)

        if v.animInfo.active then
            TaskPlayAnim(launderPed, v.animInfo.dict, v.animInfo.clip, 4.0, 4.0, -1, 1, false, false, false, false)
        end

        MoneyLaundering[k] = {
            entity = launderPed,
            currentlyLaundering = false,
            networkId = serverEntity,
        }
    end

    print(json.encode(MoneyLaundering, {indent = true}))
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(MoneyLaundering) do
            if DoesEntityExist(v.entity) then
                DeleteEntity(v.entity)
                print("Deleted: ", json.encode(k, {indent = true}))
            end
        end
    end
end)

lib.callback.register('blackmarket:server:GetLaunderInfo', function(source)

    return MoneyLaundering
end)