local API = {}

rconsolename("X-CLI")
function API:DisplayText(Text: string, Color: string)
	if Text and Text~="" and Text~="\n" then
	if syn then Color = Color~="" and "@@"..Color.."@@" or "@@WHITE@@" else Color = Color~="" and Color or "white" end
	--local Color = Color and Color~="" and (syn and ("@@"..Color.."@@" or "@@WHITE@@") or (white"))
	rconsoleprint(Color)
	rconsoleprint("[!] "..Text.."\n")
	end
end

function API:Prompt(Prompt: string, Color: string, Callback)
	API:DisplayText(Prompt.."\n",Color)
	rconsoleprint(syn and "@@LIGHT_GREEN@@" or "bgreen")
    rconsoleprint("["..game:GetService("Players").LocalPlayer.Name.."@"..game:GetService("Players").LocalPlayer.DisplayName.."]$ ")
	rconsoleprint(syn and "@@WHITE@@" or "white")
	local Callback = Callback or function() end
	pcall(function() Callback(rconsoleinput()) end)
end

return API

---- This copies linux terminal style loleris
