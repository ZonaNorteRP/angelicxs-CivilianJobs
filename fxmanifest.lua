fx_version 'cerulean'
game 'gta5'

author 'AngelicXS'
version '1.2'

dependencies {
    'oxmysql',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'uniforms.lua',
}

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/style.css',
    'nui/script.js',
    'database.sql',
}

client_scripts {
    'client/main.lua',
    'client/busjob.lua',
    'client/forkliftjob.lua',
    'client/garbage.lua',
    'client/helijob.lua',
    'client/jetskijob.lua',
    'client/scubajob.lua',
    'client/taxijob.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server.lua',
}

lua54 'yes'
