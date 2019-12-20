local tool = script.Parent
local player = tool.Parent.Parent

tool.Activated:Connect(function()
		
		script.Parent.Handle.Sound:Play()
		
		local mouseHit = game.ReplicatedStorage.Remotes.GetMouseHit:InvokeClient(player)
		local ray = Ray.new(tool.Handle.CFrame.Position, (mouseHit.p - tool.Handle.CFrame.p).unit * 25)
		local part, position = workspace:FindPartOnRay(ray, player.Character)
		
		
		local beam = Instance.new("Part", workspace)
		beam.BrickColor = BrickColor.new("Bright red")
		beam.Material = "Neon"
		beam.Anchored = true
		beam.CanCollide = false
		
		local distance = (tool.Handle.CFrame.p - position).magnitude
		beam.Size = Vector3.new(0.3, 0.3, distance)
		beam.CFrame = CFrame.new(tool.Handle.CFrame.p, position) * CFrame.new(0, 0, -distance / 2)
		
		game:GetService("Debris"):AddItem(beam, 0.1)
		
		if part then
			local humanoid = part.Parent:FindFirstChild("Humanoid")
			
			if not humanoid then
				humanoid = part.Parent.Parent:FindFirstChild("Humanoid")
			end
			
			if humanoid then
				if humanoid.Parent:FindFirstChild("Glue") then
					humanoid:TakeDamage(10)
				end
			end
		end
end)