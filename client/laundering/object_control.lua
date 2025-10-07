QBCore = exports["qb-core"]:GetCoreObject()

local machineUsed = false
local machinePlaced = false

RegisterNetEvent('moneywash:client:PlaceDownObject', function(data)
    local player = cache.ped
    local playerCoords = cache.coords

    if GetVehiclePedIsIn(player, false) ~= 0 then
        return
    end

    if machineUsed then
        return
    end

    machineUsed = true

    local machineModel = lib.requestModel(Config.MoneyMachine.objectModel, 60000)

    local machineShadow = CreateObject(machineModel, playerCoords, false, true, true) 
    SetEntityAlpha(machineShadow, 170, false)
    SetEntityCollision(machineShadow, false, false)
    FreezeEntityPosition(machineShadow, true)
    SetModelAsNoLongerNeeded(machineModel)

    lib.showTextUI("[E] to place, [Q/R] to rotate or [G] to cancel")

    while machinePlaced == false do
        if not machineUsed then
            return
        end

        local hit, entityHit, coords, surface, hash = lib.raycast.cam(1, 7, 10)
        if not hit then
            return
        end

        SetEntityCoords(machineShadow, coords)
        PlaceObjectOnGroundProperly(machineShadow)
        DisableControlAction(0, 24, true)

        if IsControlJustPressed(0, 38) then -- Press [E] to place
            PlaceObject(data, coords, newHeading)
            DeleteEntity(machineShadow)
            machinePlaced = false
            machineUsed = false

            break
        end

        if IsControlPressed(0, 44) then -- Hold Q to rotate
            local currentHeading = GetEntityHeading(machineShadow)
            newHeading = (currentHeading + 1.5)

            SetEntityHeading(machineShadow, newHeading)
        end

        if IsControlPressed(0, 105) then -- Hold R to rotate
            local currentHeading = GetEntityHeading(machineShadow)
            newHeading = (currentHeading - 1.5)

            SetEntityHeading(machineShadow, newHeading)
        end

        if IsControlJustPressed(0, 47) then -- Press [G] to cancel
            DeleteEntity(machineShadow)
            machinePlaced = false
            machineUsed = false
            lib.hideTextUI()

            break
        end

        Wait(0)
    end
end)

function PlaceObject(data, coords, newHeading)
    local player = cache.ped
    lib.hideTextUI()

    TriggerServerEvent('moneywash:server:SetUpMachine', data, coords, newHeading)
end