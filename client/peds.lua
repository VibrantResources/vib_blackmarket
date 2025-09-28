CreateThread(function()
    ----------
    --Shops--
    ---------

    for _, v in pairs(Config.Shops) do
        local pedInfo = v.pedInfo
        local shopPedModel = lib.requestModel(pedInfo.pedModel, 60000)
        local shopPed = CreatePed(1, shopPedModel, pedInfo.pedLocation, pedInfo.pedLocation.w, false, true)

        SetEntityInvincible(shopPed, true)
        SetBlockingOfNonTemporaryEvents(shopPed, true)
        FreezeEntityPosition(shopPed, true)

        if pedInfo.animInfo.active then
            lib.requestAnimDict(pedInfo.animInfo.dict)
            TaskPlayAnim(shopPed, pedInfo.animInfo.dict, pedInfo.animInfo.clip, 1.0, 1.0, -1, 1, 1, false, false, false)

            RemoveAnimDict(pedInfo.animInfo.dict)
        end

        if pedInfo.propInfo.active then
            local placement = pedInfo.propInfo.placement
            lib.RequestModel(pedInfo.propInfo.propModel, 60000)
            local propModel = CreateObject(pedInfo.propInfo.propModel, exit.exitPedLocations[i], false, true, false)
            AttachEntityToEntity(propModel, shopPed, GetPedBoneIndex(shopPed, pedInfo.propInfo.bone), placement.x, placement.y, placement.z, placement.xRot, placement.yRot, placement.zRot, true, true, false, true, 1, true)
            SetModelAsNoLongerNeeded(pedInfo.propInfo.propModel)
        end

        if v.type == "buying" then
            exports.ox_target:addLocalEntity(shopPed,  {
                {
                    label = 'Trade with '..pedInfo.pedName,
                    icon = 'fa-solid fa-cart-shopping',
                    onSelect = function()
                        Wait(100)
                        PlayPedAmbientSpeechNative(shopPed, 'GENERIC_HI', 'Speech_Params_Force')
                        exports.ox_inventory:openInventory('shop', {
                            type = pedInfo.pedName
                        })
                    end,
                }
            })
        elseif v.type == "selling" then
            exports.ox_target:addLocalEntity(shopPed,  {
                {
                    label = "Sell to "..pedInfo.pedName,
                    icon = 'fa-solid fa-sack-dollar',
                    onSelect = function()
                        Wait(100)
                        PlayPedAmbientSpeechNative(shopPed, 'GENERIC_HI', 'Speech_Params_Force')
                        exports.ox_inventory:openInventory('stash', pedInfo.pedName)
                    end,
                }
            })
        end

        SetModelAsNoLongerNeeded(shopPedModel)
    end

    -------------------
    --Entering Market--
    -------------------

    local entranceCoords = lib.callback.await('blackmarket:server:GetRandomEntranceLocation', false)
    local pedInfo = Config.BlackMarket.EntranceInfo.pedInfo
    local pedModelKey = math.random(1, #pedInfo.pedModels)
    local chosenPedModel = lib.requestModel(pedInfo.pedModels[pedModelKey], 60000)
    
    local entrancePed = CreatePed(1, chosenPedModel, entranceCoords, entranceCoords.w, false, true)
    SetEntityInvincible(entrancePed, true)
    SetBlockingOfNonTemporaryEvents(entrancePed, true)
    FreezeEntityPosition(entrancePed, true)
    
    if pedInfo.animInfo.active then
        lib.requestAnimDict(pedInfo.animInfo.dict)
        TaskPlayAnim(entrancePed, pedInfo.animInfo.dict, pedInfo.animInfo.clip, 4.0, 4.0, -1, 1, false, false, false, false)
        RemoveAnimDict(pedInfo.animInfo.dict)
    end

    if pedInfo.propInfo.active then
        local placement = pedInfo.propInfo.placement
        lib.RequestModel(pedInfo.propInfo.propModel, 60000)
        local propModel = CreateObject(pedInfo.propInfo.propModel, entranceCoords, false, true, false)
        AttachEntityToEntity(propModel, entrancePed, GetPedBoneIndex(entrancePed, pedInfo.propInfo.bone), placement.x, placement.y, placement.z, placement.xRot, placement.yRot, placement.zRot, true, true, false, true, 1, true)
        SetModelAsNoLongerNeeded(pedInfo.propInfo.propModel)
    end

    exports.ox_target:addLocalEntity(entrancePed, {
        {
            label = 'Speak',
            event = 'blackmarket:EntranceMenu',
            icon = 'fa-solid fa-comment-dots',
            iconColor = 'yellow',
            distance = 2,
        },
    })
    SetModelAsNoLongerNeeded(chosenPedModel)

    ------------------
    --Exiting Market--
    ------------------

    local exit = Config.BlackMarket.ExitInfo
    local exitPedInfo = exit.pedInfo
    for i=1, #exit.exitPedLocations do
        local exitPedModel = lib.requestModel(exitPedInfo.exitPedModel, 60000)
        local exitPed = CreatePed(1, exitPedModel, exit.exitPedLocations[i], exit.exitPedLocations[i].w, false, true)
        SetEntityInvincible(exitPed, true)
        SetBlockingOfNonTemporaryEvents(exitPed, true)
        FreezeEntityPosition(exitPed, true)

        if exitPedInfo.animInfo.active then
            lib.requestAnimDict(exitPedInfo.animInfo.dict)
            TaskPlayAnim(exitPed, exitPedInfo.animInfo.dict, exitPedInfo.animInfo.clip, 1.0, 1.0, -1, 1, 1, false, false, false)

            RemoveAnimDict(exitPedInfo.animInfo.dict)
        end

        if exitPedInfo.propInfo.active then
            local placement = exitPedInfo.propInfo.placement
            lib.RequestModel(exitPedInfo.propInfo.propModel, 60000)
            local propModel = CreateObject(exitPedInfo.propInfo.propModel, exit.exitPedLocations[i], false, true, false)
            AttachEntityToEntity(propModel, exitPed, GetPedBoneIndex(exitPed, exitPedInfo.propInfo.bone), placement.x, placement.y, placement.z, placement.xRot, placement.yRot, placement.zRot, true, true, false, true, 1, true)
            SetModelAsNoLongerNeeded(exitPedInfo.propInfo.propModel)
        end

        exports.ox_target:addLocalEntity(exitPed, {
            {
                label = 'Speak to '..exitPedInfo.exitPedName,
                event = 'blackmarket:ExitMenu',
                args = exitPedInfo.exitPedName,
                icon = 'fa-solid fa-box-archive',
                iconColor = 'yellow',
                distance = 2, 
            },
        })
        SetModelAsNoLongerNeeded(exitPedModel)
    end

    ------------------
    --Weapon Repairs--
    ------------------

    for _, v in pairs(Config.BlackMarket.RepairsInfo.repairLocations) do
        local repairPedModel = lib.requestModel(v.pedInfo.pedModel, 60000)
        local repairPed = CreatePed(1, repairPedModel, v.repairsPedLocation, v.repairsPedLocation.w, false, true)
        SetEntityInvincible(repairPed, true)
        SetBlockingOfNonTemporaryEvents(repairPed, true)
        FreezeEntityPosition(repairPed, true)

        if v.pedInfo.animInfo.active then
            lib.requestAnimDict(v.pedInfo.animInfo.dict)
            TaskPlayAnim(repairPed, v.pedInfo.animInfo.dict, v.pedInfo.animInfo.clip, 1.0, 1.0, -1, 1, 1, false, false, false)

            RemoveAnimDict(v.pedInfo.animInfo.dict)
        end

        if v.pedInfo.propInfo.active then
            local placement = v.pedInfo.propInfo.placement
            lib.RequestModel(v.pedInfo.propInfo.propModel, 60000)
            local propModel = CreateObject(v.pedInfo.propInfo.propModel, exit.exitPedLocations[i], false, true, false)
            AttachEntityToEntity(propModel, repairPed, GetPedBoneIndex(repairPed, v.pedInfo.propInfo.bone), placement.x, placement.y, placement.z, placement.xRot, placement.yRot, placement.zRot, true, true, false, true, 1, true)
            SetModelAsNoLongerNeeded(v.pedInfo.propInfo.propModel)
        end

        exports.ox_target:addLocalEntity(repairPed, {
            {
                label = 'Speak to '..v.pedInfo.pedName,
                event = 'blackmarket:RepairMenu',
                args = v,
                icon = 'fa-solid fa-box-archive',
                iconColor = 'yellow',
                distance = 2, 
            },
        })
        SetModelAsNoLongerNeeded(repairPedModel)
    end
end)