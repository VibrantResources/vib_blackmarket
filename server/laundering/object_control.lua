QBCore = exports["qb-core"]:GetCoreObject()
placedMachines = {}

RegisterNetEvent('moneywash:server:SetUpMachine', function(data, coords, heading)
    local player = QBCore.Functions.GetPlayer(source)

    if not player then
        return
    end

    if exports.ox_inventory:RemoveItem(source, Config.MoneyMachine.item, 1, nil, data.slot) then
        local spawnedMachine = CreateObjectNoOffset(Config.MoneyMachine.objectModel, coords.x, coords.y, coords.z, true, true, false)
        FreezeEntityPosition(spawnedMachine, true)
        SetEntityHeading(spawnedMachine, heading)
        local id = os.time() .. QBCore.Shared.RandomInt(3)
        Wait(250)
        local clientEntity = NetworkGetNetworkIdFromEntity(spawnedMachine)

        if not placedMachines[spawnedMachine] then
            placedMachines[placedMachines] = {}
        end

        placedMachines[spawnedMachine] = {
            id = id,
            coords = coords,
            cEntity = clientEntity,
        }

        exports.ox_inventory:RegisterStash(placedMachines[spawnedMachine].id, "Count Money", 10, 50000)
        Wait(100)
        TriggerClientEvent('moneywash:client:CreateTargetForMachine', -1, placedMachines[spawnedMachine])
    end
end)