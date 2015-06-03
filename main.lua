version=0.3
gdebug=""
trueTimeCoef=1
timeCoef=1/trueTimeCoef
musicVolume=1
sound={}

userDir=love.filesystem.getUserDirectory()

--Libraries
require "lib.stateManager"
require "lib.lovelyMoon"
require "lib.persistence"

--GameStates
require "state.gameState"
require "state.menuState"
require "state.pauseState"
require "state.nextmapState"
require "state.pictureState"

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
		buttonUp="nil",
		buttonDown="nil",
		buttonLeft="nil",
		buttonRight="nil",
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
		buttonUp="nil",
		buttonDown="nil",
		buttonLeft="nil",
		buttonRight="nil",

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
		buttonUp="nil",
		buttonDown="nil",
		buttonLeft="nil",
		buttonRight="nil",

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
		buttonUp="nil",
		buttonDown="nil",
		buttonLeft="nil",
		buttonRight="nil",

		joystick="no joystick",
		button="nil",
		hat="nil",
		hAxis="nil",
		hAxisDirection=1,
		vAxis="nil",
		vAxisDirection=1
	}
	if love.filesystem.exists("ligo.conf") then
		local dir=love.filesystem.getSaveDirectory()
		local w,h,f,v
		keymap,w,h,f,v,musicVolume=persistence.load(dir.."/ligo.conf") 
		love.audio.setVolume(v)
		love.window.setMode(w,h,f)
	else
		for p=1,4 do
			for i,v in pairs(keymap[p].default) do
				keymap[p][i]=v
			end
		end
	end
	love.graphics.setDefaultFilter("nearest","nearest")
	-- keyboard disable repeating key don't seem to work
	love.keyboard:setKeyRepeat(false)

	love.audio.setDistanceModel("linear clamped")

	addState(menuState, "menu")
	addState(pauseState, "pause")
	addState(nextmapState, "nextmap")

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
