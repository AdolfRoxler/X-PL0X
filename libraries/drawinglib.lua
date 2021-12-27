if syn then warn("bro nigga chill out I didn't make this for other gaysploits yet") else repeat wait() until syn end
local User = game:GetService('Players').LocalPlayer
game:GetService("RunService").RenderStepped:connect(function() -- Constant updater to ease up resource use
    Camera = workspace.CurrentCamera
    Mouse = User:GetMouse()
    Resolution = Vector2.new(Mouse.ViewSizeX,Mouse.ViewSizeY)
end)
lownumber = (2^31-1)*-1
warn(lownumber)

local functions = {}

function functions:MakeBox(PosX,PosY,SizeX,SizeY,Filled,BorderThickness,Color)
local PX = tonumber(PosX)
local PY = tonumber(PosY)
local SX = tonumber(SizeX)
local SY = tonumber(SizeY)
local BT = tonumber(BorderThickness)

if PX and PY and SX and SY then else return nil end

local Frame = Drawing.new("Quad")

Frame.PointB = Vector2.new(PX,PY)
Frame.PointA = Vector2.new(PX+SizeX,PY)
Frame.PointC = Vector2.new(PX,PY+SY)
Frame.PointD = Vector2.new(PX+SizeX,PY+SY)

if Filled == true or Filled == false then
Frame.Filled = Filled 
else end

Frame.Color = Color

Frame.Visible = true

Frame.Thickness = tonumber(BorderThickness)

Frame.Zindex = lownumber

return Frame
end

return functions