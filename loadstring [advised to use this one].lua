local devmode = devmode or false --- Change this if you want to switch on developer mode.
if devmode then 
loadstring(game:HttpGet("https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/frontend.lua", true))()
else
loadstring(game:HttpGet("https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/frontend.lua", true))() end