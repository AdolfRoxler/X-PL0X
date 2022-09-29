local API = {}
--- For some reason this make shit run faster, i dunno ima just copy icewolf. Update 2: lol nigga even lua docs say indexing lua var globally in local once makes shit run faster! lol!
API.Camera = workspace.CurrentCamera;
API.RunService = game:GetService("RunService");
API.Players = game:GetService("Players");
API.PLAYERLIST = Players:GetPlayers()
API.User = Players.LocalPlayer
API.GuiService = game:GetService("GuiService");
API.Ve3n = Vector3.new;
API.Ve2n = Vector2.new;
API.CFN = CFrame.new;
API.WTVP = API.Camera.WorldToViewportPoint;
API.WorldToViewport = function(...) return WTVP(API.Camera, ...) end;
API.Resolution = Ve2n(Mouse.ViewSizeX,Mouse.ViewSizeY)

---- Crosshair n sheeit

API.CR1 = Drawing.new("Line")
API.CR2 = Drawing.new("Line")
API.AIMSTATUS = Drawing.new("Text")
API.AIMSTATUS2 = Drawing.new("Text")
API.PATHSTATUS = Drawing.new("Text")
API.DELTA = 1

--- Debounce and raycast

API.FIRING = false
API.DeletedInstances = {}
API.TPRaycastAPI.Config = RaycastParams.new()
TPRaycastConfig.FilterType = Enum.RaycastFilterType.Blacklist
TPRaycastConfig.IgnoreWater = true

--- Debounces below
API.MAPRESTORING = false
API.teleportingtowardspoint = false

--- Preloaded default config
API.Config = {}
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
Config.FOV = 70
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

function API:refreshplayers()
	REFRESHING = true
	API.RunService.RenderStepped:Wait()
	for _,L in pairs(PLAYERLIST) do 
		for l,n in pairs(SKELETONS[_]) do
			n.one:Remove()
			n.two:Remove()
			SKELETONS[_][l]=nil
		end
		L.Tracer:Remove() L.Head:Remove() L.Nametag:Remove() L.Healthbar[1]:Remove() L.Healthbar[2]:Remove() L.Healthbar[3]:Remove() L.Box:Remove() L.Arrow[1]:Remove() L.Arrow[2]:Remove() L.Arrow[3]:Remove() L.Arrow[4]:Remove() L.Arrow[5]:Remove() L.Arrow[6]:Remove() L.Arrow[7]:Remove() L.Arrow[8]:Remove() L.Arrow[9]:Remove() L.Arrow[10]:Remove() PLAYERLIST[_]=nil end
		API.PLAYERLIST = Players:GetPlayers()
	for _,L in pairs(PlayerList) do 
		if L and L~=User then
			SKELETONS[L]={}
			PLAYERLIST[L]={L,Tracer=Drawing.new("Line"),Head=Drawing.new("Circle"),Nametag=Drawing.new("Text"),Box=Drawing.new("Quad"),Healthbar={Drawing.new("Quad"),Drawing.new("Quad"),Drawing.new("Quad")},Arrow={Drawing.new("Quad"),Drawing.new("Triangle"),Drawing.new("Quad"),Drawing.new("Triangle"),Drawing.new("Quad"),Drawing.new("Quad"),Drawing.new("Quad"),Drawing.new("Quad"),Drawing.new("Quad"),Drawing.new("Quad")}} 
		end
	end
	REFRESHING = false
end

function API:randomplayer()
	local temptable = Players:GetPlayers()
	table.remove(temptable,table.find(temptable,User))
	return temptable[math.random(1,#temptable)]
end

function API:MatchName(Player)  ----copypasted from my other mf project, just modified it right now, it should autocomplete.... faster.
	local tab = {}
	for _,player in pairs(Players:GetPlayers()) do
		if tostring(player.DisplayName):lower():find(tostring(Player):lower())==1 or tostring(player.Name):lower():find(tostring(Player):lower())==1 then
			table.insert(tab,player)
		end
	end
	return tab
end

function API:GetBoundingBox(model, recursive, orientation, mustcollide) ----- copypasted code xdflol
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

function API:changestatus(h) --- I guess this is how I'll set up humanoid status changes from now on
	if API.Config.IMMORTALITY==true and h then h:SetStateEnabled(15,false) end --my dumb ass thought this was somewhere else
	if API.Config.SWIM==true and h then h:ChangeState(4) end
	if API.Config.flight==true and h then h:ChangeState(5) end
	if API.Config.FIDGETSPINNER==true and h then h:ChangeState(8) end
end

function API:XRAY(int)
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

function API:UnequipEverythin(l,h)
	if (API.Config.AFELOOP or API.Config.FIDGETSPINNER) and l and l:IsA("Tool") and h then
		RunService.Stepped:Wait()
		UserHum:UnequipTools()
	end
end

function API:setsimulationradius(v)
	local v = tonumber(v) or 1000
	sethiddenproperty(User, "SimulationRadius", v) 
	sethiddenproperty(User, "MaximumSimulationRadius", v) 
	User.ReplicationFocus = workspace
end

function API:findpath(From,To,Path,overwritemaintable)
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

function API:mousefunctions()
	if API.Config.CLICKTP==true and Mouse and (FIRING==false or API.Config.MOUSESPOOF==true) then
		if teleportingtowardspoint then return end
		if UserChar then
			teleportingtowardspoint = true
			local n,s = GetBoundingBox(UserChar,false)
			TPRaycastConfig.FilterDescendantsInstances={API.Camera,UserChar}
			local raycast = workspace:Raycast(API.Camera.CFrame.p,Mouse.UnitRay.Direction*5000,TPRaycastConfig)
			if raycast and raycast.Instance and raycast.Position then else UserChar:PivotTo(CFN(Mouse.Hit.p)*UserChar:GetModelCFrame().Rotation) teleportingtowardspoint = false return end
			if UserHum then UserHum.Sit = false end
			RunService.Heartbeat:Wait()
			if hr and raycast.Instance and raycast.Instance:IsA("BasePart") then hr.AssemblyLinearVelocity = raycast.Instance.AssemblyLinearVelocity end
		end
		teleportingtowardspoint = false
	end
	if API.Config.CLICKDEL==true and Mouse and (FIRING==false or API.Config.MOUSESPOOF==true) then
		local l = Mouse.Target:FindFirstAncestorWhichIsA("Model")
		if Mouse.Target then if l and l:FindFirstChildOfClass("Humanoid") or Mouse.Target:FindFirstAncestorWhichIsA("Camera") or table.find(DeletedInstances,Mouse.Target) then else
				DeletedInstances[Mouse.Target]={Mouse.Target,Mouse.Target.Size}
				Mouse.Target.Size = Ve3n(0,0,0)
			end
		end
	end
end

--[[				if SKELETONS[_] then
					for s,S in pairs(SKELETONS[_]) do
						local one = S.one
						local two = S.two
                        one.Visible = false
                        two.Visible = false 
						if one and two and Config.Skeleton==true then
							if (not _:IsAncestorOf(Camera.CameraSubject)) and Config.Skeleton == true and Config.ESP == true and s~=nil and s.Parent~=nil and s.Part0 and s.Part1 and s.Part0:IsDescendantOf(_.Character) and s.Part1:IsDescendantOf(_.Character) then else one:Remove() two:Remove() SKELETONS[_][s]=nil continue end
							local Pivot = s.Part0.CFrame*s.C0
							local pivot2d = (s.Part0.CFrame.p-Camera.CFrame.p).Magnitude>=0 and WorldToViewport(Pivot.p) or math:InverseWorldToViewportPoint(Pivot.p)
							local root = (s.Part0.CFrame.p-Camera.CFrame.p).Magnitude>=0 and WorldToViewport(s.Part0.CFrame.p) or math:InverseWorldToViewportPoint(s.Part0.CFrame.p)
							local tip = (s.Part0.CFrame.p-Camera.CFrame.p).Magnitude>=0 and WorldToViewport(s.Part1.CFrame.p) or math:InverseWorldToViewportPoint(s.Part1.CFrame.p)
							local m = math.clamp((Pivot.p-Camera.CFrame.p).Magnitude-1,0,1)
							local c = c:Lerp(Color3.new(1,1,1),.25)
							local vis = pivot2d.Z>0 and root.Z>0 and tip.Z>0 and s and s.Part0 and s.Part1 and Config.ESP or false
							local pivto = Ve2n(pivot2d.X,pivot2d.Y)
							one.ZIndex = boxzindex+5
							two.ZIndex = boxzindex+5

							one.Visible = vis
							two.Visible = vis

							one.Thickness = standard2
							one.Color = c
							one.Transparency = m

							two.Thickness = standard2
							two.Color = c
							two.Transparency = m

							one.From = Ve2n(root.X,root.Y)
							one.To = pivto

							two.From = Ve2n(tip.X,tip.Y)
							two.To = pivto


						else if one then one:Remove() end if two then two:Remove() end SKELETONS[_][s]=nil end
					end
				end   ]]

function API:drawvisuals(Delta)
	Resolution = Ve2n(Mouse.ViewSizeX,Mouse.ViewSizeY)
	DELTA = Delta
	if API.Camera and API.Config.FOVSET==true then API.Camera.FieldOfView = API.Config.FOV end

	CR1.Visible = API.Config.CROSS
	CR2.Visible = API.Config.CROSS
	local maths = (Resolution.Y*(math.abs(API.Config.CROSSS)/1000))
	CR1.From = Vector2.new(Mouse.X-maths,Mouse.Y+inset)
	CR1.To = Vector2.new(Mouse.X+maths,Mouse.Y+inset)
	CR1.Thickness = (Resolution.Y*.0025)
	CR2.From = Vector2.new(Mouse.X,Mouse.Y+inset+maths)
	CR2.To = Vector2.new(Mouse.X,Mouse.Y+inset-maths)
	CR2.Thickness = (Resolution.Y*.0025)
	CR1.Color = API.Config.CROSSC and API.Config.CROSSC[1] and API.Config.CROSSC[2] and API.Config.CROSSC[3] and Color3.new(API.Config.CROSSC[1],API.Config.CROSSC[2],API.Config.CROSSC[3]) or Color3.new(1,1,1)
	CR2.Color = API.Config.CROSSC and API.Config.CROSSC[1] and API.Config.CROSSC[2] and API.Config.CROSSC[3] and Color3.new(API.Config.CROSSC[1],API.Config.CROSSC[2],API.Config.CROSSC[3]) or Color3.new(1,1,1)
	CR1.ZIndex = highvalue
	CR2.ZIndex = highvalue
	if API.Config.CROSSTRAN then CR1.Transparency = API.Config.CROSSTRAN/100 else CR1.Transparency = 1 end
	CR2.Transparency = CR1.Transparency

	AIMSTATUS.Visible= API.Config.AIMBOT and GuiService.MenuIsOpen
	AIMSTATUS.Font = API.Config.FONT
	AIMSTATUS.Color = API.Config.CROSS and CR1.Color:Lerp(Color3.new(1,1,1),.5) or Color3.new(1,1,1)
	AIMSTATUS.OutlineColor = Color3.new(0,0,0)
	AIMSTATUS.Transparency = API.Config.CROSS==true and API.Config.CROSSTRAN and API.Config.CROSSTRAN/100 or 0
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


	API.Camera = workspace.CurrentCamera;
	local FovDelta = (70/API.Camera.FieldOfView)
	local s1 = (0.068*Resolution.Y)
	local s2 = (0.034*Resolution.Y)
	local magic = 70/120
	for _,N in pairs(PLAYERLIST) do
		local Plr = _
		local Box = N.Box
		local Arrow = N.Arrow
		local Healthbar = N.Healthbar
		local Char = Plr.Character
		local HeadE = N.Head
		local NameTag = N.Nametag
		local Tracer = N.Tracer
		if Char and Box and Arrow[10] and Healthbar[3] and NameTag and HeadE and (Char:GetModelCFrame().p-API.Camera.CFrame.p).Magnitude<=25000 then
			local Head = Char:FindFirstChild("Head")
			local Hum = Char:FindFirstChildOfClass("Humanoid")
			local Pos,Size = GetBoundingBox(Char,false,Char:GetModelCFrame())
			local teamcolor = API.Config.COLOREDBOXES and Plr.TeamColor.Color:Lerp(Color3.new(1,1,1),.5) or Color3.new(1,1,1)
			local boxzindex = lowvalue+5
			local standard = ((s1/(API.Camera.CFrame.p-Pos.p).Magnitude))*FovDelta 
			local standard2 = ((s2/(API.Camera.CFrame.p-Pos.p).Magnitude))*FovDelta 
			local health = Hum and math.clamp((Hum.Health/Hum.MaxHealth),0,1) or 0
			local c = Color3.fromHSV(health*.3,0.8,1)
			local sx15 = -Size.X/1.5   
			local sx8 = Size.X*.125
			local sx2 = Size.X*.5
			local sx4 = Size.X*.25
			local sy2 = -Size.Y*.5
			local sx5 = Size.X*.2    

			local V1,V2,V3,V4,UR,UL,DL,DR = nil
			local V19,V20,V21,V22,BUR,BUL,BDL,BDR = nil
			local UR,UL,DL,DR,L,R,U,UR2,UL2,DL2,DR2,L2,U2,R2,V5,V6,V7,V8,V9,V10,V11,V12,V13,V14,V15,V16,V17,V18 = nil
			local HPV,HPV2 = nil
			local NT,NT2 = nil

			if _:IsAncestorOf(API.Camera.CameraSubject) then NameTag.Visible = false Tracer.Visible = false HeadE.Visible = false Box.Visible = false Arrow[1].Visible = false Arrow[2].Visible = false Arrow[3].Visible = false Arrow[4].Visible = false Arrow[5].Visible = false Arrow[6].Visible = false Arrow[7].Visible = false Arrow[8].Visible = false Arrow[9].Visible = false Arrow[10].Visible = false Healthbar[1].Visible = false Healthbar[2].Visible = false Healthbar[3].Visible = false continue end


			if API.Config.BOX == true then
				UR,V1 = WorldToViewport(Pos*(Ve3n(Size.X,Size.Y,0)*.5))
				UL,V2 = WorldToViewport(Pos*(Ve3n(-Size.X,Size.Y,0)*.5))
				DL,V3 = WorldToViewport(Pos*(Ve3n(-Size.X,-Size.Y,0)*.5))
				DR,V4 = WorldToViewport(Pos*(Ve3n(Size.X,-Size.Y,0)*.5))

				Box.PointA = Ve2n(UR.X,UR.Y)
				Box.PointB = Ve2n(UL.X,UL.Y)
				Box.PointC = Ve2n(DL.X,DL.Y)
				Box.PointD = Ve2n(DR.X,DR.Y)

				Box.Filled = false
				Box.Transparency = 1
				Box.Thickness = standard
				Box.Color = teamcolor
				Box.ZIndex = boxzindex 
			end

			if API.Config.HLT==true then
				BUR,V19 = WorldToViewport(Pos*(Ve3n(sx15,-sy2,0)))
				BUL,V20 = WorldToViewport(Pos*(Ve3n(-sx2,-sy2,0)))
				BDL,V21 = WorldToViewport(Pos*(Ve3n(-sx2,sy2,0)))
				BDR,V22 = WorldToViewport(Pos*(Ve3n(sx15,sy2,0)))

				local H1,H2 = 0,0

				if Hum then
					local barh = sy2+(Size.Y)*health
					H1 = WorldToViewport(Pos*(Ve3n(sx15,barh,0)))
					H2 = WorldToViewport(Pos*(Ve3n(-sx2,barh,0)))
					Healthbar[2].Color = c
				else
					H1 = BDL
					H2 = BDR
				end

				Healthbar[1].PointA = Ve2n(BUR.X,BUR.Y)
				Healthbar[1].PointB = Ve2n(BUL.X,BUL.Y)
				Healthbar[1].PointC = Ve2n(BDL.X,BDL.Y)
				Healthbar[1].PointD = Ve2n(BDR.X,BDR.Y)

				Healthbar[2].PointA = Ve2n(H1.X,H1.Y)
				Healthbar[2].PointB = Ve2n(H2.X,H2.Y)
				Healthbar[2].PointC = Ve2n(BDL.X,BDL.Y)
				Healthbar[2].PointD = Ve2n(BDR.X,BDR.Y)

				Healthbar[3].PointA = Ve2n(BUR.X,BUR.Y)
				Healthbar[3].PointB = Ve2n(BUL.X,BUL.Y)
				Healthbar[3].PointC = Ve2n(BDL.X,BDL.Y)
				Healthbar[3].PointD = Ve2n(BDR.X,BDR.Y)


				Healthbar[1].Filled = false
				Healthbar[1].ZIndex = boxzindex-2
				Healthbar[1].Color = Box.Color
				Healthbar[1].Thickness = standard--Box.Thickness
				local h,s,v = Healthbar[2].Color:ToHSV()
				Healthbar[3].Filled = true
				Healthbar[3].ZIndex = Healthbar[1].ZIndex-2
				Healthbar[3].Color = Color3.fromHSV(h,s,.2)
				Healthbar[3].Thickness = standard--Box.Thickness

				Healthbar[2].Filled = true
				Healthbar[2].ZIndex = Healthbar[1].ZIndex-1
				Healthbar[2].Thickness = 0
			end

			if API.Config.ARW==true then
				UR,V5 = WorldToViewport(Pos*(Ve3n(sx8,Size.Y,0)))
				UL,V6 = WorldToViewport(Pos*(Ve3n(-sx8,Size.Y,0)))
				DL,V7 = WorldToViewport(Pos*(Ve3n(-sx8,Size.Y,sx2)))
				DR,V8 = WorldToViewport(Pos*(Ve3n(sx8,Size.Y,sx2)))

				Arrow[1].PointA = Ve2n(UR.X,UR.Y)
				Arrow[1].PointB = Ve2n(UL.X,UL.Y)
				Arrow[1].PointC = Ve2n(DL.X,DL.Y)
				Arrow[1].PointD = Ve2n(DR.X,DR.Y)

				L,V9 = WorldToViewport(Pos*(Ve3n(-sx4,Size.Y,0)))
				R,V10 = WorldToViewport(Pos*(Ve3n(sx4,Size.Y,0)))
				U,V11 = WorldToViewport(Pos*(Ve3n(0,Size.Y,-sx2)))

				Arrow[2].PointA = Ve2n(U.X,U.Y)
				Arrow[2].PointB = Ve2n(L.X,L.Y)
				Arrow[2].PointC = Ve2n(R.X,R.Y)

				UR2,V12 = WorldToViewport(Pos*(Ve3n(sx8,Size.Y+sx5,0)))
				UL2,V13 = WorldToViewport(Pos*(Ve3n(-sx8,Size.Y+sx5,0)))
				DL2,V14 = WorldToViewport(Pos*(Ve3n(-sx8,Size.Y+sx5,sx2)))
				DR2,V15 = WorldToViewport(Pos*(Ve3n(sx8,Size.Y+sx5,sx2)))

				Arrow[3].PointA = Ve2n(UR2.X,UR2.Y)
				Arrow[3].PointB = Ve2n(UL2.X,UL2.Y)
				Arrow[3].PointC = Ve2n(DL2.X,DL2.Y)
				Arrow[3].PointD = Ve2n(DR2.X,DR2.Y)

				L2,V16 = WorldToViewport(Pos*(Ve3n(-sx4,Size.Y+sx5,0)))
				R2,V17 = WorldToViewport(Pos*(Ve3n(sx4,Size.Y+sx5,0)))
				U2,V18 = WorldToViewport(Pos*(Ve3n(0,Size.Y+sx5,-sx2)))

				Arrow[4].PointA = Ve2n(U2.X,U2.Y)
				Arrow[4].PointB = Ve2n(L2.X,L2.Y)
				Arrow[4].PointC = Ve2n(R2.X,R2.Y)


				Arrow[1].Filled = true
				Arrow[2].Filled = true
				Arrow[3].Filled = true
				Arrow[4].Filled = true
				Arrow[5].Filled = true
				Arrow[6].Filled = true
				Arrow[7].Filled = true
				Arrow[8].Filled = true
				Arrow[9].Filled = true
				Arrow[10].Filled = true

				local q = 0.25
				local azindex = boxzindex+3
				Arrow[1].Transparency = q
				Arrow[2].Transparency = q
				Arrow[3].Transparency = q
				Arrow[4].Transparency = q
				Arrow[5].Transparency = q
				Arrow[6].Transparency = q
				Arrow[7].Transparency = q
				Arrow[8].Transparency = q
				Arrow[9].Transparency = q
				Arrow[10].Transparency = q

				Arrow[1].Thickness = 0 
				Arrow[1].Color = teamcolor
				Arrow[1].ZIndex = azindex

				Arrow[2].Thickness = 0
				Arrow[2].Color = teamcolor
				Arrow[2].ZIndex = azindex

				Arrow[3].Thickness = 0
				Arrow[3].Color = teamcolor
				Arrow[3].ZIndex = azindex

				Arrow[4].Thickness = 0
				Arrow[4].Color = teamcolor
				Arrow[4].ZIndex = azindex

				Arrow[5].Thickness = 0
				Arrow[5].Color = teamcolor
				Arrow[5].ZIndex = azindex
				Arrow[5].PointA = Ve2n(U2.X,U2.Y)
				Arrow[5].PointB = Ve2n(R2.X,R2.Y)
				Arrow[5].PointC = Ve2n(R.X,R.Y)
				Arrow[5].PointD = Ve2n(U.X,U.Y)

				Arrow[6].Thickness = 0
				Arrow[6].Color = teamcolor
				Arrow[6].ZIndex = azindex
				Arrow[6].PointA = Ve2n(U2.X,U2.Y)
				Arrow[6].PointB = Ve2n(L2.X,L2.Y)
				Arrow[6].PointC = Ve2n(L.X,L.Y)
				Arrow[6].PointD = Ve2n(U.X,U.Y)

				Arrow[7].Thickness = 0
				Arrow[7].Color = teamcolor
				Arrow[7].ZIndex = azindex
				Arrow[7].PointA = Ve2n(R2.X,R2.Y)
				Arrow[7].PointB = Ve2n(L2.X,L2.Y)
				Arrow[7].PointC = Ve2n(L.X,L.Y)
				Arrow[7].PointD = Ve2n(R.X,R.Y)

				Arrow[8].Thickness = 0
				Arrow[8].Color = teamcolor
				Arrow[8].ZIndex = azindex
				Arrow[8].PointA = Ve2n(UR2.X,UR2.Y)
				Arrow[8].PointB = Ve2n(DR2.X,DR2.Y)
				Arrow[8].PointC = Ve2n(DR.X,DR.Y)
				Arrow[8].PointD = Ve2n(UR.X,UR.Y)

				Arrow[9].Thickness = 0
				Arrow[9].Color = teamcolor
				Arrow[9].ZIndex = azindex
				Arrow[9].PointA = Ve2n(UL2.X,UL2.Y)
				Arrow[9].PointB = Ve2n(DL2.X,DL2.Y)
				Arrow[9].PointC = Ve2n(DL.X,DL.Y)
				Arrow[9].PointD = Ve2n(UL.X,UL.Y)

				Arrow[10].Thickness = 0
				Arrow[10].Color = teamcolor
				Arrow[10].ZIndex = azindex
				Arrow[10].PointA = Ve2n(DR2.X,DR2.Y)
				Arrow[10].PointB = Ve2n(DL2.X,DL2.Y)
				Arrow[10].PointC = Ve2n(DL.X,DL.Y)
				Arrow[10].PointD = Ve2n(DR.X,DR.Y)
			end

			if Head and Head:IsA("BasePart") then
				local avghead = (Head.Size.X+Head.Size.Y+Head.Size.Z)/3
				HPV,HPV2 = WorldToViewport(Head.CFrame.p)
				HeadE.Position = Ve2n(HPV.X,HPV.Y)
				local m = (((Resolution.Y*0.4*avghead)/HPV.Z))*FovDelta 
				HeadE.Radius = m
				HeadE.Thickness = m*0.5
				HeadE.Color = teamcolor
				HeadE.Transparency = math.clamp((Head.CFrame.p-API.Camera.CFrame.p).Magnitude-1,0,1)
				HeadE.ZIndex = lowvalue+1
			end

			if API.Config.NTAGST==true then
				NT,NT2 = WorldToViewport(Pos*Ve3n(0,(Size.Y*API.Config.NTAGSV/100),0)) --workspace.CurrentCamera.CFrame.p-Char:GetModelCFrame().p).Magnitude
				NameTag.Size = math.clamp((Resolution.Y*(API.Config.NTAGV/500))*(magic),24,math.huge) --24
				NameTag.Position = Ve2n(NT.X,NT.Y-NameTag.TextBounds.Y*.5)
				NameTag.Text = Plr.Team and Plr.DisplayName.."/"..Plr.Name.."  ["..tostring(Plr.Team).."]" or Plr.DisplayName.."/"..Plr.Name
				NameTag.Center = true
				NameTag.Color = teamcolor
				NameTag.Outline = true
				NameTag.OutlineColor = Color3.new(0,0,0)
				NameTag.Font = API.Config.FONT end

			if API.Config.TRACERST==true then
				local TT = WorldToViewport(Pos*Ve3n(0,sy2,0))
				Tracer.Thickness = (Resolution.Y*0.0016)
				Tracer.Color = teamcolor
				Tracer.Transparency = math.clamp(1-(Pos.p-API.Camera.CFrame.p).Magnitude/423,.32,1)
				Tracer.From = Ve2n(Resolution.X*.5,Resolution.Y*0.95)
				Tracer.ZIndex = boxzindex+4 if TT.Z<0 then TT=math:InverseWorldToViewportPoint(Pos*Ve3n(0,sy2,0)) end Tracer.To = Ve2n(TT.X,TT.Y) 
            end

			if API.Config.TRACERST==true then Tracer.Visible = API.Config.ESP else Tracer.Visible = false end
			if NT2 and API.Config.NTAGST==true then NameTag.Visible = API.Config.ESP else NameTag.Visible = false end
			if HPV2 and API.Config.HESPT==true then HeadE.Visible = API.Config.ESP else HeadE.Visible = false end
			if API.Config.ARW==true and V5 and V6 and V7 and V8 and V9 and V10 and V11 and V12 and V13 and V14 and V15 and V16 and V17 and V18 then Arrow[1].Visible = API.Config.ESP Arrow[2].Visible = API.Config.ESP Arrow[3].Visible = API.Config.ESP Arrow[4].Visible = API.Config.ESP Arrow[5].Visible = API.Config.ESP Arrow[6].Visible = API.Config.ESP Arrow[7].Visible = API.Config.ESP Arrow[8].Visible = API.Config.ESP Arrow[9].Visible = API.Config.ESP Arrow[10].Visible = API.Config.ESP else Arrow[1].Visible = false Arrow[2].Visible = false Arrow[3].Visible = false Arrow[4].Visible = false Arrow[5].Visible = false Arrow[6].Visible = false Arrow[7].Visible = false Arrow[8].Visible = false Arrow[9].Visible = false Arrow[10].Visible = false end
			if API.Config.BOX==true and V1 and V2 and V3 and V4 then Box.Visible = API.Config.ESP else Box.Visible = false end
			if API.Config.HLT==true and V19 and V20 and V21 and V22 then Healthbar[1].Visible = API.Config.ESP Healthbar[2].Visible = API.Config.ESP Healthbar[3].Visible = API.Config.ESP else Healthbar[1].Visible = false Healthbar[2].Visible = false Healthbar[3].Visible = false end
		else NameTag.Visible = false Tracer.Visible = false HeadE.Visible = false Box.Visible = false Arrow[1].Visible = false Arrow[2].Visible = false Arrow[3].Visible = false Arrow[4].Visible = false Arrow[5].Visible = false Arrow[6].Visible = false Arrow[7].Visible = false Arrow[8].Visible = false Arrow[9].Visible = false Arrow[10].Visible = false Healthbar[1].Visible = false Healthbar[2].Visible = false Healthbar[3].Visible = false end
	end
end