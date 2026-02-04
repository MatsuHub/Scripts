-- [[ MATSUHUB TSUNAMI - VOO SUAVE SUBTERRÂNEO ]] --
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

local RED, BLACK, WHITE = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)
local holeIndex = 1

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = RED, 2.5, Enum.ApplyStrokeMode.Border
end

-- Menu Visual
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLACK, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
ToggleBtn.ZIndex = 10; Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 190), UDim2.new(0.5, -130, 0.5, -95)
MainFrame.BackgroundColor3, MainFrame.Visible = BLACK, true
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency, Header.Text = 1, "MatsuHub Tsunami"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 18

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = Color3.fromRGB(15, 15, 15), t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 14
    Instance.new("UICorner", b); applyNeon(b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- Botão SOBE MAIS UM (Voo Suave por Baixo)
createBtn("Sobe mais um", UDim2.new(0.05, 0, 0.5, 0), function(b)
    b.Text, b.TextColor3 = "VOANDO...", RED
    
    task.spawn(function()
        local char = player.Character
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        -- 1. Acha o Alvo
        local targets = {}
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:lower():find("secret") or v.Name:lower():find("win")) then
                table.insert(targets, v)
            end
        end

        if #targets > 0 then
            if holeIndex > #targets then holeIndex = 1 end
            local target = targets[holeIndex]

            -- 2. Mergulha (Entra debaixo da terra)
            hrp.CFrame = hrp.CFrame * CFrame.new(0, -25, 0)
            task.wait(0.3)

            -- 3. Configura o Voo Suave (Tween)
            local targetUnder = CFrame.new(target.Position.X, hrp.Position.Y, target.Position.Z)
            local distance = (hrp.Position - targetUnder.p).Magnitude
            local speed = 30 -- Velocidade do voo (quanto menor, mais devagar)
            local duration = distance / speed

            local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetUnder})
            
            -- Ativa Noclip durante o voo
            local noclipper = game:GetService("RunService").Stepped:Connect(function()
                for _, p in pairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end)

            tween:Play()
            tween.Completed:Wait() -- Espera chegar lá embaixo do buraco

            -- 4. Sobe para o Buraco
            hrp.CFrame = target.CFrame + Vector3.new(0, 3, 0)
            noclipper:Disconnect()
            holeIndex = holeIndex + 1
        end
        
        b.Text, b.TextColor3 = "Sobe mais um", WHITE
    end)
end)
