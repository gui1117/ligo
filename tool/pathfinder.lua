-- necessite initmap() pour avoir map.height et map.width
local Grid = require ("lib/jumper.grid")
local Pathfinder = require ("lib/jumper.pathfinder")

pathfinding={}
function pathfinding:load(width,height)
	local pmap = {}
	for i = 1,height do
		pmap[i]={}
		for j = 1,width do
			pmap[i][j]=0
		end
	end
	for _,obj in pairs(object) do
		if obj.collision then
			obj.collision(pmap)
		end
	end

	local grid=Grid(pmap)
	pathfinder=Pathfinder(grid, 'JPS', 0)
end
