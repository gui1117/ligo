require "tool.pathfinder"
function initmap (mapname)
	--timeCoef=1.5
	map=nil
	map=love.filesystem.load("map/"..mapname..".lua")() -- needed for pathfinding ( height and width )
	local gid=tiolved.gid(map,"map/")

	tileset=tiolved.tileset(gid,map)
	toMap,toRender=tiolved.usefulfunc(map,tileset)

	local toremove={}
	for i,v in ipairs (map.layers) do
		if v.name=="objet" then
			for k,vjk in ipairs (v.data) do
				if vjk~=0 then
					local g=gid[vjk]
					if g.name and create[g.name] then
						g.canvas:setFilter("nearest")
						create[g.name](world,(k-1)%map.width+1,math.ceil(k/map.width),g,gid,mapGid)
					end
				end
			end
			table.insert(toremove,i)
		end
	end
	for _,v in ipairs(toremove) do
		table.remove(map.layers,v)
	end

	layers=tiolved.layers(map,tileset)
	pathfinding:load(map.width,map.height)
	map=nil
	collectgarbage()
end
