----------------------------------------------------------------------
-- Sistema de Uniformes para Civilian Jobs                          --
-- Criado para gerenciar roupas específicas de cada emprego         --
----------------------------------------------------------------------

Uniforms = {}

-- Configuração de uniformes por emprego
Uniforms.JobUniforms = {
    ['bus-driver'] = {
        name = 'Motorista de Ônibus',
        male = {
            ['tshirt_1'] = 57,   -- Camisa polo azul
            ['tshirt_2'] = 0,    
            ['torso_1'] = 32,    -- Jaqueta de motorista
            ['torso_2'] = 0,     
            ['decals_1'] = 0,    
            ['decals_2'] = 0,    
            ['arms'] = 1,        -- Braços da jaqueta
            ['pants_1'] = 24,    -- Calça social azul escuro
            ['pants_2'] = 0,     
            ['shoes_1'] = 25,    -- Sapatos sociais pretos
            ['shoes_2'] = 0,     
            ['helmet_1'] = 8,    -- Boné da empresa
            ['helmet_2'] = 0,    
            ['chain_1'] = 0,     
            ['chain_2'] = 0,     
            ['ears_1'] = -1,     
            ['ears_2'] = 0,      
        },
        female = {
            ['tshirt_1'] = 36,   -- Blusa polo azul
            ['tshirt_2'] = 0,
            ['torso_1'] = 49,    -- Blazer feminino
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 6,     -- Calça social feminina
            ['pants_2'] = 0,
            ['shoes_1'] = 24,    -- Sapatos sociais femininos
            ['shoes_2'] = 0,
            ['helmet_1'] = 8,    -- Boné da empresa
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        }
    },
    
    ['taxi-driver'] = {
        name = 'Motorista de Táxi',
        male = {
            ['tshirt_1'] = 15,   -- Camisa branca básica
            ['tshirt_2'] = 0,
            ['torso_1'] = 4,     -- Camisa social aberta
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 28,    -- Jeans escuro
            ['pants_2'] = 0,
            ['shoes_1'] = 54,    -- Tênis casual
            ['shoes_2'] = 0,
            ['helmet_1'] = -1,   -- Sem chapéu
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 14,   -- Blusa branca básica
            ['tshirt_2'] = 0,
            ['torso_1'] = 7,     -- Cardigan casual
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 6,     -- Jeans feminino
            ['pants_2'] = 0,
            ['shoes_1'] = 6,     -- Tênis feminino
            ['shoes_2'] = 0,
            ['helmet_1'] = -1,
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        }
    },
    
    ['forklift-driver'] = {
        name = 'Operador de Empilhadeira',
        male = {
            ['tshirt_1'] = 15,   -- Camisa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 56,    -- Colete refletivo laranja
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 36,    -- Calça cargo
            ['pants_2'] = 0,
            ['shoes_1'] = 12,    -- Botas de segurança
            ['shoes_2'] = 6,
            ['helmet_1'] = 78,   -- Capacete de segurança amarelo
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 14,   -- Blusa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 56,    -- Colete refletivo laranja
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 36,    -- Calça cargo
            ['pants_2'] = 0,
            ['shoes_1'] = 12,    -- Botas de segurança
            ['shoes_2'] = 6,
            ['helmet_1'] = 78,   -- Capacete de segurança amarelo
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        }
    },
    
    ['scuba-diver'] = {
        name = 'Mergulhador',
        male = {
            ['tshirt_1'] = 15,   -- Camisa base
            ['tshirt_2'] = 0,
            ['torso_1'] = 243,   -- Roupa de mergulho preta
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 94,    -- Calça de mergulho
            ['pants_2'] = 0,
            ['shoes_1'] = 67,    -- Nadadeiras
            ['shoes_2'] = 0,
            ['helmet_1'] = 117,  -- Máscara de mergulho
            ['helmet_2'] = 0,
            ['chain_1'] = 123,   -- Tanque de oxigênio
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 14,   -- Blusa base
            ['tshirt_2'] = 0,
            ['torso_1'] = 251,   -- Roupa de mergulho feminina
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 97,    -- Calça de mergulho feminina
            ['pants_2'] = 0,
            ['shoes_1'] = 70,    -- Nadadeiras femininas
            ['shoes_2'] = 0,
            ['helmet_1'] = 119,  -- Máscara de mergulho feminina
            ['helmet_2'] = 0,
            ['chain_1'] = 96,    -- Tanque de oxigênio feminino
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        }
    },
    
    ['lifeguard'] = {
        name = 'Salva-Vidas',
        male = {
            ['tshirt_1'] = 15,   -- Camisa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 15,    -- Regata vermelha
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 15,       -- Braços nus
            ['pants_1'] = 16,    -- Shorts
            ['pants_2'] = 0,
            ['shoes_1'] = 34,    -- Chinelos
            ['shoes_2'] = 0,
            ['helmet_1'] = -1,   -- Sem chapéu
            ['helmet_2'] = 0,
            ['chain_1'] = 0,     -- Sem corrente
            ['chain_2'] = 0,
            ['ears_1'] = -1,     -- Sem óculos
            ['ears_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 14,   -- Blusa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 15,    -- Regata vermelha
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 15,       -- Braços nus
            ['pants_1'] = 16,    -- Shorts
            ['pants_2'] = 0,
            ['shoes_1'] = 35,    -- Chinelos femininos
            ['shoes_2'] = 0,
            ['helmet_1'] = -1,   -- Sem chapéu
            ['helmet_2'] = 0,
            ['chain_1'] = 0,     -- Sem corrente
            ['chain_2'] = 0,
            ['ears_1'] = -1,     -- Sem óculos
            ['ears_2'] = 0,
        }
    },
    
    ['heli-driver'] = {
        name = 'Piloto de Helicóptero',
        male = {
            ['tshirt_1'] = 15,   -- Camisa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 7,     -- Camisa de piloto com listras
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 28,    -- Calça social preta
            ['pants_2'] = 0,
            ['shoes_1'] = 25,    -- Sapatos sociais
            ['shoes_2'] = 0,
            ['helmet_1'] = 79,   -- Capacete de piloto
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = 15,     -- Headset/comunicador
            ['ears_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 14,   -- Blusa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 7,     -- Blazer de piloto
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 28,    -- Calça social preta
            ['pants_2'] = 0,
            ['shoes_1'] = 25,    -- Sapatos sociais
            ['shoes_2'] = 0,
            ['helmet_1'] = 79,   -- Capacete de piloto
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = 15,     -- Headset/comunicador
            ['ears_2'] = 0,
        }
    },
    
    ['garbage-driver'] = {
        name = 'Coletor de Lixo',
        male = {
            ['tshirt_1'] = 15,   -- Camisa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 56,    -- Colete refletivo
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 36,    -- Calça cargo
            ['pants_2'] = 0,
            ['shoes_1'] = 12,    -- Botas de segurança
            ['shoes_2'] = 0,
            ['helmet_1'] = -1,   -- Sem chapéu
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 14,   -- Blusa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 56,    -- Colete refletivo
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 36,    -- Calça cargo
            ['pants_2'] = 0,
            ['shoes_1'] = 12,    -- Botas de segurança
            ['shoes_2'] = 0,
            ['helmet_1'] = -1,   -- Sem chapéu
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        }
    },

    -- Uniformes adicionais para outros possíveis empregos
    ['delivery-driver'] = {
        name = 'Entregador',
        male = {
            ['tshirt_1'] = 15,   -- Camisa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 24,    -- Jaqueta de entregador
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 28,    -- Calça jeans
            ['pants_2'] = 0,
            ['shoes_1'] = 54,    -- Tênis
            ['shoes_2'] = 0,
            ['helmet_1'] = 18,   -- Boné de entregador
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 14,   -- Blusa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 24,    -- Jaqueta de entregador
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 6,     -- Calça jeans feminina
            ['pants_2'] = 0,
            ['shoes_1'] = 6,     -- Tênis feminino
            ['shoes_2'] = 0,
            ['helmet_1'] = 18,   -- Boné de entregador
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        }
    },

    ['mechanic'] = {
        name = 'Mecânico',
        male = {
            ['tshirt_1'] = 15,   -- Camisa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 65,    -- Macacão de mecânico
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 36,    -- Calça de trabalho
            ['pants_2'] = 0,
            ['shoes_1'] = 12,    -- Botas de trabalho
            ['shoes_2'] = 6,
            ['helmet_1'] = -1,   -- Sem chapéu
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 14,   -- Blusa branca
            ['tshirt_2'] = 0,
            ['torso_1'] = 65,    -- Macacão de mecânico
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 36,    -- Calça de trabalho
            ['pants_2'] = 0,
            ['shoes_1'] = 12,    -- Botas de trabalho
            ['shoes_2'] = 6,
            ['helmet_1'] = -1,   -- Sem chapéu
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = -1,
            ['ears_2'] = 0,
        }
    }
}

local savedSkin = nil

local function SavePlayerSkin()
    local ped = PlayerPedId()
    savedSkin = {
        components = {},
        props = {}
    }
    for i = 0, 11 do
        savedSkin.components[i] = {
            drawable = GetPedDrawableVariation(ped, i),
            texture = GetPedTextureVariation(ped, i),
            palette = GetPedPaletteVariation(ped, i)
        }
    end
    local propIds = {0, 1, 2, 6, 7}
    for _, id in ipairs(propIds) do
        savedSkin.props[id] = {
            drawable = GetPedPropIndex(ped, id),
            texture = GetPedPropTextureIndex(ped, id)
        }
    end
end

local function RestorePlayerSkin()
    if not savedSkin then return end
    local ped = PlayerPedId()
    for id, comp in pairs(savedSkin.components) do
        SetPedComponentVariation(ped, id, comp.drawable, comp.texture, comp.palette)
    end
    for id, prop in pairs(savedSkin.props) do
        if prop.drawable == -1 then
            ClearPedProp(ped, id)
        else
            SetPedPropIndex(ped, id, prop.drawable, prop.texture, true)
        end
    end
    savedSkin = nil
end

-- Função para aplicar uniforme
function Uniforms.ApplyUniform(jobName)
    if not Uniforms.JobUniforms[jobName] then
        print("^1[UNIFORMS] Uniforme não encontrado para o emprego: " .. tostring(jobName) .. "^7")
        return false
    end
    
    local playerPed = PlayerPedId()
    local uniform = Uniforms.JobUniforms[jobName]
    local gender = 'male'
    
    -- Detectar gênero do jogador
    if GetEntityModel(playerPed) == GetHashKey('mp_f_freemode_01') then
        gender = 'female'
    end
    
    local clothes = uniform[gender]
    if not clothes then
        print("^1[UNIFORMS] Roupas não encontradas para o gênero: " .. gender .. "^7")
        return false
    end
    
    -- Salvar roupas originais antes de aplicar
    if not IsDuplicityVersion() then
        if not savedSkin then
            SavePlayerSkin()
        end
    end
    
    -- Aplicar cada peça de roupa
    for component, data in pairs(clothes) do
        if type(data) == "number" then
            if component == 'helmet_1' and data ~= -1 then
                SetPedPropIndex(playerPed, 0, data, clothes['helmet_2'] or 0, true)
            elseif component == 'ears_1' and data ~= -1 then
                SetPedPropIndex(playerPed, 2, data, clothes['ears_2'] or 0, true)
            elseif component == 'chain_1' and data ~= -1 then
                SetPedPropIndex(playerPed, 7, data, clothes['chain_2'] or 0, true)
            elseif component == 'tshirt_1' then
                SetPedComponentVariation(playerPed, 8, data, clothes['tshirt_2'] or 0, 0)
            elseif component == 'torso_1' then
                SetPedComponentVariation(playerPed, 11, data, clothes['torso_2'] or 0, 0)
            elseif component == 'decals_1' then
                SetPedComponentVariation(playerPed, 10, data, clothes['decals_2'] or 0, 0)
            elseif component == 'arms' then
                SetPedComponentVariation(playerPed, 3, data, 0, 0)
            elseif component == 'pants_1' then
                SetPedComponentVariation(playerPed, 4, data, clothes['pants_2'] or 0, 0)
            elseif component == 'shoes_1' then
                SetPedComponentVariation(playerPed, 6, data, clothes['shoes_2'] or 0, 0)
            end
        end
    end
    
    return true
end

-- Função para remover uniforme (voltar às roupas originais)
function Uniforms.RemoveUniform()
    if IsDuplicityVersion() then return end
    
    if savedSkin then
        RestorePlayerSkin()
    else
        -- Fallback: solicitar carregamento de skin do framework
        if Config.UseQBCore then
            TriggerServerEvent('qb-clothes:loadPlayerSkin')
        elseif Config.UseESX then
            pcall(function()
                local ESX = exports["es_extended"]:getSharedObject()
                if ESX then
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end
            end)
        else
            local playerPed = PlayerPedId()
            
            -- Remover props
            ClearPedProp(playerPed, 0) -- Chapéu/Capacete
            ClearPedProp(playerPed, 2) -- Óculos/Acessórios de orelha
            ClearPedProp(playerPed, 7) -- Corrente
            
            -- Resetar para roupas padrão
            SetPedComponentVariation(playerPed, 8, 15, 0, 0)  -- Camisa
            SetPedComponentVariation(playerPed, 11, 15, 0, 0) -- Torso
            SetPedComponentVariation(playerPed, 10, 0, 0, 0)  -- Decalques
            SetPedComponentVariation(playerPed, 3, 15, 0, 0)  -- Braços
            SetPedComponentVariation(playerPed, 4, 21, 0, 0)  -- Calças
            SetPedComponentVariation(playerPed, 6, 34, 0, 0)  -- Sapatos
        end
    end
end

-- Função para obter nome do uniforme
function Uniforms.GetUniformName(jobName)
    if Uniforms.JobUniforms[jobName] then
        return Uniforms.JobUniforms[jobName].name
    end
    return "Uniforme Desconhecido"
end

-- Função para verificar se existe uniforme para o emprego
function Uniforms.HasUniform(jobName)
    return Uniforms.JobUniforms[jobName] ~= nil
end

-- Eventos para aplicar/remover uniformes
RegisterNetEvent('angelicxs-CivilianJobs:Uniforms:Apply')
AddEventHandler('angelicxs-CivilianJobs:Uniforms:Apply', function(jobName)
    if Uniforms.ApplyUniform(jobName) then
        TriggerEvent('angelicxs-CivilianJobs:Notify', 
            'Você vestiu o uniforme de ' .. Uniforms.GetUniformName(jobName) .. '!', 
            'success')
    else
        TriggerEvent('angelicxs-CivilianJobs:Notify', 
            'Erro ao aplicar uniforme!', 
            'error')
    end
end)

RegisterNetEvent('angelicxs-CivilianJobs:Uniforms:Remove')
AddEventHandler('angelicxs-CivilianJobs:Uniforms:Remove', function()
    Uniforms.RemoveUniform()
    TriggerEvent('angelicxs-CivilianJobs:Notify', 
        'Você removeu o uniforme de trabalho!', 
        'success')
end)

-- Variações de uniformes (cores alternativas)
Uniforms.UniformVariations = {
    ['bus-driver'] = {
        {
            name = 'Motorista de Ônibus - Azul',
            male = {
                ['tshirt_1'] = 57, ['tshirt_2'] = 0,
                ['torso_1'] = 32, ['torso_2'] = 0,
                ['arms'] = 1, ['pants_1'] = 24, ['pants_2'] = 0,
                ['shoes_1'] = 25, ['shoes_2'] = 0,
                ['helmet_1'] = 8, ['helmet_2'] = 0,
            }
        },
        {
            name = 'Motorista de Ônibus - Verde',
            male = {
                ['tshirt_1'] = 57, ['tshirt_2'] = 1,
                ['torso_1'] = 32, ['torso_2'] = 1,
                ['arms'] = 1, ['pants_1'] = 24, ['pants_2'] = 1,
                ['shoes_1'] = 25, ['shoes_2'] = 0,
                ['helmet_1'] = 8, ['helmet_2'] = 1,
            }
        }
    },
    
    ['taxi-driver'] = {
        {
            name = 'Motorista de Táxi - Casual',
            male = {
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 4, ['torso_2'] = 0,
                ['arms'] = 1, ['pants_1'] = 28, ['pants_2'] = 0,
                ['shoes_1'] = 54, ['shoes_2'] = 0,
            }
        },
        {
            name = 'Motorista de Táxi - Formal',
            male = {
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 32, ['torso_2'] = 0,
                ['arms'] = 1, ['pants_1'] = 24, ['pants_2'] = 0,
                ['shoes_1'] = 25, ['shoes_2'] = 0,
            }
        }
    }
}

-- Função para aplicar variação de uniforme
function Uniforms.ApplyUniformVariation(jobName, variationIndex)
    if not Uniforms.UniformVariations[jobName] or not Uniforms.UniformVariations[jobName][variationIndex] then
        return false
    end
    
    local playerPed = PlayerPedId()
    local variation = Uniforms.UniformVariations[jobName][variationIndex]
    local gender = 'male'
    
    if GetEntityModel(playerPed) == GetHashKey('mp_f_freemode_01') then
        gender = 'female'
    end
    
    local clothes = variation[gender] or variation.male
    if not clothes then
        return false
    end
    
    -- Aplicar cada peça de roupa da variação
    for component, data in pairs(clothes) do
        if type(data) == "number" then
            if component == 'helmet_1' and data ~= -1 then
                local helmet2 = clothes['helmet_2']
                if type(helmet2) == "number" then
                    SetPedPropIndex(playerPed, 0, data, helmet2, true)
                else
                    SetPedPropIndex(playerPed, 0, data, 0, true)
                end
            elseif component == 'ears_1' and data ~= -1 then
                local ears2 = clothes['ears_2']
                if type(ears2) == "number" then
                    SetPedPropIndex(playerPed, 2, data, ears2, true)
                else
                    SetPedPropIndex(playerPed, 2, data, 0, true)
                end
            elseif component == 'chain_1' and data ~= -1 then
                local chain2 = clothes['chain_2']
                if type(chain2) == "number" then
                    SetPedPropIndex(playerPed, 7, data, chain2, true)
                else
                    SetPedPropIndex(playerPed, 7, data, 0, true)
                end
            elseif component == 'tshirt_1' then
                local tshirt2 = clothes['tshirt_2']
                if type(tshirt2) == "number" then
                    SetPedComponentVariation(playerPed, 8, data, tshirt2, 0)
                else
                    SetPedComponentVariation(playerPed, 8, data, 0, 0)
                end
            elseif component == 'torso_1' then
                local torso2 = clothes['torso_2']
                if type(torso2) == "number" then
                    SetPedComponentVariation(playerPed, 11, data, torso2, 0)
                else
                    SetPedComponentVariation(playerPed, 11, data, 0, 0)
                end
            elseif component == 'decals_1' then
                local decals2 = clothes['decals_2']
                if type(decals2) == "number" then
                    SetPedComponentVariation(playerPed, 10, data, decals2, 0)
                else
                    SetPedComponentVariation(playerPed, 10, data, 0, 0)
                end
            elseif component == 'arms' then
                SetPedComponentVariation(playerPed, 3, data, 0, 0)
            elseif component == 'pants_1' then
                local pants2 = clothes['pants_2']
                if type(pants2) == "number" then
                    SetPedComponentVariation(playerPed, 4, data, pants2, 0)
                else
                    SetPedComponentVariation(playerPed, 4, data, 0, 0)
                end
            elseif component == 'shoes_1' then
                local shoes2 = clothes['shoes_2']
                if type(shoes2) == "number" then
                    SetPedComponentVariation(playerPed, 6, data, shoes2, 0)
                else
                    SetPedComponentVariation(playerPed, 6, data, 0, 0)
                end
            end
        end
    end
    
    return true
end

-- Função para obter variações disponíveis
function Uniforms.GetUniformVariations(jobName)
    return Uniforms.UniformVariations[jobName] or {}
end