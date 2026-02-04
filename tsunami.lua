-- [[ MATSUHUB TSUNAMI - NO-FRAME EDITION ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubNoFrame"

-- Botão M (Para fechar/abrir os botões)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 60)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = Color3.fromRGB(0, 85, 255), "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold, 25
Instance.new("UICorner", ToggleBtn)

-- Container Invisível
local Holder = Instance.new("Frame", sgui)
Holder.Size, Holder.Position = UDim2.new(0, 260, 0, 150), UDim2.new(0.5, -130, 0.5, -75)
Holder.BackgroundTransparency = 1 -- TOTALMENTE INVISÍVEL
Holder.Visible = true

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", Holder)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 50), pos
    b.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
    b.Text, b.TextColor3 = t, Color3.fromRGB(255, 255, 255)
    b.Font, b.TextSize = Enum.Font.GothamBold, 16
    Instance.new("UICorner", b)
    local s = Instance.new("UIStroke", b)
    s.Color, s.Thickness = Color3.fromRGB(255, 255, 255), 2
    b.MouseButton1Click:Connect(function() f(b) end)
end

-- Título Flutuante
local Title = Instance.new("TextLabel", Holder)
Title.Size, Title.Position = UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, -0.3, 0)
Title.BackgroundTransparency, Title.Text = 1, "MATSUHUB TSUNAMI"
Title.TextColor3, Title.Font, Title.TextSize = Color3.fromRGB(0, 85, 255), Enum.Font.GothamBold, 20

-- Funções
createBtn("Liberar Vips", UDim2.new(0.05, 0, 0.1, 0), function(b)
    b.Text = "VIP ATIVO"
    task.spawn(function()
        while true do
            for _, v in pairs(workspace:GetDescendants()) do
                if (v.Name:lower():find("vip") or v.Name:lower():find("pass")) and v:IsA("BasePart") then
                    v.CanCollide, v.Transparency = false, 0.6
                end
            end
            task.wait(3)
        end
    end)
end)

createBtn("Auto Lucky", UDim2.new(0.05, 0, 0.6, 0), function(b)
    b.Text = "LUCKY ATIVO"
    task.spawn(function()
        while true do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
                    local n = v.Parent.Name:lower()
                    if n:find("lucky") or n:find("sorte") or n:find("machine") then
                        if v:IsA("ClickDetector") then fireclickdetector(v)
                        else fireproximityprompt(v) end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)

ToggleBtn.MouseButton1Click:Connect(function() Holder.Visible = not Holder.Visible end)
