Ligo
========================================
Game in development using [Tiled](http://www.mapeditor.org/) a tile map editor, [LÖVE](http://love2d.org) a lua game engine and [Tiölved](https://github.com/thiolliere/tiolved) a library to use Tiled in Löve.

current state : 0.1 alpha

the project is free and open source and is hosted on github [here](https://github.com/thiolliere/ligo)

all version are available [there](http://www.thiolliere.org/ligo/download)

about
----------------------------------------
Ligo is two player cooperative game. 
The main mecanic is a link between players that force them to act together. 
Indeed the link is the only way to kill ennemy. 
However surviving is individual.

The input are simple as possible : 4 directions and a key. It can be played on joystick or keyboard.

Ligo uses 

* löve2d game engine to manage sounds, graphics, keyboard, and physics
* tiled, a tile map editor that is used as a complete game map editor.
* tiölved to use tiled in love2d

install stable version
----------------------------------------

* linux : 
	* install [LÖVE](http://love2d.org) 
	* download [ligo.love](http://www.thiolliere.org/ligo/download/stable/ligo.love)
* windows :
	* 32 bit : [ligo_win32](http://www.thiolliere.org/ligo/download/stable/ligo_win32.zip)
	* 64 bit : [ligo_win64](http://www.thiolliere.org/ligo/download/stable/ligo_win64.zip)
* mac :
	* download [ligo_osx](http://www.thiolliere.org/ligo/download/stable/ligo_osx.zip)

map editor
----------------------------------------
It uses tiled as said above. There are two kind of tilelayer : the interpreted and the drawned.

### interpreted
* the name of the tile-layer must be *objet*  
* each tile drawn on the layer have a name and the argument needed for the object
* object are :
  * **arrow** :
    * **shape** : circle or rectangle
    * **radius** : number
    * **height** : number
    * **width** : number
    * **velocity** : number : maximum linear velocity
    * **velocityTime** : number : time to reach maximum speed
    * **density** : number
    * **distance** : number : distance the arrow survive in square
    * **time** : number : time the arrow survive in second
    * **damage** : number : amount of damage
    * **guided** : false or true : if the arrow is guided to the closest character
    * **sound** : string
      * destroy : "string-destroy.ogg" when destroyed 
    * **animation** :
      * 1 : tile effect of dying
  * **arrowslit** :
    * **rate** : number : time between shoots in second
    * **angularVelocity** : velocity in degree per second
    * **shape** : rectangle or circle
    * **radius**
    * **height**
    * **width**
    * **initTime** : set time at beginning
    * **angle..** : angles of shoot
    * **aim** : boolean : if it follow de closest character or not
    * **sound** : string
      * shoot 
    * **animation** :
      * 1 : tile of engine
      * 2 : gid of the arrow
  * **camera** :
    * **scale**
  * **character** :
    * **animation** :
      * 1 : animation of character staying
      * 2 : animation of character running
    * **player** : number of the player ( 1..4 )
  * **generator** :
    * **prespawn** : fraction where prespawn
    * **animation** :
      * 1 generator waiting tile
      * 2 generator prespawn tile 
      * 3 monster gid
    * **rate** : number of second between generations
    * **newtime** : time at beginning
    * **spawn** : number of place = 4, 8 or 16
    * **salvo** : number of monster to spawn at each generations
    * **distance** : the distance minimal to active the generator
    * **sound** : string
      * walk
      * run
      * damaged
      * phantom
      * resurrection
      * link
      * heal
      * die
      * restart
  * **interface** : 
    * **animation** :
      * 1 life point tile
      * 2 stamina point tile
  * **link** :
    * **anchor1** : number of the first player tied
    * **anchor2** : number of the second player tied
    * **animation** :
      * 1 : link
      * 2 : hotlink
    * **sound** :
      * damage
      * destroyed
      * elongate
      * retract
  * **wall** : 
    * **sound** :
      * character
  * **pike** : 
    * **animation** :
      * 1 : tile pike down
      * 2 : tile pike up
    * **sound** :
      * declench
      * up
  * **redmonster** : 
    * **animation** :
      * 1 staying
      * 2 running
    * **sound** :
      * run
      * die
      * damage
    * **velocity** : relative to characterVelocity
    * **velocityTime** : time to reach 0.95 * velocity
    * **shape** : circle or rectangle
    * **radius**
    * **height**
    * **width**
    * **density**
    * **damage** : amount of damage
    * **searchTime** : time between pathfinder
    * **distance** : distance of character to wake up
  * **fin** : move to the next map in mapList
    * **sound** :
      * fin

### drawned
* name mustn't be *objet*
* the layer must have propriety named *z* and valued *0* or *1* for the moment
