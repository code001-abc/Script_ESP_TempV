-- You VS Homelander - TempV Syringe ESP (Safe & Optimized)
-- Author: code001-abc & AI Collaborator
-- Features: Bright Green Highlight + Big Text Label + Anti-Bait Protection

print("TempV Syringe ESP (Anti-Lag & Anti-Bait) Loaded!")

local TARGET_NAME = "TempVSyringe"
local MIN_HEIGHT = -100 -- Игнорировать всё, что зарыто глубоко под картой (ловушки админов)
local processed = {}

local function addESP(model)
    if processed[model] then return end
    
    -- Проверка на ловушку (HoneyPot) по высоте
    -- Сначала проверяем, есть ли у объекта координаты (PrimaryPart или Handle)
    local rootPart = model:IsA("Model") and (model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")) or model:FindFirstChild("Handle")
    if rootPart and rootPart.Position.Y < MIN_HEIGHT then
        print("[ESP Warning] Blocked potential honey-pot trap at Y: " .. tostring(rootPart.Position.Y))
        return
    end

    processed[model] = true

    -- Яркая зелёная подсветка
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.1
    highlight.OutlineTransparency = 0.0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = model

    -- Огромная надпись TEMP V
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 250, 0, 80)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = model

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "💉 TEMP V 💉"
    textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    textLabel.TextSize = 40
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Parent = billboard

    print("[ESP] Found TempV Syringe: " .. model.Name)
end

-- Оптимизированный поиск: проверяем то, что уже есть на карте
for _, obj in pairs(workspace:GetDescendants()) do
    if (obj:IsA("Model") or obj:IsA("Tool")) and obj.Name == TARGET_NAME then
        addESP(obj)
    end
end

-- Вместо тяжелого цикла следим только за НОВЫМИ появляющимися предметами
workspace.DescendantAdded:Connect(function(obj)
    if (obj:IsA("Model") or obj:IsA("Tool")) and obj.Name == TARGET_NAME then
        -- Небольшая задержка, чтобы объект успел загрузиться и встать на свою позицию
        task.wait(0.1) 
        addESP(obj)
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "✅ TempV ESP";
    Text = "Safe ESP is actively scanning...";
    Duration = 3;
})
