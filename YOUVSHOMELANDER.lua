-- ESP СЫВОРОТКА V: подсветка + огромная надпись TEMP V
print("ESP V (с надписью) запущен!")

local TARGET_NAME = "TempVSyringe"
local processed = {}

-- === ФУНКЦИЯ ДОБАВЛЕНИЯ НАДПИСИ И ПОДСВЕТКИ ===
local function addESP(model)
    if processed[model] then return end
    processed[model] = true

    -- 1. Яркая подсветка
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.1
    highlight.OutlineTransparency = 0.0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = model

    -- 2. Огромная надпись TEMP V (видна издалека)
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 200, 0, 80)  -- Ширина 200, высота 80
    billboard.StudsOffset = Vector3.new(0, 3, 0)  -- Над предметом
    billboard.AlwaysOnTop = true
    billboard.Parent = model

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "💉 TEMP V 💉"
    textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)  -- Ярко-зелёный
    textLabel.TextSize = 40  -- Огромный шрифт
    textLabel.TextScaled = true  -- Масштабируется под размер окна
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Parent = billboard

    print("[ESP] Найдена сыворотка: " .. model.Name .. " (надпись добавлена)")
end

-- === ОСНОВНОЙ ЦИКЛ ===
spawn(function()
    while wait(0.5) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj:IsA("Model") or obj:IsA("Tool")) and obj.Name == TARGET_NAME then
                addESP(obj)
            end
        end
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "✅ ESP V + НАДПИСЬ";
    Text = "Ищу TempVSyringe... Будет видно издалека!";
    Duration = 3;
})
