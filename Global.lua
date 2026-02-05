local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_Global_FlyOnly"

-- BOTÃO M (ABRIR/FECHAR)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- Vermelho Superman
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- MENU PRINCIPAL
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 150)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(200, 0, 0)
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MatsuHub Global"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- BOTÃO SUPERMAN FLY
local FlyBtn = Instance.new("TextButton", MainFrame)
FlyBtn.Size = UDim2.new(0.9, 0, 0, 60)
FlyBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
FlyBtn.Text = "Superman Fly (E)"
FlyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FlyBtn.TextColor3 = Color3.new(1, 1, 1)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextSize = 16
Instance.new("UICorner", FlyBtn)

local flying = false
local speed = 70 -- Aumentei um pouco a velocidade pra ficar mais heróico

FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "VOANDO..." or "Superman Fly (E)"
    FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(200, 0, 0)
    
    local char = player.Character
    if not char then return end
    local root = char:WaitForChild("HumanoidRootPart")
    
    if flying then
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0.1, 0)
        bv.Name = "MatsuFly"
        
        local bg = Instance.new("BodyGyro", root)
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.P = 9e4
        bg.Name = "MatsuGyro"
        
        task.spawn(function()
            while flying do
                if root:FindFirstChild("MatsuGyro") then
                    root.MatsuGyro.CFrame = workspace.CurrentCamera.CFrame
                end
                if root:FindFirstChild("MatsuFly") then
                    root.MatsuFly.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
                end
                task.wait()
            end
            if root:FindFirstChild("MatsuFly") then root.MatsuFly:Destroy() end
            if root:FindFirstChild("MatsuGyro") then root.MatsuGyro:Destroy() end
        end)
    end
end)

-- ATALHO TECLA "E"
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.E then
        FlyBtn:Activate()
    end
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
