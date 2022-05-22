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

function spoofer:spooffunction(Inst,Function,Args)
if Inst and Function and Args then else return end
if spoofer.tamperedfunctions[Inst]==nil then spoofer.tamperedfunctions[Inst]={} end
spoofer.tamperedfunctions[Inst][tostring(Function)] = Args
end

spoofer.tamperedmetatable = hookmetamethod(game,"__index",newcclosure(function(Instance,Type)
if spoofer.tamperedinstances[Instance] and spoofer.tamperedinstances[Instance][Type] then return spoofer.tamperedinstances[Instance][Type] end
return spoofer.tamperedmetatable(Instance,Type)
end))

spoofer.namecall = hookmetamethod(game, "__namecall", function(Self, ...)
local arguments = {...}
local method = getnamecallmethod()
if not checkcaller() and spoofer.tamperedfunctions[Self]~=nil and spoofer.tamperedfunctions[Self][Function]~=nil then
return spoofer.tamperedfunctions[Self][Function]
end
end)

return spoofer