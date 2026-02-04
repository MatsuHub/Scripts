-- [[ MATSUHUB - FUJA DO TSUNAMI ]] --
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)
local VipBtn = Instance.new("TextButton", MainFrame)

local RED, BLACK, WHITE = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = RED, 2.5, Enum.ApplyStrokeMode.Border
end

ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLACK, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
ToggleBtn.ZIndex = 10
Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 150), UDim2.new(0.5, -130, 0.5, -75)
MainFrame.BackgroundColor3, MainFrame.Visible = BLACK, true
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency, Header.Text = 1, "MATSUHUB TSUNAMI"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 18

VipBtn.Parent, VipBtn.Size = MainFrame, UDim2.new(0.9, 0, 0, 50)
VipBtn.Position, VipBtn.BackgroundColor3 = UDim2.new(0.05, 0, 0.45, 0), Color3.fromRGB(15, 15, 15)
VipBtn.Text, VipBtn.TextColor3 = "Liberar Vips", WHITE
VipBtn.Font, VipBtn.TextSize = Enum.Font.GothamBold, 16
Instance.new("UICorner", VipBtn); applyNeon(VipBtn)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

VipBtn.MouseButton1Click:Connect(function()
    VipBtn.Text = "LIBERADO!"
    VipBtn.TextColor3 = RED
    task.spawn(function()
        while true do
            for _, v in pairs(workspace:GetDescendants()) do
                if (v.Name:lower():find("vip") or v.Name:lower():find("pass")) and v:IsA("BasePart") then
                    v.CanCollide = false
                    v.Transparency = 0.6
                end
            end
            task.wait(2)
        end
    end)
end)
