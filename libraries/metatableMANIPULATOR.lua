local spoofer = {}
local tamperedmetatable
spoofer.tamperedinstances = {}

function spoofer:spoof(Inst,prop,val)
if Inst~=nil and typeof(tostring(prop)) then spoofer.tamperedinstances[Inst] = {Property=prop,Value=val} end
end

function spoofer:unspoof(Inst)
if spoofer.tamperedinstances[Inst] then spoofer.tamperedinstances[Inst]=nil end
end

local tamperedmetatable = hookmetamethod(game, "__newindex", newcclosure(function(Self,Index,Value)
   local index = spoofer.tamperedinstances[Self].Property or Index
   local value = spoofer.tamperedinstances[Self].Value or Value
   return tamperedmetatable(Self,index,value)
end))

return spoofer