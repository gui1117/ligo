--Example of a GameState file

--Table
pauseState = {}

--New
function pauseState:new()
	local gs = {}

	gs = setmetatable(gs, self)
	self.__index = self
	_gs = gs

	return gs
end

--Load
function pauseState:load()
	mem={}
	paused=false
end

--Close
function pauseState:close()
end

--Enable
function pauseState:enable()
	-- mise en memoire et desactivation de tout les états courant
	for _,state in pairs(_slotState.states) do
		if state._enabled then
			table.insert(mem,state._id)
			disableState(state._id)
		end
	end
end


--Disable
function pauseState:disable()
	if togame then
		for _,stateIndex in ipairs(mem) do
			enableState(stateIndex)
		end
	else
		destroyState("game")	
		enableState("menu")
	end
	mem={}
end

--Update
function pauseState:update(dt)
	paused=true
end

--Draw
function pauseState:draw()
	love.graphics.print("Pause, press space to resume\nPress escape to quit", 64, 64)
end

--KeyPressed
function pauseState:keypressed(key, unicode)
	if paused then
		if key == " " then
			togame=true
			disableState("pause")
		end
		if key == "escape" then
			togame=false
			disableState("pause")
		end
	end

end

--KeyRelease
function pauseState:keyreleased(key, unicode)
end

--MousePressed
function pauseState:mousepressed(x, y, button)
end

--MouseReleased
function pauseState:mousereleased(x, y, button)
end
