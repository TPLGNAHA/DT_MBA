fx_version 'cerulean'
game 'gta5'
lua54 'yes'

team 'Dowters'
Name 'DT_MBA'
author 'Naha'
description 'Une ressource qui permets de modifier l\'Interieurs du mapping de gabz. Disclaimer c\'est un script modifier ! je les refait moi meme de base c\'est la ressource de Scully.'

dependencies {
    '/server:5848',
    '/onesync',
    'cfx-gabz-mba',
    'ox_lib'
}

shared_script {
    'config.lua',
    '@ox_lib/init.lua' 
}

client_script 'client/main.lua'

server_script 'server/main.lua'
