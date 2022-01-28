local spoofer = {}
spoofer.tamperedmetatable = nil
local tamperedmetatable = spoofer.tamperedmetatable
spoofer.tamperedproperties = {}

function spoofer:spoof(Inst,prop,val)
if Inst~=nil and typeof(prop) then spoofer.tamperedproperties[prop] = spoofer.tamperedproperties[prop] or {} spoofer.tamperedproperties[prop][Inst]=val end
end

function spoofer:unspoof(Inst,prop)
if spoofer.tamperedproperties[prop] and spoofer.tamperedproperties[prop][Inst] then spoofer.tamperedinstances[prop][Inst]=nil 
elseif typeof(Inst)=="Instance" and not spoofer.tamperedproperties[prop] then  
for ref,val in pairs(spoofer.tamperedproperties) do
if ref[Inst] then ref[Inst]=nil end
end
end
end

local tamperedmetatable = hookmetamethod(game, "__index", newcclosure(function(Prop,Type)
   local value = spoofer.tamperedproperties[Prop][] or Value
   return tamperedmetatable(Self,value)
end))

return spoofer