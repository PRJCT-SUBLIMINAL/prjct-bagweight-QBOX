Config = {}

-- Debug mode (true for verbose output in console)
Config.Debug = false

-- List of bags and their respective weight increases
Config.Bags = {
    { drawableId = 40, weightIncrease = 8000 },
    { drawableId = 41, weightIncrease = 8000 },
    { drawableId = 44, weightIncrease = 8000 },
    { drawableId = 45, weightIncrease = 8000 },
    { drawableId = 81, weightIncrease = 8000 },
    { drawableId = 82, weightIncrease = 8000 },
    { drawableId = 85, weightIncrease = 8000 },
    { drawableId = 86, weightIncrease = 8000 },
    { drawableId = 156, weightIncrease = 2000 },
    { drawableId = 159, weightIncrease = 2000 },
    { drawableId = 160, weightIncrease = 2000 },
    { drawableId = 161, weightIncrease = 2000 },
    { drawableId = 162, weightIncrease = 10000 },
    { drawableId = 163, weightIncrease = 2000 },
}

Config.AddonBags = {
    { drawableId = 201, weightIncrease = 2000 },
    { drawableId = 201, weightIncrease = 2000 },
}

-- Default inventory weight (used if no bag is equipped)
Config.DefaultWeight = 28000 -- 28kg
