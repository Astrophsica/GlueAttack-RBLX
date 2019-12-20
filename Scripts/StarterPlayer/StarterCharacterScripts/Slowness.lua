local playerHumanoid = script.Parent:WaitForChild("Humanoid")
local defaultWalkSpeed = playerHumanoid.WalkSpeed

script.Activate.Event:Connect(function(timing, speed)
	playerHumanoid.WalkSpeed = speed
	wait(timing)
	playerHumanoid.WalkSpeed = defaultWalkSpeed
end)
