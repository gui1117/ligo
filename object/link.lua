require "tool.function"

link={}
link.nbr=0

function create.link(world,x,y,gid)
	local nl={name="link"}
	link.nbr=link.nbr+1
	nl.nbr=link.nbr

	if not sound["link-damage"] then
		sound["link-damage"]={cursor=1}
	end
	for i=1,5 do
		table.insert(sound["link-damage"],initsource(love.audio.newSource(contentFile("sound/link-damage.ogg"),"static")))
	end

	if not sound["link-destroyed"] then
		sound["link-destroyed"]={cursor=1}
	end
	table.insert(sound["link-destroyed"],initsource(love.audio.newSource(contentFile("sound/link-destroyed.ogg"),"static")))

	if not sound["link-elongate"] then
		sound["link-elongate"]={cursor=1}
	end
	for i=1,5 do
		table.insert(sound["link-elongate"],initsource(love.audio.newSource(contentFile("sound/link-elongate.ogg"),"static")))
	end

	if not sound["link-retract"] then
		sound["link-retract"]={cursor=1}
	end
	for i=1,5 do
		table.insert(sound["link-retract"],initsource(love.audio.newSource(contentFile("sound/link-retract.ogg"),"static")))
	end

	nl.anchor={}
	nl.force=1000
	nl.anchor[1]=tonumber(gid.anchor1) or 1
	nl.anchor[2]=tonumber(gid.anchor2) or 2
	local a1,a2=nl.anchor[1],nl.anchor[2]
	nl.distance=0
	nl.maxNodeDistance=1.5
	nl.minNodeDistance=0.6
	nl.linearDamping=5
	nl.radius=0.25
	nl.width=1.6
	nl.height=0.2
	nl.density=0
	nl.hot=3 --  >=1
	nl.damage=1
	--nl.gap

	nl.state="init"
	local newnode=function(x,y)
		local s=sound["link-elongate"]
		s[s.cursor]:setPosition(x,y)
		s[s.cursor]:play()
		s.cursor=s.cursor % table.getn(s) +1

		local nn={}
		nn.body=love.physics.newBody(world,x,y,"dynamic")
		nn.body:setBullet(true)
		nn.body:setLinearDamping(nl.linearDamping)
		nn.shape=love.physics.newRectangleShape(nl.width,nl.height)
		nn.fixture=love.physics.newFixture(nn.body,nn.shape,nl.density)
		nn.fixture:setUserData(nn)
		nn.beginContact={}
		setGroup(nn.fixture,"link")
		nn.hot=false
		return nn
	end
	local destroyNode=function(n)
		local s=sound["link-retract"]
		s[s.cursor]:setPosition(n.body:getX(),n.body:getY())
		s[s.cursor]:play()
		s.cursor=s.cursor % table.getn(s) +1

		n.body:destroy()
		n=nil
	end

	nl.unlink=function()
		local s=sound["link-destroyed"]
		s[s.cursor]:setPosition(love.audio.getPosition())
		s[s.cursor]:play()
		s.cursor=s.cursor % table.getn(s) +1

		for i,v in ipairs(nl.node) do
			destroyNode(v)
		end
		nl.node={}
		nl.state="nothing"
	end
	nl.link=function()
		if nl.state~="nothing" then
			nl.unlink()
		end
		nl.state="init"
	end
	
	nl.node={}
	nl.update=function()
		for _,n in ipairs(nl.node) do
			if n.hot then
				for _,v in ipairs(n.beginContact) do
					if v.other.makeDamage then
						local x,y=love.audio.getPosition()
						local s=sound["link-damage"]
						s[s.cursor]:setPosition(x,y)
						s[s.cursor]:play()
						s.cursor=s.cursor % table.getn(s) +1

						v.other.makeDamage(nl.damage)
					end
				end
				n.beginContact={}
			end
		end

			
		if nl.state=="nothing" then
		elseif nl.state=="init" then
			character[nl.anchor[1]].linkedWith[nl.anchor[2]]=nl
			character[nl.anchor[2]].linkedWith[nl.anchor[1]]=nl
			local o=angleOfVector(character[a1].body:getX(),character[a1].body:getY(),character[a2].body:getX(),character[a2].body:getY())
			nl.node[1]=newnode(character[a1].body:getX()+nl.distance*math.cos(o),character[a1].body:getY()+nl.distance*math.sin(o))
			nl.node[2]=newnode(character[a2].body:getX()-nl.distance*math.cos(o),character[a2].body:getY()-nl.distance*math.sin(o))
			nl.state="update"
		elseif nl.state=="update" then
			--first node
			local cursor=1
			while cursor==1 do
				local xi,yi=nl.node[1].body:getPosition()
				local xip1,yip1=nl.node[2].body:getPosition()
				local ni=norme(xip1-xi,yip1-yi)
				if ni>nl.maxNodeDistance then
					local nnode=newnode((xi+xip1)/2,(yi+yip1)/2)
					table.insert(nl.node,2,nnode)
				elseif ni<nl.minNodeDistance then
					if table.getn(nl.node)~=2 then
						destroyNode(nl.node[2])
						table.remove(nl.node,2)
					else
						local o=angleOfVector(character[a1].body:getX(),character[a1].body:getY(),nl.node[2].body:getX(),nl.node[2].body:getY())
						nl.node[1].body:setPosition(character[a1].body:getX()+nl.distance*math.cos(o),character[a1].body:getY()+nl.distance*math.sin(o))
						cursor=cursor+1
					end
				else
					local o=angleOfVector(character[a1].body:getX(),character[a1].body:getY(),nl.node[2].body:getX(),nl.node[2].body:getY())
					nl.node[1].body:setPosition(character[a1].body:getX()+nl.distance*math.cos(o),character[a1].body:getY()+nl.distance*math.sin(o))
					nl.node[1].body:setAngle(o)
					cursor=cursor+1
				end
			end
			--intern node
			while cursor<table.getn(nl.node) do
				if cursor <= nl.hot or cursor >= table.getn(nl.node)-nl.hot+1 then
					if nl.node[cursor].hot then
						setGroup(nl.node[cursor].fixture,"link")
						nl.node[cursor].hot=false
					end
				else
					if not nl.node[cursor].hot then
						setGroup(nl.node[cursor].fixture,"hotlink")
						nl.node[cursor].hot=true
					end
				end
				local xi,yi=nl.node[cursor].body:getPosition()
				local xip1,yip1=nl.node[cursor+1].body:getPosition()
				local ni=norme(xip1-xi,yip1-yi)
				if ni>nl.maxNodeDistance then
					local nnode=newnode((xi+xip1)/2,(yi+yip1)/2)
					table.insert(nl.node,cursor+1,nnode)
				elseif ni<nl.minNodeDistance then
					destroyNode(nl.node[cursor+1])
					table.remove(nl.node,cursor+1)
				else
					local p=nl.node
					local xip1,yip1=p[cursor+1].body:getPosition()
					local xi,yi=p[cursor].body:getPosition()
					local xim1,yim1=p[cursor-1].body:getPosition()
					local x=(xip1-xi)+(xim1-xi)
					local y=(yip1-yi)+(yim1-yi)
					p[cursor].body:applyForce(x*nl.force,y*nl.force)
					local o=angleOfVector(xip1,yip1,xim1,yim1)
					p[cursor].body:setAngle(o)
					cursor=cursor+1
				end
			end
			--last node
			local n=table.getn(nl.node)
			local o=angleOfVector(character[a2].body:getX(),character[a2].body:getY(),nl.node[n-1].body:getX(),nl.node[n-1].body:getY())
			nl.node[n].body:setPosition(character[a2].body:getX()+nl.distance*math.cos(o),character[a2].body:getY()+nl.distance*math.sin(o))
			nl.node[n].body:setAngle(o)
		end
	end

	nl.draw=function()
		for i,v in ipairs(nl.node) do
			local x=v.body:getX()
			local y=v.body:getY()
			if camera.isVisible(x,y) then
				x,y=toRender(x,y)
				local o=v.body:getAngle()
				if v.hot then
					tileset:add( 20, gid.animation[1].tileid, x, y, o, 1, 1, toRender(1/2,1/2))
				else
					tileset:add( 20, gid.animation[2].tileid, x, y, o, 1, 1, toRender(1/2,1/2))
				end
			end
		end
	end

	object[nl.name..nl.nbr]=nl
end
