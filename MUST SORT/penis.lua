--GUI = loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/drawinglib.lua')()
local devmode = type(devmode)=="boolean" and devmode or true
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport  --- thanks iy
local scrn = false

local wget = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Lget.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Lget.lua')()
local Phys = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/physicsMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/physicsMANIPULATOR.lua')()
local Gaylib = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/Kavo.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/Kavo.lua')()
local math = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/arbitrarymath.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/arbitrarymath.lua')()
local spoofer = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/metatableMANIPULATOR.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/metatableMANIPULATOR.lua')()
local Config = devmode and loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/libraries/X-API.lua')() or loadstring(game:HttpGet'https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/libraries/X-API.lua')()

assert(Drawing,"No drawing api?")
if getgenv().XPL0X and not devmode then return end
if getgenv().XPL0XDISABLELOADINGSCREEN then game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen() game:GetService("CoreGui").TeleportGui.Enabled = false scrn = getgenv().XPL0XDISABLELOADINGSCREEN end
getgenv().XPL0X = true
local WAITBACKGROUND = Drawing.new("Quad")
local WAITMSG = Drawing.new("Text")
local ASSETCOUNT = Drawing.new("Text")


local InGUI = false
--- warn(UserSettings():GetService("UserGameSettings").MouseSensitivity) this'll come in handy later.

if game:IsLoaded() then else  ---- In case game didn't load leave out a nice ass message like this
	repeat 
		RunService.RenderStepped:Wait() 
		WAITMSG.Center = true 
		WAITMSG.Visible = not scrn
		WAITMSG.Position = Ve2n(Camera.ViewportSize.X*.5,Camera.ViewportSize.Y/3)
		WAITMSG.Size = (Camera.ViewportSize.Y/Camera.ViewportSize.X)*.1
		WAITMSG.Text = "Yo nigga the game hasn't loaded yet"
		WAITMSG.Color = Color3.new(1,1,1)
		WAITMSG.OutlineColor = Color3.new(0,0,0)
		WAITMSG.Outline = true
		WAITMSG.Font = 0
		WAITMSG.ZIndex = 1
		WAITBACKGROUND.Visible = not scrn
		WAITBACKGROUND.PointA = Ve2n(Camera.ViewportSize.X,0)
		WAITBACKGROUND.PointB = Ve2n(0,0)
		WAITBACKGROUND.PointC = Ve2n(0,Camera.ViewportSize.Y)
		WAITBACKGROUND.PointD = Ve2n(Camera.ViewportSize.X,Camera.ViewportSize.Y)
		WAITBACKGROUND.Color = Color3.new(1,1,1)
		WAITBACKGROUND.Transparency = 1
		WAITBACKGROUND.Filled = true
		WAITBACKGROUND.ZIndex = 0
		ASSETCOUNT.Size = WAITMSG.Size*0.8
		ASSETCOUNT.Position = Ve2n(WAITMSG.Position.X,WAITMSG.Position.Y+WAITMSG.TextBounds.Y)
		ASSETCOUNT.Text = "Loaded assets: "..game:GetService("ContentProvider").RequestQueueSize--"Brought to you by hicksville (real)"
		ASSETCOUNT.OutlineColor = Color3.new(0,0,0)
		ASSETCOUNT.Color = Color3.new(1,1,1)
		ASSETCOUNT.Center = true
		ASSETCOUNT.Visible = not scrn
		ASSETCOUNT.Outline = true
		ASSETCOUNT.Font = 0
		ASSETCOUNT.ZIndex = 1
	until game.Loaded
end

repeat wait() until game:GetService("Players").LocalPlayer

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
	if State == Enum.TeleportState.Started then
		if queueteleport then
			if devmode then
				queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/dev/frontend.lua', true))()")
			else 
				queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/AdolfRoxler/X-PL0X/main/frontend.lua', true))()")
			end
		end
	end
end)

local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local testthumb = Players:GetUserThumbnailAsync(game:GetService'Players'.LocalPlayer.UserId,0,6)


local Notifications = {}
Notifications.Overwrite = {Title="Configuration overwritten",Text="Settings have been saved",Icon=testthumb,Duration=4}
Notifications.Read = {Title="Configuration read",Text="Settings have been loaded",Icon=testthumb,Duration=4}
Notifications.LOverwrite = {Title="Saved config for:",Text=GameName,Icon=testthumb,Duration=4}
Notifications.LRead = {Title="Loaded config for:",Text=GameName,Icon=testthumb,Duration=4}

local UserChar,UserHum,hr=nil
local SUPERMANN=nil
local Rig=nil
local inset = 36
local SUPERMAN = Instance.new("Animation")

WAITBACKGROUND:Remove()
WAITMSG:Remove()
ASSETCOUNT:Remove()
User = Players.LocalPlayer
repeat wait() until User:GetMouse()
Mouse = User:GetMouse()

SUPERMAN.AnimationId="http://www.roblox.com/asset/?id=616115533"  ---superman animation???? god muddafuggin dam!!!!
SUPERMANR6 = Instance.new("Animation")
SUPERMANR6.AnimationId = "rbxassetid://429681631"  ---superman animation for r6???? god muddafuggin dam!!!!

local AllocatedPath = game:GetService("PathfindingService"):CreatePath({AgentRadius=0,AgentHeight=0,AgentCanJump = true}) --- The 'weird first two parameters' are necessary in this case.
local Waypoints = {}
local PathState = nil


if UserChar and UserHum and hr and UserHead then else
	if humanoidstatuschanger then humanoidstatuschanger:Disconnect() end
	if CharInstanceAddedFunc then CharInstanceAddedFunc:Disconnect() end
	if tpfixer then tpfixer:Disconnect() end
	spawn(function()
		repeat wait() until User.Character
		UserChar = User.Character
		if UserChar:FindFirstChild("Head") and UserChar:FindFirstChild("Head"):IsA("BasePart") then UserHead = UserChar:FindFirstChild("Head") end
		CharInstanceAddedFunc = UserChar.ChildAdded:connect(function(s) charinstanceaddedfunc(s,UserHum) end)
		if UserChar:FindFirstChildOfClass("Humanoid") then UserHum=UserChar:FindFirstChildOfClass("Humanoid") hr = UserHum.RootPart Rig = UserHum.RigType humanoidstatuschanger = UserHum.StateChanged:connect(function() changestatus(UserHum) end) tpfixer = UserHum.Changed:connect(function(b) if b=="Sitting" and teleportingtowardspoint then UserHum.Sitting = false end end) end
		spawn(function() while UserHum==nil do wait() end
			if UserHum and UserHum.RigType == Enum.HumanoidRigType.R15 then
				SUPERMANN = UserHum:LoadAnimation(SUPERMAN) SUPERMANN.Priority = Enum.AnimationPriority.Action SUPERMANN.TimePosition = 1 SUPERMANN.Looped = true
			elseif UserHum then
				SUPERMANN = UserHum:LoadAnimation(SUPERMANR6) SUPERMANN.Priority = Enum.AnimationPriority.Action SUPERMANN.TimePosition = .09 SUPERMANN.Looped = true
			end
			changestatus(UserHum)
		end)
	end)
end

User.SimulationRadiusChanged:Connect(function()
	if Config.ForceSimR==true then
		setsimulationradius(Config.SimR)
		User.ReplicationFocus = workspace
	end
end)

User.CharacterAdded:connect(function(nig)
	if humanoidstatuschanger then humanoidstatuschanger:Disconnect() end
	if CharInstanceAddedFunc then CharInstanceAddedFunc:Disconnect() end
	if tpfixer then tpfixer:Disconnect() end
	UserChar = nig
	CharInstanceAddedFunc = UserChar.ChildAdded:connect(function(s) charinstanceaddedfunc(s,UserHum) end)
	SUPERMANN = nil
	UserHum=UserChar:FindFirstChildOfClass("Humanoid")
	if UserChar:FindFirstChild("Head") and UserChar:FindFirstChild("Head"):IsA("BasePart") then UserHead = UserChar:FindFirstChild("Head") end
	spawn(function()
		repeat wait() until User.Character and User.Character:FindFirstChildOfClass("Humanoid")
		UserHum=UserChar:FindFirstChildOfClass("Humanoid") 
		hr = UserHum.RootPart
		humanoidstatuschanger = UserHum.StateChanged:connect(function() changestatus(UserHum) end)
		tpfixer = UserHum.Changed:connect(function(b) if b=="Sitting" and teleportingtowardspoint then UserHum.Sitting = false end end)
		Rig = UserHum.RigType
		if User.Character:FindFirstChildOfClass("Humanoid") and User.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
			SUPERMANN = User.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(SUPERMAN) SUPERMANN.Priority = Enum.AnimationPriority.Action SUPERMANN.TimePosition = 1 SUPERMANN.Looped = true if Config.flight==true and Config.superman==true then SUPERMANN:Play(.1,1,0) end 
		elseif User.Character:FindFirstChildOfClass("Humanoid") then
			SUPERMANN = User.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(SUPERMANR6) SUPERMANN.Priority = Enum.AnimationPriority.Action SUPERMANN.TimePosition = .09 SUPERMANN.Looped = true if Config.flight==true and Config.superman==true then SUPERMANN:Play(.1,1,0) end
		end
		changestatus(UserHum)
	end)
end) 
--- Thank you xHeptc for making the super duper sexy nigger gui lib



RunService.RenderStepped:connect(function(D) -- Constant updater to ease up resource use
	DELTA = D
	settings().Physics.AreOwnersShown = Config.VisualizeNet
	settings().Physics.AreRegionsShown = Config.VisualizeSimR -- idk what AreTerrainReplicationRegionsShown is
	if SUPERMANN then
		if Rig == Enum.HumanoidRigType.R15 then
			SUPERMANN.Priority = Enum.AnimationPriority.Action
			SUPERMANN.TimePosition = 1
			SUPERMANN.Looped = true
		else
			SUPERMANN.Priority = Enum.AnimationPriority.Action 
			SUPERMANN.TimePosition = .12 
			SUPERMANN.Looped = true
		end
		if PATHFINDING then 
			--PATHSTATUS
		end
	end
end)


--- A little bit of insight, this script is the rebirth of Skidmund, a script I never released, aspiring the same objective, but in a much more efficient way.
---
--[[ Reference
local Tab= Library.CreateLib("TITLE", "DarkTheme")

local Section = Tab:NewSection("Section Name")

Section:UpdateSection("Section New Title")

Section:NewLabel("LabelText")

label:UpdateLabel("New Text")

Section:NewButton("ButtonText", "ButtonInfo", function()
    print("Clicked")
end)

button:UpdateButton("New Text")

Section:NewToggle("ToggleText", "ToggleInfo", function(state)
    if state then
        print("Toggle On")
    else
        print("Toggle Off")
    end
end)

Section:NewSlider("SliderText", "SliderInfo", 500, 0, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

Section:NewTextBox("TextboxText", "TextboxInfo", function(txt)
	print(txt)
end)

Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.F, function()
	print("You just clicked the bind")
end)


Library:ToggleUI()

Section:NewDropdown("DropdownText", "DropdownInf", {"Option 1", "Option 2", "Option 3"}, function(currentOption)
    print(currentOption)
end)

]]
---

--[[
if antiantitp then
local state,waypoints = findpath(UserChar:GetModelCFrame().p,pos.p,AllocatedPath)
if state==Enum.PathStatus.Success then
for _,point in pairs(waypoints) do
local n,s = GetBoundingBox(UserChar,true)
local calctime = TweenInfo.new((point.Position-hr.CFrame.p).Magnitude/math.pow(UserHum.WalkSpeed,2))
local temptween = game:GetService("TweenService"):Create(hr,calctime,{CFrame = CFN(point.Position+Ve3n(0,s.Y/2,0))*hr.CFrame.Rotation})
temptween:Play()
temptween.Completed:Wait()
end
else 
local n,s = GetBoundingBox(UserChar,true)
local calctime = TweenInfo.new((pos.Position-hr.CFrame.p).Magnitude/math.pow(UserHum.WalkSpeed,2))
local temptween = game:GetService("TweenService"):Create(hr,calctime,{CFrame = CFN(pos.Position+Ve3n(0,s.Y/2,0))*hr.CFrame.Rotation})
temptween:Play()
end
else
UserChar:PivotTo(pos)
end
]]

---


---
local GUI = Gaylib.CreateLib("X-PL0X", "Serpent")
local Visuals = GUI:NewTab("Visuals")
local ESPS = Visuals:NewSection("Render")
local ESPTOG = ESPS:NewToggle("ESP", "Toggles ESP duh", function(state)
	Config.ESP = state
end)
local CROSSTOG = ESPS:NewToggle("Crosshair", "'Nice crosshair, where'd you get it?'", function(state)
	Config.CROSS = state
end)
local XRAYTOG = ESPS:NewToggle("X-Ray", "'This nigga's superman or something..'", function(state)
	Config.XRAYB = state
	if state then XRAY(0) else XRAY(Config.XRAYM) end
end)
local FOVTOG = ESPS:NewToggle("FOV", "'Widelens simulator'", function(state)
	Config.FOVSET = state
	Config.FOV = Camera.FieldOfView
end)
ESPS:NewSlider("FOV amount", "'Widelens simulator'", 120, 1, function(s)
	Config.FOV = s
end)
local Util = GUI:NewTab("Utilities")
local SPDS = Util:NewSection("Movement")
local SPDT = SPDS:NewToggle("Walkspeed","run fast as fuck boiiiii",function(state)Config.spd=state end)
local FLYT = SPDS:NewToggle("Flight", "you fly duh", function(state)
	if not state and Config.FIDGETSPINNER==true then turnflightbackon() return end --- literally fucking stupid bro
	if state then
		movedir=Ve3n(0,0,0)
		if UserHum then UserHum.Sit = false end
		RunService.Heartbeat:Wait()
		Config.flight=true
		spawn(function() ---- This is the only fucking way I can do it
			repeat wait() until UserHum
			local FallingDown = UserHum:GetStateEnabled(Enum.HumanoidStateType.FallingDown)
			local Running = UserHum:GetStateEnabled(Enum.HumanoidStateType.Running)
			local RunningNoPhysics = UserHum:GetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics)
			local Climbing = UserHum:GetStateEnabled(Enum.HumanoidStateType.Climbing)
			local StrafingNoPhysics = UserHum:GetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics)
			local Ragdoll = UserHum:GetStateEnabled(Enum.HumanoidStateType.Ragdoll)
			local GettingUp = UserHum:GetStateEnabled(Enum.HumanoidStateType.GettingUp)
			local Jumping = UserHum:GetStateEnabled(Enum.HumanoidStateType.Jumping)
			local Landed = UserHum:GetStateEnabled(Enum.HumanoidStateType.Landed)
			local Flying = UserHum:GetStateEnabled(Enum.HumanoidStateType.Flying)
			local Freefall = UserHum:GetStateEnabled(Enum.HumanoidStateType.Freefall)
			local Seated = UserHum:GetStateEnabled(Enum.HumanoidStateType.Seated)
			local PlatformStanding = UserHum:GetStateEnabled(Enum.HumanoidStateType.PlatformStanding)
			local Swimming = UserHum:GetStateEnabled(Enum.HumanoidStateType.Swimming)
			local Physics = UserHum:GetStateEnabled(Enum.HumanoidStateType.Physics)
			local None = UserHum:GetStateEnabled(Enum.HumanoidStateType.None)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.Running,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
			UserHum:SetStateEnabled(Enum.HumanoidStateType.None,false)
			spawn(function() repeat wait() until Config.flight==false
				UserHum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,FallingDown)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Running,Running)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,RunningNoPhysics)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Climbing,Climbing)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,StrafingNoPhysics)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,Ragdoll)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.GettingUp,GettingUp)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Jumping,Jumping)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Landed,Landed)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Flying,Flying)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Freefall,Freefall)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Seated,Seated)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,PlatformStanding)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Swimming,Swimming)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Physics,Physics)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.None,None)
			end) end)
		if SUPERMANN and Config.superman==true then SUPERMANN:Play(.1,1,0) end
	else Config.flight=false movedir=Ve3n(0,0,0) if SUPERMANN then SUPERMANN:Stop() end
	end
	changestatus(UserHum)
end)
function turnflightbackon() FLYT:UpdateToggle("Flight",true) end --- most simple retarded solution I could find
local VLOCKTOG = SPDS:NewToggle("Vertical lock", "Tired of falling?", function(state)
	Config.verticallock=state
	currentheight = hr and hr.CFrame.p or UserChar and UserChar:GetModelCFrame() or Ve3n(0,0,0)
end)
local CLICKTPT = SPDS:NewToggle("Click teleport", "Check the settings for it before using", function(state)
	Config.CLICKTPTOG=state
end)
local CLICKDELT = SPDS:NewToggle("Click 'delete'", "Check the settings for it before using", function(state)
	Config.CLICKDELTOG=state
end)
SPDS:NewButton("Restore map", "Hate what you did to it?", function()
	if MAPRESTORING == false then
		MAPRESTORING = true
		for _,Brick in pairs(DeletedInstances) do
			if Brick[1] and Brick[2] then
				Brick[1].Size = Brick[2]
				DeletedInstances[_]=nil
			else DeletedInstances[_]=nil
			end
		end
		MAPRESTORING = false
	end
end)
local AMBTS = Util:NewSection("Automation")
local AIMBOTTOG = AMBTS:NewToggle("Aimbot", "Automates the whole aiming process", function(state)
	Config.AIMBOT=state
end)
local triggerbottog = AMBTS:NewToggle("Triggerbot", "Automates the whole aiming process", function(state)
	Config.TRIGGERBOT=state
end)
local mousespooftog = AMBTS:NewToggle("Silent Aim", "spoofs aiming in on itself", function(state)
	Config.MOUSESPOOF = state
	--if not state then 
	--RunService.Heartbeat:Wait() 
        --[[spoofer:unspooffunction(workspace,"FindPartOnRayWithIgnoreList")
        spoofer:unspooffunction(workspace,"FindPartOnRayWithWhitelist")]]
	--spoofer:unspooffunction(workspace,"FindPartOnRay")
	--spoofer:unspooffunction(workspace,"findPartOnRay")
	--spoofer:unspooffunction(workspace,"Raycast")
	--end
end)
local AIMBOTKBMODE = AMBTS:NewDropdown("Aim key mode", "i'm a fucking genius bro", {"None", "Toggle", "Hold"}, function(currentOption)
	Config.aimbotkbmode = currentOption
end)
local AUTOWALKTOG = AMBTS:NewToggle("Auto walk (not coded)", "if noob then walktonoob() end", function(state)
	Config.autowalk = state
end)

local Spoofing = GUI:NewTab("Spoofing")
---
local SPFN = Spoofing:NewSection("Network")
local BRAZILWIFI = SPFN:NewTextBox("Outbound KB/s", "Max (and default) is 64KB/s", function(am)
	Config.OKBPS = math.clamp(math.abs(tonumber(am)),1,64) or 64
	game:GetService("NetworkClient"):SetOutgoingKBPSLimit(Config.OKBPS)
end)
local BRAZILPING = SPFN:NewTextBox("Replication lag", "It's a multiplier. Any number.", function(am)
	Config.RLAG = tonumber(math.abs(am)) or 0
	settings().Network.IncomingReplicationLag = Config.RLAG
end)
local TOGGLENET = SPFN:NewToggle("Force simradius", "XD flying sex", function(state) Config.ForceSimR = state end)
local SETSIMR = SPFN:NewTextBox("Simradius value", "Simradius in studs", function(am) Config.SimR = tonumber(am)~=nil and tonumber(am) or 1000 setsimulationradius(Config.SimR) end)
local SHN = Spoofing:NewSection("Local Shenanigans")
SHN:NewTextBox("Spoof userid","Any number, defaults to place owner", function(input)local owner = game.CreatorType==Enum.CreatorType.User and game.CreatorId or game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id local input = tonumber(input)~=nil and tonumber(input) or owner spoofer:spoof(User,"UserId",input,false) end)
SHN:NewTextBox("Spoof username","Any string, defaults to place owner", function(input)local owner = game.CreatorType==Enum.CreatorType.User and game.CreatorId or game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id local input = tostring(input)~="" and tostring(input) or game:GetService("Players"):GetNameFromUserIdAsync(owner) spoofer:spoof(User,"Name",input,false)  end)
local RANKSPOOF = SHN:NewToggle("Spoof grouprank","Spoofs rank to 255", function(state) Config.SPOOFRANK=state if state then spoofer:spooffunction(User,"GetRankInGroup",255,false) else spoofer:unspooffunction(User,"GetRankInGroup") end end)
local ASSETSPOOF = SHN:NewToggle("Spoof assets","Spoofs item ownership", function(state) Config.SPOOFASSETS=state if state then spoofer:spooffunction(game:GetService("MarketplaceService"),"UserOwnsGamePassAsync",true,false) spoofer:spooffunction(game:GetService("GamePassService"),"PlayerHasPass",true,false) spoofer:spooffunction(game:GetService("MarketplaceService"),"PlayerOwnsAsset",true,false) else spoofer:unspooffunction(game:GetService("MarketplaceService"),"UserOwnsGamePassAsync") spoofer:unspooffunction(game:GetService("GamePassService"),"PlayerHasPass") spoofer:unspooffunction(game:GetService("MarketplaceService"),"PlayerOwnsAsset") end end)
---
local Misc = GUI:NewTab("Miscellaneous")
local MiscGui = Misc:NewSection("UI tweaks")
local db1 = false
local DISABLEPURCHASES = MiscGui:NewToggle("Disable purchase prompts","Tired of the 'chair' free model?", function(state) spawn(function() if db1==true then repeat wait() until db1==false end db1=true Config.NOPURCHASES = state spawn(function() game:GetService("CoreGui"):WaitForChild("PurchasePrompt").Enabled = state db1=false end) end) end)
local DISABLELOADINGSCREEN = MiscGui:NewToggle("Disable loading screen","Need something refreshing?", function(state) Config.NOLOADINGSCREEN = state getgenv().XPL0XDISABLELOADINGSCREEN = state end)
local MiscVis = Misc:NewSection("Visuals (some might not work because roblox)")
MiscVis:NewToggle("'Wireframe'", "It's supposed to work....", function(state)
	settings().Rendering.RenderCSGTrianglesDebug = state
end)
MiscVis:NewToggle("Bounding Boxes", "Draws box around EVERYTHING", function(state)
	settings().Rendering.ShowBoundingBoxes = state
end)
MiscVis:NewToggle("VRAM unlocker", "Disables vram cap", function(state)
	settings().Rendering.EagerBulkExecution = state
end)
MiscVis:NewTextBox("Change mesh cache", "Default size is 32MB", function(state)
	settings().Rendering.MeshCacheSize = tonumber(state) or 32
end)
MiscVis:NewToggle("Diagnostic mode", "Toggles diagnostic mode", function(state)
	if state then settings().Rendering.GraphicsMode = Enum.GraphicsMode.NoGraphics
	else
		settings().Rendering.GraphicsMode = Enum.GraphicsMode.Automatic end
end)
local ViewSimR = MiscVis:NewToggle("Simradius viewer", "Who's fucking with my net owner??", function(state)Config.VisualizeSimR = state end)
local ViewOwners = MiscVis:NewToggle("Physowner vision", "Who's fucking with my net owner??", function(state)Config.VisualizeNet = state end)

local Prot = GUI:NewTab("Protection")
local MSECT = Prot:NewSection("Character")
local MTOG = MSECT:NewToggle("Disable death","Death? Is this a bad joke?",function(state)
	Config.IMMORTALITY=state
	spawn(function()
		repeat wait() until UserHum
		local hst = UserHum:GetStateEnabled(15)
		if state then spawn(function() repeat wait() until Config.IMMORTALITY==false UserHum:SetStateEnabled(15,hst) end) end
	end)
	changestatus(UserHum)
end)
local FELOOPPROTTOG = MSECT:NewToggle("Anti feloop","Prevents tool equipping",function(state)
	Config.AFELOOP=state
end)
local FPDST = MSECT:NewToggle("Ignore destruction layer","Fall for 99999 seconds challenge",function(state)
	Config.FPDSD = state
	spawn(function()
		local hst = workspace.FallenPartsDestroyHeight
		workspace.FallenPartsDestroyHeight = math.huge-math.huge
		if Config.FPDSD==true then spawn(function() repeat wait() until Config.FPDSD==false workspace.FallenPartsDestroyHeight=hst end) end
	end)
end)
local Gim = GUI:NewTab("Gimmicks")
local CharGim = Gim:NewSection("Character")
local TrollGim = Gim:NewSection("Trolling")
sounddebounce = false
local PlaySounds = TrollGim:NewButton("Fuck... I hate niggers....", "Plays every sound [FE]", function()
	if sounddebounce then return else sounddebounce = true end
	spawn(function() wait(1) sounddebounce=false end)
	for _,S in pairs(workspace:GetDescendants()) do if S:IsA("Sound") then S:Play() end end
end)
local StopSounds = TrollGim:NewButton("NIGGERS ARE BLACK BRO!!!! SCARY.", "Stops every sound [FE]", function()
	if sounddebounce then return else sounddebounce = true end
	spawn(function() wait(1) sounddebounce=false end)
	for _,S in pairs(workspace:GetDescendants()) do if S:IsA("Sound") then S:Stop() end end
end)
local ScrambleSounds = TrollGim:NewButton("Poop. Toluene Miller gay sex.", "Stops every sound [FE]", function()
	if sounddebounce then return else sounddebounce = true end
	spawn(function() wait(1) sounddebounce=false end)
	for _,S in pairs(workspace:GetDescendants()) do if S:IsA("Sound") then S:Pause() S.TimePosition = math.random(0,S.TimeLength) S:Resume() end end
end)
local EARRAPE = TrollGim:NewButton("Poop. Toluene Miller gay sex.", "Stops every sound [FE]", function()
	if sounddebounce then return else sounddebounce = true end
	spawn(function() wait(1) sounddebounce=false end)
	for _,S in pairs(workspace:GetDescendants()) do if S:IsA("Sound") then S:Pause() local oldvol = S.Volume S.Volume=10 local earrape = Instance.new("DistortionSoundEffect",S) earrape.Level = .5 earrape.Priority = 2^31 S:Resume() spawn(function() repeat wait() until S.Stopped S.Volume = oldvol earrape:Remove() end) end end
end)
local SPAMCD = TrollGim:NewButton("Fire click detectors", "Pray the game doesn't have AC", function()
	spawn(function() for _,N in pairs(game:GetDescendants()) do if N:IsA("ClickDetector") then fireclickdetector(N) end end end)
end)
local SPAMTD = TrollGim:NewButton("Fire touch detectors", "Pray the game doesn't have AC", function()
	spawn(function() for _,N in pairs(game:GetDescendants()) do if N:IsA("TouchTransmitter") then spawn(function() firetouchinterest(N.Parent,hr,1) game:GetService("RunService").RenderStepped:Wait() firetouchinterest(N.Parent,hr,0) end) end end end)
end)
local FidgetSpinner = TrollGim:NewToggle("Fidget spinner", "This is a certified hood classic.", function(state)
	Config.FIDGETSPINNER = state
	if state then FLYT:UpdateToggle("Flight",true) else hr.AssemblyAngularVelocity = Ve3n(0,0,0) end
end)
local FIDGETSPINNERNOCLIP = TrollGim:NewToggle("Fidget spinner noclip", "No moure bouncing!!!!", function(state)
	Config.fspinnernoclip = state
end)
function updsoundtroll() --- too lazy to copypaste the same function twice lol
	if game:GetService("SoundService").RespectFilteringEnabled==true then
		PlaySounds:UpdateButton("Play sounds [Local]")
		StopSounds:UpdateButton("Stop sounds [Local]")
		ScrambleSounds:UpdateButton("Scramble sounds [Local]")
		EARRAPE:UpdateButton("Earrape playback [Local]")
	else
		PlaySounds:UpdateButton("Play sounds [Global]")
		StopSounds:UpdateButton("Stop sounds [Global]")
		ScrambleSounds:UpdateButton("Scramble sounds [Global]")
		EARRAPE:UpdateButton("Earrape playback [Global]")
	end end updsoundtroll()
function swimfunc(a)
	spawn(function() ---- This is the only fucking way I can do it
		repeat wait() until UserHum
		if FallingDown and Running and RunningNoPhysics and Climbing and StrafingNoPhysics and Ragdoll and GettingUp and Jumping and Landed and Flying and Freefall and Seated and PlatformStanding and Swimming and Physics then else

			FallingDown = UserHum:GetStateEnabled(Enum.HumanoidStateType.FallingDown)
			Running = UserHum:GetStateEnabled(Enum.HumanoidStateType.Running)
			RunningNoPhysics = UserHum:GetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics)
			Climbing = UserHum:GetStateEnabled(Enum.HumanoidStateType.Climbing)
			StrafingNoPhysics = UserHum:GetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics)
			Ragdoll = UserHum:GetStateEnabled(Enum.HumanoidStateType.Ragdoll)
			GettingUp = UserHum:GetStateEnabled(Enum.HumanoidStateType.GettingUp)
			Jumping = UserHum:GetStateEnabled(Enum.HumanoidStateType.Jumping)
			Landed = UserHum:GetStateEnabled(Enum.HumanoidStateType.Landed)
			Flying = UserHum:GetStateEnabled(Enum.HumanoidStateType.Flying)
			Freefall = UserHum:GetStateEnabled(Enum.HumanoidStateType.Freefall)
			Seated = UserHum:GetStateEnabled(Enum.HumanoidStateType.Seated)
			PlatformStanding = UserHum:GetStateEnabled(Enum.HumanoidStateType.PlatformStanding)
			Swimming = UserHum:GetStateEnabled(Enum.HumanoidStateType.Swimming)
			Physics = UserHum:GetStateEnabled(Enum.HumanoidStateType.Physics)
			--local None = UserHum:GetStateEnabled(Enum.HumanoidStateType.None)
		end
		UserHum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		UserHum:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		--UserHum:SetStateEnabled(Enum.HumanoidStateType.None,false)
		repeat wait() until Config.SWIM==false or User.CharacterAdded
		if Config.SWIM==false then
			local UserHum = User.Character:FindFirstChildOfClass("Humanoid")
			if UserHum then
				UserHum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,FallingDown)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Running,Running)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,RunningNoPhysics)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Climbing,Climbing)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,StrafingNoPhysics)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,Ragdoll)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.GettingUp,GettingUp)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Jumping,Jumping)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Landed,Landed)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Flying,Flying)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Freefall,Freefall)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Seated,Seated)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,PlatformStanding)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Swimming,Swimming)
				UserHum:SetStateEnabled(Enum.HumanoidStateType.Physics,Physics)
				--UserHum:SetStateEnabled(Enum.HumanoidStateType.None,None)
				FallingDown,Running,RunningNoPhysics,Climbing,StrafingNoPhysics,Ragdoll,GettingUp,Jumping,Landed,Flying,Freefall,Seated,PlatformStanding,Swimming,Physics = nil
			end
		elseif Config.SWIM==true then swimfunc() end
	end)
end --- another retard solution
game:GetService("SoundService").Changed:Connect(function(s) if s=="RespectFilteringEnabled" then updsoundtroll() end end) --- in case something changes FE sounds mid-game.
local swmT = CharGim:NewToggle("Air swim","Do crabs think fish fly?",function(state)
	Config.SWIM = state
	if state then swimfunc() end
	changestatus(UserHum)
end)
local NOGRAV = CharGim:NewToggle("No gravity", "poland cannot into space", function(state) 
	Config.nograv = state
end)

--[[
Will be added later
local Spoofing = GUI:NewTab("Spoofing")
local Misc = GUI:NewTab("Miscellaneous")
local Prot = GUI:NewTab("Protection") 
local Util = GUI:NewTab("Utilities")
local Gim = GUI:NewTab("Gimmicks")
]]
---
local Statsz = GUI:NewTab("Stats")
local ClientStats = Statsz:NewSection("Client")
local ServerStats = Statsz:NewSection("Server")

local FPSL = ClientStats:NewLabel("FPS")
local PINGL = ClientStats:NewLabel("Ping")
local PhysL = ClientStats:NewLabel("Physics TPS")
local PhysLR = ClientStats:NewLabel("REAL")

local TPSL = ServerStats:NewLabel("TPS")
local PTPSL = ServerStats:NewLabel("Physics TPS")
---
local Settings = GUI:NewTab("Settings")
local ESPSET = Settings:NewSection("ESP")
local CROSSSET = Settings:NewSection("Crosshair")
local XRAYSET = Settings:NewSection("X-Ray")
local TEAMCOLOREDBOXt = ESPSET:NewToggle("Team coloured boxes", "have sex with children", function(state) 
	Config.COLOREDBOXES=state
end)
local mn = ESPSET:NewToggle("Directional Arrows", "y u no like dem??", function(state) 
	Config.ARW=state
end)
local mn2 = ESPSET:NewToggle("Healthbar", "buh 💀", function(state) 
	Config.HLT=state
end)
local HESP = ESPSET:NewToggle("Show heads", "gg ez onetap", function(state) 
	Config.HESPT = state
end)
local TRACERS = ESPSET:NewToggle("Tracers", "omg guys i found him!!", function(state) 
	Config.TRACERST = state
end)
local NTAG = ESPSET:NewToggle("Nametags", "u n00b ncca?", function(state) 
	Config.NTAGST = state
end)
local BOCKS = ESPSET:NewToggle("Box", "frame :)", function(state) 
	Config.BOX = state
end)
local SKELLE = ESPSET:NewToggle("Skeleton", "spooky!", function(state) 
	Config.Skeleton = state
end)
local NTAGO = ESPSET:NewSlider("Nametag offset", "(Y%)", 400, -400, function(s)
	Config.NTAGSV = s
end)
local NTAGS = ESPSET:NewTextBox("Nametag size", "Any non-imaginary number", function(s)
	Config.NTAGV = s
end)
local FONTz = ESPSET:NewDropdown("Font", "I like your style.", {"UI", "System", "Plex", "Monospace"}, function(currentOption)
	Config.FONT = Drawing.Fonts[currentOption]
end)

local CROSSCS = CROSSSET:NewColorPicker("Crosshair color", "Choose whatever color", Color3.fromRGB(255,255,255), function(color)
	Config.CROSSC = {color.R,color.G,color.B}
end)
local CROSSTRANSEL = CROSSSET:NewSlider("Crosshair (%)", "How opaque?", 100, 0, function(s)
	Config.CROSSTRAN = s
end)
local CROSSSZ = CROSSSET:NewTextBox("Crosshair size","Any non-imaginary number", function(am)
	Config.CROSSS = tonumber(am) or 15
end)
local XRAYSETT = XRAYSET:NewSlider("X-Ray (%)", "100% = map is invisible", 100, 0, function(s)
	Config.XRAYM = s/100
end)
local AUTOUPDXRAY = XRAYSET:NewToggle("X-Ray autoupdate", "VERY resource intensive", function(state) 
	Config.XRAYBU=state
end)
local UPDXRAY = XRAYSET:NewButton("X-Ray manual update", "Manually update X-RAY", function() 
	if Config.XRAYB==true then
		XRAY(Config.XRAYM)
	end
end)

local SPDSET = Settings:NewSection("Movement")
local FLYSP = SPDSET:NewTextBox("Flight speed","Any non-imaginary number", function(am)
	Config.fspeed = tonumber(am) or 10
end)
local SUPRMN = SPDSET:NewToggle("Superman mockup", "wtf are you superman ncca?", function(state) Config.superman=state 
	if state and SUPERMANN then
		spawn(function()
			repeat wait() until Config.flight==true
			if Config.superman==false then else
				if SUPERMANN then
					SUPERMANN.Priority = Enum.AnimationPriority.Action
					SUPERMANN.TimePosition = 1
					SUPERMANN.Looped = true
					SUPERMANN:Play(.1,1,0) end
			end
		end)
	elseif not state or Config.flight==false then
		if SUPERMANN then
			SUPERMANN:Stop() 
		end
	end
end)
local FLIGHTNOGRAV = SPDSET:NewToggle("Anti flight drift", "prevents vertical drift", function(state) 
	Config.flightnograv = state
end)
local SPDP = SPDSET:NewTextBox("Walkspeed","Any non-imaginary number", function(am)
	Config.spdsp = tonumber(am) or 16
end)
local SPDDRFT = SPDSET:NewToggle("Anti slip","Any non-imaginary number", function(am)
	Config.SPEEDDRIFT = am
end)
local BINDSET = Settings:NewSection("Keybinds")
local CLICKTPKB = BINDSET:NewKeybind("Click teleport bind", "This is the keybind for it", Enum.KeyCode.LeftControl, function(bind)
	if Config.CLICKTPTOG==true and FIRING == false then
		if Config.CLICKTP==true then
			Config.CLICKTP = false
		else Config.CLICKTP = true spawn(function() while game:GetService("UserInputService"):IsKeyDown(bind) do game:GetService("UserInputService").InputEnded:Wait() end Config.CLICKTP = false end)
		end
	end
end)
local CLICKDELKB = BINDSET:NewKeybind("Click delete bind", "This is the keybind for it", Enum.KeyCode.RightAlt, function(bind)
	if Config.CLICKDELTOG==true and FIRING == false and MAPRESTORING==false then
		if Config.CLICKDEL==true then
			Config.CLICKDEL = false
		else Config.CLICKDEL = true spawn(function() while game:GetService("UserInputService"):IsKeyDown(bind) do game:GetService("UserInputService").InputEnded:Wait() end Config.CLICKDEL = false end)
		end
	end
end)
local FLIGHTKB = BINDSET:NewKeybind("Click delete bind", "This is the keybind for it", Enum.KeyCode.KeypadPlus, function(bind)
	if Config.flight==true then
		FLYT:UpdateToggle("Flight",false) else FLYT:UpdateToggle("Flight",true) end
end)
local AIMBOTKB = BINDSET:NewKeybind("Aimbot bind", "This is the keybind for it", Enum.KeyCode.V, function(bind)
	if Config.AIMBOT==true then
		if Config.aimbotkbmode=="Toggle" then
			AIMBOTTOG:UpdateToggle("Aimbot",false)Config.AIMBOT=false end
	else 
		if Config.aimbotkbmode=="Toggle" then
			AIMBOTTOG:UpdateToggle("Aimbot",true)Config.AIMBOT=true
		elseif Config.aimbotkbmode=="Hold" then AIMBOTTOG:UpdateToggle("Aimbot",true) spawn(function() while game:GetService("UserInputService"):IsKeyDown(bind) or Config.AIMBOT==false do game:GetService("UserInputService").InputEnded:Wait() end AIMBOTTOG:UpdateToggle("Aimbot",false) end) end
	end
end)


local TARGETSETBANNER = Settings:NewSection("Targeting")
local TGTLIST = TARGETSETBANNER:NewTextBox("Target", "FETCH ME THEIR SOULS!!!!", function(txt)
	TGT = MatchName(txt)
end)
local TPTOBTN = TARGETSETBANNER:NewButton("Teleport", "Instant transmission?", function(txt)
	if not teleportingtowardspoint then else return end
	teleportingtowardspoint = true
	local pos = UserChar:GetModelCFrame()
	if TGT and TGT[1] and TGT[1].Character and Config.RANDOMTGT~=true then 
		if UserHum then UserHum.Sit = false end
		RunService.Heartbeat:Wait()
		pos = TGT[1].Character:GetModelCFrame()
	else
		if UserHum then UserHum.Sit = false end
		RunService.Heartbeat:Wait()
		pos = randomplayer().Character:GetModelCFrame()
	end
	if Config.antiantitp==true then
		local n,s = GetBoundingBox(UserChar,false)
		local radius = s.X>s.Z and s.X or s.Z
		local state,waypoints = findpath(UserChar:GetModelCFrame().p,pos.p,game:GetService("PathfindingService"):CreatePath({AgentRadius=radius,AgentHeight=s.Y,AgentCanJump = true}))
		if state==Enum.PathStatus.Success then
			for _,point in pairs(waypoints) do
				Phys:MoveTo(hr,CFN(point.Position),1)
				--warn("noger")
				local tptimeout = true
				spawn(function() wait(10) if tptimeout then return  end end)
				repeat wait() until (hr.Position-point.Position).Magnitude<3
				tptimeout = nil
			end
			Phys:PurgePhysics(hr)
		else 
			local n,s = GetBoundingBox(UserChar,false)
			local calctime = TweenInfo.new((pos.Position-hr.CFrame.p).Magnitude/math.pow(UserHum.WalkSpeed,2))
			local temptween = game:GetService("TweenService"):Create(hr,calctime,{CFrame = CFN(pos.Position+Ve3n(0,s.Y*.5,0))*hr.CFrame.Rotation})
			temptween:Play()
		end
	else
		UserChar:PivotTo(pos)
	end
	teleportingtowardspoint = false
end)
local ANTIANTITPt = TARGETSETBANNER:NewToggle("Anti anti tp", "ayo wtf", function(ms)
	Config.antiantitp = ms
end)
local AIMBOTSETBANNER = Settings:NewSection("Aimbot")
local TEAMCHECK = AIMBOTSETBANNER:NewToggle("Team check", "friendly fire is banned!!", function(state)
	Config.teamcheck = state
end)
local WALLCHECK = AIMBOTSETBANNER:NewToggle("Wall check", "friendly fire is banned!!", function(state)
	Config.wallcheck = state
end)
local AIMSPEED = AIMBOTSETBANNER:NewTextBox("Aim speed", "gay fart sex penis", function(s)
	local aimspeedz = tonumber(s) or 10
	Config.aimspeed = aimspeedz
end)
local HEADAIM = AIMBOTSETBANNER:NewToggle("Headshot", "onetap 2.0 (real)", function(state)
	Config.headaim = state
end)
local SHOOTRAD = AIMBOTSETBANNER:NewTextBox("Trigger radius", "BOOM HEADSHOT!", function(am)
	Config.shootrad = tonumber(am) or 10
end)
local SHOOTSPEED = AIMBOTSETBANNER:NewTextBox("Shots per second", "BRRRT", function(am)
	local number = tonumber(am) and am or 1000
	Config.firedelay = 1/number
end)
local LOCKTARGETTOG = AIMBOTSETBANNER:NewToggle("Lock target", "tired of spinning?", function(state)
	Config.LockTarget = state
end)
local RANDOMTARGETTOGGLE = TARGETSETBANNER:NewToggle("Random target", "Chooses any target at random", function(state) 
	Config.RANDOMTGT=state
end)
---
local Credits = GUI:NewTab("Credits")
local Thx = Credits:NewSection("Thanks to:")
local Thxwho = Thx:NewLabel("Github - home of this shit")
local Thxwho2 = Thx:NewLabel("xHeptc - fuck you nigga why can't I fuck this UI???")
local Thxwho3 = Thx:NewLabel("rqccc - taught me how to get server ping")
local Thxwho4 = Thx:NewLabel("ic3w0lf22 - tracer code used for aimbot and tracers")
local DC = GUI:NewTab("Discord")
local mm=DC:NewSection("Discord Server")
local m=mm:NewButton("Copy to clipboard", "copies discord invite to clipboard", function()
	if discorddebounce then else
		setclipboard('https://discord.gg/eCtE2ukNVV')
		m:UpdateButton("Copied!")
		discorddebounce=true
		wait(1)
		discorddebounce=nil
		m:UpdateButton("Copy to clipboard")
	end
end)
---
--[[  So yeah this is ESP template and stuff

[Player] = 
{
    Plr,
    Box,
    Healthbar = {},
    Arrow = {},
}

]]
--- Custom Functions and shit
local PLAYERLIST = {}
local SKELETONS = {}
lowvalue = -(2^31-1)
highvalue = -lowvalue
--StatsService = game:GetService("Stats") --- redundant af
local StatsService = stats()
local UserInputService = game:GetService("UserInputService")
DELTA = 0
local Ping = StatsService:WaitForChild("Network"):WaitForChild("ServerStatsItem"):WaitForChild("Data Ping")
local ContextActionService = game:GetService("ContextActionService")
local movedir=Ve3n(0,0,0)
local f,b,l,r = false,false,false,false

WallRaycastConfig = RaycastParams.new()
WallRaycastConfig.FilterType = Enum.RaycastFilterType.Blacklist
WallRaycastConfig.IgnoreWater = true
function GetClosestPlayer(d,t,w,h,a,trackuntil)
	WallRaycastConfig.FilterDescendantsInstances={Camera,UserChar} --heightOffset = cameraSubject.RigType == Enum.HumanoidRigType.R15 and R15HeadHeight or HEAD_OFFSET
	local d = d or 25000
	local player = nil
    local temptgt = nil
    local offset = Ve3n(0,1.5,0)

	local function testfor(plr) --messy but idgaf
		if plr~=User and plr.Character and UserChar then
            local pheadp = UserChar:FindFirstChild("Head")
            local p = pheadp and pheadp.Position or UserChar:GetModelCFrame().p
			local dist = (p-plr.Character:GetModelCFrame().p).Magnitude

            local Camera = pheadp and UserInputService.MouseBehavior~=Enum.MouseBehavior.LockCenter and pheadp or Camera
			if dist<d then else return nil end
			if t then if plr.TeamColor ~= User.TeamColor then else return nil end end
			if UserChar:FindFirstChildOfClass("Humanoid") then if UserChar:FindFirstChildOfClass("Humanoid").Health==0 or UserChar:FindFirstChildOfClass("Humanoid"):GetState() == Enum.HumanoidStateType.Dead then return nil end end
			if a==true then if plr.Character:FindFirstChildOfClass("Humanoid") and (plr.Character:FindFirstChildOfClass("Humanoid").Health~=0 or plr.Character:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Dead) then else temptgt = nil end if plr.Character:FindFirstChildOfClass("ForceField") then return nil end end
			if w then
				local ray2 = workspace:Raycast(Camera.CFrame.p,(plr.Character:GetModelCFrame().p-Camera.CFrame.p).Unit*d,WallRaycastConfig)
				local ray1 = ray2
				if plr.Character:FindFirstChild("Head") then ray1 = workspace:Raycast(Camera.CFrame.p,(plr.Character:FindFirstChild("Head").CFrame.p-Camera.CFrame.p).Unit*d,WallRaycastConfig) end
				if h then
					if ray1==nil or ray1.Instance==nil or plr.Character:IsAncestorOf(ray1.Instance) then else return nil end 
				else
					if ray2==nil or ray2.Instance==nil or plr.Character:IsAncestorOf(ray2.Instance) then else return nil end 
				end
			end
			return plr, d
		else
			return nil
		end
	end

	if trackuntil and temptgt then temptgt = testfor(temptgt) else
		temptgt = nil
		for _,plr in pairs(Players:GetPlayers()) do
			player, d = testfor(plr) or player,d
		end 
	end

	--temptgt = player
	return player
end

refreshplayers() 
Players.PlayerAdded:connect(function() refreshplayers()  end)
Players.PlayerRemoving:connect(function() refreshplayers()  end)
local function MOVEMENT(actionname, inputstate, inputobject) --- I FUCKING HATE CONTEXTACTIONSERVICE!!!!!!!!!!!!!!!!!!!!!!!!!
	if (Config.flight or Config.verticallock) then
		if f==false and actionname == "f" and inputstate == Enum.UserInputState.Begin then f=true movedir = Ve3n(movedir.X,movedir.Y,movedir.Z-1) end
		if b==false and actionname == "b" and inputstate == Enum.UserInputState.Begin then b=true movedir = Ve3n(movedir.X,movedir.Y,movedir.Z+1) end
		if l==false and actionname == "l" and inputstate == Enum.UserInputState.Begin then l=true movedir = Ve3n(movedir.X-1,movedir.Y,movedir.Z) end
		if r==false and actionname == "r" and inputstate == Enum.UserInputState.Begin then r=true movedir = Ve3n(movedir.X+1,movedir.Y,movedir.Z) end

		if f==true and actionname == "f" and inputstate == Enum.UserInputState.End then f=false movedir = Ve3n(movedir.X,movedir.Y,movedir.Z+1) end
		if b==true and actionname == "b" and inputstate == Enum.UserInputState.End then b=false movedir = Ve3n(movedir.X,movedir.Y,movedir.Z-1) end
		if l==true and actionname == "l" and inputstate == Enum.UserInputState.End then l=false movedir = Ve3n(movedir.X+1,movedir.Y,movedir.Z) end
		if r==true and actionname == "r" and inputstate == Enum.UserInputState.End then r=false movedir = Ve3n(movedir.X-1,movedir.Y,movedir.Z) end
	end end
ContextActionService:BindAction("f", MOVEMENT, false, Enum.PlayerActions.CharacterForward)
ContextActionService:BindAction("b", MOVEMENT, false, Enum.PlayerActions.CharacterBackward)
ContextActionService:BindAction("l", MOVEMENT, false, Enum.PlayerActions.CharacterLeft)
ContextActionService:BindAction("r", MOVEMENT, false, Enum.PlayerActions.CharacterRight)
UserInputService.InputChanged:Connect(function(input, gameProcessed) 
	InGUI = gameProcessed
	if gameProcessed then 
		movedir = Ve3n(0,0,0) 
		f,b,l,r = false,false,false,false  end 
end)---UI BUGFIX



--- Whatever else section
function flighregulate() if hr.AssemblyLinearVelocity.Magnitude>Config.fspeed/100 then hr.AssemblyLinearVelocity = Ve3n(0,0,0) end end--UserChar:PivotTo(CFN(UserChar:GetPivot().p)) 
RunService.Stepped:connect(function(a,d) ---inefficient but I think it'd be more if I spread it accross renderS and S, plus ws won't work if .RS is used
	physTPS=d or 0
	if hr and (Config.flight or Config.verticallock) and not teleportingtowardspoint then
		local movedir2 = movedir
		if movedir.Magnitude>0 then
			movedir2 = movedir.Unit 
		end
		local x, y, z, m11, m12, m13, m21, m22, m23, m31, m32, m33 = Camera.CFrame:components()
		local noycoordscam = CFN(x,y,z, m11,m12,m13, m21,m22,m23, m31,0,m33)
		local ws = (Config.spd==true and Config.spdsp) or (UserHum and UserHum.WalkSpeed or 16)
		local cf = Config.verticallock==true and (noycoordscam.Rotation+Ve3n(hr.CFrame.p.X,currentheight.Y,hr.CFrame.p.Z)):ToWorldSpace(CFN(movedir2*ws/100)) or (Camera.CFrame.Rotation+hr.CFrame.p):ToWorldSpace(CFN(movedir2*(Config.fspeed/10)))      --+movedir2--*(ws/1000)
		Phys:MoveTo(hr,cf,75)
	end
	if hr and not teleportingtowardspoint then if (not Config.flight and not Config.verticallock)==true then Phys:PurgePhysics(hr) end else FLYT:UpdateToggle("Flight",false) end
	if Config.FIDGETSPINNER==true and Config.fspinnernoclip==true then for _,N in pairs(UserChar:GetChildren()) do if N:IsA("BasePart") then N.CanCollide = false end end end
	if hr and Config.FIDGETSPINNER then flighregulate() if UserHum then changestatus(UserHum) end hr.AssemblyAngularVelocity = Ve3n(0,2^8/DELTA,0) end--*CFrame.Angles(0,y,0) end .6*DELTA
	if hr and Config.spd==true and Config.flight==false and UserHum then
		if UserHum.MoveDirection.Magnitude>0 then
			local ws = UserHum.MoveDirection.Unit*Config.spdsp
			hr.AssemblyLinearVelocity=Ve3n(ws.X,hr.AssemblyLinearVelocity.Y,ws.Z) 
		elseif Config.SPEEDDRIFT==true then
			local ws = UserHum.MoveDirection.Unit*Config.spdsp
			if UserHum.MoveDirection.Magnitude>0 then
				hr.AssemblyLinearVelocity=Ve3n(ws.X,hr.AssemblyLinearVelocity.Y,ws.Z) else
				hr.AssemblyLinearVelocity=Ve3n(0,hr.AssemblyLinearVelocity.Y,0)
			end
		end
		--elseif hr==nil or UserHum==nil then SPDT:UpdateToggle("Enable",false) ---not really needed


	end
	if (Config.SWIM or Config.nograv or (Config.flightnograv and (Config.flight and not Config.verticallock)==true) or Config.FIDGETSPINNER) and hr and UserHum then --
		hr:ApplyImpulse(Ve3n(0,hr.AssemblyMass*workspace.Gravity*d,0)) --- as precise as I can go, lots of trial and error, then it suddendly came up to me when I accidentally pressed F12.
	end 
end)

RunService.Heartbeat:connect(function()

	if Config.superman==true and Config.FIDGETSPINNER==false and movedir.Magnitude>0 and Config.verticallock==false and Config.flight==true then --hr.CFrame = hr.CFrame:lerp(CFN(hr.CFrame.p,cf.p),d*50) ---eh not for my taste, choppy it is!
		--local cf = (Camera.CFrame.Rotation+hr.CFrame.p):ToWorldSpace(CFN(movedir2*(Config.fspeed/10)))
		hr.CFrame = CFN(hr.CFrame.p)*CFN(Camera.CFrame.p,Camera.CFrame:ToWorldSpace(CFN(movedir)).p).Rotation --spawn(function() game:GetService("RunService").Heartbeat:Wait() hr.CFrame=hr.CFrame*CFN(hr.CFrame.p,cf.p).Rotation end)
	end
	if Config.FIDGETSPINNER==true then UserChar:PivotTo(CFN(UserChar:GetPivot().p)) end
	if hr and Config.FIDGETSPINNER then flighregulate() end

	if Config.XRAYB==true and Config.XRAYBU==true then
		XRAY(Config.XRAYM)  end

end)

windowactive = false
--- Rendering section
local fakemouseparams = RaycastParams.new()
fakemouseparams.IgnoreWater=false
spawn(function() while RunService.RenderStepped:Wait() do --- aimbot 
		local windowactive = isrbxactive()~=nil and isrbxactive() or iswindowactive()~=nil and iswindowactive
		AIMSTATUS.Text = "Aimbot: Polling"
		if Config.AIMBOT==true and ((UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter and windowactive and User.GameplayPaused==false and GuiService.MenuIsOpen==false) or (Config.MOUSESPOOF==true and User.GameplayPaused==false and GuiService.MenuIsOpen==false and windowactive)) then 
			local target = GetClosestPlayer(25000,Config.teamcheck,Config.wallcheck,Config.headaim,true,Config.LockTarget)
			-- Adding the following later when I get home
			if target and target.Character then
				--if target.Character:FindFirstChildOfClass("Humanoid") then if target.Character:FindFirstChildOfClass("Humanoid").Health==0 or target.Character:FindFirstChildOfClass("Humanoid"):GetState() == Enum.HumanoidStateType.Dead then else
				local targetpos,targetinst = nil
				if Config.headaim==true and target.Character:FindFirstChild("Head") then
					targetpos,targetinst = target.Character:FindFirstChild("Head").CFrame.p,target.Character:FindFirstChild("Head")
					if Config.MOUSESPOOF==true then spoofer:spoof(false,"Target",target.Character:FindFirstChild("Head"),true) spoofer:spoof(false,"target",target.Character:FindFirstChild("Head"),true) end
				else targetpos,targetinst = target.Character:GetModelCFrame().p,target.Character:FindFirstChild("HumanoidRootPart")
					if Config.MOUSESPOOF==true then spoofer:spoof(false,"Target",target.Character:FindFirstChild("HumanoidRootPart"),true) spoofer:spoof(false,"target",target.Character:FindFirstChild("HumanoidRootPart"),true) end
				end
				if Config.MOUSESPOOF==true then spoofer:spoof(false,"Hit",CFN(targetpos),true) spoofer:spoof(false,"hit",CFN(targetpos),true) end
				--local targetpos = Ve3n(0,0,0) --aimbot debug lol
				local FinalMouse, nigger = WorldToViewport(targetpos)
				if FinalMouse.Z<0 then
					FinalMouse = math:InverseWorldToViewportPoint(targetpos)
				end
				--local payload = {targetinst,targetpos,Ve3n(0,1,0),targetinst.Material}
				fakemouseparams.FilterDescendantsInstances = {Mouse.TargetFilter}
				if Config.MOUSESPOOF==true and InGUI==false then
					spoofer:spoof(false,"UnitRay",Ray.new(Camera.CFrame.p,(targetpos-Camera.CFrame.p).Unit),true) 
					spoofer:spoof(false,"Origin",CFN(Camera.CFrame.p,targetpos),true) 

					--spoofer:spooffunction(workspace,"FindPartOnRayWithIgnoreList",true,payload)
					--spoofer:spooffunction(workspace,"FindPartOnRayWithWhitelist",true,payload)
					--spoofer:spooffunction(workspace,"FindPartOnRay",true,payload)
					--spoofer:spooffunction(workspace,"findPartOnRay",true,payload)
					--spoofer:spooffunction(workspace,"Raycast",true,{targetpos-target.Character:GetModelCFrame().p,targetinst,targetinst.Material,targetpos,Ve3n(0,1,0)})]]
				end

				local Move = (((Ve2n(FinalMouse.X-Mouse.X,FinalMouse.Y-Mouse.Y-inset))/UserSettings():GetService("UserGameSettings").MouseSensitivity)/UserInputService.MouseDeltaSensitivity)*0.01
				Move = FinalMouse.Z<0 and Move*Config.aimspeed*DELTA*.6 or Move*Config.aimspeed --- I don't know why but 60*DeltaT works? Bruh: https://developer.roblox.com/en-us/articles/CFrame-Math-Operations

				local aimtxt = Config.MOUSESPOOF==true and "Aimbot: Targeting" or "Aimbot: Aiming"
				if target.Character:FindFirstChildOfClass("Humanoid") and (target.Character:FindFirstChildOfClass("Humanoid").Health==0 or target.Character:FindFirstChildOfClass("Humanoid"):GetState() == Enum.HumanoidStateType.Dead) then else 
					if Config.MOUSESPOOF==true then else 
						mousemoverel(Move.X,Move.Y) end AIMSTATUS.Text = aimtxt if Config.TRIGGERBOT==true and InGUI==false then 
						if math.abs(((FinalMouse.X-Mouse.X+FinalMouse.Y-Mouse.Y-inset)*.5)/FinalMouse.Z) <=math.abs((Resolution.Y*(Config.shootrad/Resolution.Y))/FinalMouse.Z) or Config.MOUSESPOOF then 
							spawn(function() if FIRING==false then mouse1press() AIMSTATUS2.Text = " ["..(1/Config.firedelay).." Clicks per second]" FIRING = true wait(Config.firedelay) mouse1release() AIMSTATUS2.Text = "" FIRING = false  end end) end end end     



			end
		else
			spoofer:unspoof(false,"UnitRay") 
			spoofer:unspoof(false,"Origin")
			spoofer:unspoof(false,"Target")
			spoofer:unspoof(false,"Hit")
            spoofer:unspoof(false,"target")
			spoofer:unspoof(false,"hit")
		end
    --[[for _,waypoint in pairs(Waypoints) do
  
    end]]
	end end)

--[[spawn(function() 
	while RunService.Heartbeat:Wait() do
		for _,N in pairs(SKELETONS) do
			if Config.Skeleton==true and Config.ESP == true and _~=nil and _.Character then
				for ll,NN in pairs(_.Character:GetDescendants()) do
					if NN.ClassName=="Motor6D" and SKELETONS[_][NN]==nil then SKELETONS[_][NN] = {one=Drawing.new("Line"),two=Drawing.new("Line")} else end
				end
            end
		end

	end
end)]]

    --[[
					local ScreenPosition, Vis = WorldToViewport(v.Instance.Position);
					local Color = v.Color;
					local OPos = Camera.CFrame:pointToObjectSpace(v.Instance.Position);
					
					if ScreenPosition.Z < 0 then
						local AT = math.atan2(OPos.Y, OPos.X) + math.pi;
						OPos = CFrame.Angles(0, 0, AT):vectorToWorldSpace((CFrame.Angles(0, math.rad(89.9), 0):vectorToWorldSpace(Ve3New(0, 0, -1))));
					end


]] -- This is some code yoinked from unnamed esp
---

function updatetoggles(config)
	ESPTOG:UpdateToggle("ESP",config.ESP)

	CROSSTOG:UpdateToggle("Crosshair",config.CROSS)

	XRAYTOG:UpdateToggle("X-Ray",config.XRAYB)

	FOVTOG:UpdateToggle("FOV",config.FOVSET)

	SPDT:UpdateToggle("Walkspeed",config.spd)

	FLYT:UpdateToggle("Flight",config.flight)

	VLOCKTOG:UpdateToggle("Vertical lock",config.verticallock)

	CLICKTPT:UpdateToggle("Click teleport",config.CLICKTPTOG)

	CLICKDELT:UpdateToggle("Click 'delete'",config.CLICKDELTOG)

	AIMBOTTOG:UpdateToggle("Aimbot",config.AIMBOT)

	triggerbottog:UpdateToggle("Triggerbot",config.TRIGGERBOT)

	mousespooftog:UpdateToggle("Silent Aim",config.MOUSESPOOF)

	AUTOWALKTOG:UpdateToggle("Auto walk",config.autowalk)

	MTOG:UpdateToggle("Disable death",config.IMMORTALITY)

	FELOOPPROTTOG:UpdateToggle("Anti feloop",config.AFELOOP)

	FPDST:UpdateToggle("Ignore destruction layer",config.FPDSD)

	FidgetSpinner:UpdateToggle("Fidget spinner",config.FIDGETSPINNER)

	FIDGETSPINNERNOCLIP:UpdateToggle("Fidget spinner noclip",config.fspinnernoclip)

	swmT:UpdateToggle("Air swim",config.SWIM)

	NOGRAV:UpdateToggle("No gravity",config.nograv)

	TEAMCOLOREDBOXt:UpdateToggle("Team coloured boxes",config.COLOREDBOXES)

	mn:UpdateToggle("Directional Arrows",config.ARW)

	mn2:UpdateToggle("Healthbar",config.HLT)

	HESP:UpdateToggle("Show heads",config.HESPT)

	TRACERS:UpdateToggle("Tracers",config.TRACERST)

	NTAG:UpdateToggle("Nametags",config.NTAGST)

	AUTOUPDXRAY:UpdateToggle("X-Ray autoupdate",config.XRAYBU)

	SUPRMN:UpdateToggle("Superman mockup",config.superman)

	FLIGHTNOGRAV:UpdateToggle("Anti flight drift",config.flightnograv)

	SPDDRFT:UpdateToggle("Anti slip",config.SPEEDDRIFT)

	ANTIANTITPt:UpdateToggle("Anti anti tp",config.antiantitp)

	TEAMCHECK:UpdateToggle("Team check",config.teamcheck)

	WALLCHECK:UpdateToggle("Wall check",config.wallcheck)

	HEADAIM:UpdateToggle("Headshot",config.headaim)

	RANDOMTARGETTOGGLE:UpdateToggle("Random target",config.RANDOMTGT)

	LOCKTARGETTOG:UpdateToggle("Lock target",config.LockTarget)

	BOCKS:UpdateToggle("Box",config.BOX)

	SKELLE:UpdateToggle("Skeleton",config.Skeleton)

	TOGGLENET:UpdateToggle("Force simradius",config.ForceSimR)

	ViewSimR:UpdateToggle("Simradius viewer",config.VisualizeSimR)

	ViewOwners:UpdateToggle("Physowner vision",config.VisualizeNet)

	RANKSPOOF:UpdateToggle("Spoof grouprank",config.SPOOFRANK)
	ASSETSPOOF:UpdateToggle("Spoof assets",config.SPOOFASSETS)
	DISABLEPURCHASES:UpdateToggle("Disable purchase prompts",config.NOLOADINGSCREEN)
	DISABLELOADINGSCREEN:UpdateToggle("Disable loading screen",config.NOPURCHASES)
end

local function loadconfig(c,global)
	if readfile then
		local r = global==false and Notifications.LRead or Notifications.Read
		game:GetService("StarterGui"):SetCore("SendNotification",r)
		if global==false then
			local zog = false
			if pcall(function() readfile("X-PL0XS.xplx") end) then else loadconfig(c) return end

			for _,N in pairs(game:GetService("HttpService"):JSONDecode(readfile("X-PL0XS.xplx"))) do 

				if tostring(_)==tostring(game.GameId) then
					zog = true
					for __,NN in pairs(N) do c[__]=NN end
					return 
				end

			end
			if not zog then
				loadconfig(c) end
		else
			if pcall(function() readfile("X-PL0X.xplx") end) then else return end
			for _,N in pairs(game:GetService("HttpService"):JSONDecode(readfile("X-PL0X.xplx"))) do c[_]=N end
		end
	end
end

local function writeconfig(c,global)


	if writefile then
		if global==false then 

			local test = pcall(function() readfile("X-PL0XS.xplx") end)
			if test==true then C = game:GetService("HttpService"):JSONDecode(readfile("X-PL0XS.xplx")) else C = {} end
			C[tostring(game.GameId)]=c
			--for _,N in pairs(C) do if tostring(_)==tostring(game.GameId) then for __,NN in pairs(N) do __=c[__] end end end
			--task.wait()
			writefile("X-PL0XS.xplx",game:GetService("HttpService"):JSONEncode(C))


		else
			writefile("X-PL0X.xplx",game:GetService("HttpService"):JSONEncode(c)) 
		end




		local w = global==false and Notifications.LOverwrite or Notifications.Overwrite
		game:GetService("StarterGui"):SetCore("SendNotification",w)
	end
end


local configtab = Settings:NewSection("Configuration")
configtab:NewButton("Overwrite global config", "game:GetService('HttpService'):JSONDecode(readfile('X-PL0X.xplx'))", function()
	writeconfig(Config)
end)

configtab:NewButton("Load global config", "writefile('X-PL0X.xplx',game:GetService('HttpService'):JSONEncode(Config))", function()
	loadconfig(Config)
	updatetoggles(Config)
end)

configtab:NewButton("Overwrite game config", "game:GetService('HttpService'):JSONDecode(readfile('X-PL0X.xplx'))", function()
	writeconfig(Config,false)
end)

configtab:NewButton("Load game config", "writefile('X-PL0XS.xplx',game:GetService('HttpService'):JSONEncode(Config))", function()
	loadconfig(Config,false)
	updatetoggles(Config)
end)

loadconfig(Config,false)
updatetoggles(Config)



physTPS = 0
spawn(function() --- Pathfinding function
end)
while wait(.5) do  --- this is for a more readable stat sheet
	PINGL:UpdateLabel("Ping: "..string.split(Ping:GetValueString()," ")[1].."ms")
	FPSL:UpdateLabel("FPS: "..math.roundtodecimal(1/DELTA,2)) --ez fps and rounding
	TPSL:UpdateLabel("Tasks per second: "..1/(StatsService.HeartbeatTimeMs/1000))
	PTPSL:UpdateLabel("Physics iterations per second: "..1/(StatsService.PhysicsStepTimeMs/1000))
	PhysL:UpdateLabel("Phys TPS: "..workspace:GetRealPhysicsFPS())
	PhysLR:UpdateLabel("True Phys TPS: "..tonumber(1/physTPS))
end

--GUI:MakeBox(500,500,200,100,true,0,Color3.new(255,255,255))
--[[local throwawaytable = {true,false} -- Gay ass table that i don't need
while true do
	local poop = GUI:MakeBox(math.random(0,Resolution.X),math.random(0,Resolution.Y),math.random(0,Resolution.X),math.random(0,Resolution.Y),throwawaytable[math.random(1,#throwawaytable)],math.random(0,10),Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))) -- generate random box with random properties
    wait(1)
    table.remove(GUIFRAMES,table.find(GUIFRAMES,poop))
	poop:Remove()
end]] --- Refraining from using drawing api for objects and shit. LITERALLY TOO MUCH TROUBLE FOR ITS WORTH.


]]