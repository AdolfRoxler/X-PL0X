local Phys = {}
local PhysQueue = {}
function Phys:MoveTo(Inst,V3,Aggressivity)
	if Inst:IsA("BasePart") then else return end
		PhysQueue[Inst] = {Obj=Inst,MoveTo={V3,Aggressivity}}
end
function Phys:PurgePhysics(Inst)
	if PhysQueue[Inst] then
		PhysQueue[Inst]=nil
	end
end
function Phys:AlignTo(Inst,Cframe,Aggressivity)
	if Inst:IsA("BasePart") then else return end
		PhysQueue[Inst] = {Obj=Inst,AlignTo={Inst,Cframe,Aggressivity}}
end

game:GetService("RunService").Stepped:connect(function(t,delta)
	for Obj,_ in pairs(PhysQueue) do
		if _.Obj then
		elseif not _.Obj:IsA("BasePart") then PhysQueue[Obj]=nil continue
		else PhysQueue[Obj]=nil continue end


		if _.MoveTo then
		local v3 = _.MoveTo[1] or Vector3.new(0,0,0)
		if typeof(v3)=="CFrame" then v3 = _.MoveTo[1].p end
        local vector = (v3-_.Obj.CFrame.p)
        _.Obj.AssemblyLinearVelocity = (vector*_.MoveTo[2])
        warn(_.Obj.AssemblyLinearVelocity)
		elseif _.AlignTo then end --- not filling in yet
	end
end)---- This is the thread that does ALL of the work
return Phys