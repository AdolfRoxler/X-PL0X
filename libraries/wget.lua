local wget = {}
local wget.Root = "LuaGet_Cache"
if isfolder(wget.Root) then else makefolder(wget.Root) end

function wget:Download(URL)
local path = wget.Root.."/".."name.FORMAT"
writefile(),game:GttpGet(URL))
return getsynasset(path)
end

return wget