local module = {}

local humanoid = nil
local players = game:GetService("Players")


function SetOnDied()
	humanoid.Died:Connect(function()
		humanoid.GlueMode.Value = false
		local clone = game.ServerStorage.NPC:FindFirstChild(humanoid.Parent.Name):Clone()
		clone:WaitForChild("Glue"):Destroy()
		
		local NPCModule = game.ServerScriptService.Modules.NPC.LoadModule:Clone()
		NPCModule.Parent = clone:WaitForChild("Humanoid")
		NPCModule.Disabled = false
		
		clone.Parent = workspace
		clone:MakeJoints()
		clone:SetPrimaryPartCFrame(humanoid.Parent.PrimaryPart.CFrame)
		humanoid.Parent:Destroy()
	end)
end

function attack(player)
	local npcHumanoidRootPart = humanoid.Parent.HumanoidRootPart
	local playerCharacter = player.Character
	local playerHumanoidRootPart = playerCharacter:WaitForChild("HumanoidRootPart")
	
	local ray = Ray.new(npcHumanoidRootPart.Position, (playerHumanoidRootPart.Position - npcHumanoidRootPart.Position).unit * 50)
	local part, position = workspace:FindPartOnRay(ray, humanoid.Parent)
	
	local beam = Instance.new("Part", workspace)
	beam.Anchored = true
	beam.CanCollide = false
	
	local distance = (npcHumanoidRootPart.Position - position).magnitude
	beam.Size = Vector3.new(0.3, 0.3, distance)
	beam.CFrame = CFrame.new(npcHumanoidRootPart.Position, position) * CFrame.new(0, 0, -distance / 2)
	
	game.Debris:AddItem(beam, 0.1)
	
	local bullet = Instance.new("Part", workspace)
	local sphereMesh = Instance.new("SpecialMesh", bullet)
	sphereMesh.MeshType = Enum.MeshType.Sphere
	bullet.Anchored = true
	bullet.CanCollide = false
	bullet.Size = Vector3.new(2, 2, 2)
	bullet.Material = Enum.Material.Glass
	bullet.Transparency = 0.5
	
	local increment = distance / 5
	
	bullet.Touched:Connect(function(hit)
		if hit.Parent.Name == player.Name then
			hit.Parent:FindFirstChild("Humanoid"):TakeDamage(1)
			playerCharacter:WaitForChild("Slowness").Activate:Fire(2, 8)
		end
	end)
	
	game.Debris:AddItem(bullet, 0.5)
	
	for i = 1, 5 do
		bullet.CFrame = CFrame.new(npcHumanoidRootPart.Position, position) * CFrame.new(0, 0, (-increment * i))
		if playerCharacter.Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) then
			bullet.Position = bullet.Position + playerHumanoidRootPart.CFrame.lookVector * 5
		end
		wait()
	end
	
	
end





function module.Run(NPChumanoid)
	humanoid = NPChumanoid
	SetOnDied()
	while humanoid.GlueMode.Value do
		for _, player in pairs(players:GetChildren())do
			if player.Character then
				if (humanoid.Parent.HumanoidRootPart.Position - player.Character:FindFirstChild("HumanoidRootPart").Position).magnitude < 50 then
					attack(player)
				end
			end
		end
		wait(0.5)
	end
end


return module
