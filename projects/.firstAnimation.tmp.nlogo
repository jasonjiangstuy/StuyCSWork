globals [stage-number person1 myAirplane introbars cinder portal alien]


to background-outerspace ;setup
  cd
  ct
  cro 1
  [
    set color white
    set shape "star"
    repeat 100[
    set size (random-float 1) + 0.5
    setxy random 33 - 16 random 33 - 16
      if not (ycor > 1 and ycor < 5)[
        stamp]
    ]
    die

  ]
  cro 1 [
    set color green + 1
  set shape "ufo side"
  set size 3
    set alien self
  ]

  cro 1 [
    set color grey
    set shape "airplane-flying"
    set size 14
    setxy -16 12
    set myAirplane self
    ht
  ]
    cro 1 [
   set portal self
   set shape "portal flipped"
   set size 13
   set xcor n-of-plane "x" + 5
   set ycor n-of-plane "y"
  ]
 cro 1 [
    set shape "moon"
    set size 5
    set color 9
    setxy 14 14
    stamp
    die
  ]
end

to background-airport ;setup
  cd
  ct
  ;set up sky color
  ask patches[
    set pcolor sky
  ]
  ;set up clouds
  cro 3[
    set color random-float 5 + 4.9
    set shape "cloud"
    set size random 3 + 3
    set xcor random 32 - 16
    set ycor random 4 + 12
  ]
  ;set up sun
  cro 1[
    set color yellow
    set shape "sun"
    set size 5
    setxy 16 16
    stamp
    die
  ]
  ;set up hanger turtle
  cro 1[
    set shape "hanger"
    set size 5
    setxy -13 -12
  ]

  place-floor "dirt_block" "dirt_block"

  ;set up airplane
  cro 1 [
    set color grey
    set shape "airplane"
    set size 14
    setxy -3 -12
    set myAirplane self
  ]
end

to place-floor [name-of-block startingblock]

  let temp 0

  cro 1[
  set size 3
  set shape startingblock
    setxy -15 -15
    stamp
   set temp temp + 3
    repeat 10[
    set shape name-of-block
    setxy (-15 + temp) -15
    stamp
      set temp temp + 3

    ]
    die
  ]
end
to introduction
  ask patches [ set pcolor magenta]
  set introbars []
  repeat 32[
  cro 1[
  set introbars lput self introbars
  set shape "blackcolumn"
  set size 16
  set ycor -7
  show position self introbars
  set xcor -16 + position self introbars
  ]
  ]

  show introbars

  cro 1[
    set shape "disney"
    set size 33
    setxy 0 -16
    stamp
    die
  ]
  talk-intro "A trip to DisneyLand by Jason Jiang"
  tick
  cro 1[
  set shape "traveler1stand"
  set person1 self
  set size 9
  setxy 15 7
  ]
  let hold 0
     foreach introbars[
    x -> ask x [ die ]

    repeat 9[
    ask person1 [
      if xcor <= -15 [ die ]
      set xcor xcor - 0.1
      ifelse shape = "traveler1stand"[
      set shape "traveler1walk"][
      set shape "traveler1stand"]
      ]
      wait 0.02
      tick
    ]
      ]

  talk-intro ""
  ask person1[
    die
  ]
  cd

end

to get-on-plane
  cro 1[
  set shape "traveler1stand"
  set person1 self
  set size 6
  setxy 16 -15
  ]
  ;start of movement
  while [xcor_greater_than_x person1 0]
  [
    ask person1[
    set xcor xcor - 0.2
    set shape "traveler1walk"
    ]
    tick
    wait 0.01
    ask person1[
    set xcor xcor - 0.2
    set shape "traveler1stand"
    ]
    tick
    wait 0.01
  ]
  show "starting talk"
  talk-airport "I'm going to Disney Land!!"
  ask person1[
    die]
  ask myAirplane[
    set shape "airplane-flying"
    set heading 90
  ]
  fly-to-portal
end
to fly-to-portal
  ;build up speed
  repeat 2[
    repeat 12[
    ask myAirplane[
      object-back]
    ]
    spawn-cloud
  ]

  ;lift off
    repeat 3[
    repeat 9[
    repeat 2[
    liftoff
    ]
    glide
    ]
    spawn-cloud
  ]

  ;bring to glide
  repeat 2
  [
    repeat 12 [
      repeat 2[
      glide
      ]
      liftoff
    ]spawn-cloud
  ]

  talk-airport ""
end
to glide
  ask myAirplane[
    set ycor ycor * 0.99
    rt 1
    object-back]
    tick
    wait 0.005
end
to liftoff

    ask myAirplane[
      set ycor ycor * 0.99
      lt 1
      object-back
    ]
    tick
    wait 0.005
end

to go
  ca
  reset-ticks ;earth scenes
  introduction ;finnicky
  background-airport ;
  get-on-plane ;shaky
  flytoportal2 ;
  flyintoportal;
  ca
  reset-ticks;space scenes
  background-outerspace
  alientalk
end

to flytoportal2
  ask myAirplane[
  set heading 90
  ]
talk-airport "** Alright Passengers"
talk-airport2 "this is your Pilot speaking... **"
cro 1[
   set size 3
   set shape "cement"
   set cinder self
   setxy 15 -15
   stamp
   set shape "gtoc"
  ]
    bufferfly 7


  talk-airport "** We have reached Crusing Altitude"
  talk-airport2 " you may now unbu-... **"

    bufferfly 6
  talk-airport "** Nevermind---- Everyone, we have "
  talk-airport2 "just recieved word that..."

    bufferfly 6
  talk-airport "**we are rapidly approching an alien portal!!! **"
  talk-airport2 ""

    bufferfly 5

  talk-airport2 ""
  talk-airport "** BrAcE fOr ImPaCt!!! **"
  bufferfly 3



end

to bufferfly [x] ; one second of terrain flying
  repeat x [
  spawn-cloud
  spawn-building
    repeat 2[
        if cinder != nobody[
    ask cinder [
      set shape "cement"
      stamp
      set shape "gtoc"
    ]
  ]
    repeat 5[
    ask myAirplane[
    object-back
    set ycor ycor + random-float .25 - 0.128
    if ycor < -2[
        set ycor ycor + 0.1
        ]
    ]
    tick
    wait 0.1
    ]]
]
end
to-report xcor_greater_than_x [target x]
  let temp false
  ask target[
  set temp xcor > x
  ]
  report temp
end

to alientalk
  talk-space "Ok any minute now..." 14 green + 1
  tick
  wait 3
  talk-space "I got this" 5 green + 1
  tick
  wait 2
  talk-space "3 " 1 green + 1
  tick
  wait 1
  talk-space "2 " 1 green + 1
  tick
  wait 1
  talk-space "1 " 1 green + 1
  tick
  wait 1
  talk-space "0 " 1 green + 1
  tick
  wait 2
  talk-space "..." 1 green + 1
  tick
  wait 2
  talk-space "I said zErO" 6 green + 1
  tick
  wait 2
  talk-space "... " 1 green + 1
  tick
  wait 2

  talk-space "nailed it" 5 green + 1
  tick
  ask myAirplane[
   st
    set heading 90

  ]
  repeat 60[
    ask myAirplane[set xcor xcor + 0.3 ]
    tick
    wait 0.01
    ]

  talk-space "Hey Hey You" 8 green + 1
  tick
  wait 3
  talk-space "**Ahh help anyone come in" 17 grey
  tick
  wait 4
  talk-space "we are at uhhhhh... where are we???** " 25 grey
  tick
  wait 3
  talk-space "You are at the edge of space..." 20 green + 1
  tick
  wait 5
  talk-space "...yeah I'm hijacking your plane sorry" 23 green + 1
  tick
  wait 4
  talk-space "I got dared lmao" 10 green + 1
  tick
  wait 3
  talk-space "Now that I think about it, this is really mean" 28 green + 1
  tick
  wait 5
  talk-space "Welp, too late to go back now" 20 green + 1
  tick
  wait 3
  ask alien[
  create-link-with myAirplane
  ]
  talk-space "gotcha!!" 3 green + 1
  tick
  wait 0.5
  while [((distance-between alien myAirplane) > 8)][
    ask myAirplane[
      set heading towards alien
      fd 0.3
    ]

    tick
    wait 0.02
  ]
  talk-space "Now I'm bringing you to my hometown of Mars" 2 green + 1
  tick
  wait 3
  talk-space "**Please be gentle with us!!** " 20 grey
  tick
  wait 4
  talk-space "You got it!!!" 7 green + 1
  tick wait 3
  talk-space "Hold on tight!!!" 10 green + 1
  tick
  wait 3









end
to-report distance-between [x y]
  let z 0
  ask x [
   set z distance y
  ]
  report z
end
to spawn-cloud
  cro 1[
    set color random-float 5 + 4.9
    set shape "cloud"
    set size random 3 + 3
    set xcor 16 - random-float 1
    set ycor random 4 + 12
  ]
end
to object-back
  ask other turtles[
    if xcor <= -15.4[
     die
    ]
    set xcor xcor - 0.6

  ]
  wait 0.02
end
to spawn-building


     cro 1[
    set color random-float 14 * 10 + 6
    set shape one-of["house" "plant" "building institution" "building store" "ambulance" "bus" "car" "factory"]
    set size random 4 + 3
    set xcor 16 - random-float 1
    set ycor -15 + random 3
  ]
end
to talk-airport [x]

  ask patch 14 4[
    set plabel x
  ]
end
to talk-space [x tiles colortext]
  ask patches with [pycor <= 4 and pycor >= 2]
  [
    set pcolor black
  ]
  ask patch 14 3[
   set plabel-color colortext
    set plabel x
  ]
  ask patches with [pycor <= 4 and pycor >= 2 and pxcor <= 14 and pxcor >= (14 - tiles) ]

  [set pcolor white]

end
to talk-airport2 [x]
  ask patch 14 0[
    set plabel x
  ]
end
to talk-intro [x]

  ask patch 15 4[
    set plabel-color 9.9
    set plabel x
  ]
end
to test [x]

  show x

end


to setuptest
  ca
  reset-ticks

end

to flyintoportal
  cro 1 [
   set shape "portal"
   set size 13
   set xcor 14
   set ycor n-of-plane "y"
  ]
  talk-airport "~Screams of the passangers~"

  while [n-of-plane "x" < 14] [
  ask myAirplane [
     set xcor xcor + 0.4
    ]
    tick
    wait 0.01

  ]


end



to-report n-of-plane [n] ;if n is "y" -> ycor "x" -> xcor
  let y 0
  ifelse n = "y"
  [
  ask myAirplane[
   set y ycor
  ]]
  [
  ask myAirplane[
    set y xcor
  ]]
  report y
end


to-report xcor-of-plane ;
  let y 0
  ask myAirplane[
   set y xcor
  ]
  report y
end
to-report ycor-of-plane
  let y 0
  ask myAirplane[
   set y ycor
  ]
  report y
end
@#$#@#$#@
GRAPHICS-WINDOW
208
10
673
476
-1
-1
13.85
1
20
1
1
1
0
0
0
1
-16
16
-16
16
1
1
1
ticks
30.0

BUTTON
696
190
901
223
NIL
background-outerspace\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
838
69
962
102
NIL
get-on-plane\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
53
74
116
107
NIL
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
728
31
813
64
NIL
setuptest\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
827
29
924
62
NIL
introduction
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
50
17
113
50
NIL
stop\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
805
264
886
297
NIL
alientalk\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
false
0
Rectangle -6459832 true false 150 180 165 210
Polygon -7500403 true true 49 156 33 156 32 169 112 183 267 182 273 174 274 168 272 163 264 159 255 151 132 144 87 146 67 150 45 150 42 154 46 156
Polygon -16777216 false false 36 128 84 161
Polygon -16777216 true false 31 155 19 154 19 166 36 165 36 154
Polygon -16777216 true false 258 155 255 160 245 162 245 170 260 167 265 160 259 157 259 156
Polygon -16777216 false false 155 184 159 198
Rectangle -16777216 true false 172 205 158 207
Polygon -16777216 false false 123 156 123 156 195 176
Polygon -14835848 true false 120 165 78 175 92 176 191 167 119 166
Polygon -14835848 true false 80 159 54 159 28 164 41 167 79 159
Rectangle -16777216 false false 225 165 240 180
Polygon -14835848 true false 50 87 87 145 51 154 36 88
Circle -16777216 true false 133 199 28
Circle -16777216 true false 159 196 28
Circle -1 true false 166 203 14
Circle -1 true false 141 206 14
Polygon -6459832 true false 224 173 226 191 210 218 207 209 226 175
Polygon -6459832 true false 224 179 240 181 223 218 211 217 226 182
Polygon -6459832 true false 239 173 239 181 223 216 220 207 239 175
Polygon -16777216 false false 211 218 225 181 225 174 207 204 211 218 225 217 239 183 238 174 221 205 226 219

airplane-flying
true
0
Polygon -7500403 true true 156 251 156 267 169 268 183 188 182 33 174 27 168 26 163 28 159 36 151 45 144 168 146 213 150 233 150 255 154 258 156 254
Polygon -16777216 false false 128 264 161 216
Polygon -16777216 true false 155 269 154 281 166 281 165 264 154 264
Polygon -16777216 true false 155 42 160 45 162 55 170 55 167 40 160 35 157 41 156 41
Polygon -16777216 false false 184 145 198 141
Rectangle -16777216 true false 205 142 207 128
Polygon -16777216 false false 156 177 156 177 176 105
Polygon -14835848 true false 165 180 175 222 176 208 167 109 166 181
Polygon -14835848 true false 159 220 159 246 164 272 167 259 159 221
Rectangle -16777216 false false 165 60 180 75
Polygon -14835848 true false 87 250 145 213 154 249 88 264

ambulance
false
0
Rectangle -7500403 true true 30 90 210 195
Polygon -7500403 true true 296 190 296 150 259 134 244 104 210 105 210 190
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Circle -16777216 true false 69 174 42
Rectangle -1 true false 288 158 297 173
Rectangle -1184463 true false 289 180 298 172
Rectangle -2674135 true false 29 151 298 158
Line -16777216 false 210 90 210 195
Rectangle -16777216 true false 83 116 128 133
Rectangle -16777216 true false 153 111 176 134
Line -7500403 true 165 105 165 135
Rectangle -7500403 true true 14 186 33 195
Line -13345367 false 45 135 75 120
Line -13345367 false 75 135 45 120
Line -13345367 false 60 112 60 142

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

blackcolumn
false
0
Rectangle -5825686 true false 90 0 210 330

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

building institution
false
0
Rectangle -7500403 true true 0 60 300 270
Rectangle -16777216 true false 130 196 168 256
Rectangle -16777216 false false 0 255 300 270
Polygon -7500403 true true 0 60 150 15 300 60
Polygon -16777216 false false 0 60 150 15 300 60
Circle -1 true false 135 26 30
Circle -16777216 false false 135 25 30
Rectangle -16777216 false false 0 60 300 75
Rectangle -16777216 false false 218 75 255 90
Rectangle -16777216 false false 218 240 255 255
Rectangle -16777216 false false 224 90 249 240
Rectangle -16777216 false false 45 75 82 90
Rectangle -16777216 false false 45 240 82 255
Rectangle -16777216 false false 51 90 76 240
Rectangle -16777216 false false 90 240 127 255
Rectangle -16777216 false false 90 75 127 90
Rectangle -16777216 false false 96 90 121 240
Rectangle -16777216 false false 179 90 204 240
Rectangle -16777216 false false 173 75 210 90
Rectangle -16777216 false false 173 240 210 255
Rectangle -16777216 false false 269 90 294 240
Rectangle -16777216 false false 263 75 300 90
Rectangle -16777216 false false 263 240 300 255
Rectangle -16777216 false false 0 240 37 255
Rectangle -16777216 false false 6 90 31 240
Rectangle -16777216 false false 0 75 37 90
Line -16777216 false 112 260 184 260
Line -16777216 false 105 265 196 265

building store
false
0
Rectangle -7500403 true true 30 45 45 240
Rectangle -16777216 false false 30 45 45 165
Rectangle -7500403 true true 15 165 285 255
Rectangle -16777216 true false 120 195 180 255
Line -7500403 true 150 195 150 255
Rectangle -16777216 true false 30 180 105 240
Rectangle -16777216 true false 195 180 270 240
Line -16777216 false 0 165 300 165
Polygon -7500403 true true 0 165 45 135 60 90 240 90 255 135 300 165
Rectangle -7500403 true true 0 0 75 45
Rectangle -16777216 false false 0 0 75 45

bus
false
0
Polygon -7500403 true true 15 206 15 150 15 120 30 105 270 105 285 120 285 135 285 206 270 210 30 210
Rectangle -16777216 true false 36 126 231 159
Line -7500403 false 60 135 60 165
Line -7500403 false 60 120 60 165
Line -7500403 false 90 120 90 165
Line -7500403 false 120 120 120 165
Line -7500403 false 150 120 150 165
Line -7500403 false 180 120 180 165
Line -7500403 false 210 120 210 165
Line -7500403 false 240 135 240 165
Rectangle -16777216 true false 15 174 285 182
Circle -16777216 true false 48 187 42
Rectangle -16777216 true false 240 127 276 205
Circle -16777216 true false 195 187 42
Line -7500403 false 257 120 257 207

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

cement
false
7
Rectangle -7500403 true false -15 75 345 420
Polygon -7500403 true false 0 75 -15 45 330 45 300 75 285 90 270 75 255 105 240 75 225 90 195 75 195 105 165 75 150 90 120 75 105 105 90 75 75 105 60 75 45 105 30 75 15 105
Rectangle -16777216 true false 240 210 255 240
Rectangle -16777216 true false 225 120 240 135
Rectangle -16777216 true false 135 225 150 240
Rectangle -16777216 true false 210 180 225 195
Rectangle -16777216 true false 60 195 75 210
Rectangle -16777216 true false 150 270 165 285
Rectangle -16777216 true false 195 240 210 255
Rectangle -16777216 true false 75 255 90 270
Rectangle -16777216 true false 45 150 60 165
Rectangle -16777216 true false 270 255 285 285
Rectangle -16777216 true false 15 240 30 270
Rectangle -16777216 true false 165 120 180 150
Rectangle -16777216 true false 90 135 105 150
Line -16777216 false 300 90 -15 90
Polygon -1184463 true false 41 60 37 67 67 67 70 62 39 62
Polygon -1184463 true false 226 59 222 66 252 66 255 61 224 61
Polygon -1184463 true false 166 62 162 69 192 69 195 64 164 64
Polygon -1184463 true false 102 62 98 69 128 69 131 64 100 64

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cloud
false
0
Circle -7500403 true true 13 118 94
Circle -7500403 true true 86 101 127
Circle -7500403 true true 51 51 108
Circle -7500403 true true 118 43 95
Circle -7500403 true true 158 68 134

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dirt_block
false
0
Rectangle -6459832 true false -15 75 345 420
Polygon -13840069 true false 0 75 30 45 270 45 300 75 285 90 270 75 255 105 240 75 225 90 195 75 195 105 165 75 150 90 120 75 105 105 90 75 75 105 60 75 45 105 30 75 15 105
Rectangle -1184463 true false 240 210 255 240
Rectangle -1184463 true false 225 120 240 135
Rectangle -1184463 true false 135 225 150 240
Rectangle -1184463 true false 210 180 225 195
Rectangle -1184463 true false 60 195 75 210
Rectangle -1184463 true false 105 135 120 150
Rectangle -1184463 true false 150 270 165 285
Rectangle -1184463 true false 195 240 210 255
Rectangle -1184463 true false 75 255 90 270
Rectangle -1184463 true false 45 150 60 165
Rectangle -1184463 true false 270 255 285 285
Rectangle -1184463 true false 15 240 30 270
Rectangle -1184463 true false 150 120 165 150

disney
false
0
Rectangle -5825686 true false 2 3 467 393
Circle -11221820 false false 1 28 298
Rectangle -5825686 true false 1 165 361 375
Polygon -11221820 true false 42 165 34 191 147 190 257 193 255 180 258 147 267 146 261 138 254 120 255 106 246 106 254 111 254 112 251 122 249 126 244 121 236 93 228 123 222 123 217 116 212 86 203 117 197 117 193 100 198 82 191 65 198 53 190 40 198 39 184 5 167 39 175 39 168 52 174 63 166 79 161 77 154 88 147 53 136 53 146 58 137 90 142 93 129 117 121 100 116 117 106 125 109 115 107 101 95 86 93 75 83 77 93 80 90 87 80 103 76 114 79 126 71 146 61 133 55 110 44 117 54 118 43 133 33 145 38 146 41 182
Rectangle -16777216 true false 41 175 263 181
Rectangle -5825686 true false 46 90 255 95
Rectangle -5825686 true false 42 109 264 115
Rectangle -5825686 true false 39 126 266 132
Rectangle -5825686 true false 29 143 270 149
Rectangle -5825686 true false 37 159 259 165
Rectangle -16777216 true false 41 175 263 181
Rectangle -5825686 true false 36 175 263 181
Rectangle -5825686 true false 168 37 201 43
Rectangle -5825686 true false 67 60 240 68
Circle -5825686 true false 124 154 55

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

factory
false
0
Rectangle -7500403 true true 76 194 285 270
Rectangle -7500403 true true 36 95 59 231
Rectangle -16777216 true false 90 210 270 240
Line -7500403 true 90 195 90 255
Line -7500403 true 120 195 120 255
Line -7500403 true 150 195 150 240
Line -7500403 true 180 195 180 255
Line -7500403 true 210 210 210 240
Line -7500403 true 240 210 240 240
Line -7500403 true 90 225 270 225
Circle -1 true false 37 73 32
Circle -1 true false 55 38 54
Circle -1 true false 96 21 42
Circle -1 true false 105 40 32
Circle -1 true false 129 19 42
Rectangle -7500403 true true 14 228 78 270

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

gtoc
false
7
Polygon -7500403 true false 90 45 300 45 300 75 90 75 90 45
Rectangle -7500403 true false -45 75 315 420
Polygon -13840069 true false 0 75 30 45 90 45 90 75 300 90 75 75 75 105 90 75 90 75 90 75 90 75 60 105 90 75 60 105 105 105 60 105 90 75 60 75 45 105 30 75 15 105
Rectangle -16777216 true false 240 210 255 240
Rectangle -16777216 true false 225 120 240 135
Rectangle -16777216 true false 135 225 150 240
Rectangle -16777216 true false 210 180 225 195
Rectangle -16777216 true false 60 195 75 210
Rectangle -16777216 true false 150 270 165 285
Rectangle -16777216 true false 195 240 210 255
Rectangle -16777216 true false 75 255 90 270
Rectangle -16777216 true false 45 150 60 165
Rectangle -16777216 true false 270 255 285 285
Rectangle -16777216 true false 15 240 30 270
Rectangle -16777216 true false 165 120 180 150
Rectangle -16777216 true false 90 135 105 150
Line -16777216 false 300 90 -15 90
Polygon -1184463 true false 226 59 222 66 252 66 255 61 224 61
Polygon -1184463 true false 166 62 162 69 192 69 195 64 164 64
Polygon -1184463 true false 102 62 98 69 128 69 131 64 100 64
Polygon -7500403 true false 120 60 240 75

hanger
false
0
Polygon -7500403 true true 0 300 15 225 60 180 105 165 150 150 195 165 240 180 285 225 300 300 0 300
Rectangle -16777216 true false 75 225 225 300

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

moon
false
0
Polygon -7500403 true true 125 7 217 36 275 108 273 186 221 250 166 271 95 274 19 239 93 233 148 216 187 185 196 132 190 77 168 51

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

portal
false
0
Rectangle -13791810 true false 149 69 304 206
Polygon -8630108 true false 150 66 135 127 145 206 150 134 150 70
Polygon -8630108 true false 152 77 163 137 147 203 144 203 150 79 131 143
Polygon -8630108 true false 149 74 165 86 170 97 179 110 181 126 181 141 178 167 172 189 163 198 146 205
Polygon -2064490 false false 159 82 164 117 170 155 156 186 158 208 153 196
Polygon -5825686 false false 175 114 153 116 160 137 166 158 177 154 166 118 164 94 157 173 177 167 144 145 178 117
Polygon -13791810 false false 145 117 171 93 129 166 219 159 154 132 191 210 107 221 134 140 207 114 170 71 124 106 126 137
Polygon -13840069 false false 120 75 205 129 146 176 137 128 188 78 119 186 181 210 143 188 220 161 132 138 152 111 165 83 159 79 132 122 191 148 181 190 161 200

portal flipped
false
0
Rectangle -16777216 true false -4 69 151 206
Polygon -8630108 true false 150 66 165 127 155 206 150 134 150 70
Polygon -8630108 true false 148 77 137 137 153 203 156 203 150 79 169 143
Polygon -8630108 true false 151 74 135 86 130 97 121 110 119 126 119 141 122 167 128 189 137 198 154 205
Polygon -2064490 false false 141 82 136 117 130 155 144 186 142 208 147 196
Polygon -5825686 false false 125 114 147 116 140 137 134 158 123 154 134 118 136 94 143 173 123 167 156 145 122 117
Polygon -13791810 false false 155 117 129 93 171 166 81 159 146 132 109 210 193 221 166 140 93 114 130 71 176 106 174 137
Polygon -13840069 false false 180 75 95 129 154 176 163 128 112 78 181 186 119 210 157 188 80 161 168 138 148 111 135 83 141 79 168 122 109 148 119 190 139 200

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

sun
false
0
Circle -7500403 true true 75 75 150
Polygon -7500403 true true 300 150 240 120 240 180
Polygon -7500403 true true 150 0 120 60 180 60
Polygon -7500403 true true 150 300 120 240 180 240
Polygon -7500403 true true 0 150 60 120 60 180
Polygon -7500403 true true 60 195 105 240 45 255
Polygon -7500403 true true 60 105 105 60 45 45
Polygon -7500403 true true 195 60 240 105 255 45
Polygon -7500403 true true 240 195 195 240 255 255

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

traveler1stand
false
5
Polygon -10899396 true true 225 165 195 180 210 225 240 210 225 165 210 165 180 180 195 180
Polygon -10899396 true true 195 180 180 180 195 225 210 225 195 180
Polygon -16777216 false false 225 165 195 180 210 225 240 210 225 165
Polygon -16777216 false false 195 180 180 180 195 225 180 180 210 165 225 165
Polygon -16777216 false false 204 169 197 158 184 164 191 174
Polygon -13791810 true false 194 162
Rectangle -10899396 true true 136 134 162 184
Circle -10899396 true true 130 109 38
Polygon -16777216 true false 190 161 149 152 147 156 188 162
Polygon -16777216 true false 162 184 163 227 156 227 151 186 144 227 137 228 137 184 161 184
Rectangle -16777216 true false 130 104 168 114
Rectangle -16777216 true false 138 68 160 109

traveler1walk
false
5
Polygon -10899396 true true 225 165 195 180 210 225 240 210 225 165 210 165 180 180 195 180
Polygon -10899396 true true 195 180 180 180 195 225 210 225 195 180
Polygon -16777216 false false 225 165 195 180 210 225 240 210 225 165
Polygon -16777216 false false 195 180 180 180 195 225 180 180 210 165 225 165
Polygon -16777216 false false 204 169 197 158 184 164 191 174
Polygon -13791810 true false 194 162
Rectangle -10899396 true true 136 134 162 184
Circle -10899396 true true 130 109 38
Polygon -16777216 true false 190 161 149 152 147 156 188 162
Polygon -16777216 true false 162 184 180 225 165 225 151 186 135 225 120 225 137 184 161 184
Rectangle -16777216 true false 130 104 168 114
Rectangle -16777216 true false 138 68 160 109

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

ufo side
false
0
Polygon -1 true false 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 195 105 150 105 105 105 60 105 15 120 0 135
Polygon -16777216 false false 105 105 60 105 15 120 0 135 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 210 105
Polygon -7500403 true true 60 131 90 161 135 176 165 176 210 161 240 131 225 101 195 71 150 60 105 71 75 101
Circle -16777216 false false 255 135 30
Circle -16777216 false false 180 180 30
Circle -16777216 false false 90 180 30
Circle -16777216 false false 15 135 30
Circle -7500403 true true 15 135 30
Circle -7500403 true true 90 180 30
Circle -7500403 true true 180 180 30
Circle -7500403 true true 255 135 30
Polygon -16777216 false false 150 59 105 70 75 100 60 130 90 160 135 175 165 175 210 160 240 130 225 100 195 70

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
