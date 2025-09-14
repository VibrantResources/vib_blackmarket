fx_version 'cerulean'
game 'gta5'

description 'Black Market'
author 'Vibrant Resources'
version '1.2.3'

shared_scripts {
    '@ox_lib/init.lua',
	'config.lua',
}

server_scripts  {
	'server/*.lua',
	'server/laundering/*.lua',
}

client_scripts {
	'client/*.lua',
	'client/laundering/*.lua',
	'menus/*.lua',
	'menus/laundering/*.lua',
	'ambient_peds/*.lua'
}

ui_page "index.html"

files {
    "index.html"
}

lua54 'yes'