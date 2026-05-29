ESX = nil
QBCore = nil
local recPaid = {}

if Config.UseESX then
    pcall(function() ESX = exports["es_extended"]:getSharedObject() end)
elseif Config.UseQBCore then
    local attempts = 0
    while not QBCore and attempts < 10 do
        pcall(function() QBCore = exports['qb-core']:GetCoreObject() end)
        if not QBCore then
            pcall(function() QBCore = exports['qbx_core']:GetCoreObject() end)
        end
        if not QBCore then attempts = attempts + 1; Wait(500) end
    end
    if not QBCore then
        print("^1[CIVILIAN-JOBS] ERRO: Não foi possível carregar o Qbox/QBCore via Bridge!^7")
    else
        print("^2[CIVILIAN-JOBS] Framework Qbox/QBCore carregado no servidor!^7")
    end
end

-- ==========================================
-- GERENCIAMENTO DE STATS (XP/LEVEL)
-- ==========================================

function GetPlayerIdentifier(source)
    if Config.UseQBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player and Player.PlayerData.citizenid or nil
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer and xPlayer.getIdentifier() or nil
    end
end

function GetPlayerStats(source)
    local identifier = GetPlayerIdentifier(source)
    if not identifier then return { xp = 0, level = 1 } end
    
    local status, result = pcall(function()
        return MySQL.Sync.fetchAll('SELECT xp, level FROM angelicxs_civilian_stats WHERE identifier = ?', {identifier})
    end)
    
    if status and result and result[1] then
        return { xp = result[1].xp, level = result[1].level }
    else
        pcall(function() 
            MySQL.Sync.execute('INSERT INTO angelicxs_civilian_stats (identifier, xp, level) VALUES (?, ?, ?)', {identifier, 0, 1})
        end)
        return { xp = 0, level = 1 }
    end
end

function AddPlayerXP(source, amount)
    local src = source
    local identifier = GetPlayerIdentifier(src)
    local xpToAdd = tonumber(amount)

    local stats = GetPlayerStats(src)
    local newXP = stats.xp + math.floor(xpToAdd)
    local newLevel = stats.level
    local nextLevelXP = ((newLevel + 1) ^ 2) * 100
    
    if newXP >= nextLevelXP then
        newLevel = newLevel + 1
        TriggerClientEvent('angelicxs-CivilianJobs:Notify', src, "PARABÉNS! Você subiu para o NÍVEL " .. newLevel, "success")
    else
        TriggerClientEvent('angelicxs-CivilianJobs:Notify', src, "XP +" .. math.floor(xpToAdd), "primary")
    end
    
    MySQL.Async.execute('UPDATE angelicxs_civilian_stats SET xp = ?, level = ? WHERE identifier = ?', {newXP, newLevel, identifier})
    
    -- Sincronizar com o cliente (para o Tablet)
    TriggerClientEvent('angelicxs-CivilianJobs:Client:UpdateStats', src, { xp = newXP, level = newLevel })
end

-- Callback para o Client/NUI (Protegido)
if QBCore then
    QBCore.Functions.CreateCallback('angelicxs-CivilianJobs:Server:GetStats', function(source, cb)
        cb(GetPlayerStats(source))
    end)
end

-- ==========================================
-- SISTEMA DE PAGAMENTO E RECOMPENSAS
-- ==========================================

-- Função auxiliar de pagamento com bônus
function ProcessPayment(src, amount, reason)
    local paymentAmount = tonumber(amount)

    if not paymentAmount or paymentAmount <= 0 then 
        return 
    end

    if not recPaid[src] then
        recPaid[src] = true
        local stats = GetPlayerStats(src)
        local bonusMultiplier = (stats.level - 1) * 0.02 -- 2% bônus por nível acima do 1
        local bonusAmount = math.floor(paymentAmount * bonusMultiplier)
        local totalAmount = paymentAmount + bonusAmount

        if Config.UseESX then
            local xPlayer = ESX.GetPlayerFromId(src)
            if xPlayer then xPlayer.addAccountMoney(Config.AccountMoney, totalAmount) end
        elseif Config.UseQBCore then
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then 
                Player.Functions.AddMoney(Config.AccountMoney, totalAmount, tostring(reason)) 
            end
        end

        AddPlayerXP(src, paymentAmount) -- Ganha 1 XP a cada $1 (MAIS JUSTO)
        TriggerClientEvent('angelicxs-CivilianJobs:Notify', src, "Pagamento: $"..totalAmount.." (Bônus Lvl: $"..bonusAmount..")", "success")
        
        SetTimeout(1000, function() recPaid[src] = false end)
    end
end

-- Pagamento Fixo (Flat)
RegisterNetEvent('angelicxs-CivilianJobs:Server:PaymentFlat', function(amount, reason)
    ProcessPayment(source, amount, reason)
end)

-- Pagamento por Distância
RegisterNetEvent('angelicxs-CivilianJobs:Server:DistancePayment', function(amount, reason)
    ProcessPayment(source, amount, reason)
end)

-- Entrega de Itens
RegisterNetEvent('angelicxs-CivilianJobs:Server:PaymentItem', function(itemData, reason)
    local src = source
    if not itemData or not itemData.name then return end
    
    local amount = math.random(tonumber(itemData.min) or 1, tonumber(itemData.max) or 1)
    print("^3[DEBUG] PaymentItem iniciado para ID: " .. tostring(src) .. " | Item: " .. tostring(itemData.name) .. " | Qtd: " .. amount .. "^7")
    
    if Config.UseESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then xPlayer.addInventoryItem(itemData.name, amount) end
    elseif Config.UseQBCore then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then 
            Player.Functions.AddItem(itemData.name, amount, false, {reason = tostring(reason)})
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemData.name], "add")
            print("^2[DEBUG] Item adicionado com sucesso via Qbox/QBCore.^7")
        end
    end

    AddPlayerXP(src, amount * 5) -- Itens dão um pouco de XP
    TriggerClientEvent('angelicxs-CivilianJobs:Notify', src, "Recebeu: "..amount.."x "..itemData.name, "success")
end)

-- Verificação de dinheiro para o Helicóptero
RegisterNetEvent('angelicxs-CivilianJobs:HeliJob:CheckMoney', function(amount)
    local src = source
    local hasMoney = false
    local cost = tonumber(amount) or 0

    print("^3[DEBUG] Verificando dinheiro para Heli (ID: " .. tostring(src) .. ") | Custo: " .. cost .. "^7")

    if Config.UseESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer and xPlayer.getMoney() >= cost then
            xPlayer.removeMoney(cost)
            hasMoney = true
        end
    elseif Config.UseQBCore then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player and Player.Functions.RemoveMoney('cash', cost, "Aluguel de Helicóptero - Civilian Jobs") then
            hasMoney = true
        end
    end

    if hasMoney then
        print("^2[DEBUG] Dinheiro removido com sucesso. Spawnando Heli.^7")
        TriggerClientEvent('angelicxs-CivilianJobs:HeliJob:SpawnHeli', src)
    else
        print("^1[DEBUG] Erro: Dinheiro insuficiente para ID " .. tostring(src) .. "^7")
        TriggerClientEvent('angelicxs-CivilianJobs:Notify', src, "Você não tem dinheiro suficiente para alugar o helicóptero!", "error")
    end
end)

-- Evento genérico (compatibilidade)
RegisterNetEvent('angelicxs-CivilianJobs:Server:Payment', function(amount)
    ProcessPayment(source, amount, "Generic Payment")
end)
