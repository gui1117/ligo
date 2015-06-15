require "tool.pathfinder"
function initmap (mapname)
	--timeCoef=1.5
	map=nil
	map=love.filesystem.load(contentFile("map/"..mapname))() -- needed for pathfinding ( height and width )

	local gid=tiolved.gid(map,"map/")

	tileset=tiolved.tileset(gid,map)
	toMap,toRender=tiolved.usefulfunc(map,tileset)

	local toremove={}
	for i,v in ipairs (map.layers) do
		if v.name=="wall" or v.name=="object" then
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
	local dv=0
	for _,v in ipairs(toremove) do
		table.remove(map.layers,v-dv)
		dv=dv+1
	end

	layers=tiolved.layers(map,tileset)
	pathfinding:load(map.width,map.height)
	map=nil
	collectgarbage()
end

function initmusic(name,loop)
	if music then
		music:stop()
		music=nil
	end
	if name then
		if love.filesystem.exists(userDir.."sound/"..name) then
			music=love.audio.newSource(userDir.."sound/"..name,"stream")
		elseif love.filesystem.exists("sound/"..name) then
			music=love.audio.newSource("sound/"..name,"stream")
		end
		if music then
			music:setLooping(loop)
			music:setVolume(musicVolume)
			music:play()
		end
	end
end

function initconstant(level)
	timecoef=level.timecoef or timecoef
	charactervelocity=level.charactervelocity or charactervelocity
end


