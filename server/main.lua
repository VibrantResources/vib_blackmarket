QBCore = exports["qb-core"]:GetCoreObject()

math.randomseed(os.time())

-------------
--Variables--
-------------

isCarAttached = false

----------
--Events--
----------

-----------
--Threads--
-----------

CreateThread(function()
    for _, v in pairs(Config.Shops) do
        if v.type == "buying" then
            exports.ox_inventory:RegisterShop(v.pedInfo.pedName, {
                name = v.pedInfo.pedName,
                inventory = v.itemsToBuy,
            })
        elseif v.type == "selling" then
            exports.ox_inventory:RegisterStash(v.pedInfo.pedName, "Sell "..v.pedInfo.pedName, 10, 50000)
        end
    end
end)