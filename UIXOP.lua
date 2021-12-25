local SciWareLib = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		local Tween = tween:Create(object, TweenInfo.new(0.2), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
				input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	input.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

function Utility:TweenObject(obj, properties, duration, ...)
	tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end


local themes = {
	SchemeColor = Color3.fromRGB(74, 99, 135),
	Background = Color3.fromRGB(36, 37, 43),
	Header = Color3.fromRGB(255, 255, 255),
	TextColor = Color3.fromRGB(255,255,255),
	ElementColor = Color3.fromRGB(32, 32, 38)
}
local themeStyles = {
	Dis = {
		SchemeColor = Color3.fromRGB(64, 64, 64),
		Background = Color3.fromRGB(10,10,10),
		Header = Color3.fromRGB(0, 0, 0),
		TextColor = Color3.fromRGB(255,255,255),
		ElementColor = Color3.fromRGB(20, 20, 20)
	}
}
local oldTheme = ""

local SettingsT = {

}

local Name = "SciWare.lua"

pcall(function()

	if not pcall(function() readfile(Name) end) then
		writefile(Name, game:service'HttpService':JSONEncode(SettingsT))
	end

	Settings = game:service'HttpService':JSONEncode(readfile(Name))
end)

local LibName = "SciWare[1.001]"

do  local ui =  game:GetService("CoreGui"):FindFirstChild(LibName)  if ui then ui:Destroy() end end

function SciWareLib:ToggleUI()
	if game.CoreGui[LibName].Enabled then
		game.CoreGui[LibName].Enabled = false
	else
		game.CoreGui[LibName].Enabled = true
	end
end

function SciWareLib.CreateLib(SciName, themeList)
	if not themeList then
		themeList = themes
	end
	if themeList == "Dis" then
		themeList = themeStyles.Dis
	end

	themeList = themeList or {}
	local selectedTab
	SciName = SciName or "Library"
	table.insert(SciWareLib, SciName)
	for i,v in pairs(game.CoreGui:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name == SciName then
			v:Destroy()
		end
	end



	local ScreenGui = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local MainCorner = Instance.new("UICorner")
	local MainHeader = Instance.new("Frame")
	local headerCover = Instance.new("UICorner")
	local coverup = Instance.new("Frame")
	local title = Instance.new("TextLabel")
	local MainSide = Instance.new("Frame")
	local sideCorner = Instance.new("UICorner")
	local coverup_2 = Instance.new("Frame")
	local tabFrames = Instance.new("Frame")
	local tabListing = Instance.new("UIListLayout")
	local pages = Instance.new("Frame")
	local Pages = Instance.new("Folder")
	local infoContainer = Instance.new("Frame")

	local blurFrame = Instance.new("Frame")

	MakeDraggable(MainHeader,Main)

	blurFrame.Name = "blurFrame"
	blurFrame.Parent = pages
	blurFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
	blurFrame.BackgroundTransparency = 1
	blurFrame.BorderSizePixel = 0
	blurFrame.Position = UDim2.new(-0.0222222228, 0, -0.0371747203, 0)
	blurFrame.Size = UDim2.new(0, 376, 0, 289)
	blurFrame.ZIndex = 999

	ScreenGui.Parent = game.CoreGui
	ScreenGui.Name = LibName
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false

	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = themeList.Background
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true
	Main.Position = UDim2.new(0.336503863, 0, 0.275485456, 0)
	Main.Size = UDim2.new(0, 500, 0, 310)

	MainCorner.CornerRadius = UDim.new(0, 5)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = Main

	local MainStroke = Instance.new("UIStroke")
	MainStroke.Parent = Main
	MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	MainStroke.Color = Color3.fromRGB(25,25,25)
	MainStroke.Thickness = 2

	MainHeader.Name = "MainHeader"
	MainHeader.Parent = Main
	MainHeader.BackgroundColor3 = Color3.fromRGB(5,5,5)
	MainHeader.Size = UDim2.new(0, 525, 0, 29)
	headerCover.CornerRadius = UDim.new(0, 4)
	headerCover.Name = "headerCover"
	headerCover.Parent = MainHeader

	coverup.Name = "coverup"
	coverup.Parent = MainHeader
	coverup.BackgroundColor3 = Color3.fromRGB(10,10,10)
	coverup.BorderSizePixel = 0
	coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
	coverup.Size = UDim2.new(0, 525, 0, 7)

	title.Name = "title"
	title.Parent = MainHeader
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1.000
	title.BorderSizePixel = 0
	title.Position = UDim2.new(0.0171428565, 0, 0.344827592, 0)
	title.Size = UDim2.new(0, 204, 0, 2)
	title.Font = Enum.Font.SourceSansSemibold
	title.RichText = true
	title.Text = SciName
	title.TextColor3 = Color3.fromRGB(245, 245, 245)
	title.TextSize = 16.000
	title.TextXAlignment = Enum.TextXAlignment.Left

	MainSide.Name = "MainSide"
	MainSide.Parent = Main
	MainSide.BackgroundColor3 = themeList.Background
	MainSide.BackgroundTransparency = 1
	MainSide.Position = UDim2.new(-7.4505806e-09, 0, 0.0911949649, 0)
	MainSide.Size = UDim2.new(0, 149, 0, 289)

	sideCorner.CornerRadius = UDim.new(0, 4)
	sideCorner.Name = "sideCorner"
	sideCorner.Parent = MainSide

	coverup_2.Name = "coverup"
	coverup_2.Parent = MainSide
	coverup_2.BackgroundColor3 = themeList.Header
	coverup_2.BackgroundTransparency = 1
	coverup_2.BorderSizePixel = 0
	coverup_2.Position = UDim2.new(0.949939311, 0, 0, 0)
	coverup_2.Size = UDim2.new(0, 7, 0, 289)

	tabFrames.Name = "tabFrames"
	tabFrames.Parent = MainSide
	tabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tabFrames.BackgroundTransparency = 1.000
	tabFrames.Position = UDim2.new(0.0438990258, 0, -0.00066378375, 0)
	tabFrames.Size = UDim2.new(0, 135, 0, 283)

	tabListing.Name = "tabListing"
	tabListing.Parent = tabFrames
	tabListing.SortOrder = Enum.SortOrder.LayoutOrder
	tabListing.Padding = UDim.new(0, 5)

	pages.Name = "pages"
	pages.Parent = Main
	pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	pages.BackgroundTransparency = 1.000
	pages.BorderSizePixel = 0
	pages.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
	pages.Size = UDim2.new(0, 360, 0, 269)

	Pages.Name = "Pages"
	Pages.Parent = pages

	infoContainer.Name = "infoContainer"
	infoContainer.Parent = Main
	infoContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	infoContainer.BackgroundTransparency = 1.000
	infoContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
	infoContainer.ClipsDescendants = true
	infoContainer.Position = UDim2.new(0.299047619, 0, 0.874213815, 0)
	infoContainer.Size = UDim2.new(0, 368, 0, 33)

	local library = {toggledui = false;}
	game:GetService("UserInputService").InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.RightControl or input.KeyCode == Enum.KeyCode.P  then
			if library.toggledui == false then
				library.toggledui = true
				tween:Create(Main,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Size = UDim2.new(0, 0, 0, 318)}):Play()
				tween:Create(MainStroke,TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),{Transparency = 1}):Play()
			else
				library.toggledui = false
				tween:Create(Main,TweenInfo.new(0.4,Enum.EasingStyle.Back),{Size = UDim2.new(0, 525, 0, 318)}):Play()
				tween:Create(MainStroke,TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),{Transparency = 0}):Play()
			end
		end
	end)


	function SciWareLib:ChangeColor(prope,color)
		if prope == "Background" then
			themeList.Background = color
		elseif prope == "SchemeColor" then
			themeList.SchemeColor = color
		elseif prope == "Header" then
			themeList.Header = color
		elseif prope == "TextColor" then
			themeList.TextColor = color
		elseif prope == "ElementColor" then
			themeList.ElementColor = color
		end
	end
	local Tabs = {}

	local first = true

	function Tabs:NewTab(tabName)
		tabName = tabName or "Tab"
		local tabButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local page = Instance.new("ScrollingFrame")
		local pageListing = Instance.new("UIListLayout")
		local Blank = Instance.new("Frame")

		local function UpdateSize()
			local cS = pageListing.AbsoluteContentSize

			game.TweenService:Create(page, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				CanvasSize = UDim2.new(0,cS.X,0,cS.Y)
			}):Play()
		end

		page.Name = "Page"
		page.Parent = Pages
		page.Active = true
		page.BackgroundColor3 = Color3.fromRGB(10,10,10)
		page.BorderSizePixel = 0
		page.Position = UDim2.new(-0.1, 0, -0.00371747208, 0)
		page.Size = UDim2.new(1.1, 0, 1, 0)
		page.ScrollBarThickness = 5
		page.Visible = false
		page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)

		Blank.Name = "Blank"
		Blank.Parent = page
		Blank.Size = UDim2.new(0,100,0,-15)
		Blank.BackgroundTransparency = 1

		pageListing.Name = "pageListing"
		pageListing.Parent = page
		pageListing.SortOrder = Enum.SortOrder.LayoutOrder
		pageListing.Padding = UDim.new(0, 5)
		pageListing.HorizontalAlignment = Enum.HorizontalAlignment.Center

		tabButton.Name = tabName.."TabButton"
		tabButton.Parent = tabFrames
		tabButton.BackgroundColor3 = Color3.fromRGB(5,5,5)
		tabButton.Size = UDim2.new(0, 100, 0, 28)
		tabButton.AutoButtonColor = false
		tabButton.Font = Enum.Font.Gotham
		tabButton.Text = tabName
		tabButton.TextColor3 = Color3.fromRGB(255,255,255)
		tabButton.TextSize = 12.000
		tabButton.BackgroundTransparency = 0

		local tabButtonStroke = Instance.new("UIStroke")
		tabButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		tabButtonStroke.Parent = tabButton
		tabButtonStroke.Thickness = 1
		tabButtonStroke.Color = Color3.fromRGB(0,0,0)

		tabButton.MouseEnter:Connect(function()
			tween:Create(
				tabButtonStroke,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{Color = Color3.fromRGB(170, 85, 255)}
			):Play()
		end)

		tabButton.MouseLeave:Connect(function()
			tween:Create(
				tabButtonStroke,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{Color = Color3.fromRGB(0, 0, 0)}
			):Play()
		end)

		if first then
			first = false
			page.Visible = true
			tabButton.BackgroundTransparency = 0
			UpdateSize()
		else
			page.Visible = false
		end

		UICorner.CornerRadius = UDim.new(0, 5)
		UICorner.Parent = tabButton
		table.insert(Tabs, tabName)

		UpdateSize()
		page.ChildAdded:Connect(UpdateSize)
		page.ChildRemoved:Connect(UpdateSize)

		tabButton.MouseButton1Click:Connect(function()
			UpdateSize()
			for i,v in next, Pages:GetChildren() do
				v.Visible = false
			end
			page.Visible = true
			Utility:TweenObject(tabButton, {BackgroundTransparency = 0}, 0.2)
		end)
		local Sections = {}
		local focusing = false
		local viewDe = false

		function Sections:NewSection(secName, hidden)
			secName = secName or "Section"
			local sectionFunctions = {}
			local modules = {}
			hidden = hidden or false
			local sectionFrame = Instance.new("Frame")
			local sectionlistoknvm = Instance.new("UIListLayout")
			local sectionHead = Instance.new("Frame")
			local sHeadCorner = Instance.new("UICorner")
			local sectionName = Instance.new("TextLabel")
			local sectionInners = Instance.new("Frame")
			local sectionElListing = Instance.new("UIListLayout")

			if hidden then
				sectionHead.Visible = false
			else
				sectionHead.Visible = true
			end

			sectionFrame.Name = "sectionFrame"
			sectionFrame.Parent = page
			sectionFrame.BackgroundColor3 = themeList.Background--36, 37, 43
			sectionFrame.BorderSizePixel = 0

			sectionlistoknvm.Name = "sectionlistoknvm"
			sectionlistoknvm.Parent = sectionFrame
			sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
			sectionlistoknvm.Padding = UDim.new(0, 6)

			for i,v in pairs(sectionInners:GetChildren()) do
				while wait() do
					if v:IsA("Frame") or v:IsA("TextButton") then
						function size(pro)
							if pro == "Size" then
								UpdateSize()
								updateSectionFrame()
							end
						end
						v.Changed:Connect(size)
					end
				end
			end
			sectionHead.Name = "sectionHead"
			sectionHead.Parent = sectionFrame
			sectionHead.BackgroundColor3 = Color3.fromRGB(10,10,10)
			sectionHead.Size = UDim2.new(0, 352, 0, 33)

			sHeadCorner.CornerRadius = UDim.new(0, 4)
			sHeadCorner.Name = "sHeadCorner"
			sHeadCorner.Parent = sectionHead

			sectionName.Name = "sectionName"
			sectionName.Parent = sectionHead
			sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sectionName.BackgroundTransparency = 1.000
			sectionName.BorderColor3 = Color3.fromRGB(27, 42, 53)
			sectionName.Position = UDim2.new(0.0198863633, 0, 0, 0)
			sectionName.Size = UDim2.new(0.980113626, 0, 1, 0)
			sectionName.Font = Enum.Font.Gotham
			sectionName.Text = secName
			sectionName.RichText = true
			sectionName.TextColor3 = Color3.fromRGB(255, 255, 255)
			sectionName.TextSize = 12.000
			sectionName.TextXAlignment = Enum.TextXAlignment.Left

			sectionInners.Name = "sectionInners"
			sectionInners.Parent = sectionFrame
			sectionInners.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sectionInners.BackgroundTransparency = 1.000
			sectionInners.Position = UDim2.new(0, 0, 0.190751448, 0)

			sectionElListing.Name = "sectionElListing"
			sectionElListing.Parent = sectionInners
			sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
			sectionElListing.Padding = UDim.new(0, 4)

			local function updateSectionFrame()
				local innerSc = sectionElListing.AbsoluteContentSize
				sectionInners.Size = UDim2.new(1, 0, 0, innerSc.Y)
				local frameSc = sectionlistoknvm.AbsoluteContentSize
				sectionFrame.Size = UDim2.new(0, 352, 0, frameSc.Y)
			end
			updateSectionFrame()
			UpdateSize()
			local Elements = {}
			function Elements:NewButton(bname,callback)
				local ButtonFunction = {}
				bname = bname or "Click Me!"
				callback = callback or function() end

				local buttonElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local btnInfo = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local touch = Instance.new("ImageLabel")
				local Sample = Instance.new("ImageLabel")

				table.insert(modules, bname)

				buttonElement.Name = bname
				buttonElement.Parent = sectionInners
				buttonElement.BackgroundColor3 = Color3.fromRGB(5,5,5)
				buttonElement.ClipsDescendants = true
				buttonElement.Size = UDim2.new(0, 352, 0, 33)
				buttonElement.AutoButtonColor = false
				buttonElement.Font = Enum.Font.SourceSans
				buttonElement.Text = ""
				buttonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				buttonElement.TextSize = 14.000

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = buttonElement

				local buttonElementStroke = Instance.new("UIStroke")
				buttonElementStroke.Parent = buttonElement
				buttonElementStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				buttonElementStroke.Color = Color3.fromRGB(0,0,0)
				buttonElementStroke.Thickness = 1

				Sample.Name = "Sample"
				Sample.Parent = buttonElement
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1.000
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = themeList.SchemeColor
				Objects[Sample] = "ImageColor3"
				Sample.ImageTransparency = 0.600

				btnInfo.Name = "btnInfo"
				btnInfo.Parent = buttonElement
				btnInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				btnInfo.BackgroundTransparency = 1.000
				btnInfo.Position = UDim2.new(0.05, 0, 0.272727281, 0)
				btnInfo.Size = UDim2.new(0, 314, 0, 14)
				btnInfo.Font = Enum.Font.Gotham
				btnInfo.Text = bname
				btnInfo.RichText = true
				btnInfo.TextColor3 = themeList.TextColor
				btnInfo.TextSize = 12.000

				updateSectionFrame()
				UpdateSize()

				local ms = game.Players.LocalPlayer:GetMouse()

				local btn = buttonElement
				local sample = Sample

				btn.MouseButton1Down:Connect(function()
					tween:Create(
						btnInfo,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(108, 54, 162)}
					):Play()
				end)

				btn.MouseButton1Click:Connect(function()
					pcall(callback)
					btnInfo.TextSize = 0
					tween:Create(
						btnInfo,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextSize = 12}
					):Play()
				end)
				local hovering = false
				btn.MouseEnter:Connect(function()
					tween:Create(
						buttonElementStroke,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Color = Color3.fromRGB(170, 85, 255)}
					):Play()
					tween:Create(
						btnInfo,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(170, 85, 255)}
					):Play()
				end)
				btn.MouseLeave:Connect(function()
					tween:Create(
						buttonElementStroke,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Color = Color3.fromRGB(0,0,0)}
					):Play()
					tween:Create(
						btnInfo,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)}
					):Play()
				end)

				function ButtonFunction:UpdateButton(newTitle)
					btnInfo.Text = newTitle
				end
				return ButtonFunction
			end

			function Elements:NewTextBox(tname, callback)
				tname = tname or "Textbox"
				callback = callback or function() end
				local textboxElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local viewInfo = Instance.new("ImageButton")
				local write = Instance.new("ImageLabel")
				local TextBox = Instance.new("TextBox")
				local UICorner_2 = Instance.new("UICorner")
				local togName = Instance.new("TextLabel")

				textboxElement.Name = "textboxElement"
				textboxElement.Parent = sectionInners
				textboxElement.BackgroundColor3 = Color3.fromRGB(5,5,5)
				textboxElement.ClipsDescendants = true
				textboxElement.Size = UDim2.new(0, 352, 0, 33)
				textboxElement.AutoButtonColor = false
				textboxElement.Font = Enum.Font.SourceSans
				textboxElement.Text = ""
				textboxElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				textboxElement.TextSize = 14.000

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = textboxElement

				local textboxElementtStroke = Instance.new("UIStroke")
				textboxElementtStroke.Parent = textboxElement
				textboxElementtStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				textboxElementtStroke.Color = Color3.fromRGB(0,0,0)
				textboxElementtStroke.Thickness = 1

				TextBox.Parent = textboxElement
				TextBox.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 6, themeList.ElementColor.g * 255 - 6, themeList.ElementColor.b * 255 - 7)
				TextBox.BorderSizePixel = 0
				TextBox.ClipsDescendants = true
				TextBox.Position = UDim2.new(0.55, 0, 0.212121218, 0)
				TextBox.Size = UDim2.new(0, 150, 0, 18)
				TextBox.ZIndex = 99
				TextBox.ClearTextOnFocus = false
				TextBox.Font = Enum.Font.Gotham
				TextBox.PlaceholderColor3 = Color3.fromRGB(129,129,129)
				TextBox.PlaceholderText = "Type . . ."
				TextBox.Text = ""
				TextBox.TextColor3 = Color3.fromRGB(170, 85, 255)
				TextBox.TextSize = 12.000

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = TextBox

				local TextBoxStroke = Instance.new("UIStroke")
				TextBoxStroke.Parent = TextBox
				TextBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				TextBoxStroke.Color = Color3.fromRGB(0,0,0)
				TextBoxStroke.Thickness = 1

				togName.Name = "togName"
				togName.Parent = textboxElement
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1.000
				togName.Position = UDim2.new(0.02, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 138, 0, 14)
				togName.Font = Enum.Font.Gotham
				togName.Text = tname
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 12.000
				togName.TextXAlignment = Enum.TextXAlignment.Left

				updateSectionFrame()
				UpdateSize()

				local btn = textboxElement
				local infBtn = viewInfo

				btn.MouseButton1Click:Connect(function()
					if focusing then
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)
				local hovering = false

				TextBox.Focused:Connect(function()
					tween:Create(
						TextBoxStroke,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Color = Color3.fromRGB(170, 85, 255)}
					):Play()
				end)

				btn.MouseEnter:Connect(function()
					if not focusing then
						tween:Create(
							textboxElementtStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(170, 85, 255)}
						):Play()
						tween:Create(
							togName,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(170, 85, 255)}
						):Play()
						hovering = true
					end
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						tween:Create(
							textboxElementtStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(0, 0, 0)}
						):Play()
						tween:Create(
							togName,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
						hovering = false
					end
				end)

				TextBox.FocusLost:Connect(function(EnterPressed)
					tween:Create(
						TextBoxStroke,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Color = Color3.fromRGB(0, 0, 0)}
					):Play()
					if focusing then
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
					if not EnterPressed then
						return
					else
						callback(TextBox.Text)
						wait(0.18)
						TextBox.Text = ""
					end
				end)

				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
						Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
			end

			function Elements:NewToggle(tname,callback)
				local TogFunction = {}
				tname = tname or "Toggle"
				callback = callback or function() end
				local toggled = false
				table.insert(SettingsT, tname)

				local toggleElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local toggleDisabled = Instance.new("ImageLabel")
				local toggleEnabled = Instance.new("ImageLabel")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local Sample = Instance.new("ImageLabel")

				toggleElement.Name = "toggleElement"
				toggleElement.Parent = sectionInners
				toggleElement.BackgroundColor3 = Color3.fromRGB(5,5,5)
				toggleElement.ClipsDescendants = true
				toggleElement.Size = UDim2.new(0, 352, 0, 33)
				toggleElement.AutoButtonColor = false
				toggleElement.Font = Enum.Font.SourceSans
				toggleElement.Text = ""
				toggleElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				toggleElement.TextSize = 14.000

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = toggleElement

				local toggleElementStroke = Instance.new("UIStroke")
				toggleElementStroke.Parent = toggleElement
				toggleElementStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				toggleElementStroke.Color = Color3.fromRGB(0,0,0)
				toggleElementStroke.Thickness = 1

				toggleDisabled.Name = "toggleDisabled"
				toggleDisabled.Parent = toggleElement
				toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggleDisabled.BackgroundTransparency = 1.000
				toggleDisabled.Position = UDim2.new(0.9, 0, 0.180000007, 0)
				toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
				toggleDisabled.Image = "rbxassetid://7072723598"
				toggleDisabled.ImageColor3 = themeList.SchemeColor

				toggleEnabled.Name = "toggleEnabled"
				toggleEnabled.Parent = toggleElement
				toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggleEnabled.BackgroundTransparency = 1.000
				toggleEnabled.Position = UDim2.new(0.9, 0, 0.180000007, 0)
				toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
				toggleEnabled.Image = "rbxassetid://7072723637"
				toggleEnabled.ImageColor3 = themeList.SchemeColor
				toggleEnabled.ImageTransparency = 1.000

				togName.Name = "togName"
				togName.Parent = toggleElement
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1.000
				togName.Position = UDim2.new(0.02, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 288, 0, 14)
				togName.Font = Enum.Font.Gotham
				togName.Text = tname
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 12.000
				togName.TextXAlignment = Enum.TextXAlignment.Left

				local ms = game.Players.LocalPlayer:GetMouse()

				local btn = toggleElement
				local sample = Sample
				local img = toggleEnabled
				local img2 = toggleDisabled
				local infBtn = viewInfo

				updateSectionFrame()
				UpdateSize()

				btn.MouseButton1Down:Connect(function()
					tween:Create(
						togName,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(108, 54, 162)}
					):Play()
					tween:Create(
						img,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(108, 54, 162)}
					):Play()
				end)

				btn.MouseButton1Click:Connect(function()
					if not focusing then
						if toggled == false then
							game.TweenService:Create(img2, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
								ImageTransparency = 1
							}):Play()
							game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
								ImageTransparency = 0
							}):Play()
							tween:Create(
								img,
								TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{ImageColor3 = Color3.fromRGB(170, 85, 255)}
							):Play()

							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
						else
							game.TweenService:Create(img2, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
								ImageTransparency = 0
							}):Play()
							game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
								ImageTransparency = 1
							}):Play()
							local len, size = 0.35, nil
							if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
								size = (btn.AbsoluteSize.X * 1.5)
							else
								size = (btn.AbsoluteSize.Y * 1.5)
							end
						end
						toggled = not toggled
						pcall(callback, toggled)
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						tween:Create(
							toggleElementStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(170, 85, 255)}
						):Play()
						tween:Create(
							togName,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(170, 85, 255)}
						):Play()
						hovering = true
					end
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						tween:Create(
							toggleElementStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(0, 0, 0)}
						):Play()
						tween:Create(
							togName,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
						hovering = false
					end
				end)
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
						Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
				function TogFunction:UpdateToggle(newText, isTogOn)
					isTogOn = isTogOn or toggle
					if newText ~= nil then
						togName.Text = newText
					end
					if isTogOn then
						toggled = true
						game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
							ImageTransparency = 0
						}):Play()
						pcall(callback, toggled)
					else
						toggled = false
						game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
							ImageTransparency = 1
						}):Play()
						pcall(callback, toggled)
					end
				end
				return TogFunction
			end

			function Elements:NewSlider(slidInf, maxvalue, minvalue, callback)
				slidInf = slidInf or "Slider"
				maxvalue = maxvalue or 500
				minvalue = minvalue or 16
				startVal = startVal or 0
				callback = callback or function() end

				local sliderElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local sliderBtn = Instance.new("TextButton")
				local UICorner_2 = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local sliderDrag = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local write = Instance.new("ImageLabel")
				local val = Instance.new("TextLabel")

				sliderElement.Name = "sliderElement"
				sliderElement.Parent = sectionInners
				sliderElement.BackgroundColor3 = Color3.fromRGB(5,5,5)
				sliderElement.ClipsDescendants = true
				sliderElement.Size = UDim2.new(0, 352, 0, 33)
				sliderElement.AutoButtonColor = false
				sliderElement.Font = Enum.Font.SourceSans
				sliderElement.Text = ""
				sliderElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				sliderElement.TextSize = 14.000

				local sliderElementStroke = Instance.new("UIStroke")
				sliderElementStroke.Parent = sliderElement
				sliderElementStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				sliderElementStroke.Color = Color3.fromRGB(0,0,0)
				sliderElementStroke.Thickness = 1

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = sliderElement

				togName.Name = "togName"
				togName.Parent = sliderElement
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1.000
				togName.Position = UDim2.new(0.02, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 138, 0, 14)
				togName.Font = Enum.Font.Gotham
				togName.Text = slidInf
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 12.000
				togName.TextXAlignment = Enum.TextXAlignment.Left

				sliderBtn.Name = "sliderBtn"
				sliderBtn.Parent = sliderElement
				sliderBtn.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255  + 5)
				sliderBtn.BorderSizePixel = 0
				sliderBtn.Position = UDim2.new(0.54, 0, 0.393939406, 0)
				sliderBtn.Size = UDim2.new(0, 149, 0, 6)
				sliderBtn.AutoButtonColor = false
				sliderBtn.Font = Enum.Font.SourceSans
				sliderBtn.Text = ""
				sliderBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
				sliderBtn.TextSize = 14.000

				UICorner_2.Parent = sliderBtn

				UIListLayout.Parent = sliderBtn
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

				sliderDrag.Name = "sliderDrag"
				sliderDrag.Parent = sliderBtn
				sliderDrag.BackgroundColor3 = Color3.fromRGB(170, 85, 255)
				sliderDrag.BorderColor3 = Color3.fromRGB(74, 99, 135)
				sliderDrag.BorderSizePixel = 0
				sliderDrag.Size = UDim2.new(-0.671140969, 100,1,0)

				UICorner_3.Parent = sliderDrag

				val.Name = "val"
				val.Parent = sliderElement
				val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				val.BackgroundTransparency = 1.000
				val.Position = UDim2.new(0.352386296, 0, 0.272727281, 0)
				val.Size = UDim2.new(0, 41, 0, 14)
				val.Font = Enum.Font.Gotham
				val.Text = "["..minvalue.."/"..maxvalue.."]"
				val.TextColor3 = themeList.TextColor
				val.TextSize = 12.000
				val.TextTransparency = 1.000
				val.TextXAlignment = Enum.TextXAlignment.Right

				updateSectionFrame()
				UpdateSize()
				local mouse = game:GetService("Players").LocalPlayer:GetMouse();

				local ms = game.Players.LocalPlayer:GetMouse()
				local uis = game:GetService("UserInputService")
				local btn = sliderElement
				local infBtn = viewInfo
				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						tween:Create(
							sliderElementStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(170, 85, 255)}
						):Play()
						tween:Create(
							togName,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(170, 85, 255)}
						):Play()
						hovering = true
					end
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						tween:Create(
							sliderElementStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(0, 0, 0)}
						):Play()
						tween:Create(
							togName,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
						hovering = false
					end
				end)

				local Value
				sliderBtn.MouseButton1Down:Connect(function()
					if not focusing then
						game.TweenService:Create(val, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
							TextTransparency = 0
						}):Play()
						Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue)) or 0
						pcall(function()
							callback(Value)
						end)
						sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
						moveconnection = mouse.Move:Connect(function()
							val.Text = "["..Value.."/"..maxvalue.."]"
							Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue))
							pcall(function()
								callback(Value)
							end)
							sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
						end)
						releaseconnection = uis.InputEnded:Connect(function(Mouse)
							if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
								Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue))
								pcall(function()
									callback(Value)
								end)
								val.Text = "["..Value.."/"..maxvalue.."]"
								game.TweenService:Create(val, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									TextTransparency = 1
								}):Play()
								sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
								moveconnection:Disconnect()
								releaseconnection:Disconnect()
							end
						end)
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)
				viewInfo.MouseButton1Click:Connect(function()
					if not viewDe then
						viewDe = true
						focusing = true
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
						Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
						wait(1.5)
						focusing = false
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						wait(0)
						viewDe = false
					end
				end)
			end

			function Elements:NewDropdown(dropname, list, callback)
				local DropFunction = {}
				dropname = dropname or "Dropdown"
				list = list or {}
				callback = callback or function() end

				local opened = false
				local DropYSize = 33


				local dropFrame = Instance.new("Frame")
				local dropOpen = Instance.new("TextButton")
				local listImg = Instance.new("ImageLabel")
				local itemTextbox = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local UICorner = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local UICornerdropframe = Instance.new("UICorner")

				local ms = game.Players.LocalPlayer:GetMouse()

				dropFrame.Name = "dropFrame"
				dropFrame.Parent = sectionInners
				dropFrame.BackgroundColor3 = Color3.fromRGB(5,5,5)
				dropFrame.BorderSizePixel = 0
				dropFrame.Position = UDim2.new(0, 0, 1.23571432, 0)
				dropFrame.Size = UDim2.new(0, 352, 0, 33)
				dropFrame.ClipsDescendants = true

				UICornerdropframe.CornerRadius = UDim.new(0, 4)
				UICornerdropframe.Parent = dropFrame

				local dropFrameStroke = Instance.new("UIStroke")
				dropFrameStroke.Parent = dropFrame
				dropFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				dropFrameStroke.Color = Color3.fromRGB(0,0,0)
				dropFrameStroke.Thickness = 1

				local btn = dropOpen
				dropOpen.Name = "dropOpen"
				dropOpen.Parent = dropFrame
				dropOpen.BackgroundColor3 = Color3.fromRGB(5,5,5)
				dropOpen.Size = UDim2.new(0, 352, 0, 33)
				dropOpen.AutoButtonColor = false
				dropOpen.Font = Enum.Font.SourceSans
				dropOpen.Text = ""
				dropOpen.TextColor3 = Color3.fromRGB(0, 0, 0)
				dropOpen.TextSize = 14.000
				dropOpen.ClipsDescendants = true

				local dropOpenStroke = Instance.new("UIStroke")
				dropOpenStroke.Parent = dropOpen
				dropOpenStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				dropOpenStroke.Color = Color3.fromRGB(0,0,0)
				dropOpenStroke.Thickness = 1

				dropOpen.MouseButton1Click:Connect(function()
					if not focusing then
						if opened then
							opened = false
							dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
							tween:Create(
								viewInfo,
								TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{Rotation = 0}
							):Play()
						else
							opened = true
							dropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
							tween:Create(
								viewInfo,
								TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{Rotation = 180}
							):Play()
						end
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)

				itemTextbox.Name = "itemTextbox"
				itemTextbox.Parent = dropOpen
				itemTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				itemTextbox.BackgroundTransparency = 1.000
				itemTextbox.Position = UDim2.new(0.02, 0, 0.273000002, 0)
				itemTextbox.Size = UDim2.new(0, 138, 0, 14)
				itemTextbox.Font = Enum.Font.Gotham
				itemTextbox.Text = dropname
				itemTextbox.RichText = true
				itemTextbox.TextColor3 = themeList.TextColor
				itemTextbox.TextSize = 12
				itemTextbox.TextXAlignment = Enum.TextXAlignment.Left

				viewInfo.Name = "viewInfo"
				viewInfo.Parent = dropOpen
				viewInfo.BackgroundTransparency = 1.000
				viewInfo.LayoutOrder = 9
				viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
				viewInfo.Size = UDim2.new(0, 20, 0, 20)
				viewInfo.ZIndex = 2
				viewInfo.Image = "rbxassetid://7072706663"
				viewInfo.ImageColor3 = Color3.fromRGB(255,255,255)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = dropOpen

				UIListLayout.Parent = dropFrame
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 3)

				updateSectionFrame()
				UpdateSize()

				local ms = game.Players.LocalPlayer:GetMouse()
				local uis = game:GetService("UserInputService")
				local infBtn = viewInfo

				local hovering = false
				btn.MouseEnter:Connect(function()
					if not focusing then
						tween:Create(
							dropFrameStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(170, 85, 255)}
						):Play()
						tween:Create(
							dropOpenStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(170, 85, 255)}
						):Play()
						tween:Create(
							itemTextbox,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(170, 85, 255)}
						):Play()
						hovering = true
					end
				end)
				btn.MouseLeave:Connect(function()
					if not focusing then
						tween:Create(
							dropFrameStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(0, 0, 0)}
						):Play()
						tween:Create(
							dropOpenStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(0, 0, 0)}
						):Play()
						tween:Create(
							itemTextbox,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
						hovering = false
					end
				end)

				for i,v in next, list do
					local optionSelect = Instance.new("TextButton")
					local UICorner_2 = Instance.new("UICorner")
					local Sample1 = Instance.new("ImageLabel")

					local sample1 = Sample1
					DropYSize = DropYSize + 33
					optionSelect.Name = "optionSelect"
					optionSelect.Parent = dropFrame
					optionSelect.BackgroundColor3 = Color3.fromRGB(5,5,5)
					optionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
					optionSelect.Size = UDim2.new(0, 352, 0, 33)
					optionSelect.AutoButtonColor = false
					optionSelect.Font = Enum.Font.Gotham
					optionSelect.Text = "  "..v
					optionSelect.TextColor3 = Color3.fromRGB(255,255,255)
					optionSelect.TextSize = 12.000
					optionSelect.TextXAlignment = Enum.TextXAlignment.Left
					optionSelect.ClipsDescendants = true
					optionSelect.MouseButton1Click:Connect(function()
						if not focusing then
							opened = false
							callback(v)
							itemTextbox.Text = v
							dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), 'InOut', 'Linear', 0.08)
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
							tween:Create(
								viewInfo,
								TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{Rotation = 0}
							):Play()
						else
							for i,v in next, infoContainer:GetChildren() do
								Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
								focusing = false
							end
							Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
						end
					end)

					UICorner_2.CornerRadius = UDim.new(0, 4)
					UICorner_2.Parent = optionSelect

					local oHover = false
					optionSelect.MouseEnter:Connect(function()
						if not focusing then
							tween:Create(
								optionSelect,
								TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{TextColor3 = Color3.fromRGB(170, 85, 255)}
							):Play()
							oHover = true
						end
					end)
					optionSelect.MouseLeave:Connect(function()
						if not focusing then
							tween:Create(
								optionSelect,
								TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{TextColor3 = Color3.fromRGB(255, 255, 255)}
							):Play()
							oHover = false
						end
					end)
				end

				function DropFunction:Refresh(newList)
					newList = newList or {}
					for i,v in next, dropFrame:GetChildren() do
						if v.Name == "optionSelect" then
							v:Destroy()
						end
					end
					for i,v in next, newList do
						local optionSelect = Instance.new("TextButton")
						local UICorner_2 = Instance.new("UICorner")

						DropYSize = DropYSize + 33
						optionSelect.Name = "optionSelect"
						optionSelect.Parent = dropFrame
						optionSelect.BackgroundColor3 = themeList.ElementColor
						optionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
						optionSelect.Size = UDim2.new(0, 352, 0, 33)
						optionSelect.AutoButtonColor = false
						optionSelect.Font = Enum.Font.GothamSemibold
						optionSelect.Text = "  "..v
						optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
						optionSelect.TextSize = 14.000
						optionSelect.TextXAlignment = Enum.TextXAlignment.Left
						optionSelect.ClipsDescendants = true
						UICorner_2.CornerRadius = UDim.new(0, 4)
						UICorner_2.Parent = optionSelect
						optionSelect.MouseButton1Click:Connect(function()
							if not focusing then
								opened = false
								callback(v)
								itemTextbox.Text = v
								dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), 'InOut', 'Linear', 0.08)
								wait(0.1)
								updateSectionFrame()
								UpdateSize()
								tween:Create(
									viewInfo,
									TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
									{Rotation = 180}
								):Play()
							else
								for i,v in next, infoContainer:GetChildren() do
									Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
									focusing = false
								end
								Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
							end
						end)
						updateSectionFrame()
						UpdateSize()
						local hov = false
						optionSelect.MouseEnter:Connect(function()
							if not focusing then
								game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
								}):Play()
								hov = true
							end
						end)
						optionSelect.MouseLeave:Connect(function()
							if not focusing then
								game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
									BackgroundColor3 = themeList.ElementColor
								}):Play()
								hov = false
							end
						end)
					end
					if opened then
						dropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
						wait(0.1)
						updateSectionFrame()
						UpdateSize()
					else
						dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
						wait(0.1)
						updateSectionFrame()
						UpdateSize()
					end
				end
				return DropFunction
			end
			function Elements:NewKeybind(keytext, first, callback)
				keytext = keytext or "KeybindText"
				callback = callback or function() end
				local oldKey = first.Name
				local keybindElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local touch = Instance.new("ImageLabel")
				local togName_2 = Instance.new("TextLabel")

				local ms = game.Players.LocalPlayer:GetMouse()
				local uis = game:GetService("UserInputService")
				local infBtn = viewInfo

				local moreInfo = Instance.new("TextLabel")
				local UICorner1 = Instance.new("UICorner")

				keybindElement.Name = "keybindElement"
				keybindElement.Parent = sectionInners
				keybindElement.BackgroundColor3 = Color3.fromRGB(5,5,5)
				keybindElement.ClipsDescendants = true
				keybindElement.Size = UDim2.new(0, 352, 0, 33)
				keybindElement.AutoButtonColor = false
				keybindElement.Font = Enum.Font.SourceSans
				keybindElement.Text = ""
				keybindElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				keybindElement.TextSize = 14.000
				keybindElement.MouseButton1Click:connect(function(e)

					if not focusing then
						togName_2.Text = "..."
						local a, b = game:GetService('UserInputService').InputBegan:wait();
						if a.KeyCode.Name ~= "Unknown" then
							togName_2.Text = a.KeyCode.Name
							oldKey = a.KeyCode.Name;
						end
						local len, size = 0.35, nil
						if keybindElement.AbsoluteSize.X >= keybindElement.AbsoluteSize.Y then
							size = (keybindElement.AbsoluteSize.X * 1.5)
						else
							size = (keybindElement.AbsoluteSize.Y * 1.5)
						end
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)

				game:GetService("UserInputService").InputBegan:connect(function(current, ok)
					if not ok then
						if current.KeyCode.Name == oldKey then
							callback()
						end
					end
				end)

				togName.Name = "togName"
				togName.Parent = keybindElement
				togName.BackgroundColor3 = themeList.TextColor
				togName.BackgroundTransparency = 1.000
				togName.Position = UDim2.new(0.02, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 222, 0, 14)
				togName.Font = Enum.Font.Gotham
				togName.Text = keytext
				togName.RichText = true
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 12.000
				togName.TextXAlignment = Enum.TextXAlignment.Left

				updateSectionFrame()
				UpdateSize()

				local keybindElementStroke = Instance.new("UIStroke")
				keybindElementStroke.Parent = keybindElement
				keybindElementStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				keybindElementStroke.Color = Color3.fromRGB(0,0,0)
				keybindElementStroke.Thickness = 1

				local oHover = false
				keybindElement.MouseEnter:Connect(function()
					tween:Create(
						keybindElementStroke,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Color = Color3.fromRGB(170, 85, 255)}
					):Play()
					if not focusing then
						tween:Create(
							togName,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(170, 85, 255)}
						):Play()
						oHover = true
					end
				end)
				keybindElement.MouseLeave:Connect(function()
					if not focusing then
						tween:Create(
							togName,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
						oHover = false
						tween:Create(
							keybindElementStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(0, 0, 0)}
						):Play()
					end
				end)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = keybindElement

				togName_2.Name = "togName"
				togName_2.Parent = keybindElement
				togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName_2.BackgroundTransparency = 1.000
				togName_2.Position = UDim2.new(0.727386296, 0, 0.272727281, 0)
				togName_2.Size = UDim2.new(0, 70, 0, 14)
				togName_2.Font = Enum.Font.Gotham
				togName_2.Text = oldKey
				togName_2.TextColor3 = themeList.SchemeColor
				togName_2.TextSize = 12.000
				togName_2.TextXAlignment = Enum.TextXAlignment.Right
			end

			function Elements:NewColorPicker(colText, defcolor, callback)
				colText = colText or "ColorPicker"
				callback = callback or function() end
				defcolor = defcolor or Color3.fromRGB(1,1,1)
				local h, s, v = Color3.toHSV(defcolor)
				local ms = game.Players.LocalPlayer:GetMouse()
				local colorOpened = false
				local colorElement = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local colorHeader = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local touch = Instance.new("ImageLabel")
				local togName = Instance.new("TextLabel")
				local viewInfo = Instance.new("ImageButton")
				local colorCurrent = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local colorInners = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local rgb = Instance.new("ImageButton")
				local UICorner_5 = Instance.new("UICorner")
				local rbgcircle = Instance.new("ImageLabel")
				local darkness = Instance.new("ImageButton")
				local UICorner_6 = Instance.new("UICorner")
				local darkcircle = Instance.new("ImageLabel")
				local toggleDisabled = Instance.new("ImageLabel")
				local toggleEnabled = Instance.new("ImageLabel")
				local onrainbow = Instance.new("TextButton")
				local togName_2 = Instance.new("TextLabel")

				--Properties:

				local btn = colorHeader

				colorElement.Name = "colorElement"
				colorElement.Parent = sectionInners
				colorElement.BackgroundColor3 = Color3.fromRGB(5,5,5)
				colorElement.BackgroundTransparency = 1.000
				colorElement.ClipsDescendants = true
				colorElement.Position = UDim2.new(0, 0, 0.566834569, 0)
				colorElement.Size = UDim2.new(0, 352, 0, 33)
				colorElement.AutoButtonColor = false
				colorElement.Font = Enum.Font.SourceSans
				colorElement.Text = ""
				colorElement.TextColor3 = Color3.fromRGB(0, 0, 0)
				colorElement.TextSize = 14.000

				local colorElementStroke = Instance.new("UIStroke")
				colorElementStroke.Parent = colorElement
				colorElementStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				colorElementStroke.Color = Color3.fromRGB(0,0,0)
				colorElementStroke.Thickness = 1

				colorElement.MouseButton1Click:Connect(function()
					if not focusing then
						if colorOpened then
							colorOpened = false
							colorElement:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
						else
							colorOpened = true
							colorElement:TweenSize(UDim2.new(0, 352, 0, 141), "InOut", "Linear", 0.08, true)
							wait(0.1)
							updateSectionFrame()
							UpdateSize()
						end
					else
						for i,v in next, infoContainer:GetChildren() do
							Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
							focusing = false
						end
						Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
					end
				end)
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = colorElement

				colorHeader.Name = "colorHeader"
				colorHeader.Parent = colorElement
				colorHeader.BackgroundColor3 = Color3.fromRGB(5,5,5)
				colorHeader.Size = UDim2.new(0, 352, 0, 33)
				colorHeader.ClipsDescendants = true

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = colorHeader

				local colorHeaderStroke = Instance.new("UIStroke")
				colorHeaderStroke.Parent = colorHeader
				colorHeaderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				colorHeaderStroke.Color = Color3.fromRGB(0,0,0)
				colorHeaderStroke.Thickness = 1

				togName.Name = "togName"
				togName.Parent = colorHeader
				togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName.BackgroundTransparency = 1.000
				togName.Position = UDim2.new(0.02, 0, 0.272727281, 0)
				togName.Size = UDim2.new(0, 288, 0, 14)
				togName.Font = Enum.Font.Gotham
				togName.Text = colText
				togName.TextColor3 = themeList.TextColor
				togName.TextSize = 12
				togName.RichText = true
				togName.TextXAlignment = Enum.TextXAlignment.Left

				colorCurrent.Name = "colorCurrent"
				colorCurrent.Parent = colorHeader
				colorCurrent.BackgroundColor3 = defcolor
				colorCurrent.Position = UDim2.new(0.792613626, 0, 0.212121218, 0)
				colorCurrent.Size = UDim2.new(0, 42, 0, 18)

				UICorner_3.CornerRadius = UDim.new(0, 4)
				UICorner_3.Parent = colorCurrent

				UIListLayout.Parent = colorElement
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 3)

				colorInners.Name = "colorInners"
				colorInners.Parent = colorElement
				colorInners.BackgroundColor3 = themeList.ElementColor
				colorInners.Position = UDim2.new(0, 0, 0.255319148, 0)
				colorInners.Size = UDim2.new(0, 352, 0, 105)

				UICorner_4.CornerRadius = UDim.new(0, 4)
				UICorner_4.Parent = colorInners

				rgb.Name = "rgb"
				rgb.Parent = colorInners
				rgb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				rgb.BackgroundTransparency = 1.000
				rgb.Position = UDim2.new(0.0198863633, 0, 0.0476190485, 0)
				rgb.Size = UDim2.new(0, 211, 0, 93)
				rgb.Image = "http://www.roblox.com/asset/?id=6523286724"

				UICorner_5.CornerRadius = UDim.new(0, 4)
				UICorner_5.Parent = rgb

				rbgcircle.Name = "rbgcircle"
				rbgcircle.Parent = rgb
				rbgcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				rbgcircle.BackgroundTransparency = 1.000
				rbgcircle.Size = UDim2.new(0, 14, 0, 14)
				rbgcircle.Image = "rbxassetid://3926309567"
				rbgcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
				rbgcircle.ImageRectOffset = Vector2.new(628, 420)
				rbgcircle.ImageRectSize = Vector2.new(48, 48)

				darkness.Name = "darkness"
				darkness.Parent = colorInners
				darkness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				darkness.BackgroundTransparency = 1.000
				darkness.Position = UDim2.new(0.636363626, 0, 0.0476190485, 0)
				darkness.Size = UDim2.new(0, 18, 0, 93)
				darkness.Image = "http://www.roblox.com/asset/?id=6523291212"

				UICorner_6.CornerRadius = UDim.new(0, 4)
				UICorner_6.Parent = darkness

				darkcircle.Name = "darkcircle"
				darkcircle.Parent = darkness
				darkcircle.AnchorPoint = Vector2.new(0.5, 0)
				darkcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				darkcircle.BackgroundTransparency = 1.000
				darkcircle.Size = UDim2.new(0, 14, 0, 14)
				darkcircle.Image = "rbxassetid://3926309567"
				darkcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
				darkcircle.ImageRectOffset = Vector2.new(628, 420)
				darkcircle.ImageRectSize = Vector2.new(48, 48)

				toggleDisabled.Name = "toggleDisabled"
				toggleDisabled.Parent = colorInners
				toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggleDisabled.BackgroundTransparency = 1.000
				toggleDisabled.Position = UDim2.new(0.704659104, 0, 0.0657142699, 0)
				toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
				toggleDisabled.Image = "rbxassetid://3926309567"
				toggleDisabled.ImageColor3 = themeList.SchemeColor
				toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
				toggleDisabled.ImageRectSize = Vector2.new(48, 48)

				toggleEnabled.Name = "toggleEnabled"
				toggleEnabled.Parent = colorInners
				toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				toggleEnabled.BackgroundTransparency = 1.000
				toggleEnabled.Position = UDim2.new(0.704999983, 0, 0.0659999996, 0)
				toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
				toggleEnabled.Image = "rbxassetid://3926309567"
				toggleEnabled.ImageColor3 = themeList.SchemeColor
				toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
				toggleEnabled.ImageRectSize = Vector2.new(48, 48)
				toggleEnabled.ImageTransparency = 1.000

				onrainbow.Name = "onrainbow"
				onrainbow.Parent = toggleEnabled
				onrainbow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				onrainbow.BackgroundTransparency = 1.000
				onrainbow.Position = UDim2.new(2.90643607e-06, 0, 0, 0)
				onrainbow.Size = UDim2.new(1, 0, 1, 0)
				onrainbow.Font = Enum.Font.SourceSans
				onrainbow.Text = ""
				onrainbow.TextColor3 = Color3.fromRGB(0, 0, 0)
				onrainbow.TextSize = 14.000

				togName_2.Name = "togName"
				togName_2.Parent = colorInners
				togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				togName_2.BackgroundTransparency = 1.000
				togName_2.Position = UDim2.new(0.779999971, 0, 0.100000001, 0)
				togName_2.Size = UDim2.new(0, 278, 0, 14)
				togName_2.Font = Enum.Font.Gotham
				togName_2.Text = "Rainbow"
				togName_2.TextColor3 = themeList.TextColor
				togName_2.TextSize = 13.000
				togName_2.TextXAlignment = Enum.TextXAlignment.Left

				local hovering = false

				colorElement.MouseEnter:Connect(function()
					if not focusing then
						tween:Create(
							colorHeaderStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(170, 85, 255)}
						):Play()
						tween:Create(
							colorElementStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(170, 85, 255)}
						):Play()
						tween:Create(
							togName,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(170, 85, 255)}
						):Play()
						hovering = true
					end
				end)
				colorElement.MouseLeave:Connect(function()
					if not focusing then
						tween:Create(
							colorHeaderStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(0, 0, 0)}
						):Play()
						tween:Create(
							colorElementStroke,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Color = Color3.fromRGB(0, 0, 0)}
						):Play()
						tween:Create(
							togName,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
						hovering = false
					end
				end)

				updateSectionFrame()
				UpdateSize()
				local plr = game.Players.LocalPlayer
				local mouse = plr:GetMouse()
				local uis = game:GetService('UserInputService')
				local rs = game:GetService("RunService")
				local colorpicker = false
				local darknesss = false
				local dark = false
				local rgb = rgb
				local dark = darkness
				local cursor = rbgcircle
				local cursor2 = darkcircle
				local color = {1,1,1}
				local rainbow = false
				local rainbowconnection
				local counter = 0
				--
				local function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end
				counter = 0
				local function mouseLocation()
					return plr:GetMouse()
				end
				local function cp()
					if colorpicker then
						local ml = mouseLocation()
						local x,y = ml.X - rgb.AbsolutePosition.X,ml.Y - rgb.AbsolutePosition.Y
						local maxX,maxY = rgb.AbsoluteSize.X,rgb.AbsoluteSize.Y
						if x<0 then x=0 end
						if x>maxX then x=maxX end
						if y<0 then y=0 end
						if y>maxY then y=maxY end
						x = x/maxX
						y = y/maxY
						local cx = cursor.AbsoluteSize.X/2
						local cy = cursor.AbsoluteSize.Y/2
						cursor.Position = UDim2.new(x,-cx,y,-cy)
						color = {1-x,1-y,color[3]}
						local realcolor = Color3.fromHSV(color[1],color[2],color[3])
						colorCurrent.BackgroundColor3 = realcolor
						callback(realcolor)
					end
					if darknesss then
						local ml = mouseLocation()
						local y = ml.Y - dark.AbsolutePosition.Y
						local maxY = dark.AbsoluteSize.Y
						if y<0 then y=0 end
						if y>maxY then y=maxY end
						y = y/maxY
						local cy = cursor2.AbsoluteSize.Y/2
						cursor2.Position = UDim2.new(0.5,0,y,-cy)
						cursor2.ImageColor3 = Color3.fromHSV(0,0,y)
						color = {color[1],color[2],1-y}
						local realcolor = Color3.fromHSV(color[1],color[2],color[3])
						colorCurrent.BackgroundColor3 = realcolor
						callback(realcolor)
					end
				end

				local function setcolor(tbl)
					local cx = cursor.AbsoluteSize.X/2
					local cy = cursor.AbsoluteSize.Y/2
					color = {tbl[1],tbl[2],tbl[3]}
					cursor.Position = UDim2.new(color[1],-cx,color[2]-1,-cy)
					cursor2.Position = UDim2.new(0.5,0,color[3]-1,-cy)
					local realcolor = Color3.fromHSV(color[1],color[2],color[3])
					colorCurrent.BackgroundColor3 = realcolor
				end
				local function setrgbcolor(tbl)
					local cx = cursor.AbsoluteSize.X/2
					local cy = cursor.AbsoluteSize.Y/2
					color = {tbl[1],tbl[2],color[3]}
					cursor.Position = UDim2.new(color[1],-cx,color[2]-1,-cy)
					local realcolor = Color3.fromHSV(color[1],color[2],color[3])
					colorCurrent.BackgroundColor3 = realcolor
					callback(realcolor)
				end
				local function togglerainbow()
					if rainbow then
						game.TweenService:Create(toggleEnabled, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							ImageTransparency = 1
						}):Play()
						rainbow = false
						rainbowconnection:Disconnect()
					else
						game.TweenService:Create(toggleEnabled, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							ImageTransparency = 0
						}):Play()
						rainbow = true
						rainbowconnection = rs.RenderStepped:Connect(function()
							setrgbcolor({zigzag(counter),1,1})
							counter = counter + 0.01
						end)
					end
				end

				onrainbow.MouseButton1Click:Connect(togglerainbow)
				--
				mouse.Move:connect(cp)
				rgb.MouseButton1Down:connect(function()colorpicker=true end)
				dark.MouseButton1Down:connect(function()darknesss=true end)
				uis.InputEnded:Connect(function(input)
					if input.UserInputType.Name == 'MouseButton1' then
						if darknesss then darknesss = false end
						if colorpicker then colorpicker = false end
					end
				end)
				setcolor({h,s,v})
			end

			function Elements:NewLabel(title)
				local labelFunctions = {}
				local label = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				label.Name = "label"
				label.Parent = sectionInners
				label.BackgroundColor3 = themeList.SchemeColor
				label.BackgroundTransparency = 1
				label.BorderSizePixel = 0
				label.ClipsDescendants = true
				label.Text = title
				label.Size = UDim2.new(0, 352, 0, 33)
				label.Font = Enum.Font.Gotham
				label.Text = "  "..title
				label.RichText = true
				label.TextColor3 = themeList.TextColor
				label.TextSize = 12.000
				label.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = label

				updateSectionFrame()
				UpdateSize()
				function labelFunctions:UpdateLabel(newText)
					if label.Text ~= "  "..newText then
						label.Text = "  "..newText
					end
				end
				return labelFunctions
			end
			return Elements
		end
		return Sections
	end
	return Tabs
end
