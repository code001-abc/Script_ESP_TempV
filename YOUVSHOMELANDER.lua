-- МАКСИМАЛЬНО ЯРКИЙ И СТАБИЛЬНЫЙ ESP ДЛЯ ТЕЛЕФОНА
print("SUPER BRIGHT ESP ЗАПУЩЕН")

local TargetItem = "TempVSyringe"

-- Функция, которая добавляет невероятно яркую подсветку
local function MakeItGlow(object)
    -- Удаляем старую подсветку, если она есть
    local old = object:FindFirstChild("ESP_Highlight")
    if old then old:Destroy() end

    -- Создаём новую подсветку
    local glow = Instance.new("Highlight")
    glow.Name = "ESP_Highlight"
    glow.FillColor = Color3.fromRGB(0, 255, 0)   -- Зелёный
    glow.OutlineColor = Color3.fromRGB(255, 255, 255) -- Белая обводка
    glow.FillTransparency = 0.1   -- Почти не прозрачный
    glow.OutlineTransparency = 0.0
    glow.Parent = object
    
    print("ЯРКО ПОДСВЕЧЕНО: " .. object.Name)
end

-- Бесконечный цикл поиска
while true do
    -- Ищем все объекты в мире
    for _, item in pairs(workspace:GetDescendants()) do
        -- Если это модель или инструмент и имя совпадает
        if (item:IsA("Model") or item:IsA("Tool")) and item.Name == TargetItem then
            MakeItGlow(item)
        end
    end
    wait(0.5) -- Пауза, чтобы телефон не грелся
end
