--Example of a GameState file

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
	if nextmap and mapList.current~=table.getn(mapList) then
		mapList.current=mapList.current+1
	end
	if mapList[mapList.current].sound~=musicname then
		musicname=mapList[mapList.current].sound
		music=nil
		music=love.audio.newSource("sound/"..musicname..".mp3","stream")
		music:setLooping(true)
	end
	music:play()
	nextmap=false
		
	addState(gameState,"game")
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
