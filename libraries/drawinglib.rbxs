if syn then warn("bro nigga chill out I didn't make this for other gaysploits yet") else repeat wait() until syn end
game:GetService("RunService").RenderStepped:connect(function() -- Constant updater to ease up resource use
    Camera = workspace.CurrentCamera
    Resolution = Camera.ViewportSize
end)

local functions = {}

function functions:MakeBox(PosX,PosY,SizeX,SizeY,Filled,BorderThickness,Color)
local Frame = Drawing.new("Quad")
local PX = tonumber(PosX)
local PY = tonumber(-PosY)
local SX = tonumber(SizeX)
local SY = tonumber(SizeY)
local BT = tonumber(BorderThickness)

Frame.PointB.Position = Vector2.new(PX,PY)
Frame.PointA.Position = Vector2.new(PX+SizeX,PY)
Frame.PointC.Position = Vector2.new(PX,PY-SY)
Frame.PointD.Position = Vector2.new(PX+SizeX,PY-SY)

Frame.Filled = Filled

Frame.Color = Color

Frame.Thickness = tonumber(BorderThickness)


return Frame
end

return functions