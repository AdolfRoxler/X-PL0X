--- Preloaded default config
Config = {}
Config.ESP = false
Config.flight = false
Config.flightnograv = false
Config.nograv = false
Config.fspeed = 10
Config.spdsp=16
Config.spd=false
Config.superman=false
Config.CROSS=false
Config.CROSSC={1,1,1}
Config.CROSSS=15
Config.IMMORTALITY=false
Config.SWIM=false
Config.XRAYB=false
Config.HESPT = false
Config.NTAGST = false
Config.NTAGSV = 150
Config.NTAGV = 15
Config.firedelay = 1/5
Config.FOVSET = false
Config.CROSSTRAN = 100
Config.XRAYM = 0
Config.AFELOOP = false
Config.FIDGETSPINNER = false
Config.verticallock = false
Config.CLICKDELTOG=false
Config.CLICKTPTOG=false
Config.aimbotkbmode = "None"
Config.AIMBOT = false
Config.TRIGGERBOT = false
Config.MOUSESPOOF = false
Config.autowalk = false
Config.OKBPS = 64
Config.RLAG = 0
Config.FPDSD = false
Config.CLICKTP = false
Config.CLICKDEL = false
Config.fspinnernoclip = false
Config.COLOREDBOXES = false
Config.ARW = false
Config.HLT = false
Config.TRACERST = false
Config.FONT = Drawing.Fonts["UI"]
Config.XRAYBU = false
Config.SPEEDDRIFT = false
Config.antiantitp = false
Config.teamcheck = false
Config.wallcheck = false
Config.aimspeed = 10
Config.headaim = false
Config.shootrad = 10
Config.RANDOMTGT= false
Config.CurrentExploit = identifyexecutor() or nil
Config.FOV = Camera.FieldOfView
Config.LockTarget = false
Config.BOX = true
Config.Skeleton = false
Config.ForceSimR = false
Config.SimR = 1000
Config.VisualizeSimR = false
Config.VisualizeNet = false
Config.SPOOFRANK = false
Config.SPOOFASSETS = false
Config.NOLOADINGSCREEN = false
Config.NOPURCHASES = false

--- For some reason this make shit run faster, i dunno ima just copy icewolf. Update 2: lol nigga even lua docs say indexing lua var globally in local once makes shit run faster! lol!
local Camera = workspace.CurrentCamera;
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local Ve3n = Vector3.new;
local Ve2n = Vector2.new;
local CFN = CFrame.new;
local WTVP = Camera.WorldToViewportPoint;
local WorldToViewport = function(...) return WTVP(Camera, ...) end;
local Resolution = Ve2n(Mouse.ViewSizeX,Mouse.ViewSizeY)

---- Crosshair n sheeit

local CR1 = Drawing.new("Line")
local CR2 = Drawing.new("Line")
local AIMSTATUS = Drawing.new("Text")
local AIMSTATUS2 = Drawing.new("Text")
local PATHSTATUS = Drawing.new("Text")
local DELTA = 1

--- Debounce and raycast

local FIRING = false
local DeletedInstances = {}
local TPRaycastConfig = RaycastParams.new()
TPRaycastConfig.FilterType = Enum.RaycastFilterType.Blacklist
TPRaycastConfig.IgnoreWater = true

--- Debounces below
local MAPRESTORING = false
local teleportingtowardspoint = false

local function GetBoundingBox(model, recursive, orientation, mustcollide) ----- copypasted code xdflol
	if typeof(model) == "Instance" then
		model = recursive and model:GetDescendants() or model:GetChildren() --- had to modify some shit, last two variables are implemented by me
	end
	local orientation = orientation~=nil and orientation or CFN()
	local minx, miny, minz = math.huge,math.huge,math.huge
	local maxx, maxy, maxz = -math.huge,-math.huge,-math.huge
	for _, obj in pairs(model) do
		if obj:IsA("BasePart") then
			if (mustcollide==true and obj.CanCollide==false) then continue end
			cf = orientation:toObjectSpace(obj.CFrame)
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

local function changestatus(h) --- I guess this is how I'll set up humanoid status changes from now on
	if Config.IMMORTALITY==true and h then h:SetStateEnabled(15,false) end --my dumb ass thought this was somewhere else
	if Config.SWIM==true and h then h:ChangeState(4) end
	if Config.flight==true and h then h:ChangeState(5) end
	if Config.FIDGETSPINNER==true and h then h:ChangeState(8) end
end

local function XRAY(int)
	local int = tonumber(int) or 0
	local function search(obj)
		if obj:IsA("BasePart") then obj.LocalTransparencyModifier = math.abs(int) end
		if obj:FindFirstChildOfClass("Humanoid") then return end
		for _,l in pairs (obj:GetChildren()) do
			search(l)
		end
	end
	search(workspace)
end

local function charinstanceaddedfunc(l,h)
	if (Config.AFELOOP or Config.FIDGETSPINNER) and l and l:IsA("Tool") and h then
		RunService.Stepped:Wait()
		UserHum:UnequipTools()
	end
end

local function setsimulationradius(v)
	local v = tonumber(v) or 1000
	sethiddenproperty(User, "SimulationRadius", v) 
	sethiddenproperty(User, "MaximumSimulationRadius", v) 
	User.ReplicationFocus = workspace
end

function findpath(From,To,Path,overwritemaintable)
	local from = From
	local to = To
	local path = Path
	if from and to and path then else return nil end
	if typeof(from) == "CFrame" then from = from.p end
	if typeof(to) == "CFrame" then to = to.p end
	local success,eror = pcall(function()
		path:ComputeAsync(from,to) end)
	if not success then return nil end
	if overwritemaintable then PathState = path.Status Waypoints = path:GetWaypoints() else return path.Status,path:GetWaypoints() end--return nil,tostring(errorMessage) 
end

local function mousefunctions()
	if Config.CLICKTP==true and Mouse and (FIRING==false or Config.MOUSESPOOF==true) then
		if teleportingtowardspoint then return end
		if UserChar then
			teleportingtowardspoint = true
			local n,s = GetBoundingBox(UserChar,false)
			TPRaycastConfig.FilterDescendantsInstances={Camera,UserChar}
			local raycast = workspace:Raycast(Camera.CFrame.p,Mouse.UnitRay.Direction*5000,TPRaycastConfig)
			if raycast and raycast.Instance and raycast.Position then else UserChar:PivotTo(CFN(Mouse.Hit.p)*UserChar:GetModelCFrame().Rotation) teleportingtowardspoint = false return end
			if UserHum then UserHum.Sit = false end
			RunService.Heartbeat:Wait()
			if hr and raycast.Instance and raycast.Instance:IsA("BasePart") then hr.AssemblyLinearVelocity = raycast.Instance.AssemblyLinearVelocity end
		end
		teleportingtowardspoint = false
	end
	if Config.CLICKDEL==true and Mouse and (FIRING==false or Config.MOUSESPOOF==true) then
        local l = Mouse.Target:FindFirstAncestorWhichIsA("Model")
		if Mouse.Target then if l and l:FindFirstChildOfClass("Humanoid") or Mouse.Target:FindFirstAncestorWhichIsA("Camera") or table.find(DeletedInstances,Mouse.Target) then else
				DeletedInstances[Mouse.Target]={Mouse.Target,Mouse.Target.Size}
				Mouse.Target.Size = Ve3n(0,0,0)
			end
		end
	end
end

local function drawvisuals(Delta)
	    Resolution = Ve2n(Mouse.ViewSizeX,Mouse.ViewSizeY)
        DELTA = Delta
        if Camera and Config.FOVSET==true then Camera.FieldOfView = Config.FOV end

		CR1.Visible = Config.CROSS
		CR2.Visible = Config.CROSS
		local maths = (Resolution.Y*(math.abs(Config.CROSSS)/1000))
		CR1.From = Vector2.new(Mouse.X-maths,Mouse.Y+inset)
		CR1.To = Vector2.new(Mouse.X+maths,Mouse.Y+inset)
		CR1.Thickness = (Resolution.Y*.0025)
		CR2.From = Vector2.new(Mouse.X,Mouse.Y+inset+maths)
		CR2.To = Vector2.new(Mouse.X,Mouse.Y+inset-maths)
		CR2.Thickness = (Resolution.Y*.0025)
		CR1.Color = Config.CROSSC and Config.CROSSC[1] and Config.CROSSC[2] and Config.CROSSC[3] and Color3.new(Config.CROSSC[1],Config.CROSSC[2],Config.CROSSC[3]) or Color3.new(1,1,1)
		CR2.Color = Config.CROSSC and Config.CROSSC[1] and Config.CROSSC[2] and Config.CROSSC[3] and Color3.new(Config.CROSSC[1],Config.CROSSC[2],Config.CROSSC[3]) or Color3.new(1,1,1)
		CR1.ZIndex = highvalue
		CR2.ZIndex = highvalue
		if Config.CROSSTRAN then CR1.Transparency = Config.CROSSTRAN/100 else CR1.Transparency = 1 end
		CR2.Transparency = CR1.Transparency

		AIMSTATUS.Visible= Config.AIMBOT and GuiService.MenuIsOpen
		AIMSTATUS.Font = Config.FONT
		AIMSTATUS.Color = Config.CROSS and CR1.Color:Lerp(Color3.new(1,1,1),.5) or Color3.new(1,1,1)
		AIMSTATUS.OutlineColor = Color3.new(0,0,0)
		AIMSTATUS.Transparency = Config.CROSS==true and Config.CROSSTRAN and Config.CROSSTRAN/100 or 0
		AIMSTATUS.Size = Resolution.Y*0.03
		AIMSTATUS.Center = true
		AIMSTATUS.Position = Vector2.new(Mouse.X+AIMSTATUS.TextBounds.X/1.5,Mouse.Y+inset-AIMSTATUS.TextBounds.Y)

		AIMSTATUS2.Visible= AIMSTATUS.Visible
		AIMSTATUS2.Font = AIMSTATUS.Font
		AIMSTATUS2.Color = AIMSTATUS.Color
		AIMSTATUS2.OutlineColor = AIMSTATUS.OutlineColor
		AIMSTATUS2.Transparency = AIMSTATUS.Transparency
		AIMSTATUS2.Size = AIMSTATUS.Size
		AIMSTATUS2.Center = true
		AIMSTATUS2.Position = Vector2.new(AIMSTATUS.Position.X+AIMSTATUS.TextBounds.X*.5+AIMSTATUS2.TextBounds.X*.5,AIMSTATUS.Position.Y)
end

game:GetService("RunService").RenderStepped:connect(drawvisuals)