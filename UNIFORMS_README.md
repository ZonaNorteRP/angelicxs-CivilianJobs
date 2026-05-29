# Sistema de Uniformes - Civilian Jobs

## Visão Geral
Este sistema adiciona uniformes específicos para cada emprego no script Civilian Jobs, permitindo que os jogadores vistam roupas apropriadas para cada trabalho através do ox_target nos NPCs.

## Características
- ✅ Integração completa com ox_target
- ✅ Uniformes específicos para cada emprego
- ✅ Suporte para personagens masculinos e femininos
- ✅ Aplicação/remoção automática ou manual
- ✅ Sistema modular e facilmente customizável

## Como Funciona

### 1. Interação com NPCs
- Aproxime-se de qualquer NPC de emprego
- Use o ox_target (botão direito do mouse por padrão)
- Selecione "Gerenciar Uniforme"
- Escolha entre "Vestir Uniforme" ou "Remover Uniforme"

### 2. Aplicação Automática
O sistema pode aplicar uniformes automaticamente quando:
- O jogador inicia um trabalho
- O jogador termina um trabalho (remove o uniforme)

## Uniformes Disponíveis

### 🚌 Motorista de Ônibus (`bus-driver`)
- **Camisa polo azul** da empresa
- **Jaqueta de motorista** com distintivos
- **Calça social azul escuro**
- **Sapatos sociais pretos**
- **Boné da empresa** com logo
- **Variações**: Azul (padrão) e Verde

### 🚖 Motorista de Táxi (`taxi-driver`)
- **Camisa branca básica**
- **Camisa social aberta** por cima
- **Jeans escuro** confortável
- **Tênis casual** para dirigir
- **Variações**: Casual (padrão) e Formal

### 🏗️ Operador de Empilhadeira (`forklift-driver`)
- **Colete refletivo laranja** de segurança
- **Calça cargo** resistente
- **Botas de segurança** com biqueira de aço
- **Capacete de segurança amarelo** obrigatório
- **Camisa branca** por baixo do colete

### 🤿 Mergulhador (`scuba-diver`)
- **Roupa de mergulho preta** completa
- **Nadadeiras** profissionais
- **Máscara de mergulho** com snorkel
- **Tanque de oxigênio** nas costas
- **Equipamento completo** para mergulho

### 🏖️ Salva-Vidas (`lifeguard`)
- **Regata vermelha** com cruz de salva-vidas
- **Shorts vermelhos** da corporação
- **Chinelos** para areia/piscina
- **Boné** para proteção solar
- **Apito** profissional no peito
- **Óculos de sol** para proteção

### 🚁 Piloto de Helicóptero (`heli-driver`)
- **Camisa de piloto** com listras
- **Calça social preta** formal
- **Sapatos sociais** polidos
- **Capacete de piloto** com viseira
- **Headset/comunicador** nas orelhas
- **Visual profissional** de aviação

### 🗑️ Coletor de Lixo (`garbage-driver`)
- **Colete refletivo verde** de alta visibilidade
- **Calça cargo verde** da empresa
- **Botas de segurança** impermeáveis
- **Boné da empresa** de limpeza urbana
- **Camisa branca** respirável

### 📦 Entregador (`delivery-driver`) - BÔNUS
- **Jaqueta de entregador** com logo
- **Calça jeans** confortável
- **Tênis** para caminhada
- **Boné** da empresa de entregas

### 🔧 Mecânico (`mechanic`) - BÔNUS
- **Macacão de mecânico** azul
- **Calça de trabalho** resistente a óleo
- **Botas de trabalho** antiderrapantes
- **Camisa branca** por baixo

## Personalização

### Variações de Uniformes
Alguns empregos possuem variações de cores disponíveis:

- **Motorista de Ônibus**: Azul (padrão) e Verde
- **Motorista de Táxi**: Casual (padrão) e Formal

Para usar variações, utilize:
```lua
-- Aplicar variação específica (índice 1 ou 2)
Uniforms.ApplyUniformVariation('bus-driver', 2) -- Verde
```

### Adicionando Novos Uniformes
1. Abra o arquivo `uniforms.lua`
2. Adicione uma nova entrada em `Uniforms.JobUniforms`:

```lua
['novo-emprego'] = {
    name = 'Nome do Emprego',
    male = {
        ['tshirt_1'] = 15,   -- ID da camisa
        ['tshirt_2'] = 0,    -- Textura da camisa
        ['torso_1'] = 10,    -- ID da jaqueta
        ['torso_2'] = 0,     -- Textura da jaqueta
        -- ... outros componentes
    },
    female = {
        -- Mesma estrutura para personagens femininos
    }
}
```

### Modificando Uniformes Existentes
1. Encontre o emprego desejado em `uniforms.lua`
2. Altere os IDs dos componentes conforme necessário
3. Use ferramentas como `eup-ui` ou `fivem-appearance` para encontrar IDs corretos

## Componentes de Roupa

### Componentes Principais (SetPedComponentVariation)
- `tshirt_1/2`: Camisa (componente 8)
- `torso_1/2`: Jaqueta/Colete (componente 11)
- `decals_1/2`: Decalques (componente 10)
- `arms`: Braços (componente 3)
- `pants_1/2`: Calças (componente 4)
- `shoes_1/2`: Sapatos (componente 6)

### Props/Acessórios (SetPedPropIndex)
- `helmet_1/2`: Chapéu/Capacete (prop 0)
- `ears_1/2`: Óculos/Acessórios de orelha (prop 2)
- `chain_1/2`: Corrente (prop 7)

## Integração com Jobs

### Aplicação Automática
Para aplicar uniformes automaticamente quando um trabalho inicia, adicione no evento de início do job:

```lua
-- Aplicar uniforme automaticamente
if Uniforms and Uniforms.HasUniform('nome-do-job') then
    TriggerEvent('angelicxs-CivilianJobs:Uniforms:Apply', 'nome-do-job')
end
```

### Remoção Automática
Para remover uniformes automaticamente quando um trabalho termina, adicione no evento de reset:

```lua
-- Remover uniforme automaticamente
if Uniforms then
    TriggerEvent('angelicxs-CivilianJobs:Uniforms:Remove')
end
```

## Eventos Disponíveis

### Client-Side
- `angelicxs-CivilianJobs:Uniforms:Apply` - Aplica uniforme
- `angelicxs-CivilianJobs:Uniforms:Remove` - Remove uniforme
- `angelicxs-CivilianJobs:MAIN:UniformMenu` - Abre menu de uniformes

### Funções Úteis
- `Uniforms.HasUniform(jobName)` - Verifica se existe uniforme
- `Uniforms.GetUniformName(jobName)` - Retorna nome do uniforme
- `Uniforms.ApplyUniform(jobName)` - Aplica uniforme
- `Uniforms.RemoveUniform()` - Remove uniforme

## Configuração

### Requisitos
- ox_target configurado e funcionando
- ox_lib instalado (para menus)
- Config.OXLib = true no config.lua

### Instalação
1. Adicione `uniforms.lua` ao shared_script no fxmanifest.lua
2. Reinicie o resource
3. Os uniformes estarão disponíveis automaticamente

## Troubleshooting

### Uniforme não aparece
- Verifique se o job name está correto
- Confirme se os IDs dos componentes são válidos
- Teste com diferentes personagens (masculino/feminino)

### Menu não abre
- Verifique se ox_lib está instalado
- Confirme se Config.OXLib = true
- Verifique se ox_target está funcionando

### Componentes incorretos
- Use ferramentas de customização para encontrar IDs corretos
- Teste cada componente individualmente
- Verifique diferenças entre personagens masculinos e femininos

## Suporte
Para suporte adicional, consulte:
- Documentação do ox_target
- Documentação do ox_lib
- Comunidade FiveM para IDs de roupas