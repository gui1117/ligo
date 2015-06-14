fin={}
fin.nbr=0
fin.activated=0

function create.fin (world,x,y,gid) 
	local nf = {}
	nf.name="fin"
	fin.nbr=fin.nbr+1
	nf.nbr=fin.nbr

	nf.sound=gid.sound or "fin"
	if not sound[nf.sound.."-0Activated"] then
		sound[nf.sound.."-0Activated"]={}
	end
	local s=initsource(love.audio.newSource(contentFile("sound/"..nf.sound.."-0Activated.ogg"),"static"))
	s:setPosition(x-1/2,y-1/2)
	sound[nf.sound.."-0Activated"][nf.nbr]=s

	if not sound[nf.sound.."-1Activated"] then
		sound[nf.sound.."-1Activated"]={}
	end
	s=initsource(love.audio.newSource(contentFile("sound/"..nf.sound.."-1Activated.ogg"),"static"))
	s:setPosition(x-1/2,y-1/2)
	s:setLooping(true)
	sound[nf.sound.."-1Activated"][nf.nbr]=s

	if not sound[nf.sound.."-2Activated"] then
		sound[nf.sound.."-2Activated"]={}
	end
	s=initsource(love.audio.newSource(contentFile("sound/"..nf.sound.."-2Activated.ogg"),"static"))
	s:setPosition(x-1/2,y-1/2)
	sound[nf.sound.."-2Activated"][nf.nbr]=s

	nf.beginContact={}
	nf.endContact={}
	nf.activated=0
	nf.body=love.physics.newBody(world,x-1/2,y-1/2,"static")
	nf.shape=love.physics.newRectangleShape(1,1)
	nf.fixture=love.physics.newFixture(nf.body,nf.shape)
	nf.fixture:setUserData(nf)
	setGroup(nf.fixture,"floor")
	nf.activeSound=sound[nf.sound.."-"..nf.activated.."Activated"]
	nf.update=function()
		local s=false
		for _,v in ipairs(nf.beginContact) do
			if v.other.name == "character" then
				sound[nf.sound.."-"..nf.activated.."Activated"][nf.nbr]:stop()
				nf.activated=nf.activated+1
				sound[nf.sound.."-"..nf.activated.."Activated"][nf.nbr]:play()
			end
		end
		nf.beginContact={}
		for _,v in ipairs(nf.endContact) do
			if v.other.name == "character" then
				sound[nf.sound.."-"..nf.activated.."Activated"][nf.nbr]:stop()
				nf.activated=nf.activated-1
				sound[nf.sound.."-"..nf.activated.."Activated"][nf.nbr]:play()
			end
		end
		if s then
			s[s.cursor]:setPosition(nf.body:getX(),nf.body:getY())
			s[s.cursor]:play()
			s.cursor=s.cursor % table.getn(s) +1
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
