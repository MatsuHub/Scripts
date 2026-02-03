-- [[ MatsuHub Oficial - Build A Boat ]] --
if game.PlaceId ~= 537413528 then return end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local ActionBtn = Instance.new("TextButton", MainFrame)

-- Botão M (Para abrir/fechar depois)
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.Text, ToggleBtn.BackgroundColor3 = "M", Color3.fromRGB(0,0,0)
ToggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", ToggleBtn)

-- Painel Principal (Ajustado para já iniciar VISÍVEL)
MainFrame.Size, MainFrame.Position = UDim2.new(0, 250, 0, 310), UDim2.new(0.5, -125, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
MainFrame.Visible = true -- <--- AQUI O ERRO FOI CORRIGIDO
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame)

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.85, 0, 0, 40), p
    b.Text, b.BackgroundColor3 = t, Color3.fromRGB(20,20,20)
    b.TextColor3 = Color3.fromRGB(255,0,0)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(f)
end

-- Botão PARAR (Aparece só quando trava no baú)
ActionBtn.Size, ActionBtn.Position = UDim2.new(0.85, 0, 0, 45), UDim2.new(0.075, 0, 0.78, 0)
ActionBtn.Text, ActionBtn.BackgroundColor3 = "PARAR DE VOAR", Color3.fromRGB(150, 0, 0)
ActionBtn.TextColor3, ActionBtn.Visible = Color3.fromRGB(255,255,255), false
Instance.new("UICorner", ActionBtn)

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
            -- NOCLIP ATIVO (Atravessa a parede da foto)
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end

            local posZ = h.Position.Z
            -- CONGELA NO BAÚ
            if posZ >= 9480 then
                bv.Velocity = Vector3.new(0,0,0)
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

createBtn("FARM DE BARCO (200)", UDim2.new(0.075, 0, 0.20, 0), function() startFly(200) end)
createBtn("FARM NORMAL (250)", UDim2.new(0.075, 0, 0.38, 0), function() startFly(250) end)
createBtn("FARM TURBO (400)", UDim2.new(0.075, 0, 0.56, 0), function() startFly(400) end)
