QBCore = exports["qb-core"]:GetCoreObject()

math.randomseed(os.time())

-------------
--Variables--
-------------

----------
--Events--
----------

-----------
--Threads--
-----------

CreateThread(function()
    for _, v in pairs(Config.Shops) do
        if v.Type == "buying" then
            exports.ox_inventory:RegisterShop(v.Name, {
                name = v.Name,
                inventory = v.ItemsToBuy,
            })
        elseif v.Type == "selling" then
            exports.ox_inventory:RegisterStash(v.Name, "Sell "..v.Name, 10, 50000)
        end
    end
end)