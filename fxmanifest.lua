fx_version 'cerulean'
game 'gta5'

author 'Baggers'
description 'Bag Weight Modifier for ox_inventory'
version '1.2.0'

shared_scripts {
    'config.lua',
    'bag_drawables.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'ox_inventory',
    'oxmysql'
}