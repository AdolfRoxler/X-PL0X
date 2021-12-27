if syn then warn("bro nigga chill out I didn't make this for other gaysploits yet") else repeat wait() until syn end
local User = game:GetService('Players').LocalPlayer
game:GetService("RunService").RenderStepped:connect(function() -- Constant updater to ease up resource use
    Camera = workspace.CurrentCamera
    Mouse = User:GetMouse()
    Resolution = Vector2.new(Mouse.ViewSizeX,Mouse.ViewSizeY)
end)
game:GetService("RunService").RenderStepped:Wait()
Mouse.Changed:connect(function(prop)
if MouseMockup then else MouseMockup = Drawing.new("Image") end
if prop == "X" or prop == "Y" then
MouseMockup.Position = Vector2.new(Mouse.X,Mouse.Y)
elseif prop == "Icon" then
MouseMockup.Data = game:HttpGet(tostring(Mouse.Icon))
end
MouseMockup.Size = Vector2.new(17,24)
MouseMockup.Visible = true
MouseMockup.Transparency = 1
MouseMockup.Zindex = 2^31-1
end)

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

Frame.Filled = Filled

Frame.Color = Color

Frame.Visible = true

Frame.Thickness = tonumber(BorderThickness)


return Frame
end

return functions