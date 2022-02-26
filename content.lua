-- Gui to Lua
-- Version: 3.2

-- Instances:
--game:GetService("Players").LocalPlayer.Character:FindFirstChild("Building Tools").SyncAPI.ServerEndpoint


--This is where the F3X remote is located. Some versions handle data differently, though most are consistant. This works with AH.
F3XENDPOINT = game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint
SPAWNAT = workspace



local TweenService = game:GetService("TweenService")

local Shop = Instance.new("ScreenGui")
local MainFrame = Instance.new("ImageLabel")
local Banner = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Icon = Instance.new("ImageLabel")
local UIGradient = Instance.new("UIGradient")
local Description = Instance.new("TextLabel")
local ID = Instance.new("TextBox")
local Load = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Banner2 = Instance.new("Frame")
local TextLabel_2 = Instance.new("TextLabel")
local Description2 = Instance.new("TextLabel")
local ScaleRatio = Instance.new("TextBox")
local Scale = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Selection = Instance.new("TextLabel")



function movePreview(modal)
	local items = modal:GetDescendants()
	local player = game.Players.LocalPlayer
	local newGroup = Instance.new("Model",game.Workspace)
	for _,v in ipairs(modal:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Parent = newGroup
			v.Anchored = true
		end
	end

	local orientation, size = newGroup:GetBoundingBox()
	local hitbox = Instance.new("Part",newGroup)
	hitbox.Transparency = 0.5
	hitbox.Color = Color3.fromRGB(102, 51, 153)
	hitbox.Size = size
	hitbox.CFrame = orientation
	hitbox.CanCollide = false
	hitbox.Anchored = true
	hitbox.Name = "Model-Hitbox"


	newGroup.PrimaryPart = hitbox

	local previewitem = newGroup
	local mouse = player:GetMouse()
	local moving = true

	grid = 1

	local target = nil
	local pos = nil
	local norm = nil
	local rot = 0
	local rotT = 0

	local MAX_PLACEMENT_DISTANCE = 99999

	function doFakeMouseStuff()
		if moving == true then
			local ignoreList = {previewitem}	--game.Workspace:WaitForChild("BaseStore"):GetChildren()
			local mouseRay = mouse.UnitRay
			local newRay = Ray.new(mouseRay.Origin, mouseRay.Direction.unit * MAX_PLACEMENT_DISTANCE)
			target, pos, norm = workspace:FindPartOnRayWithIgnoreList(newRay, ignoreList)
		end
	end


	mouse.Move:connect(function()
		if previewitem and pos and norm then
			doFakeMouseStuff()	-- Just to be cetain that the data is up to date.
			local endPos = pos + (norm * (previewitem.PrimaryPart.Size*.5))
			local endPosX = math.floor(endPos.X / grid + 0.5) * grid
			local endPosY = math.floor(endPos.Y / grid + 0.5) * grid
			local endPosZ = math.floor(endPos.Z / grid + 0.5) * grid
			previewitem:SetPrimaryPartCFrame(CFrame.new(endPosX,endPosY,endPosZ))
		end
	end)

	mouse.Button1Down:Connect(function()
		newGroup["Model-Hitbox"]:Destroy()
		moving = false
	end)
	while moving == true do
		doFakeMouseStuff()
		game:GetService("RunService").Heartbeat:wait()
	end
	newGroup.Parent = game.ReplicatedStorage
	return newGroup
end


function getSelection()
	for _, e in ipairs(game.Players.LocalPlayer.PlayerGui["Building Tools by F3X (UI)"]:GetChildren()) do
		if e:IsA("SelectionBox") and e.Name == "BTSelectionBox" then
			if e.Adornee ~= nil then
				return e.Adornee
			end
		end
	end
end



local function scaleModel(model,scale)
	local function fireRemote(instance,args)
		local success, err = pcall(function()
			instance:InvokeServer(unpack(args))
		end)
		if not success then
			warn(err)
			task.wait()
			return fireRemote(instance, args)
		end
	end

	ie = 0
	local args = {
		[1] = "SyncResize",
		[2] = {}
	}

	local items = model:GetChildren()
	local PrimaryPartCFrame = items[math.random(1, #items)].CFrame

	--Scale BaseParts
	for _,object in pairs(model:GetDescendants()) do
		if object:IsA('BasePart') then
			ie = ie + 1

			local distance = (object.Position - PrimaryPartCFrame.p)
			local rotation = (object.CFrame - object.Position)

			args[2][ie] = {["Part"] = object,["CFrame"] = (CFrame.new(PrimaryPartCFrame.p + distance*scale) * rotation),["Size"] = object.Size*scale}

		end
	end
	fireRemote(F3XENDPOINT,args)
end



local function loadModel(id)
	ie = 0

	local Sizeargs = {
		[1] = "SyncResize",
		[2] = {}
	}

	local Colorargs = {
		[1] = "SyncColor",
		[2] = {
			[1] = {

			}
		}
	}

	local Materialargs = {
		[1] = "SyncMaterial",
		[2] = {

		}
	}

	local Collisionargs = {
		[1] = "SyncCollision",
		[2] = {

		}
	}

	TextLabel.Text = "Calculating.."
	local total = 0
	local counterParts = 0

	print("Fetching data..")
	local modele = Instance.new("Model", game.ReplicatedStorage)
	game:GetObjects('rbxassetid://'..id)[1].Parent = modele
	local model = movePreview(modele)


	local offset = Vector3.new(0,0,0)

	local fireErrorRetry = 0

	local run = 0
	local part = nil
	local estimateTime = false
	local timeEstimate = 0
	local EST = 0
	isHttp = true

	local success, err = pcall(function()
		local args = {[1] = "ExtractMeshFromAsset",[2] = 16606212}
		F3XENDPOINT:InvokeServer(unpack(args))
	end)
	if not success then
		isHttp = false
	end

	print("Finished getting data")

	local function fireRemote(instance,args)
		local success, err = pcall(function()
			instance:InvokeServer(unpack(args))
		end)
		if not success then
			warn(err)
			task.wait()
			return fireRemote(instance, args)
		end
	end




	local obj = model
	for _, e in ipairs(obj:GetDescendants()) do
		if e:IsA("BasePart") then
			total += 1
		end
	end

	for _, e in ipairs(obj:GetDescendants()) do
		if e:IsA("BasePart") then
			ie += 1
			if run > 3 then
				run = 0
				estimateTime = true
				timeEstimate = tick()
				wait(fireErrorRetry)
			end
			run += 1
			counterParts += 1
			TextLabel.Text = "Loading Model.. ("..counterParts.."/"..total..")".." ["..EST.."s]"
			if e:IsA("WedgePart") then
				local args = {
					[1] = "CreatePart",
					[2] = "Wedge",
					[3] = e.CFrame,
					[4] = SPAWNAT
				}
				fireRemote(F3XENDPOINT,args)
				for _, ee in ipairs(workspace:GetDescendants()) do
					if ee:IsA("BasePart") and ee.Name ~= "FinishedPart" then
						part = ee
					end
				end


			end

			if e:IsA("TrussPart") then
				local args = {
					[1] = "CreatePart",
					[2] = "Truss",
					[3] = e.CFrame + offset,
					[4] = SPAWNAT
				}
				fireRemote(F3XENDPOINT,args)
				for _, ee in ipairs(workspace:GetDescendants()) do
					if ee:IsA("BasePart") and ee.Name ~= "FinishedPart" then
						part = ee
					end
				end


			end

			if e:IsA("Part") and e.Shape == Enum.PartType.Ball then
				local args = {
					[1] = "CreatePart",
					[2] = "Ball",
					[3] = e.CFrame + offset,
					[4] = SPAWNAT
				}
				fireRemote(F3XENDPOINT,args)

				for _, ee in ipairs(workspace:GetDescendants()) do
					if ee:IsA("BasePart") and ee.Name ~= "FinishedPart" then
						part = ee
					end
				end


			end

			if e:IsA("Part") and e.Shape ~= Enum.PartType.Ball then
				local args = {
					[1] = "CreatePart",
					[2] = "Normal",
					[3] = e.CFrame + offset,
					[4] = SPAWNAT
				}
				fireRemote(F3XENDPOINT,args)


				for _, ee in ipairs(workspace:GetDescendants()) do
					if ee:IsA("BasePart") and ee.Name ~= "FinishedPart" then
						part = ee
					end
				end
			end
			
			if e:IsA("MeshPart") then
				local args = {
					[1] = "CreatePart",
					[2] = "Normal",
					[3] = e.CFrame + offset,
					[4] = SPAWNAT
				}
				fireRemote(F3XENDPOINT,args)

				for _, ee in ipairs(workspace:GetDescendants()) do
					if ee:IsA("BasePart") and ee.Name ~= "FinishedPart" then
						part = ee
					end
				end


			end
			Sizeargs[2][ie] = {["Part"] = part,["CFrame"] = part.CFrame,["Size"] = e.Size}
			Colorargs[2][ie] = {["Color"] = e.Color,["Part"] = part,["UnionColoring"] = true}
			Materialargs[2][ie] = {["Part"] = part,["Transparency"] = e.Transparency,["Material"] = e.Material}
			Collisionargs[2][ie] = {["Part"] = part,["CanCollide"] = part.CanCollide}
			--//MESH FUNCTION
			if isHttp == true then

				local foundmesh = false
				for _, partMesh in ipairs(e:GetChildren()) do
					if partMesh:IsA("SpecialMesh") then
						foundmesh = true
					end
				end
				local obj = nil
				if foundmesh == true then
					obj = e:FindFirstChildWhichIsA("SpecialMesh")
					local args = {
						[1] = "CreateMeshes",
						[2] = {
							[1] = {
								["Part"] = part
							}
						}
					}
					fireRemote(F3XENDPOINT,args)
					if obj.MeshType ~= Enum.MeshType.FileMesh then
						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["MeshType"] = obj.MeshType,
									["Scale"] = obj.Scale,
									["Offset"] = obj.Offset,
									["Part"] = part
								}
							}
						}
						fireRemote(F3XENDPOINT,args)
					else
                        if obj.MeshId ~= "" then
						if string.find(obj.MeshId,"rbxassetid") then --rbxassetid
							local args = {
								[1] = "ExtractMeshFromAsset",
								[2] = tonumber(string.split(obj.MeshId,"//")[2])
							}

							fireRemote(F3XENDPOINT,args)
							local args = {
								[1] = "SyncMesh",
								[2] = {
									[1] = {
										["MeshType"] = obj.MeshType,
										["Scale"] = obj.Scale,
										["Offset"] = obj.Offset,
										["MeshId"] = "rbxassetid://"..string.split(obj.MeshId,"//")[2],
										["Part"] = part
									}
								}
							}
							fireRemote(F3XENDPOINT,args)
						else --https

							local args = {
								[1] = "ExtractMeshFromAsset",
								[2] = tonumber(string.split(obj.MeshId,"=")[2])
							}

							fireRemote(F3XENDPOINT,args)
							local args = {
								[1] = "SyncMesh",
								[2] = {
									[1] = {
										["MeshType"] = obj.MeshType,
										["Scale"] = obj.Scale,
										["Offset"] = obj.Offset,
										["MeshId"] = "rbxassetid://"..string.split(obj.MeshId,"=")[2],
										["Part"] = part
									}
								}
							}
							fireRemote(F3XENDPOINT,args)
						end
						end
					end



				end

				--//MESHPART FUNCTION
				local foundmeshpart = false
				if e:IsA("MeshPart") then
					foundmeshpart = true
				end

				if foundmeshpart == true then
				    if e.MeshId ~= "" then
					local args = {
						[1] = "CreateMeshes",
						[2] = {
							[1] = {
								["Part"] = part
							}
						}
					}
					fireRemote(F3XENDPOINT,args)
					if string.find(e.MeshId,"rbxassetid") then --rbxassetid
						local args = {
							[1] = "ExtractMeshFromAsset",
							[2] = tonumber(string.split(e.MeshId,"//")[2])
						}


						fireRemote(F3XENDPOINT,args)
						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["MeshType"] = Enum.MeshType.FileMesh,
									["MeshId"] = "rbxassetid://"..string.split(e.MeshId,"//")[2],
									["Part"] = part
								}
							}
						}
						fireRemote(F3XENDPOINT,args)
					else --https
						local args = {
							[1] = "ExtractMeshFromAsset",
							[2] = tonumber(string.split(e.MeshId,"=")[2])
						}

						fireRemote(F3XENDPOINT,args)
						local args = {
							[1] = "SyncMesh",
							[2] = {
								[1] = {
									["MeshType"] = Enum.MeshType.FileMesh,
									["MeshId"] = "rbxassetid://"..string.split(e.MeshId,"=")[2],
									["Part"] = part
								}
							}
						}
						fireRemote(F3XENDPOINT,args)
					end
				    end
			end
			end







			if estimateTime == true then
				estimateTime = false
				EST = math.floor((tick()-timeEstimate)*(total-counterParts))

			end


			part.Name = "FinishedPart"
		end
	end
	fireRemote(F3XENDPOINT,Sizeargs)
	wait(1)
	fireRemote(F3XENDPOINT,Colorargs)
	wait(1)
	fireRemote(F3XENDPOINT,Materialargs)
	wait(1)
	fireRemote(F3XENDPOINT,Collisionargs)
	wait(1)
	model:Destroy()
	print("Finished loading!")
	TextLabel.Text = "Load Model"
end









--Properties:

Shop.Name = "Shop"
Shop.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Shop.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = Shop
MainFrame.Active = true
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 1.000
MainFrame.BorderSizePixel = 0
MainFrame.Draggable = true
MainFrame.Position = UDim2.new(0.598096609, -68, 0.228866324, 38)
MainFrame.Selectable = true
MainFrame.Size = UDim2.new(0, 400, 0, 298)
MainFrame.ZIndex = 0
MainFrame.Image = "rbxassetid://1934624205"
MainFrame.ImageColor3 = Color3.fromRGB(249, 249, 249)
MainFrame.ScaleType = Enum.ScaleType.Slice
MainFrame.SliceCenter = Rect.new(4, 4, 252, 252)

Banner.Name = "Banner"
Banner.Parent = MainFrame
Banner.BackgroundColor3 = Color3.fromRGB(248, 189, 85)
Banner.BorderSizePixel = 0
Banner.Position = UDim2.new(0, 0, 0, 5)
Banner.Size = UDim2.new(1, 0, 0, 35)

TextLabel.Parent = Banner
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0, 20, 0, 0)
TextLabel.Size = UDim2.new(1, -20, 1, 0)
TextLabel.Font = Enum.Font.SourceSansSemibold
TextLabel.Text = "Load Model"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 25.000
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

Icon.Name = "Icon"
Icon.Parent = MainFrame
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1.000
Icon.BorderSizePixel = 0
Icon.Position = UDim2.new(0, 10, 0, 40)
Icon.Size = UDim2.new(0, 100, 0, 100)
Icon.Image = "http://www.roblox.com/asset/?id=6026568222"
Icon.ImageColor3 = Color3.fromRGB(248, 189, 85)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
UIGradient.Parent = Icon

coroutine.wrap(function()
	while wait() do
		UIGradient.Rotation += 4
	end
end)()

coroutine.wrap(function()
	while wait(.5) do
		if getSelection() ~= nil then
			Selection.Text = "Selection: "..tostring(getSelection().Name)
		else
			Selection.Text = "Selection: Nil"
		end
	end
end)()

Description.Name = "Description"
Description.Parent = MainFrame
Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Description.BackgroundTransparency = 1.000
Description.BorderSizePixel = 0
Description.Position = UDim2.new(0, 130, 0, 80)
Description.Size = UDim2.new(0, 260, 0, 88)
Description.Font = Enum.Font.SourceSans
Description.Text = [[
- If your model does not load, try re-exec
- The load time will be long, depending
  on your model size
- You must have F3X in your inv or hand
- Made by Snippy#1118
- Some models will NOT work!
]]
Description.TextColor3 = Color3.fromRGB(43, 43, 43)
Description.TextSize = 14.000
Description.TextXAlignment = Enum.TextXAlignment.Left
Description.TextYAlignment = Enum.TextYAlignment.Top

ID.Name = "ID"
ID.Parent = MainFrame
ID.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ID.BackgroundTransparency = 1.000
ID.Position = UDim2.new(0, 130, 0, 45)
ID.Size = UDim2.new(0, 260, 0, 30)
ID.Font = Enum.Font.SourceSansSemibold
ID.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
ID.PlaceholderText = "Model ID"
ID.Text = ""
ID.TextColor3 = Color3.fromRGB(43, 43, 43)
ID.TextScaled = true
ID.TextSize = 14.000
ID.TextWrapped = true

Load.Name = "Load"
Load.Parent = MainFrame
Load.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Load.Position = UDim2.new(0.0225001518, 0, 0.478211164, 0)
Load.Size = UDim2.new(0.258609205, 0, 0.0855472013, 0)
Load.Font = Enum.Font.SourceSans
Load.Text = "LOAD"
Load.TextColor3 = Color3.fromRGB(0, 170, 0)
Load.TextSize = 19.000
Load.TextWrapped = true

UICorner.Parent = Load

Banner2.Name = "Banner2"
Banner2.Parent = MainFrame
Banner2.BackgroundColor3 = Color3.fromRGB(248, 189, 85)
Banner2.BorderSizePixel = 0
Banner2.Position = UDim2.new(0, 0, 0, 180)
Banner2.Size = UDim2.new(1, 0, 0, 35)

TextLabel_2.Parent = Banner2
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0, 20, 0, 0)
TextLabel_2.Size = UDim2.new(1, -20, 1, 0)
TextLabel_2.Font = Enum.Font.SourceSansSemibold
TextLabel_2.Text = "Scale Model"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 25.000
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

Description2.Name = "Description2"
Description2.Parent = MainFrame
Description2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Description2.BackgroundTransparency = 1.000
Description2.BorderSizePixel = 0
Description2.Position = UDim2.new(0, 136, 0, 252)
Description2.Size = UDim2.new(0, 260, 0, 37)
Description2.Font = Enum.Font.SourceSans
Description2.Text = [[
- The model you select will be scaled
- A model must have only parts inside one group
]]
Description2.TextColor3 = Color3.fromRGB(43, 43, 43)
Description2.TextSize = 14.000
Description2.TextXAlignment = Enum.TextXAlignment.Left
Description2.TextYAlignment = Enum.TextYAlignment.Top

ScaleRatio.Name = "ScaleRatio"
ScaleRatio.Parent = MainFrame
ScaleRatio.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScaleRatio.BackgroundTransparency = 1.000
ScaleRatio.Position = UDim2.new(0, 130, 0, 219)
ScaleRatio.Size = UDim2.new(0, 260, 0, 30)
ScaleRatio.Font = Enum.Font.SourceSansSemibold
ScaleRatio.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
ScaleRatio.PlaceholderText = "Scale Ratio"
ScaleRatio.Text = ""
ScaleRatio.TextColor3 = Color3.fromRGB(43, 43, 43)
ScaleRatio.TextScaled = true
ScaleRatio.TextSize = 14.000
ScaleRatio.TextWrapped = true

Scale.Name = "Scale"
Scale.Parent = MainFrame
Scale.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Scale.Position = UDim2.new(0.0225000773, 0, 0.886262894, 0)
Scale.Size = UDim2.new(0.258609205, 0, 0.0840635151, 0)
Scale.Font = Enum.Font.SourceSans
Scale.Text = "Scale"
Scale.TextColor3 = Color3.fromRGB(0, 170, 0)
Scale.TextSize = 19.000
Scale.TextWrapped = true

UICorner_2.Parent = Scale

Selection.Name = "Selection"
Selection.Parent = MainFrame
Selection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Selection.BackgroundTransparency = 1.000
Selection.BorderSizePixel = 0
Selection.Position = UDim2.new(0, 10, 0, 222)
Selection.Size = UDim2.new(0, 123, 0, 18)
Selection.Font = Enum.Font.GothamSemibold
Selection.Text = "Selection: nil"
Selection.TextColor3 = Color3.fromRGB(43, 43, 43)
Selection.TextSize = 20.000
Selection.TextXAlignment = Enum.TextXAlignment.Left
Selection.TextYAlignment = Enum.TextYAlignment.Top

Load.MouseEnter:Connect(function()
	TweenService:Create(Load, TweenInfo.new(0.25), {['BackgroundColor3'] = Color3.fromRGB(255, 194, 87)}):Play()
end)

Load.MouseLeave:Connect(function()
	TweenService:Create(Load, TweenInfo.new(0.25), {['BackgroundColor3'] = Color3.fromRGB(255, 255, 255)}):Play()
end)

Load.MouseButton1Down:Connect(function()
	loadModel(ID.Text)
end)

--SCALE

Scale.MouseEnter:Connect(function()
	TweenService:Create(Scale, TweenInfo.new(0.25), {['BackgroundColor3'] = Color3.fromRGB(255, 194, 87)}):Play()
end)

Scale.MouseLeave:Connect(function()
	TweenService:Create(Scale, TweenInfo.new(0.25), {['BackgroundColor3'] = Color3.fromRGB(255, 255, 255)}):Play()
end)

Scale.MouseButton1Down:Connect(function()
	scaleModel(getSelection(),tonumber(ScaleRatio.Text))
end)
