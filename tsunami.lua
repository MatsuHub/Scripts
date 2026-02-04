-- [[ MATSUHUB - FUJA DO TSUNAMI VELOCIDADE REAL ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

local RED, BLACK, WHITE = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)
local speedValue = 16

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
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 220), UDim2.new(0.5, -130, 0.5, -110)
MainFrame.BackgroundColor3, MainFrame.Visible = BLACK, true
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

-- Título
Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency, Header.Text = 1, "MATSUHUB SPEED"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 17

-- SEÇÃO DE VELOCIDADE (Ajusta o valor do "Sapato")
local SpeedLabel = Instance.new("TextLabel", MainFrame)
SpeedLabel.Size, SpeedLabel.Position = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0.45, 0)
SpeedLabel.BackgroundTransparency, SpeedLabel.Text = 1, "👟 Velocidade: " .. speedValue
SpeedLabel.TextColor3, SpeedLabel.Font, SpeedLabel.TextSize = WHITE, Enum.Font.GothamBold, 16

local function updateSpeed()
    -- Muda a velocidade física do boneco
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speedValue
    end
    -- Atualiza o texto do menu
    SpeedLabel.Text = "👟 Velocidade: " .. speedValue
end

-- Botões + e -
local MinusBtn = Instance.new("TextButton", MainFrame)
MinusBtn.Size, MinusBtn.Position = UDim2.new(0.4, 0, 0, 45), UDim2.new(0.05, 0, 0.65, 0)
MinusBtn.BackgroundColor3, MinusBtn.Text = Color3.fromRGB(15, 15, 15), "-"
MinusBtn.TextColor3, MinusBtn.Font, MinusBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
Instance.new("UICorner", MinusBtn); applyNeon(MinusBtn)

local PlusBtn = Instance.new("TextButton", MainFrame)
PlusBtn.Size, PlusBtn.Position = UDim2.new(0.4, 0, 0, 45), UDim2.new(0.55, 0, 0.65, 0)
PlusBtn.BackgroundColor3, PlusBtn.Text = Color3.fromRGB(15, 15, 15), "+"
PlusBtn.TextColor3, PlusBtn.Font, PlusBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
Instance.new("UICorner", PlusBtn); applyNeon(PlusBtn)

PlusBtn.MouseButton1Click:Connect(function()
    if speedValue < 500 then
        speedValue = speedValue + 20
        updateSpeed()
    end
end)

MinusBtn.MouseButton1Click:Connect(function()
    if speedValue > 16 then
        speedValue = speedValue - 20
        updateSpeed()
    end
end)

-- Loop para garantir que a velocidade não caia (Anti-Script do Jogo)
task.spawn(function()
    while true do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            if player.Character.Humanoid.WalkSpeed ~= speedValue then
                player.Character.Humanoid.WalkSpeed = speedValue
            end
        end
        task.wait(0.1)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
