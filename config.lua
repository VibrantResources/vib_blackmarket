Config = Config or {}

Config.Debug = false
Config.UseAnims = true -- set to false if you want peds to be static with no animations
Config.DirtyMoneyItem = "black_money" -- Currency item used to make purchases with market peds
Config.CleanMoneyItem = "money"

Config.BlackMarketAccess = {
    EntranceInfo = {
        EntranceLandingLocation = vector4(892.62, -3245.87, -98.28, 73.49), -- Where the player lands after being teleported inside
        EntranceLocations = { -- Randomly selected upon server/resource restart
            {
                pedModel = "a_m_m_hasjew_01",
                location = vector4(726.63, 4190.56, 39.7, 258.79),
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
        {
            Question = "How many vehicles are currently on LSPD's watch list?",
            Answers = {
                "75",
                "60",
                "115",
                "22",
            },
            Correct_Answer = "60",
        },
        {
            Question = "How many families are within this city?",
            Answers = {
                "Three",
                "Four",
                "Seven",
                "Fifteen",
            },
            Correct_Answer = "Three",
        },
        {
            Question = "What time does the security on the power grid clock off?",
            Answers = {
                "00:00am",
                "12:00pm",
                "08:00am",
                "17:00pm",
            },
            Correct_Answer = "12:00pm",
        },
        {
            Question = "Mind telling me where you'd get a boost contract from?",
            Answers = {
                "Sandy Shores race track",
                "Casino",
                "Franks Emoprium",
                "Southside",
                "Paleto bay garage"
            },
            Correct_Answer = "Sandy Shores race track",
        },
        {
            Question = "Do you know where to get some good stuff?",
            Answers = {
                "The Nudist colony",
                "The back of that southside restaurant",
                "Paleto bay docks",
                "The oil refinery",
                "You could always grow your own in the hills"
            },
            Correct_Answer = "The Nudist colony",
        },
        {
            Question = "What would I need to make a device that could hack a vault panel?",
            Answers = {
                "A trojan USB",
                "A screwdriver set",
                "Some copper wire",
                "An old phone",
                "Some gold"
            },
            Correct_Answer = "Some copper wire",
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
        {
            coords = vec3(1267.7, -1710.4, 54.5),
            size = vec3(1.25, 1.0, 1.25),
            rotation = 294.4,
        },
    },
}

-----------------
--Money Washing--
-----------------

Config.Laundering = {
    {
        shopName = "Grapeseed",
        pedModel = "s_m_m_linecook",
        location = vector4(2439.8, 4977.93, 45.81, 47.18),
        launderTimeInMinutes = 25,
        percentageTakenFromPlayer = 0.285,
        animInfo = {
            active = true, -- Set to false if using scenario below
            dict = "amb@world_human_aa_smoke@male@idle_a",
            clip = "idle_c",
        },
        -- propInfo = {
        --     active = true, -- Set to false to have no props
        --     propModel = "prop_cs_ciggy_01",
        --     bone = 28422,
        --     placement = {
        --         x = 0.0,
        --         y = 0.0,
        --         z = 0.0,
        --         xRot = 0.0,
        --         yRot = 0.0,
        --         zRot = 0.0,
        --     },
        -- },
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
        {
            PedModel = "s_m_m_chemsec_01",
            SpawnLocation = vector4(888.95, -3194.64, -99.2, 165.48),
            PlayAnim = false,
            AnimationDict = "amb@world_human_welding@male@base",
            AnimationClip = "base",
            PlayScenario = true,
            Scenario = 'WORLD_HUMAN_GUARD_PATROL',
            IsPedArmed = false,
            WeaponIfArmed = nil,
        },
        {
            PedModel = "s_m_m_chemsec_01",
            SpawnLocation = vector4(891.74, -3211.22, -99.2, 205.19),
            PlayAnim = true,
            AnimationDict = "mini@repair",
            AnimationClip = "fixing_a_ped",
            PlayScenario = false,
            Scenario = 'WORLD_HUMAN_WELDING',
            IsPedArmed = false,
            WeaponIfArmed = 453432689,
            
        },
        {
            PedModel = "s_m_m_chemsec_01",
            SpawnLocation = vector4(903.17, -3182.84, -98.05, 99.65),
            PlayAnim = true,
            AnimationDict = "anim@amb@business@bgen@bgen_no_work@",
            AnimationClip = "stand_phone_phoneputdown_idle_nowork",
            PlayScenario = false,
            Scenario = 'WORLD_HUMAN_WELDING',
            IsPedArmed = false,
            WeaponIfArmed = 736523883,
        },
    },
}