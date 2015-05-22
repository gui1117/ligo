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

	ng.shootsound=love.audio.newSource("sound/arrowshoot.ogg","static")
	ng.shootsound:setPosition(x-1/2,y-1/2)

	initGeneratorCarac(ng,world,x,y,gid,mapgid)
	initGeneratorPhysic(ng,world,x,y,gid,mapgid)
	initGeneratorUpdate(ng,world,x,y,gid,mapgid)
	initGeneratorDraw(ng,world,x,y,gid,mapgid)

	object[ng.name..ng.nbr]=ng
end

function initGeneratorCarac(ng,world,x,y,gid,mapgid)
	ng.rate=(tonumber(gid.rate) or 1)*timeCoef
	ng.timeToSpawn=love.timer.getTime() + ng.rate - (tonumber(gid.newtime) or 0)
	ng.spawn={}
	local nbr=tonumber(gid.spawn) or 4
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
	ng.salvo=tonumber(gid.salvo) or 4
	ng.monstergid=mapgid[gid.animation[2].tileid]
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
	function ng.update ()
		ng.beginContact={}
		local cx,cy=camera.cx,camera.cy
		if norme(x-1/2-cx,y-1/2-cy)<ng.distance then
			if love.timer.getTime() > ng.timeToSpawn then
				ng.timeToSpawn=ng.timeToSpawn + ng.rate
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

function initGeneratorDraw(ng,world,x,y,gid,mapgid)
	local xr,yr=toRender(x-1/2,y-1/2)
	function ng.draw ()
		tileset:add(40,gid.animation[1].tileid,xr,yr,ng.body:getAngle(),1,1,toRender(1/2,1/2))
	end
end
