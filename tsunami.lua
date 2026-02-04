-- [[ MATSUHUB - VERSÃO VIP DEFINITIVA ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubV5"

local BLUE = Color3.fromRGB(0, 85, 255)
local BLACK = Color3.fromRGB(15, 15, 15)
local GOLD = Color3.fromRGB(255, 215, 0)
local WHITE = Color3.fromRGB(255, 255, 255)

-- Botão M (Única forma de abrir/fechar)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 10, 0, 200) -- Posição fixa para não sumir
ToggleBtn.BackgroundColor3 = BLUE
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = WHITE
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- Painel Principal (Apenas VIP)
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 280, 0, 180)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
MainFrame.BackgroundColor3 = BLACK
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = BLUE
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MatsuHub VIP"
Title.TextColor3 = WHITE
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- Botão VIP Unlocked
local VipBtn = Instance.new("TextButton", MainFrame)
VipBtn.Size = UDim2.new(0.9, 0, 0, 60)
VipBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
VipBtn.BackgroundColor3 = GOLD
VipBtn.Text = "ATIVAR VIP UNLOCKED"
VipBtn.TextColor3 = BLACK -- Texto preto no fundo dourado para ler melhor
VipBtn.Font = Enum.Font.GothamBold
VipBtn.TextSize = 16
Instance.new("UICorner", VipBtn)

VipBtn.MouseButton1Click:Connect(function()
    VipBtn.Text = "VIP ATIVADO! 👑"
    pcall(function()
        -- Bypass de permissões VIP do jogo
        if player:FindFirstChild("IsVip") then player.IsVip.Value = true end
        if player:FindFirstChild("VipPass") then player.VipPass.Value = true end
        
        -- Libera áreas trancadas
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name:lower():find("vip") and v:IsA("BasePart") then
                v.CanCollide = false
                v.Transparency = 0.5
            end
        end
    end)
    task.wait(2)
    VipBtn.Text = "VIP UNLOCKED ✅"
end)

-- Sistema de Fechar/Abrir
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
