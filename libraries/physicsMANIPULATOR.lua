local Phys = {}
local PhysQueue = {}

function Phys:MoveTo(Inst,Cframe,Aggressivity)
	if Inst:IsA("BasePart") then else return end
	if PhysQueue[Inst] then 
		PhysQueue[Inst].MoveTo = {Cframe,Aggressivity}
	else
		PhysQueue[Inst] = {Obj=Inst,MoveTo={Cframe,Aggressivity}}
	end
end
function Phys:PurgePhysics(Inst)
	if PhysQueue[Inst] then
		PhysQueue[Inst]=nil
	end
end
function Phys:AlignTo(Inst,Cframe,Aggressivity)
	if Inst:IsA("BasePart") then else return end
	if PhysQueue[Inst] then 
		PhysQueue[Inst].AlignTo = {Cframe,Aggressivity}
	else
		PhysQueue[Inst] = {Obj=Inst,AlignTo={Inst,Cframe,Aggressivity}}
	end
end

game:GetService("RunService").Stepped:connect(function()
	for Obj,_ in pairs(PhysQueue) do
		if _.Obj then if isnetworkowner(_.Obj) then 
			else continue end 
		elseif not _.Obj:IsA("BasePart") then PhysQueue[Obj]=nil continue
		else PhysQueue[Obj]=nil continue end


		if _.MoveTo then local vector = _.MoveTo[1].p-_.Obj.CFrame.p _.Obj.AssemblyLinearVelocity = vector*vector.Magnitude*_.MoveTo[2]
		elseif _.AlignTo then end --- not filling in yet
	end
end)---- This is the thread that does ALL of the work

return Phys