fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'vib_blackmarket'
author 'Vibrant Resources'
version '1.2.3'
repository 'https://github.com/VibrantResources/vib_blackmarket'
description 'A blackmarket resource providing buying/selling shops, weapon knowledge and more'

client_scripts {
	'client/**/*.lua',
	'menus/*.lua',
	'menus/**/*.lua',
	'ambient_peds/*.lua',
}

server_scripts  {
	'server/*.lua',
	'server/**/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
	'config.lua',
}

-- These files below are for when the sreen goes black when the ped bags a players head
-- that is trying to enter the blackmarket
ui_page "index.html"

files {
    "index.html"
}