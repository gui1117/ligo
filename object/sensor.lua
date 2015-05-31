fin={}
fin.nbr=0
fin.activated=0

function create.fin (world,x,y,gid) 
	local nf = {}
	nf.name="fin"
	fin.nbr=fin.nbr+1
	nf.nbr=fin.nbr

	nf.beginContact={}
	nf.endContact={}
	nf.activated=0
	nf.body=love.physics.newBody(world,x-1/2,y-1/2,"static")
	nf.shape=love.physics.newRectangleShape(0.7,0.7)
	nf.fixture=love.physics.newFixture(nf.body,nf.shape)
	nf.fixture:setUserData(nf)
	setGroup(nf.fixture,"floor")
	nf.update=function()
		for _,v in ipairs(nf.beginContact) do
			if v.other.name == "character" then
				nf.activated=nf.activated+1
			end
		end
		nf.beginContact={}
		for _,v in ipairs(nf.endContact) do
			if v.other.name == "character" then
				nf.activated=nf.activated-1
			end
		end
		nf.endContact={}
		if nf.activated==table.getn(character) then
			endmap=true
		end
	end
	local xr,yr=toRender(x-1/2,y-1/2)
	nf.draw=function()
		if camera.isVisible(x-1/2,y-1/2) then
			if nf.activated > 0 then
				tileset:add(10,gid.animation[2].tileid,xr,yr,0,1,1,toRender(1/2,1/2))
			else
				tileset:add(10,gid.animation[1].tileid,xr,yr,0,1,1,toRender(1/2,1/2))
			end
		end
	end
	object[nf.name..nf.nbr]=nf
end
