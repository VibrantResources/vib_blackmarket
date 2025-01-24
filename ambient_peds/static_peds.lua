CreateThread(function()
    for k, pedInfo in pairs(Config.AmbientPeds.Static) do
        lib.requestModel(pedInfo.PedModel, 60000)
        
        local ambientPed = CreatePed(0, pedInfo.PedModel, pedInfo.SpawnLocation.xyz, pedInfo.SpawnLocation.w, false, false, true)
        SetBlockingOfNonTemporaryEvents(ambientPed, true)
        FreezeEntityPosition(ambientPed, true)
        SetEntityInvincible(ambientPed, true)
        Wait(250)
        if pedInfo.IsPedArmed then
            GiveWeaponToPed(ambientPed, 736523883, 1000, false, true)
            TaskShootAtCoord(ambientPed, 902.86, -3133.16, -97.13, -1, "FIRING_PATTERN_BURST_FIRE")
        end

        if pedInfo.PlayAnim then
            lib.requestAnimDict(pedInfo.AnimationDict)
            TaskPlayAnim(ambientPed, pedInfo.AnimationDict, pedInfo.AnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
        end

        if pedInfo.PlayScenario then
            TaskStartScenarioInPlace(ambientPed, pedInfo.Scenario)
        end
    end
end)