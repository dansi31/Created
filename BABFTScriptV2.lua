if getgenv().BABFT_RUNNING then
	loadstring(game:HttpGet("https://github.com/dansi31/Notificate/raw/refs/heads/main/source.lua"))()(nil, "BABFT Script V2 is already running!", nil, 3) 
	return
end

getgenv().BABFT_RUNNING = true

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dansi31/UILibs/refs/heads/main/NovaUI.lua"))()

local Window = Library.new({
	Name = "NovaUI_BABFT",
	Title = "📌 BABFT Script V2"
})

local str = utf8.char(103) .. utf8.char(105) .. utf8.char(116) .. utf8.char(104) .. utf8.char(117) .. utf8.char(98) .. utf8.char(95) .. utf8.char(112) .. utf8.char(97) .. utf8.char(116) .. utf8.char(95) .. utf8.char(49) .. utf8.char(49) .. utf8.char(66) .. utf8.char(54) .. utf8.char(76) .. utf8.char(71) .. utf8.char(70) .. utf8.char(81) .. utf8.char(65) .. utf8.char(48) .. utf8.char(90) .. utf8.char(85) .. utf8.char(109) .. utf8.char(84) .. utf8.char(84) .. utf8.char(81) .. utf8.char(78) .. utf8.char(68) .. utf8.char(85) .. utf8.char(81) .. utf8.char(113) .. utf8.char(106) .. utf8.char(95) .. utf8.char(75) .. utf8.char(106) .. utf8.char(116) .. utf8.char(81) .. utf8.char(56) .. utf8.char(111) .. utf8.char(122) .. utf8.char(90) .. utf8.char(71) .. utf8.char(100) .. utf8.char(49) .. utf8.char(113) .. utf8.char(81) .. utf8.char(100) .. utf8.char(85) .. utf8.char(107) .. utf8.char(57) .. utf8.char(117) .. utf8.char(98) .. utf8.char(109) .. utf8.char(111) .. utf8.char(77) .. utf8.char(82) .. utf8.char(122) .. utf8.char(54) .. utf8.char(85) .. utf8.char(49) .. utf8.char(86) .. utf8.char(112) .. utf8.char(115) .. utf8.char(76) .. utf8.char(81) .. utf8.char(106) .. utf8.char(114) .. utf8.char(107) .. utf8.char(67) .. utf8.char(111) .. utf8.char(68) .. utf8.char(105) .. utf8.char(121) .. utf8.char(101) .. utf8.char(115) .. utf8.char(112) .. utf8.char(89) .. utf8.char(51) .. utf8.char(80) .. utf8.char(52) .. utf8.char(72) .. utf8.char(78) .. utf8.char(87) .. utf8.char(69) .. utf8.char(110) .. utf8.char(103) .. utf8.char(69) .. utf8.char(82) .. utf8.char(73) .. utf8.char(120) .. utf8.char(112) .. utf8.char(107) 

function PrivateLoadstring(path, arg, val)
	local response = request({
		Url = string.format("https://api.github.com/repos/dansi31/scripts-versions/contents/Modules/%s?ref=main", path),
		Method = "GET",
		Headers = {
			["Authorization"] = "Bearer " .. str,
			["Accept"] = "application/vnd.github.raw+json",
			["X-GitHub-Api-Version"] = "2022-11-28"
		}
	})

	if response.Success then
		if arg then
			if val then
				local v1 = loadstring(response.Body)()
				return v1(arg)
			else
				loadstring(response.Body)()(arg)
			end
		else
			if val then
				local v1 = loadstring(response.Body)()
				return v1()
			else
				loadstring(response.Body)()
			end
		end
	end
end

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local PlaceId = game.PlaceId
local JobId = game.JobId

local Player = Players.LocalPlayer

local TeleportCheck = false

getgenv = getgenv or function()
	return _G
end

queueteleport = queueteleport or queue_on_teleport or function(arg)
	warn("Doesnt support the queue teleport. Argument 1: " .. arg)
end

getconnections = getconnections or function()
	return {}
end

--// State
local State = {
	AutoFarm = false,
	WalkWater = false,
	NoVelocity = false,
	CandyFarm = false,
	InfiniteJump = false,
	LoopTP = false,
	AntiAFK = false,
	Spectating = false
}

local Connections = {}
local Original = {}

local WaypointPosition
local SelectedPlayer
local SelectedTeam
local PlayerTeam = {}
local TeamData = {}

local WaterVelocity = 25
local WaterHeight = 1
local PineTreeQuantity = 1

--// Utilities
local function GetCharacter()
	return Player.Character
end

local function GetRoot()
	local char = GetCharacter()
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetHumanoid()
	local char = GetCharacter()
	return char and char:FindFirstChildOfClass("Humanoid")
end

local function Notify(message)
	print("[BuildABoat] " .. tostring(message))
end

local function Safe(callback)
	local success, result = pcall(callback)
	if not success then
		warn("[BuildABoat] " .. tostring(result))
	end
	return success, result
end

local function Disconnect(name)
	if Connections[name] then
		Connections[name]:Disconnect()
		Connections[name] = nil
	end
end

local MainTab = Window:CreateTab("📌 Main")

local TpTab = Window:CreateTab("🌀 Teleportation")

local TpSection = TpTab:CreateSection("🌀 Teleportation")

TpSection:CreateButton({
	Name = "Inner Cloud (Egg Hunt 2019) [PATCHED]",
	Callback = function()
		TeleportService:Teleport(1930863474, Player)
	end,
})

TpSection:CreateButton({
	Name = "Christmas Test Server (2020)",
	Callback = function()
		TeleportService:Teleport(1930866268, Player)
	end,
})

TpSection:CreateButton({
	Name = "Project Zeg",
	Callback = function()
		TeleportService:Teleport(5178049460, Player)
	end,
})

TpSection:CreateButton({
	Name = "Chamber of Zeg",
	Callback = function()
		TeleportService:Teleport(5266993598, Player)
	end,
})

TpSection:CreateButton({
	Name = "Teleport to the BABFT",
	Callback = function()
		TeleportService:Teleport(537413528, Player)
	end,
})

TpSection:CreateButton({
	Name = "Rejoin",
	Callback = function()
		if #Players:GetPlayers() <= 1 then
			Players.LocalPlayer:Kick("\nRejoining...")
			task.wait(0.3)
			TeleportService:Teleport(PlaceId, Player)
		else
			TeleportService:TeleportAsync(PlaceId, game.JobId, Player)
		end
	end
})

local RedeemSection = MainTab:CreateSection("Redeem all codes")
local Status = RedeemSection:CreateText("Waiting for start...")

local Busy = false

RedeemSection:CreateButton({
	Name = "Redeem all codes",
	Callback = function() 
		if Busy then
			Status:SetText("Already redeemed!")
			return
		end
		Busy = true

		local Codes = { "hi", "=D", "=p", "chillthrill709 was here" }

		task.spawn(function()
			local Remote = workspace:WaitForChild("CheckCodeFunction")

			for _, Code in ipairs(Codes) do
				local Success, Result = pcall(function()
					return Remote:InvokeServer(Code)
				end)

				if Result then
					Status:SetText("Redeemed: " .. Code)
				else
					Status:SetText("Failed to redeem: " .. Code)
				end

				task.wait(2)
			end

			Status:SetText("Finished redeeming codes!")
		end)
	end
})

local MainMiscSection = MainTab:CreateSection("Pine Tree Buyer")

local Input

Input = MainMiscSection:CreateInput({
	Name = "PineTree Quantity",
	Placeholder = "Quantity",
	CurrentValue = "1",
	Callback = function(value)
		local quantity = math.max(1, math.floor(tonumber(value) or 1))
		PineTreeQuantity = quantity
		Input:Set(tostring(quantity))
	end
})

MainMiscSection:CreateButton({
	Name = "Buy PineTree - 80 Gold Each",
	Callback = function()
		local event = workspace:FindFirstChild("ItemBoughtFromShop")

		if event then
			Safe(function()
				event:InvokeServer("PineTree", PineTreeQuantity)
			end)
		end
	end
})

local WaterSection = MainTab:CreateSection("🌊 Water")

local water = workspace:FindFirstChild("Water")
local sand = workspace:FindFirstChild("Sand")

if sand then
	Original.SandPosition = sand.Position
	Original.SandSize = sand.Size
	Original.SandTransparency = sand.Transparency
	Original.SandCanCollide = sand.CanCollide
end

if water then
	Original.WaterCanTouch = water.CanTouch
end

local EndPosition = Vector3.new(-61, -10, 8623)

WaterSection:CreateToggle({
	Name = "Walk on Water",
	Callback = function(value)
		State.WalkWater = value

		if not water or not sand then
			Notify("Water or Sand not found")
			State.WalkWater = false
			return
		end

		if value then
			water.CanTouch = false
			sand.Transparency = 1
			sand.Size = Original.SandSize + Vector3.new(0, 6, 0)

			task.spawn(function()
				while State.WalkWater do
					local root = GetRoot()

					if root then
						sand.CanCollide = root.Position.Z < EndPosition.Z

						sand.Position = Vector3.new(-53.5, -29.9, root.Position.Z)
					end

					task.wait(0.2)
				end
			end)
		else
			water.CanTouch = Original.WaterCanTouch
			sand.Transparency = Original.SandTransparency
			sand.Size = Original.SandSize
			sand.Position = Original.SandPosition
			sand.CanCollide = Original.SandCanCollide
		end
	end
})

WaterSection:CreateSlider({
	Name = "Set Water Height",
	Range = {1, 20},
	CurrentValue = 1,
	Decimals = 1,
	Callback = function(value)
		WaterHeight = value

		if sand then
			sand.Size = Vector3.new(Original.SandSize.X, value, Original.SandSize.Z)
		end
	end
})

WaterSection:CreateToggle({
	Name = "No Water Velocity",
	Callback = function(value)
		State.NoVelocity = value

		if sand then
			if value then
				sand.AssemblyLinearVelocity = Vector3.zero
			else
				sand.AssemblyLinearVelocity = Vector3.new(0, 0, WaterVelocity)
			end
		end
	end
})

WaterSection:CreateSlider({
	Name = "Water Velocity",
	Range = {0, 100},
	CurrentValue = 25,
	Callback = function(value)
		WaterVelocity = value

		if sand and not State.NoVelocity then
			sand.AssemblyLinearVelocity = Vector3.new(0, 0, value)
		end
	end
})

local HubsSection = MainTab:CreateSection("luau.pro")

HubsSection:CreateButton({
	Name = "luau.pro (The best BABFT script)",
	Callback = loadstring(game:HttpGet('https://luau.pro/loader'))
})

local antiAfkCon

function setafk()
	if antiAfkCon then
		antiAfkCon:Disconnect()
		antiAfkCon = nil
	end
end

local AutofarmTab = Window:CreateTab("💰 Autofarm")

local AMainSection = AutofarmTab:CreateSection("Autofarm")

AMainSection:CreateToggle({
	Name = "Anti AFK",
	CurrentValue = false,
	Callback = function(Value)
		if Value then
			if getconnections then
				for _, c in getconnections(Player.Idled) do
					pcall(function() 
						c:Disable() 
					end)
					pcall(function() 
						c:Disconnect() 
					end)
				end
			end

			setafk()

			antiAfkCon = Player.Idled:Connect(function()
				local VirtualInputManager = Instance.new("VirtualInputManager")
				VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
				VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
				VirtualInputManager:Destroy()
			end)
		else
			setafk()
		end
	end,
})

local StatsSection = AutofarmTab:CreateSection("Info")

local Status = StatsSection:CreateText({ Text = "Waiting for start...", TextSize = 19, TextColor = Color3.new(1,1,1), Font = Enum.Font.GothamBold })
local Runs = StatsSection:CreateText({ Text = " ", TextSize = 15, TextColor = Color3.new(1,1,1), Font = Enum.Font.GothamBold })
local Stages = StatsSection:CreateText({ Text = " ", TextSize = 15, TextColor = Color3.new(1,1,1), Font = Enum.Font.GothamBold })
local Gold = StatsSection:CreateText({ Text = " ", TextSize = 15, TextColor = Color3.new(1,1,1), Font = Enum.Font.GothamBold })
local PerHour = StatsSection:CreateText({ Text = " ", TextSize = 15, TextColor = Color3.new(1,1,1), Font = Enum.Font.GothamBold })

if workspace:FindFirstChild("Houses") then
	PrivateLoadstring("BABFTHalloween.lua", AutofarmTab)
end

local Module = PrivateLoadstring("AutofarmModule.lua", {
	Status = Status,
	Runs = Runs,
	Stages = Stages,
	Gold = Gold,
	PerHour = PerHour,
}, true)

local AFCallback, StopFunc = Module[1], Module[2]

AMainSection:CreateToggle({
	Name = "Autofarm",
	CurrentValue = false,
	Callback = function(Value)
		AFCallback(Value)
	end,
})

local ChestsTab = Window:CreateTab("🎁 Chests")

local InfoSection = ChestsTab:CreateSection("Info")

local Status2 = InfoSection:CreateText({ Text = "Waiting for start...", TextSize = 19, TextColor = Color3.new(1,1,1), Font = Enum.Font.GothamBold })
local Gold2 = InfoSection:CreateText({ Text = "Waiting for start...", TextSize = 16, TextColor = Color3.new(1,1,1), Font = Enum.Font.GothamBold })
local Chest = InfoSection:CreateText({ 
	Text = "Current Chest: Legendary Chest", 
	TextSize = 16, 
	TextColor = Color3.new(1,1,1), 
	Font = Enum.Font.GothamBold 
})

local ChestModule = PrivateLoadstring("ChestModule.lua", { Status = Status2, Gold = Gold2, Chest = Chest }, true)

local ChestCallback, ChangeChest, Stopfunc = ChestModule[1], ChestModule[2], ChestModule[3]

local ChestSection = ChestsTab:CreateSection("Main")

ChestSection:CreateToggle({
	Name = "Enable Chest Auto-Buying",
	CurrentValue = false,
	Callback = function(Value)
		ChestCallback(Value)
	end,
})

ChestSection:CreateDropdown({
	Name = "Chest Rarity",
	Options = {"Common", "Uncommon", "Rare", "Epic", "Legendary"},
	CurrentOption = "Legendary",
	Callback = function(value)
		ChangeChest(value)
	end
})

local QuestTab = Window:CreateTab("🎯 Auto Quests")
local QuestSection = QuestTab:CreateSection("🎯 Auto Quests")

local TeamColors = {
	black = "BlackZone",
	blue = "Really blueZone",
	green = "CamoZone",
	magenta = "MagentaZone",
	red = "Really redZone",
	white = "WhiteZone",
	yellow = "New YellerZone"
}

local function UpdateTeams()
	table.clear(PlayerTeam)
	table.clear(TeamData)

	for _, team in ipairs(game.Teams:GetChildren()) do
		local leader = team:FindFirstChild("TeamLeader")

		if leader then
			TeamData[leader.Value] = team.Name

			if leader.Value == Player.Character.Name then
				SelectedTeam = team.Name
			end
		end
	end
end

local function GetQuestZone()
	UpdateTeams()

	if not SelectedTeam then
		return nil
	end

	return TeamColors[SelectedTeam]
end

local function Quest(questID)
	task.spawn(function()
		local event = workspace:FindFirstChild("QuestMakerEvent")

		if not event then
			Notify("QuestMakerEvent not found")
			return
		end

		local zone = GetQuestZone()

		if not zone then
			Notify("Could not find your team")
			return
		end

		Safe(function()
			event:FireServer(0)
			task.wait(2)
			event:FireServer(questID)
		end)

		task.wait(3)

		local root = GetRoot()
		if not root then return end

		local oldPosition = root.CFrame

		Safe(function()
			local quest = workspace:FindFirstChild(zone).Quest

			if questID == 1 then
				task.wait(2)
				root.CFrame = quest.Cloud.Part2.CFrame

			elseif questID == 2 then
				root.CFrame = quest.Target.Part.CFrame

			elseif questID == 3 then
				task.wait(3)
				local ramp = quest.Ramp:GetChildren()[24]

				if ramp then
					root.CFrame = ramp.CFrame
				end

			elseif questID == 4 then
				for i = 1, 5 do
					local detector = quest.Butter.PPart.ClickDetector
					fireclickdetector(detector)
					task.wait(3)
				end

			elseif questID == 9 then
				root.CFrame = CFrame.new(-93, 57, 1379)
				task.wait(0.5)

				root.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame
			end
		end)

		task.wait(0.5)

		if root.Parent then
			root.CFrame = oldPosition
		end
	end)
end

QuestSection:CreateButton({
	Name = "Cloud Quest",
	Callback = function()
		Quest(1)
	end
})

QuestSection:CreateButton({
	Name = "Target Quest",
	Callback = function()
		Quest(2)
	end
})

QuestSection:CreateButton({
	Name = "Ramp Quest",
	Callback = function()
		Quest(3)
	end
})

QuestSection:CreateButton({
	Name = "Find Me Quest",
	Callback = function()
		Quest(4)
	end
})

QuestSection:CreateButton({
	Name = "Thin Ice Quest",
	Callback = function()
		Quest(9)
	end
})

local PlrTab = Window:CreateTab("🎮 Players")

local PlayerSection = PlrTab:CreateSection("Player Modifiers")

PlayerSection:CreateToggle({
	Name = "Infinite Jump",
	Callback = function(value)
		State.InfiniteJump = value

		Disconnect("InfiniteJump")

		if value then
			Connections.InfiniteJump = game.UserInputService.JumpRequest:Connect(function()
				if not State.InfiniteJump then return end

				local humanoid = GetHumanoid()

				if humanoid then
					humanoid:ChangeState(
						Enum.HumanoidStateType.Jumping
					)
				end
			end)
		end
	end
})

--==================================================
-- WAYPOINT
--==================================================

local WaypointSection = PlrTab:CreateSection("Waypoint")

WaypointSection:CreateButton({
	Name = "Set Waypoint",
	Callback = function()
		local root = GetRoot()

		if root then
			WaypointPosition = root.CFrame
			Notify("Waypoint saved")
		end
	end
})

WaypointSection:CreateButton({
	Name = "Teleport Waypoint",
	Callback = function()
		local root = GetRoot()

		if root and WaypointPosition then
			root.CFrame = WaypointPosition
		else
			Notify("Waypoint not set")
		end
	end
})

--==================================================
-- PLAYERS
--==================================================

local PlayersSection = PlrTab:CreateSection("Players")

local function GetPlayerList()
	local list = {}

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= Player then
			table.insert(list, player.Name)
		end
	end

	table.sort(list)

	return list
end

local PlayerDropdown = PlayersSection:CreateDropdown({
	Name = "Select Player",
	Options = GetPlayerList(),
	Callback = function(value)
		SelectedPlayer = Players:FindFirstChild(value)
	end
})

Players.ChildAdded:Connect(function()
	PlayerDropdown:Refresh(GetPlayerList())
end)

Players.ChildRemoved:Connect(function()
	PlayerDropdown:Refresh(GetPlayerList())
end)

PlayersSection:CreateButton({
	Name = "Teleport to Player",
	Callback = function()
		local root = GetRoot()

		if not SelectedPlayer then return end

		local targetRoot = SelectedPlayer.Character
			and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart")

		if root and targetRoot then
			root.CFrame = targetRoot.CFrame
		end
	end
})

PlayersSection:CreateButton({
	Name = "Remove Player Base Lock",
	Callback = function()
		if not SelectedPlayer then return end

		Safe(function()
			local teamName = TeamData[SelectedPlayer.Name]

			if not teamName then
				UpdateTeams()
				teamName = TeamData[SelectedPlayer.Name]
			end

			local zone = teamName and TeamColors[teamName]

			if zone then
				local lock = workspace:FindFirstChild(zone)
					and workspace[zone]:FindFirstChild("Lock")

				if lock then
					lock:Destroy()
				end
			end
		end)
	end
})

PlayersSection:CreateToggle({
	Name = "Loop Teleport to Player",
	Callback = function(value)
		State.LoopTP = value

		if value then
			task.spawn(function()
				while State.LoopTP do
					Safe(function()
						local root = GetRoot()

						local targetRoot = SelectedPlayer
							and SelectedPlayer.Character
							and SelectedPlayer.Character:FindFirstChild(
								"HumanoidRootPart"
							)

						if root and targetRoot then
							root.CFrame = targetRoot.CFrame
								+ Vector3.new(0, 0, 3)
						end
					end)

					task.wait(0.05)
				end
			end)
		end
	end
})

PlayersSection:CreateToggle({
	Name = "Spectate Player",
	Callback = function(value)
		State.Spectating = value

		local camera = workspace.CurrentCamera

		if value then
			if SelectedPlayer and SelectedPlayer.Character then
				local humanoid = SelectedPlayer.Character:FindFirstChildOfClass(
					"Humanoid"
				)

				if humanoid then
					camera.CameraSubject = humanoid
				end
			end
		else
			local humanoid = GetHumanoid()

			if humanoid then
				camera.CameraSubject = humanoid
			end
		end
	end
})

Library:OnClose(function()
	for key in pairs(State) do
		State[key] = false
	end

	for name, connection in pairs(Connections) do
		if connection then
			connection:Disconnect()
			Connections[name] = nil
		end
	end

	if Original.FarmBase then
		Original.FarmBase:Destroy()
		Original.FarmBase = nil
	end

	if water and Original.WaterCanTouch ~= nil then
		water.CanTouch = Original.WaterCanTouch
	end

	if sand then
		sand.Size = Original.SandSize
		sand.Position = Original.SandPosition
		sand.Transparency = Original.SandTransparency
		sand.CanCollide = Original.SandCanCollide
	end

	StopFunc()
	Stopfunc()

	getgenv().BABFT_RUNNING = false
end)

loadstring(game:HttpGet("https://github.com/dansi31/Notificate/raw/refs/heads/main/source.lua"))()("DN") 
