resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies{
	'vrp',
	'pNotify'
}

client_script 'client.lua'
server_scripts{
	'@vrp/lib/utils.lua',
	'server.lua'
}