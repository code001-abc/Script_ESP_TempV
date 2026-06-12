-- ============================================
-- TempV ESP HUB by code001-abc
-- Features: Moveable Window + ESP (Syringe + Players)
-- ============================================

print("TempV ESP HUB загружен!")

local TARGET_NAME = "TempVSyringe"
local espSyringeActive = true
local espPlayersActive = true
local syringeHighlights = {}
local playerHighlights = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- === GUI ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TempV_HUB"
screenGui.Parent = game:GetService("CoreGui")

-- Окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 240, 0, 180)
mainFrame.Position = UDim2.new(0, 50, 0, 200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Parent = screenGui

-- Заголовок (за него тащим)
local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.Text = "🔧 TempV ESP HUB  (тяни меня)"
titleBar.TextColor3 = Color3.fromRGB(0, 255, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
titleBar.BackgroundTransparency = 0.3
titleBar.TextXAlignment = Enum.TextXAlignment.Center
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 14
titleBar.Parent = mainFrame

-- Кнопка минус (свернуть)
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 25)
minBtn.Position = UDim2.new(1, -35, 0, 3)
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.Parent = mainFrame

-- Кнопка ESP сыворотка
local syringeBtn = Instance.new("TextButton")
syringeBtn.Size = UDim2.new(0, 200, 0, 35)
syringeBtn.Position = UDim2.new(0.5, -100, 0, 45)
syringeBtn.Text = "🟢 ESP СЫВОРОТКА: ВКЛ"
syringeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
syringeBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
syringeBtn.Font = Enum.Font.GothamBold
syringeBtn.TextSize = 12
syringeBtn.Parent = mainFrame

-- Кнопка ESP игроки
local playersBtn = Instance.new("TextButton")
playersBtn.Size = UDim2.new(0, 200, 0, 35)
playersBtn.Position = UDim2.new(0.5, -100, 0, 90)
playersBtn.Text = "🟢 ESP ИГРОКИ: ВКЛ"
playersBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
playersBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
playersBtn.Font = Enum.Font.GothamBold
playersBtn.TextSize = 12
playersBtn.Parent = mainFrame

-- Кнопка открытия (когда окно свёрнуто)
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 20, 0, 250)
openBtn.Text = "🔴🔵"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 20
openBtn.Visible = false
openBtn.Parent = screenGui

-- Статус
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 1, -25)
status.Text = "Готов"
status.TextColor3 = Color3.fromRGB(150, 150, 150)
status.BackgroundTransparency = 1
status.TextSize = 11
status.Parent = mainFrame

-- ========== ПЕРЕМЕЩЕНИЕ ОКНА ==========
local drag = false
local dragStartPos
local frameStartPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        drag = true
        dragStartPos = input.Position
        frameStartPos = mainFrame.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        drag = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if drag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartPos
        mainFrame.Position = UDim2.new(
            frameStartPos.X.Scale, 
            frameStartPos.X.Offset + delta.X,
            frameStartPos.Y.Scale, 
            frameStartPos.Y.Offset + delta.Y
        )
    end
end)

-- ========== СВЁРТЫВАНИЕ ==========
minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openBtn.Visible = false
end)

-- ========== ESP СЫВОРОТКА ==========
local function addSyringeESP(model)
    if syringeHighlights[model] then return end
    syringeHighlights[model] = true
    
    local hl = Instance.new("Highlight")
    hl.FillColor = Color3.fromRGB(0, 255, 0)
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.1
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = model
    
    local bill = Instance.new("BillboardGui")
    bill.Size = UDim2.new(0, 200, 0, 60)
    bill.StudsOffset = Vector3.new(0, 2.5, 0)
    bill.AlwaysOnTop = true
    bill.Parent = model
    
    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Text = "💉 TEMP V 💉"
    txt.TextColor3 = Color3.fromRGB(0, 255, 0)
    txt.TextScaled = true
    txt.Font = Enum.Font.GothamBold
    txt.TextStrokeTransparency = 0
    txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    txt.Parent = bill
    
    status.Text = "✅ Найдена сыворотка!"
    task.wait(2)
    if espSyringeActive then status.Text = "Поиск сыворотки..." end
end

local function clearSyringeESP()
    for model, _ in pairs(syringeHighlights) do
        local hl = model:FindFirstChild("Highlight")
        if hl then hl:Destroy() end
        local bill = model:FindFirstChild("BillboardGui")
        if bill then bill:Destroy() end
    end
    syringeHighlights = {}
end

-- ========== ESP ИГРОКИ ==========
local function addPlayerESP(player)
    if player == LocalPlayer then return end
    if not player.Character then return end
    if playerHighlights[player] then return end
    
    local hl = Instance.new("Highlight")
    hl.FillColor = Color3.fromRGB(255, 100, 0)
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.3
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = player.Character
    
    local bill = Instance.new("BillboardGui")
    bill.Size = UDim2.new(0, 150, 0, 40)
    bill.StudsOffset = Vector3.new(0, 2.5, 0)
    bill.AlwaysOnTop = true
    bill.Parent = player.Character
    
    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Text = "👤 " .. player.Name
    txt.TextColor3 = Color3.fromRGB(255, 100, 0)
    txt.TextScaled = true
    txt.Font = Enum.Font.GothamBold
    txt.TextStrokeTransparency = 0
    txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    txt.Parent = bill
    
    playerHighlights[player] = {hl = hl, bill = bill}
end

local function clearPlayerESP()
    for player, data in pairs(playerHighlights) do
        if data.hl then data.hl:Destroy() end
        if data.bill then data.bill:Destroy() end
    end
    playerHighlights = {}
end

-- ========== КНОПКИ ==========
syringeBtn.MouseButton1Click:Connect(function()
    espSyringeActive = not espSyringeActive
    if espSyringeActive then
        syringeBtn.Text = "🟢 ESP СЫВОРОТКА: ВКЛ"
        syringeBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj:IsA("Model") or obj:IsA("Tool")) and obj.Name == TARGET_NAME then
                addSyringeESP(obj)
            end
        end
        status.Text = "ESP сыворотки включён"
    else
        syringeBtn.Text = "🔴 ESP СЫВОРОТКА: ВЫКЛ"
        syringeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        clearSyringeESP()
        status.Text = "ESP сыворотки выключен"
    end
end)

playersBtn.MouseButton1Click:Connect(function()
    espPlayersActive = not espPlayersActive
    if espPlayersActive then
        playersBtn.Text = "🟢 ESP ИГРОКИ: ВКЛ"
        playersBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        for _, plr in pairs(Players:GetPlayers()) do
            addPlayerESP(plr)
        end
        status.Text = "ESP игроков включён"
    else
        playersBtn.Text = "🔴 ESP ИГРОКИ: ВЫКЛ"
        playersBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        clearPlayerESP()
        status.Text = "ESP игроков выключен"
    end
end)

-- ========== ОБРАБОТЧИКИ СОБЫТИЙ ==========
workspace.DescendantAdded:Connect(function(obj)
    if espSyringeActive and (obj:IsA("Model") or obj:IsA("Tool")) and obj.Name == TARGET_NAME then
        task.wait(0.1)
        addSyringeESP(obj)
    end
end)

for _, obj in pairs(workspace:GetDescendants()) do
    if espSyringeActive and (obj:IsA("Model") or obj:IsA("Tool")) and obj.Name == TARGET_NAME then
        addSyringeESP(obj)
    end
end

Players.PlayerAdded:Connect(function(plr)
    if espPlayersActive then
        plr.CharacterAdded:Connect(function()
            addPlayerESP(plr)
        end)
    end
end)

for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        addPlayerESP(plr)
        plr.CharacterAdded:Connect(function()
            if espPlayersActive then
                addPlayerESP(plr)
            end
        end)
    end
end

-- ========== СТАРТ ==========
game.StarterGui:SetCore("SendNotification", {
    Title = "✅ TempV ESP HUB";
    Text = "Окно можно перемещать! Тяни за заголовок";
    Duration = 4;
})
print("TempV ESP HUB готов | Перемещай окно за заголовок")
