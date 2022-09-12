assert(Drawing,"No drawing api?")
--if getgenv().XPL0X then return end
--if getgenv().XPL0XDISABLELOADINGSCREEN then game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen() game:GetService("CoreGui").TeleportGui.Enabled = false scrn = getgenv().XPL0XDISABLELOADINGSCREEN end
local devmode = type(devmode)=="boolean" and devmode or true
rconsoleprint("[!] Frontend script loaded. There will now be an attempt to load the required libraries. \n")
local CLI = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/CLI.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/CLI.lua')()
--local wget = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Lget.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Lget.lua')()
--local math = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/arbitrarymath.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/arbitrarymath.lua')()
--local spoofer = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/metatableMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/metatableMANIPULATOR.lua')()

local Core = loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Unused/Stupid%20draft.lua')()