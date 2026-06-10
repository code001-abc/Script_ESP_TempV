-- ИДЕАЛЬНЫЙ ESP для сыворотки V (модель TempVSyringe)
print("ESP V (финал) запущен!")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- === ТОЧНОЕ НАЗВАНИЕ МОДЕЛИ ===
local TARGET_NAME = "TempVSyringe"

-- === ФУНКЦИЯ ПРОВЕРКИ (только модели) ===
local function isTarget(obj)
    -- Ищем только модели (целые предметы)
    if obj:IsA("Model") and obj.Name == TARGET_NAME then
        return true
    end
    return false
end

-- === ПОДСВЕТКА ===
local highlighted = {}

local function addHighlight(model)
    if highlighted[model] then return end
    highlighted[model] = true
    
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 255, 0)  -- Зелёный
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.3
    highlight.Parent = model
    
    print("[ESP] НАЙДЕНА СЫВОРОТКА: " .. model.Name)
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "💉 СЫВОРОТКА V";
        Text = "Найдена! Иди за ней!";
        Duration = 3;
    })
end

-- === ОСНОВНОЙ ЦИКЛ ===
spawn(function()
    while wait(0.5) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if isTarget(obj) then
                addHighlight(obj)
            end
        end
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "✅ ESP V";
    Text = "Ищу модель TempVSyringe...";
    Duration = 3;
})
