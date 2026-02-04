-- [[ MATSUHUB TSUNAMI - VIP DEFINITIVO ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubVFINAL"

local BLUE = Color3.fromRGB(0, 85, 255)
local BLACK = Color3.fromRGB(15, 15, 15)
local GOLD = Color3.fromRGB(255, 215, 0)
local WHITE = Color3.fromRGB(255, 255, 255)

-- 1. Botão M (Sempre visível para abrir/fechar)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = BLUE
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = WHITE
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- 2. Menu Principal (Preto com Borda Azul)
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
Title.Text = "MatsuHub Tsunami"
Title.TextColor3 = WHITE
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- 3. Função VIP (Atravessar Parede sem Deletar)
local VipBtn = Instance.new("TextButton", MainFrame)
VipBtn.Size = UDim2.new(0.9, 0, 0, 60)
VipBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
VipBtn.BackgroundColor3 = GOLD
VipBtn.Text = "ATIVAR ATRAVESSAR VIP"
VipBtn.TextColor3 = Color3.new(0,0,0)
VipBtn.Font = Enum.Font.GothamBold
VipBtn.TextSize = 15
Instance.new("UICorner", VipBtn)

VipBtn.MouseButton1Click:Connect(function()
    VipBtn.Text = "VIP ATIVADO! 👑"
    pcall(function()
        -- Loop para garantir que você passe pela parede, mas ela continue lá
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name:lower():find("vip") and v:IsA("BasePart") then
                v.CanCollide = false -- Permite atravessar
                v.Transparency = 0.5 -- Fica levemente transparente para indicar que funciona
            end
        end
    end)
    task.wait(2)
    VipBtn.Text = "VIP GHOST ATIVO ✅"
end)

-- Sistema de Fechar/Abrir
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
