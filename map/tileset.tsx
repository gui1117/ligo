<?xml version="1.0" encoding="UTF-8"?>
<tileset name="tileset" tilewidth="16" tileheight="16">
 <image source="tileset.png" trans="ff00ff" width="320" height="320"/>
 <terraintypes>
  <terrain name="sol" tile="0"/>
  <terrain name="plafond" tile="1"/>
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
 <tile id="20" terrain="1,1,1,0">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="21" terrain="1,1,0,1">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="22" terrain="1,0,1,1">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="23" terrain="0,1,1,1">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="24" terrain="0,0,0,1">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="25" terrain="0,0,1,0">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="26" terrain="0,1,0,0">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="27" terrain="1,0,0,0">
  <properties>
   <property name="name" value="wall"/>
  </properties>
 </tile>
 <tile id="40">
  <properties>
   <property name="angle1" value="0"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="45" duration="0"/>
   <frame tileid="203" duration="0"/>
  </animation>
 </tile>
 <tile id="41">
  <properties>
   <property name="angle1" value="180"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="46" duration="0"/>
   <frame tileid="203" duration="0"/>
  </animation>
 </tile>
 <tile id="42">
  <properties>
   <property name="angle1" value="270"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="47" duration="0"/>
   <frame tileid="203" duration="0"/>
  </animation>
 </tile>
 <tile id="43">
  <properties>
   <property name="angle" value="90"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="48" duration="0"/>
   <frame tileid="203" duration="0"/>
  </animation>
 </tile>
 <tile id="60">
  <properties>
   <property name="angle" value="0"/>
   <property name="name" value="arrowslit"/>
  </properties>
 </tile>
 <tile id="100">
  <properties>
   <property name="name" value="pike"/>
  </properties>
  <animation>
   <frame tileid="101" duration="0"/>
   <frame tileid="102" duration="0"/>
  </animation>
 </tile>
 <tile id="120">
  <properties>
   <property name="angle1" value="0"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="125" duration="0"/>
   <frame tileid="200" duration="0"/>
  </animation>
 </tile>
 <tile id="121">
  <properties>
   <property name="angle1" value="0"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="126" duration="0"/>
   <frame tileid="201" duration="0"/>
  </animation>
 </tile>
 <tile id="122">
  <properties>
   <property name="angle1" value="0"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="127" duration="0"/>
   <frame tileid="202" duration="0"/>
  </animation>
 </tile>
 <tile id="123">
  <properties>
   <property name="angle1" value="0"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="128" duration="0"/>
   <frame tileid="203" duration="0"/>
  </animation>
 </tile>
 <tile id="140">
  <properties>
   <property name="angle1" value="0"/>
   <property name="angle2" value="180"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="145" duration="0"/>
   <frame tileid="200" duration="0"/>
  </animation>
 </tile>
 <tile id="141">
  <properties>
   <property name="angle1" value="0"/>
   <property name="angle2" value="180"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="146" duration="0"/>
   <frame tileid="201" duration="0"/>
  </animation>
 </tile>
 <tile id="142">
  <properties>
   <property name="angle1" value="0"/>
   <property name="angle2" value="0"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="147" duration="0"/>
   <frame tileid="202" duration="0"/>
  </animation>
 </tile>
 <tile id="143">
  <properties>
   <property name="angle1" value="0"/>
   <property name="angle2" value="180"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="147" duration="0"/>
   <frame tileid="202" duration="0"/>
  </animation>
 </tile>
 <tile id="180">
  <properties>
   <property name="angle1" value="0"/>
   <property name="angle2" value="90"/>
   <property name="angle3" value="180"/>
   <property name="angle4" value="270"/>
   <property name="angularVelocity" value="60"/>
   <property name="name" value="arrowslit"/>
   <property name="rate" value="30"/>
  </properties>
  <animation>
   <frame tileid="185" duration="0"/>
   <frame tileid="200" duration="0"/>
  </animation>
 </tile>
 <tile id="181">
  <properties>
   <property name="angle1" value="0"/>
   <property name="angle2" value="90"/>
   <property name="angle3" value="180"/>
   <property name="angle4" value="270"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="186" duration="0"/>
   <frame tileid="201" duration="0"/>
  </animation>
 </tile>
 <tile id="182">
  <properties>
   <property name="angle1" value="0"/>
   <property name="angle2" value="90"/>
   <property name="angle3" value="180"/>
   <property name="angle4" value="270"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="187" duration="0"/>
   <frame tileid="202" duration="0"/>
  </animation>
 </tile>
 <tile id="183">
  <properties>
   <property name="angle1" value="0"/>
   <property name="angle2" value="90"/>
   <property name="angle3" value="180"/>
   <property name="angle4" value="270"/>
   <property name="name" value="arrowslit"/>
  </properties>
  <animation>
   <frame tileid="188" duration="0"/>
   <frame tileid="203" duration="0"/>
  </animation>
 </tile>
 <tile id="204">
  <properties>
   <property name="name" value="bullet"/>
  </properties>
 </tile>
 <tile id="220">
  <properties>
   <property name="name" value="redmonster"/>
  </properties>
  <animation>
   <frame tileid="260" duration="0"/>
   <frame tileid="240" duration="0"/>
  </animation>
 </tile>
 <tile id="221">
  <properties>
   <property name="name" value="redmonster"/>
  </properties>
  <animation>
   <frame tileid="261" duration="0"/>
   <frame tileid="241" duration="0"/>
  </animation>
 </tile>
 <tile id="222">
  <properties>
   <property name="name" value="redmonster"/>
  </properties>
  <animation>
   <frame tileid="262" duration="0"/>
   <frame tileid="242" duration="0"/>
  </animation>
 </tile>
 <tile id="223">
  <properties>
   <property name="name" value="redmonster"/>
  </properties>
  <animation>
   <frame tileid="263" duration="0"/>
   <frame tileid="243" duration="0"/>
  </animation>
 </tile>
 <tile id="240">
  <animation>
   <frame tileid="260" duration="100"/>
   <frame tileid="240" duration="100"/>
   <frame tileid="260" duration="100"/>
   <frame tileid="280" duration="100"/>
  </animation>
 </tile>
 <tile id="241">
  <animation>
   <frame tileid="261" duration="100"/>
   <frame tileid="241" duration="100"/>
   <frame tileid="261" duration="100"/>
   <frame tileid="281" duration="100"/>
  </animation>
 </tile>
 <tile id="242">
  <animation>
   <frame tileid="262" duration="100"/>
   <frame tileid="242" duration="100"/>
   <frame tileid="262" duration="100"/>
   <frame tileid="282" duration="100"/>
  </animation>
 </tile>
 <tile id="243">
  <animation>
   <frame tileid="263" duration="100"/>
   <frame tileid="243" duration="100"/>
   <frame tileid="263" duration="100"/>
   <frame tileid="283" duration="100"/>
  </animation>
 </tile>
 <tile id="300">
  <properties>
   <property name="name" value="character"/>
  </properties>
  <animation>
   <frame tileid="302" duration="0"/>
   <frame tileid="301" duration="0"/>
  </animation>
 </tile>
 <tile id="301">
  <animation>
   <frame tileid="302" duration="100"/>
   <frame tileid="301" duration="100"/>
   <frame tileid="302" duration="100"/>
   <frame tileid="303" duration="100"/>
  </animation>
 </tile>
 <tile id="320">
  <properties>
   <property name="name" value="fin"/>
  </properties>
 </tile>
 <tile id="321">
  <properties>
   <property name="name" value="interface"/>
  </properties>
  <animation>
   <frame tileid="205" duration="0"/>
   <frame tileid="206" duration="0"/>
  </animation>
 </tile>
</tileset>
