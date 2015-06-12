--Example of a GameState file

--Table
menuState = {}

--New
function menuState:new()
	local gs = {}

	gs = setmetatable(gs, self)
	self.__index = self
	_gs = gs
	
	return gs
end

--Load
function menuState:load()
	titletheme=love.audio.newSource("sound/Lappel-8-bit.mp3","stream")
	titletheme:setVolume(musicVolume)
	selectsound=love.audio.newSource("sound/selectButton.ogg","static")
	changesound=love.audio.newSource("sound/changeButton.ogg","static")
end

--Close
function menuState:close()
end

--Enable
function menuState:enable()
	titletheme:play()
	menuButton={
		escape=function()
			love.event.quit()
		end,
		{name=function()
			return "play"
		end,
		enter=function()
			buttonPress=1
			currentButton=levelButton
		end},
		{name=function()
			return "manual"
		end,
		enter=function()
			buttonPress=1
			currentButton=manualButton
		end},
		{name=function()
			return "setting"
		end,
		enter=function()
			buttonPress=1
			currentButton=settingButton
		end},
		{name=function()
			return "credit"
		end,
		enter=function()
			buttonPress=1
			currentButton=creditButton
		end},
		{name=function()
			return "quit"
		end,
		enter=function()
			love.event.quit()
		end},
	}
	creditButton={
		escape=function()
			buttonPress=1
			currentButton=menuButton
		end,
		{name=function()
			return "Created by THIOLLIERE,\nmusic by Therence\n see www.thiolliere.org"
		end,
		enter=function()
			buttonPress=1
			currentButton=menuButton
		end}
	}
	settingButton={
		escape=function()
			buttonPress=1
			currentButton=menuButton
		end,
		{name=function()
			return "input"
		end,
		enter=function()
			buttonPress=1
			currentButton=settingInput
		end},
		{name=function()
			return "video"
		end,
		enter=function()
			buttonPress=1
			currentButton=settingVideo
		end},
		{name=function()
			return "sound"
		end,
		enter=function()
			buttonPress=1
			currentButton=settingSound
		end},
		{name=function() return "save configuration" end,
		enter=function()
			local w,h,f=love.window.getMode()
			local dir=love.filesystem.getSaveDirectory()
			if not love.filesystem.exists(dir) then
				love.filesystem.write("ligo.conf","")
			end
			persistence.store(dir.."/ligo.conf",keymap,w,h,f,love.audio.getVolume(),musicVolume)
		end
		},
		{name=function() return "reset configuration" end,
		enter=function()
			local dir=love.filesystem.getSaveDirectory()
			if love.filesystem.exists(dir) and love.filesystem.exists(dir.."/ligo.conf") then
				love.filesystem.remove(dir.."/ligo.conf")

			end
		end},
		{name=function()
			return "return"
		end,
		enter=function()
			buttonPress=1
			currentButton=menuButton
		end}
	}
	settingVideo={
		escape=function()
			buttonPress=1
			currentButton=settingButton
		end,
		{name=function()
			if love.window.getFullscreen() then
				return "unset fullscreen" 
			else
				return "set fullscreen"
			end
		end,
		enter=function()
			love.window.setFullscreen( not love.window.getFullscreen())
		end},
		{name=function()
			local w,h,f=love.window.getMode()
			return "set dimension ("..w..","..h..")"

		end,
		right=function()
			local w,h,f=love.window.getMode()
			local modes = love.window.getFullscreenModes()
			table.sort(modes, function(a, b) return a.width*a.height < b.width*b.height end) 
			local n = table.getn(modes)
			local k
			for i,v in ipairs(modes) do
				if v.width==w and v.height==h then
					k=math.min(i+1,n)
				end
			end
			if not k then k=n end
			w=modes[k].width
			h=modes[k].height
			love.window.setMode(w,h,f)
		end,
		left=function()
			local w,h,f=love.window.getMode()
			local modes = love.window.getFullscreenModes()
			table.sort(modes, function(a, b) return a.width*a.height < b.width*b.height end) 
			local n = table.getn(modes)
			local k
			for i,v in ipairs(modes) do
				if v.width==w and v.height==h then
					if i == 1 then 
						k=1
					else
						k=i-1
					end
				end
			end
			if not k then k=n-1 end
			w=modes[k].width
			h=modes[k].height
			love.window.setMode(w,h,f)
		end},
--		{name=function()
--			local _,_,f=love.window.getMode()
--			if f.vsync then
--				return "unset vsync"
--			else
--				return "set vsync"
--			end
--
--		end,
--		right=function()
--			local w,h,f=love.window.getMode()
--			f.vsync=not f.vsync
--			love.window.setMode(w,h,f)
---		end,
--		left=function()
--			local w,h,f=love.window.getMode()
--			f.sync=not f.vsync
--			love.window.setMode(w,h,f)
--		end},
		--name=fsaa
		{name=function()
			return "return"
		end,
		enter=function()
			buttonPress=1
			currentButton=settingButton
		end}
	}
	settingSound={
		escape=function()
			buttonPress=1

			currentButton=settingButton
		end,
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
			titletheme:setVolume(musicVolume)
		end,
		right=function()
			musicVolume=math.min(1,musicVolume+0.05)
			titletheme:setVolume(musicVolume)
		end},
		{name=function()
			return "return"
		end,
		enter=function()
			buttonPress=1
			currentButton=settingButton
		end}
	}
	settingInput={
		escape=function()
			buttonPress=1
			currentButton=settingButton
		end,
		{name=function()
			return "set default"
		end,
		enter=function()
			for p=1,2 do
				for i,v in pairs(keymap[p].default) do
					keymap[p][i]=v
				end
			end
		end},
		{name=function()
			return "player 1"
		end,
		enter=function()
			buttonPress=1
			currentButton=playerInput
			playerSetting=1
		end},
		{name=function()
			return "player 2"
		end,
		enter=function()
			buttonPress=1
			currentButton=playerInput
			playerSetting=2
		end},
		{name=function()
			return "player 3"
		end,
		enter=function()
			buttonPress=1
			currentButton=playerInput
			playerSetting=3
		end},
		{name=function()
			return "player 4"
		end,
		enter=function()
			buttonPress=1
			currentButton=playerInput
			playerSetting=4
		end},
		{name=function()
			return "return"
		end,
		enter=function()
			buttonPress=1
			currentButton=settingButton
		end}    
	}
	dungeonList={current=1}
	sourceInsertDungeonList=function(name)
		if string.find(name,".dungeon.lua") and not string.find(name,".swp") then
			table.insert(dungeonList,love.filesystem.load("dungeon/"..name)())
		end
	end
	userInsertDungeonList=function(name)
		if string.find(name,".dungeon.lua") and not string.find(name,".swp") then
			table.insert(dungeonList,love.filesystem.load(love.filesystem.getUserDirectory().."dungeon/"..name)())
		end
	end
	love.filesystem.getDirectoryItems("dungeon",sourceInsertDungeonList)
	if love.filesystem.exists(love.filesystem.getUserDirectory().."dungeon") then
		love.filesystem.getDirectoryItems(love.filesystem.getUserDirectory().."dungeon",userInsertDungeonList)
	end
	levelButton={
		escape=function()
			buttonPress=1
			currentButton=menuButton
		end,
		{name=function()
			return "play"
		end,
		enter=function()
			disableState("menu")
			enableState("nextmap")
		end},
		{name=function()
			return "dungeon : "..dungeonList[dungeonList.current].name
		end,
		right=function()
			dungeonList.current=dungeonList.current%table.getn(dungeonList)+1
		end,
		left=function()
			dungeonList.current=(dungeonList.current-2)%table.getn(dungeonList)+1
		end},
		{name=function()
			return "time multiplicator coefficient : "..timeCoef.." [1]"
		end,
		right=function()
			timeCoef=timeCoef+0.1
		end,
		left=function()
			timeCoef=timeCoef-0.1
		end},
		{name=function()
			return "character velocity: "..character.velocity.." [10]"
		end,
		right=function()
			character.velocity=character.velocity+0.5
		end,
		left=function()
			character.velocity=character.velocity-0.5
		end},
		{name=function()
			return "return"
		end,
		enter=function()
			buttonPress=1
			currentButton=menuButton
		end}

	}
	manualButton={
		escape=function()
			buttonPress=1
			currentButton=menuButton
		end,
		{name=function()
			return "run in two dimension\nwalk by holding a key\n\nwhen you die you become a phantom that can rebirth by touching a character alive\n\nlink is reset between player when touching, it is constituted of two part a hazardous one and a safe one."
		end},
		{name=function()
			return "return"
		end,
		enter=function()
			buttonPress=1
			currentButton=menuButton
		end}
	}
	playerInput={
		escape=function()
			buttonPress=1
			currentButton=settingInput
		end,
		{name=function()
			return "type : "..keymap[playerSetting].type
		end,
		right=function()
			if keymap[playerSetting].type=="keyboard" then
				keymap[playerSetting].type="hat"
			elseif keymap[playerSetting].type=="hat" then
				keymap[playerSetting].type="axis"
			elseif keymap[playerSetting].type=="axis" then
				keymap[playerSetting].type="button"
			else
				keymap[playerSetting].type="keyboard"
			end
		end,
		left=function()
			if keymap[playerSetting].type=="keyboard" then
				keymap[playerSetting].type="button"
			elseif keymap[playerSetting].type=="hat" then
				keymap[playerSetting].type="keyboard"
			elseif keymap[playerSetting].type=="axis" then
				keymap[playerSetting].type="hat"
			else
				keymap[playerSetting].type="axis"
			end
		end,
		keyboard=true,
		hat=true,
		button=true,
		axis=true},
		{name=function()
			return "up : "..keymap[playerSetting].up or "nil"
		end,
		enter=function()
			askKey=true
			keymap[playerSetting].up=" new key  "
			function changeKey(key)
				keymap[playerSetting].up=key
			end
		end,
		keyboard=true,
		hat=false,
		axis=false},
		{name=function()
			return "down : "..keymap[playerSetting].down or "nil"
		end,
		enter=function()
			askKey=true
			keymap[playerSetting].down=" new key  "
			function changeKey(key)
				keymap[playerSetting].down=key
			end
		end,
		keyboard=true,
		hat=false,
		axis=false},
		{name=function()
			return "left : "..keymap[playerSetting].left
		end,
		enter=function()
			askKey=true
			keymap[playerSetting].left=" new key  "
			function changeKey(key)
				keymap[playerSetting].left=key
			end
		end,
		keyboard=true,
		hat=false,
		axis=false},
		{name=function()
			return "right : "..keymap[playerSetting].right
		end,
		enter=function()
			askKey=true
			keymap[playerSetting].right=" new key  "
			function changeKey(key)
				keymap[playerSetting].right=key
			end
		end,
		keyboard=true,
		hat=false,
		axis=false},
		{name=function()
			return "walk : "..keymap[playerSetting].walk
		end,
		enter=function()
			askKey=true
			keymap[playerSetting].walk=" new key  "
			function changeKey(key)
				keymap[playerSetting].walk=key
			end
		end,
		keyboard=true,
		hat=false,
		axis=false},
		{name=function()
			return "joystick : "..keymap[playerSetting].joystick
		end,
		right=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				j_id=j_id or 1
				j_id=j_id % love.joystick.getJoystickCount() +1
				keymap[playerSetting].joystick=js[j_id]:getName()
			end
		end,
		left=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				j_id=j_id or 1
				j_id=(j_id-2) % love.joystick.getJoystickCount() +1
				keymap[playerSetting].joystick=js[j_id]:getName()
			end
		end,
		keyboard=false,
		hat=true,
		axis=true,
		button=true},
		{name=function()
			return "up pad button : "..keymap[playerSetting].buttonUp
		end,
		enter=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				else
					local j=js[j_id]
					askButton=true
					keymap[playerSetting].buttonUp=" new button "
					function changeButton(button)
						keymap[playerSetting].buttonUp=button
					end
				end
			end
		end,
		keyboard=false,
		hat=false,
		button=true,
		axis=false},
		{name=function()
			return "down pad button : "..keymap[playerSetting].buttonDown
		end,
		enter=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				else
					local j=js[j_id]
					askButton=true
					keymap[playerSetting].buttonDown=" new button "
					function changeButton(button)
						keymap[playerSetting].buttonDown=button
					end
				end
			end
		end,
		keyboard=false,
		hat=false,
		button=true,
		axis=false},

		{name=function()
			return "left pad button : "..keymap[playerSetting].buttonLeft
		end,
		enter=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				else
					local j=js[j_id]
					askButton=true
					keymap[playerSetting].buttonLeft=" new button "
					function changeButton(button)
						keymap[playerSetting].buttonLeft=button
					end
				end
			end
		end,
		keyboard=false,
		hat=false,
		button=true,
		axis=false},

		{name=function()
			return "right pad button : "..keymap[playerSetting].buttonRight
		end,
		enter=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				else
					local j=js[j_id]
					askButton=true
					keymap[playerSetting].buttonRight=" new button "
					function changeButton(button)
						keymap[playerSetting].buttonRight=button
					end
				end
			end
		end,
		keyboard=false,
		hat=false,
		button=true,
		axis=false},


		{name=function()
			return "hat number "..keymap[playerSetting].hat
		end,
		right=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				elseif js[j_id]:getHatCount()~=0 then
					local j=js[j_id]
					if keymap[playerSetting].hat=="nil" then
						keymap[playerSetting].hat=1
					else
						keymap[playerSetting].hat=keymap[playerSetting].hat % j:getHatCount() + 1
					end
				else
					keymap[playerSetting].hat="nil"
				end
			end
		end,
		left=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				elseif js[j_id]:getHatCount()~=0 then
					local j=js[j_id]
					if keymap[playerSetting].hat=="nil" then
						keymap[playerSetting].hat=1
					else
						keymap[playerSetting].hat=(keymap[playerSetting].hat -2)  % j:getHatCount() + 1
					end
				else
					keymap[playerSetting].hat="nil"
				end
			end
		end,
		keyboard=false,
		hat=true,
		axis=false},
		{name=function()
			return "vAxis number "..keymap[playerSetting].vAxis
		end,
		right=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				elseif js[j_id]:getAxisCount()~=0 then
					local j=js[j_id]
					if keymap[playerSetting].vAxis=="nil" then
						keymap[playerSetting].vAxis=1
					else
						keymap[playerSetting].vAxis=keymap[playerSetting].vAxis % j:getAxisCount() + 1
					end
				else
					keymap[playerSetting].vAxis="nil"
				end
			end
		end,
		left=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				elseif js[j_id]:getAxisCount()~=0 then
					local j=js[j_id]
					if keymap[playerSetting].vAxis=="nil" then
						keymap[playerSetting].vAxis=1
					else
						keymap[playerSetting].vAxis=(keymap[playerSetting].vAxis -2)  % j:getAxisCount() + 1
					end
				else
					keymap[playerSetting].vAxis="nil"
				end
			end
		end,
		keyboard=false,
		hat=false,
		axis=true},
--		{name=function()
--			return "vAxisDirection : "..keymap[playerSetting].vAxisDirection
--		end,
--		enter=function()
--			keymap[playerSetting].vAxisDirection=-keymap[playerSetting].vAxisDirection
--		end},
		{name=function()
			return "hAxis number "..keymap[playerSetting].hAxis
		end,
		right=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				elseif js[j_id]:getAxisCount()~=0 then
					local j=js[j_id]
					if keymap[playerSetting].hAxis=="nil" then
						keymap[playerSetting].hAxis=1
					else
						keymap[playerSetting].hAxis=keymap[playerSetting].hAxis % j:getAxisCount() + 1
					end
				else
					keymap[playerSetting].hAxis="nil"
				end
			end
		end,
		left=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				elseif js[j_id]:getAxisCount()~=0 then
					local j=js[j_id]
					if keymap[playerSetting].hAxis=="nil" then
						keymap[playerSetting].hAxis=1
					else
						keymap[playerSetting].hAxis=(keymap[playerSetting].hAxis -2)  % j:getAxisCount() + 1
					end
				else
					keymap[playerSetting].hAxis="nil"
				end
			end
		end,
		keyboard=false,
		hat=false,
		axis=true},
--		{name=function()
--			return "hAxisDirection : "..keymap[playerSetting].hAxisDirection
--		end,
--		enter=function()
--			keymap[playerSetting].hAxisDirection=-keymap[playerSetting].hAxisDirection
--		end},
		{name=function()
			return "walk pad button : "..keymap[playerSetting].button 
		end,
		enter=function()
			if love.joystick.getJoystickCount()==0 then
				keymap[playerSetting].joystick="no joystick"
			else
				local js=love.joystick.getJoysticks()
				local j_id=false
				for i,v in ipairs(js) do
					if v:getName()==keymap[playerSetting].joystick then
						j_id=i
					end
				end
				if not j_id then keymap[playerSetting].joystick=js[1]:getName()
				else
					local j=js[j_id]
					askButton=true
					keymap[playerSetting].button=" new button "
					function changeButton(button)
						keymap[playerSetting].button=button
					end
				end
			end
		end,
		keyboard=false,
		hat=true,
		button=true,
		axis=true},
		{name=function()
			return "return"
		end,
		enter=function()
			buttonPress=1
			currentButton=settingInput
		end,
		button=true,
		keyboard=true,
		hat=true,
		axis=true}
	}

	currentButton=menuButton
	buttonPress=1

--	pattern=" .--..--.\n/ .. \\.. \\\n\\ \\/\\ \\/ /\n \\/ /\\/ /\n / /\\/ /\\\n/ /\\ \\/\\ \\\n\\ \\/\\ \\/ /\n \\/ /\\/ /\n / /\\/ /\\\n/ /\\ \\/\\ \\\n\\ \\/\\ \\/ /\n \\/ /\\/ /\n / /\\/ /\\\n/ /\\ \\/\\ \\\n\\ \\/\\ \\/ /\n \\/ /\\/ /\n / /\\/ /\\\n/ /\\ \\/\\ \\\n\\ \\/\\ \\/ /\n \\/ /\\/ /\n / /\\/ /\\\n/ /\\ \\/\\ \\\n\\ `'\\ `' /\n `--'`--'\n"
	local f=love.graphics.getFont()
	f:setFilter("linear","linear",8)
	
end
	


--Disable
function menuState:disable()
	titletheme:stop()
	menuButton=nil
	buttonPress=nil
	settingButton=nil
end

--Update
function menuState:update(dt)
end

--Draw
function menuState:draw()
	love.graphics.printf("Ligo",love.window.getWidth()/2,love.window.getHeight()/4,0,"center",0,10,9)
	--love.graphics.print(pattern,love.window.getWidth()/2,love.window.getHeight()/4)
	local b=""
	local p=""

	if currentButton==playerInput then
	local joysticks=love.joystick.getJoysticks()
	for _,j in ipairs(joysticks) do
		p=p.."joystick : "..j:getName().."\n"
		p=p..j:getAxisCount().." axis : \n"
		for a=1,j:getAxisCount() do
			p=p.." * "..j:getAxis(a).."\n"
		end
		p=p..j:getHatCount().." hat : \n"
		for a=1,j:getHatCount() do
			p=p.." * "..j:getHat(a).."\n"
		end
		p=p.."button down : \n"
		for i=1,100 do
			if j:isDown(i) then
				p=p.." * "..i.."\n"
			end
		end
		p=p.."\n\n"
	end
	end

	for i,v in ipairs(currentButton) do
		local mes=v.name()
		if currentButton==playerInput and not v[keymap[playerSetting].type] then
			mes="( "..mes.." )"
		end
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
	love.graphics.printf(p,love.window.getWidth()/3,love.window.getHeight()/4,150,"left",0,1,1,75,0)
--	love.graphics.printf(pattern,love.window.getWidth()/8,love.window.getHeight()/15,150,"center",0,3,2,75,0)
--	love.graphics.printf(pattern,love.window.getWidth()*7/8,love.window.getHeight()/15,150,"center",0,3,2,75,0)
end

--KeyPressed
function menuState:keypressed(key, unicode)
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

function menuState:joystickpressed(joystick, button)
	if askButton then
		changeButton(button)
		askButton=false
	end
end

--KeyRelease
function menuState:keyrelease(key, unicode)
end

--MousePressed
function menuState:mousepressed(x, y, button)
end

--MouseReleased
function menuState:mousereleased(x, y, button)
end
