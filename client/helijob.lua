----------------------------------------------------------------------
--				Helicopter Configuration Options					--
--			 The following options can be changed to make your      --
--			  helicopter job unique and suit your server      		--
----------------------------------------------------------------------

local Heli_Options = {
    Boss = {
        Location = vector4(-1177.19, -2832.88, 13.95, 157.16),
        Model = 's_m_y_airworker',
        Name = "Miguel",
        tag = "PILOTO",
        message = "👋 Olá, me chamo 😃**Miguel Santos**, mas pode me chamar de **Seu Miguel**.  \nVou te ensinar a como trabalhar aqui na 🚁 empresa de transporte aéreo. É bem simples!  \nTe daremos o helicóptero e você pegará as cargas nos locais marcados e levará até o destino. 📦  \nCuidado para não danificar a carga durante o voo!  \nAgora larga mão de preguiça e vai trabalhar! 💼👊"
    },
    Sprite = {
        icon = 64,
        colour = 48,
        name = 'Empresa de Air Cargo',
    },
    Heli = {
        Spawn = vector4(-1178.76, -2846.53, 13.95, 151.0),
        Type = {
            'frogger',
        },
        SpawnCost = 8000, -- Custo ajustado para rentabilidade de $12k/h
    },
    Payment = {
        flatRate = false,
        flatRateAmount = 100,
        DistanceMultiplier = 0.33, -- Only applies if flatRate = false, pays driver based on multiplying distance from pick up to drop off.
    },
}

local crateOptions = {
    CrateAllowMarker = true,
    CrateLocationMarker = 34,
    Location = {
        vector3(-1199.59, -2885.95, 13.95),
        vector3(-1123.6, -2930.38, 13.95),
        vector3(-1079.36, -3060.27, 14.81),
        vector3(-1228.67, -3073.65, 14.3),
        vector3(-1760.56, -2774.77, 13.94)
    },
    Style = {
        'prop_box_wood02a_pu',
        'prop_box_wood02a_mws',
        'prop_box_wood05a',
        'prop_box_wood05b',
        'prop_box_wood08a',
    },
    DropAllowMarker = true,
    DropLocationMarker = 43,
    DropLocation = {
        vector3(-2206.95, 264.1, 198.11),
        vector3(-1885.3, 2807.79, 32.81),
        vector3(-467.41, 5982.57, 31.34),
        vector3(2135.45, 4816.68, 41.2),
        vector3(1751.76, 3282.69, 41.08),
        vector3(2727.76, 1417.36, 24.46),
        vector3(2511.46, -427.09, 118.19),
        vector3(910.77, -1681.53, 51.13),
        vector3(965.91, 42.84, 123.13),
        vector3(-1582.72, -569.14, 116.33),
        vector3(-1011.04, -756.65, 81.75),
        vector3(-914.45, -377.5, 137.91),
        vector3(-582.69, -930.38, 36.83),
        vector3(-144.21, -593.05, 211.78),
        vector3(-745.06, -1469.2, 5.0),
        vector3(1045.71, -2879.72, 19.01),
        vector3(3065.86, -4614.55, 15.26),
        vector3(-1714.83, 6406.84, 16.74),
        vector3(-3619.43, 6370.88, 43.07),
        vector3(-3141.2, 7272.97, 44.22),
        vector3(-1005.67, 6590.85, 3.42),
        vector3(200.44, 7482.91, 4.57),

    }
}

----------------------------------------------------------------------
--						 Helicopter Script       					--
--		It is NOT recommended to change any of the following        --
----------------------------------------------------------------------

local PedSpawned = false
local CargoItem = nil
local heliJob = false

if Config.HeliJobOn then
    CreateThread(function()
        JobBlip(Heli_Options.Boss.Location, Heli_Options.Sprite.icon, Heli_Options.Sprite.colour, Heli_Options.Sprite.name)
        Job3DText(Heli_Options.Boss.Location, 'angelicxs-CivilianJobs:HeliJob:AskForWork', 'angelicxs-CivilianJobs:HeliJob:HowTo')
        while true do
            local Pos = GetEntityCoords(PlayerPedId())
            local HeliBoss = vector3(Heli_Options.Boss.Location.x, Heli_Options.Boss.Location.y, Heli_Options.Boss.Location.z)
            local Dist = #(Pos - HeliBoss)
            if Dist <= 50 and not PedSpawned then
                TriggerEvent('angelicxs-CivilianJobs:MAIN:SpawnBossNPC', Heli_Options.Boss.Model, Heli_Options.Boss.Location, 'angelicxs-CivilianJobs:HeliJob:AskForWork', 'angelicxs-CivilianJobs:HeliJob:HowTo', ' HeliJob.lua', Heli_Options)
                PedSpawned = true
            elseif PedSpawned and Dist > 50 then
                PedSpawned = false
            end
            Wait(2000)
        end
    end)

    RegisterNetEvent('angelicxs-CivilianJobs:HeliJob:HowTo', function()
        TriggerEvent('angelicxs-CivilianJobs:Notify', Config.Lang['gen_how_to'], Config.LangType['info'])
        print(Config.Lang['heli_how_to'])
    end)

    RegisterNetEvent('angelicxs-CivilianJobs:HeliJob:AskForWork', function()
        print("^3[HELI DEBUG CLIENT] Evento AskForWork acionado^7")
        if FreeWork or PlayerJob == Config.HeliJobName then
            print("^3[HELI DEBUG CLIENT] Job verificado - OK^7")
            if not MissionVehicle then
                print("^3[HELI DEBUG CLIENT] Verificando dinheiro no servidor^7")
                -- Verificar se o jogador tem dinheiro suficiente para spawnar o helicóptero
                TriggerServerEvent('angelicxs-CivilianJobs:HeliJob:CheckMoney', 8000) -- Valor ajustado para rentabilidade de $12k/h
            else
                TriggerEvent('angelicxs-CivilianJobs:HeliJob:BeginWork')
            end
        else
            TriggerEvent('angelicxs-CivilianJobs:Notify', Config.Lang['wrong_job'], Config.LangType['error'])
        end
    end)

    RegisterNetEvent('angelicxs-CivilianJobs:HeliJob:BeginWork', function()
        if not DoesEntityExist(CargoItem) then
            heliJob = true
            TriggerEvent('angelicxs-CivilianJobs:Notify', Config.Lang['heli_start'], Config.LangType['info'])
            CargoCrateCreator()
        else
            TriggerEvent('angelicxs-CivilianJobs:Notify', Config.Lang['heli_on_job'], Config.LangType['error'])
        end
    end)

    -- Novo evento para spawnar o helicóptero após verificação de pagamento
    RegisterNetEvent('angelicxs-CivilianJobs:HeliJob:SpawnHeli', function()
        print("^2[HELI DEBUG CLIENT] Evento SpawnHeli recebido, spawnando helicóptero^7")
        local ChosenHeli = Randomizer(Heli_Options.Heli.Type, 'angelicxs-CivilianJobs:HeliJob:SpawnHeli')
        print("^2[HELI DEBUG CLIENT] Helicóptero escolhido: " .. ChosenHeli .. "^7")
        TriggerEvent('angelicxs-CivilianJobs:MAIN:CreateVehicle', ChosenHeli, Heli_Options.Heli.Spawn, 'angelicxs-CivilianJobs:HeliJob:SpawnHeli')
        while not DoesEntityExist(MissionVehicle) do
            Wait(25)
        end
        print("^2[HELI DEBUG CLIENT] Helicóptero spawnado, iniciando trabalho^7")
        TriggerEvent('angelicxs-CivilianJobs:HeliJob:BeginWork')
    end)

    function CargoCrateCreator()
        local cargoType = Randomizer(crateOptions.Style, 'CargoCrateCreator()')
        local location = Randomizer(crateOptions.Location, 'CargoCrateCreator()')
        while not cargoType and not location do Wait(10) end
        local hash = HashGrabber(cargoType)
        while not hash do Wait(10) end
        CargoItem = CreateObject(hash, location.x, location.y, location.z-0.95, true, true, true)
        PlaceObjectOnGroundProperly(CargoItem)
        SetEntityInvincible(CargoItem, true)
        SetEntityAsMissionEntity(CargoItem, true, true)
        TriggerEvent('angelicxs-CivilianJobs:MAIN:RouteMarker', false, location, 'Cargo Location', 'CargoCrateCreator()')
        SetModelAsNoLongerNeeded(cargoType)
        while true do 
            local sleep = 1000
            local coord = GetEntityCoords(PlayerPedId())
            if #(coord-location) <40 then
                sleep = 0
                if crateOptions.CrateAllowMarker then
                    DrawMarker(crateOptions.CrateLocationMarker, location.x, location.y, (location.z+2), 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 100, 200, 50, 255, true, true, 2, 0.0, false, false, false)
                end
                if #(coord-location) <= 5 then
                    Wait(2000)
                    AttachEntityToEntity(CargoItem, MissionVehicle, 0, 0, 0, -1.5, 0, 0, 0, 0, false, false, false, 0, false)
                    break
                end
            end
            Wait(sleep)
        end
        CargoDropLocation(location)
    end

    function CargoDropLocation(inital)
        local location = Randomizer(crateOptions.DropLocation, 'CargoDropLocation()')
        while not location do Wait(10) end
        TriggerEvent('angelicxs-CivilianJobs:MAIN:RouteMarker', false, location, 'Drop Location', 'CargoDropLocation()')
        while true do 
            local sleep = 1000
            local coord = GetEntityCoords(PlayerPedId())
            local pcoord = GetEntityCoords(CargoItem)
            if #(coord-location) <40 then
                sleep = 0
                if crateOptions.DropAllowMarker then
                    DrawMarker(crateOptions.DropLocationMarker, location.x, location.y, (location.z+2), 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 100, 200, 50, 255, true, true, 2, 0.0, false, false, false)
                end
                if #(pcoord-location) <= 5 then
                    DetachEntity(CargoItem, false, false)
                    PlaceObjectOnGroundProperly(CargoItem)
                    SetEntityAsNoLongerNeeded(CargoItem)
                    CargoItem = nil
                    break
                end
            end
            Wait(sleep)
        end
        TriggerEvent('angelicxs-CivilianJobs:MAIN:RouteMarker', false, vector3(Heli_Options.Heli.Spawn.x, Heli_Options.Heli.Spawn.y, Heli_Options.Heli.Spawn.z), 'Heli Pad', 'CargoDropLocation()')
        if Heli_Options.Payment.flatRate then
            PaymentFlat(Heli_Options.Payment.flatRateAmount, 'Helicopter Job - CargoDropLocation()')
        else
            DistancePayment(inital, location, 'Helicopter Job - CargoDropLocation()', Heli_Options.Payment.DistanceMultiplier)
        end
        heliJob = false
        TriggerEvent('angelicxs-CivilianJobs:Notify', Config.Lang['heli_job_complete'], Config.LangType['success'])
    end

    AddEventHandler('angelicxs-CivilianJobs:Main:ResetJobs', function()
        if DoesEntityExist(CargoItem) then
            DeleteEntity(CargoItem)
        end
        CargoItem = nil
    end)
end