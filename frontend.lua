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
_G.ESP = false
local CLI = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/CLI.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/CLI.lua')()
--local wget = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Lget.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Lget.lua')()
--local math = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/arbitrarymath.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/arbitrarymath.lua')()
--local spoofer = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/metatableMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/metatableMANIPULATOR.lua')()

local Core = loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Unused/Stupid%20draft.lua')() --_L.LatestCommit = JSONDecode(Services.HttpService, game.HttpGetAsync(game, "https://api.github.com/repos/fatesc/fates-admin/commits?per_page=1&path=main.lua"))[1]

local function mainmenu(message: boolean)
    local welcome = message and "Welcome to the main menu. Type in 'help' to see the command set." or ""
    CLI:Prompt(welcome,"YELLOW",function(t)
    if lowercase(t)=="help" then help() 
    elseif lowercase(t)=="ESP" then ESP = not ESP 
    mainmenu(false)
    else mainmenu() 
    end
    end)
end

local function help() CLI:DisplayText("umm fuck u go back to the menu","RED") end

mainmenu(true)