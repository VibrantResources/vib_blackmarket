RegisterNetEvent('blackmarket:RepairMenu', function(data)
    PlayPedAmbientSpeechNative(data.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
    
	local headerMenu = {}
    local moneyAmount = exports.ox_inventory:Search('count', Config.DirtyMoneyItem)
    local repairWeaponDescription = nil
    local attachmentDescription = nil
    local statsDescription = nil
    local currentWeapon = exports.ox_inventory:getCurrentWeapon()
    if not currentWeapon then
        QBCore.Functions.Notify("You don't have a weapon to show me", "error", 3500)

        return
    end

    local weaponHash = GetHashKey(currentWeapon.name)
    local weaponTypeGroup = GetWeapontypeGroup(weaponHash)
    local repairValues = CheckWeaponGroup(weaponTypeGroup)

    if currentWeapon then
        if moneyAmount > repairValues.repairCost then
            repairWeaponDescription = "It'll cost $"..repairValues.repairCost.." to repair your "..currentWeapon.label.."\n\n"..math.floor(currentWeapon.metadata.durability).."/100"
        else
            repairWeaponDescription = "You don't have enough cash"
        end

        if currentWeapon ~= nil then
            if currentWeapon.metadata.durability >= 100 then
                repairWeaponDescription = "Your "..currentWeapon.label.." doesn't require any repairs"
            end
        end
    end

    if currentWeapon then
        headerMenu[#headerMenu + 1] = {
            title = "Current Weapon:",
            description = currentWeapon.label,
            readOnly = true
        }
    end

    headerMenu[#headerMenu + 1] = {
        title = "Repair Weapon",
        description = repairWeaponDescription,
        event = 'blackmarket:client:RepairWeapon',
        args = {
            repairCost = repairValues.repairCost,
            repairInfo = data,
        },
        icon = 'fa-solid fa-hammer',
        iconColor = "brown",
        disabled = repairValues.repairCost > moneyAmount or currentWeapon == nil or currentWeapon.metadata.durability >= 100,
    }

    headerMenu[#headerMenu + 1] = {
        title = "Attachments",
        description = attachmentDescription or "View a list of possible attachments for your weapon",
        event = 'blackmarket:client:GetWeaponComponents',
        icon = 'fa-solid fa-gun',
        iconColor = "red",
        disabled = currentWeapon == nil,
    }

    -- headerMenu[#headerMenu + 1] = {
    --     title = "Weapon Stats",
    --     description = statsDescription or "Check the average stats for your weapon",
    --     event = 'blackmarket:client:GetWeaponStats',
    --     icon = 'fa-solid fa-chart-simple',
    --     iconColor = "green",
    --     disabled = currentWeapon == nil,
    -- }

    lib.registerContext({
        id = 'repair_menu',
        title = "Weapons Repair",
        options = headerMenu
    })

    lib.showContext('repair_menu')
end)