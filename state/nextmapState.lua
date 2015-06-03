--Table
nextmapState = {}

--New
function nextmapState:new()
	local gs = {}

	gs = setmetatable(gs, self)
	self.__index = self
	_gs = gs

	return gs
end

--Load
function nextmapState:load()
end

--Close
function nextmapState:close()
end

--Enable
function nextmapState:enable()
	local dungeon=dungeonList[dungeonList.current]
	dungeon.current=dungeon.current+1
	if dungeon.current > table.getn(dungeon) then
		enableState("menu")
		return
	end
	local level=dungeon[dungeon.current]
	if level.type == "picture" then
		addState(pictureState,"game")
	elseif level.type == "level" then
		addState(gameState,"game")
	end
end

--Disable
function nextmapState:disable()
end

--Update
function nextmapState:update(dt)
	enableState("game")
	disableState("nextmap")
end

--Draw
function nextmapState:draw()
end
