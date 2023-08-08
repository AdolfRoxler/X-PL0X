assert(Drawing,"No drawing api?")
--if getgenv().XPL0X then return end
--if getgenv().XPL0XDISABLELOADINGSCREEN then game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen() game:GetService("CoreGui").TeleportGui.Enabled = false scrn = getgenv().XPL0XDISABLELOADINGSCREEN end
local devmode = type(devmode)=="boolean" and devmode or false
rconsoleclear()
rconsoleprint(syn and "@@WHITE@@" or "")
rconsoleprint("[!] Frontend loaded. Press a key to nudge the CLI to continue loading. \n")
--- code optimization for cli ---
local lowercase = string.lower
---

--local ConfigTemplate = game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Config.lua'

local CLI = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/CLI.lua',true)() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/CLI.lua',true)()
local Core = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/X-API.lua',true)() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/X-API.lua',true)()
local ConfigTemplate = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Config.lua',true)() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Config.lua',true)()

--local wget = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Lget.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Lget.lua')()
--local math = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/arbitrarymath.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/arbitrarymath.lua')()
--local spoofer = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/metatableMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/metatableMANIPULATOR.lua')()
--_L.LatestCommit = JSONDecode(Services.HttpService, game.HttpGetAsync(game, "https://api.github.com/repos/fatesc/fates-admin/commits?per_page=1&path=main.lua"))[1]


local help = {
	help = "prints this gay ass guide",
	clear = "clears cli output so it's way cleaner to the eye",
	set = "Example: set ESP Enabled true | set ESP Boxes true \n   [For reference]: check out the default config.",
	ping = "get the server ping",
	config = "\n    write -> [args]: global (default) / game / place\n    load -> place > game > global\n    reset -> wipes loaded config [DOES NOT OVERWRITE]"
}


local function TranslateValue(str)
	local tr = str
	local ntr = tonumber(str)
	if str=="on" or str=="true" or ntr==1 then tr=true
	elseif str=="off" or str=="false" or ntr==0 then tr=false
	end
	return ntr or tr
end

local function changeData(tabl,pathArray) --- stolen from devforum | Source: https://devforum.roblox.com/t/how-to-make-equivalent-of-instancegetfullname-for-tables/1114061
	--send pathArray to client
	local template = ConfigTemplate
	for index, path in ipairs(pathArray) do
		if pathArray[index + 2]==nil then
			if typeof(pathArray[index + 1]) == typeof(template[path]) and pathArray[index + 1]~=nil and template[path]~=nil then tabl[path] = pathArray[index + 1] end
		else
			if tabl[path]==nil then
				break
			end
			if typeof(tabl[path]) == typeof(template[path]) and tabl[path]~=nil and template[path]~=nil then
				tabl = tabl[path] 
				template = template[path] 
				else break end
		end
	end
end

local function getconfig()
	if readfile then
		local success, value = pcall(function() return game:GetService("HttpService"):JSONDecode(readfile("X-PLOX.xpv2")) end)
		if success==true then return success,value else return false,nil end
	else
		CLI:DisplayText("Your exploit can't read files","RED")
		return false, nil
	end end

local function writeconfig(method)
	if writefile then
		local success, config = getconfig()
		local function globalconfig()
			if config~=nil then else config = {} end
			config.GLOBAL = Core
			return config
		end
		local function gameconfig()
			local inheritance = false
			if config~=nil then else config = globalconfig() inheritance = true end
			local id = tostring(game.GameId)
			config.GAMES = config.GAMES or {}
			config.GAMES[id] = config.GAMES[id] or {}
			config.GAMES[id].GLOBAL = inheritance==true and config.GLOBAL or Core
			return config
		end
		local function placeconfig()
			local inheritance = false
			if config~=nil and config.GAMES and config.GAMES[tostring(game.GameId)] then else config = gameconfig() inheritance = true end
			local placeid = tostring(game.PlaceId)
			local gameid = tostring(game.GameId)
			config.GAMES[gameid][placeid] = inheritance==true and config.GAMES[gameid].GLOBAL or Core
			return config
		end

		writefile("X-PLOX.xpv2",game:GetService("HttpService"):JSONEncode(method=="game" and globalconfig() or method=="place" and placeconfig() or globalconfig()))
	else
		CLI:DisplayText("Your exploit can't write files","RED")
	end end

local function readconfig(success, mem)
	local placeid = tostring(game.PlaceId)
	local gameid = tostring(game.GameId)
	--print(success,mem)
	if mem.GAMES and mem.GAMES[gameid] then
		if mem.GAMES[gameid][placeid] then
			for _,N in pairs(Core) do
				Core[_] = mem.GAMES[gameid][placeid][_]
			end return
		end
		for _,N in pairs(Core) do
			Core[_] = mem.GAMES[gameid][_]
		end return
	end
	for _,N in pairs(Core) do
		Core[_] = mem.GLOBAL[_]
	end
end


local commands = {
	help = function() 
		for _,N in pairs(help) do
			CLI:DisplayText(_..": "..N,"") 
		end
		return false 
	end,
	clear = function() rconsoleclear() return true end,
	set = function(args)

		local value = TranslateValue(lowercase(args[#args]))

		table.remove(args,1)
		table.remove(args,#args)

		for _,N in pairs(args) do args[_] = lowercase(N) end

		table.insert(args,value)
		--local memtree = {}

		--[[for _,N in pairs(args) do
			if Core[N]==nil then break end
			table.insert(Core,N)
		end]]
		changeData(Core,args)
		return false
	end,
	ping = function()
		CLI:DisplayText("Current ping: "..string.split(stats():WaitForChild("Network"):WaitForChild("ServerStatsItem"):WaitForChild("Data Ping"):GetValueString()," ")[1].."ms")
		return false
	end,
	config = function(args)
		table.remove(args,1)
		for _,N in pairs(args) do args[_] = lowercase(N) end
		if args[1] == "write" then
			writeconfig(args[2] or "")
		elseif args[1] == "load" then
			readconfig(getconfig())
		elseif args[1] == "reset" then
			for _,N in pairs(Core) do Core[_] = ConfigTemplate[_] end
		end
		return false
	end
}

local function mainmenu(message)
	local welcome = message and "Welcome to the main menu. Type in 'help' to see the command set." or ""
	CLI:Prompt(welcome,"YELLOW",function(t)
		local msg = lowercase(t):split(" ")
		local displaymsg = msg and msg[1] and commands[msg[1]]~=nil and commands[msg[1]](msg) or false
		displaymsg = displaymsg or false
		mainmenu(displaymsg)
	end)
end

mainmenu(true)
