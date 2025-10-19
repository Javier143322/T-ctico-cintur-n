
fx_version 'cerulean'
game 'gta5'

author 'TuNombre'
description 'Sistema de Cinturera Táctica para ESX'
version '1.0.0'

client_scripts {
    'config.lua',
    'client/main.lua',
    'client/item_usage.lua'
}

server_scripts {
    'server/main.lua'
}

shared_scripts {
    '@es_extended/imports.lua',  -- Si usas ESX Legacy
    -- '@es_extended/locale.lua', -- Descomenta si usas locales
    -- 'locales/*.lua'            -- Descomenta si usas locales
}

dependencies {
    'es_extended'
}