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

-- Função para o Estilo Neon do MatsuHub
local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color = NEON_RED
    s.Thickness = 3
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- Botão "M" Estilizado
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3 = PRETO
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = BRANCO
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 20
Instance.new("UICorner", ToggleBtn)
applyNeon(ToggleBtn)

-- Painel Principal MatsuHub
MainFrame.Size, MainFrame.Position = UDim2.new(0, 250, 0, 310), UDim2.new(0.5, -125, 0.5, -155)
MainFrame.BackgroundColor3 = PRETO
MainFrame.Visible = true
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame)
applyNeon(MainFrame)

-- Cabeçalho do Menu
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = PRETO
Header.Text = "MATSUHUB BUILD BOAT"
Header.TextColor3 = BRANCO
Header.Font = Enum.Font.GothamBold
Header.TextSize = 15
Instance.new("UICorner", Header)

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.85, 0, 0, 40), p
    b.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    b.Text = t
    b.TextColor3 = BRANCO
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b)
    applyNeon(b)
    b.MouseButton1Click:Connect(f)
end

-- Botão de Parar (Redondo e Vermelho)
ActionBtn.Size, ActionBtn.Position = UDim2.new(0.85, 0, 0, 45), UDim2.new(0.075, 0, 0.78, 0)
ActionBtn.BackgroundColor3 = PRETO
ActionBtn.Text = "PARAR DE VOAR"
ActionBtn.TextColor3 = NEON_RED
ActionBtn.Font = Enum.Font.GothamBold
ActionBtn.TextSize = 12
ActionBtn.Visible = false
Instance.new("UICorner", ActionBtn)
applyNeon(ActionBtn)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local lp = game.Players.LocalPlayer
local flying, bv, bg = false, nil, nil

local function cleanup()
    flying = false
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    ActionBtn.Visible = false
    if lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = true end
        end
    end
end

local function startFly(s)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local h = char:WaitForChild("HumanoidRootPart")
    cleanup()
    
    bv, bg = Instance.new("BodyVelocity", h), Instance.new("BodyGyro", h)
    bv.MaxForce, bg.MaxTorque = Vector3.one * 1e6, Vector3.one * 1e6
    flying = true
    
    task.spawn(function()
        while flying and h.Parent do
            -- NOCLIP TOTAL: Atravessa a parede da cachoeira sem parar
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end

            local posZ = h.Position.Z
            -- TRAVA NO BAÚ (Final do percurso)
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

createBtn("AUTO FARM DE BARCO", UDim2.new(0.075, 0, 0.20, 0), function() startFly(200) end)
createBtn("AUTO FARM (NORMAL)", UDim2.new(0.075, 0, 0.38, 0), function() startFly(250) end)
createBtn("AUTO FARM (TURBO)", UDim2.new(0.075, 0, 0.56, 0), function() startFly(400) end)
