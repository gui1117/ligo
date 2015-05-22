fin={}
fin.nbr=0
function create.fin (world,x,y,gid) 
	local nf = {}
	nf.name="fin"
	fin.nbr=fin.nbr+1
	nf.nbr=fin.nbr

	nf.update=function()
		local f=true
		for i=1,4 do 
			if character[i] and character[i].body then
				local xc,yc=character[i].body:getPosition()
				f=f and (norme(xc-x+1/2,yc-y+1/2) < 0.5)
			end
		end
		if f then
			nextmap=true
			destroyState("game")
			enableState("nextmap")
		end
	end
	local xr,yr=toRender(x-1/2,y-1/2)
	nf.draw=function()
		if camera.isVisible(x-1/2,y-1/2) then
			tileset:add(40,gid.id,xr,yr,0,1,1,toRender(1/2,1/2))
		end
	end
	object[nf.name..nf.nbr]=nf
end
