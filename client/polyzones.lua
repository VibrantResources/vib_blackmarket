insideZone = false

CreateThread(function()
    if Config.Experts.Vehicles.active then
        local respray = Config.Experts.Vehicles.respray

        lib.zones.poly({
            points = respray.resprayPolyzoneLocation,
            thickness = 8,
            debug = Config.Debug,
            onEnter = function(self)
                insideZone = true
                lib.showTextUI('[E] - Place Vehicle')
                
                lib.notify({
                    title = "Entered Respray Zone",
                    description = "",
                    type = 'inform',
                })
            end,
            inside = function(self)
                if IsControlJustPressed(2, 38) then
                    TriggerEvent('blackmarket:client:ResprayVehicle')
                end
            end,
            onExit = function(self)
                insideZone = false
                lib.hideTextUI()

                lib.notify({
                    title = "Left respray zone",
                    description = "",
                    type = 'inform',
                })
            end,
        })
    end
end)