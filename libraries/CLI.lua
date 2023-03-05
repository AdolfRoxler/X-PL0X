local API = {}
rconsolename("X-CLI")
function API:DisplayText(Text: string, Color: string)
	if Text and Text~="" and Text~="\n" then
	Color = Color~=nil and Color or ""
	if syn then Color = Color~="" and "@@"..Color.."@@" else end
	--local Color = Color and Color~="" and (syn and ("@@"..Color.."@@" or "@@WHITE@@") or (white"))
	if syn then
	rconsoleprint(Color)
	end
	rconsoleprint("[!] "..Text.."\n")
	end
end

function API:Prompt(Prompt: string, Color: string, Callback)
	API:DisplayText(Prompt.."\n",Color)
	if syn then rconsoleprint("@@LIGHT_GREEN@@") end
    rconsoleprint("["..game:GetService("Players").LocalPlayer.Name.."@"..game:GetService("Players").LocalPlayer.DisplayName.."]$ ")
	if syn then rconsoleprint(syn and "@@WHITE@@" or "") end
	local Callback = Callback or function() end
	pcall(function() Callback(rconsoleinput()) end)
end

return API
---- This copies linux terminal style loleris
