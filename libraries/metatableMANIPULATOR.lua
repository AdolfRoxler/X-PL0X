local spoofer = {}
spoofer.tamperedmetatable = nil
spoofer.tamperedinstances =  {}

function spoofer:spoof(Inst,Prop,Val)
if Inst and Prop then else return end
if spoofer.tamperedinstances[Inst]==nil then spoofer.tamperedinstances[Inst]={} end
spoofer.tamperedinstances[Inst][Prop]=Val
end
function spoofer:unspoof(Inst,Prop)
if spoofer.tamperedinstances[Inst] and spoofer.tamperedinstances[Inst][Prop] then spoofer.tamperedinstances[Inst][Prop]=nil
elseif spoofer.tamperedinstances[Inst] then spoofer.tamperedinstances[Inst]=nil end
end

spoofer.tamperedmetatable = hookmetamethod(game,"__index",newcclosure(function(Instance,Type)
if spoofer.tamperedinstances[Instance] and spoofer.tamperedinstances[Instance][Type] then return spoofer.tamperedinstances[Instance][Type],Type end
return spoofer.tamperedmetatable(Instance,Type)
end))
return spoofer