-- [[ MATSUHUB V4 - TRADE SCAM & AUTO-ACCEPT ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuTradeScam"

local BLUE = Color3.fromRGB(0, 85, 255)
local BLACK = Color3.fromRGB(15, 15, 15)
local RED = Color3.fromRGB(200, 0, 0)
local GREEN = Color3.fromRGB(0, 180, 0)
local WHITE = Color3.fromRGB(255, 255, 255)

-- Botão M (Esconder tudo)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 10, 0, 150)
ToggleBtn.BackgroundColor3 = BLUE
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = WHITE
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- Menu Principal (Azul)
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 300)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -150)
MainFrame.BackgroundColor3 = BLUE
Instance.new("UICorner", MainFrame)

-- Menu Trade Scam (Preto)
local TradeFrame = Instance.new("Frame", sgui)
TradeFrame.Size = UDim2.new(0, 280, 0, 220)
TradeFrame.Position = UDim2.new(0.5, -140, 0.5, -110)
TradeFrame.BackgroundColor3 = BLACK
TradeFrame.Visible = false
local border = Instance.new("UIStroke", TradeFrame)
border.Color = BLUE
border.Thickness = 2
Instance.new("UICorner", TradeFrame)

local Title = Instance.new("TextLabel", TradeFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "MATSUHUB TRADE SCAM"
Title.TextColor3 = WHITE
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

local function createBtn(t, pos, frame, color, f)
    local b = Instance.new("TextButton", frame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = color, t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 13
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

-- Botão para abrir o menu de Scam
createBtn("ABRIR TRADE SCAM", UDim2.new(0.05, 0, 0.3, 0), MainFrame, Color3.fromRGB(30, 30, 30), function()
    TradeFrame.Visible = not TradeFrame.Visible
end)

-- FUNÇÃO CONGELAR TRADE
createBtn("CONGELAR TRADE", UDim2.new(0.05, 0, 0.25, 0), TradeFrame, RED, function(b)
    _G.FreezeTrade = not _G.FreezeTrade
    b.Text = _G.FreezeTrade and "TRADE CONGELADA! ❄️" or "CONGELAR TRADE"
    
    task.spawn(function()
        while _G.FreezeTrade do
            -- Tenta localizar o sistema de troca do jogo
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                -- Dispara eventos comuns de troca para sobrecarregar a resposta de cancelamento do outro
                for _, v in pairs(rs:GetDescendants()) do
                    if v:IsA("RemoteEvent") and (v.Name:find("Trade") or v.Name:find("Accept")) then
                        v:FireServer(true)
                    end
                end
            end)
            task.wait(0.01) -- Velocidade máxima
        end
    end)
end)

-- FUNÇÃO AUTO ACCEPT
createBtn("AUTO ACCEPT", UDim2.new(0.05, 0, 0.6, 0), TradeFrame, GREEN, function(b)
    _G.AutoAcc = not _G.AutoAcc
    b.Text = _G.AutoAcc and "ACCEPT ATIVO! ✅" or "AUTO ACCEPT"
    
    task.spawn(function()
        while _G.AutoAcc do
            pcall(function()
                -- Procura por botões de aceitar na interface do jogador
                for _, v in pairs(player.PlayerGui:GetDescendants()) do
                    if v:IsA("TextButton") and (v.Text:lower():find("accept") or v.Text:lower():find("confirm")) then
                        -- Simula o clique
                        firesignal(v.MouseButton1Click)
                    end
                end
            end)
            task.wait(0.05)
        end
    end)
end)

-- Toggle com botão M
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if not MainFrame.Visible then TradeFrame.Visible = false end
end)
