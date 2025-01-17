-------------
--Variables--
-------------

local bl_ui = exports.bl_ui

----------
--Events--
----------

RegisterNetEvent("blackmarket:client:GetCode", function(data)
    local player = cache.ped
    local zoneOptions = Config.Hacking.ZoneOptions
    local hackItem = exports.ox_inventory:Search('count', Config.Hacking.HackItem)

    local hackCooldown = lib.callback.await('blackmarket:server:GetHackTimer', false, data.args)

    if hackCooldown > 0 then 
        lib.notify({
            title = 'Unable',
            description = "This location has already been hit",
            type = 'error'
        })
        return
    end
    
    if hackItem == 0 then
        lib.notify({
            title = 'Missing items',
            description = "You're missing tools",
            type = 'error',
        })
        return
    end

    lib.requestAnimDict("amb@world_human_bum_wash@male@low@idle_a")
    TaskPlayAnim(player, 'amb@world_human_bum_wash@male@low@idle_a', 'idle_a', 1.0, 1.0, -1, 01, 0, true, true, true)
    RemoveAnimDict('amb@world_human_bum_wash@male@low@idle_a')
    
    local success = exports.bl_ui:CircleSum(4, {
        length = 5,
        duration = 6000,
    })

    if success then
        ClearPedTasks(player)
        local requiredCode = lib.callback.await('blackmarket:server:GenerateNumberCode', false)

        lib.notify({
            title = "Attention",
            description = 'The access code is: '..requiredCode.. '. Make sure you write it down!',
            type = 'inform',
            duration = 6000,
        })

        TriggerServerEvent('blackmarket:server:TriggerHackTimer', data.args)
    else
        ClearPedTasks(player)
        lib.notify({
            title = 'Failed',
            description = "You failed, best get moving!",
            type = 'error',
        })
    end
end)

---------------------
--Hacking Locations--
---------------------

CreateThread(function()
    for k, v in pairs(Config.Hacking.HackingZones) do
        exports.ox_target:addBoxZone({
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            debug = Config.Debug,
            options = {
                {
                    label = "Attach Laptop",
                    event = "blackmarket:client:GetCode",
                    args = k,
                    icon = "fa-solid fa-code",
                    iconColor = "purple",
                    distance = 1.0,
                },
            },
        })
    end
end)