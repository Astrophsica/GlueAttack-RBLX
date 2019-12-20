GUI = script.Parent
MainMenu = GUI:WaitForChild("MainMenu")
Scene1 = GUI:WaitForChild("Scene1")

MainMenu.TextButton.MouseButton1Down:Connect(function()
	MainMenu.Visible = false
	Scene1.Visible = true
end)

Scene1.TextButton.MouseButton1Down:Connect(function()
	Scene1.Visible = false
	GUI.Enabled = false
	game.ReplicatedStorage.Remotes.RunGame:FireServer()
end)

GUI.Enabled = true
