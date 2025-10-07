local washingFx = nil

RegisterNetEvent('moneywash:client:TriggerWashingPTFX', function(state, coords)
    local ptfxLib = lib.requestNamedPtfxAsset('scr_xs_celebration')

    if state == true and not washingFx then
        UseParticleFxAssetNextCall(ptfxLib)  
        washingFx = StartParticleFxLoopedAtCoord('scr_xs_money_rain_celeb', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.5, false, false, false, false)
        RemovePtfxAsset(ptfxLib)
    elseif state == false and washingFx then
        StopParticleFxLooped(washingFx, 0)
        washingFx = nil
        washingThread = nil
    end
end)