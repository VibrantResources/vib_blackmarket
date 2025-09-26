RegisterNetEvent("blackmarket:RiddleInput", function()
    local randomKey = math.random(1, #Config.EntranceTypes.Riddles)
    local riddle = Config.EntranceTypes.Riddles[randomKey]
    local options = {}

    math.randomseed(GetGameTimer())

    local randomised = {}
    for _, answer in ipairs(riddle.Answers) do
        local key = math.random(1, #randomised + 1)
        table.insert(randomised, key, answer)
    end

    for k, answer in ipairs(randomised) do
        table.insert(options, {
            value = k,
            label = answer,
        })
    end

    local input = lib.inputDialog(riddle.Question, {
        {
            type = "select",
            label = "Select Answer",
            description = "Choose carefully",
            options = options,
            required = true,
            icon = "fa-solid fa-question",
            iconColor = "yellow",
        },
    })

    if not input or not input[1] then
        return
    end

    local selectedOption = options[input[1]]
    if selectedOption == nil then
        print("No answer selected")
    end

    local selectedAnswer = selectedOption.label

    local function formatAnswer(str)
        return str:lower():gsub("%s+", "")
    end

    if formatAnswer(selectedAnswer) == formatAnswer(riddle.Correct_Answer) then
        SpawnKidnapPed()
        lib.notify({
            title = 'Good job',
            description = 'You got the answer right!',
            type = 'success',
        })
    else
        lib.notify({
            title = 'Incorrect',
            description = 'You got the answer wrong!',
            type = 'error',
        })
    end
end)

RegisterNetEvent("blackmarket:CodeInput", function()
    local requiredCode = lib.callback.await('blackmarket:server:GenerateNumberCode', false)

    local codeInput = lib.inputDialog('Code Input', {
        {
            type = "number",
            label = "What's todays entrance code?",
            description = "Entrance Code:",
            required = true,
            icon = "fa-solid fa-hashtag",
            iconColor = "green",
        },
    })

    if not codeInput then return end

    if codeInput[1] == requiredCode then
        SpawnKidnapPed()
    else
        lib.alertDialog({
            header = "Mr. 0:",
            content = "That isn't the code ... stop wasting our time!",
            centered = true,
        })
    end
end)