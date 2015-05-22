require "object.character"
require "object.camera"

function create.interface(world,x,y,gid)
	local int = {}
	int.name="interface"
	local x,y = toRender(1/2,1/2)
	local dx = 2*x
	local dy=2*y
	int.draw=function()
		for i,v in ipairs(character) do
			local compt=0
			while compt<character[i].life do
				tileset:add(100,gid.animation[1].tileid,camera._x+x+compt*dx,camera._y+y*i)
				compt=compt+1
			end
		end
	end


	object[int.name]=int
end
