-- СУПЕР-ЯРКИЙ ESP для TempVSyringe
print("ESP V (яркий) запущен!")

local TARGET_NAME = "TempVSyringe"

-- === ЯРКАЯ ПОДСВЕТКА ===
local function addHighlight(model)
    -- Удаляем старую подсветку, если есть
    local oldHighlight = model:FindFirstChild("Highlight")
    if oldHighlight then oldHighlight:Destroy() end
    
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 255, 0)      -- Максимально яркий зелёный
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Белая обводка
    highlight.FillTransparency = 0.1                     -- Почти непрозрачный
    highlight.OutlineTransparency = 0.0                  -- Обводка完全不 прозрачная
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Всегда поверх всего
    highlight.Parent = model
    
    print("[ESP] НАЙДЕНА СЫВОРОТКА: " .. model.Name)
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "💉 СЫВОРОТКА V";
        Text = "Найдена! Ярко-зелёная подсветка!";
        Duration = 2;
    })
end

-- === ПОИСК ===
spawn(function()
    while wait(0.3) do  -- Проверяем чаще
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == TARGET_NAME then
                addHighlight(obj)
            end
        end
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "✅ ESP V (ЯРКИЙ)";
    Text = "Ищу TempVSyringe... подсветка будет очень яркой!";
    Duration = 3;
})
