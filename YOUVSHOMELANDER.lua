-- ФИНАЛЬНЫЙ ESP для TempVSyringe (с диагностикой)
print("ESP V (финальный) запущен!")

local TARGET_NAME = "TempVSyringe"
local highlighted = {}

local function addHighlight(obj)
    if highlighted[obj] then return end
    highlighted[obj] = true

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.1
    highlight.OutlineTransparency = 0.0
    -- Убрали DepthMode для совместимости
    highlight.Parent = obj

    print("[ESP] НАЙДЕНО И ПОДСВЕЧЕНО: " .. obj.Name .. " (" .. obj.ClassName .. ")")
    game.StarterGui:SetCore("SendNotification", {
        Title = "💉 НАЙДЕНО!";
        Text = obj.Name;
        Duration = 2;
    })
end

-- Поиск Моделей и Инструментов
spawn(function()
    while wait(0.5) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj:IsA("Model") or obj:IsA("Tool")) and obj.Name == TARGET_NAME then
                addHighlight(obj)
            end
        end
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "✅ ESP V (финал)";
    Text = "Ищу " .. TARGET_NAME .. " (модели и инструменты)";
    Duration = 3;
})
