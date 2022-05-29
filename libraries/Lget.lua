local wget = {}
wget.Root = "LuaGet_Cache"
if isfolder(wget.Root) then else makefolder(wget.Root) end

function wget:Download(URL,errorcheck)
local URL = tostring(URL)
local asset=syn.request({Url=URL,Method='GET'});
if asset.Success then else return nil end
local Subdirectories = URL:split('/')
local cachedfiles = listfiles(wget.Root)

--[[if #Subdirectories==1 then  
local number = math.random(0,math.huge)
repeat math.randomseed(os.time) number = math.random(0,math.huge) until not
Subdirectories={"unknown("..number..").png"}
end]]

local path = wget.Root.."/".."name.FORMAT"
--writefile(),game:GttpGet(URL))
return getsynasset(path)
end

function wget:LoadFile(file)
local rawpath = tostring(file)
local Subdirectories = rawpath:split('/') or rawpath:split([[\]])
local filename = rawpath and Subdirectories and tostring(Subdirectories[#Subdirectories]) or rawpath
print(filename)

local cachedfiles = listfiles(wget.Root)
local result = nil

for _,N in pairs(cachedfiles) do
local pn = N:split([[\]])
print(tostring(pn[#pn]))
if N==filename or pn[#pn]==filename then result = N break end
end

return result~=nil and getsynasset(result) or nil
end

return wget