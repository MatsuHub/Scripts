local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubV3_Fix"

-- BOTAO M
local btn = Instance.new("TextButton", sgui)
btn.Size = UDim2.new(0, 50, 0, 50)
btn.Position = UDim2.new(0, 10, 0, 150)
btn.Text = "M"
btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", btn)

-- MENU
local frame = Instance.new("Frame", sgui)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Visible = true
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "MatsuHub V3"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

-- BOTAO GAMEPASS
local gp = Instance.new("TextButton", frame)
gp.Size = UDim2.new(0.8, 0, 0, 40)
gp.Position = UDim2.new(0.1, 0, 0.4, 0)
gp.Text = "Free Gamepass"
gp.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", gp)

gp.MouseButton1Click:Connect(function()
    pcall(function()
        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_Items.giver["M4A1"].ITEMPICKUP)
    end)
    gp.Text = "Ativado!"
end)

btn.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)
