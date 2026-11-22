local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local function createPart(name, size, position, color, material)
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Position = position
	part.Color = color
	part.Material = material or Enum.Material.SmoothPlastic
	part.Anchored = true
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = Workspace
	return part
end

local function createDune(position, size)
	local dune = createPart(
		"Duna",
		size,
		position,
		Color3.fromRGB(205, 170, 105),
		Enum.Material.Sand
	)
	dune.Shape = Enum.PartType.Ball
end

local function createCactus(position)
	local cactus = Instance.new("Model")
	cactus.Name = "Cactus"
	cactus.Parent = Workspace

	local trunk = createPart("Tronco", Vector3.new(1.8, 7, 1.8), position + Vector3.new(0, 3.5, 0), Color3.fromRGB(70, 145, 85), Enum.Material.Sand)
	trunk.Shape = Enum.PartType.Cylinder
	trunk.CFrame = CFrame.lookAt(trunk.Position, trunk.Position + Vector3.new(0, 1, 0))
	trunk.Parent = cactus

	for _, offset in ipairs({
		Vector3.new(-2, 1.5, 0),
		Vector3.new(2, 3, 0),
	}) do
		local arm = createPart("Brazo", Vector3.new(1.2, 4, 1.2), position + offset, Color3.fromRGB(70, 145, 85), Enum.Material.Sand)
		arm.Shape = Enum.PartType.Cylinder
		arm.CFrame = CFrame.lookAt(arm.Position, arm.Position + Vector3.new(0, 1, 0))
		arm.Parent = cactus
	end
end

local function createRock(position, size)
	local rock = createPart("Roca", size, position, Color3.fromRGB(120, 105, 85), Enum.Material.Slate)
	rock.Shape = Enum.PartType.Ball
end

createPart(
	"SueloDelDesierto",
	Vector3.new(240, 1, 240),
	Vector3.new(0, -0.5, 0),
	Color3.fromRGB(205, 170, 105),
	Enum.Material.Sand
)

for x = -100, 100, 25 do
	for z = -100, 100, 25 do
		local height = math.abs(math.sin(x * 0.025) * math.cos(z * 0.022)) * 4
		createDune(Vector3.new(x, height - 1, z), Vector3.new(22, 8 + height, 22))
	end
end

createCactus(Vector3.new(-45, 0, -35))
createCactus(Vector3.new(-55, 0, 20))
createCactus(Vector3.new(50, 0, -20))
createCactus(Vector3.new(65, 0, 45))
createCactus(Vector3.new(20, 0, 75))

createRock(Vector3.new(-25, 2, 35), Vector3.new(7, 4, 6))
createRock(Vector3.new(35, 2, -55), Vector3.new(9, 5, 7))
createRock(Vector3.new(75, 2, 12), Vector3.new(6, 3, 5))

createPart(
	"Oasis",
	Vector3.new(30, 0.2, 22),
	Vector3.new(-70, 0.12, 70),
	Color3.fromRGB(70, 155, 190),
	Enum.Material.Glass
)
createCactus(Vector3.new(-78, 0, 62))
createCactus(Vector3.new(-62, 0, 78))

local spawn = Instance.new("SpawnLocation")
spawn.Name = "SpawnDelDesierto"
spawn.Size = Vector3.new(12, 1, 12)
spawn.Position = Vector3.new(0, 0.5, 58)
spawn.Color = Color3.fromRGB(255, 195, 90)
spawn.Material = Enum.Material.Neon
spawn.Anchored = true
spawn.Duration = 0
spawn.Parent = Workspace

local function createBat()
	local bat = Instance.new("Tool")
	bat.Name = "Bate"
	bat.CanBeDropped = false
	bat.RequiresHandle = true

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(0.7, 4.5, 0.7)
	handle.Color = Color3.fromRGB(155, 103, 61)
	handle.Material = Enum.Material.Wood
	handle.CanCollide = false
	handle.Massless = true
	handle.Parent = bat

	return bat
end

local function giveBat(player)
	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack and not backpack:FindFirstChild("Bate") then
		createBat().Parent = backpack
	end
end

local SPAWN_POSITION = Vector3.new(0, 4, 58)

local function placeCharacter(character)
	task.defer(function()
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local root = character:FindFirstChild("HumanoidRootPart")

		if humanoid then
			humanoid.WalkSpeed = 16
			humanoid.JumpPower = 50
		end

		if root then
			root.Anchored = true
			root.CFrame = CFrame.new(SPAWN_POSITION)
			task.wait(0.15)
			root.Anchored = false
		end
	end)
end

Players.PlayerAdded:Connect(function(player)
	giveBat(player)

	player.CharacterAdded:Connect(function(character)
		giveBat(player)
		placeCharacter(character)
	end)

	if player.Character then
		placeCharacter(player.Character)
	end
end)

for _, player in ipairs(Players:GetPlayers()) do
	giveBat(player)
end
