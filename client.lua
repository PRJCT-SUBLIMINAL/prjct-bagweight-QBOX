local currentBagWeight = 0
local isInitialized = false
local lastDrawable, lastAddonDrawable

local function DebugPrint(msg)
    if Config.Debug then
        print("[BagWeightModifier] " .. msg)
    end
end

local function GetBagWeight()
    local playerPed = PlayerPedId()
    local drawableId = GetPedDrawableVariation(playerPed, 5)
    local addonDrawableId = GetPedDrawableVariation(playerPed, 7)

    for _, addonBag in pairs(Config.AddonBags) do
        if addonBag.drawableId == addonDrawableId then
            return addonBag.weightIncrease
        end
    end

    for _, bag in pairs(Config.Bags) do
        if bag.drawableId == drawableId then
            return bag.weightIncrease
        end
    end

    return 0
end

local function UpdateWeight()
    local newBagWeight = GetBagWeight()
    if newBagWeight ~= currentBagWeight then
        currentBagWeight = newBagWeight
        local totalWeight = Config.DefaultWeight + currentBagWeight
        exports.ox_inventory:setMaxWeight(totalWeight)
        DebugPrint("Weight updated to: " .. totalWeight)
    end
end

CreateThread(function()
    while true do
        if NetworkIsPlayerActive(PlayerId()) then
            if not isInitialized then
                UpdateWeight()
                isInitialized = true
            end
            
            local playerPed = PlayerPedId()
            local currentDrawable = GetPedDrawableVariation(playerPed, 5)
            local currentAddonDrawable = GetPedDrawableVariation(playerPed, 7)
            
            if currentDrawable ~= lastDrawable or currentAddonDrawable ~= lastAddonDrawable then
                lastDrawable = currentDrawable
                lastAddonDrawable = currentAddonDrawable
                UpdateWeight()
            end
        end
        Wait(1000)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Wait(2000)
    UpdateWeight()
    isInitialized = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerSpawn')
AddEventHandler('QBCore:Client:OnPlayerSpawn', function()
    UpdateWeight()
end)

-- Debug command to check current weight
RegisterCommand('checkweight', function()
    local currentWeight = exports.ox_inventory:getCurrentWeight()
    local maxWeight = exports.ox_inventory:getMaxWeight()
    print(string.format('Current Weight: %s / %s', currentWeight, maxWeight))
end, false)
