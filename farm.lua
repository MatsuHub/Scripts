-- [[ MATSUHUB BUILD BOAT - FINAL FORCE ]] --
if game.PlaceId ~= 537413528 then return end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local StopBtn = Instance.new("TextButton", ScreenGui)

local RED = Color3.fromRGB(255, 0, 0)
local BLACK = Color3.fromRGB(0, 0, 0)
local WHITE = Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness = RED, 2.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- Botão M
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLACK, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

-- Menu
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 250), UDim2.new(0.5, -130, 0.5, -125)
MainFrame.BackgroundColor3, MainFrame.Visible = BLACK, true
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

-- Título (Fonte Branca como pediu)
Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency, Header.Text = 1, "MATSUHUB BUILD BOAT"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 17

-- Botão Parar Auto Farm (Lógica de Congelamento)
StopBtn.Size, StopBtn.Position = UDim2.new(0, 180, 0, 50), UDim2.new(0.5, -90, 0.7, 0)
StopBtn.BackgroundColor3, StopBtn.Text = BLACK, "Parar Auto Farm"
StopBtn.TextColor3, StopBtn.Font, StopBtn.TextSize = WHITE, Enum.Font.GothamBold, 16
StopBtn.Visible = false; Instance.new("UICorner", StopBtn); applyNeon(StopBtn)

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), p
    b.BackgroundColor3, b.Text = Color3.fromRGB(15, 15, 15), t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 13
    Instance.new("UICorner", b); applyNeon(b)
    b.MouseButton1Click:Connect(f)
end

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local lp = game.Players.LocalPlayer
local flying = false

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
    StopBtn.Visible = false
    toggleNoclip(false)
end

StopBtn.MouseButton1Click:Connect(stopAll)

local function startFarm(speed, mode)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    stopAll()
    flying = true
    
    task.spawn(function()
        while flying and root.Parent do
            toggleNoclip(true)
            local currentPos = root.Position
            local targetY = 35
            
            -- FORÇA A DESCIDA POR TELEPORTE (CFrame)
            if mode == "Boat" and currentPos.Z >= 9410 and currentPos.Z < 9485 then
                targetY = -35 -- Altura dos espinhos
            end

            -- CHEGADA NO TESOURO
            if currentPos.Z >= 9485 then
                root.CFrame = CFrame.new(-106, -35, currentPos.Z)
                StopBtn.Visible = true
                -- Para o movimento mas mantém o noclip
            else
                -- Move o boneco setando o CFrame (Ignora física)
                local nextZ = currentPos.Z + (speed * task.wait())
                root.CFrame = CFrame.new(-106, targetY, nextZ)
                StopBtn.Visible = false
            end
        end
    end)
end

createBtn("AUTO FARM DE BARCO", UDim2.new(0.05, 0, 0.25, 0), function() startFarm(150, "Boat") end)
createBtn("AUTO FARM (NORMAL)", UDim2.new(0.05, 0, 0.45, 0), function() startFarm(200, "Normal") end)
createBtn("AUTO FARM (TURBO)", UDim2.new(0.05, 0, 0.65, 0), function() startFarm(350, "Normal") end)
