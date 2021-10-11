print("Initiated15653536")
local Universus = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Mouse = game.Players.LocalPlayer:GetMouse()

local MainGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local ContentFrame = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local Menu = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local UIGradient = Instance.new("UIGradient")
local UIGradient_2 = Instance.new("UIGradient")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")
local UICorner_4 = Instance.new("UICorner")
local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
local UIGradient_3 = Instance.new("UIGradient")
local UIGradient_4 = Instance.new("UIGradient")
local Circle = Instance.new("ImageLabel")
local NotificationHolder = Instance.new("Frame")

Circle.Name = "Circle"
Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Circle.BackgroundTransparency = 1.000
Circle.ZIndex = 10
Circle.Image = "rbxassetid://266543268"
Circle.ImageColor3 = Color3.fromRGB(0, 0, 0)
Circle.ImageTransparency = 0.900

NotificationHolder.Name = "NotificationHolder"
NotificationHolder.Parent = MainGui
NotificationHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotificationHolder.BackgroundTransparency = 1.000
NotificationHolder.Position = UDim2.new(-4.46816664e-08, 0, 0, 0)
NotificationHolder.Size = UDim2.new(0.192891866, 0, 0.989010155, 0)

function CircleClick(Button, X, Y)
	coroutine.resume(coroutine.create(function()
		
		Button.ClipsDescendants = true
		
		local Circle = Circle:Clone()
			Circle.Parent = Button
			local NewX = X - Circle.AbsolutePosition.X
			local NewY = Y - Circle.AbsolutePosition.Y
			Circle.Position = UDim2.new(0, NewX, 0, NewY)
		
		local Size = 0
			if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
				 Size = Button.AbsoluteSize.X*1.5
			elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
				 Size = Button.AbsoluteSize.Y*1.5
			elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then																										Size = Button.AbsoluteSize.X*1.5
			end
		
		local Time = 1
			Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
			for i=1,10 do
				Circle.ImageTransparency = Circle.ImageTransparency + 0.01
				wait(Time/10)
			end
			Circle:Destroy()	
	end))
end



function notification(content)
	local UIListLayout = Instance.new("UIListLayout")
local Notification = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local MainFrame = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local TextButton = Instance.new("TextButton")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local UIGradient_2 = Instance.new("UIGradient")

UIListLayout.Parent = NotificationHolder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.Padding = UDim.new(0.0250000004, 0)

Notification.Name = "Notification"
Notification.Parent = NotificationHolder
Notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Notification.Position = UDim2.new(0.0445000045, 0, 0.913579404, 0)
Notification.Size = UDim2.new(0.911000013, 0, 0.0864206254, 0)

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Notification

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(96, 202, 249)), ColorSequenceKeypoint.new(0.24, Color3.fromRGB(197, 164, 251)), ColorSequenceKeypoint.new(0.52, Color3.fromRGB(223, 157, 255)), ColorSequenceKeypoint.new(0.77, Color3.fromRGB(207, 182, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(183, 227, 233))}
UIGradient.Parent = Notification

MainFrame.Name = "MainFrame"
MainFrame.Parent = Notification
MainFrame.BackgroundColor3 = Color3.fromRGB(31, 33, 30)
MainFrame.Position = UDim2.new(0.0124979345, 0, 0.0426586121, 0)
MainFrame.Size = UDim2.new(0.969887078, 0, 0.89530015, 0)

UICorner_2.CornerRadius = UDim.new(0, 10)
UICorner_2.Parent = MainFrame

TextButton.Parent = MainFrame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.Size = UDim2.new(1, 0, 1, 0)
TextButton.Font = Enum.Font.ArialBold
TextButton.Text = content
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true

UITextSizeConstraint.Parent = TextButton
UITextSizeConstraint.MaxTextSize = 20

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(96, 202, 249)), ColorSequenceKeypoint.new(0.24, Color3.fromRGB(197, 164, 251)), ColorSequenceKeypoint.new(0.52, Color3.fromRGB(223, 157, 255)), ColorSequenceKeypoint.new(0.77, Color3.fromRGB(207, 182, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(183, 227, 233))}
UIGradient_2.Parent = TextButton
	
	coroutine.wrap(function()
		while wait() do
			UIGradient.Rotation += 1
		end
	end)()
	
	TextButton.MouseButton1Click:Connect(function()
		Notification:Destroy()
	end)
	
	
end

MainGui.Name = "MainGui"
MainGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

MainFrame.Name = "MainFrame"
MainFrame.Parent = MainGui
MainFrame.BackgroundColor3 = Color3.fromRGB(31, 33, 30)
MainFrame.Position = UDim2.new(0.445827246, 0, 0.205997393, 0)
MainFrame.Size = UDim2.new(0.277, 0,0.324, 0)
MainFrame.ZIndex = 2

UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 44, 39)
ContentFrame.Position = UDim2.new(0.245680958, 0, 0.086102128, 0)
ContentFrame.Size = UDim2.new(0.754318833, 0, 0.913897872, 0)
ContentFrame.ZIndex = 2

UICorner_2.CornerRadius = UDim.new(0, 6)
UICorner_2.Parent = ContentFrame

Menu.Name = "Menu"
Menu.Parent = ContentFrame
Menu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Menu.BackgroundTransparency = 1.000
Menu.Size = UDim2.new(1, 0, 1, 0)
Menu.ZIndex = 2

UIListLayout.Parent = Menu
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0.0500000007, 0)

UIPadding.Parent = Menu
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingTop = UDim.new(0, 10)

function Universus:Prt(name,callback)
  callback = callback or function() end
local Button = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextButton = Instance.new("TextButton")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local UIGradient = Instance.new("UIGradient")
local UIGradient_2 = Instance.new("UIGradient")

Button.Name = "Button"
Button.Parent = Menu
Button.BackgroundColor3 = Color3.fromRGB(98, 104, 95)
Button.Position = UDim2.new(0.136000007, 0, 0.42899999, 0)
Button.Size = UDim2.new(0.965, 0,0.132, 0)
Button.ZIndex = 2

UICorner.Parent = Button

TextButton.Parent = Button
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.Size = UDim2.new(1, 0, 1, 0)
TextButton.ZIndex = 2
TextButton.Font = Enum.Font.GothamBold
TextButton.Text = name
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true
TextButton.TextScaled = true

UITextSizeConstraint.Parent = TextButton
UITextSizeConstraint.MaxTextSize = 20

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(96, 202, 249)), ColorSequenceKeypoint.new(0.24, Color3.fromRGB(197, 164, 251)), ColorSequenceKeypoint.new(0.52, Color3.fromRGB(223, 157, 255)), ColorSequenceKeypoint.new(0.77, Color3.fromRGB(207, 182, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(183, 227, 233))}
UIGradient.Parent = TextButton

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(96, 202, 249)), ColorSequenceKeypoint.new(0.24, Color3.fromRGB(197, 164, 251)), ColorSequenceKeypoint.new(0.52, Color3.fromRGB(223, 157, 255)), ColorSequenceKeypoint.new(0.77, Color3.fromRGB(207, 182, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(183, 227, 233))}
UIGradient_2.Parent = Button
  
  TextButton.MouseEnter:Connect(function()
	local tween = TweenService:Create(UIGradient_2, TweenInfo.new(.25), {["Rotation"] = 180});tween:Play()
	local tween = TweenService:Create(Button, TweenInfo.new(.25), {["BackgroundColor3"] = Color3.fromRGB(175, 186, 170)});tween:Play()
end)
  
  TextButton.MouseLeave:Connect(function()
	local tween = TweenService:Create(UIGradient_2, TweenInfo.new(.25), {["Rotation"] = 0});tween:Play()
	local tween = TweenService:Create(Button, TweenInfo.new(.25), {["BackgroundColor3"] = Color3.fromRGB(98, 104, 95)});tween:Play()
end)
  
  TextButton.MouseButton1Click:Connect(function()
	CircleClick(TextButton, Mouse.X, Mouse.Y) 
      callback()
   end)

end
return Universus
