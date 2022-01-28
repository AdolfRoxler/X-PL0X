local spoofer = {}
spoofer.tamperedmetatable = nil
spoofer.tamperedinstances =  {}

function spoofer:spoof(Inst,Prop,Val)
spoofer.tamperedinstances[Inst][Prop]=Val
end
function spoofer:unspoof(Inst,Prop)
spoofer.tamperedinstances[Inst][Prop]=nil
end

spoofer.tamperedmetatable = hookmetamethod(game,"__index",newcclosure(function(Instance,Type)
if spoofer.tamperedinstances[Instance] and spoofer.tamperedinstances[Instance][Type] then return spoofer.tamperedinstances[Instance][Type],Type
return spoofer.tamperedmetatable(property,Type)
end))
return spoofer