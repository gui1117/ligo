camera = {}
camera._x = 0
camera._y = 0
camera.cx = 0
camera.cy = 0
camera.scaleX = 0.3
camera.scaleY = 0.3
camera.rotation = 0
camera.tileinwidth=100
camera.tileinheight=100
camera.scaleFactor=1

function create.camera(world,x,y,gid)
	camera.scaleX=tonumber(gid.scale) or camera.scaleX
	camera.scaleY=tonumber(gid.scale) or camera.scaleY
end

function camera:set()
	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
	love.graphics.translate(-self._x, -self._y)
end

function camera:unset()
	love.graphics.pop()
end

function camera:move(dx, dy)
	self._x = self._x + (dx or 0)
	self._y = self._y + (dy or 0)
end

function camera:rotate(dr)
	self.rotation = self.rotation + dr
end

function camera:scale(sx, sy)
	sx = sx or 1
	self.scaleX = self.scaleX * sx
	self.scaleY = self.scaleY * (sy or sx)
end

function camera:setX(value)
	self._x = value
end

function camera:setY(value)
	self._y = value
end

function camera:toGlobal(x,y)
	return camera:toGlobalX(x),camera:toGlobalY(y)
end
function camera:toGlobalX(x)
	return x*camera.scaleX+camera._x
end
function camera:toGlobalY(y)
	return y*camera.scaleY+camera._y
end


function camera:setPosition(x, y)
	if x then self:setX(x) end
	if y then self:setY(y) end
end

function camera:setScale(sx, sy)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY
end

function camera:update()
	if love.keyboard.isDown("kp+") then
		camera.scaleFactor=camera.scaleFactor*1.02
	elseif love.keyboard.isDown("kp-") then
		camera.scaleFactor=camera.scaleFactor*0.98
	end
	local w=love.graphics.getWidth()
	local h=love.graphics.getHeight()
	tiolved.setResolution(w,h)
	local m=math.max(w,h)/500*camera.scaleFactor
	camera.scaleX=1/m
	camera.scaleY=1/m
	local n=table.getn(character)
	camera.cx,camera.cy=0,0
	for _,v in ipairs(character) do
		camera.cx=camera.cx+v.body:getX()
		camera.cy=camera.cy+v.body:getY()
	end
	camera.cx=camera.cx/n
	camera.cy=camera.cy/n
	tiolved.setPosition(camera.cx,camera.cy)
	love.audio.setPosition(camera.cx,camera.cy)
	local cx,cy=toRender(camera.cx,camera.cy)
	local wx=love.window.getWidth()*camera.scaleX
	local wy=love.window.getHeight()*camera.scaleY
	tiolved.setResolution(wx,wy)
	camera:setX(cx-wx/2)
	camera:setY(cy-wy/2)
	camera.tileinwidth=wx/tiolved.tileWidth
	camera.tileinheight=wx/tiolved.tileHeight
end

function camera.isVisible(x,y)
	local cx=camera.cx
	local cy=camera.cy
	return (math.abs(cx-x)<camera.tileinwidth) and (math.abs(cy-y)<camera.tileinheight)
end
