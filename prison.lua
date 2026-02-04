-- [[ MATSUHUB TSUNAMI - PRISON LIFE PRO ]] --
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubPrisonFinal"

local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

local BLUE = Color3.fromRGB(0, 85, 255)
local DARK_BLUE = Color3.fromRGB(0, 40, 120)
local WHITE = Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = WHITE, 2, Enum.ApplyStrokeMode.Border
end

-- Botão M
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 60)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLUE, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
ToggleBtn.ZIndex = 100; Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

-- Painel Principal
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 260), UDim2.new(0.5, -130, 0.5, -130)
MainFrame.BackgroundColor3, MainFrame.Visible = BLUE, true
MainFrame.ZIndex = 5; Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

-- Título
Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency, Header.Text = 1, "MatsuHub Tsunami"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 18

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = DARK_BLUE, t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 13
    b.ZIndex = 7; Instance.new("UICorner", b); applyNeon(b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

-- LÓGICA DO AIMBOT
_G.AimbotMode = "None" -- "Police" ou "Criminals"

task.spawn(function()
    while task.wait() do
        if _G.AimbotMode ~= "None" then
            local target = nil
            local dist = math.huge
            
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("Head") and v.Character.Humanoid.Health > 0 then
                    -- Verifica o time
                    local isTarget = false
                    if _G.AimbotMode == "Police" and v.TeamColor.Name == "Bright blue" then isTarget = true end
                    if _G.AimbotMode == "Criminals" and (v.TeamColor.Name == "Really red" or v.TeamColor.Name == "Deep orange") then isTarget = true end
                    
                    if isTarget then
                        local screenPos, onScreen = camera:WorldToViewportPoint(v.Character.Head.Position)
                        if onScreen then
                            local mDist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                            if mDist < dist then
                                dist = mDist
                                target = v.Character.Head
                            end
                        end
                    end
                end
            end
            
            if target then
                camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position)
            end
        end
    end
end)

-- 1. AIMBOT POLICE
createBtn("Aimbot Police", UDim2.new(0.05, 0, 0.22, 0), function(b)
    if _G.AimbotMode == "Police" then _G.AimbotMode = "None" b.Text = "Aimbot Police"
    else _G.AimbotMode = "Police" b.Text = "POLICE ON" end
end)

-- 2. AIMBOT CRIMINAL
createBtn("Aimbot Criminal", UDim2.new(0.05, 0, 0.45, 0), function(b)
    if _G.AimbotMode == "Criminals" then _G.AimbotMode = "None" b.Text = "Aimbot Criminal"
    else _G.AimbotMode = "Criminals" b.Text = "CRIMINAL ON" end
end)

-- 3. TELEPORT GUNS (Arsenal da Polícia)
createBtn("Teleporte Guns", UDim2.new(0.05, 0, 0.68, 0), function(b)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- Coordenadas do Arsenal dentro da delegacia
        char.HumanoidRootPart.CFrame = CFrame.new(837, 99, 2267)
        b.Text = "TELEPORTADO!"
        task.wait(1)
        b.Text = "Teleporte Guns"
    end
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
