require "object.character"
require "object.camera"

function create.interface(world,x,y,gid)
	local int = {}
	int.name="interface"
	local x,y = toRender(1/2,1/2)
	local dx = 2*x
	local dy=2*y
	int.draw=function()
		if character[1] then
			local compt=0
			while compt<character[1].life do
				tileset:add(100,gid.animation[1].tileid,camera._x+x+compt*dx,camera._y+y)
				compt=compt+1
			end
		end
		if character[2] then
			local compt=0
			while compt<character[2].life do
				tileset:add(100,gid.animation[1].tileid,camera._x+love.window.getWidth()*camera.scaleX-x-character[2].life*dx+compt*dx,camera._y+y)
				compt=compt+1
			end
		end
	end

	object[int.name]=int
end
