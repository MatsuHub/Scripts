-- [[ MATSUHUB TSUNAMI - LUCKY BAR FARM ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

local RED, BLACK, WHITE = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = RED, 2.5, Enum.ApplyStrokeMode.Border
end

-- Botão M
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLACK, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
ToggleBtn.ZIndex = 10; Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

-- Painel
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 200), UDim2.new(0.5, -130, 0.5, -100)
MainFrame.BackgroundColor3, MainFrame.Visible = true
MainFrame.BackgroundColor3 = BLACK
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

-- Título
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

-- 1. BOTÃO VIP
createBtn("Liberar Vips", UDim2.new(0.05, 0, 0.3, 0), function(b)
    b.Text, b.TextColor3 = "VIP LIBERADO!", RED
    task.spawn(function()
        while true do
            for _, v in pairs(workspace:GetDescendants()) do
                if (v.Name:lower():find("vip") or v.Name:lower():find("pass")) and v:IsA("BasePart") then
                    v.CanCollide, v.Transparency = false, 0.6
                end
            end
            task.wait(3)
        end
    end)
end)

-- 2. BOTÃO ENCHER SORTE (LUCKY FARM)
createBtn("Farmar Barra de Sorte", UDim2.new(0.05, 0, 0.6, 0), function(b)
    b.Text, b.TextColor3 = "SORTE ATIVA!", RED
    task.spawn(function()
        while true do
            -- Procura pela máquina e pelos gatilhos de sorte
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
                    local name = v.Parent.Name:lower()
                    if name:find("lucky") or name:find("sorte") or name:find("machine") or name:find("roll") then
                        -- Ativa o clique ou o prompt sem parar para subir a barra
                        if v:IsA("ClickDetector") then 
                            fireclickdetector(v) 
                        elseif v:IsA("ProximityPrompt") then 
                            fireproximityprompt(v) 
                        end
                    end
                end
            end
            -- Tenta coletar orbs ou moedas de sorte que dropam no chão
            for _, item in pairs(workspace:GetChildren()) do
                if item:IsA("BasePart") and (item.Name:lower():find("luck") or item.Name:lower():find("orb")) then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        item.CFrame = player.Character.HumanoidRootPart.CFrame
                    end
                end
            end
            task.wait(0.1) -- Velocidade máxima de farm
        end
    end)
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
