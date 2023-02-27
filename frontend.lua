assert(Drawing,"No drawing api?")
--if getgenv().XPL0X then return end
--if getgenv().XPL0XDISABLELOADINGSCREEN then game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen() game:GetService("CoreGui").TeleportGui.Enabled = false scrn = getgenv().XPL0XDISABLELOADINGSCREEN end
local devmode = type(devmode)=="boolean" and devmode or true
rconsoleclear()
rconsoleprint("@@WHITE@@")
rconsoleprint("[!] Frontend loaded. Press a key to nudge the CLI to continue loading. \n")
--- code optimization for cli ---
local lowercase = string.lower
---

local CLI = game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/CLI.lua'
--local ConfigTemplate = game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Config.lua'
local Core = game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/X-API.lua'

CLI = loadstring(CLI)()
--ConfigTemplate = loadstring(ConfigTemplate)()
Core = loadstring(Core)()
--local wget = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Lget.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Lget.lua')()
--local math = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/arbitrarymath.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/arbitrarymath.lua')()
--local spoofer = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/metatableMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/metatableMANIPULATOR.lua')()
--_L.LatestCommit = JSONDecode(Services.HttpService, game.HttpGetAsync(game, "https://api.github.com/repos/fatesc/fates-admin/commits?per_page=1&path=main.lua"))[1]


local help = {
	help = "prints this gay ass guide",
	clear = "clears cli output so it's way cleaner to the eye",
	set = "Example: set ESP Enabled true | set ESP Boxes true \nFor reference: check out the default config.",
}

local function changeData(tabl,pathArray) --- stolen from devforum | Source: https://devforum.roblox.com/t/how-to-make-equivalent-of-instancegetfullname-for-tables/1114061
	--send pathArray to client
	for index, path in ipairs(pathArray) do
		if pathArray[index + 2]==nil then
			tabl[path] = pathArray[index + 1]
		else
			if tabl[path]==nil then
				break
			end
			tabl = tabl[path]
		end
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

		table.insert(args,value)
		--local memtree = {}

		--[[for _,N in pairs(args) do
			if Core[N]==nil then break end
			table.insert(Core,N)
		end]]
		changeData(Core,args)
		return false
	end,
}

function TranslateValue(str)
	local tr = nil
	if str=="on" or str=="true" then tr=true
	elseif str=="off" or str=="false" then tr=false
	end
	return tr
end

function CheckValidity(val)
end


function mainmenu(message)
	local welcome = message and "Welcome to the main menu. Type in 'help' to see the command set." or ""
	CLI:Prompt(welcome,"YELLOW",function(t)
		local msg = t:split(" ")
		local displaymsg = msg and msg[1] and commands[msg[1]]~=nil and commands[msg[1]](msg) or false
		displaymsg = displaymsg or false
		mainmenu(displaymsg)
	end)
end

mainmenu(true)