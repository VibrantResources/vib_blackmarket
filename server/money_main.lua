----------
--Events--
----------

RegisterNetEvent('blackmarket:server:UpdateStores', function(data)
	Context.StoreInfo[data.ShopName] = {
		CurrentlyWashing = false,
		AmountBeingWashed = 0,
		Owner = nil,
		storeCut = nil,
		Robber = nil,
		HasStoreBeenRobbed = false,
		Investigated = false,
	}
end)

RegisterNetEvent('blackmarket:server:StartWashing', function(input, data, citizenId, moneyWashingingLoss)
	local moneyAmount = input[1]

	if exports.ox_inventory:RemoveItem(source, Config.DirtyMoneyItem, moneyAmount) then 
		Context.StoreInfo[data.ShopName] = {
			CurrentlyWashing = true,
			AmountBeingWashed = moneyAmount,
			Owner = citizenId,
			StoreCut = moneyWashingingLoss,
		}
	end
end)

RegisterNetEvent('blackmarket:server:RetrieveMoney', function(data)
	local amount = math.floor(data.returnMoney)

	if exports.ox_inventory:CanCarryItem(source, Config.CleanMoneyItem, amount) then
		exports.ox_inventory:AddItem(source, Config.CleanMoneyItem, amount)
		Context.StoreInfo[data.storeData.args.shop.ShopName] = {
			CurrentlyWashing = false,
			AmountBeingWashed = 0,
			Owner = nil,
			storeCut = nil,
			Robber = nil,
			HasStoreBeenRobbed = false,
			Investigated = false,
		}
	end
end)

RegisterNetEvent('blackmarket:server:RobStore', function(data, citizenId)
	local moneyAmount = Context.StoreInfo[data.storeData.args.shop.ShopName].AmountBeingWashed

	if exports.ox_inventory:CanCarryItem(source, Config.DirtyMoneyItem, moneyAmount) then
		exports.ox_inventory:AddItem(source, Config.DirtyMoneyItem, moneyAmount)

		Context.StoreInfo[data.storeData.args.shop.ShopName].AmountBeingWashed = 0
		Context.StoreInfo[data.storeData.args.shop.ShopName].Robber = citizenId
		Context.StoreInfo[data.storeData.args.shop.ShopName].HasStoreBeenRobbed = true
	end
end)

-------------
--Callbacks--
-------------

lib.callback.register("blackmarket:server:GetStoreInfo", function(source, data)
	return Context.StoreInfo[data]
end)

lib.callback.register('blackmarket:server:InvestigateRobbery', function(source, data)
    local robber = QBCore.Functions.GetPlayerByCitizenId(data.robber)
	local robberInfo = robber.PlayerData.charinfo
	
	Context.StoreInfo[data.storeData.args.ShopName].Investigated = true
    return robberInfo
end)