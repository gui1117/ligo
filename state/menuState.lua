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
			currentButton=mapButton
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
			return "set input"
		end,
		enter=function()
			buttonPress=1
			currentButton=settingInput
		end},
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
		{name=function() return "save configuration" end,
		enter=function()
			local w,h,f=love.window.getMode()
			local dir=love.filesystem.getSaveDirectory()
			if not love.filesystem.exists(dir) then
				love.filesystem.write("ligo.conf","")
			end
		print(dir)
			persistence.store(dir.."/ligo.conf",keymap,w,h,f)
		end
		},
		{name=function()
			return "return"
		end,
		enter=function()
			buttonPress=1
			currentButton=menuButton
		end}    
		--name=fsaa
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
	mapList={
		current=1,
		{map="map1-1",sound="Ambiance2"},
		{map="map1-2",sound="Ambiance2"},
		{map="map1-3",sound="Ambiance2"},
--		{map="map",sound="Sideways"},
--		{map="map2-1",sound="Ambiance2"},
--		{map="map2-2",sound="Ambiance2"},
--		{map="map3-1",sound="Sideways"},
---		{map="map3-2",sound="Sideways"},
--		{map="map3-3",sound="Sideways"},
		{map="test",sound="Ambiance"}
	}
	mapButton={
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
			return "map : "..mapList[mapList.current].map
		end,
		right=function()
			mapList.current=mapList.current % table.getn(mapList) + 1
		end,
		left=function()
			mapList.current=mapList.current -1
			if mapList.current==0 then
				mapList.current=table.getn(mapList)
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
	manualButton={
		escape=function()
			buttonPress=1
			currentButton=menuButton
		end,
		{name=function()
			local k=keymap
			return k.up..","..k.down..","..k.right..","..k.left.." <-- move\nspace <-- jump\nleft shift <-- walk\nmouse <-- aim\n+/- <-- volume"
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
			else
				keymap[playerSetting].type="keyboard"
			end
		end,
		left=function()
			if keymap[playerSetting].type=="keyboard" then
				keymap[playerSetting].type="axis"
			elseif keymap[playerSetting].type=="hat" then
				keymap[playerSetting].type="keyboard"
			else
				keymap[playerSetting].type="hat"
			end

		end},
		{name=function()
			return "up : "..keymap[playerSetting].up or "nil"
		end,
		enter=function()
			askKey=true
			keymap[playerSetting].up=" new key  "
			function changeKey(key)
				keymap[playerSetting].up=key
			end
		end},
		{name=function()
			return "down : "..keymap[playerSetting].down or "nil"
		end,
		enter=function()
			askKey=true
			keymap[playerSetting].down=" new key  "
			function changeKey(key)
				keymap[playerSetting].down=key
			end
		end},
		{name=function()
			return "left : "..keymap[playerSetting].left
		end,
		enter=function()
			askKey=true
			keymap[playerSetting].left=" new key  "
			function changeKey(key)
				keymap[playerSetting].left=key
			end
		end},
		{name=function()
			return "right : "..keymap[playerSetting].right
		end,
		enter=function()
			askKey=true
			keymap[playerSetting].right=" new key  "
			function changeKey(key)
				keymap[playerSetting].right=key
			end
		end},
		{name=function()
			return "walk : "..keymap[playerSetting].walk
		end,
		enter=function()
			askKey=true
			keymap[playerSetting].walk=" new key  "
			function changeKey(key)
				keymap[playerSetting].walk=key
			end
		end},
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
		end},
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
		end},
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
		end},
		{name=function()
			return "vAxisDirection : "..keymap[playerSetting].vAxisDirection
		end,
		enter=function()
			keymap[playerSetting].vAxisDirection=-keymap[playerSetting].vAxisDirection
		end},
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
		end},
		{name=function()
			return "hAxisDirection : "..keymap[playerSetting].hAxisDirection
		end,
		enter=function()
			keymap[playerSetting].hAxisDirection=-keymap[playerSetting].hAxisDirection
		end},
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
		end},
		{name=function()
			return "return"
		end,
		enter=function()
			buttonPress=1
			currentButton=settingInput
		end}
	}

	currentButton=menuButton
	buttonPress=1
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
	love.graphics.printf("Ligo",love.window.getWidth()/2,love.window.getHeight()/3,0,"center",0,5,5)
	local b=""
	local p=""

	local joysticks=love.joystick.getJoysticks()
	for _,j in ipairs(joysticks) do
		p=p..j:getName().."\n"
		p=p..j:getAxisCount().." axis\n"
		for a=1,j:getAxisCount() do
			p=p..j:getAxis(a).."\n"
		end
		p=p..j:getHatCount().." hat\n"
		for a=1,j:getHatCount() do
			p=p..j:getHat(a).."\n"
		end
		p=p.."button down :\n"
		for i=1,100 do
			if j:isDown(i) then
				p=p..i.."\n"
			end
		end
	end

	for i,v in ipairs(currentButton) do
		if buttonPress==i then
			local len=string.len(v.name())
			b=b.."\n"
			for i=1,len do
				b=b.."="
			end
			b=b.."\n|| "..v.name().." ||\n"
			for i=1,len do
				b=b.."="
			end
		else
			b=b.."\n"..v.name()
		end
	end
	love.graphics.printf(b,love.window.getWidth()/2,love.window.getHeight()/2,250,"center",0,1,1,125,0)
	love.graphics.printf(p,love.window.getWidth()/2.3,love.window.getHeight()/2,250,"left",0,1,1,125,0)
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
