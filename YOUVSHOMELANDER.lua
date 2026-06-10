-- You VS Homelander - TempV Syringe ESP
-- Author: code001-abc
-- Features: Highlight + Big Text Label

print("TempV Syringe ESP Loaded!")

local TARGET_NAME = "TempVSyringe"
local processed = {}

local function addESP(model)
    if processed[model] then return end
    processed[model] = true

    -- Bright green highlight
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.1
    highlight.OutlineTransparency = 0.0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = model

    -- Big text label
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 200, 0, 80)
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

    print("[ESP] Found: " .. model.Name)
end

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
    Title = "✅ TempV ESP";
    Text = "Searching for TempVSyringe...";
    Duration = 3;
})
