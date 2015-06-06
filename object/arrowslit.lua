require "object.character"
require "tool.function"
require "lib.tiolved"

arrowslit={}
arrowslit.nbr=0

function create.arrowslit(world, x, y, gid, mapgid)
	local nas={} 
	arrowslit.nbr=arrowslit.nbr+1
	nas.nbr=arrowslit.nbr
	nas.name="arrowslit"

	nas.sound=gid.sound or "arrowslit"
	if not sound[nas.sound.."-shoot"] then
		sound[nas.sound.."-shoot"]={cursor=1}
		for i=1,20 do
			table.insert(sound[nas.sound.."-shoot"],initsource(love.audio.newSource(contentFile("sound/"..nas.sound.."-shoot.ogg"),"static")))
		end
	end

	--init carac :
	nas.rate=(tonumber(gid.rate) or 1)*timeCoef
	nas.aim=(gid.aim or "false")=="true"
	nas.angularVelocity=(tonumber(gid.angularVelocity) or 0)*math.pi/180
	nas.shape=tonumber(gid.shape) or "circle"
	if nas.shape=="circle" then
		nas.radius=tonumber(gid.radius) or 0.5
		nas.distance=nas.radius*1.1
	elseif nas.shape=="rectangle" then
		nas.height=tonumber(gid.height) or 1
		nas.width=tonumber(gid.width) or 1
		nas.distance=math.max(nas.height,nas.width)
	end
	nas.timeToShoot=nas.rate - (tonumber(gid.initTime) or 0 ) + love.timer.getTime()
	for k,v in pairs(gid) do
		if string.find(k,"angle.*")==1 then
			table.insert(nas,{angle=tonumber(v)*math.pi/180})
		end
	end
	nas.bulletgid=mapgid[gid.animation[2].tileid]

	-- init physic
	local bodytype
	if nas.angularVelocity==0 or nas.aim==false then
		bodytype="static"
	else
		bodytype="dynamic"
	end
	nas.body=love.physics.newBody(world,x-1/2,y-1/2,bodytype)
	nas.body:setAngle(0)
	nas.body:setAngularVelocity(nas.angularVelocity)
	if nas.shape=="circle" then
		nas.shape=love.physics.newCircleShape(nas.radius)
	elseif nas.shape=="rectangle" then
		nas.shape=love.physics.newRectangleShape(nas.height,nas.width)
	end
	nas.fixture=love.physics.newFixture(nas.body,nas.shape)
	setGroup(nas.fixture,"wall")
	nas.collision=function(pmap)
		local x,y=nas.body:getPosition()
		local x=math.ceil(x)
		local y=math.ceil(y)
		pmap[y][x]=1
	end
	nas.fixture:setUserData(nas)

	local aim=function()
	end
	--init update
	if nas.aim then
		aim=function()
			nas.body:setPosition(x-1/2,y-1/2)
			local oa=nas.body:getAngle()
			local noa
			local xa,ya=nas.body:getPosition()
			local i=character.closer(xa,ya)
			if i then
				local xc,yc=character[i].body:getPosition()
				noa=angleOfVector(xa,ya,xc,yc)
			end
			nas.body:setAngle(noa)
		end
	elseif nas.angularvelocity~=0 then
		-- maybe setAngle instead of setAngularVelocity
		local av=nas.angularVelocity
		aim=function()
			nas.body:setAngle(love.timer.getTime()*av)
			nas.body:setPosition(x-1/2,y-1/2)
		end
	end
	function nas.update ()
		aim()
		if love.timer.getTime() > nas.timeToShoot then
			nas.timeToShoot=nas.timeToShoot+nas.rate
			for i,v in ipairs(nas) do
				local a=v.angle+nas.body:getAngle()
				local s=sound[nas.sound.."-shoot"]
				s[s.cursor]:setPosition(nas.body:getX(),nas.body:getY())
				s[s.cursor]:play()
				s.cursor=s.cursor % table.getn(s) +1
				create[nas.bulletgid.name](world,x-1/2+math.cos(a)*nas.distance,y-1/2+math.sin(a)*nas.distance,nas.bulletgid,a)
			end
		end
	end


	--init draw
	local xr,yr=toRender(x-1/2,y-1/2)
	function nas.draw ()
		if camera.isVisible(x-1/2,y-1/2) then
			tileset:add(40,gid.animation[1].tileid,xr,yr,nas.body:getAngle(),1,1,toRender(1/2,1/2))
		end
	end

	object[nas.name..nas.nbr]=nas
end
