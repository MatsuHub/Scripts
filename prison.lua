-- [[ MATSUHUB PRISON LIFE - AIMBOT & AUTOFIRE ]] --
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubPrisonV2"

local BLUE = Color3.fromRGB(0, 85, 255)
local DARK_BLUE = Color3.fromRGB(0, 40, 120)
local WHITE = Color3.fromRGB(255, 255, 255)

-- Interface Principal
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 260)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -130)
MainFrame.BackgroundColor3 = BLUE
Instance.new("UICorner", MainFrame)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Text = "MatsuHub Tsunami"
Header.TextColor3, Header.TextSize = WHITE, 18
Header.Font = Enum.Font.GothamBold

_G.AimbotMode = "None"

-- FUNÇÃO DE TIRO AUTOMÁTICO (FIRE EVENT)
local function fireWeapon(target)
    local gun = player.Character:FindFirstChildOfClass("Tool")
    if gun and gun:FindFirstChild("GunCursor") then
        game:GetService("ReplicatedStorage").ShootEvent:FireServer({
            [1] = {
                ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
                ["Distance"] = 0,
                ["Cframe"] = CFrame.new(),
                ["Hit"] = target
            }
        }, gun)
    end
end

-- LOOP DO AIMBOT + AUTO FIRE
task.spawn(function()
    while task.wait() do
        if _G.AimbotMode ~= "None" then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("Head") and v.Character.Humanoid.Health > 0 then
                    local isTarget = false
                    if _G.AimbotMode == "Police" and v.TeamColor.Name == "Bright blue" then isTarget = true end
                    if _G.AimbotMode == "Criminals" and (v.TeamColor.Name == "Really red" or v.TeamColor.Name == "Deep orange") then isTarget = true end
                    
                    if isTarget then
                        local head = v.Character.Head
                        local _, onScreen = camera:WorldToViewportPoint(head.Position)
                        
                        if onScreen then
                            camera.CFrame = CFrame.new(camera.CFrame.Position, head.Position)
                            fireWeapon(head) -- Atira enquanto mira
                        end
                    end
                end
            end
        end
    end
end)

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = DARK_BLUE, t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

createBtn("Aimbot Police", UDim2.new(0.05, 0, 0.22, 0), function(b)
    _G.AimbotMode = (_G.AimbotMode == "Police") and "None" or "Police"
    b.Text = (_G.AimbotMode == "Police") and "POLICE ON" or "Aimbot Police"
end)

createBtn("Aimbot Criminal", UDim2.new(0.05, 0, 0.45, 0), function(b)
    _G.AimbotMode = (_G.AimbotMode == "Criminals") and "None" or "Criminals"
    b.Text = (_G.AimbotMode == "Criminals") and "CRIMINAL ON" or "Aimbot Criminal"
end)

createBtn("Teleporte Guns", UDim2.new(0.05, 0, 0.68, 0), function(b)
    player.Character.HumanoidRootPart.CFrame = CFrame.new(837, 99, 2267)
end)
