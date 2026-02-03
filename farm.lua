-- [[ MatsuHub Oficial - Build A Boat ]] --
if game.PlaceId ~= 537413528 then return end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local ActionBtn = Instance.new("TextButton", MainFrame)

local NEON_RED = Color3.fromRGB(255, 0, 0)
local PRETO = Color3.fromRGB(0, 0, 0)
local BRANCO = Color3.fromRGB(255, 255, 255)

-- Função de Estilo MatsuHub
local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color = NEON_RED
    s.Thickness = 2.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- Botão "M" (Fonte GothamBold)
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3 = PRETO
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = BRANCO
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)
applyNeon(ToggleBtn)

-- Painel Principal
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 320), UDim2.new(0.5, -130, 0.5, -160)
MainFrame.BackgroundColor3 = PRETO
MainFrame.Visible = true
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame)
applyNeon(MainFrame)

-- Título MatsuHub
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Text = "MATSUHUB OFFICIAL"
Header.TextColor3 = NEON_RED
Header.Font = Enum.Font.GothamBold
Header.TextSize = 18

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), p
    b.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    b.Text = t
    b.TextColor3 = BRANCO
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    Instance.new("UICorner", b)
    applyNeon(b)
    b.MouseButton1Click:Connect(f)
end

-- Botão PARAR (Fica invisível até chegar no baú)
ActionBtn.Size, ActionBtn.Position = UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0.8, 0)
ActionBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
ActionBtn.Text = "PARAR DE VOAR"
ActionBtn.TextColor3 = BRANCO
ActionBtn.Font = Enum.Font.GothamBold
ActionBtn.TextSize = 14
ActionBtn.Visible = false
Instance.new("UICorner", ActionBtn)
applyNeon(ActionBtn)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local lp = game.Players.LocalPlayer
local flying, bv, bg = false, nil, nil

-- FUNÇÃO NOCLIP FORÇADA (Não tem como bater)
local function setNoclip(state)
    local char = lp.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state
            end
        end
    end
end

local function cleanup()
    flying = false
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    ActionBtn.Visible = false
    setNoclip(false)
end

local function startFly(s)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local h = char:WaitForChild("HumanoidRootPart")
    cleanup()
    
    bv = Instance.new("BodyVelocity", h)
    bg = Instance.new("BodyGyro", h)
    bv.MaxForce = Vector3.one * 1e7
    bg.MaxTorque = Vector3.one * 1e7
    flying = true
    
    task.spawn(function()
        while flying and h.Parent do
            setNoclip(true) -- Noclip ligado o tempo todo!
            
            local posZ = h.Position.Z
            -- TRAVA NO BAÚ (Se passar de 9480 ele congela)
            if posZ >= 9480 then
                bv.Velocity = Vector3.zero
                ActionBtn.Visible = true
            else
                bv.Velocity = (Vector3.new(-106, 35, posZ + 100) - h.Position).Unit * s
                ActionBtn.Visible = false
            end
            bg.CFrame = CFrame.new(h.Position, Vector3.new(-106, h.Position.Y, h.Position.Z + 100))
            task.wait()
        end
    end)
end

ActionBtn.MouseButton1Click:Connect(cleanup)

createBtn("FARM DE BARCO (200)", UDim2.new(0.05, 0, 0.2, 0), function() startFly(200) end)
createBtn("FARM NORMAL (250)", UDim2.new(0.05, 0, 0.4, 0), function() startFly(250) end)
createBtn("FARM TURBO (400)", UDim2.new(0.05, 0, 0.6, 0), function() startFly(400) end)
