local ScreenGui = Instance.new("ScreenGui", gethui())
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local UIStroke = Instance.new("UIStroke")
local UICorner_1 = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")
local Universal = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local UIListLayout_1 = Instance.new("UIListLayout")
local Special = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local UIListLayout_2 = Instance.new("UIListLayout")
local UIStroke_1 = Instance.new("UIStroke")
local Close = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local UIListLayout_3 = Instance.new("UIListLayout")

ScreenGui.Enabled = false
Frame.AnchorPoint = Vector2.new(0.500, 0.500)
Frame.BackgroundColor3 = Color3.new(0.118, 0.118, 0.118)
Frame.BorderColor3 = Color3.new(0.000, 0.000, 0.000)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.514, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 384, 0, 250)
Frame.Parent = ScreenGui
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame
TextLabel.FontFace = Font.new("rbxasset://fonts/families/Michroma.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel.Text = [[Which script do you wanna execute?]]
TextLabel.TextColor3 = Color3.new(1.000, 1.000, 1.000)
TextLabel.TextSize = 22
TextLabel.BackgroundColor3 = Color3.new(1.000, 1.000, 1.000)
TextLabel.BackgroundTransparency = 0.9
TextLabel.BorderColor3 = Color3.new(0.000, 0.000, 0.000)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.001, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 383, 0, 50)
TextLabel.Parent = Frame
UIStroke.Parent = TextLabel
UICorner_1.CornerRadius = UDim.new(0, 15)
UICorner_1.Parent = TextLabel
UIListLayout.Padding = UDim.new(0, 15)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Frame
Universal.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Universal.Text = [[Universal Script V5]]
Universal.TextColor3 = Color3.new(1.000, 1.000, 1.000)
Universal.TextSize = 31
Universal.TextWrapped = true
Universal.BackgroundColor3 = Color3.new(1.000, 1.000, 1.000)
Universal.BackgroundTransparency = 0.95
Universal.BorderColor3 = Color3.new(0.000, 0.000, 0.000)
Universal.BorderSizePixel = 0
Universal.LayoutOrder = 1
Universal.Position = UDim2.new(0, 0, 0.34, 0)
Universal.Size = UDim2.new(0, 325, 0, 50)
Universal.Parent = Frame
UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = Universal
UIListLayout_1.Padding = UDim.new(0, 35)
UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_1.Parent = Universal
Special.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Special.TextColor3 = Color3.new(1.000, 1.000, 1.000)
Special.TextSize = 21
Special.TextWrapped = true
Special.BackgroundColor3 = Color3.new(1.000, 1.000, 1.000)
Special.BackgroundTransparency = 0.95
Special.BorderColor3 = Color3.new(0.000, 0.000, 0.000)
Special.BorderSizePixel = 0
Special.LayoutOrder = 2
Special.Position = UDim2.new(0.077, 0, 0.52, 0)
Special.Size = UDim2.new(0, 346, 0, 50)
Special.Name = [[Special]]
Special.Parent = Frame
UICorner_3.CornerRadius = UDim.new(0, 15)
UICorner_3.Parent = Special
UIListLayout_2.Padding = UDim.new(0, 35)
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Parent = Special
UIStroke_1.Color = Color3.new(1.000, 1.000, 1.000)
UIStroke_1.Thickness = 0.15
UIStroke_1.Parent = Special
Close.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Close.Text = [[Close this tab]]
Close.TextColor3 = Color3.new(1.000, 1.000, 1.000)
Close.TextSize = 35
Close.TextWrapped = true
Close.BackgroundColor3 = Color3.new(1.000, 1.000, 1.000)
Close.BackgroundTransparency = 0.95
Close.BorderColor3 = Color3.new(0.000, 0.000, 0.000)
Close.BorderSizePixel = 0
Close.LayoutOrder = 3
Close.Position = UDim2.new(0, 0, 0.34, 0)
Close.Size = UDim2.new(0, 325, 0, 50)
Close.Name = [[Close]]
Close.Parent = Frame
UICorner_4.CornerRadius = UDim.new(0, 15)
UICorner_4.Parent = Close
UIListLayout_3.Padding = UDim.new(0, 35)
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.Parent = Close

function CloseGui()
	ScreenGui.Enabled = false
	task.spawn(function()
		--wait(4)
		getgenv().CHOOSING_SCRIPT = false
		wait(3)
		ScreenGui:Destroy()
	end)
end

return function(MapName, Ver, Func)
	if getgenv().CHOOSING_SCRIPT then return end
	getgenv().CHOOSING_SCRIPT = true

	ScreenGui.Enabled = true
	Special.Text = `{MapName} Script V{Ver} (For This Game)`

	Close.MouseButton1Click:Connect(CloseGui)

	Special.MouseButton1Click:Connect(function()
		CloseGui()
		Func()
	end)

	Universal.MouseButton1Click:Connect(function()
		CloseGui()
		loadstring(game:HttpGet("https://github.com/dansi31/Created/raw/refs/heads/main/UniversalScriptV5.lua"))()
	end)
end
