RegisterNetEvent('blackmarket:BuyMenu', function(v)
    PlayPedAmbientSpeechNative(v.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
	local headerMenu = {}
    local moneyAmount = exports.ox_inventory:Search('count', Config.MoneyItem)
    local buyItemDescription = nil
    local stockAmountDescription = nil

    for _, itemData in pairs(v.args.ItemsForSale) do
        local stockInfo = lib.callback.await('blackmarket:server:GetStockInfo', false, itemData.Item)

        if moneyAmount > itemData.Price then
            buyItemDescription = "Our "..exports.ox_inventory:Items(itemData.Item).label.." cost $"..itemData.Price.. " today"
        else
            buyItemDescription = "You don't have enough money to buy any "..exports.ox_inventory:Items(itemData.Item).label
        end

        if stockInfo.stock <= 0 then
            stockAmountDescription = "We don't have any left in stock"
        else
            stockAmountDescription = "We have "..stockInfo.stock.." available"
        end

        headerMenu[#headerMenu + 1] = {
            title = "Purchase "..exports.ox_inventory:Items(itemData.Item).label,
            description = buyItemDescription..'\n\n'..stockAmountDescription,
            event = "blackmarket:BuyInput",
            args = {
                item = stockInfo.item,
                price = stockInfo.price,
                stock = stockInfo.stock
            },
            icon = "nui://ox_inventory/web/images/"..itemData.Item..".png",
            readOnly = itemData.Price > moneyAmount or stockInfo.stock <= 0,
        }
    end

    lib.registerContext({
        id = 'sales_menu',
        title = v.label,
        options = headerMenu
    })

    lib.showContext('sales_menu')
end)

RegisterNetEvent("blackmarket:BuyInput", function(args)
    local options = {}
    local moneyAmount = exports.ox_inventory:Search('count', Config.MoneyItem)
    local CanBuyWithMoney = math.floor((moneyAmount / args.price))

	local input = lib.inputDialog('Item Sales', {
        {
            type = "slider",
            label = "How many do you want?",
            options = options,
            required = true,
            icon = "nui://ox_inventory/web/images/"..args.item..".png",
            min = 1,
            max = math.min(CanBuyWithMoney, args.stock),
        },
    })
    if input == nil then
        return
    end

    TriggerServerEvent("blackmarket:server:BuyStock", input[1], args)
end)