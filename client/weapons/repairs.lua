RegisterNetEvent('blackmarket:client:RepairWeapon', function(data)
    local repairInfo = data.repairInfo.args
    local repairingWeapon = false
    local weaponData = lib.callback.await('blackmarket:server:CheckWeaponData', false)
    local modelLocation = repairInfo.repairModelLocation

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
    local weaponTypeGroup = GetWeapontypeGroup(weaponHash)
    local repairValues = CheckWeaponGroup(weaponTypeGroup)

    if not repairValues then
        lib.notify({
            title = 'Error',
            description = "This value returned 0 and is broken",
            type = 'error'
        })

        return
    end

    local weaponModel = GetWeapontypeModel(weaponHash)
    local gunModel = lib.requestModel(weaponModel, 60000)
    local weaponObject = CreateObjectNoOffset(gunModel, modelLocation.x, modelLocation.y, modelLocation.z, true, true, false)
    local weaponCoords = GetEntityCoords(weaponObject)
    SetEntityHeading(weaponObject, 25.0) -- This is the heading of the spawned weapon model
    SetEntityRotation(weaponObject, repairInfo.SpawnedRepairModelRotation, 1) -- This is the rotation of the spawned weapon model

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
        duration = repairInfo.repairDuration,
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

function CheckWeaponGroup(weaponTypeGroup)
    local player = cache.ped
    local weaponGroups = {
        {group = 'GROUP_PISTOL', groupHash = 416676503, unsigned = 416676503, unsignedGroup = 'WEAPON_PISTOL'},
        {group = 'GROUP_RIFLE',	groupHash = 970310034, unsigned = 970310034, unsignedGroup = 'WEAPON_ASSAULTRIFLE'},
        {group = 'GROUP_SHOTGUN', groupHash = 860033945, unsigned = 860033945,unsignedGroup = 'WEAPON_PUMPSHOTGUN'},
        {group = 'GROUP_SMG', groupHash = 3337201093,  unsigned = -957766203, unsignedGroup = 'WEAPON_MICROSMG'},
        {group = 'GROUP_SNIPER', groupHash = 3082541095, unsigned = -1212426201, unsignedGroup = 'WEAPON_SNIPERRIFLE'},
    }

    for k, v in pairs(weaponGroups) do
        if weaponTypeGroup == v.group or v.groupHash or v.unsigned  then
            local groupInfo = GetRepairValues(v)

            return groupInfo
        end
    end

    lib.notify({
        title = 'Unable',
        description = "Your weaponTypeGroup was "..weaponTypeGroup.." but we couldn't find one to match it",
        type = 'error'
    })
end

function GetRepairValues(groupData)
    local player = cache.ped
    local repairsInfo = Config.BlackMarket.RepairsInfo

    for k, v in pairs(repairsInfo.groupCosts) do
        if groupData.group == v.group then

            return v
        end
    end
end