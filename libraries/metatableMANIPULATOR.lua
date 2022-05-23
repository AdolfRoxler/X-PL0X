local spoofer = {}
spoofer.tamperedmetatable = nil
spoofer.namecall = nil
spoofer.tamperedinstances =  {}
spoofer.tamperedfunctions = {}
spoofer.dumpedfunctions = {}

function spoofer:spoof(Inst,Prop,Val)
if Inst and Prop then else return end
if spoofer.tamperedinstances[Inst]==nil then spoofer.tamperedinstances[Inst]={} end
spoofer.tamperedinstances[Inst][Prop]=Val
end

function spoofer:unspoof(Inst,Prop)
if spoofer.tamperedinstances[Inst] and spoofer.tamperedinstances[Inst][Prop] then spoofer.tamperedinstances[Inst][Prop]=nil
elseif spoofer.tamperedinstances[Inst] then spoofer.tamperedinstances[Inst]=nil end
end

function spoofer:spooffunction(Inst,Function,ignoresyn,Replacement,Args)
if Function and Replacement then else return end
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
if spoofer.tamperedfunctions[Inst][Function]~=nil then spoofer.tamperedfunctions[Inst][Function]=nil return end
if spoofer.tamperedfunctions[Inst]~=nil then spoofer.tamperedfunctions[Inst]=nil end
end

function spoofer:probefunction(Inst,Function)
if Function then else return end
if typeof(Inst)=="Instance" then else Inst=false end
spoofer.dumpedfunctions[Inst][Function]=true
end

function spoofer:releasefunction(Inst,Function)
if Inst and Function then else return end
spoofer.dumpedfunctions[Inst][Function]=nil
end

spoofer.tamperedmetatable = hookmetamethod(game,"__index",newcclosure(function(Instance,Type)
if spoofer.tamperedinstances[Instance] and spoofer.tamperedinstances[Instance][Type] then return spoofer.tamperedinstances[Instance][Type] end
return spoofer.tamperedmetatable(Instance,Type)
end))

spoofer.namecall = hookmetamethod(game, "__namecall", function(Self,...)
local method = getnamecallmethod()
local Self2 = spoofer.tamperedfunctions[Self] and Self or false
if spoofer.tamperedfunctions[Self2] and spoofer.tamperedfunctions[Self2][method] and spoofer.tamperedfunctions[Self2][method].Replacement then
if spoofer.tamperedfunctions[Self2][method].ignoresyn==true and checkcaller() then return spoofer.namecall(Self,...) end
--if spoofer.tamperedfunctions[Self][method].Target~=nil and spoofer.tamperedfunctions[Self][method].Target==arguments then return spoofer.namecall(Self,spoofer.tamperedfunctions[Self][method].Replacement) elseif spoofer.tamperedfunctions[Self][method].Target==nil then return spoofer.namecall(Self,spoofer.tamperedfunctions[Self][method].Replacement) end end
--return spoofer.tamperedfunctions[Self][method].Replacement
--if spoofer.tamperedfunctions[Self][method].Target == ... or spoofer.tamperedfunctions[Self][method].Target == nil then
if spoofer.dumpedfunctions[Self2][method] then print('Self: '..Self..' | Arguments: '..(...)) end
if spoofer.tamperedfunctions[Self2][method].Target == nil or (spoofer.tamperedfunctions[Self2][method].Target~=nil and spoofer.tamperedfunctions[Self2][method].Target == ...) then
return spoofer.tamperedfunctions[Self2][method].Replacement
end
--else
--end

end
--print(...)
return spoofer.namecall(Self,...)
end)

--spoofer:spooffunction(game,"GetService",true,game.ReplicatedStorage)
--spoofer:spooffunction(false,"FindPartOnRay",false,workspace)
return spoofer