local spoofer = {}
spoofer.tamperedmetatable = nil
spoofer.tamperedinstances =  {}

function spoofer:spoof(Inst,Prop,Val)
spoofer.tamperedinstances[Inst][Prop]=Val
end

function spoofer:unspoof(Inst,Prop)
spoofer.tamperedinstances[Inst][Prop]=nil
end

spoofer.tamperedmetatable = hookmetamethod(game,"__index",newcclosure(function(Property,Type)
for INSTANCE in pairs(spoofer.tamperedinstances) do
if INSTANCE[Property] then return INSTANCE[Property],Type
end
return spoofer.tamperedmetatable(property,Type)
end))

return spoofer