
local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Función para usar items específicos
function UseBeltItem(itemName)
    local playerPed = PlayerPedId()
    
    if itemName == "flashlight" then
        -- Usar linterna (necesitas tener un recurso de linterna o implementarlo)
        ESX.ShowNotification("🔦 Linterna encendida")
        TriggerEvent('tactical_belt:useItem', 'flashlight')
        
    elseif itemName == "radio" then
        -- Usar walkie talkie
        ESX.ShowNotification("📻 Walkie Talkie activado")
        TriggerEvent('tactical_belt:useItem', 'walkie_talkie')
        
    elseif itemName == "handcuffs" then
        -- Usar esposas
        ESX.ShowNotification("👮 Esposas utilizadas")
        TriggerEvent('tactical_belt:useItem', 'handcuffs')
        
    elseif itemName == "latex_gloves" then
        -- Usar guantes
        ESX.ShowNotification("🧤 Guantes de latex puestos")
        TriggerEvent('tactical_belt:useItem', 'latex_gloves')
        
    elseif itemName == "microphone" then
        -- Usar micrófono
        ESX.ShowNotification("🎤 Micrófono activado")
        TriggerEvent('tactical_belt:useItem', 'microphone')
        
    elseif itemName == "ammo_pouch" then
        -- Usar cartuchera
        ESX.ShowNotification("🎯 Cartuchera abierta")
        TriggerEvent('tactical_belt:useItem', 'ammo_pouch')
        
    else
        -- Para otros items
        ESX.ShowNotification("🛠️ Usando " .. itemName)
        TriggerEvent('tactical_belt:useItem', itemName)
    end
end

-- Comando para usar items específicos (para testing)
RegisterCommand('usebeltitem', function(source, args)
    local itemName = args[1]
    if itemName then
        UseBeltItem(itemName)
    else
        ESX.ShowNotification("Uso: /usebeltitem [nombre_item]")
        ESX.ShowNotification("Items disponibles: flashlight, radio, handcuffs, latex_gloves, microphone, ammo_pouch")
    end
end, false)

-- Evento para usar items desde otros recursos
RegisterNetEvent('tactical_belt:useBeltItem')
AddEventHandler('tactical_belt:useBeltItem', function(itemName)
    UseBeltItem(itemName)
end)