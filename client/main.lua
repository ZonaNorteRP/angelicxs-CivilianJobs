PlayerData, PlayerJob = nil, nil
FreeWork, MissionRoute, MissionVehicle, NPC, VehicleDestroyed = false, nil, nil, nil, false
SpawnedNPCs = {}
CurrentJobLocation, ActiveCivJob = nil, nil
CachedStats = { xp = 0, level = 1 } -- Cache local para abertura instantânea

ESX = nil
QBCore = nil

-- ==========================================
-- FUNÇÕES TÉCNICAS (PRECISAM ESTAR NO TOPO)
-- ==========================================

function HashGrabber(model)
    local hash = GetHashKey(model)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do Wait(10) end
    end
    return hash
end

function JobBlip(coords, sprite, colour, name)
    local jobBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(jobBlip, sprite)
    SetBlipScale(jobBlip, Config.JobBlipSize or 0.8)
    SetBlipAsShortRange(jobBlip, true)
    SetBlipColour(jobBlip, colour)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(name)
    EndTextCommandSetBlipName(jobBlip)
    return jobBlip
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function Job3DText(location, event, event2)
    if Config.Use3DText then
        CreateThread(function()
            while true do
                local Sleep = 2000
                local Pos = GetEntityCoords(PlayerPedId())
                local Dist = #(Pos - vector3(location.x, location.y, location.z))
                if Dist <= 5.0 then
                    Sleep = 0
                    DrawText3Ds(location.x, location.y, location.z, Config.Lang['request_work_3d'] or "~g~[E]~w~ Solicitar Trabalho")
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent(event)
                    elseif event2 and IsControlJustReleased(0, 47) then
                        TriggerEvent(event2)
                    end
                end
                Wait(Sleep)
            end
        end)
    end
end

function Randomizer(list, reason)
    if not list or #list == 0 then 
        print("^1[CIVILIAN-JOBS] Randomizer falhou para: " .. tostring(reason) .. "^7")
        return nil 
    end
    return list[math.random(1, #list)]
end

function LoadAnim(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do Wait(10) end
    end
end

-- ==========================================
-- SISTEMA DE PAGAMENTO E XP (RESTAURADO)
-- ==========================================

function PaymentItem(item, reason)
    TriggerServerEvent('angelicxs-CivilianJobs:Server:PaymentItem', item, reason)
end

function PaymentFlat(amount, reason)
    local amt = tonumber(amount) or 0
    TriggerServerEvent('angelicxs-CivilianJobs:Server:PaymentFlat', amt, reason)
end

function DistancePayment(startPos, endPos, reason, multiplier)
    local dist = #(startPos - endPos)
    local mult = tonumber(multiplier) or 1
    local total = math.floor(dist * mult)
    
    TriggerServerEvent('angelicxs-CivilianJobs:Server:DistancePayment', total, reason)
end

-- ==========================================
-- INICIALIZAÇÃO DE FRAMEWORK
-- ==========================================

CreateThread(function()
    if Config.UseESX then
        pcall(function() ESX = exports["es_extended"]:getSharedObject() end)
        while not ESX do Wait(100); pcall(function() ESX = exports["es_extended"]:getSharedObject() end) end
        while not ESX.IsPlayerLoaded() do Wait(100) end
        PlayerData = ESX.GetPlayerData()
        PlayerJob = PlayerData.job.name
        RegisterNetEvent('esx:setJob', function(job) PlayerJob = job.name end)
    elseif Config.UseQBCore then
        local attempts = 0
        while not QBCore and attempts < 10 do
            pcall(function() QBCore = exports['qb-core']:GetCoreObject() end)
            if not QBCore then attempts = attempts + 1; Wait(500) end
        end
        if QBCore then
            print("^2[CIVILIAN-JOBS] Framework Qbox/QBCore carregado!^7")
            PlayerData = QBCore.Functions.GetPlayerData()
            while not PlayerData or not PlayerData.citizenid do
                Wait(100)
                PlayerData = QBCore.Functions.GetPlayerData()
            end
            PlayerJob = PlayerData.job.name
            RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job) PlayerJob = job.name end)
            
            QBCore.Functions.TriggerCallback('angelicxs-CivilianJobs:Server:GetStats', function(stats)
                if stats then CachedStats = stats end
            end)
        end
    end

    if not Config.UsePlayerJob then
        FreeWork = true
    end
end)

-- Notificações
RegisterNetEvent('angelicxs-CivilianJobs:Notify', function(message, type)
	if Config.UseCustomNotify then
        TriggerEvent('angelicxs-CivilianJobs:CustomNotify',message, type)
	elseif Config.UseESX then
		ESX.ShowNotification(message)
	elseif Config.UseQBCore and QBCore then
		QBCore.Functions.Notify(message, type)
	end
end)

-- ==========================================
-- SISTEMA DE TABLET NUI
-- ==========================================

function OpenJobTablet(filterJobId)
    RenderTabletUI(CachedStats, filterJobId)
    if QBCore then
        QBCore.Functions.TriggerCallback('angelicxs-CivilianJobs:Server:GetStats', function(stats)
            if stats then
                CachedStats = stats
                SendNUIMessage({ action = 'updateStats', stats = stats })
            end
        end)
    end
end

function RenderTabletUI(stats, filterJobId)
    local allJobs = {
        { id = 'forklift-driver', name = 'Operador de Empilhadeira', icon = 'fa-solid fa-truck-ramp-box', enabled = Config.ForkliftJobOn, event = 'angelicxs-CivilianJobs:ForkliftJob:AskForWork' },
        { id = 'bus-driver', name = 'Motorista de Ônibus', icon = 'fa-solid fa-bus', enabled = Config.BusJobOn, event = 'angelicxs-CivilianJobs:BusJob:AskForWork' },
        { id = 'taxi-driver', name = 'Taxista', icon = 'fa-solid fa-taxi', enabled = Config.TaxiJobOn, event = 'angelicxs-CivilianJobs:TaxiJob:AskForWork' },
        { id = 'scuba-diver', name = 'Mergulhador Profissional', icon = 'fa-solid fa-person-swimming', enabled = Config.ScubaJobOn, event = 'angelicxs-CivilianJobs:ScubaJob:AskForWork' },
        { id = 'lifeguard', name = 'Salva-Vidas / Jet Ski', icon = 'fa-solid fa-life-ring', enabled = Config.JetSkiJobOn, event = 'angelicxs-CivilianJobs:JetskiJob:AskForWork' },
        { id = 'heli-driver', name = 'Piloto de Helicóptero', icon = 'fa-solid fa-helicopter', enabled = Config.HeliJobOn, event = 'angelicxs-CivilianJobs:HeliJob:AskForWork' },
        { id = 'garbage-driver', name = 'Coletor de Lixo', icon = 'fa-solid fa-trash-can', enabled = Config.GarbageJobOn, event = 'angelicxs-CivilianJobs:GarbageJob:AskForWork' },
    }

    local filteredJobs = {}
    if filterJobId then
        for _, job in ipairs(allJobs) do
            if job.id == filterJobId then table.insert(filteredJobs, job) end
        end
    else
        filteredJobs = allJobs
    end

    SendNUIMessage({
        action = 'open',
        stats = stats,
        jobs = filteredJobs,
        activeJob = MissionRoute and (ActiveCivJob or filterJobId or 'active-job') or nil,
        isFiltered = (filterJobId ~= nil)
    })
    SetNuiFocus(true, true)
end

-- Callbacks NUI
RegisterNUICallback('close', function(data, cb) SetNuiFocus(false, false); cb('ok') end)
RegisterNUICallback('nuiLoaded', function(data, cb) cb('ok') end)

RegisterNUICallback('startJob', function(data, cb)
    local hasJob = false
    if MissionRoute and DoesBlipExist(MissionRoute) then hasJob = true end
    if hasJob then
        TriggerEvent('angelicxs-CivilianJobs:Notify', 'Você já possui um serviço ativo!', 'error')
    else
        ActiveCivJob = data.job
        TriggerEvent(data.event)
    end
    cb('ok')
end)

RegisterNUICallback('applyUniform', function(data, cb)
    if data.job then
        TriggerEvent('angelicxs-CivilianJobs:Uniforms:Apply', data.job)
    end
    cb('ok')
end)

RegisterNUICallback('removeUniform', function(data, cb)
    TriggerEvent('angelicxs-CivilianJobs:Uniforms:Remove')
    cb('ok')
end)

RegisterNUICallback('endJob', function(data, cb)
    TriggerEvent('angelicxs-CivilianJobs:Main:ResetJobs')
    cb('ok')
end)

-- ==========================================
-- SISTEMA DE NPC E TARGET
-- ==========================================

RegisterNetEvent('angelicxs-CivilianJobs:MAIN:SpawnBossNPC', function(model, coords, eventTrigger, eventTrigger2, askedEvent, config)
    if not Config.UsePedAsJobBoss then return end
    local jobName = nil
    local cleanEvent = string.lower(tostring(askedEvent))
    local cleanTrigger = string.lower(tostring(eventTrigger))
    if string.find(cleanEvent, 'bus') or string.find(cleanTrigger, 'bus') then jobName = 'bus-driver'
    elseif string.find(cleanEvent, 'taxi') or string.find(cleanTrigger, 'taxi') then jobName = 'taxi-driver'
    elseif string.find(cleanEvent, 'forklift') or string.find(cleanTrigger, 'forklift') then jobName = 'forklift-driver'
    elseif string.find(cleanEvent, 'scuba') or string.find(cleanTrigger, 'scuba') then jobName = 'scuba-diver'
    elseif string.find(cleanEvent, 'jetski') or string.find(cleanTrigger, 'jetski') or string.find(cleanTrigger, 'lifeguard') then jobName = 'lifeguard'
    elseif string.find(cleanEvent, 'heli') or string.find(cleanTrigger, 'heli') then jobName = 'heli-driver'
    elseif string.find(cleanEvent, 'garbage') or string.find(cleanTrigger, 'garbage') then jobName = 'garbage-driver'
    end
    CurrentJobLocation = jobName
    local hash = HashGrabber(model)
    local currentPos = vector3(coords[1], coords[2], coords[3])
    
    -- Check if we already have a spawned NPC for this job to prevent duplication
    if jobName and SpawnedNPCs[jobName] and DoesEntityExist(SpawnedNPCs[jobName]) then
        if #(GetEntityCoords(SpawnedNPCs[jobName]) - currentPos) < 5.0 then
            return
        else
            DeleteEntity(SpawnedNPCs[jobName])
            SpawnedNPCs[jobName] = nil
        end
    end
    
    if DoesEntityExist(NPC) and #(GetEntityCoords(NPC) - currentPos) < 2.0 then return end
    local newNPC = CreatePed(1, hash, coords[1], coords[2], coords[3]-1.0, coords[4], false, false)
    SetEntityInvincible(newNPC, true)
    SetEntityHeading(newNPC, coords[4])
    FreezeEntityPosition(newNPC, true)
    SetBlockingOfNonTemporaryEvents(newNPC, true)
    TaskStartScenarioInPlace(newNPC,'WORLD_HUMAN_CLIPBOARD', 0, false)
    NPC = newNPC
    if jobName then
        SpawnedNPCs[jobName] = newNPC
    end
    if Config.UseThirdEye and Config.ThirdEyeName == 'ox_target' then
        exports.ox_target:addBoxZone({
            name = "CivJobNPC_"..tostring(askedEvent),
            coords = vec3(coords[1], coords[2], coords[3] + 0.5),
            size = vec3(1.5, 1.5, 2.5),
            rotation = coords[4],
            options = {
                {
                    icon = 'fa-solid fa-tablet-screen-button',
                    label = 'Abrir Terminal de Emprego',
                    onSelect = function()
                        SetNuiFocus(true, true)
                        OpenJobTablet(jobName)
                    end,
                },
                {
                    icon = 'fa-solid fa-warehouse',
                    label = Config.Lang['vehicle_return_request'],
                    event = 'angelicxs-CivilianJobs:MAIN:RemoveVehicle',
                }
            }
        })
    end
end)

-- ==========================================
-- GERENCIAMENTO DE MISSÕES
-- ==========================================

RegisterNetEvent('angelicxs-CivilianJobs:MAIN:CreateVehicle', function(model, spawn, askedEvent)
    if VehicleDestroyed then
        TriggerEvent('angelicxs-CivilianJobs:Notify', Config.Lang['vehicle_destroyed_notice'], 'info')
        return
    end
    if DoesEntityExist(MissionVehicle) then return end
    local hash = HashGrabber(model)
    ClearAreaOfVehicles(spawn.x,spawn.y,spawn.z, 5, false, false, false, false, false)
    MissionVehicle = CreateVehicle(hash, spawn.x, spawn.y, spawn.z, spawn.w, true, true)
    SetEntityAsMissionEntity(MissionVehicle, true, true)
    TriggerEvent('angelicxs-CivilianJobs:VehicleInitation', MissionVehicle)
    
    local jobName = nil
    local cleanEvent = string.lower(tostring(askedEvent))
    if string.find(cleanEvent, 'bus') then jobName = 'bus-driver'
    elseif string.find(cleanEvent, 'taxi') then jobName = 'taxi-driver'
    elseif string.find(cleanEvent, 'forklift') then jobName = 'forklift-driver'
    elseif string.find(cleanEvent, 'scuba') then jobName = 'scuba-diver'
    elseif string.find(cleanEvent, 'jetski') or string.find(cleanEvent, 'lifeguard') then jobName = 'lifeguard'
    elseif string.find(cleanEvent, 'heli') then jobName = 'heli-driver'
    elseif string.find(cleanEvent, 'garbage') then jobName = 'garbage-driver'
    end
    if jobName then
        ActiveCivJob = jobName
    end
end)

RegisterNetEvent('angelicxs-CivilianJobs:MAIN:RemoveVehicle', function()
    if not DoesEntityExist(MissionVehicle) then
        TriggerEvent('angelicxs-CivilianJobs:Notify', Config.Lang['vehicle_not_out'], 'error')
        return
    end
    DeleteEntity(MissionVehicle)
    MissionVehicle = nil
    TriggerEvent('angelicxs-CivilianJobs:Notify', Config.Lang['vehicle_return'], 'success')
    TriggerEvent('angelicxs-CivilianJobs:Main:ResetJobs')
end)

RegisterNetEvent('angelicxs-CivilianJobs:Main:ResetJobs', function()
    if DoesBlipExist(MissionRoute) then RemoveBlip(MissionRoute); MissionRoute = nil end
    if DoesEntityExist(MissionVehicle) then DeleteEntity(MissionVehicle); MissionVehicle = nil end
    ActiveCivJob = nil
    TriggerEvent('angelicxs-CivilianJobs:Notify', 'Serviço ativo limpo.', 'info')
end)

RegisterNetEvent('angelicxs-CivilianJobs:MAIN:RouteMarker', function(isTable, route, routeName, askedEvent)
    if not route then return end
    if isTable then
        for i = 1, #route do
            MissionRoute = AddBlipForCoord(route[i].x, route[i].y, route[i].z)
            SetBlipColour(MissionRoute,Config.BlipMarkerColour or 3)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(routeName)
            EndTextCommandSetBlipName(MissionRoute)
            SetBlipRoute(MissionRoute, true)
            while true do
                local dist = #(GetEntityCoords(PlayerPedId()) - vector3(route[i].x, route[i].y, route[i].z))
                if dist <= 15 then
                    RemoveBlip(MissionRoute)
                    MissionRoute = nil
                    TriggerEvent('angelicxs-CivilianJobs:Notify', Config.Lang['at_route_marker'], 'success')
                    break
                end
                Wait(1000)            
            end
        end    
    else
        MissionRoute = AddBlipForCoord(route.x, route.y, route.z)
        SetBlipColour(MissionRoute,Config.BlipMarkerColour or 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(routeName)
        EndTextCommandSetBlipName(MissionRoute)
        SetBlipRoute(MissionRoute, true)
        while true do
            local dist = #(GetEntityCoords(PlayerPedId()) - vector3(route.x, route.y, route.z))
            if dist <= 15 then
                RemoveBlip(MissionRoute)
                MissionRoute = nil
                TriggerEvent('angelicxs-CivilianJobs:Notify', Config.Lang['at_route_marker'], 'success')
                break
            end
            Wait(1000)            
        end
    end
end)

-- Limpeza e Comandos
AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        if SpawnedNPCs then
            for _, npc in pairs(SpawnedNPCs) do
                if DoesEntityExist(npc) then DeleteEntity(npc) end
            end
        end
        if DoesEntityExist(NPC) then DeleteEntity(NPC) end
        if DoesEntityExist(MissionVehicle) then DeleteEntity(MissionVehicle) end
        if DoesBlipExist(MissionRoute) then RemoveBlip(MissionRoute) end
    end
end)

-- Keymapping to cancel active civilian job (F7)
RegisterCommand('cancelcivjob', function()
    if ActiveCivJob or DoesEntityExist(MissionVehicle) or DoesBlipExist(MissionRoute) then
        TriggerEvent('angelicxs-CivilianJobs:Main:ResetJobs')
        TriggerEvent('angelicxs-CivilianJobs:Uniforms:Remove')
    else
        TriggerEvent('angelicxs-CivilianJobs:Notify', 'Você não possui nenhum serviço ativo para cancelar.', 'error')
    end
end, false)

RegisterKeyMapping('cancelcivjob', 'Cancelar Trabalho Civil', 'keyboard', 'F7')

-- Sincronização de Stats (XP/Level)
RegisterNetEvent('angelicxs-CivilianJobs:Client:UpdateStats', function(stats)
    if not stats then return end
    CachedStats = stats
    SendNUIMessage({
        action = 'updateStats',
        stats = stats
    })
end)