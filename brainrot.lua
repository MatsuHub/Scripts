-- [[ MATSUHUB TSUNAMI - STEAL A BRAINROT VIP ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubBrainrot"

local BLUE = Color3.fromRGB(0, 85, 255)
local DARK_BLUE = Color3.fromRGB(0, 40, 120)
local WHITE = Color3.fromRGB(255, 255, 255)

local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 260)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -130)
MainFrame.BackgroundColor3 = BLUE
Instance.new("UICorner", MainFrame)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Text = "MatsuHub Brainrot"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 18

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = DARK_BLUE, t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

-- 1. AUTO COLLECT
createBtn("Auto Collect Items", UDim2.new(0.05, 0, 0.22, 0), function(b)
    _G.CollectBrainrot = not _G.CollectBrainrot
    b.Text = _G.CollectBrainrot and "COLLECT: ON" or "Auto Collect Items"
    task.spawn(function()
        while _G.CollectBrainrot do
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Tool") or v:FindFirstChild("Handle") then
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            firetouchinterest(player.Character.HumanoidRootPart, v.Handle, 0)
                            firetouchinterest(player.Character.HumanoidRootPart, v.Handle, 1)
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)

-- 2. TELEPORTE PARA BASE (ENTREGAR)
createBtn("Entregar na Base", UDim2.new(0.05, 0, 0.45, 0), function(b)
    pcall(function()
        local root = player.Character.HumanoidRootPart
        -- Procura o cofre/base que pertence ao jogador
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Owner" and v.Value == player.Name then
                local base = v.Parent -- O modelo da base
                if base and base:FindFirstChild("TouchPart") or base:FindFirstChild("Deliver") then
                    root.CFrame = (base:FindFirstChild("TouchPart") or base.PrimaryPart).CFrame
                    b.Text = "ENTREGUE!"
                    task.wait(1)
                    b.Text = "Entregar na Base"
                end
            end
        end
    end)
end)

-- 3. SPEED TURBO
createBtn("Speed Turbo", UDim2.new(0.05, 0, 0.68, 0), function(b)
    _G.BrainSpeed = not _G.BrainSpeed
    b.Text = _G.BrainSpeed and "SPEED: MAX" or "Speed Turbo"
    task.spawn(function()
        while _G.BrainSpeed do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = 80
            end
            task.wait(0.5)
        end
        player.Character.Humanoid.WalkSpeed = 16
    end)
end)
