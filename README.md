Valdmor
========================================
Game in development using [Tiled](http://www.mapeditor.org/) a tile map editor, [LÖVE](http://love2d.org) a lua game engine and [Tiölved](https://github.com/thiolliere/tiolved) a library to use Tiled in Löve.

current state : 0.1
[github](https://github.com/thiolliere/valdmor)

about
----------------------------------------
Valdmor is a mix of top-down and shoot'em up gameplay. In fact 

* static or very patterned engine throw bullet that have to be dodge in shoot'em up way using 'z' 'q' 's' 'd' 
* and monster with basic AI - such as run to the hero, stay at a distance from the hero, have to be killed by shooting on them with the mouse aim.

Valdmor uses 

* löve2d game engine to manage sound, drawing, keyboard, and a physic engine
* tiled, a tile map editor that is used as a complete game map editor.
* tiölved to interprete map from tiled in xml into lua.

install
----------------------------------------

* linux : 
	* install [LÖVE](http://love2d.org) 
	* download [valdmor.love](http://www.thiolliere.org/valdmor/download/valdmor0.1/valdmor.love)
* windows :
	* 32 bit : [valdmor32](http://www.thiolliere.org/valdmor/download/valdmor0.1/valdmor32.zip)
	* 64 bit : [valdmor64](http://www.thiolliere.org/valdmor/downloadvaldmor0.1/valdmor64.zip)
* mac :
	* download [valdmor_osx](http://www.thiolliere.org/valdmor/download/valmdor0.1/valdmor_osx.zip)

play
----------------------------------------

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
    * **animation** :
      * 1 generator tile
      * 2 monster gid
    * **rate** : number of second between generations
    * **newtime** : time at beginning
    * **spawn** : number of place = 4, 8 or 16
    * **salvo** : number of monster to spawn at each generations
    * **distance** : the distance minimal to active the generator
  * **interface** : 
    * **animation** :
      * 1 life point tile
      * 2 stamina point tile
  * **link** :
    * **anchor1** : number of the first player tied
    * **anchor2** : number of the second player tied
  * **wall** : no arguments
  * **pike** : animation
    * 1 : tile pike down
    * 2 : tile pike up
  * **redmonster** : 
    * **animation** :
      * 1 staying
      * 2 running
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

### drawned
* name mustn't be *objet*
* the layer must have propriety named *z* and valued *0* or *1* for the moment

todo
----
* sound balance
* searchDeep
* save config file
* arrowslit angular velocity can be changed be colliding with them
* calculate with time and not frame

global idea(french)
-----------------------------------------

####**Son** : l'ensemble est dans un style 8-bit.

* **effets sonores** générés simplement avec sfxr.
* **musiques** divisé en variations avec des variations discrètes et d'autre très présente de manière à s'adapter au differente phase de gameplay : puzzle/plateforme-douce et combat/plateforme-dure respectivement.
