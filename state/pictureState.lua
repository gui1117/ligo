require "tool.loadmap"

pictureState = {}

--New
function pictureState:new()
	local gs = {}

	gs = setmetatable(gs, self)
	self.__index = self
	_gs = gs

	return gs
end

--Load
function pictureState:load()
	picture=false
	picturenbr=0
	dungeon=dungeonList[dungeonList.current]
	level=dungeon[dungeon.current]
	if level.music then
		initmusic(level.music,false)
	else
		music=nil
	end
	if level.image then
		if love.filesystem.exists(userDir.."image/"..level.image) then
			image=love.graphics.newImage(userDir.."image/"..level.image)
		elseif love.filesystem.exists("image/"..level.image) then
			image=love.graphics.newImage("image/"..level.image)
		end
	end
end

--Close
function pictureState:close()
	image=nil
	if music then
		music:stop()
	end
	enableState("nextmap")
end

--Enable
function pictureState:enable()
	if music then
		music:play()
	end
end

--Disable
function pictureState:disable()
	if music then
		music:stop()
	end
end

--Update
function pictureState:update(dt)
	picturenbr=picturenbr+1
	if picturenbr > 2 then
		picture=true
	end
end

--Draw
function pictureState:draw()
	if level.image then
		local iw,ih=image:getDimensions()
		local sw,sh=love.window.getDimensions()
		local scale
		if iw/sw > ih/sh then
			scale=sw/iw
		else
			scale=sh/ih
		end
		love.graphics.draw(image,sw/2-iw*scale/2,sh/2-ih*scale/2,0,scale,scale)
	end
	if level.text then
		love.graphics.printf(level.text,love.window.getWidth()/2,love.window.getHeight()/3,2500,"center",0,1.5,1.5,1250,0)
	end
end

--KeyPressed
function pictureState:keypressed(key, unicode)
	if picture then
		destroyState("game")
	end
end

--KeyReleased
function pictureState:keyreleased(key, unicode)
end

function pictureState:joystickpressed(joystick, button)
	if picture then
		destroyState("game")
	end
end

function pictureState:joystickreleased(joystick, button)
end

--MousePressed
function pictureState:mousepressed(x, y, button)
end

--MouseReleased
function pictureState:mousereleased(x, y, button)
end
