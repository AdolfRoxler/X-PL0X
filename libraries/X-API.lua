--- Rewrite
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local User = Players.LocalPlayer
local GuiService = game:GetService("GuiService")
local UIS = game:GetService("UserInputService")
local CAS = game:GetService("ContextActionService")
local V3N = Vector3.new
local V2N = Vector2.new
local CFN = CFrame.new
local HSV = Color3.fromHSV
local RGB = Color3.fromRGB
local WTVP = Camera.WorldToViewportPoint
local NewInstance = Instance.new
local WorldToViewport = function(...) return WTVP(Camera, ...) end
local Mouse = User:GetMouse()
local Resolution = V2N(Mouse.ViewSizeX,Mouse.ViewSizeY)
local PlayerList = {}
local Random = Random.new(tick())
local time = os.clock
local Draw = Drawing.new
local SafeFolder = NewInstance("Folder",game.CoreGui); SafeFolder.Name = "GhettoSmosh"
local lowvalue = -(2^31-1)
local AvatarURL = "https://www.roblox.com/headshot-thumbnail/image?userId=ñ&width=512&height=512&format=png"
--syn.protect_gui(SafeFolder)

--- Config initialization
--local Config = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Config.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Config.lua')()
local Config = devmode and loadstring(game:HttpGet('https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Config.lua',true))() or loadstring(game:HttpGet('https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Config.lua',true))()
--- Libraries

local math = devmode and loadstring(game:HttpGet('https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/arbitrarymath.lua',true))() or loadstring(game:HttpGet('https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/arbitrarymath.lua',true))()
local wget = devmode and loadstring(game:HttpGet('https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Lget.lua',true))() or loadstring(game:HttpGet('https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Lget.lua',true))()
--local Phys = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/physicsMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/physicsMANIPULATOR.lua')()
local spoofer = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/metatableMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/metatableMANIPULATOR.lua')()

--- Crosshair objects
local WHITE = Color3.new(1,1,1)


local CR1 = Draw("Line")
local CR2 = Draw("Line")
local AIMSTATUS = Draw("Text")
local CrosshairLength = 0
local CrosshairThickness = 0
local inset = 36
local N = 0
CR1.Color = WHITE
CR2.Color = WHITE
---

local rDELTA = 1
local pDELTA = 1
local FovDelta = 1
local zindex = lowvalue+100
local NaN = math.huge-math.huge

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
--- Sppof stuff
local GameOwnerID = game.CreatorType==Enum.CreatorType.User and game.CreatorId or game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
local GameOwnerName = game:GetService("Players"):GetNameFromUserIdAsync(GameOwnerID) 


---

--- Character stuff

local SelfHum;
local SelfRoot;
local HumVector;
local InputVector = V3N()
local ZERO = V3N()
local BLACK = RGB()
local F,B,L,R,U = false,false,false,false,false
local BEGIN = Enum.UserInputState.Begin
local END = Enum.UserInputState.End

local FRONT = V3N(0,0,-1)
local BACK = V3N(0,0,1)

local LEFT = V3N(-1,0,0)
local RIGHT = V3N(1,0,0)

local UP = V3N(0,1,0)

---


--- make math faster cuh!
local clamp = math.clamp ---- math.clamp no worky real
local inf = math.huge
local abs = math.abs
local floor = math.floor
local bitrshift = bit.rshift or bit32.rshift
local bitlshift = bit.lshift or bit32.lshift

local split = string.split
local tostring = tostring
local tonumber = tonumber
local lshift = function(a,b,p) return not p and bitlshift(a,b) or a*(.5^-b) end
local rshift = function(a,b,p) return not p and bitrshift(a,b) or a*(.5^b) end



	--local lshift = bit and Config.render.esp.precise and bit.lshift or and function(a,b) return a*(2^b) end
	---

	local function RefreshSpoof()
		local DEEP = not Config.spoof.deep
		if Config.spoof.manual.enabled then
			spoofer:spoof(User,"Name",Config.spoof.manual.username,DEEP)
			spoofer:spoof(User,"DisplayName",Config.spoof.manual.displayname,DEEP)
			spoofer:spoof(User,"UserId",Config.spoof.manual.userid,DEEP)
		elseif Config.spoof.gameowner and GameOwnerID and GameOwnerName then
			spoofer:spoof(User,"UserId",GameOwnerID,DEEP)
			spoofer:spoof(User,"Name",GameOwnerName,DEEP)
		else
			spoofer:unspoof(User,"Name")
			spoofer:unspoof(User,"DisplayName")
			spoofer:unspoof(User,"UserId")
		end
	end

	local function MovementInput(action: string, state: Enum.UserInputState, object: InputObject)
		if action == "F" and not F and state == BEGIN then InputVector+=FRONT	F = true end
		if action == "B" and not B and state == BEGIN then InputVector+=BACK	B = true end
		if action == "L" and not L and state == BEGIN then InputVector+=LEFT	L = true end
		if action == "R" and not R and state == BEGIN then InputVector+=RIGHT	R = true end
		if action == "U" and not U and state == BEGIN then InputVector+=UP		U = true end

		if action == "F" and F and state == END then InputVector-=FRONT			F = false end
		if action == "B" and B and state == END then InputVector-=BACK			B = false end
		if action == "L" and L and state == END then InputVector-=LEFT			L = false end
		if action == "R" and R and state == END then InputVector-=RIGHT			R = false end
		if action == "U" and U and state == END then InputVector-=UP			U = false end
	end

	CAS:BindAction("F", MovementInput, false, Enum.PlayerActions.CharacterForward)
	CAS:BindAction("B", MovementInput, false, Enum.PlayerActions.CharacterBackward)
	CAS:BindAction("L", MovementInput, false, Enum.PlayerActions.CharacterLeft)
	CAS:BindAction("R", MovementInput, false, Enum.PlayerActions.CharacterRight)
	CAS:BindAction("U", MovementInput, false, Enum.PlayerActions.CharacterJump)

	UIS.InputChanged:connect(function(input, gameProcessed)
		if gameProcessed then
			InputVector = V3N()
			F,B,L,R,U = false,false,false,false,false
		end
	end)

	local function scaletotextbound(Text: string,Bounds,u)
		if Text.TextBounds.XB>Bounds.X or Text.TextBounds.Y>Bounds.Y then repeat Text.Size -= u until Text.TextBounds.X == Bounds.X and Text.TextBounds.Y == Bounds.Y 
		elseif Text.TextBounds.X<Bounds.X or Text.TextBounds.Y<Bounds.Y then repeat Text.Size += u until Text.TextBounds.X == Bounds.X and Text.TextBounds.Y == Bounds.Y end 
	end

	local function RefreshPlayers(Remove: Instance)
		--repeat game:GetService('RunService').Heartbeat:Wait() until REFRESHING == false
		if Remove and PlayerList[Remove] then
			REFRESHING = true
			if PlayerList[Remove].Tag then for _,N in pairs(PlayerList[Remove].Tag) do warn(_,N) N:Remove() end PlayerList[Remove].Tag = nil end
			PlayerList[Remove].CheapChams:Remove()
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
				PlayerList[N].CheapChams = PlayerList[N].CheapChams or NewInstance("Highlight")
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
				local wsx = rshift((abs(R00) * sx + abs(R01) * sy + abs(R02) * sz),1,Config.render.esp.precise)
				local wsy = rshift((abs(R10) * sx + abs(R11) * sy + abs(R12) * sz),1,Config.render.esp.precise)
				local wsz = rshift((abs(R20) * sx + abs(R21) * sy + abs(R22) * sz),1,Config.render.esp.precise)
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
		local omin, omax = V3N(minx, miny, minz), V3N(maxx, maxy, maxz)
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

	local function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end

	game:GetService("Players").PlayerAdded:Connect(function() RefreshPlayers() end)
	game:GetService("Players").PlayerRemoving:Connect(RefreshPlayers)
	RefreshPlayers()




	game:GetService("RunService").RenderStepped:connect(function(d)


		RefreshSpoof()







		rDELTA = d
		Camera = workspace.CurrentCamera -- fix for penis rcl game that deletes camera
		Resolution = V2N(Mouse.ViewSizeX,Mouse.ViewSizeY)
		FovDelta = (70/Camera.FieldOfView)









		CR1.Visible = Config.render.ui.crosshair.enabled
		CR2.Visible = Config.render.ui.crosshair.enabled

		if Config.render.ui.crosshair.enabled then
		CrosshairThickness = Resolution.Y*(Config.render.ui.crosshair.thickness/1000)
		CrosshairLength = Resolution.Y*(Config.render.ui.crosshair.length/1000)

		CR1.Thickness = CrosshairThickness
		CR2.Thickness = CrosshairThickness

		CR1.From = V2N(Mouse.X-CrosshairLength,Mouse.y+inset)
		CR1.To = V2N(Mouse.X+CrosshairLength,Mouse.y+inset)

		CR2.From = V2N(Mouse.X,Mouse.y+inset-CrosshairLength)
		CR2.To = V2N(Mouse.X,Mouse.y+inset+CrosshairLength)

		local H,S,V = RGB(Config.render.ui.crosshair.color.r,Config.render.ui.crosshair.color.g,Config.render.ui.crosshair.color.b):ToHSV()
		N = Config.render.ui.crosshair.rgb and N+d or 0
		local K = HSV(zigzag(N),not Config.render.ui.crosshair.rgb and S or 1,not Config.render.ui.crosshair.rgb and V or 1)

		CR1.Color = K
		CR2.Color = K end
		






		
		for _,N in pairs(PlayerList) do
			if REFRESHING then continue end
			local Char = _.Character
			local Chams = N.CheapChams
			local Box = N.Box
			local Tracer = N.Tracer
			local Healthbar = N.Healthbar
			local HeadE = N.Circle
			local TeamColor = _.TeamColor.Color:Lerp(WHITE,.5) or WHITE
			local HPV2,alive,Pos,Size,IsFocused,sx15,standardcheck,hcheck,Head,V1,V2,V3,V4 = false,true;

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


			if Char~=nil then Pos,Size = GetBoundingBox(Char,false,Config.render.esp.box.dynamic and Char:GetModelCFrame() or CFN(Char:GetModelCFrame().p)*Camera.CFrame.Rotation) IsFocused = Char:IsAncestorOf(Camera.CameraSubject)
			local UR,UL,DR,DL;
			
			
			sx15 = Size*.75
			Size = Size*.5
			local standard = (((0.018*Resolution.Y*(Size.X+Size.Y))/(Camera.CFrame.p-Pos.p).Magnitude))*FovDelta 
			standardcheck = IsFocused==false and Config.render.esp.enabled or false

			Chams.Adornee = Char
			Chams.FillColor = TeamColor
			Chams.FillTransparency = .43
			Chams.OutlineColor = WHITE
			Chams.OutlineTransparency = 0
			Chams.DepthMode = Config.render.esp.chams.throughWalls and 0 or 1
			Chams.Parent = SafeFolder

			UR,V1 = WorldToViewport(Pos*(V3N(Size.X,Size.Y,0)))
			UL,V2 = WorldToViewport(Pos*(V3N(-Size.X,Size.Y,0)))
			DL,V3 = WorldToViewport(Pos*(V3N(-Size.X,-Size.Y,0)))
			DR,V4 = WorldToViewport(Pos*(V3N(Size.X,-Size.Y,0)))

			Box.PointA = V2N(UR.X,UR.Y)
			Box.PointB = V2N(UL.X,UL.Y)
			Box.PointC = V2N(DL.X,DL.Y)
			Box.PointD = V2N(DR.X,DR.Y)
			Box.Filled = false
			Box.Transparency = 1
			Box.Thickness = standard
			Box.Color = TeamColor
			Box.ZIndex = zindex

			Head = Char:FindFirstChild("Head")
			local Hum = Char:FindFirstChildOfClass("Humanoid")
			local H1,H2 = DL,DR
			local health,c = 0,BLACK

			if Hum then
					health = (Hum.Health/Hum.MaxHealth)
					alive = not (health==0 or health<0)
			end
			if Config.render.esp.box.healthbar then
				local barh = -Size.Y+(Size.Y*health*2)
				--c = Color3.fromHSV(health*.35,0.9,1) health = 0
				c = HSV(health*.4,.9,.98)
				H1 = WorldToViewport(Pos*(V3N(-sx15.X,barh,0)))
				H2 = WorldToViewport(Pos*(V3N(-Size.X,barh,0)))
				Healthbar[2].Color = c

				local BUR,V19 = WorldToViewport(Pos*(V3N(-sx15.X,Size.y,0)))
				local BDR,V22 = WorldToViewport(Pos*(V3N(-sx15.X,-Size.Y,0)))

				Healthbar[1].PointA = V2N(BUR.X,BUR.Y)
				Healthbar[1].PointB = V2N(UL.X,UL.Y)
				Healthbar[1].PointC = V2N(DL.X,DL.Y)
				Healthbar[1].PointD = V2N(BDR.X,BDR.Y)

				Healthbar[2].PointA = V2N(H1.X,H1.Y)
				Healthbar[2].PointB = V2N(H2.X,H2.Y)
				Healthbar[2].PointC = V2N(DL.X,DL.Y)
				Healthbar[2].PointD = V2N(BDR.X,BDR.Y)

				Healthbar[3].PointA = V2N(BUR.X,BUR.Y)
				Healthbar[3].PointB = V2N(UL.X,UL.Y)
				Healthbar[3].PointC = V2N(DL.X,DL.Y)
				Healthbar[3].PointD = V2N(BDR.X,BDR.Y)


				Healthbar[1].Filled = false
				Healthbar[1].ZIndex = zindex
				Healthbar[1].Color = TeamColor
				Healthbar[1].Thickness = standard--Box.Thickness
				local h,s = c:ToHSV()
				Healthbar[3].Filled = true
				Healthbar[3].ZIndex = zindex-2
				Healthbar[3].Color = HSV(h,s,.2)
				Healthbar[3].Transparency = .75
				Healthbar[3].Thickness = standard--Box.Thickness

				Healthbar[2].Filled = true
				Healthbar[2].ZIndex = zindex-1
				Healthbar[2].Thickness = 0

				hcheck = V2 and V3 and V19 and V22 and standardcheck and Config.render.esp.box.healthbar

			end
			
			if Config.render.esp.tracers.enabled then
				local TT = WorldToViewport(Pos*V3N(0,-Size.Y,0))
				if TT.Z<0 then TT=math:InverseWorldToViewportPoint(Pos*V3N(0,-Size.Y,0)) end 


				--Tracer.Thickness = clamp(standard,0,(Resolution.Y*0.004))
				Tracer.Thickness = standard
				Tracer.Color = TeamColor
				Tracer.Transparency = 1-(Pos.p-Camera.CFrame.p).Magnitude*(1/Config.render.esp.tracers.maxdistance)
				Tracer.From = V2N(Resolution.X*.5,Resolution.Y*.985)
				Tracer.ZIndex = zindex
				Tracer.To = V2N(TT.X,TT.Y)  
			end

			local avghead,HPV
			if Head then

				HPV,HPV2 = WorldToViewport(Head.CFrame.p) 
				HeadE.Transparency = (Head.CFrame.p-Camera.CFrame.p).Magnitude-1
				HeadE.Position = V2N(HPV.X,HPV.Y)
				local m = (((Resolution.Y*0.12*(Head.Size.X+Head.Size.Y+Head.Size.Z))/HPV.Z))*FovDelta
				HeadE.Radius = m
				HeadE.Thickness = m*0.45
				HeadE.Color = TeamColor
				HeadE.ZIndex = lowvalue+1
			end
			end

			local isalive = ((alive and Config.render.esp.ignorecorpses) or not Config.render.esp.ignorecorpses) 

			Chams.Enabled = Config.render.esp.chams.enabled and isalive
			Box.Visible = V1 and V2 and V3 and V4 and standardcheck and Config.render.esp.box.enabled and isalive
			HeadE.Visible = HPV2 and Head and standardcheck and Config.render.esp.head and isalive
			Tracer.Visible = standardcheck and Config.render.esp.tracers.enabled and isalive
			Healthbar[1].Visible = hcheck and isalive
			Healthbar[2].Visible = hcheck and isalive
			Healthbar[3].Visible = hcheck and isalive
			-- May complete later
		--[[
		local NBOX,BV = WorldToViewport(Pos*V3N(0,Size.Y*2.5,0))
		local n = clamp(((Resolution.Y*2)/NBOX.Z)*FovDelta,55,inf)
		local nNn = BV and Config.render.esp.Nametag.Enabled
		NBOX = V3N(NBOX.X,NBOX.Y-n*.5,NBOX.Z)

		NametagBox.PointA = V2N(NBOX.X+n,NBOX.Y+n*.5)
		NametagBox.PointB = V2N(NBOX.X-n,NBOX.Y+n*.5)
		NametagBox.PointC = V2N(NBOX.X-n,NBOX.Y)
		NametagBox.PointD = V2N(NBOX.X+n,NBOX.Y)
		NametagBox.Filled = true
		NametagBox.Transparency = Config.render.esp.Nametag.Customization.Base.Opacity
		NametagBox.Visible = nNn
		NametagBox.Color = Config.render.esp.Nametag.Customization.Base.Color

		Avatar.Size = V2N(n*.5,n*.5)
		Avatar.Position = Vector2.new(NBOX.X-n*1.5,NBOX.Y)
		Avatar.Visible = nNn and Config.render.esp.Nametag.DisplayAvatar

		AvatarFrame.PointA = V2N(NBOX.X-n,NBOX.Y+n*.5)
		AvatarFrame.PointB = V2N(NBOX.X-n*1.5,NBOX.Y+n*.5)
		AvatarFrame.PointC = V2N(NBOX.X-n*1.5,NBOX.Y)
		AvatarFrame.PointD = V2N(NBOX.X-n,NBOX.Y)
		AvatarFrame.Visible = nNn and Config.render.esp.Nametag.DisplayAvatar
		AvatarFrame.Filled = true
		AvatarFrame.Transparency = Config.render.esp.Nametag.Customization.SecondaryRight.Opacity
		AvatarFrame.Color = Config.render.esp.Nametag.Customization.SecondaryRight.Color

		NameBar.From =  V2N(NBOX.X-n,NBOX.Y+n*.5-standard*.5)
		NameBar.To = V2N(NBOX.X-n+(n*2*health),NBOX.Y+n*.5-standard*.5)
		NameBar.Thickness = standard
		NameBar.Visible = nNn and Config.render.esp.Nametag.DisplayHealth
		NameBar.Transparency = 1
		NameBar.Color = c

		NameTag.Text = _.Name
		--*2/(string.len(NameTag.Text))
		--NameTag.Size = n
		-- scaletotextbound
		--coroutine.wrap(scaletotextbound(NameTag,Vector2.new(n*.5,n*.5),1))

		NameTag.Size = n*8/(clamp(string.len(NameTag.Text),7,inf)*2)
		--n/((string.len(NameTag.Text)*.5)/(#string.split(NameTag.Text,"\n")))
		NameTag.Position = V2N(NBOX.X,NBOX.Y-NameTag.TextBounds.Y+n*.5)
		NameTag.Visible = nNn and Config.render.esp.Nametag.DisplayName
		NameTag.Color = WHITE
		NameTag.Center = true

		DistanceFrame.PointA = V2N(NBOX.X-n,NBOX.Y+n*.5)
		DistanceFrame.PointB = V2N(NBOX.X-n*1.75,NBOX.Y+n*.5)
		DistanceFrame.PointC = V2N(NBOX.X-n*1.75,NBOX.Y)
		DistanceFrame.PointD = V2N(NBOX.X-n,NBOX.Y)
		DistanceFrame.Visible = nNn and Config.render.esp.Nametag.DisplayDistance
		DistanceFrame.Filled = true
		DistanceFrame.Transparency = Config.render.esp.Nametag.Customization.SecondaryLeft.Opacity
		DistanceFrame.Color = Config.render.esp.Nametag.Customization.SecondaryLeft.Color

		Distance.Text = tostring(floor(User:DistanceFromCharacter(Pos.p)*.28)).."m"
		Distance.Visible = nNn and Config.render.esp.Nametag.DisplayDistance
		Distance.Size = n*2.5/(clamp(string.len(Distance.Text),3,inf)*2)
		Distance.Position = V2N(NBOX.X-n*1.375,NBOX.Y-Distance.TextBounds.Y+n*.5)
		Distance.Color = WHITE
		Distance.Center = true

		]]

		end
	end)

	game:GetService("RunService").Stepped:connect(function(d)
		pDELTA = d
		if User.Character then
			SelfHum = User.Character:FindFirstChildOfClass("Humanoid")
			HumVector = SelfHum and SelfHum.MoveDirection or HumVector
			SelfRoot = User.Character:FindFirstChild("HumanoidRootPart") or User.Character.PrimaryPart
		end

		if not Config.movement.flight.enabled and SelfHum and (HumVector.X~=0 or HumVector.Z~=0) then
			if Config.movement.walkspeed.enabled then
					SelfRoot.AssemblyLinearVelocity = Config.movement.walkspeed.allowinertia and SelfRoot.AssemblyLinearVelocity+HumVector.Unit*Config.movement.walkspeed.speed or HumVector.Unit*Config.movement.walkspeed.speed+V3N(0,SelfRoot.AssemblyLinearVelocity.Y,0)
			end	
		elseif Config.movement.flight.enabled and SelfRoot then
			local InputVector = (InputVector.X~=0 or InputVector.Z~=0) and InputVector.Unit or ZERO
			SelfRoot.AssemblyLinearVelocity = (Camera.CFrame.Rotation*InputVector)*Config.movement.flight.speed
		end

	end)

	return Config
