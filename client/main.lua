QBCore = exports["qb-core"]:GetCoreObject()

-------------
--Variables--
-------------

-------------
--Functions--
-------------

function SpawnKidnapPed()
    local player = cache.ped
    local playerCoords = GetEntityCoords(player)

    local kidnapModel = lib.requestModel("a_m_m_acult_01", 60000)
    local kidnapPed = CreatePed(1, kidnapModel, playerCoords.x-1.0, playerCoords.y-1.0, playerCoords.z, false, true, true)
    SetModelAsNoLongerNeeded(kidnapModel)

    local kidnapPedCoords = GetEntityCoords(kidnapPed)
    SetEntityHeading(kidnapPed, playerCoords)
    TaskTurnPedToFaceCoord(kidnapPed, playerCoords.x, playerCoords.y, playerCoords.z, 1000)
    Wait(2000)

    local animToPlay = lib.requestAnimDict("melee@unarmed@streamed_variations")
    TaskPlayAnim(kidnapPed, animToPlay, 'plyr_takedown_rear_lefthook', 8.0, 8.0, -1, 10, 0, true, true, true)
    RemoveAnimDict(animToPlay)

    Wait(750)

    local stumbleAnim = lib.requestAnimDict("misscarsteal4@actor")
    TaskPlayAnim(player, stumbleAnim, 'stumble', 1.0, 1.0, -1, 10, 0, true, true, true)
    RemoveAnimDict(stumbleAnim)

    Wait(2000)

    SetPedToRagdollWithFall(player, 7500, 9000, 1, GetEntityForwardVector(player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

    Wait(1500)

    local headBagModel = lib.requestModel('prop_money_bag_01', 60000)
    local headbagObject = CreateObject(headBagModel, 0, 0, 0, true, true, true)
    AttachEntityToEntity(headbagObject, player, GetPedBoneIndex(player, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    SetEntityCompletelyDisableCollision(headbagObject, false, true)
    SetModelAsNoLongerNeeded(headBagModel)

    SendNUIMessage({
        type = "openGeneral"
    })

    Wait(1500)

    SetEntityAsNoLongerNeeded(kidnapPed)
    TeleportPlayer(headbagObject)
end

function TeleportPlayer(headbagObject)
    local player = cache.ped
    local coords = Config.BlackMarketAccess.EntranceInfo.EntranceLandingLocation

    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    SetEntityCoords(player, coords.x, coords.y, coords.z, false, false, false, false)
    SetEntityHeading(player, coords.w)

    Wait(100)

    DoScreenFadeIn(2000)
    while not IsScreenFadedIn() do
        Wait(10)
    end

    DeleteEntity(headbagObject)
    FreezeEntityPosition(player, false)
    ClearPedTasks(player)

    SendNUIMessage({
        type = "closeAll"
    })
end

function LeavingMarket()
    local player = cache.ped
    local Exit = Config.BlackMarketAccess.ExitInfo
    local randomLocation = math.random(1, #Exit.ExitLocations)
    local dropoffLocation = Exit.ExitLocations[randomLocation]

    DoScreenFadeOut(2000)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    local dropOffDict = lib.requestAnimDict("anim@amb@nightclub@lazlow@lo_sofa@")
    SetEntityCoords(player, dropoffLocation.x, dropoffLocation.y, dropoffLocation.z, false, false, false, false)
    TaskPlayAnim(player, dropOffDict, 'lowsofa_dlg_shit2strong_laz', 2.0, 2.0, -1, 01, 0, true, true, true)
    RemoveAnimDict(dropOffDict)

    DoScreenFadeIn(3500)
    while not IsScreenFadedIn() do
        Wait(10)
    end

    ClearPedTasks(player)
end