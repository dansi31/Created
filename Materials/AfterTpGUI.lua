local GUI = Instance.new("ScreenGui", gethui())
local Frame = Instance.new("Frame", GUI)
local UICorner = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local UIStroke = Instance.new("UIStroke")
local UICorner_1 = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")
local Keep = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local UIListLayout_1 = Instance.new("UIListLayout")
local Inject = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local UIListLayout_2 = Instance.new("UIListLayout")
local TextButton = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local UIListLayout_3 = Instance.new("UIListLayout")

Frame.AnchorPoint = Vector2.new(0.500, 0.500)
Frame.BackgroundColor3 = Color3.new(0.118, 0.118, 0.118)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 350, 0, 250)
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame
TextLabel.FontFace = Font.new("rbxasset://fonts/families/Michroma.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel.Text = "What do you wanna do rn?"
TextLabel.TextColor3 = Color3.new(1.000, 1.000, 1.000)
TextLabel.TextSize = 26
TextLabel.BackgroundColor3 = Color3.new(1.000, 1.000, 1.000)
TextLabel.BackgroundTransparency = 0.9
TextLabel.Size = UDim2.new(0, 350, 0, 50)
TextLabel.Parent = Frame
UIStroke.Parent = TextLabel
UICorner_1.CornerRadius = UDim.new(0, 15)
UICorner_1.Parent = TextLabel
UIListLayout.Padding = UDim.new(0, 15)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Frame
Keep.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Keep.Text = "Keep server-hopping"
Keep.TextColor3 = Color3.new(1.000, 1.000, 1.000)
Keep.TextSize = 31
Keep.BackgroundColor3 = Color3.new(1.000, 1.000, 1.000)
Keep.BackgroundTransparency = 0.95
Keep.Position = UDim2.new(0, 0, 0.34, 0)
Keep.Size = UDim2.new(0, 325, 0, 50)
Keep.Parent = Frame
UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Keep
UIListLayout_1.Padding = UDim.new(0, 35)
UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_1.Parent = Keep
Inject.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Inject.Text = "Execute the Universal Script"
Inject.TextColor3 = Color3.new(1.000, 1.000, 1.000)
Inject.TextSize = 22
Inject.BackgroundColor3 = Color3.new(1.000, 1.000, 1.000)
Inject.BackgroundTransparency = 0.95
Inject.Position = UDim2.new(0, 0, 0.34, 0)
Inject.Size = UDim2.new(0, 325, 0, 50)
Inject.Parent = Frame
UICorner_3.CornerRadius = UDim.new(0, 15)
UICorner_3.Parent = Inject
UIListLayout_2.Padding = UDim.new(0, 35)
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Parent = Inject
TextButton.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextButton.Text = "Close this tab"
TextButton.TextColor3 = Color3.new(1.000, 1.000, 1.000)
TextButton.TextSize = 35
TextButton.BackgroundColor3 = Color3.new(1.000, 1.000, 1.000)
TextButton.BackgroundTransparency = 0.95
TextButton.Position = UDim2.new(0, 0, 0.34, 0)
TextButton.Size = UDim2.new(0, 325, 0, 50)
TextButton.Parent = Frame
UICorner_4.CornerRadius = UDim.new(0, 15)
UICorner_4.Parent = TextButton
UIListLayout_3.Padding = UDim.new(0, 35)
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.Parent = TextButton

for i = 1, 4 do
	local UIShadow = Instance.new("UIShadow", Frame)
	UIShadow.BlurRadius = UDim.new(0, 20)
	UIShadow.Transparency = 0.5
end

local Player = game:GetService("Players").LocalPlayer

local Active = true

Keep.MouseButton1Click:Connect(function()
	if not Active then return end
	
	GUI.Enabled = false
	Active = false
	local servers = {}
	local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
	local body = game.HttpService:JSONDecode(req)

	if body and body.data then
		for i, v in next, body.data do
			if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
				table.insert(servers, 1, v.id)
			end
		end
	end

	if #servers > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Player)
	end
end)

Inject.MouseButton1Click:Connect(function()
	if not Active then return end
	GUI.Enabled = false
	Active = false
	task.spawn(function()
		wait(7)
		GUI:Destroy()
	end)
	loadstring(game:HttpGet("https://github.com/dansi31/Created/raw/refs/heads/main/UniversalScriptV4.lua"))()
end)

TextButton.MouseButton1Click:Connect(function()
	GUI.Enabled = false
	Active = false
	task.spawn(function()
		wait(7)
		GUI:Destroy()
	end)
end)

local UserInputService = game:GetService("UserInputService")
local runService = (game:GetService("RunService"));

local gui = Frame

local dragging
local dragInput
local dragStart
local startPos

function Lerp(a, b, m)
	return a + (b - a) * m
end;

local lastMousePos
local lastGoalPos
local DRAG_SPEED = (8); -- // The speed of the UI darg.
function Update(dt)
	if not (startPos) then return end;
	if not (dragging) and (lastGoalPos) then
		gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
		return 
	end;

	local delta = (lastMousePos - UserInputService:GetMouseLocation())
	local xGoal = (startPos.X.Offset - delta.X);
	local yGoal = (startPos.Y.Offset - delta.Y);
	lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
	gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
end;

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		lastMousePos = UserInputService:GetMouseLocation()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

runService.Heartbeat:Connect(Update)
