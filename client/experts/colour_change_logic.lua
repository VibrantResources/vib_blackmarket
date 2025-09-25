local function lerp(a, b, t)
    return a + (b - a) * t
end

-- Utility: load particle dictionary
local function loadPtfx(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
        while not HasNamedPtfxAssetLoaded(dict) do
            Citizen.Wait(0)
        end
    end
end

-- Smooth fade with smoke
function SmoothChangeVehicleColorWithSmoke(vehicle, duration)
    if not DoesEntityExist(vehicle) then return false end
    duration = tonumber(duration) or 2000

    -- Start RGB
    local r0,g0,b0 = GetVehicleCustomPrimaryColour(vehicle)
    local r1,g1,b1 = GetVehicleCustomSecondaryColour(vehicle)

    -- Target RGB
    local rT0,gT0,bT0 = math.random(0,255), math.random(0,255), math.random(0,255)
    local rT1,gT1,bT1 = math.random(0,255), math.random(0,255), math.random(0,255)

    local startTime = GetGameTimer()

    -- Load particle fx dictionary
    local dict = "core"
    loadPtfx(dict)

    -- Start smoke effect
    UseParticleFxAssetNextCall(dict)
    local fxHandle = StartParticleFxLoopedOnEntity(
        "exp_grd_grenade_smoke", -- effect name
        vehicle,
        0.0, 0.0, 0.0, -- offset
        0.0, 0.0, 0.0, -- rotation
        0.5, -- scale
        false, false, false
    )

    Citizen.CreateThread(function()
        while true do
            local now = GetGameTimer()
            local elapsed = now - startTime
            local t = elapsed / duration

            -- Interpolated colours
            local rP = math.floor(lerp(r0, rT0, math.min(t,1.0)))
            local gP = math.floor(lerp(g0, gT0, math.min(t,1.0)))
            local bP = math.floor(lerp(b0, bT0, math.min(t,1.0)))

            local rS = math.floor(lerp(r1, rT1, math.min(t,1.0)))
            local gS = math.floor(lerp(g1, gT1, math.min(t,1.0)))
            local bS = math.floor(lerp(b1, bT1, math.min(t,1.0)))

            SetVehicleCustomPrimaryColour(vehicle, rP, gP, bP)
            SetVehicleCustomSecondaryColour(vehicle, rS, gS, bS)

            -- Update smoke colour (PTFX supports RGB)
            SetParticleFxLoopedColour(fxHandle, rP/255.0, gP/255.0, bP/255.0)

            if t >= 1.0 then
                -- Done fading
                StopParticleFxLooped(fxHandle, 0)
                break
            end

            Citizen.Wait(40)
        end
    end)

    return true
end