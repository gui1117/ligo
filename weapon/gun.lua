require "tool.function"
require "weapon.bullet"
gun={}

-- configuration
--
-- sound
-- draw
-- shootImpulse
-- timetoreload
-- timetoshoot

gun.shootsound=love.audio.newSource("sound/gunshoot.ogg","static")
gun.shootsound:setRelative("true")

gun.shootImpulse=30
gun.timetoreload=5

function gun:shoot(character)
	if character.reloading then
--		gun.sound.emptyweapon:stop()
--		gun.sound.emptyweapon:play()
	end
	character.gun.shooting=true
end

function gun:nonshoot(character)
	character.gun.shooting=false
end

function gun:load(character)
	character.gun={}
	character.gun.armed=true
	character.gun.reloading=false
	character.gun.equipped=false
	character.gun.shooting=false
	character.gun.timereloading=0
end

function gun:equip(character)
	character.gun.reloading=false
	character.gun.timereloading=0
	character.gun.equipped=true
end

function gun:nonequip(character)
	character.gun.reloading=false
	character.gun.timereloading=0
	character.gun.equipped=false
	character.gun.shooting=false
end


function gun:update(character)
	local cc = character.gun
	if cc.shooting then
		if cc.armed then
			local imp=gun.shootImpulse
			local a = character.body:getAngle()
			local x = character.body:getX()
			local y = character.body:getY()
			local d = character.shootdistance
			local bul = bullet:create(x+d*math.cos(a),y+d*math.sin(a),a)
			bul.body:applyLinearImpulse(imp*math.cos(a),imp*math.sin(a))
			gun.shootsound:stop()
			gun.shootsound:play()
			cc.armed=false
			cc.reloading=true
		else 
			cc.reloading=true
		end
	end
	if cc.reloading then
		cc.timereloading=cc.timereloading+1
		if cc.timereloading>gun.timetoreload then
			cc.timereloading=0
			cc.reloading=false
			cc.armed=true
		end
	end
end
