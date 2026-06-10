-- ИСПРАВЛЕННЫЙ ESP для TempVSyringe (без спама)
print("ESP V (исправленный) запущен!")

local TARGET_NAME = "TempVSyringe"
local highlighted = {}  -- Список уже подсвеченных объектов

-- === ФУНКЦИЯ ПОДСВЕТКИ ===
local function addHighlight(model)
    -- Если модель уже подсвечена — ничего не делаем
    if highlighted[model] then
        return
    end
    
    -- Создаём подсветку
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 255, 0)      -- Ярко-зелёный
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.1                     -- Минимум прозрачности
    highlight.OutlineTransparency = 0.0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = model
    
    -- Запоминаем, что модель уже подсвечена
    highlighted[model] = true
    
    -- Сообщаем в консоль (только 1 раз за предмет)
    print("[ESP] СЫВОРОТКА НАЙДЕНА И ПОДСВЕЧЕНА: " .. model.Name)
    
    -- Показываем уведомление (только 1 раз)
    game.StarterGui:SetCore("SendNotification", {
        Title = "💉 СЫВОРОТКА V";
        Text = "Найдена и подсвечена!";
        Duration = 2;
    })
end

-- === ОСНОВНОЙ ЦИКЛ ===
spawn(function()
    while wait(0.5) do
        for _, obj in pairs(workspace:GetDescendants()) do
            -- Проверяем, является ли объект целевой моделью
            if obj:IsA("Model") and obj.Name == TARGET_NAME then
                addHighlight(obj)
            end
        end
    end
end)

-- Стартовое уведомление
game.StarterGui:SetCore("SendNotification", {
    Title = "✅ ESP V";
    Text = "Ищу TempVSyringe... Без спама!";
    Duration = 3;
})
