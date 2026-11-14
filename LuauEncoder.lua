
-- LuaU String Encoder
-- Real / Xeno compatible (where supported)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local oldGui = player.PlayerGui:FindFirstChild("LuaUStringEncoder")

if oldGui then
	oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "LuaUStringEncoder"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main window
local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(440, 370)
frame.Position = UDim2.new(0.5, -220, 0.5, -185)
frame.BackgroundColor3 = Color3.fromRGB(22, 23, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(31, 33, 43)
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -65, 1, 0)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "LuaU String Encoder"
title.TextColor3 = Color3.fromRGB(220, 220, 255)
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Close button
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(32, 32)
close.Position = UDim2.new(1, -39, 0, 6)
close.BackgroundColor3 = Color3.fromRGB(190, 55, 65)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.TextSize = 15
close.Font = Enum.Font.GothamBold
close.Parent = header

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 7)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Dragging
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = frame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		) then
		local delta = input.Position - dragStart

		frame.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- Input label
local inputLabel = Instance.new("TextLabel")
inputLabel.Size = UDim2.new(1, -30, 0, 20)
inputLabel.Position = UDim2.fromOffset(15, 55)
inputLabel.BackgroundTransparency = 1
inputLabel.Text = "INPUT TEXT"
inputLabel.TextColor3 = Color3.fromRGB(150, 155, 175)
inputLabel.TextSize = 11
inputLabel.Font = Enum.Font.GothamBold
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = frame

-- Input box
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -30, 0, 75)
inputBox.Position = UDim2.fromOffset(15, 78)
inputBox.BackgroundColor3 = Color3.fromRGB(34, 36, 47)
inputBox.TextColor3 = Color3.fromRGB(240, 240, 245)
inputBox.PlaceholderText = "Enter your text here..."
inputBox.PlaceholderColor3 = Color3.fromRGB(110, 115, 135)
inputBox.Text = ""
inputBox.TextSize = 14
inputBox.Font = Enum.Font.Code
inputBox.TextWrapped = true
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.TextYAlignment = Enum.TextYAlignment.Top
inputBox.MultiLine = true
inputBox.ClearTextOnFocus = false
inputBox.Parent = frame

inputBox:GetPropertyChangedSignal("Text"):Connect(function()
	if #inputBox.Text > 255 then
		inputBox.Text = string.sub(inputBox.Text, 1, 255)
	end
end)

Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 7)

-- Encode button
local encodeButton = Instance.new("TextButton")
encodeButton.Size = UDim2.new(1, -30, 0, 35)
encodeButton.Position = UDim2.fromOffset(15, 163)
encodeButton.BackgroundColor3 = Color3.fromRGB(105, 85, 220)
encodeButton.Text = "ENCODE"
encodeButton.TextColor3 = Color3.new(1, 1, 1)
encodeButton.TextSize = 13
encodeButton.Font = Enum.Font.GothamBold
encodeButton.Parent = frame

Instance.new("UICorner", encodeButton).CornerRadius = UDim.new(0, 7)

-- Output label
local outputLabel = Instance.new("TextLabel")
outputLabel.Size = UDim2.new(1, -30, 0, 20)
outputLabel.Position = UDim2.fromOffset(15, 207)
outputLabel.BackgroundTransparency = 1
outputLabel.Text = "ENCODED OUTPUT"
outputLabel.TextColor3 = Color3.fromRGB(150, 155, 175)
outputLabel.TextSize = 11
outputLabel.Font = Enum.Font.GothamBold
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.Parent = frame

-- Output box
local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(1, -30, 0, 75)
outputBox.Position = UDim2.fromOffset(15, 230)
outputBox.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
outputBox.TextColor3 = Color3.fromRGB(110, 230, 160)
outputBox.PlaceholderText = "Encoded text will appear here..."
outputBox.Text = ""
outputBox.TextSize = 12
outputBox.Font = Enum.Font.Code
outputBox.TextWrapped = true
outputBox.TextXAlignment = Enum.TextXAlignment.Left
outputBox.TextYAlignment = Enum.TextYAlignment.Top
outputBox.MultiLine = true
outputBox.ClearTextOnFocus = false
outputBox.TextEditable = false
outputBox.Active = true
outputBox.Parent = frame

Instance.new("UICorner", outputBox).CornerRadius = UDim.new(0, 7)

-- Encode function
local function encode(text)
	local parts = {}

	for _, codepoint in utf8.codes(text) do
		table.insert(parts, "utf8.char(" .. codepoint .. ")")
	end
	
	local str = table.concat(parts, " .. "):sub(1, -1)

	return "local str = " .. str
end

encodeButton.MouseButton1Click:Connect(function()
	if inputBox.Text == "" then
		outputBox.Text = ""
		return
	end

	outputBox.Text = encode(inputBox.Text)
end)

-- Copy button
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(1, -30, 0, 35)
copyButton.Position = UDim2.fromOffset(15, 315)
copyButton.BackgroundColor3 = Color3.fromRGB(45, 155, 100)
copyButton.Text = "COPY TO CLIPBOARD"
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.TextSize = 13
copyButton.Font = Enum.Font.GothamBold
copyButton.Parent = frame

Instance.new("UICorner", copyButton).CornerRadius = UDim.new(0, 7)

copyButton.MouseButton1Click:Connect(function()
	if outputBox.Text == "" then
		copyButton.Text = "NOTHING TO COPY"
		task.wait(1)
		copyButton.Text = "COPY TO CLIPBOARD"
		return
	end

	if typeof(setclipboard) == "function" then
		setclipboard(outputBox.Text)
		copyButton.Text = "COPIED SUCCESSFULLY!"
	else
		copyButton.Text = "CLIPBOARD NOT SUPPORTED"
	end

	task.wait(1.5)
	copyButton.Text = "COPY TO CLIPBOARD"
end)
