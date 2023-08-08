--- Rewrite
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
--local SafeFolder = Instance.new("Folder",game.CoreGui) SafeFolder.Name = "GhettoSmosh"
local lowvalue = -(2^31-1)
local AvatarURL = "https://www.roblox.com/headshot-thumbnail/image?userId=ñ&width=512&height=512&format=png"
--syn.protect_gui(SafeFolder)

--- Config initialization
--local Config = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Config.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Config.lua')()
local Config = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Config.lua',true)() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Config.lua',true)()
--- Libraries

local math = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/arbitrarymath.lua',true)() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/arbitrarymath.lua',true)()
local wget = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Lget.lua',true)() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Lget.lua',true)()
--local Phys = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/physicsMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/physicsMANIPULATOR.lua')()
--local spoofer = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/metatableMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/metatableMANIPULATOR.lua')()

--- Crosshair objects

local CR1 = Draw("Line")
local CR2 = Draw("Line")
local AIMSTATUS = Draw("Text")

---

local DELTA = 1
local FovDelta = 1
local WHITE = Color3.new(1,1,1)
local zindex = lowvalue+100

--- Debounces

local FIRING = false
local DeletedInstances = {}
local RaycastConfig = RaycastParams.new()
RaycastConfig.FilterType = Enum.RaycastFilterType.Blacklist
RaycastConfig.IgnoreWater = true

local MAPRESTORING = false
local Teleporting = false

local REFRESHING = false
---
--- make math faster cuh!
local clamp = math.clamp
local inf = math.huge
local abs = math.abs
local floor = math.floor

local split = string.split
local tostring = tostring
local tonumber = tonumber
local lshift = function(a,b,p) return p and bit.lshift(a,b) or a*(.5^-b) end
local rshift = function(a,b,p) return p and rshift(a,b) or a*(.5^b) end
	--local lshift = bit and Config.esp.precise and bit.lshift or and function(a,b) return a*(2^b) end
	---

	local function scaletotextbound(Text,Bounds,u)
		if Text.TextBounds.XB>Bounds.X or Text.TextBounds.Y>Bounds.Y then repeat Text.Size -= u until Text.TextBounds.X == Bounds.X and Text.TextBounds.Y == Bounds.Y 
		elseif Text.TextBounds.X<Bounds.X or Text.TextBounds.Y<Bounds.Y then repeat Text.Size += u until Text.TextBounds.X == Bounds.X and Text.TextBounds.Y == Bounds.Y end 
	end

	local function RefreshPlayers(Remove: Instance)
		--repeat game:GetService('RunService').Heartbeat:Wait() until REFRESHING == false
		if Remove and PlayerList[Remove] then
			REFRESHING = true
			if PlayerList[Remove].Tag then for _,N in pairs(PlayerList[Remove].Tag) do warn(_,N) N:Remove() end PlayerList[Remove].Tag = nil end
			PlayerList[Remove].Healthbar[1]:Remove()
			PlayerList[Remove].Healthbar[2]:Remove()
			PlayerList[Remove].Healthbar[3]:Remove()
			PlayerList[Remove].Healthbar = nil
			PlayerList[Remove].Skeleton = nil
			for _,N in pairs(PlayerList[Remove]) do if N~=nil then N:Remove() end end 
			PlayerList[Remove] = nil
			REFRESHING = false
		end
		for _,N in pairs(Players:GetPlayers()) do 
			if N.Parent~=nil and N~=User then 
				PlayerList[N] = PlayerList[N] or {}
				--PlayerList[N].CheapChams = PlayerList[N].CheapChams or Instance.new("Highlight")
				PlayerList[N].Box = PlayerList[N].Box or Draw("Quad")
				PlayerList[N].Skeleton = PlayerList[N].Skeleton or {}
				PlayerList[N].Circle = PlayerList[N].Circle or Draw("Circle")
				PlayerList[N].Healthbar = PlayerList[N].Healthbar or {Draw("Quad"),Draw("Quad"),Draw("Quad")}
				PlayerList[N].Tracer = PlayerList[N].Tracer or Draw("Line")

			--[[
			PlayerList[N].Tag = PlayerList[N].Tag or {}
			PlayerList[N].Tag.Background = PlayerList[N].Tag.Background or Draw("Quad")
			PlayerList[N].Tag.Nametag = PlayerList[N].Tag.Nametag or Draw("Text")
			PlayerList[N].Tag.Avatar = PlayerList[N].Tag.Avatar or Draw("Image")
			PlayerList[N].Tag.AvatarFrame = PlayerList[N].Tag.AvatarFrame or Draw("Quad")
			PlayerList[N].Tag.Healthbar = PlayerList[N].Tag.Healthbar or Draw("Line")
			PlayerList[N].Tag.DistanceFrame = PlayerList[N].Tag.DistanceFrame or Draw("Quad")
			PlayerList[N].Tag.Distance = PlayerList[N].Tag.Distance or Draw("Text")

			spawn(function() local avatar = syn.request({Url=AvatarURL:gsub("ñ",tostring(N.UserId)),Method='GET'}) PlayerList[N].Tag.Avatar.Data = avatar.Success and avatar.Body or "" end)
			]] -- Unneeded for now


				--syn.request({Url=URL,Method='GET'});


				--wget:LoadFile(N.Name.."png") or wget:Download(AvatarURL:gsub("ñ",tostring(N.UserId)),true,N.Name,"png")
			end 

		end
		--for _,N in pairs(PlayerList) do warn(_,N) end
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
		local minx, miny, minz = inf,inf,inf
		local maxx, maxy, maxz = -inf,-inf,-inf
		for _, obj in pairs(model) do
			if obj:IsA("BasePart") then
				if (mustcollide==true and obj.CanCollide==false) then continue end
				local cf = orientation:toObjectSpace(obj.CFrame)
				local sx, sy, sz = obj.Size.X, obj.Size.Y, obj.Size.Z
				local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cf:components()
				local wsx = rshift((abs(R00) * sx + abs(R01) * sy + abs(R02) * sz),1,Config.esp.precise)
				local wsy = rshift((abs(R10) * sx + abs(R11) * sy + abs(R12) * sz),1,Config.esp.precise)
				local wsz = rshift((abs(R20) * sx + abs(R21) * sy + abs(R22) * sz),1,Config.esp.precise)
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

	game:GetService("Players").PlayerAdded:Connect(function() RefreshPlayers() end)
	game:GetService("Players").PlayerRemoving:Connect(RefreshPlayers)
	RefreshPlayers()

	game:GetService("RunService").RenderStepped:connect(function()
		Camera = workspace.CurrentCamera -- fix for penis rcl game that deletes camera
		Resolution = Ve2n(Mouse.ViewSizeX,Mouse.ViewSizeY)
		FovDelta = (70/Camera.FieldOfView)
		for _,N in pairs(PlayerList) do
			if REFRESHING then continue end
			local Char = _.Character
			--local Chams = N.CheapChams
			local Box = N.Box
			local Tracer = N.Tracer
			local Healthbar = N.Healthbar
			local HeadE = N.Circle
			local TeamColor = _.TeamColor.Color:Lerp(WHITE,.5) or WHITE
			local Pos,Size,IsFocused,sx15,standardcheck,hcheck,Head,HPV2,V1,V2,V3,V4;

		--[[ -- Not needed
		local NametagBox = N.Tag.Background
		local Avatar = N.Tag.Avatar
		local AvatarFrame = N.Tag.AvatarFrame
		local NameBar = N.Tag.Healthbar
		local NameTag = N.Tag.Nametag 
		local Distance = N.Tag.Distance
		local DistanceFrame = N.Tag.DistanceFrame
		NameTag.Font = 1
		Distance.Font = 1
		]]


			if Char~=nil then Pos,Size = GetBoundingBox(Char,false,Config.esp.box.dynamic and Char:GetModelCFrame() or CFN(Char:GetModelCFrame().p)*Camera.CFrame.Rotation) IsFocused = Char:IsAncestorOf(Camera.CameraSubject)
			local UR,UL,DR,DL;
			
			
			sx15 = Size*.75
			Size = Size*.5
			local standard = (((0.07*Resolution.Y)/(Camera.CFrame.p-Pos.p).Magnitude))*FovDelta 
			standardcheck = IsFocused==false and Config.esp.enabled or false

			--[[Chams.Adornee = Char or nil
			Chams.FillColor = TeamColor
			Chams.FillTransparency = .43
			Chams.OutlineColor = WHITE
			Chams.OutlineTransparency = 0
			Chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			Chams.Enabled = false --standardcheck
			Chams.Parent = SafeFolder]]

			UR,V1 = WorldToViewport(Pos*(Ve3n(Size.X,Size.Y,0)))
			UL,V2 = WorldToViewport(Pos*(Ve3n(-Size.X,Size.Y,0)))
			DL,V3 = WorldToViewport(Pos*(Ve3n(-Size.X,-Size.Y,0)))
			DR,V4 = WorldToViewport(Pos*(Ve3n(Size.X,-Size.Y,0)))

			Box.PointA = Ve2n(UR.X,UR.Y)
			Box.PointB = Ve2n(UL.X,UL.Y)
			Box.PointC = Ve2n(DL.X,DL.Y)
			Box.PointD = Ve2n(DR.X,DR.Y)
			Box.Filled = false
			Box.Transparency = 1
			Box.Thickness = standard
			Box.Color = TeamColor
			Box.ZIndex = zindex

			local BUR,V19 = WorldToViewport(Pos*(Ve3n(-sx15.X,Size.y,0)))
			local BDR,V22 = WorldToViewport(Pos*(Ve3n(-sx15.X,-Size.Y,0)))

			local Hum = Char:FindFirstChildOfClass("Humanoid")
			local Head = Char:FindFirstChild("Head")
			local H1,H2 = DL,DR
			local barh,c,health;

			if Hum then
				health = (Hum.Health/Hum.MaxHealth)
				barh = -Size.Y+(Size.Y*health*2)
				--c = Color3.fromHSV(health*.35,0.9,1) health = 0
				c = Color3.fromHSV(health*.4,.9,.98)
				H1 = WorldToViewport(Pos*(Ve3n(-sx15.X,barh,0)))
				H2 = WorldToViewport(Pos*(Ve3n(-Size.X,barh,0)))
				Healthbar[2].Color = c
			end

			Healthbar[1].PointA = Ve2n(BUR.X,BUR.Y)
			Healthbar[1].PointB = Ve2n(UL.X,UL.Y)
			Healthbar[1].PointC = Ve2n(DL.X,DL.Y)
			Healthbar[1].PointD = Ve2n(BDR.X,BDR.Y)

			Healthbar[2].PointA = Ve2n(H1.X,H1.Y)
			Healthbar[2].PointB = Ve2n(H2.X,H2.Y)
			Healthbar[2].PointC = Ve2n(DL.X,DL.Y)
			Healthbar[2].PointD = Ve2n(BDR.X,BDR.Y)

			Healthbar[3].PointA = Ve2n(BUR.X,BUR.Y)
			Healthbar[3].PointB = Ve2n(UL.X,UL.Y)
			Healthbar[3].PointC = Ve2n(DL.X,DL.Y)
			Healthbar[3].PointD = Ve2n(BDR.X,BDR.Y)


			Healthbar[1].Filled = false
			Healthbar[1].ZIndex = zindex
			Healthbar[1].Color = TeamColor
			Healthbar[1].Thickness = standard--Box.Thickness
			local h,s,v = Healthbar[2].Color:ToHSV()
			Healthbar[3].Filled = true
			Healthbar[3].ZIndex = zindex-2
			Healthbar[3].Color = Color3.fromHSV(h,s,.2)
			Healthbar[3].Transparency = .75
			Healthbar[3].Thickness = standard--Box.Thickness

			Healthbar[2].Filled = true
			Healthbar[2].ZIndex = zindex-1
			Healthbar[2].Thickness = 0

			hcheck = V2 and V3 and V19 and V22 and standardcheck and Config.esp.box.healthbar


			if Config.esp.tracers.enabled then
				local TT = WorldToViewport(Pos*Ve3n(0,-Size.Y,0))
				if TT.Z<0 then TT=math:InverseWorldToViewportPoint(Pos*Ve3n(0,-Size.Y,0)) end 


				--Tracer.Thickness = clamp(standard,0,(Resolution.Y*0.004))
				Tracer.Thickness = standard
				Tracer.Color = TeamColor
				Tracer.Transparency = 1-(Pos.p-Camera.CFrame.p).Magnitude*(1/Config.esp.tracers.maxdistance)
				Tracer.From = Ve2n(Resolution.X*.5,Resolution.Y*.985)
				Tracer.ZIndex = zindex
				Tracer.To = Ve2n(TT.X,TT.Y)  
			end

			local avghead,HPV
			if Head then
				avghead = (Head.Size.X+Head.Size.Y+Head.Size.Z)/3
				HPV,HPV2 = WorldToViewport(Head.CFrame.p) 
				HeadE.Transparency = (Head.CFrame.p-Camera.CFrame.p).Magnitude-1
				HeadE.Position = Ve2n(HPV.X,HPV.Y)
				local m = (((Resolution.Y*0.4*avghead)/HPV.Z))*FovDelta
				HeadE.Radius = m
				HeadE.Thickness = m*0.45
				HeadE.Color = TeamColor
				HeadE.ZIndex = lowvalue+1
			end
			end



			Box.Visible = V1 and V2 and V3 and V4 and standardcheck and Config.esp.box.enabled
			HeadE.Visible = HPV2 and Head and standardcheck and Config.esp.head
			Tracer.Visible = standardcheck and Config.esp.tracers.enabled
			print(Tracer.Visible)
			Healthbar[1].Visible = hcheck
			Healthbar[2].Visible = hcheck
			Healthbar[3].Visible = hcheck
			-- May complete later
		--[[
		local NBOX,BV = WorldToViewport(Pos*Ve3n(0,Size.Y*2.5,0))
		local n = clamp(((Resolution.Y*2)/NBOX.Z)*FovDelta,55,inf)
		local nNn = BV and Config.ESP.Nametag.Enabled
		NBOX = Ve3n(NBOX.X,NBOX.Y-n*.5,NBOX.Z)

		NametagBox.PointA = Ve2n(NBOX.X+n,NBOX.Y+n*.5)
		NametagBox.PointB = Ve2n(NBOX.X-n,NBOX.Y+n*.5)
		NametagBox.PointC = Ve2n(NBOX.X-n,NBOX.Y)
		NametagBox.PointD = Ve2n(NBOX.X+n,NBOX.Y)
		NametagBox.Filled = true
		NametagBox.Transparency = Config.ESP.Nametag.Customization.Base.Opacity
		NametagBox.Visible = nNn
		NametagBox.Color = Config.ESP.Nametag.Customization.Base.Color

		Avatar.Size = Ve2n(n*.5,n*.5)
		Avatar.Position = Vector2.new(NBOX.X-n*1.5,NBOX.Y)
		Avatar.Visible = nNn and Config.ESP.Nametag.DisplayAvatar

		AvatarFrame.PointA = Ve2n(NBOX.X-n,NBOX.Y+n*.5)
		AvatarFrame.PointB = Ve2n(NBOX.X-n*1.5,NBOX.Y+n*.5)
		AvatarFrame.PointC = Ve2n(NBOX.X-n*1.5,NBOX.Y)
		AvatarFrame.PointD = Ve2n(NBOX.X-n,NBOX.Y)
		AvatarFrame.Visible = nNn and Config.ESP.Nametag.DisplayAvatar
		AvatarFrame.Filled = true
		AvatarFrame.Transparency = Config.ESP.Nametag.Customization.SecondaryRight.Opacity
		AvatarFrame.Color = Config.ESP.Nametag.Customization.SecondaryRight.Color

		NameBar.From =  Ve2n(NBOX.X-n,NBOX.Y+n*.5-standard*.5)
		NameBar.To = Ve2n(NBOX.X-n+(n*2*health),NBOX.Y+n*.5-standard*.5)
		NameBar.Thickness = standard
		NameBar.Visible = nNn and Config.ESP.Nametag.DisplayHealth
		NameBar.Transparency = 1
		NameBar.Color = c

		NameTag.Text = _.Name
		--*2/(string.len(NameTag.Text))
		--NameTag.Size = n
		-- scaletotextbound
		--coroutine.wrap(scaletotextbound(NameTag,Vector2.new(n*.5,n*.5),1))

		NameTag.Size = n*8/(clamp(string.len(NameTag.Text),7,inf)*2)
		--n/((string.len(NameTag.Text)*.5)/(#string.split(NameTag.Text,"\n")))
		NameTag.Position = Ve2n(NBOX.X,NBOX.Y-NameTag.TextBounds.Y+n*.5)
		NameTag.Visible = nNn and Config.ESP.Nametag.DisplayName
		NameTag.Color = WHITE
		NameTag.Center = true

		DistanceFrame.PointA = Ve2n(NBOX.X-n,NBOX.Y+n*.5)
		DistanceFrame.PointB = Ve2n(NBOX.X-n*1.75,NBOX.Y+n*.5)
		DistanceFrame.PointC = Ve2n(NBOX.X-n*1.75,NBOX.Y)
		DistanceFrame.PointD = Ve2n(NBOX.X-n,NBOX.Y)
		DistanceFrame.Visible = nNn and Config.ESP.Nametag.DisplayDistance
		DistanceFrame.Filled = true
		DistanceFrame.Transparency = Config.ESP.Nametag.Customization.SecondaryLeft.Opacity
		DistanceFrame.Color = Config.ESP.Nametag.Customization.SecondaryLeft.Color

		Distance.Text = tostring(floor(User:DistanceFromCharacter(Pos.p)*.28)).."m"
		Distance.Visible = nNn and Config.ESP.Nametag.DisplayDistance
		Distance.Size = n*2.5/(clamp(string.len(Distance.Text),3,inf)*2)
		Distance.Position = Ve2n(NBOX.X-n*1.375,NBOX.Y-Distance.TextBounds.Y+n*.5)
		Distance.Color = WHITE
		Distance.Center = true

		]]

		end
	end)

	return Config
