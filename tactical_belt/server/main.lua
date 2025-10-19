
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Aquí puedes agregar eventos del servidor si es necesario
-- Por ejemplo, para verificar permisos, logs, etc.

-- Evento para cuando un jugador carga
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    print("[Tactical Belt] Jugador cargado: " .. GetPlayerName(playerId))
end)

-- Verificar si un jugador tiene un item específico
ESX.RegisterServerCallback('tactical_belt:checkItem', function(source, cb, itemName)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local item = xPlayer.getInventoryItem(itemName)
        cb(item.count > 0)
    else
        cb(false)
    end
end)