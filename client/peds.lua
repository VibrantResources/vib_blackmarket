CreateThread(function()
    ----------
    --Shops--
    ---------

    for _, v in pairs(Config.Shops) do
        lib.requestModel(v.Model, 60000)
        local shopPed = CreatePed(1, v.Model, v.Location, false, true, false)

        SetEntityInvincible(shopPed, true)
        SetBlockingOfNonTemporaryEvents(shopPed, true)
        FreezeEntityPosition(shopPed, true)

        if Config.UseAnims then
            lib.requestAnimDict(v.AnimationDict)
            TaskPlayAnim(shopPed, v.AnimationDict, v.AnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
            
            RemoveAnimDict(v.AnimationDict)
        end

        if v.Type == "buying" then
            exports.ox_target:addLocalEntity(shopPed,  {
                {
                    label = 'Trade '..v.Name,
                    icon = 'fa-solid fa-cart-shopping',
                    name = k,
                    onSelect = function()
                        Wait(100)
                        PlayPedAmbientSpeechNative(shopPed, 'GENERIC_HI', 'Speech_Params_Force')
                        exports.ox_inventory:openInventory('shop', {
                            type = v.Name
                        })
                    end,
                }
            })
        elseif v.Type == "selling" then
            exports.ox_target:addLocalEntity(shopPed,  {
                {
                    label = "Sell "..v.Name,
                    icon = 'fa-solid fa-sack-dollar',
                    onSelect = function()
                        Wait(100)
                        PlayPedAmbientSpeechNative(shopPed, 'GENERIC_HI', 'Speech_Params_Force')
                        exports.ox_inventory:openInventory('stash', v.Name)
                    end,
                }
            })
        end

        SetModelAsNoLongerNeeded(v.Model)
    end

    -------------------
    --Entering Market--
    -------------------

    local entranceCoords = lib.callback.await('blackmarket:server:GetRandomEntranceLocation', false)
    local pedInfo = Config.BlackMarketAccess.EntranceInfo.pedInfo
    local pedModelKey = math.random(1, #pedInfo.pedModels)
    local chosenPedModel = lib.requestModel(pedInfo.pedModels[pedModelKey], 60000)
    
    local entrancePed = CreatePed(1, chosenPedModel, entranceCoords, false, true, false)
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

    local exit = Config.BlackMarketAccess.ExitInfo
    local pedCoords = exit.ExitPedLocation

    lib.requestModel(exit.ExitPedModel, 60000)
    local exitPed = CreatePed(1, exit.ExitPedModel, exit.ExitPedLocation, false, true, true)
    SetEntityInvincible(exitPed, true)
    SetBlockingOfNonTemporaryEvents(exitPed, true)
    FreezeEntityPosition(exitPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(exit.ExitPedAnimationDict)
        TaskPlayAnim(exitPed, exit.ExitPedAnimationDict, exit.ExitPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)

        RemoveAnimDict(exit.ExitPedAnimationDict)
    end

    exports.ox_target:addLocalEntity(exitPed, {
        {
            label = 'Speak to '..exit.ExitPedName,
            event = 'blackmarket:ExitMenu',
            args = exit.ExitPedName,
            icon = 'fa-solid fa-box-archive',
            iconColor = 'yellow',
            distance = 2, 
        },
    })
    SetModelAsNoLongerNeeded(exit.ExitPedModel)

    ------------------
    --Weapon Repairs--
    ------------------

    for _, v in pairs(Config.BlackMarketAccess.RepairsInfo) do
        lib.requestModel(v.RepairsPedModel, 60000)
        local repairPed = CreatePed(1, v.RepairsPedModel, v.RepairsPedLocation, false, true, true)
        SetEntityInvincible(repairPed, true)
        SetBlockingOfNonTemporaryEvents(repairPed, true)
        FreezeEntityPosition(repairPed, true)

        if Config.UseAnims then
            lib.requestAnimDict(v.RepairsPedAnimationDict)
            TaskPlayAnim(repairPed, v.RepairsPedAnimationDict, v.RepairsPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)

            RemoveAnimDict(v.RepairsPedAnimationDict)
        end

        exports.ox_target:addLocalEntity(repairPed, {
            {
                label = 'Speak to '..v.RepairsPedName,
                event = 'blackmarket:RepairMenu',
                args = v,
                icon = 'fa-solid fa-box-archive',
                iconColor = 'yellow',
                distance = 2, 
            },
        })
        SetModelAsNoLongerNeeded(v.RepairsPedModel)
    end
end)