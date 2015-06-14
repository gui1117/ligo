require "object.character"

arrow={}
arrow.nbr=0

function create.arrow(world,x,y,gid,a)
	local na={name="arrow"}
	arrow.nbr=arrow.nbr+1
	na.nbr=arrow.nbr

	na.sound=gid.sound or "arrow"
	if not sound[na.sound.."-destroy"] then
		sound[na.sound.."-destroy"]={cursor=1}
		for i=1,20 do
			table.insert(sound[na.sound.."-destroy"],initsource(love.audio.newSource(contentFile("sound/"..na.sound.."-destroy.ogg"),"static")))
		end
	end

	na.shape=gid.shape or "circle"
	na.radius=tonumber(gid.radius) or 0.25
	na.height=tonumber(gid.height) or 0.3
	na.width=tonumber(gid.width) or 0.1
	na.velocity=(tonumber(gid.velocity) or 1)*character.velocity
	na.velocityTime=tonumber(gid.velocityTime) or 1  -- for guided
	na.density=tonumber(gid.density) or 1
	na.timeToDie=(tonumber(gid.time) or (tonumber(gid.distance) or 30)/na.velocity )+ love.timer.getTime()
	na.damage=tonumber(gid.damage) or 1
	a=a or 0
	na.guided=(gid.guided=="true")

	if na.shape=="circle" then
		na.body=love.physics.newBody(world, x+math.cos(a)*(na.radius), y+math.sin(a)*(na.radius), "dynamic")
		na.shape=love.physics.newCircleShape(na.radius)
	elseif na.shape=="rectangle" then
		na.body=love.physics.newBody(world, x+math.cos(a)*(na.height/2), y+math.sin(a)*(na.height/2), "dynamic")
		na.shape=love.physics.newRectangleShape(na.height,nas.width)
	end
	na.body:setAngle(a)
	na.body:setBullet(true)
	na.fixture=love.physics.newFixture(na.body,na.shape,na.density)
	na.fixture:setUserData(na)
	setGroup(na.fixture,"bullet")

	na.beginContact={}
	local time=love.timer.getTime()
	function na.kill()
		local s=sound[na.sound.."-destroy"]
		s[s.cursor]:setPosition(na.body:getX(),na.body:getY())
		if closeSound(s[s.cursor]) then
			s[s.cursor]:play()
			s.cursor=s.cursor % table.getn(s) +1
		end
		local x=na.body:getX()
		local y=na.body:getY()
		if camera.isVisible(x,y) then
			x,y=toRender(x,y)
			local o=na.body:getAngle()
			tileset:addEffect( 20, gid.animation[2].tileid, x, y, o, 1, 1, toRender(1/2,1/2))
		end
		na.body:destroy()
		object[na.name..na.nbr]=nil
	end

	local guided
	if na.guided then
		na.linearDamping=-math.log(0.05)/na.velocityTime
		na.moveForce=na.linearDamping*na.velocity*na.body:getMass()
		na.body:setLinearDamping(na.linearDamping)

		guided=function()
			local oa=na.body:getAngle()
			local xa,ya=na.body:getPosition()
			local i=character.closer(xa,ya)
			if i then
				local xc,yc=character[i].body:getPosition()
				oa=angleOfVector(xa,ya,xc,yc)
			else
			end
			na.body:applyForce(na.moveForce*math.cos(oa),na.moveForce*math.sin(oa))
		end
	else
		guided=function()
		end
	end

	na.update=function()
		if love.timer.getTime() > na.timeToDie then
			na.kill()
			return
		end
		for _,v in ipairs(na.beginContact) do
			if v.other and v.other.makeDamage then
				v.other.makeDamage(na.damage)
			end
			na.kill()
			return
		end
		guided()
	end

	na.draw=function()
		local x=na.body:getX()
		local y=na.body:getY()
		if camera.isVisible(x,y) then
			x,y=toRender(x,y)
			local o=na.body:getAngle()
			tileset:add( 20, gid.animation[1].tileid, x, y, o, 1, 1, toRender(1/2,1/2))
		end
	end

	na.body:setLinearVelocity(na.velocity*math.cos(a),na.velocity*math.sin(a))

	object[na.name..na.nbr]=na
end
