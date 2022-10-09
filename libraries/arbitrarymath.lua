local module = {}
function module.roundtodecimal(X,decimallimit)
if decimallimit then else decimallimit = 0 end ---found doing this for every time I wanted to round exhausting so here's this piece of shit
decimalpointer = 10^math.abs(decimallimit)
return math.round(X*(decimalpointer))/decimalpointer
end

function module:InverseWorldToViewportPoint(V3)
local PlrCameraOffset = workspace.CurrentCamera.CFrame:PointToObjectSpace(V3)
local AT = math.atan2(PlrCameraOffset.Y, PlrCameraOffset.X) + math.pi;
local inverse = CFrame.Angles(0, 0, AT):vectorToWorldSpace((CFrame.Angles(0, math.rad(89.9), 0):vectorToWorldSpace(Vector3.new(0, 0, -1)))); --- my brain too ooga booga for this shit
return workspace.CurrentCamera:WorldToViewportPoint(workspace.CurrentCamera.CFrame:pointToWorldSpace(inverse))
end

function module:clamp(a:number,b:number,c:number)
local m = a>=b
local M = a<=c
return ((m and M) and a) or ((not m and M) and b) or ((m and not M) and c)
end

function module:abs(a:number)
    return (0>a and a*-1) or a
end

function module.truncate(f,x) return math.floor(f*x)/x end 

return setmetatable(module, { __index = math })