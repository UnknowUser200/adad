local TweenService = game:GetService("TweenService")
local CoreGui = game:FindService("CoreGui")
local lib = {}

for i, v in next, CoreGui:GetChildren() do
    if v.Name == "ui" then
        v:Destroy()
    end
end

local ui = Instance.new("ScreenGui")
ui.Name = "ui"
ui.Parent = CoreGui
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local NotificationsHolder = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
NotificationsHolder.Name = "NotificationsHolder"
NotificationsHolder.Parent = ui
NotificationsHolder.AnchorPoint = Vector2.new(1, 1)
NotificationsHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotificationsHolder.BackgroundTransparency = 1.000
NotificationsHolder.Position = UDim2.new(1, -25, 1, -25)
NotificationsHolder.Size = UDim2.new(0, 300, 1, -25)

UIListLayout.Parent = NotificationsHolder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.Padding = UDim.new(0, 5)

local function createnotify(NotificationConfig)
    NotificationConfig.Name = NotificationConfig.Name or "Notification"
    NotificationConfig.Content = NotificationConfig.Content or "Test"
    NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://10897014055"
    NotificationConfig.Time = NotificationConfig.Time or 15

    local Notify = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIPadding = Instance.new("UIPadding")
    local Icon = Instance.new("ImageLabel")
    local Label = Instance.new("TextLabel")
    local Title = Instance.new("TextLabel")

    Notify.Name = "Notify"
    Notify.Parent = NotificationsHolder
    Notify.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Notify.Position = UDim2.new(0, 0, 0.870063722, 0)
    Notify.Size = UDim2.new(1, 0, 0, 0)
    Notify.AutomaticSize = Enum.AutomaticSize.Y

    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Notify

    UIPadding.Parent = Notify
    UIPadding.PaddingBottom = UDim.new(0, 12)
    UIPadding.PaddingLeft = UDim.new(0, 12)
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.PaddingTop = UDim.new(0, 12)

    Icon.Name = "Icon"
    Icon.Parent = Notify
    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon.BackgroundTransparency = 1.000
    Icon.BorderSizePixel = 0
    Icon.Size = UDim2.new(0, 20, 0, 20)
    Icon.ImageColor3 = Color3.fromRGB(240, 240, 240)
    Icon.Image = NotificationConfig.Image

    Label.Name = "Label"
    Label.Parent = Notify
    Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1.000
    Label.BorderSizePixel = 0
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.Size = UDim2.new(1, -30, 0, 20)
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 15.000
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = NotificationConfig.Name

    Title.Name = "Title"
    Title.Parent = Notify
    Title.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0, 0, 0, 25)
    Title.Size = UDim2.new(1, 0, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(200, 200, 200)
    Title.TextSize = 14.000
    Title.TextWrapped = true
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.AutomaticSize = Enum.AutomaticSize.Y
    Title.Text = NotificationConfig.Content
    return Notify,Icon,Label,Title
end

function lib:Notify(NotificationConfig)
    coroutine.wrap(function()
        local Notify,Icon,Label,Title = createnotify(NotificationConfig)
        wait(NotificationConfig.Time)
        TweenService:Create(Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { ImageTransparency = 1 }):Play()
        TweenService:Create(Notify, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { BackgroundTransparency = 1}):Play()
        TweenService:Create(Label, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { TextTransparency = 1 }):Play()
        TweenService:Create(Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { TextTransparency = 1 }):Play()
        Notify:Destroy()
    end)()
end

function lib:YieldNotify(NotificationConfig,data)
    assert(type(data) == 'function',"Expected function got "..type(data))
    local Notify,Icon,Label,Title = createnotify(NotificationConfig)
    data()
    TweenService:Create(Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { ImageTransparency = 1 }):Play()
    TweenService:Create(Notify, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { BackgroundTransparency = 1}):Play()
    TweenService:Create(Label, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { TextTransparency = 1 }):Play()
    TweenService:Create(Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { TextTransparency = 1 }):Play()
    Notify:Destroy()
end

return lib
