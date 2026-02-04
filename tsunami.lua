-- [[ MATSUHUB TSUNAMI - VIP GHOST EDITION ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubTsunamiV5"

local BLUE = Color3.fromRGB(0, 85, 255)
local BLACK = Color3.fromRGB(15, 15, 15)
local GOLD = Color3.fromRGB(255, 215, 0)
local WHITE = Color3.fromRGB(255, 255, 255)

-- Botão M (Sempre visível para fechar/abrir)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = BLUE
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = WHITE
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- Menu Principal (Preto com Borda Azul)
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 280, 0, 200)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -100)
MainFrame.BackgroundColor3 = BLACK
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = BLUE
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MatsuHub Tsunami"
Title.TextColor3 = WHITE
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- Botão VIP UNLOCKED
local VipBtn = Instance.new("TextButton", MainFrame)
VipBtn.Size = UDim2.new(0.9, 0, 0, 60)
VipBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
VipBtn.BackgroundColor3 = GOLD
VipBtn.Text = "ATIVAR VIP GHOST"
VipBtn.TextColor3 = Color3.new(0,0,0)
VipBtn.Font = Enum.Font.GothamBold
VipBtn.TextSize = 16
Instance.new("UICorner", VipBtn)

VipBtn.MouseButton1Click:Connect(function()
    VipBtn.Text = "VIP ATIVADO! 👑"
    pcall(function()
        -- Torna as paredes VIP atravessáveis apenas para VOCÊ
        -- A parede continua existindo visualmente
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name:lower():find("vip") and v:IsA("BasePart") then
                v.CanCollide = false -- Você passa por dentro
                v.Transparency = 0.7 -- Ela fica meio fantasma para você saber que funciona
            end
        end
        
        -- Bypass de verificação básica
        if player:FindFirstChild("IsVip") then player.IsVip.Value = true end
    end)
    task.wait(2)
    VipBtn.Text = "VIP GHOST ATIVO ✅"
end)

-- Sistema de Abrir/Fechar com o M
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
