require "object.objects"
require "lib.tiolved"
require "tool.loadmap"

gameState = {}

--New
function gameState:new()
	local gs = {}

	gs = setmetatable(gs, self)
	self.__index = self
	_gs = gs

	return gs
end

--Load
function gameState:load()
	debug=""
	debug2=""
	debug3=""
	debug4=""
	initobject()
	world=love.physics.newWorld(0,0,true)
	world:setCallbacks(beginContact,endContact, preSolve, postSolve)
	love.physics.setMeter(1)
	initmap(mapList[mapList.current])
end

--Close
function gameState:close()
	world:destroy()
	music:pause()
end

--Enable
function gameState:enable()
	music:play()
end

--Disable
function gameState:disable()
	music:pause()
end

--Update
function gameState:update(dt)
	dt=dt/timeCoef
	local t = love.timer.getTime()
	world:update(dt)
	tworld=love.timer.getTime() - t 
	local t2 = love.timer.getTime()
	tileset:update(dt)
	ttileset=love.timer.getTime() -t2
	for k,v in pairs(object) do
		if v.update then 
			v.update()
		end
	end
	camera:update()
	tupdate=love.timer.getTime() - t
end

--Draw
function gameState:draw()
	local t = love.timer.getTime()
	for _,v in pairs(object) do
		if v.draw then
			v.draw()
		end
	end
	tdrawobject=love.timer.getTime()-t
	t2=love.timer.getTime()
	layers:draw()
	tdrawlayers=love.timer.getTime()-t2
	t2=love.timer.getTime()
	camera:set()
	tileset:draw()
	camera:unset()
	tdrawtileset=love.timer.getTime()-t2

	tdraw=love.timer.getTime() - t
	if printdebug then
		love.graphics.print(
		debug..
		"\n"..debug2..
		"\n"..debug3..
		"\n"..debug4..
		"\n FPS:"..love.timer.getFPS()..
		"\n Delta"..1000*love.timer.getDelta()..
		"\n"..gdebug..
		"\ntupdate ="..tupdate..
		"\nttileset ="..ttileset..
		"\ntdraw ="..tdraw..
		"\ntdrawobject ="..tdrawobject..
		"\ntdrawlayers ="..tdrawlayers..
		"\ntdrawtileset ="..tdrawtileset
		)
	end
end

--KeyPressed
function gameState:keypressed(key, unicode)
	character.keypressed(key,unicode)
	if key == "escape" then
		enableState("pause")
--	elseif key == "kp+" then 
--		love.audio.setVolume(love.audio.getVolume()*1.5)
--	elseif key == "kp-" then
--		love.audio.setVolume(love.audio.getVolume()*0.5)
	elseif key == "p" then
		music:pause()
	elseif key == "g" then
		printdebug=not printdebug
	end
end

--KeyReleased
function gameState:keyreleased(key, unicode)
	character.keyreleased(key,unicode)
end

function gameState:joystickpressed(joystick, button)
	character.joystickpressed(joystick,button)
end

function gameState:joystickreleased(joystick, button)
	character.joystickreleased(joystick,button)
end


--MousePressed
function gameState:mousepressed(x, y, button)
end

--MouseReleased
function gameState:mousereleased(x, y, button)
end

function beginContact(a,b,coll) 
	local ua=a:getUserData()
	local ub=b:getUserData()

	if ua.beginContact then
		table.insert(ua.beginContact,{coll=coll,other=ub})
	end
	if ub.beginContact then
		table.insert(ub.beginContact,{coll=coll,other=ua})
	end
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end
