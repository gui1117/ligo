<?xml version="1.0" encoding="UTF-8"?>
<tileset name="character" tilewidth="16" tileheight="16">
 <image source="character.png" width="144" height="96"/>
 <tile id="0">
  <properties>
   <property name="name" value="bullet"/>
  </properties>
 </tile>
 <tile id="1">
  <properties>
   <property name="anchor1" value="1"/>
   <property name="anchor2" value="3"/>
   <property name="name" value="link"/>
  </properties>
 </tile>
 <tile id="2">
  <properties>
   <property name="name" value="link"/>
  </properties>
  <animation>
   <frame tileid="2" duration="0"/>
   <frame tileid="0" duration="0"/>
  </animation>
 </tile>
 <tile id="9">
  <properties>
   <property name="name" value="character"/>
  </properties>
  <animation>
   <frame tileid="11" duration="0"/>
   <frame tileid="10" duration="0"/>
  </animation>
 </tile>
 <tile id="10">
  <animation>
   <frame tileid="11" duration="100"/>
   <frame tileid="10" duration="100"/>
   <frame tileid="11" duration="100"/>
   <frame tileid="12" duration="100"/>
  </animation>
 </tile>
 <tile id="14">
  <properties>
   <property name="name" value="character"/>
   <property name="player" value="2"/>
  </properties>
  <animation>
   <frame tileid="11" duration="0"/>
   <frame tileid="10" duration="0"/>
  </animation>
 </tile>
 <tile id="15">
  <properties>
   <property name="name" value="character"/>
   <property name="player" value="3"/>
  </properties>
  <animation>
   <frame tileid="11" duration="0"/>
   <frame tileid="10" duration="0"/>
  </animation>
 </tile>
 <tile id="18">
  <properties>
   <property name="name" value="fin"/>
  </properties>
 </tile>
 <tile id="19">
  <properties>
   <property name="name" value="interface"/>
  </properties>
  <animation>
   <frame tileid="1" duration="0"/>
   <frame tileid="2" duration="0"/>
  </animation>
 </tile>
</tileset>
