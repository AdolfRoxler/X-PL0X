local wget = {}
wget.Root = "LuaGet_Cache"
if isfolder(wget.Root) then else makefolder(wget.Root) end

function wget:Download(URL,overwrite,forcefilename)
local overwrite,forcefilename = overwrite,forcefilename~=nil and tostring(forcefilename) or nil
if type(overwrite)=="boolean" then else overwrite = false end
local URL = tostring(URL) or ""
local asset=syn.request({Url=URL,Method='GET'});
if asset.Success then else return nil end
local Subdirectories = URL:split('/')
local cachedfiles = listfiles(wget.Root)
local nameassembly = Subdirectories[#Subdirectories]

if #Subdirectories==1 then Subdirectories={"unknown.png"} end

local format = nameassembly:split(".")
format = format[#format]
local filename = string.sub(nameassembly,"1",string.len(nameassembly)-(string.len(format)+1))
local clonestr = "."
format = forcefilename==nil and format or forcefilename

if overwrite==false then --- imitates windows' way to manage multiple downloaded files with the same name
local clonenumber=0
for _,N in pairs(cachedfiles) do 
local pn = N:split([[\]]) or N:split('/')
local clonesubfix = pn[#pn]:split(" (") 
if #clonesubfix>1 then clonenumber = clonenumber+1 
end end
if isfile(wget.Root.."/"..filename..clonestr..format) then clonenumber = clonenumber+1 end
if clonenumber>0 then clonestr = " ("..tostring(clonenumber)..")." end
end


local path = wget.Root.."/"..filename..clonestr..format

writefile(path,asset.Body)
return getsynasset(path)
end

function wget:LoadFile(file)
local rawpath = tostring(file) or ""
local Subdirectories = rawpath:split('/') or rawpath:split([[\]])
local filename = rawpath and Subdirectories and Subdirectories[#Subdirectories] or rawpath
local cachedfiles = listfiles(wget.Root)
local result = nil

for _,N in pairs(cachedfiles) do
local pn = N:split([[\]])
if N==filename or pn[#pn]==filename then result = N break end
end

return result~=nil and getsynasset(result) or nil
end

return wget