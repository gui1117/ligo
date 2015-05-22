version=0.3
gdebug=""
trueTimeCoef=1
timeCoef=1/trueTimeCoef

--Libraries
require "lib.stateManager"
require "lib.lovelyMoon"
require "lib.persistence"

--GameStates
require "state.gameState"
require "state.menuState"
require "state.pauseState"
require "state.nextmapState"

function love.load()
	keymap={}
	keymap[1]={}
	keymap[1].default={
		type="keyboard",
		up=love.keyboard.getKeyFromScancode("up"),
		down=love.keyboard.getKeyFromScancode("down"),
		left=love.keyboard.getKeyFromScancode("left"),
		right=love.keyboard.getKeyFromScancode("right"),
		walk=love.keyboard.getKeyFromScancode("lctrl"),
		joystick="no joystick",
		button="nil",
		hat="nil",
		hAxis="nil",
		hAxisDirection=1,
		vAxis="nil",
		vAxisDirection=1
	}
	keymap[2]={}
	keymap[2].default={
		type="keyboard",
		up=love.keyboard.getKeyFromScancode("w"),
		down=love.keyboard.getKeyFromScancode("s"),
		left=love.keyboard.getKeyFromScancode("a"),
		right=love.keyboard.getKeyFromScancode("d"),
		walk=love.keyboard.getKeyFromScancode("lshift"),
		joystick="no joystick",
		button="nil",
		hat="nil",
		hAxis="nil",
		hAxisDirection=1,
		vAxis="nil",
		vAxisDirection=1
	}
	keymap[3]={}
	keymap[3].default={
		type="keyboard",
		up=love.keyboard.getKeyFromScancode("w"),
		down=love.keyboard.getKeyFromScancode("s"),
		left=love.keyboard.getKeyFromScancode("a"),
		right=love.keyboard.getKeyFromScancode("d"),
		walk=love.keyboard.getKeyFromScancode("lshift"),
		joystick="no joystick",
		button="nil",
		hat="nil",
		hAxis="nil",
		hAxisDirection=1,
		vAxis="nil",
		vAxisDirection=1
	}
	keymap[4]={}
	keymap[4].default={
		type="keyboard",
		up=love.keyboard.getKeyFromScancode("w"),
		down=love.keyboard.getKeyFromScancode("s"),
		left=love.keyboard.getKeyFromScancode("a"),
		right=love.keyboard.getKeyFromScancode("d"),
		walk=love.keyboard.getKeyFromScancode("lshift"),
		joystick="no joystick",
		button="nil",
		hat="nil",
		hAxis="nil",
		hAxisDirection=1,
		vAxis="nil",
		vAxisDirection=1
	}
	if love.filesystem.exists("valdmor.conf") then
		local dir=love.filesystem.getSaveDirectory()
		keymap,w,h,f=persistence.load(dir.."/valdmor.conf") 
		love.window.setMode(w,h,f)
	else
		for p=1,4 do
			for i,v in pairs(keymap[p].default) do
				keymap[p][i]=v
			end
		end
	end
	love.graphics.setDefaultFilter("nearest","nearest")
	-- keyboard disable repeating key
	love.keyboard:setKeyRepeat(false)

	love.audio.setDistanceModel("none")
	love.graphics.setPointSize(5)
	love.graphics.setPointStyle("rough")
	--Add Gamestates Here
	addState(menuState, "menu")
	addState(pauseState, "pause")
	addState(nextmapState, "nextmap")

	--Remember to Enable your mestates!
	enableState("menu")
end

function love.update(dt)
	require("lib.lovebird").update()
	lovelyMoon.update(dt)
end

function love.draw()
	lovelyMoon.draw()
end

function love.keypressed(key, unicode)
	lovelyMoon.keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
	lovelyMoon.keyreleased(key, unicode)
end

function love.joystickpressed(joystick,button)
	lovelyMoon.joystickpressed(joystick, button)
end

function love.joystickreleased(joystick,button)
	lovelyMoon.joystickreleased(joystick, button)
end

function love.mousepressed(x, y, button)
	lovelyMoon.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	lovelyMoon.mousereleased(x, y, button)
end