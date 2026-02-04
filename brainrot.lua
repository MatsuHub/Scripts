-- [[ MATSUHUB TSUNAMI - BRAINROT FLY EDITION ]] --
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubBrainrotV3"

local BLUE = Color3.fromRGB(0, 85, 255)
local DARK_BLUE = Color3.fromRGB(0, 40, 120)
local WHITE = Color3.fromRGB(255, 255, 255)

-- Botão de Abrir/Fechar (M)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.BackgroundColor3 = BLUE
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = WHITE
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 20
Instance.new("UICorner", ToggleBtn)

-- Painel Principal
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 260)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -130)
MainFrame.BackgroundColor3 = BLUE
MainFrame.Visible = true
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
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 13
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

-- Lógica de Voo e Localização
local SavedPos = nil

-- 1. SALVAR LOCALIZAÇÃO
createBtn("Salvar Localização (Na Base)", UDim2.new(0.05, 0, 0.22, 0), function(b)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        SavedPos = player.Character.HumanoidRootPart.Position
        b.Text = "BASE SALVA! ✅"
        task.wait(1)
        b.Text = "Salvar Localização"
    end
end)

-- 2. VOAR PARA BASE (Ao segurar Brainrot)
createBtn("Voar para Base", UDim2.new(0.05, 0, 0.45, 0), function(b)
    if SavedPos and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local char = player.Character
        local hrp = char.HumanoidRootPart
        
        b.Text = "VOANDO..."
        
        -- Cria o efeito de voo/deslize até a base
        local tweenService = game:GetService("TweenService")
        local info = TweenInfo.new(2, Enum.EasingStyle.Linear) -- 2 segundos de voo
        local tween = tweenService:Create(hrp, info, {CFrame = CFrame.new(SavedPos + Vector3.new(0, 3, 0))})
        
        tween:Play()
        tween.Completed:Wait()
        
        b.Text = "CHEGOU! 🚀"
        task.wait(1)
        b.Text = "Voar para Base"
    else
        b.Text = "ERRO: SEM BASE SALVA"
        task.wait(1)
        b.Text = "Voar para Base"
    end
end)

-- 3. AUTO COLLECT
createBtn("Auto Collect Items", UDim2.new(0.05, 0, 0.68, 0), function(b)
    _G.CollectBR = not _G.CollectBR
    b.Text = _G.CollectBR and "COLLECT: ON" or "Auto Collect Items"
    task.spawn(function()
        while _G.CollectBR do
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Tool") or v:FindFirstChild("Handle") then
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            firetouchinterest(player.Character.HumanoidRootPart, v:FindFirstChild("Handle") or v, 0)
                            firetouchinterest(player.Character.HumanoidRootPart, v:FindFirstChild("Handle") or v, 1)
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)

-- Abrir/Fechar
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
