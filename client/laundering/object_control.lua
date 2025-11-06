QBCore = exports["qb-core"]:GetCoreObject()

local machineInUse = false

RegisterNetEvent('moneywash:client:PlaceDownObject', function(data)
    local ped = cache.ped
    local coords = cache.coords

    if GetVehiclePedIsIn(ped, false) ~= 0 or machineInUse then 
        return 
    end
    machineInUse = true

    local model = lib.requestModel(Config.MoneyMachine.objectModel, 60000)
    if not model then
        QBCore.Functions.Notify("Couldn't load object model; timed out, this has a 60 second load time", "error", 3000)
        machineInUse = false
        return
    end

    local ghost = CreateObject(model, coords, false, true, true)
    SetEntityAlpha(ghost, 170, false)
    SetEntityCollision(ghost, false, false)
    FreezeEntityPosition(ghost, true)
    SetModelAsNoLongerNeeded(model)

    lib.showTextUI("[E] Place  |  [X] Rotate  |  [G] Cancel")

    local heading = GetEntityHeading(ghost)
    local placing = true

    while placing do
        Wait(0)

        local hit, _, hitCoords = lib.raycast.cam(1, 7, 10)
        if hit then
            SetEntityCoords(ghost, hitCoords)
            PlaceObjectOnGroundProperly(ghost)
        end

        -- Rotate (X)
        if IsControlPressed(2, 105) then
            heading = heading + 2.5
        end
        SetEntityHeading(ghost, heading%360)

        -- Place (E)
        if IsControlJustPressed(2, 38) then
            lib.hideTextUI()
            DeleteEntity(ghost)
            TriggerServerEvent('moneywash:server:SetUpMachine', data, hitCoords, heading)
            placing = false
        end

        -- Cancel (G)
        if IsControlJustPressed(2, 47) then
            lib.hideTextUI()
            DeleteEntity(ghost)
            QBCore.Functions.Notify("You put the machine away", "inform", 3000)
            placing = false
        end
    end

    machineInUse = false
end)