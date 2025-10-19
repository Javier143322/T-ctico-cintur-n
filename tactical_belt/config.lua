
Config = {}

-- Configuración de la cinturera táctica
Config.TacticalBelt = {
    {
        name = "pistol",
        prop = `prop_cs_holster_01`, 
        bone = 24818, 
        x = 0.02, y = -0.22, z = 0.01, 
        xr = 0.0, yr = 0.0, zr = 0.0,
        itemName = "weapon_pistol",
        isWeapon = true,
        label = "Pistola"
    },
    {
        name = "holster",
        prop = `prop_holster_01`, 
        bone = 24818, 
        x = 0.04, y = -0.18, z = 0.0, 
        xr = -90.0, yr = 0.0, zr = -80.0,
        itemName = "holster",
        isWeapon = false,
        label = "Holster"
    },
    {
        name = "latex_gloves",
        prop = `prop_cs_hand_radio`, 
        bone = 24818, 
        x = 0.07, y = -0.10, z = 0.0, 
        xr = 0.0, yr = 0.0, zr = 90.0,
        itemName = "latex_gloves",
        isWeapon = false,
        label = "Guantes de Látex"
    },
    {
        name = "walkie_talkie",
        prop = `prop_cs_hand_radio`, 
        bone = 24818, 
        x = -0.07, y = -0.10, z = 0.0, 
        xr = 0.0, yr = 0.0, zr = -90.0,
        itemName = "radio",
        isWeapon = false,
        label = "Walkie Talkie"
    },
    {
        name = "flashlight",
        prop = `prop_cs_police_torch`, 
        bone = 24818, 
        x = -0.12, y = -0.15, z = 0.05, 
        xr = 0.0, yr = 0.0, zr = -60.0,
        itemName = "flashlight",
        isWeapon = false,
        label = "Linterna"
    },
    {
        name = "baton",
        prop = `prop_cs_baton_01`, 
        bone = 24818, 
        x = -0.05, y = -0.22, z = 0.0, 
        xr = 0.0, yr = 0.0, zr = 10.0,
        itemName = "weapon_nightstick",
        isWeapon = true,
        label = "Porra"
    },
    {
        name = "pepper_spray",
        prop = `prop_cs_spray_can`, 
        bone = 24818, 
        x = 0.10, y = -0.15, z = 0.03, 
        xr = 0.0, yr = 0.0, zr = 100.0,
        itemName = "weapon_stungun",
        isWeapon = true,
        label = "Spray de Pimienta"
    },
    {
        name = "ammo_pouch",
        prop = `prop_ammo_case_02`, 
        bone = 24818, 
        x = 0.12, y = -0.08, z = 0.0, 
        xr = 0.0, yr = 0.0, zr = 70.0,
        itemName = "ammo_pouch",
        isWeapon = false,
        label = "Cartuchera"
    },
    {
        name = "handcuffs",
        prop = `prop_cs_cuffs_01`, 
        bone = 24818, 
        x = 0.08, y = -0.05, z = 0.0, 
        xr = 0.0, yr = 0.0, zr = 80.0,
        itemName = "handcuffs",
        isWeapon = false,
        label = "Esposas"
    },
    {
        name = "microphone",
        prop = `prop_cs_mic_01`, 
        bone = 24818, 
        x = -0.10, y = -0.05, z = 0.0, 
        xr = 0.0, yr = 0.0, zr = -100.0,
        itemName = "microphone",
        isWeapon = false,
        label = "Micrófono"
    }
}

-- Teclas
Config.Keybinds = {
    toggleBelt = "F6",  -- Tecla para poner/quitar cinturera
    useItem = "E"       -- Tecla para usar item (cuando esté cerca)
}

-- Tiempos de uso (en milisegundos)
Config.UseTimes = {
    flashlight = 30000,    -- 30 segundos
    radio = 45000,         -- 45 segundos
    handcuffs = 15000,     -- 15 segundos
    default = 20000        -- 20 segundos por defecto
}