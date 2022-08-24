if not syn then warn("not supported lol!") else repeat wait() until syn end
local User = game:GetService('Players').LocalPlayer
game:GetService("RunService").RenderStepped:connect(function() -- Im lazy ok?
    Camera = workspace.CurrentCamera
    Mouse = User:GetMouse()
    Resolution = Camera.ViewportSize
end)
local GraphicalHierarchy = {}

local functions = {}

function functions:CreateFrame(Pos,Size,Filled,BorderThickness,Color) --- Scaling based on vertical res because it's better. Argue with the retards that stretch like the guys on WOS and make ultrawide unplayable
if Pos and Size then else return nil end
local Frame = Drawing.new("Quad")

local PX = Pos.X.Scale*Resolution.X+Pos.X.Offset      -- this of course should not depend on vertical res
local PY = Pos.Y.Scale*Resolution.Y+Pos.Y.Offset
local SizeX = Size.X.Scale*Resolution.Y+Size.X.Offset
local SizeY = Size.Y.Scale*Resolution.Y+Size.Y.Offset

Frame.PointB = Vector2.new(PX,PY)
Frame.PointA = Vector2.new(PX+SizeX,PY)
Frame.PointC = Vector2.new(PX,PY+SizeY)
Frame.PointD = Vector2.new(PX+SizeX,PY+SizeY)

if type(Filled)=="boolean" then
Frame.Filled = Filled 
end
Frame.Color = Color
Frame.Visible = true
Frame.Thickness = tonumber(BorderThickness)
GraphicalHierarchy[Frame] = {}
return Frame
end

return functions