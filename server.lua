local QBCore = exports['qb-core']:GetCoreObject()

local function UpdatePlayerBagStatus(source, bagId)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        MySQL.update('UPDATE players SET bag_status = ? WHERE citizenid = ?', {
            bagId,
            Player.PlayerData.citizenid
        })
    end
end

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        MySQL.single('SELECT bag_status FROM players WHERE citizenid = ?', {
            Player.PlayerData.citizenid
        }, function(result)
            if result and result.bag_status then
                TriggerClientEvent('bag_weight_modifier:loadBagStatus', src, result.bag_status)
            end
        end)
    end
end)

RegisterNetEvent('bag_weight_modifier:saveBagStatus', function(bagId)
    local src = source
    UpdatePlayerBagStatus(src, bagId)
end)

RegisterNetEvent('bag_weight_modifier:updateWeight', function(weight)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    
    -- Add debug prints
    print('Setting weight for player: ' .. src)
    print('New weight value: ' .. weight)
    
    exports.ox_inventory:SetMaxWeight(src, weight)
    
    if Player then
        Player.Functions.SetPlayerData('metadata.maxweight', weight)
        Player.Functions.UpdatePlayerData()
    end
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        xPlayer.Functions.SetMetaData('maxweight', weight)
    end
end)

CreateThread(function()
    MySQL.query([[
        SELECT COUNT(*) as columnExists 
        FROM information_schema.COLUMNS 
        WHERE TABLE_NAME = 'players' 
        AND COLUMN_NAME = 'bag_status'
    ]], {}, function(result)
        if result[1].columnExists == 0 then
            MySQL.query([[
                ALTER TABLE players
                ADD COLUMN bag_status VARCHAR(50) DEFAULT NULL
            ]])
            print('Successfully created bag_status column in players table')
        end
    end)
end)