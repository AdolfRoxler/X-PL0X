meth = {}
meth.pi = math.pi()
function meth.round(X,decimallimit)
if decimallimit then else decimallimit = 0 end ---found doing this for every time I wanted to round exhausting so here's this piece of shit
decimalpointer = 10^math.abs(decimallimit)
return math.round(X*(decimalpointer))/decimalpointer
end

function meth:InverseWorldToViewportPoint(V3)
local PlrCameraOffset = workspace.CurrentCamera.CFrame:PointToObjectSpace(V3)
local AT = math.atan2(PlrCameraOffset.Y, PlrCameraOffset.X) + math.pi;
local inverse = CFrame.Angles(0, 0, AT):vectorToWorldSpace((CFrame.Angles(0, math.rad(89.9), 0):vectorToWorldSpace(Vector3.new(0, 0, -1)))); --- my brain too ooga booga for this shit
return workspace.CurrentCamera:WorldToViewportPoint(workspace.CurrentCamera.CFrame:pointToWorldSpace(inverse))
end

return meth