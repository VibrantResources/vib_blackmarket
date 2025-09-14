MoneyLaundering = {}

CreateThread(function()
    for k, v in pairs(Config.Laundering) do
        local launderPed = CreatePed(1, v.pedModel, v.location.x, v.location.y, v.location.z, v.location.w, true, true)

        FreezeEntityPosition(launderPed, true)
        Wait(300)
        local serverEntity = NetworkGetNetworkIdFromEntity(launderPed)

        if v.animInfo.active then
            TaskPlayAnim(launderPed, v.animInfo.dict, v.animInfo.clip, 4.0, 4.0, -1, 1, false, false, false, false)
        end

        MoneyLaundering[v.launderName] = {
            launderName = v.launderName,
            entity = launderPed,
            networkId = serverEntity,
            location = v.location,
            currentlyLaundering = false,
            launderAmount = 0,
            launderPercentageLoss = v.percentageTakenFromPlayer,
            launderDuration = v.launderTimeInMinutes,
        }
    end
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

RegisterNetEvent('blackmarket:server:BeginLaundering', function(locationInfo, launderValue, clientEntity)
    local player = QBCore.Functions.GetPlayer(source)

    if exports.ox_inventory:RemoveItem(source, 'black_money', launderValue) then
        MoneyLaundering[locationInfo.launderName].currentlyLaundering = true
        MoneyLaundering[locationInfo.launderName].launderAmount = launderValue
    end

    print(json.encode(MoneyLaundering[locationInfo.launderName], {indent = true}))
end)