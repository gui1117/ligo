Ligo
========================================

Video
----------------------------------------
not available


Install stable version
----------------------------------------

* linux : 
	* install [LÖVE](http://love2d.org) 
	* download [ligo.love](http://www.thiolliere.org/ligo/download/stable/ligo.love)
* windows :
	* 32 bit : [ligo_win32](http://www.thiolliere.org/ligo/download/stable/ligo_win32.zip)
	* 64 bit : [ligo_win64](http://www.thiolliere.org/ligo/download/stable/ligo_win64.zip)
* mac :
	* download [ligo_osx](http://www.thiolliere.org/ligo/download/stable/ligo_osx.zip)

about
----------------------------------------
Ligo is a game I develop alone.
I use [Tiled](http://www.mapeditor.org/) a tile map editor, 
[LÖVE](http://love2d.org) a lua game engine 
and [Tiölved](https://github.com/thiolliere/tiolved) a library I develop to manage Tiled in Löve. 
It also use [Jumper](https://github.com/Yonaba/Jumper) a pure lua grid-based pathfinding library.

It is not in develpment as I moved to another project.
The project is almost finished but levels must be created and
I don't like to create some so ... 

the project is free and open source and is hosted on github [here](https://github.com/thiolliere/ligo) and
all version are available [there](http://www.thiolliere.org/ligo/download).

The main mecanic is a link between players that force them to act together. 
Indeed the link is the only way to kill ennemy. 
However surviving is individual.

The input are simple as possible : 4 directions and a key. 
It can be played on joystick or keyboard.

It is easy to create your own map by using tiled.
See the documentation below.

It is released under MIT license,
so you got the code, do whatever you want. 

licence
----------------------------------------

The MIT License (MIT)

Copyright (c) 2015 thiolliere

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

map editor
----------------------------------------

a basic example is available [here](https://github.com/thiolliere/ligo_editor),
with a README explaning step by step how to create a map and a dungeon

you can edit a map and a dungeon (a series of map like in the game)

dungeon
----------------------------------------

* the filename must finish by .dungeon.lua
* the file is in dungeon repertory at the root of your user directory
	* **Windows XP**: C:\Documents and Settings\user\Application Data\LOVE\ or %appdata%\LOVE\
	* **Windows Vista and 7**: C:\Users\user\AppData\Roaming\LOVE or %appdata%\LOVE\
	* **Linux**: $XDG_DATA_HOME/love/ or ~/.local/share/love/
	* **Mac**: /Users/user/Library/Application Support/LOVE/ 
* it is a lua file that return a lua table 
	* return { name = "name of your dungeon", current = 0,
* other element are table that can be picture of level
	* don't forget coma between element
	* **level** : {
		* type="level",
		* map="your_map_from_tiled.lua", stored in map directory at the root of user directory
		* music="yourmusic.ogg", stored in sound directory, it can be also mp3 but ogg don't have patents, think of it.
		* timecoef=1, or number between 0 and +oo, however it can result in bug
		* charactervelocity=10 or other number, all velocity like monster velocity and arrow velocity are proportional to character velocity
		* },
	* **picture** : { things between level
		* type="picture",
		* image="yourimage", stored in image directory, this element isn't mandatory
		* text="yourtext", not mandatory also, it is printed at the center of the screen, you can make a new line with \n
		* music="briefmusic.ogg" stored in sound directory, not mandatory
  		* }
	* }

map
----------------------------------------

Map are generated with [tiled](http://www.mapeditor.org/), use ctrl+e to export in lua.
First download it.

Tiled is a tool to create layer of tile.
I use only tile layer but in two way

* layer that are drawned
	* they must have an attribute **"z"** that is altitude of the layer.
	* telltale : wall are at 40, character at 30, bullet at 20 and floor at 10.
	* they must'nt be name **objet**
* layer that are interprated
	* they must be named **objet**
	* tile have attribute :
		* name=name_of_the_object
		* attribute_of_the_object=value
		* ..
	* some attribute are special :
		* animation is a way to pass tile to the object, use tool animation for it. But in order not to be annoyed fix the duration to 0.
		* sound is a string that represent the subobject. For instance for the sound destroy of an arrow we want to have different sound wheither it is an arrow or fireball. So if sound=fireball the sound is fireball-destroy.ogg or arrow-destroy.ogg if sound=arrow.
	* the list of object and the attribute the need is following

object
----------------------------------------
 
They are two kind of object : primitive and alias.
The first are real object (a code in lua for each), 
the second are alias that set value of some attribute if you don't give one.
Indeed fireball can be an alias of arrow that set time=2 out of the default value.

time unit is second * timecoef, distance unit is meter, a tile is 1x1 meter.
Velocity are moslty relative to character velocity and angle are in degrees

Notation : 

* name of the object
	* animation :
		* number of the tile : description
		* ..
	* sound : string [arrow] : (if toto load toto-...ogg sound)
		* sound_of_the_object  (so need toto-sound_of_the_object.ogg in sound directory) : description
		* ..
	* attribute : type [default_value] : description
	* ..
	* an enum type is writen {class1, class2,..}

#Primitive

* **arrow** : an arrow threw by the arrowslit
	* **animation** :
		* 1 	: animation of arrow
		* 2 	: animation of dying
	* **sound** 	: string	[arrow]
		* destroy : "string-destroy.ogg" when colliding something
	* **shape** 	: {circle, rectangle} 	[circle]
	* **radius** 	: number 	[0.25]
	* **height** 	: number 	[0.3]
	* **width** 	: number	[0.1]
	* **velocity** 	: number 	[1]	: maximum linear velocity relatively to character velocity
	* **velocityTime** : number 	[1]	: time to reach maximum speed
	* **density** 	: number	[1]
	* **time** 	: number 	[NULL]	: time the arrow survive in second
	* **distance** 	: number	[30]	: distance the arrow survive if no time
	* **damage** 	: number 	[1]	: amount of damage
	* **guided** 	: boolean	[false] : if the arrow is guided to the closest character
* **arrowslit** : throw arrow in many directions
	* **animation** :
		* 1 	: tile of engine
		* 2	: gid of the arrow
	* **sound** 	: string	[arrowslit]
		* shoot 
	* **rate** 	: number 	[1]	: time between shoots in second
	* **angularVelocity** : number	[0]	: velocity in degree per second
	* **shape** 	: {rectangle, circle} [circle]
	* **radius**	: number	[0.25]
	* **height**	: number	[1]
	* **width**	: number	[1]
	* **initTime** 	: number	[0]	: set time at beginning, I use it de unsynchronize arrowslit
	* **initAngle**	: number	[0]	: set the initial angle of the arrowslit
	* **angle..** 	: number	[NULL]	: angles of shoot in degrees (this attribute can be set many times with different name as angle1, angle2...)
	* **aim** 	: boolean 	[false]	: weither it follows de closest character or not
* **camera** : set the scale
	* **scale**	: number	[0.3]	: set the zoom
* **character** : set the initial position of a character
	* **animation** :
		* 1 	: animation of character staying
		* 2 	: animation of character running
		* 3 	: animation of phantom character staying
		* 4 	: animation of phantom character running
		* 5 	: effect of heal
	* **player** 	: {1, 2}	[1]	: number of the player
	* **sound** : "character" to change it learn lua and love2d or tell me you want a more generic map editor by email.
		* walk
		* run
		* damaged
		* phantom
		* resurrection
		* link
		* heal
		* die
		* restart
* **generator** : spawn monster regularly
	* **sound** 	: string	[generator]
		* spawn		: when monster are spawn
		* prespawn	: before spawn to warn players
	* **animation** :
		* 1	: generator waiting tile
		* 2 	: generator prespawn tile 
		* 3 	: monster gid
	* **rate** 	: number	[4]	: seconds between generations
	* **prespawn** 	: number	[0.75]	: if rate=1 then prespawn happen 0.75s after spawn by default
	* **newtime** 	: number	[0]	: set time at beginning, to unsynchronize spawns between generators
	* **spawn** 	: {0, .. , 16}	[4]	: number of spawn at each generation
	* **distance** 	: number	[22]	: the distance minimal to active the generator
* **interface** : set tile of the interface
	* **animation** :
		* 1 	: tile of life point
* **link** 	 
	* **animation** :
		* 1 	: safe part of the link
		* 2 	: harmful part of the link
	* **sound** 	: string	[link]
		* damage
		* destroyed
		* elongate
		* retract
	* **anchor1** 	: number	[1]	: first player tied
	* **anchor2** 	: number 	[2]	: second player tied
* **wall** 	 
	* **sound** : string		[wall]	: not implemented
		* character : not implemented
* **pike** 	: pike that raise when hero goes on
	* **animation** :
		* 1 : tile pike down
		* 2 : tile pike up
	* **sound** :
		* declench
		* up
* **redmonster**  
	* **animation** :
		* 1 staying
		* 2 running
		* 3 dying
	* **sound** :
		* run
		* die
		* damage
	* **velocity** 	: number	[0.5] 	: maximum velocity relative to characterVelocity
	* **velocityTime** : number	[0.00001] : time to reach 0.95 * velocity
	* **shape** 	: {circle, rectangle} [rectangle] 
	* **radius**	: number 	[0.35]
	* **height**	: number	[0.7]
	* **width**	: number	[0.7]
	* **density**	: number	[1]
	* **damage** 	: number	[1]	: amount of damage
	* **searchTime** : number	[1]	: time between pathfinder
	* **distance** 	: number	[50]	: maximal distance of character to wake up
* **fin** : move to the next level
	* animation
		* 0 character on the tile
		* 1 character on the tile
	* **sound** :
		* 0Activated
		* 1Activated
		* 2Activated

#alias

none yet
