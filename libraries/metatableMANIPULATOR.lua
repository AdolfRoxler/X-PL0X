local spoofer = {}
spoofer.tamperedmetatable = nil
spoofer.namecall = nil
spoofer.tamperedinstances =  {}
spoofer.tamperedfunctions = {}

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
if Inst and Function and Replacement then else return end
local ignoresyn2 = ignoresyn
if type(ignoresyn2)=="boolean" then else ignoresyn2=true end
if spoofer.tamperedfunctions[Inst]==nil then spoofer.tamperedfunctions[Inst]={} end
if spoofer.tamperedfunctions[Inst][Function]==nil then spoofer.tamperedfunctions[Inst][Function]={} end
spoofer.tamperedfunctions[Inst][Function].Target = Args
spoofer.tamperedfunctions[Inst][Function].Replacement = Replacement
spoofer.tamperedfunctions[Inst][Function].ignoresyn = ignoresyn2
end

spoofer.tamperedmetatable = hookmetamethod(game,"__index",newcclosure(function(Instance,Type)
if spoofer.tamperedinstances[Instance] and spoofer.tamperedinstances[Instance][Type] then return spoofer.tamperedinstances[Instance][Type] end
return spoofer.tamperedmetatable(Instance,Type)
end))

spoofer.namecall = hookmetamethod(game, "__namecall", function(Self, ...)
local method = getnamecallmethod()

if spoofer.tamperedfunctions[Self] and spoofer.tamperedfunctions[Self][method] and spoofer.tamperedfunctions[Self][method].Replacement then
if spoofer.tamperedfunctions[Self][method].ignoresyn==true and checkcaller() then return spoofer.namecall(Self,...) end
--if spoofer.tamperedfunctions[Self][method].Target~=nil and spoofer.tamperedfunctions[Self][method].Target==arguments then return spoofer.namecall(Self,spoofer.tamperedfunctions[Self][method].Replacement) elseif spoofer.tamperedfunctions[Self][method].Target==nil then return spoofer.namecall(Self,spoofer.tamperedfunctions[Self][method].Replacement) end end
--return spoofer.tamperedfunctions[Self][method].Replacement

if spoofer.tamperedfunctions[Self][method].Target == ... or spoofer.tamperedfunctions[Self][method].Target == nil then
print("hacked")
return spoofer.namecall(Self,spoofer.tamperedfunctions[Self][method].Replacement)
else
end

end
--print(...)
return spoofer.namecall(Self,...)
end)

spoofer:spooffunction(game,"GetService",true,game.ReplicatedStorage)