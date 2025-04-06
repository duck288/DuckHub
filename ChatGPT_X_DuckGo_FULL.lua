-- ChatGPT X DuckGo - Blox Fruits Script (KRNL Mobile Uyumlu)

-- GUI Başlangıcı
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Logo = Instance.new("TextLabel", ScreenGui)
Logo.Size = UDim2.new(0, 250, 0, 30)
Logo.Position = UDim2.new(0, 10, 0, 10)
Logo.Text = "ChatGPT X DuckGo"
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 20
Logo.BackgroundTransparency = 1
Logo.TextColor3 = Color3.fromRGB(0, 200, 255)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true

-- Aç/kapa tuşu (mobilde de çalışır)
local toggleKey = Enum.KeyCode.RightShift
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == toggleKey then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Basit Sekme Sistemi (Auto Farm, Boss, Fruit Finder, Teleport vs.)
local Tabs = {
    "Auto Farm", "Boss Farm", "Fruit Finder", "Server Hop", "Island Teleport", "Kill Aura", "Haki", "Drop Takip"
}

for i, tabName in ipairs(Tabs) do
    local Button = Instance.new("TextButton", MainFrame)
    Button.Size = UDim2.new(0, 120, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 35)
    Button.Text = tabName
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 18
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- Auto Farm Sistemi (Basit Örnek)
spawn(function()
    while task.wait(1) do
        pcall(function()
            local player = game.Players.LocalPlayer
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                        repeat
                            task.wait()
                            char.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,10,0)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
                        until not v or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0
                    end
                end
            end
        end)
    end
end)

-- Auto Haki
spawn(function()
    while task.wait(5) do
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
        end)
    end
end)

-- Server Hop
function Hop()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Player = game.Players.LocalPlayer
    local Servers = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/2753915549/servers/Public?sortOrder=Asc&limit=100"))
    for _, server in pairs(Servers.data) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            TPS:TeleportToPlaceInstance(game.PlaceId, server.id, Player)
            break
        end
    end
end

-- Drop Takip (Terminal)
spawn(function()
    while task.wait(2) do
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") then
                warn("DROP GÖRÜLDÜ: "..v.Name)
            end
        end
    end
end)

-- Fruit Finder
spawn(function()
    while task.wait(10) do
        for _,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Tool") and v.Name:find("Fruit") then
                game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = v.Handle.CFrame
                break
            end
        end
    end
end)
