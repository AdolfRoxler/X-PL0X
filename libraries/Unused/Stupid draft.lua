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

--- Crosshair objects

local CR1 = Drawing.new("Line")
local CR2 = Drawing.new("Line")
local AIMSTATUS = Drawing.new("Text")

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
   PlayerList.RenderObjects = {}
	for _,N in pairs(Players:GetPlayers()) do 
		if N and N~=User then 
			PlayerList.RenderObjects[N] = PlayerList.RenderObjects[N] or {}
			PlayerList.CheapChams = PlayerList.CheapChams or Instance.new("Highlight")
			PlayerList.Box = PlayerList.Box or Drawing.new("Quad")
			PlayerList.Skeleton = PlayerList.Skeleton or {}
			PlayerList.Circle = PlayerList.Circle or Drawing.new("Circle")
		else
			if PlayerList.RenderObjects[N] then 
				for _,N in pairs(PlayerList.RenderObjects[N]) do
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