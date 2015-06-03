require "object.character"
require "tool.function"
require "lib.tiolved"

generator={}
generator.nbr=0
generator.arrow={}
generator.arrow.nbr=0

function create.generator(world, x, y, gid, mapgid)
	local ng={} 
	generator.nbr=generator.nbr+1
	ng.nbr=generator.nbr
	ng.name="generator"

	ng.sound=gid.sound or "generator"
	if not sound[ng.sound.."-spawn"] then
		sound[ng.sound.."-spawn"]={cursor=1}
		for i=1,20 do
			table.insert(sound[ng.sound.."-spawn"],initsource(love.audio.newSource(contentFile("sound/"..ng.sound.."-spawn.ogg"),"static")))
		end
	end
	if not sound[ng.sound.."-prespawn"] then
		sound[ng.sound.."-prespawn"]={cursor=1}
		for i=1,20 do
			table.insert(sound[ng.sound.."-prespawn"],initsource(love.audio.newSource(contentFile("sound/"..ng.sound.."-prespawn.ogg"),"static")))
		end
	end

	initGeneratorCarac(ng,world,x,y,gid,mapgid)
	initGeneratorPhysic(ng,world,x,y,gid,mapgid)
	initGeneratorUpdate(ng,world,x,y,gid,mapgid)
	initGeneratorDraw(ng,world,x,y,gid,mapgid)

	object[ng.name..ng.nbr]=ng
end

function initGeneratorCarac(ng,world,x,y,gid,mapgid)
	ng.prespawnCoef=tonumber(gid.prespawn) or 0.75
	ng.rate=(tonumber(gid.rate) or 4)*timeCoef
	ng.timeToPrespawn=love.timer.getTime() + ng.rate*ng.prespawnCoef - (tonumber(gid.newtime) or 0)
	ng.spawn={}
	ng.salvo=tonumber(gid.spawn) or 4
	local nbr
	if ng.salvo < 4 then
		nbr=4
	elseif ng.salvo < 8 then
		nbr=8
	else 
		nbr=12
	end
	if nbr==4 or nbr==8 or nbr==12 then
		table.insert(ng.spawn,{x=-1,y=0})
		table.insert(ng.spawn,{x=1,y=0})
		table.insert(ng.spawn,{x=0,y=1})
		table.insert(ng.spawn,{x=0,y=-1})
	end
	if nbr==8 or nbr==12 then
		table.insert(ng.spawn,{x=1,y=1})
		table.insert(ng.spawn,{x=-1,y=1})
		table.insert(ng.spawn,{x=1,y=-1})
		table.insert(ng.spawn,{x=-1,y=-1})
	end
	if nbr==12 then
		table.insert(ng.spawn,{x=2,y=0})
		table.insert(ng.spawn,{x=-2,y=0})
		table.insert(ng.spawn,{x=0,y=-2})
		table.insert(ng.spawn,{x=0,y=2})
	end
	ng.monstergid=mapgid[gid.animation[3].tileid]
	ng.distance=tonumber(gid.distance) or 22
end

function initGeneratorPhysic(ng,world,x,y,gid,mapgid)
	ng.body=love.physics.newBody(world,x-1/2,y-1/2,"static")
	ng.shape=love.physics.newRectangleShape(1,1)
	ng.fixture=love.physics.newFixture(ng.body,ng.shape)
	setGroup(ng.fixture,"wall")
	ng.fixture:setUserData(ng)
	ng.collision=function(pmap)
		local x,y=ng.body:getPosition()
		local x=math.ceil(x)
		local y=math.ceil(y)
		pmap[y][x]=1
	end
end

function initGeneratorUpdate(ng,world,x,y,gid,mapgid)
	ng.state="wait"
	function ng.update ()
		ng.beginContact={}
		local cx,cy=camera.cx,camera.cy
		if norme(x-1/2-cx,y-1/2-cy)<ng.distance then
			if ng.state=="wait" then
				if love.timer.getTime() > ng.timeToPrespawn then
					ng.timeToSpawn=love.timer.getTime()+(1-ng.prespawnCoef)*ng.rate
					ng.state="prespawn"
					local s=sound[ng.sound.."-prespawn"]
					s[s.cursor]:setPosition(ng.body:getX(),ng.body:getY())
					s[s.cursor]:play()
					s.cursor=s.cursor % table.getn(s) +1

				end
			elseif ng.state=="prespawn" then
				if love.timer.getTime() > ng.timeToSpawn then
					ng.timeToPrespawn=love.timer.getTime()+ng.prespawnCoef*ng.rate
					ng.state="wait"
					local s=sound[ng.sound.."-spawn"]
					s[s.cursor]:setPosition(ng.body:getX(),ng.body:getY())
					s[s.cursor]:play()
					s.cursor=s.cursor % table.getn(s) +1

					local spawn={}
					for _,v in ipairs(ng.spawn) do
						table.insert(spawn,v)
					end
					for i=ng.salvo,1,-1 do
						local j=math.random(1,table.getn(spawn))
						create[ng.monstergid.name](world,x-1/2+spawn[j].x,y-1/2+spawn[j].y,ng.monstergid)
						table.remove(spawn,j)
					end
				end
			end
		end
	end
end

function initGeneratorDraw(ng,world,x,y,gid,mapgid)
	local xr,yr=toRender(x-1/2,y-1/2)
	function ng.draw ()
		local nbr
		if ng.state=="wait" then
			nbr=1
		else
			nbr=2
		end
		tileset:add(40,gid.animation[nbr].tileid,xr,yr,ng.body:getAngle(),1,1,toRender(1/2,1/2))
	end
end
