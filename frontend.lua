assert(Drawing,"No drawing api?")
--if getgenv().XPL0X then return end
--if getgenv().XPL0XDISABLELOADINGSCREEN then game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen() game:GetService("CoreGui").TeleportGui.Enabled = false scrn = getgenv().XPL0XDISABLELOADINGSCREEN end
local devmode = type(devmode)=="boolean" and devmode or true
rconsoleclear()
rconsoleprint("@@WHITE@@")
rconsoleprint("[!] Frontend script loaded. There will now be an attempt to load the required libraries. \n")
--- code optimization for cli ---
local lowercase = string.lower
---

local CLI = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/CLI.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/CLI.lua')()
--local wget = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Lget.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Lget.lua')()
--local math = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/arbitrarymath.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/arbitrarymath.lua')()
--local spoofer = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/metatableMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/metatableMANIPULATOR.lua')()
local Core = loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Unused/Stupid%20draft.lua')() --_L.LatestCommit = JSONDecode(Services.HttpService, game.HttpGetAsync(game, "https://api.github.com/repos/fatesc/fates-admin/commits?per_page=1&path=main.lua"))[1]


local help = {
	help = "prints this gay ass guide",
	clear = "clears cli output so it's way cleaner to the eye",
	toggle = "toggles shit",
}

local commands = {
	help = function() 
		for _,N in pairs(help) do
			CLI:DisplayText(_..": "..N,"") 
		end
		return false 
	end,
	clear = function() rconsoleclear() return true end,
	toggle = function(args)
		if args[2] then
			local lowercase = lowercase(args[2])
			if lowercase=="esp" then
				local toggle = not Core.ESP
				if args[3] then local a = string.lower(tostring(args[3])) warn(a) if a=="on" then toggle=true elseif a=="off" then toggle=false end end
				--if args[3] then local lowercase = lowercase(args[3]) toggle = (lowercase=="on" and true) or (lowercase=="off" and false)  end
				Core.ESP = toggle
			end
		else
		end
	end,
}


function mainmenu(message: boolean)
	local welcome = message and "Welcome to the main menu. Type in 'help' to see the command set." or ""
	CLI:Prompt(welcome,"YELLOW",function(t)
		local msg = t:split(" ")
		local displaymsg = msg and msg[1] and commands[msg[1]]~=nil and commands[msg[1]](msg) or false
		displaymsg = displaymsg or false
		mainmenu(displaymsg)
	end)
end

mainmenu(true)