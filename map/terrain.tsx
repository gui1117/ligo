<?xml version="1.0" encoding="UTF-8"?>
<tileset name="terrain" tilewidth="16" tileheight="16">
 <image source="terrain.png" width="144" height="112"/>
 <terraintypes>
  <terrain name="sol" tile="0"/>
  <terrain name="mur" tile="5"/>
 </terraintypes>
 <tile id="0" terrain="0,0,0,0"/>
 <tile id="1" terrain="1,1,1,1"/>
 <tile id="2" terrain="1,0,1,0">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="3" terrain="0,1,0,1">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="4" terrain="0,0,1,1">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="5" terrain="1,1,0,0">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="9" terrain="1,1,1,0">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="10" terrain="1,1,0,1">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="11" terrain="1,0,1,1">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="12" terrain="0,1,1,1">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="13" terrain="0,0,0,1">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="14" terrain="0,0,1,0">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="15" terrain="0,1,0,0">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="16" terrain="1,0,0,0">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="54">
  <properties>
   <property name="name" value="pike"/>
  </properties>
  <animation>
   <frame tileid="55" duration="0"/>
   <frame tileid="56" duration="0"/>
  </animation>
 </tile>
</tileset>
