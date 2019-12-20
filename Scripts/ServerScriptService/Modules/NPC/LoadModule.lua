enemyModule = game.ServerScriptService.Modules.NPC.Enemy:Clone()
enemyModule = require(enemyModule)

bossModule = game.ServerScriptService.Modules.NPC.BossEnemy:Clone()
bossModule = require(bossModule)

pathFindModule = game.ServerScriptService.Modules.NPC.Pathfind:Clone()
pathFindModule = require(pathFindModule)

gluelessModule = game.ServerScriptService.Modules.NPC.Glueless:Clone()
gluelessModule = require(gluelessModule)


if script.Parent.Parent.Name == "David" then
	
	if script.Parent.Parent:FindFirstChild("Glue") then
		spawn(function()
			bossModule.Run(script.Parent)
		end)
	else
		spawn(function()
			gluelessModule.Run(script.Parent)
		end)
	end
	
else
	
	if script.Parent.Parent:FindFirstChild("Glue") then
		spawn(function()
			enemyModule.Run(script.Parent)
		end)

		spawn(function()
			pathFindModule.Run(script.Parent)
		end)
	else
		spawn(function()
			gluelessModule.Run(script.Parent)
		end)
	end
	
end



