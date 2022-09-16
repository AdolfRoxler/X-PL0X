local API = {}
rconsolename("X-CLI")
function API:DisplayText(Text: string, Color: string)
	if Text and Text~="" then
	local Color = Color and Color~="" and "@@"..Color.."@@" or "@@WHITE@@"
	rconsoleprint(Color)
	rconsoleprint("[!] "..Text.."\n")
	end
end

function API:Prompt(Prompt: string, Color: string, Callback)
	API:DisplayText(Prompt.."\n",Color)
	rconsoleprint("@@LIGHT_GREEN@@")
    rconsoleprint("["..game:GetService("Players").LocalPlayer.Name.."@"..game:GetService("Players").LocalPlayer.DisplayName.."]$ ")
	rconsoleprint("@@WHITE@@")
	local Callback = Callback or function() end
	pcall(function() Callback(rconsoleinput()) end)
end

return API

---- This copies linux terminal style loleris