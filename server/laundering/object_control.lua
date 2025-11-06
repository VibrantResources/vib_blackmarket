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
        local randomId = zutils.uuid()
        Wait(250)
        local netId = NetworkGetNetworkIdFromEntity(spawnedMachine)

        if not placedMachines[spawnedMachine] then
            placedMachines[placedMachines] = {}
        end

        placedMachines[randomId] = {
            machineId = randomId,
            coords = coords,
            netId = netId,
            object = spawnedMachine,
        }

        exports.ox_inventory:RegisterStash(placedMachines[randomId].machineId, "Money Counter", 10, 50000)
        Wait(100)
        TriggerClientEvent('moneywash:client:CreateTargetForMachine', -1, placedMachines[randomId])
    end
end)

RegisterNetEvent('moneywash:server:PickUpMachine', function(machineInfo)
    local player = QBCore.Functions.GetPlayer(source)
    if not player or not machineInfo then 
        return 
    end

    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    if #(playerCoords - machineInfo.args.coords) > 10.0 then
        lib.notify(source, {
            title = "Unable",
            description = "I'm too far away to do this",
            type = "error"
        })

        return
    end

    local machineItems = exports.ox_inventory:GetInventoryItems(machineInfo.args.machineId) or {}

    if exports.ox_inventory:CanCarryItem(source, Config.MoneyMachine.item, 1) then
        exports.ox_inventory:AddItem(source, Config.MoneyMachine.item, 1)

        for _, v in pairs(machineItems) do
            if exports.ox_inventory:CanCarryItem(source, v.name, v.count) then
                exports.ox_inventory:AddItem(source, v.name, v.count)
            else
                exports.ox_inventory:CustomDrop('Dropped Money', {
                    { v.name, v.count },
                }, playerCoords, 5, 10000, nil, `prop_money_bag_01`)

                lib.notify(source, {
                    title = "Unable To Carry",
                    description = "Money dropped on floor",
                    type = "inform"
                })
            end
        end

        if DoesEntityExist(machineInfo.args.object) then
            exports.ox_inventory:RemoveInventory(machineInfo.args.machineId)
            placedMachines[machineInfo.args.machineId] = nil
            DeleteEntity(machineInfo.args.object)
            
            TriggerClientEvent('moneywash:client:RemoveEntityTarget', -1, machineInfo.args)
            TriggerClientEvent('moneywash:client:TriggerWashingPTFX', source, false, machineInfo.args.coords)
        end
    else
        lib.notify(source, {
            title = "Unable",
            description = "I don't have room",
            type = "error"
        })
    end
end)
