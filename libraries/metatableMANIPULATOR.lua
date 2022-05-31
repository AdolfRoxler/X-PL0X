local spoofer = {}
spoofer.tamperedmetatable = nil
spoofer.namecall = nil
spoofer.tamperedinstances =  {}
spoofer.tamperedfunctions = {}
spoofer.dumpedfunctions = {}
spoofer.frozenfunctions = {}

function spoofer:spoof(Inst,Prop,Val,ignoresyn)
if Inst and Prop then else return end
if spoofer.tamperedinstances[Inst]==nil then spoofer.tamperedinstances[Inst]={} end
local ignoresyn = ignoresyn
if type(ignoresyn)=="boolean" then else ignoresyn=true end
spoofer.tamperedinstances[Inst][Prop]={Val,ignoresyn}
end

function spoofer:unspoof(Inst,Prop)
if spoofer.tamperedinstances[Inst] and spoofer.tamperedinstances[Inst][Prop] then spoofer.tamperedinstances[Inst][Prop]=nil
elseif spoofer.tamperedinstances[Inst] then spoofer.tamperedinstances[Inst]=nil end
end

function spoofer:spooffunction(inst,Function,Replacement,ignoresyn,Args)
if inst and Function and Replacement then else return end
local Inst = inst
if typeof(Inst)=="Instance" then else Inst=false end
local ignoresyn = ignoresyn
if type(ignoresyn)=="boolean" then else ignoresyn=true end
if spoofer.tamperedfunctions[Inst]==nil then spoofer.tamperedfunctions[Inst]={} end
if spoofer.tamperedfunctions[Inst][Function]==nil then spoofer.tamperedfunctions[Inst][Function]={} end
spoofer.tamperedfunctions[Inst][Function].Target = Args
spoofer.tamperedfunctions[Inst][Function].Replacement = Replacement
spoofer.tamperedfunctions[Inst][Function].ignoresyn = ignoresyn
end

function spoofer:unspooffunction(Inst,Function)
if Inst and Function then else return end
if spoofer.tamperedfunctions[Inst]~=nil and spoofer.frozenfunctions[Inst][Function]~=nil then spoofer.tamperedfunctions[Inst][Function]=nil return end
if spoofer.tamperedfunctions[Inst]~=nil then spoofer.tamperedfunctions[Inst]=nil end
end

function spoofer:probefunction(inst,Function,ignoresyn)
if inst and Function then else return end
local Inst = inst
if typeof(Inst)=="Instance" then else Inst=false end
local ignoresyn = ignoresyn
if type(ignoresyn)=="boolean" then else ignoresyn=true end
if spoofer.dumpedfunctions[Inst]==nil then spoofer.dumpedfunctions[Inst]={} end
if spoofer.dumpedfunctions[Inst][Function]==nil then spoofer.dumpedfunctions[Inst][Function]={} end
spoofer.dumpedfunctions[Inst][Function].engaged = true
spoofer.dumpedfunctions[Inst][Function].ignoresyn = ignoresyn
end

function spoofer:dumpfunction(Inst,Function,ignoresyn) spoofer:probefunction(Inst,Function,ignoresyn) end

function spoofer:releasefunction(Inst,Function)
if Inst then else return end
if spoofer.dumpedfunctions[Inst]~=nil and spoofer.dumpedfunctions[Inst][Function]~=nil then
spoofer.dumpedfunctions[Inst][Function]=nil else spoofer.dumpedfunctions[Inst]=nil end
end

function spoofer:undumpfunction(Inst,Function) spoofer:releasefunction(Inst,Function) end


function spoofer:freezefunction(inst,Function,ignoresyn)
if inst and Function then else return end
local Inst = inst
if typeof(Inst)=="Instance" then else Inst=false end
local ignoresyn = ignoresyn
if type(ignoresyn)=="boolean" then else ignoresyn=true end
if spoofer.frozenfunctions[Inst]==nil then spoofer.frozenfunctions[Inst]={} end
spoofer.frozenfunctions[Inst][Function]={Instance.new("BindableEvent"),ignoresyn}
end
function spoofer:stallfunction(Inst,Function,ignoresyn) spoofer:freezefunction(Inst,Function,ignoresyn) end

function spoofer:unfreezefunction(inst,Function,resumepreviouscalls)
if inst then else return end
local Inst = inst
if typeof(Inst)=="Instance" then else Inst=false end
local resumepreviouscalls = resumepreviouscalls
if type(resumepreviouscalls)=="boolean" then else resumepreviouscalls = false end
if spoofer.frozenfunctions[Inst]~=nil and spoofer.frozenfunctions[Inst][Function]~=nil then if resumepreviouscalls==true then spoofer.frozenfunctions[Inst][Function][1]:Fire() end spoofer.frozenfunctions[Inst][Function]=nil return else
spoofer.frozenfunctions[Inst]=nil end
end
function spoofer:unstallfunction(Inst,Function,r) spoofer:unfreezefunction(Inst,Function,r) end
function spoofer:thawfunction(Inst,Function,r) spoofer:unfreezefunction(Inst,Function,r) end

local crackheadmt

spoofer.tamperedmetatable = hookmetamethod(game,"__index",newcclosure(function(Instance,Type)
if spoofer.tamperedinstances[Instance] and spoofer.tamperedinstances[Instance][Type] and spoofer.tamperedinstances[Instance][Type][1] and spoofer.tamperedinstances[Instance][Type][2] and not(checkcaller()==true and spoofer.tamperedinstances[Instance][Type][2]==true) then return spoofer.tamperedinstances[Instance][Type][1] end
return spoofer.tamperedmetatable(Instance,Type)
end))

spoofer.namecall = hookmetamethod(game, "__namecall", newcclosure(function(Self,...)
local syncall = checkcaller()
local method = getnamecallmethod()
local finalchoice = spoofer.namecall(Self,...)

local Self2 = spoofer.dumpedfunctions[Self]~=nil and Self or false


if spoofer.dumpedfunctions[Self2]~=nil and spoofer.dumpedfunctions[Self2][method]~=nil and spoofer.dumpedfunctions[Self2][method].engaged==true and not (syncall==true and spoofer.dumpedfunctions[Self2][method].ignoresyn==true) then 
--local args = type(...)=="table" and tostring(table.unpack(...)) or tostring(...)
--print(args)
print(tostring(method)..':\n{ \n Self: '..tostring(Self).." \n Arguments: "..tostring(...).." \n}")
--print('Self: '..tostring(Self)..",")
--print(tostring(...))
--print("}")
end


Self2 = spoofer.tamperedfunctions[Self]~=nil and Self or false

if spoofer.tamperedfunctions[Self2] and spoofer.tamperedfunctions[Self2][method] and spoofer.tamperedfunctions[Self2][method].Replacement then
if spoofer.tamperedfunctions[Self2][method].ignoresyn==true and syncall==true then finalchoice = spoofer.namecall(Self,...) end
--if spoofer.tamperedfunctions[Self][method].Target~=nil and spoofer.tamperedfunctions[Self][method].Target==arguments then return spoofer.namecall(Self,spoofer.tamperedfunctions[Self][method].Replacement) elseif spoofer.tamperedfunctions[Self][method].Target==nil then return spoofer.namecall(Self,spoofer.tamperedfunctions[Self][method].Replacement) end end
--return spoofer.tamperedfunctions[Self][method].Replacement
--if spoofer.tamperedfunctions[Self][method].Target == ... or spoofer.tamperedfunctions[Self][method].Target == nil then

if spoofer.tamperedfunctions[Self2][method].Target == nil or (spoofer.tamperedfunctions[Self2][method].Target~=nil and spoofer.tamperedfunctions[Self2][method].Target == ...) then
finalchoice = spoofer.tamperedfunctions[Self2][method].Replacement
end
--else
--end

end
--print(...)
Self2 = spoofer.frozenfunctions[Self]~=nil and Self or false
if spoofer.frozenfunctions[Self2]~=nil and spoofer.frozenfunctions[Self2][method]~=nil and not(syncall==true and spoofer.frozenfunctions[Self2][method][2]==true) then spoofer.frozenfunctions[Self2][method][1].Event:Wait() return finalchoice --spoofer.frozenfunctions[Self2][method][1].Event:Wait() warn("allah") end
else return finalchoice end
end))




        --[[spoofer:dumpfunction(workspace,"FindPartOnRayWithIgnoreList") --- These are dump function examples
        spoofer:dumpfunction(workspace,"FindPartOnRayWithWhitelist")
        spoofer:dumpfunction(workspace,"FindPartOnRay")
        spoofer:dumpfunction(workspace,"findPartOnRay")
        spoofer:dumpfunction(workspace,"Raycast")]] --- cba to do docs figure out urself fucking skid!

--I bet my ass this can be even more optimized lol

return spoofer