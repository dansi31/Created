local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local function removeOldTool()
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp and bp:FindFirstChild("TP-Walk") then
        bp["TP-Walk"]:Destroy()
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("TP-Walk") then
        LocalPlayer.Character["TP-Walk"]:Destroy()
    end
end

removeOldTool()

local function createTool()
    local tool = Instance.new("Tool")
    tool.Name = "TP-Walk"
    tool.RequiresHandle = false
    tool.CanBeDropped = false
    tool.Parent = LocalPlayer:FindFirstChild("Backpack")

    local isEquipped = false

    tool.Equipped:Connect(function()
        isEquipped = true
    end)

    tool.Unequipped:Connect(function()
        isEquipped = false
    end)

    local function safeTeleport(pos)
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local HRP = char.HumanoidRootPart

        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {char}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist

        local rayResult = workspace:Raycast(pos + Vector3.new(0, 5, 0), Vector3.new(0, -100, 0), rayParams)

        if rayResult and rayResult.Position then
            HRP.CFrame = CFrame.new(rayResult.Position + Vector3.new(0, 3, 0))
        end
    end

    local clickConnection
    clickConnection = Mouse.Button1Down:Connect(function()
        if isEquipped and Mouse.Hit and Mouse.Hit.Position then
            safeTeleport(Mouse.Hit.Position)
        end
    end)

    return tool
end

createTool()

LocalPlayer.CharacterAdded:Connect(function(char)
    repeat wait() until char:FindFirstChild("HumanoidRootPart")
    wait(0.1)
    removeOldTool()
    createTool()
end)
