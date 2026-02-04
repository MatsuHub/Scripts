-- [[ MATSUHUB TSUNAMI - TRADE SCAM FINAL ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubV4"

local BLUE = Color3.fromRGB(0, 85, 255)
local BLACK = Color3.fromRGB(15, 15, 15)
local WHITE = Color3.fromRGB(255, 255, 255)

-- Botão M (Toggle)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 10, 0, 150)
ToggleBtn.BackgroundColor3 = BLUE
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = WHITE
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- Painel Principal (Menu Preto com Borda Azul)
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 280, 0, 250)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -125)
MainFrame.BackgroundColor3 = BLACK
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = BLUE
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MatsuHub Trade Scam"
Title.TextColor3 = WHITE
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

local function createBtn(t, pos, color, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 50), pos
    b.BackgroundColor3, b.Text = color, t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

-- 1. CONGELAR TRADE
createBtn("Congelar Trade", UDim2.new(0.05, 0, 0.25, 0), Color3.fromRGB(180, 0, 0), function(b)
    _G.Freeze = not _G.Freeze
    b.Text = _G.Freeze and "CONGELADO! ❄️" or "Congelar Trade"
    task.spawn(function()
        while _G.Freeze do
            pcall(function()
                -- Envia spam para o servidor ignorar o comando de cancelar do oponente
                local rs = game:GetService("ReplicatedStorage")
                for _, v in pairs(rs:GetDescendants()) do
                    if v:IsA("RemoteEvent") and (v.Name:find("Trade") or v.Name:find("Accept")) then
                        v:FireServer(true)
                    end
                end
            end)
            task.wait(0.01)
        end
    end)
end)

-- 2. AUTO ACCEPT
createBtn("Auto Accept", UDim2.new(0.05, 0, 0.6, 0), Color3.fromRGB(0, 160, 0), function(b)
    _G.AutoAcc = not _G.AutoAcc
    b.Text = _G.AutoAcc and "ACCEPT: ON ✅" or "Auto Accept"
    task.spawn(function()
        while _G.AutoAcc do
            pcall(function()
                for _, v in pairs(player.PlayerGui:GetDescendants()) do
                    if v:IsA("TextButton") and (v.Text:lower():find("accept") or v.Text:lower():find("confirm")) then
                        firesignal(v.MouseButton1Click)
                    end
                end
            end)
            task.wait(0.05)
        end
    end)
end)

-- Fechar/Abrir
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
