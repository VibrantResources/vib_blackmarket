Config = Config or {}

Config.Debug = false
Config.DirtyMoneyItem = "black_money" -- Currency item used to make purchases with market peds
Config.CleanMoneyItem = "money"

Config.BlackMarket = {
    EntranceInfo = {
        EntranceLandingLocation = vector4(892.62, -3245.87, -98.28, 73.49), -- Where the player lands after being teleported inside
        EntranceLocations = { -- Randomly selected location the entrance ped could spawn in per restart
            vector4(726.63, 4190.56, 39.7, 258.79),
        },
        pedInfo = {
            pedModels = { -- Randomly selected model the ped can spawn in as per restart
                "a_m_m_hasjew_01",
            },
            animInfo = {
                active = true,
                dict = "amb@world_human_aa_smoke@male@idle_a",
                clip = "idle_c",
            },
            propInfo = {
                active = true,
                propModel = "prop_cs_ciggy_01",
                bone = 28422,
                placement = {x = 0.0, y = 0.0, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0,},
            },
        },
    },
    ExitInfo = {
        pedInfo = {
            exitPedModel = "a_m_m_acult_01",
            exitPedName = "Guard",
            animInfo = {
                active = true,
                dict = "amb@world_human_aa_smoke@male@idle_a",
                clip = "idle_c",
            },
            propInfo = {
                active = true,
                propModel = "prop_cs_ciggy_01",
                bone = 28422,
                placement = {x = 0.0, y = 0.0, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0,},
            },
        },
        exitPedLocations = { -- A gurad ped will spawn in each location (Gives the appearance of each door/whatever being actually guarded)
            vector4(895.4, -3242.6, -99.26, 81.78),
            vector4(857.04, -3250.0, -99.34, 5.92),
        },
        exitLocations = { -- One of the below locations will be chosen each time a player LEAVES the black market [Set 1 vector4() if you want a static location]
            vector4(479.43, -2248.61, 5.91, 329.6),
            vector4(1119.57, -2147.11, 30.83, 354.01),
            vector4(935.48, -1517.98, 31.02, 352.9),
            vector4(523.22, -1941.31, 24.98, 292.41),
            vector4(1516.95, 3793.44, 33.5, 134.38),
        },
    },
    RepairsInfo = { 
        groupCosts = { -- How much each weapon type costs to be repaired
            {group = 'GROUP_PISTOL', repairCost = 2250,},
            {group = 'GROUP_RIFLE', repairCost = 4250,},
            {group = 'GROUP_SHOTGUN', repairCost = 3000,},
            {group = 'GROUP_SMG', repairCost = 2750,},
            {group = 'GROUP_SNIPER', repairCost = 5000,},
        },
        repairLocations = {
            {
                repairsPedLocation = vector4(907.85, -3211.16, -99.23, 23.39),
                repairModelLocation = vector3(907.65, -3210.50, -98.30),
                spawnedRepairModelRotation = vector3(-85.0, 0.0, 25.0),
                pedInfo = {
                    pedName = "Christian",
                    pedModel = "a_m_m_acult_01",
                    animInfo = {
                        active = true,
                        dict = "mini@repair",
                        clip = "fixing_a_player",
                    },
                    propInfo = {
                        active = false,
                        propModel = "prop_cs_ciggy_01",
                        bone = 28422,
                        placement = {x = 0.0, y = 0.0, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0,},
                    },
                },
                repairDuration = 5000, -- How long it takes to repair a weapon in ms
                repairCost = 175, -- Cost of repairs using [Config.DirtyMoneyItem]
                requiredMoneyType = 'black_money', -- Dirty money item name
            },
        },
    },
}

Config.EntranceQuestions = {
    {
        Question = "What is the guard rotation at BolingBroke?",
        Answers = {
            "4-4-5-3",
            "3-4-5-2",
            "4-4-4-4",
            "4-6-5-3",
        },
        Correct_Answer = "4-4-5-3", -- Must match one of the [Answers] above
    },
}

-----------
--Experts--
-----------

-- THIS IS STILL A WORK IN PROGRESS
Config.Experts = {
    Explosives = {
        active = false, -- False means the ped/target won't create
        pedModel = "a_m_m_eastsa_02",
        pedName = "Explosives Expert",
        Location = vector4(931.12, -3201.67, -99.27, 107.98),
        animationDict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a",
        animationClip = "idle_a",
        ExtinguisherBorrowDurationInSeconds = 2,
        TestableExplosives = { -- Use some logic ... If it's throwable, then it's location belongs in [ThrowExplosivesLocations] etc
            'weapon_grenade',
            'weapon_smokegrenade',
        },
        PlantExplosiveLocation = { -- Locations where a player will be asked to plant explosives
            vector3(935.72, -3212.24, -98.28),
        },
        ThrowExplosivesLocations = { -- Locations where a player will be asked to throw explosives
            vector3(934.69, -3214.96, -99.07),
            vector3(928.4, -3216.56, -99.07),
            vector3(933.85, -3221.91, -98.29),
            vector3(937.24, -3226.05, -98.29),
            vector3(930.2, -3222.24, -98.28),
        },
    },
    Vehicles = {
        active = false, -- False means the ped/target won't create
        pedModel = "a_m_m_eastsa_02",
        pedName = "Vehicles Expert",
        Location = vector4(831.17, -3241.23, -99.7, 313.76),
        animationDict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a",
        animationClip = "idle_a",
        respray = {
            cost = 1500, -- This will be using Config.DirtyMoneyItem
            LengthOfResprayInSeconds = 10, -- How long it takes to respray your car
            resprayPolyzoneLocation = {
                vec3(836.29, -3242.85, -99.0),
                vec3(836.0, -3237.0, -99.0),
                vec3(833.0, -3237.0, -99.0),
                vec3(832.0, -3242.0, -99.0),
            },
        },
    },
}

Config.Shops = {
    {
        type = "buying", -- buying = player buys items here / selling = player sells items here
        pedInfo = {
            pedName = "Shane",
            pedLocation = vector4(908.6, -3207.37, -98.19, 212.49), -- Ped location
            pedModel = "a_m_m_acult_01",
            animInfo = {
                active = true,
                dict = "anim@heists@prison_heiststation@cop_reactions",
                clip = "cop_b_idle",
            },
            propInfo = {
                active = false,
                propModel = "prop_cs_ciggy_01",
                bone = 28422,
                placement = {x = 0.0, y = 0.0, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0,},
            },
        },
        itemsToBuy = { -- Item / Item Price / Stock amount per restart
            {name = "lockpick", price = 65, count = 50, currency = "black_money"},
            {name = "screwdriverset", price = 30, count = 15, currency = "black_money"},
            {name = "advancedlockpick", price = 115, count = 25, currency = "black_money"},
            {name = "diamond_drill", price = 12500, count = 3, currency = "black_money"},
        },
    },

    {
        type = "selling",
        pedInfo = {
            pedName = "Shaun",
            pedLocation = vector4(892.05, -3227.79, -99.24, 327.8), -- Ped location
            pedModel = "a_m_m_acult_01",
            animInfo = {
                active = false,
                dict = "anim@heists@prison_heiststation@cop_reactions",
                clip = "cop_b_idle",
            },
            propInfo = {
                active = false,
                propModel = "prop_cs_ciggy_01",
                bone = 28422,
                placement = {x = 0.0, y = 0.0, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0,},
            },
        },
        sellableItems = {
            {name = "ammo-9", value = math.random(1, 2)},
            {name = "ammo-rifle", value = math.random(1, 2)},
            {name = "ammo-rifle2", value = math.random(1, 2)},
            {name = "ammo-45", value = math.random(1, 2)},
            {name = "ammo-shotgun", value = math.random(1, 2)},
        },
    },
}

------------------
--Money Counting--
------------------
-- Players add "Config.DirtyMoneyItem" to the machines inventory and at the below intervals
-- It removes the chosen values and replcaes with the chosen clean values in "Config.CleanMoneyItem"

Config.MoneyMachine = {
    item = "money_counter", -- Item used by player to place down object
    objectModel = "bkr_prop_money_counter", -- Prop placed down when above item is used
}

----------------
--Ambient Peds--
----------------

Config.AmbientPeds = {
    Static = {
        {
            PedModel = "a_m_m_prolhost_01", -- Ped model
            SpawnLocation = vector4(888.58, -3206.81, -99.2, 21.69), -- Ped location
            PlayAnim = false, -- Set to false if [PlayScenario] or [IsPedArmed] = true
            AnimationDict = "amb@world_human_welding@male@base",
            AnimationClip = "base",
            PlayScenario = true, -- Set to false if [PlayAnim] = true
            Scenario = 'WORLD_HUMAN_WELDING',
            IsPedArmed = false, -- Set to false if [PlayAnim] or [PlayScenario] = true
            WeaponIfArmed = nil, -- Leave as nil if [IsPedArmed = false] otherwise make sure the weapon HASH is used (https://gtahash.ru/weapons/?page=1)
        },
    },
}