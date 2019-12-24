globals [stage-number person1 myAirplane]

to go
  ca
  reset-ticks
  background-airport
  get-on-plane
end

to background-outerspace ;setup
  cd
  ct
  cro 1
  [
    set color white
    set shape "star"
    repeat 100[
    set size (random-float 1) + 1
    setxy random 33 random 33
      stamp
    ]
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
  ;set up dirt
  let temp 0
repeat 11[
  cro 1[
  set size 3
  set shape "dirt_block"
  setxy (-15 + temp) -15
    stamp
      die
    ]
      set temp temp + 3
  ]

  ;set up airplane
  cro 1 [
    set color grey
    set shape "airplane"
    set size 14
    setxy -3 -12
    set myAirplane self
  ]
end

to-report xcor_greater_than_zero [target]
  let temp false
  ask target[
  set temp xcor > 0
  ]
  report temp
end

to get-on-plane
  cro 1[
  set shape "traveler1stand"
  set person1 self
  set size 6
  setxy 16 -15
  ]
  while [xcor_greater_than_zero person1]
  [
    ask person1[
    set xcor xcor - 0.2
    set shape "traveler1walk"
    ]
    tick
    wait 0.001
    ask person1[
    set xcor xcor - 0.2
    set shape "traveler1stand"
    ]
    tick
    wait 0.001
  ]
  talk-airport
  ask person1[
    die]
  ask myAirplane[
    set shape "airplane-flying"
  ]
  fly-to-portal
end

to fly-to-portal
  ;build up speed
  repeat [
    repeat 5[
    ask myAirplane[
      object-back]
    ]
    spawn-cloud
  ]
    ask patch 6 0[
    set plabel ""
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
to spawn-cloud
  cro 1[
    set color random-float 5 + 4.9
    set shape "cloud"
    set size random 3 + 3
    set xcor 16
    set ycor random 4 + 12
  ]
end
to object-back
  ask other turtles[
    set xcor xcor - 0.1
    if xcor <= -15.9[
     die
    ]
  ]
  wait 0.02
end

to talk-airport

  ask patch 6 0[
    set plabel "I'm going to Disney World!!"
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
647
448
-1
-1
13.0
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
0
0
1
ticks
30.0

BUTTON
0
10
205
43
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
22
121
146
154
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
36
212
99
245
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
true
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

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

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
