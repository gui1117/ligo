require "object.character"
require "tool.function"

-- run to the character and explode at his contact
redmonster={ 
	nbr=0,
}

function create.redmonster(world,x,y,gid)
	local nrm={}
	redmonster.nbr=redmonster.nbr+1
	nrm.nbr=redmonster.nbr
	nrm.name="redmonster"

	nrm.sound=gid.sound or "redmonster"
	if not sound[nrm.sound.."-run"] then
		sound[nrm.sound.."-run"]={cursor=1}
	end
	local tmp=initsource(love.audio.newSource("sound/"..nrm.sound.."-run.ogg","static"))
	tmp:setLooping("true")
	sound[nrm.sound.."-run"][nrm.nbr]=tmp

	if not sound[nrm.sound.."-die"] then
		sound[nrm.sound.."-die"]={cursor=1}
		for i=1,5 do
			table.insert(sound[nrm.sound.."-die"],initsource(love.audio.newSource("sound/"..nrm.sound.."-die.ogg","static")))
		end
	end

	if not sound[nrm.sound.."-damage"] then
		sound[nrm.sound.."-damage"]={cursor=1}
		for i=1,5 do
			table.insert(sound[nrm.sound.."-damage"],initsource(love.audio.newSource("sound/"..nrm.sound.."-damage.ogg","static")))
		end
	end

	initRedmonsterCarac(nrm,world,x,y,gid)
	initRedmonsterPhysic(nrm,world,x,y,gid)
	initRedmonsterUpdate(nrm,world,x,y,gid)
	initRedmonsterDraw(nrm,world,x,y,gid)
	object[nrm.name..nrm.nbr]=nrm
end

function initRedmonsterCarac(nrm,world,x,y,gid)
	nrm.velocity=(tonumber(gid.velocity) or 1)*character.velocity
	nrm.velocityTime=tonumber(gid.velocityTime) or 0.0001
	nrm.shape=gid.shape or "rectangle"
	nrm.density=tonumber(gid.density) or 1
	if nrm.shape=="rectangle" then
		nrm.height=tonumber(gid.shape) or 1
		nrm.width=tonumber(gid.width) or 1
		nrm.mass=nrm.height*nrm.width*nrm.density
	elseif nrm.shape=="circle" then
		nrm.radius=tonumber(gid.radius) or 0.5
		nrm.mass=math.pow(nrm.radius,2)*math.pi*nrm.density
	end
	nrm.damage=tonumber(gid.damage) or 1	
	nrm.searchTime=(tonumber(gid.searchTime) or 1)*timeCoef
	nrm.distance=tonumber(gid.distance) or 50
end

function initRedmonsterPhysic(nrm,world,x,y,gid)
	local linearDamping=-math.log(0.05)/nrm.velocityTime
	nrm.moveForce=linearDamping*nrm.velocity*nrm.mass

	nrm.body=love.physics.newBody(world,x-1/2,y-1/2,"dynamic")
	nrm.body:setLinearDamping(linearDamping)
	if nrm.shape=="circle" then
		nrm.shape=love.physics.newCircleShape(nrm.radius)
	elseif nrm.shape=="rectangle" then
		nrm.shape=love.physics.newRectangleShape(nrm.height,nrm.width)
	end
	nrm.fixture=love.physics.newFixture(nrm.body,nrm.shape,nrm.density)
	nrm.fixture:setUserData(nrm)
	setGroup(nrm.fixture,"ramping")
end

function initRedmonsterUpdate(nrm,world,x,y,gid)
	nrm.state="waiting"
	nrm.beginContact={}
	function nrm.update()
		for _,v in ipairs(nrm.beginContact) do
			if v.other and v.other.makeDamage and v.other.name ~= nrm.name then
				local s=sound[nrm.sound.."-damage"]
				s[s.cursor]:setPosition(nrm.body:getX(),nrm.body:getY())
				s[s.cursor]:play()
				s.cursor=s.cursor % table.getn(s) +1

				v.other.makeDamage(nrm.damage)
				nrm.kill()
				return
			end
		end
		nrm.beginContact={}

		local x1,y1=nrm.body:getPosition()
		x1=math.ceil(x1)
		y1=math.ceil(y1)
		local normMin=nrm.distance*10
		local x2min,y2min=0,0
		for i,v in ipairs(character) do
			if not v.killed then
				local x2,y2=v.body:getPosition()
				local normTmp=norme(x1-x2,y1-y2)
				if normTmp<normMin then
					x2min=x2
					y2min=y2
					normMin=normTmp
				end
			end
		end
		x2=math.ceil(x2min)
		y2=math.ceil(y2min)
		if nrm.state=="waiting" then
			if normMin<nrm.distance then 
				sound[nrm.sound.."-run"][nrm.nbr]:play()
				nrm.state="searching"
			end
		elseif nrm.state=="hunting" then
			sound[nrm.sound.."-run"][nrm.nbr]:setPosition(nrm.body:getPosition())
			if nrm.currentnode then 
				local a=angleOfVector(nrm.body:getX(),nrm.body:getY(),nrm.currentnode.x-1/2,nrm.currentnode.y-1/2)
				nrm.body:setAngle(a)
				local force=nrm.moveForce
				nrm.body:applyForce(force*math.cos(a),force*math.sin(a))
			end
			if nrm.nextnode then
				if norme(nrm.currentnode.x-nrm.body:getX(),nrm.currentnode.y-nrm.body:getY())<1 then
					nrm.currentnode=nrm.nextnode
					nrm.nextnode=nrm.nodes()
				end
			else
				nrm.currentnode={x=x2min,y=y2min}
			end
			if love.timer.getTime() > nrm.timeToSearch then
				nrm.time=0
				nrm.state="searching"
			end
		elseif nrm.state=="searching" then
			local path=pathfinder:getPath(x1,y1,x2,y2)
			if path then
				nrm.state="hunting"
				nrm.timeToSearch=love.timer.getTime()+nrm.searchTime
				nrm.nodes=path:nodes()
				nrm.nodes()
				nrm.currentnode=nrm.nodes()
				nrm.nextnode=nrm.nodes()
			else
				nrm.state="waiting"
				sound[nrm.sound.."-run"][nrm.nbr]:stop()
			end
		end
	end
	function nrm.makeDamage(num)
		if nrm then
			nrm.kill()
		end
	end
	function nrm.kill()
		sound[nrm.sound.."-run"][nrm.nbr]:stop()
		local s=sound[nrm.sound.."-die"]
		s[s.cursor]:setPosition(nrm.body:getX(),nrm.body:getY())
		s[s.cursor]:play()
		s.cursor=s.cursor % table.getn(s) +1

		nrm.body:destroy()
		object[nrm.name..nrm.nbr]=nil
		nrm=nil
	end
end

function initRedmonsterDraw(nrm,world,x,y,gid)
	nrm.draw=function ()
		local x=nrm.body:getX()
		local y=nrm.body:getY()
		if camera.isVisible(x,y) then
			local x,y=toRender( x,y)
			local o=nrm.body:getAngle()
			if norme(nrm.body:getLinearVelocity())<nrm.velocity*0.05 then
				tileset:add( 30, gid.animation[1].tileid, x, y, o, 1, 1, toRender(1/2,1/2))
			else
				tileset:add( 30, gid.animation[2].tileid, x, y, o, 1, 1, toRender(1/2,1/2))
			end
		end
	end
end
