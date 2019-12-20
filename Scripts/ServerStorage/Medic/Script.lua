script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		if hit.Parent:FindFirstChild("Glue") == nil then
			hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health + 20
			script.Parent:Destroy()
		end
	end
end)
