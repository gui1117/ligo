require "object.character"
require "tool.function"

pike={}
pike.nbr=0
pike.timeToDeclench=(2*character.radius+1)/character.velocity*timeCoef
pike.timeUp=pike.timeToDeclench

function create.pike(world,x,y,gid)
	local np={}
	pike.nbr=pike.nbr+1
	np.nbr=pike.nbr
	np.name="pike"

	np.sound=gid.sound or "pike"
	if not sound[np.sound.."-declench"] then
		sound[np.sound.."-declench"]={cursor=1}
	end
	for i=1,5 do
		table.insert(sound[np.sound.."-declench"],initsource(love.audio.newSource("sound/"..np.sound.."-declench.ogg","static")))
	end

	if not sound[np.sound.."-up"] then
		sound[np.sound.."-up"]={cursor=1}
	end
	for i=1,5 do
		table.insert(sound[np.sound.."-up"],initsource(love.audio.newSource("sound/"..np.sound.."-up.ogg","static")))
	end

	np.body=love.physics.newBody(world,x-1/2,y-1/2,"kinematic")
	np.shape=love.physics.newRectangleShape(1,1)
	np.fixture=love.physics.newFixture(np.body,np.shape)
	np.fixture:setUserData(np)
	setGroup(np.fixture,"floor")

	np.declenche=false
	np.up=false
	np.time=0
	np.beginContact={}

	function np.update()
		for _,v in ipairs(np.beginContact) do
			if not np.up then
				local s=sound[np.sound.."-declench"]
				s[s.cursor]:setPosition(np.body:getX(),np.body:getY())
				s[s.cursor]:play()
				s.cursor=s.cursor % table.getn(s) +1

				np.declench=love.timer.getTime() + pike.timeToDeclench
			end
		end
		np.beginContact={}
		if np.declench then
			if love.timer.getTime() > np.declench then
				local s=sound[np.sound.."-up"]
				s[s.cursor]:setPosition(np.body:getX(),np.body:getY())
				s[s.cursor]:play()
				s.cursor=s.cursor % table.getn(s) +1

				np.up=love.timer.getTime() + pike.timeUp
				np.declench=false
				create.pikedamage(world,x,y,np)
			end
		end
	end
	local xr,yr=toRender(x-1/2,y-1/2)
	function np.draw()
		if camera.isVisible(x-1/2,y-1/2) then
			tileset:add(14,gid.animation[1].tileid,xr,yr,0,1,1,toRender(1/2,1/2))
		end
	end
	np.tilepikeup=gid.animation[2].tileid
	object[np.name..np.nbr]=np
end

function create.pikedamage(world,x,y,np)
	local npd={}
	npd.nbr=np.nbr
	npd.name="picdamage"

	npd.body=love.physics.newBody(world,x-1/2,y-1/2,"kinematic")
	npd.shape=love.physics.newRectangleShape(1,1)
	npd.fixture=love.physics.newFixture(npd.body,npd.shape)
	npd.fixture:setUserData(npd)
	setGroup(npd.fixture,"floor")

	npd.beginContact={}

	npd.time=0
	function npd.update()
		for _,v in ipairs(npd.beginContact) do
			if v.other.makeDamage then
				v.other.makeDamage(1)
			end
		end
		npd.beginContact={}
		if love.timer.getTime() > np.up then
			npd.body:destroy()
			object[npd.name..npd.nbr]=nil
			npd=nil
			np.up=false
		end
	end

	local xr,yr=toRender(x-1/2,y-1/2)
	function npd.draw()
		if camera.isVisible(x-1/2,y-1/2) then
			tileset:add(15,np.tilepikeup,xr,yr,0,1,1,toRender(1/2,1/2))
		end
	end

	object[npd.name..np.nbr]=npd
end
