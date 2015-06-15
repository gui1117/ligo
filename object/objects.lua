create={}

require "object.sensor"
require "lib.tiolved"
require "tool.function"
require "object.wall"
require "object.pike"
require "object.arrowslit"
require "object.arrow"
require "object.character"
require "object.redmonster"
require "weapon.bullet"
require "object.interface"
require "object.generator"
require "object.link"

object={}

function setGroup(fixture,type)
	if type=="floor" then
		fixture:setCategory(1)
		fixture:setMask(3,5,7)
		fixture:setGroupIndex(0)
		fixture:setSensor(true)
	elseif type=="ramping" then
		fixture:setMask()
		fixture:setGroupIndex(0)
		fixture:setCategory(2)
	elseif type=="flying" then
		fixture:setCategory(3)
		fixture:setMask(1)
		fixture:setGroupIndex(-3)
	elseif type=="wall" then
		fixture:setMask()
		fixture:setCategory(4)
		fixture:setGroupIndex(0)
	elseif type=="bullet" then
		fixture:setCategory(5)
		fixture:setMask(1)
		fixture:setGroupIndex(-5)
	elseif type=="hero" then
		fixture:setMask()
		fixture:setCategory(6)
		fixture:setGroupIndex(0)
	elseif type=="link" then
		fixture:setCategory(7)
		fixture:setGroupIndex(-7)
		fixture:setMask(1,6,8,10)
	elseif type=="hotlink" then
		fixture:setCategory(8)
		fixture:setGroupIndex(-8)
		fixture:setMask(1,7,10)
	elseif type=="phantom" then
		fixture:setCategory(9)
		fixture:setGroupIndex(-9)
		fixture:setMask(1,2,3,5,7,8)
	elseif type=="nolink" then
		fixture:setCategory(10)
		fixture:setGroupIndex(-10)
		fixture:setMask(1,2,3,4,5,6,7,8,9)
	end
end

initobject=function()
	wall.nbr=0
	pike.nbr=0
	arrowslit.nbr=0
	arrow.nbr=0
	redmonster.nbr=0
	bullet.nbr=0
	for i,v in pairs(object) do
		if v.body and v.body:isDestroyed() then
			v.body=nil
		end
		v.update=nil
		v.draw=nil
		v=nil
	end
	object=nil
	object={}
end
