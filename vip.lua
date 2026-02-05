local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_VIP_Final"

-- BOTÃO M
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.new(0, 0, 0)
ToggleBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ToggleBtn)

-- MENU
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(255, 215, 0)
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MatsuHub VIP"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

-- BOTÃO FREE GAMEPASS
local GpBtn = Instance.new("TextButton", MainFrame)
GpBtn.Size = UDim2.new(0.9, 0, 0, 60)
GpBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
GpBtn.Text = "FREE GAMEPASS (M4A1)"
GpBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
GpBtn.TextColor3 = Color3.new(0, 0, 0)
GpBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", GpBtn)

GpBtn.MouseButton1Click:Connect(function()
    -- Comando brabo para pegar a M4A1 da Gamepass direto no inventário
    local workspace = game:GetService("Workspace")
    local remote = workspace:FindFirstChild("Remote")
    
    if remote and remote:FindFirstChild("ItemHandler") then
        remote.ItemHandler:InvokeServer(workspace.Prison_Items.giver:FindFirstChild("M4A1").ITEMPICKUP)
        GpBtn.Text = "M4A1 ENTREGUE!"
        GpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
    else
        GpBtn.Text = "Erro: Remote não encontrado"
    end
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
