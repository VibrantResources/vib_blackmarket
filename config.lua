Config = Config or {}

Config.Debug = false
Config.UseAnims = true -- set to false if you want peds to be static with no animations
Config.DirtyMoneyItem = "black_money" -- Currency item used to make purchases with market peds
Config.CleanMoneyItem = "money"

Config.BlackMarketAccess = {
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
                placement = {
                    x = 0.0,
                    y = 0.0,
                    z = 0.0,
                    xRot = 0.0,
                    yRot = 0.0,
                    zRot = 0.0,
                },
            },
        },
    },
    ExitInfo = {
        ExitPedModel = "a_m_m_acult_01",
        ExitPedName = "Guard",
        ExitPedLocation = vector4(895.4, -3242.6, -99.26, 81.78),
        ExitPedAnimationDict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a",
        ExitPedAnimationClip = "idle_a",
        ExitLocations = { -- One of the below locations will be chosen each time a player LEAVES the black market [Set 1 vector4() if you want a static location]
            vector4(479.43, -2248.61, 5.91, 329.6),
            vector4(1119.57, -2147.11, 30.83, 354.01),
            vector4(935.48, -1517.98, 31.02, 352.9),
            vector4(523.22, -1941.31, 24.98, 292.41),
            vector4(1516.95, 3793.44, 33.5, 134.38),
        },
    },
    RepairsInfo = {
        {
            RepairsPedModel = "a_m_m_acult_01",
            RepairsPedName = "Christian",
            RepairsPedLocation = vector4(907.85, -3211.16, -99.23, 23.39),
            repairModelLocation = vector3(907.65, -3210.50, -98.30),
            SpawnedRepairModelRotation = vector3(-85.0, 0.0, 25.0),
            RepairsPedAnimationDict = "missfbi5ig_15",
            RepairsPedAnimationClip = "look_into_microscope_a_scientista",
            RepairDuration = 5000, -- How long it takes to repair a weapon in ms
            RepairCost = 175, -- Cost of repairs using [Config.DirtyMoneyItem]
            requiredMoneyType = 'black_money', -- Dirty money item name
        },
        {
            RepairsPedModel = "s_f_y_cop_01",
            RepairsPedName = "Armorer",
            RepairsPedLocation = vector4(487.15, -997.0, 29.68, 267.62),
            spawnedRepairModelLocation = vector3(487.95, -996.85, 30.52),
            SpawnedRepairModelRotation = vector3(0.0, 90.0, 90.0),
            RepairsPedAnimationDict = "missfbi5ig_15",
            RepairsPedAnimationClip = "look_into_microscope_a_scientista",
            RepairDuration = 7500, -- How long it takes to repair a weapon in ms
            RepairCost = 35, -- Cost of repairs using [Config.DirtyMoneyItem]
            requiredMoneyType = 'money', -- Clean money item name
        },
    },
}

-----------
--Experts--
-----------

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
        active = true, -- False means the ped/target won't create
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
        Name = "Supplies", -- Used for label when targeting ped
        Type = "buying", -- buying = player buys items here / selling = player sells items here
        Model = "s_m_m_ciasec_01", -- Ped model
        Location = vector4(899.86, -3206.64, -98.19, 114.26), -- Ped location
        AnimationDict = "amb@prop_human_bum_shopping_cart@male@idle_a", -- Dict for animation
        AnimationClip = "idle_c", -- Animation ped plays
        ItemsToBuy = { -- Item / Item Price / Stock amount per restart
            {name = "lockpick", price = 65, count = 50, currency = "black_money"},
            {name = "screwdriverset", price = 30, count = 15, currency = "black_money"},
            {name = "advancedlockpick", price = 115, count = 25, currency = "black_money"},
            {name = "diamond_drill", price = 12500, count = 3, currency = "black_money"},
        },
    },
    {
        Name = "Ammo",
        Type = "buying",
        Model = "s_m_m_fibsec_01",
        Location = vector4(904.74, -3230.82, -99.27, 345.69),
        AnimationDict = "amb@world_human_drinking@coffee@male@idle_a",
        AnimationClip = "idle_c",
        ItemsToBuy = {
            {name = "ammo-9", price = 1, count = 250, currency = "black_money"},
            {name = "ammo-rifle", price = 4, count = 150, currency = "black_money"},
            {name = "ammo-rifle2", price = 5, count = 150, currency = "black_money"},
            {name = "ammo-45", price = 2, count = 120, currency = "black_money"},
            {name = "ammo-shotgun", price = 3, count = 50, currency = "black_money"},
        },
    },
    {
        Name = "Attachments",
        Type = "buying",
        Model = "s_m_m_highsec_01",
        Location = vector4(908.93, -3207.19, -98.19, 115.63),
        AnimationDict = "amb@world_human_drinking@coffee@male@idle_a",
        AnimationClip = "idle_c",
        ItemsToBuy = {
            {name = "at_flashlight", price = 10, count = 10, currency = "black_money"},
            {name = "at_suppressor_light", price = 10, count = 10, currency = "black_money"},
            {name = "at_suppressor_heavy", price = 10, count = 10, currency = "black_money"},
            {name = "at_grip", price = 10, count = 10, currency = "black_money"},
            {name = "at_barrel", price = 10, count = 10, currency = "black_money"},
            {name = "at_clip_extended_pistol", price = 10, count = 10, currency = "black_money"},
            {name = "at_clip_extended_smg", price = 10, count = 10, currency = "black_money"},
            {name = "at_clip_extended_shotgun", price = 10, count = 10, currency = "black_money"},
            {name = "at_clip_extended_rifle", price = 10, count = 10, currency = "black_money"},
            {name = "at_clip_drum_smg", price = 10, count = 10, currency = "black_money"},
            {name = "at_clip_drum_rifle", price = 10, count = 10, currency = "black_money"},
            {name = "at_scope_macro", price = 10, count = 10, currency = "black_money"},
            {name = "at_scope_small", price = 10, count = 10, currency = "black_money"},
            {name = "at_scope_medium", price = 10, count = 10, currency = "black_money"},
            {name = "at_scope_large", price = 10, count = 10, currency = "black_money"},
            {name = "at_scope_holo", price = 10, count = 10, currency = "black_money"},
        },
    },

    {
        Name = "Ammo",
        Type = "selling",
        Model = "s_m_m_fibsec_01",
        Location = vector4(908.41, -3226.85, -99.29, 69.18),
        AnimationDict = "amb@world_human_drinking@coffee@male@idle_a",
        AnimationClip = "idle_c",
        SellableItems = {
            {name = "ammo-9", value = math.random(1, 2)},
            {name = "ammo-rifle", value = math.random(1, 2)},
            {name = "ammo-rifle2", value = math.random(1, 2)},
            {name = "ammo-45", value = math.random(1, 2)},
            {name = "ammo-shotgun", value = math.random(1, 2)},
        },
    },
}

Config.EntranceTypes = {
    Riddles = {
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
    },
}

Config.Hacking = {
    RandomNumberCode = math.random(11111, 99999),
    RequiredHackingItem = "laptop",
    HackingGlobalCooldownInMinutes = 25,
    HackingZones = {
        {
            coords = vec3(116.35, -747.4, 45.75),
            size = vec3(4.1, 1.2, 1.3),
            rotation = 294.5,
        },
    },
}

-----------------
--Money Washing--
-----------------

Config.Laundering = {
    {
        launderName = "Grapeseed",
        pedModel = "s_m_m_linecook",
        location = vector4(2439.8, 4977.93, 45.81, 47.18),
        launderTimeInMinutes = 25,
        percentageTakenFromPlayer = 0.285,
        animInfo = {
            active = true, -- Set to false if using scenario below
            dict = "amb@world_human_aa_smoke@male@idle_a",
            clip = "idle_c",
        },
        propInfo = {
            active = true, -- Set to false to have no props
            propModel = "prop_cs_ciggy_01",
            bone = 28422,
            placement = {
                x = 0.0,
                y = 0.0,
                z = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
            },
        },
    },
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