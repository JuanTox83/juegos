local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local function newPart(name, size, position, color, material, parent)
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Position = position
	part.Color = color
	part.Material = material or Enum.Material.SmoothPlastic
	part.Anchored = true
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = parent or Workspace
	return part
end

local function createSpawn()
	local spawn = Instance.new("SpawnLocation")
	spawn.Name = "ZonaDeInicio"
	spawn.Size = Vector3.new(12, 1, 12)
	spawn.Position = Vector3.new(0, 0.5, 58)
	spawn.Color = Color3.fromRGB(64, 180, 120)
	spawn.Material = Enum.Material.Neon
	spawn.Anchored = true
	spawn.Duration = 0
	spawn.Parent = Workspace

	newPart("ToldoInicio", Vector3.new(14, 1, 14), Vector3.new(0, 8, 58), Color3.fromRGB(235, 235, 235), Enum.Material.SmoothPlastic)
	for _, offset in ipairs({-5, 5}) do
		newPart("ColumnaInicio", Vector3.new(0.8, 7.5, 0.8), Vector3.new(offset, 4, 52), Color3.fromRGB(210, 210, 210), Enum.Material.SmoothPlastic)
		newPart("ColumnaInicio", Vector3.new(0.8, 7.5, 0.8), Vector3.new(offset, 4, 64), Color3.fromRGB(210, 210, 210), Enum.Material.SmoothPlastic)
	end
end

local function createRoad(name, size, position)
	newPart(name, size, position, Color3.fromRGB(65, 68, 72), Enum.Material.Asphalt)
	if size.Z > size.X then
		for line = -size.Z / 2 + 6, size.Z / 2 - 6, 12 do
			newPart("LineaCentral", Vector3.new(0.35, 0.03, 5), Vector3.new(position.X, position.Y + 0.02, position.Z + line), Color3.fromRGB(255, 210, 70), Enum.Material.SmoothPlastic)
		end
	else
		for line = -size.X / 2 + 6, size.X / 2 - 6, 12 do
			newPart("LineaCentral", Vector3.new(5, 0.03, 0.35), Vector3.new(position.X + line, position.Y + 0.02, position.Z), Color3.fromRGB(255, 210, 70), Enum.Material.SmoothPlastic)
		end
	end
end

local function createWindowBuilding(name, position, size, wallColor)
	local model = Instance.new("Model")
	model.Name = name
	model.Parent = Workspace

	newPart("Pared", size, position, wallColor, Enum.Material.Brick, model)

	local door = newPart("Entrada", Vector3.new(5, 6, 0.35), Vector3.new(position.X, position.Y - size.Y / 2 + 3, position.Z - size.Z / 2 - 0.18), Color3.fromRGB(75, 55, 45), Enum.Material.Wood, model)
	door.CanCollide = true

	local floors = math.max(1, math.floor((size.Y - 5) / 8))
	for floor = 1, floors do
		local y = position.Y - size.Y / 2 + 8 * floor
		for x = -size.X / 2 + 5, size.X / 2 - 5, 10 do
			newPart("Ventana", Vector3.new(3.5, 3.5, 0.25), Vector3.new(position.X + x, y, position.Z - size.Z / 2 - 0.15), Color3.fromRGB(110, 190, 220), Enum.Material.Glass, model)
		end
	end

	newPart("Tejado", Vector3.new(size.X + 1, 1, size.Z + 1), Vector3.new(position.X, position.Y + size.Y / 2 + 0.5, position.Z), Color3.fromRGB(90, 95, 105), Enum.Material.Slate, model)
end

local function createTree(position)
	local model = Instance.new("Model")
	model.Name = "Arbol"
	model.Parent = Workspace
	newPart("Tronco", Vector3.new(1.5, 7, 1.5), Vector3.new(position.X, position.Y + 3.5, position.Z), Color3.fromRGB(110, 75, 45), Enum.Material.Wood, model)
	newPart("Copa", Vector3.new(7, 5, 7), Vector3.new(position.X, position.Y + 9, position.Z), Color3.fromRGB(70, 145, 75), Enum.Material.Grass, model)
end

local function createLamp(position)
	local model = Instance.new("Model")
	model.Name = "Farola"
	model.Parent = Workspace
	newPart("Poste", Vector3.new(0.5, 8, 0.5), Vector3.new(position.X, position.Y + 4, position.Z), Color3.fromRGB(45, 45, 45), Enum.Material.Metal, model)
	newPart("Bombilla", Vector3.new(2, 0.5, 2), Vector3.new(position.X, position.Y + 8, position.Z), Color3.fromRGB(255, 235, 150), Enum.Material.Neon, model)
end

newPart("Suelo", Vector3.new(240, 1, 240), Vector3.new(0, -0.5, 0), Color3.fromRGB(95, 130, 75), Enum.Material.Grass)

createRoad("AvenidaPrincipal", Vector3.new(28, 0.2, 220), Vector3.new(0, 0.1, 0))
createRoad("CalleHorizonalIzquierda", Vector3.new(220, 0.2, 24), Vector3.new(-10, 0.1, -45))
createRoad("CalleHorizontalDerecha", Vector3.new(220, 0.2, 24), Vector3.new(10, 0.1, 45))

createWindowBuilding("Ayuntamiento", Vector3.new(-85, 15, 0), Vector3.new(38, 30, 30), Color3.fromRGB(180, 180, 160))
createWindowBuilding("Hospital", Vector3.new(82, 13, -20), Vector3.new(52, 26, 34), Color3.fromRGB(225, 225, 215))
createWindowBuilding("Escuela", Vector3.new(-75, 12, 78), Vector3.new(48, 24, 32), Color3.fromRGB(195, 150, 90))
createWindowBuilding("Supermercado", Vector3.new(78, 10, 78), Vector3.new(44, 20, 34), Color3.fromRGB(70, 145, 170))
createWindowBuilding("Comisaria", Vector3.new(-76, 9, -78), Vector3.new(36, 18, 30), Color3.fromRGB(95, 115, 145))
createWindowBuilding("TiendaDeJuegos", Vector3.new(76, 9, -78), Vector3.new(38, 18, 30), Color3.fromRGB(145, 90, 150))

newPart("Parque", Vector3.new(42, 0.15, 42), Vector3.new(-35, 0.08, 35), Color3.fromRGB(85, 155, 80), Enum.Material.Grass)
for _, position in ipairs({
	Vector3.new(-50, 0.15, 20),
	Vector3.new(-22, 0.15, 20),
	Vector3.new(-50, 0.15, 50),
	Vector3.new(-22, 0.15, 50),
}) do
	createTree(position)
end
newPart("Fuente", Vector3.new(12, 1.5, 12), Vector3.new(-35, 0.75, 35), Color3.fromRGB(105, 175, 190), Enum.Material.SmoothPlastic)
newPart("FuenteAgua", Vector3.new(9, 0.2, 9), Vector3.new(-35, 1.55, 35), Color3.fromRGB(90, 180, 225), Enum.Material.Glass)

for x = -105, 105, 30 do
	createLamp(Vector3.new(x, 0, -8))
	createLamp(Vector3.new(x, 0, 8))
end

createSpawn()

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

for _, player in Players:GetPlayers() do
	giveBat(player)
end