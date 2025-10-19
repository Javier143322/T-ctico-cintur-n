
local ESX = nil
local beltProps = {}
local currentWeapon = nil
local beltEquipped = false

-- Inicializar ESX
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Crear la cinturera táctica basada en el inventario del jugador
function CreateTacticalBelt()
    local playerPed = PlayerPedId()
    
    -- Verificar si el jugador tiene datos cargados
    if not ESX.PlayerData or not ESX.PlayerData.inventory then
        ESX.ShowNotification("~r~Error: Datos del jugador no cargados")
        return
    end
    
    local playerInventory = ESX.PlayerData.inventory
    beltProps = {}
    local itemsAdded = 0
    
    for _, itemConfig in ipairs(Config.TacticalBelt) do
        local hasItem = false
        local itemCount = 0
        
        -- Verificar si el jugador tiene el item en el inventario
        for _, item in ipairs(playerInventory) do
            if item.name == itemConfig.itemName and item.count > 0 then
                hasItem = true
                itemCount = item.count
                break
            end
        end
        
        if hasItem then
            -- Cargar el modelo
            if not HasModelLoaded(itemConfig.prop) then
                RequestModel(itemConfig.prop)
                local timeout = 2000 -- 2 segundos timeout
                while not HasModelLoaded(itemConfig.prop) and timeout > 0 do
                    Citizen.Wait(10)
                    timeout = timeout - 10
                end
            end
            
            if HasModelLoaded(itemConfig.prop) then
                beltProps[itemConfig.name] = CreateObject(itemConfig.prop, 0, 0, 0, true, true, true)
                AttachEntityToEntity(beltProps[itemConfig.name], playerPed, GetPedBoneIndex(playerPed, itemConfig.bone), 
                                   itemConfig.x, itemConfig.y, itemConfig.z, itemConfig.xr, itemConfig.yr, itemConfig.zr, 
                                   true, true, false, true, 1, true)
                
                print("✅ " .. itemConfig.label .. " agregado a la cinturera")
                itemsAdded = itemsAdded + 1
            else
                print("❌ No se pudo cargar el modelo: " .. itemConfig.name)
            end
        else
            print("❌ " .. itemConfig.label .. " no disponible en el inventario")
        end
    end
    
    if itemsAdded > 0 then
        beltEquipped = true
        ESX.ShowNotification("🎽 Cinturera táctica equipada (" .. itemsAdded .. " items)")
    else
        ESX.ShowNotification("~r~No tienes items para la cinturera táctica")
    end
end

-- Remover la cinturera
function RemoveTacticalBelt()
    for itemName, prop in pairs(beltProps) do
        if DoesEntityExist(prop) then
            DeleteObject(prop)
        end
    end
    beltProps = {}
    beltEquipped = false
    ESX.ShowNotification("🎽 Cinturera táctica removida")
end

-- Verificar cambios de arma y actualizar visibilidad
function CheckWeaponChanges()
    local playerPed = PlayerPedId()
    local selectedWeapon = GetSelectedPedWeapon(playerPed)
    
    if selectedWeapon ~= currentWeapon then
        UpdateBeltVisibility(selectedWeapon)
        currentWeapon = selectedWeapon
    end
end

-- Actualizar visibilidad de los items en la cinturera
function UpdateBeltVisibility(currentWeaponHash)
    for _, itemConfig in ipairs(Config.TacticalBelt) do
        if beltProps[itemConfig.name] and itemConfig.isWeapon then
            local weaponHash = GetHashKey(itemConfig.itemName)
            if currentWeaponHash == weaponHash then
                SetEntityVisible(beltProps[itemConfig.name], false, false)
            else
                SetEntityVisible(beltProps[itemConfig.name], true, false)
            end
        end
    end
end

-- Ocultar item específico cuando se usa
function HideBeltItem(itemName)
    if beltProps[itemName] then
        SetEntityVisible(beltProps[itemName], false, false)
        print("🔸 " .. itemName .. " oculto (en uso)")
    end
end

-- Mostrar item específico cuando se guarda
function ShowBeltItem(itemName)
    if beltProps[itemName] then
        SetEntityVisible(beltProps[itemName], true, false)
        print("🔹 " .. itemName .. " visible (guardado)")
    end
end

-- Evento para usar items de la cinturera
RegisterNetEvent('tactical_belt:useItem')
AddEventHandler('tactical_belt:useItem', function(itemName)
    if beltEquipped then
        HideBeltItem(itemName)
        
        -- Obtener tiempo de uso de la configuración
        local useTime = Config.UseTimes[itemName] or Config.UseTimes.default
        
        -- Programar para mostrar el item después del tiempo de uso
        Citizen.SetTimeout(useTime, function()
            if beltEquipped and beltProps[itemName] then
                ShowBeltItem(itemName)
            end
        end)
    end
end)

-- Comando para toggle de la cinturera
RegisterCommand('tacticalbelt', function()
    if not beltEquipped then
        CreateTacticalBelt()
    else
        RemoveTacticalBelt()
    end
end, false)

-- Registrar tecla (opcional)
RegisterKeyMapping('tacticalbelt', 'Poner/Quitar Cinturera Táctica', 'keyboard', Config.Keybinds.toggleBelt)

-- Hilo principal
Citizen.CreateThread(function()
    while true do
        if beltEquipped then
            CheckWeaponChanges()
        end
        Wait(1000)
    end
end)

-- Sincronizar con el inventario de ESX
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    print("✅ ESX PlayerData cargado para cinturera táctica")
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    RemoveTacticalBelt()
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setPlayerData')
AddEventHandler('esx:setPlayerData', function(key, value)
    if ESX.PlayerData then
        ESX.PlayerData[key] = value
    end
end)

-- Limpieza al reiniciar
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        RemoveTacticalBelt()
    end
end)