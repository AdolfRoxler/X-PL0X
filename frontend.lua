local devmode = type(devmode)=="boolean" and devmode or true
local CLI = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/CLI.lua')()


CLI:DisplayText("X-CLI loaded")