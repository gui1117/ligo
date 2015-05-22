require "tool.function"
require "lib.tiolved"

bullet={} -- balle standard il pourra en exister d'autre

function create.bullet (world,x,y,gid)
	bullet.tileid=gid.id
end

bullet.hitsound=love.audio.newSource("sound/hit.ogg","static")
-- un son de sifflement pour le déplacement de la fleche dans l'air ?

bullet.width=0.25
bullet.height=0.50
bullet.timetolive=20

bullet.nbr=0
function bullet:create(x,y,a)
	local newbul={}
	newbul.nbr=bullet.nbr
	bullet.nbr=bullet.nbr+1
	newbul.hitsound=bullet.hitsound
	newbul.body=love.physics.newBody(world, x+math.cos(a)*bullet.height/2, y+math.sin(a)*bullet.height/2, "dynamic")
	newbul.body:setAngle(a)
	newbul.body:setBullet()
	newbul.shape=love.physics.newRectangleShape(bullet.height,bullet.width)
	newbul.fixture=love.physics.newFixture(newbul.body,newbul.shape,10)
	newbul.fixture:setUserData(newbul)
	setGroup(newbul.fixture,"bullet")
	newbul.z=1
	newbul.name="bullet"
	newbul.beginContact={}
	newbul.timeliving=0
	function newbul.update ()
		newbul.timeliving=newbul.timeliving+1
		for _,v in ipairs(newbul.beginContact) do
			if v.other and v.other.makeDamage then
				v.other.makeDamage(1)
			end
			newbul.kill()
			return
		end
		newbul.beginContact={}
		if newbul.timeliving>bullet.timetolive then
			newbul.kill()
			return
		end
	end
	function newbul.kill ()
		object[newbul.name..newbul.nbr]=nil
		newbul.hitsound:setPosition(newbul.body:getPosition())
		play(newbul.hitsound)
		newbul.body:destroy()
		newbul=nil
	end
	newbul.draw=function()
		local x,y=toRender( newbul.body:getX(), newbul.body:getY())
		local o=newbul.body:getAngle()
		tileset:add( 30, bullet.tileid, x, y, o, 1, 1, toRender(1/2,1/2))
	end
	object[newbul.name..newbul.nbr]=newbul
	return newbul
end
