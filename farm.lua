-- [[ MATSUHUB OFFICIAL - BUILD A BOAT ]] --
if game.PlaceId ~= 537413528 then return end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local ActionBtn = Instance.new("TextButton", MainFrame)

local RED = Color3.fromRGB(255, 0, 0)
local BLACK = Color3.fromRGB(0, 0, 0)
local WHITE = Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color = RED
    s.Thickness = 2.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- Botão de Menu (M)
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3 = BLACK
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = WHITE
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)
applyNeon(ToggleBtn)

-- Painel Principal
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -160)
MainFrame.BackgroundColor3 = BLACK
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)
applyNeon(MainFrame)

-- Título
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Text = "MATSUHUB OFFICIAL"
Header.TextColor3 = RED
Header.Font = Enum.Font.GothamBold
Header.TextSize = 18

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(0.9, 0, 0, 45)
    b.Position = p
    b.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    b.Text = t
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    Instance.new("UICorner", b)
    applyNeon(b)
    b.MouseButton1Click:Connect(f)
end

-- Botão Parar
ActionBtn.Parent = MainFrame
ActionBtn.Size = UDim2.new(0.9, 0, 0, 50)
ActionBtn.Position = UDim2.new(0.05, 0, 0.8, 0)
ActionBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
ActionBtn.Text = "PARAR DE VOAR"
ActionBtn.TextColor3 = WHITE
ActionBtn.Font = Enum.Font.GothamBold
ActionBtn.TextSize = 14
ActionBtn.Visible = false
Instance.new("UICorner", ActionBtn)
applyNeon(ActionBtn)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local lp = game.Players.LocalPlayer
local flying, bv, bg = false, nil, nil

local function toggleNoclip(state)
    local char = lp.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = not state end
        end
    end
end

local function stopAll()
    flying = false
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    ActionBtn.Visible = false
    toggleNoclip(false)
end

local function startFarm(speed)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    stopAll()
    bv = Instance.new("BodyVelocity", root)
    bg = Instance.new("BodyGyro", root)
    bv.MaxForce = Vector3.new(1e7, 1e7, 1e7)
    bg.MaxTorque = Vector3.new(1e7, 1e7, 1e7)
    flying = true
    task.spawn(function()
        while flying and root.Parent do
            toggleNoclip(true) 
            local z = root.Position.Z
            if z >= 9480 then
                bv.Velocity = Vector3.new(0, 0, 0)
                ActionBtn.Visible = true
            else
                bv.Velocity = (Vector3.new(-106, 35, z + 100) - root.Position).Unit * speed
                ActionBtn.Visible = false
            end
            bg.CFrame = CFrame.new(root.Position, Vector3.new(-106, root.Position.Y, z + 100))
            task.wait()
        end
    end)
end

ActionBtn.MouseButton1Click:Connect(stopAll)

createBtn("AUTO FARM DE BARCO", UDim2.new(0.05, 0, 0.2, 0), function() startFarm(200) end)
createBtn("AUTO FARM (NORMAL)", UDim2.new(0.05, 0, 0.4, 0), function() startFarm(250) end)
createBtn("AUTO FARM (TURBO)", UDim2.new(0.05, 0, 0.6, 0), function() startFarm(400) end)
