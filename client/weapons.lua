----------------------
--Weapon Attachments--
----------------------

RegisterNetEvent('blackmarket:client:getcomponentinformation', function()
    local player = cache.ped
    local currentWeapon = GetSelectedPedWeapon(player)
    local labels = {}

    for k, v in pairs(exports.ox_inventory:Items()) do
        local stringSearch = string.sub(k, 1, 3)

        if stringSearch == "at_" then -- (All attachments in OX weapons.lua start with at_ by default, so that's what we search for)
            local attachment = k
            local components = v.client.component
            local label = v.label

            for _, component in pairs(components) do
                if DoesWeaponTakeWeaponComponent(currentWeapon, component) then
                    table.insert(labels, label)
                end
            end
        end
    end

    local markdown = "\n"

    for i, element in ipairs(labels) do
        markdown = markdown .. "- " .. element .. "\n"
    end

    if next(labels) == nil then
        lib.notify({
            title = 'Unable',
            description = "You don't have a weapon in your hand",
            type = 'error'
        })
        return
    end

    local alert = lib.alertDialog({
        header = 'Seems like your weapon will be able to use some of the following:',
        content = markdown,
        centered = true,
        cancel = false
    })
end)

------------------
--Weapon Repairs--
------------------

RegisterNetEvent('blackmarket:client:RepairWeapon', function(data)
    local repairingWeapon = false
    local weaponData = lib.callback.await('blackmarket:server:CheckWeaponData', false)
    local modelLocation = data.args.repairModelLocation

    if weaponData == nil then
        return
    end

    if weaponData.metadata.durability == 100 then
        lib.notify({
            title = 'Attention',
            description = "Your weapon is already in good repair",
            type = 'inform'
        })
        return
    end

    local weaponHash = GetHashKey(weaponData.name)
    local weaponModel = GetWeapontypeModel(weaponHash)
    local gunModel = lib.requestModel(weaponModel, 60000)
    local weaponObject = CreateObjectNoOffset(gunModel, modelLocation.x, modelLocation.y, modelLocation.z, true, true, false)
    local weaponCoords = GetEntityCoords(weaponObject)
    SetEntityHeading(weaponObject, 25.0) -- This is the heading of the spawned weapon model
    SetEntityRotation(weaponObject, data.args.SpawnedRepairModelRotation, 1) -- This is the rotation of the spawned weapon model

    repairingWeapon = true
    lib.requestNamedPtfxAsset('core')

    CreateThread(function()
        while repairingWeapon do
            UseParticleFxAssetNextCall('core')
            local sparkEffect = StartNetworkedParticleFxNonLoopedAtCoord('ent_brk_sparking_wires_sp', weaponCoords, 0.0, 0.0, 0.0, 0.3, 0.0, 0.0, 0.0)
            Wait(200)
        end
    end)

    if lib.progressCircle({
        duration = data.args.RepairDuration,
        position = 'bottom',
        label = 'Repairing Weapon',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false,
        },
        anim = {
            dict = "timetable@amanda@ig_2",
            clip = "ig_2_base_amanda",
        },
    })
    then   
        DeleteObject(weaponObject)
        repairingWeapon = false
        RemovePtfxAsset('core')
        TriggerServerEvent('blackmarket:server:RepairWeapon', data, weaponData)
    else
        DeleteObject(weaponObject)
        repairingWeapon = false
        RemovePtfxAsset('core')
        lib.notify({
            title = 'Canceled',
            description = "Canceled",
            type = 'error',
        })
    end
end)