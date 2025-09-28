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