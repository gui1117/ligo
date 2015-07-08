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
	buttonPress=1
	currentButton={
		escape=function()
			togame=true
			disableState("pause")
		end,
		{name=function()
			return "resume"
		end,
		enter=function()
			togame=true
			disableState("pause")
		end},
		{name=function()
			return "master volume "..math.round(20*love.audio.getVolume())/20
		end,
		left=function()
			local s=math.round(20*love.audio.getVolume())/20
			love.audio.setVolume(math.max(0,s-0.05))
		end,
		right=function()
			local s=math.round(20*love.audio.getVolume())/20
			love.audio.setVolume(math.min(1,s+0.05))
		end},
		{name=function()
			return "music volume "..musicVolume
		end,
		left=function()
			musicVolume=math.max(0,musicVolume-0.05)
			music:setVolume(musicVolume)
		end,
		right=function()
			musicVolume=math.min(1,musicVolume+0.05)
			music:setVolume(musicVolume)
		end},
		{name=function()
			return "return"
		end,
		enter=function()
			togame=false
			disableState("pause")
		end}
	}



--		{name=function()
--			return "character velocity : "..character.velocity
--		end,
--		right=function()
--			character.velocity=math.ceil(10*character.velocity*1.1)/10
--		end,
--		left=function()
--			character.velocity=math.floor(10*character.velocity*0.9)/10
--		end},
--		{name=function()
--			return "time coefficient : "..timeCoef
--		end,
--		right=function()
--			timeCoef=math.ceil(10*timeCoef*1.1)/10
--		end,
--		left=function()
--			timeCoef=math.floor(10*timeCoef*0.9)/10
--		end},

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
	local b=""
	for i,v in ipairs(currentButton) do
		local mes=v.name()
		if buttonPress==i then
			local len=string.len(mes)
			b=b.."\n"
			for i=1,len do
				b=b.."="
			end
			b=b.."\n|| "..mes.." ||\n"
			for i=1,len do
				b=b.."="
			end
		else
			b=b.."\n"..mes
		end
	end
	love.graphics.printf(b,love.window.getWidth()/2,love.window.getHeight()/2,250,"center",0,1,1,125,0)

end

--KeyPressed
function pauseState:keypressed(key, unicode)
	if paused then
	if askKey then
		changeKey(key)
		askKey=false
	elseif key=="up" then
		if currentButton[buttonPress-1] then
			buttonPress=buttonPress-1
		else
			buttonPress=table.getn(currentButton)
		end
		changesound:play()
	elseif key=="down" or key==" " then
		if currentButton[buttonPress+1] then
			buttonPress=buttonPress+1
		else
			buttonPress=1
		end
		changesound:play()
	elseif key=="right" or key=="return" then
		if currentButton[buttonPress].right then
			currentButton[buttonPress].right()
			changesound:play()
		elseif currentButton[buttonPress].enter then
			currentButton[buttonPress].enter()
			selectsound:play()
		end
	elseif key=="left" then
		if currentButton[buttonPress].left then
			currentButton[buttonPress].left()
		changesound:play()
		elseif currentButton[buttonPress].enter then
			currentButton[buttonPress].enter()
			selectsound:play()
		end
	elseif key=="escape" then
		currentButton.escape()
		selectsound:play()
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
