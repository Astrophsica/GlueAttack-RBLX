game.ReplicatedStorage.Remotes.GetMouseHit.OnClientInvoke = function()
	local player = game:GetService("Players").LocalPlayer
	return player:GetMouse().Hit
end
