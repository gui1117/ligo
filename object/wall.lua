require "lib.tiolved"

wall={}
wall.nbr=0
wall.destroy=function()
	wall.nbr=0
end

function create.wall(world,x,y,gid)
	local ntw = {}
	ntw.name="wall"
	wall.nbr=wall.nbr+1
	ntw.nbr=wall.nbr
	ntw.body = love.physics.newBody(world, x-1/2,y-1/2, "static")
	ntw.shape = love.physics.newRectangleShape(1,1)
	ntw.fixture = love.physics.newFixture(ntw.body, ntw.shape)
	ntw.fixture:setUserData(ntw)
	setGroup(ntw.fixture,"wall")
	local xr,yr=toRender(x-1/2,y-1/2)
	ntw.draw=function()
		if camera.isVisible(x-1/2,y-1/2) then
		tileset:add(40,gid.id,xr,yr,0,1,1,toRender(1/2,1/2))
		end
	end
	ntw.collision=function(pmap)
		local x,y=ntw.body:getPosition()
		local x=math.ceil(x)
		local y=math.ceil(y)
		pmap[y][x]=1
	end
	object[ntw.name..ntw.nbr]=ntw
end
