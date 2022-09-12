--- Rewrite
local devmode = devmode or true

local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local User = Players.LocalPlayer
local GuiService = game:GetService("GuiService")
local Ve3n = Vector3.new
local Ve2n = Vector2.new
local CFN = CFrame.new
local WTVP = Camera.WorldToViewportPoint
local WorldToViewport = function(...) return WTVP(Camera, ...) end
local Mouse = User:GetMouse()
local Resolution = Ve2n(Mouse.ViewSizeX,Mouse.ViewSizeY)
local PlayerList = {}
local Random = Random.new(tick())
local Draw = Drawing.new
local SafeFolder = Instance.new("Folder",game.CoreGui) SafeFolder.Name = "GhettoSmosh"
local lowvalue = -(2^31-1)
syn.protect_gui(SafeFolder)

--- Libraries

local math = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/arbitrarymath.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/arbitrarymath.lua')()


--- Crosshair objects

local CR1 = Draw("Line")
local CR2 = Draw("Line")
local AIMSTATUS = Draw("Text")

---

local DELTA = 1

--- Debounces

local FIRING = false
local DeletedInstances = {}
local RaycastConfig = RaycastParams.new()
RaycastConfig.FilterType = Enum.RaycastFilterType.Blacklist
RaycastConfig.IgnoreWater = true

local MAPRESTORING = false
local Teleporting = false

---

local function RefreshPlayers()
	for _,N in pairs(Players:GetPlayers()) do 
		if N and N~=User then 
			PlayerList[N] = PlayerList[N] or {}
			PlayerList[N].CheapChams = PlayerList[N].CheapChams or Instance.new("Highlight")
			PlayerList[N].Box = PlayerList[N].Box or Draw("Quad")
			PlayerList[N].Skeleton = PlayerList[N].Skeleton or {}
			PlayerList[N].Circle = PlayerList[N].Circle or Draw("Circle")
			PlayerList[N].Healthbar = PlayerList[N].Healthbar or {Draw("Quad"),Draw("Quad"),Draw("Quad")}
			PlayerList[N].Text = PlayerList[N].Text or Draw("Text")
			PlayerList[N].Tracer = PlayerList[N].Tracer or Draw("Line")
		else
			if PlayerList[N] then 
				for _,N in pairs(PlayerList[N]) do
					N:Remove()
				end
			end
		end 
	end
end

local function RandomPlayer(ExcludePlayer: Instance)
	local t = Players:GetPlayers()
	t = not ExcludePlayer and t or table.remove(t,table.find(t,ExcludePlayer))
	return t[Random:NextInteger(1,#t)]
end

local function MatchName(Player)
	local tab = {}
	for _,player in pairs(Players:GetPlayers()) do
		if tostring(player.DisplayName):lower():find(tostring(Player):lower())==1 or tostring(player.Name):lower():find(tostring(Player):lower())==1 then
			table.insert(tab,player)
		end
	end
	return tab
end

local function GetBoundingBox(model: Instance, recursive: boolean, orientation: CFrame, mustcollide: boolean) ----- copypasted code xdflol
	if typeof(model) == "Instance" then
		model = recursive and model:GetDescendants() or model:GetChildren() --- had to modify some shit, last two variables are implemented by me
	end
	local orientation = orientation~=nil and orientation or CFN()
	local minx, miny, minz = math.huge,math.huge,math.huge
	local maxx, maxy, maxz = -math.huge,-math.huge,-math.huge
	for _, obj in pairs(model) do
		if obj:IsA("BasePart") then
			if (mustcollide==true and obj.CanCollide==false) then continue end
			local cf = orientation:toObjectSpace(obj.CFrame)
			local sx, sy, sz = obj.Size.X, obj.Size.Y, obj.Size.Z
			local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cf:components()
			local wsx = 0.5 * (math.abs(R00) * sx + math.abs(R01) * sy + math.abs(R02) * sz)
			local wsy = 0.5 * (math.abs(R10) * sx + math.abs(R11) * sy + math.abs(R12) * sz)
			local wsz = 0.5 * (math.abs(R20) * sx + math.abs(R21) * sy + math.abs(R22) * sz)
			if minx > x - wsx then
				minx = x - wsx
			end
			if miny > y - wsy then
				miny = y - wsy
			end
			if minz > z - wsz then
				minz = z - wsz
			end
			if maxx < x + wsx then
				maxx = x + wsx
			end
			if maxy < y + wsy then
				maxy = y + wsy
			end
			if maxz < z + wsz then
				maxz = z + wsz
			end
		end
	end
	local omin, omax = Ve3n(minx, miny, minz), Ve3n(maxx, maxy, maxz)
	local omiddle = (omax+omin)*.5
	local wCf = orientation - orientation.p + orientation:pointToWorldSpace(omiddle)
	local size = (omax-omin)
	return wCf, size
end

local function setsimulationradius(v: number)
	local v = tonumber(v) or 1000
	sethiddenproperty(User, "SimulationRadius", v) 
	sethiddenproperty(User, "MaximumSimulationRadius", v) 
	User.ReplicationFocus = workspace
end

local function UnequipEverything()
	if User and User.Character then
		local H = User.Character:FindFirstChildOfClass("Humanoid")
		if H then
			RunService.Stepped:Wait()
			H:UnequipTools()
		end
	end
end

game:GetService("Players").PlayerAdded:Connect(RefreshPlayers)
game:GetService("Players").PlayerRemoving:Connect(RefreshPlayers)
RefreshPlayers()

game:GetService("RunService").RenderStepped:connect(function()
	for _,N in pairs(PlayerList) do
		local Char = _.Character
		local Chams = N.CheapChams
		local Box = N.Box
		local TeamColor = _.TeamColor.Color:Lerp(Color3.new(1,1,1),.5) or Color3.new(1,1,1)
		local Pos,Size,IsFocused = CFN(),Ve3n(),true
		if Char then Pos,Size = GetBoundingBox(Char,false,Char:GetModelCFrame()) IsFocused = Char:IsAncestorOf(Camera.CameraSubject) end
		Size = Size*.5
		local standard = (((0.068*Resolution.Y)/(Camera.CFrame.p-Pos.p).Magnitude))--*FovDelta 
		Chams.Adornee = Char or nil
		Chams.FillColor = TeamColor
		Chams.FillTransparency = 1
		Chams.OutlineColor = Color3.new(1,1,1)
		Chams.OutlineTransparency = 0
		Chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		Chams.Enabled = not IsFocused
		Chams.Parent = SafeFolder

		local UR,V1 = WorldToViewport(Pos*(Ve3n(Size.X,Size.Y,0)))
		local UL,V2 = WorldToViewport(Pos*(Ve3n(-Size.X,Size.Y,0)))
		local DL,V3 = WorldToViewport(Pos*(Ve3n(-Size.X,-Size.Y,0)))
		local DR,V4 = WorldToViewport(Pos*(Ve3n(Size.X,-Size.Y,0)))

		Box.PointA = Ve2n(UR.X,UR.Y)
		Box.PointB = Ve2n(UL.X,UL.Y)
		Box.PointC = Ve2n(DL.X,DL.Y)
		Box.PointD = Ve2n(DR.X,DR.Y)

		Box.Filled = false
		Box.Transparency = 1
		Box.Thickness = standard
		Box.Color = TeamColor
		Box.ZIndex = lowvalue 
		
		Box.Visible = V1 and V2 and V3 and V4 and not IsFocused
	end
end)