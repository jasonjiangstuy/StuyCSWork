globals[makeup turn leftbuttonheld gamemode settingup cannon-base1 cannon-turret1 cannon-base2 cannon-turret2 risespeed errorcounterleft errorcounterright trees ended]
turtles-own[playernum raisedirection shoot loaded angle power canshoot istree? isball? canhitwhichcolor? parent isdased? spining? timestarted drop-animate defaultangle]
patches-own[color-hit corresponding]

to go

  let pressedleft leftbuttonheld

  let pressedright mouse-down?;show lil animation // cannon charging up?



  ask turtles with [canshoot = "yes"][;cannons
    if loaded[
    leftbuttonpressed;raises left turret
    rightbuttonpressed;raises right turret
    ]
  ]
   if (timetoshoot? cannon-turret1) and pressedleft[
       ;show "shootleft";shoot from left cannon ;------------------------------
        ask cannon-turret1[set loaded False set shoot False]
        actualshoot "left";shot left
        ask cannon-turret1[set heading 60]
      ]

        set leftbuttonheld False
   if (timetoshoot? cannon-turret2) and pressedright[
       ;show "shootright"; shoot from right cannon
        ask cannon-turret2[set loaded False set shoot False]
        actualshoot "right"
        ask cannon-turret2[set heading 300];further add a falling animation
      ]

  ask turtles with [isdased? = True][
    ;show "working"
    if spining? = True[
     ifelse (timer - timestarted > 2)[
       show timestarted
       show timer
       set spining? False
       ask parent[set loaded True]
       ht
      ]
      [rt 1]
    ]
  ]
  cannonballmove
  testwin
  if ended = True[
    stop
  ]
  tick
  wait 0.03


end

to setup
  ca
  reset-ticks
  set trees []
  set risespeed 1
 	set turn 1
  set leftbuttonheld False
  set makeup 15; add to parent heading
  build-cannons["yes"]
  build-tree 3
  builddazed cannon-turret1
  builddazed cannon-turret2
  tick
end

to daze[thiscannon]
  show "dazing"
  show thiscannon
  ask turtles with [isdased? = True][
   if parent = thiscannon[
     st
     set timestarted timer
     set spining? True
    ]
  ]
end
to builddazed [myParent]
  cro 1[
    move-to myParent
    set shape "dased"
    set ycor ycor + 8
    set xcor xcor * 0.8
    set size 7
    set isdased? True
    set parent myParent
    ht
  ]

end
to angling
  cro 1[
    let x 0
    repeat 15[
     setxy (-16 + x) 16
     pd
      setxy 0 0
      pu
      set x x + 2
    ]
    set x 0
        repeat 15[
     setxy (-16 + x) -16
     pd
      setxy 0 0
      pu
      set x x + 2
    ]
    set x 0
        repeat 15[
     setxy -16 (-16 + x)
     pd
      setxy 0 0
      pu
      set x x + 2
    ]
    set x 0
        repeat 15[
     setxy 16 (-16 + x)
     pd
      setxy 0 0
      pu
      set x x + 2
    ]

      die
    ]

  tick
end

to leftbuttonpressed
    ;keep raising turret working test

      if playernum = "left"[

    if not shoot[ set shoot True];if button released shoot will launch the ball
      ifelse heading <= 60 and heading >= 40[
       set heading heading + raisedirection
        ][set raisedirection -1 * raisedirection
        set heading heading + raisedirection ]


    ]

end

to rightbuttonpressed
  ;keep raising turret

      if playernum = "right"[ ; if heading = 300 -> lowest target; heading  = 320 highest target // 6 targets // if has a heading of 319 -> hit highest target, 301 -> hit lowest target  heading of 18/6 between targets

    if not shoot[ set shoot True];if button released shoot will launch the ball
      ifelse heading >= 300 and heading <= 320[
       set heading heading + raisedirection
        ][set raisedirection -1 * raisedirection
        set heading heading + raisedirection ]
      ]

end

to-report timetoshoot?[whichplayer]
  let x False
  ask whichplayer[
    set x shoot
  ]
  report x
end

to build-tree[treesize]
  ;each part of tree takes up 3 tiles - starting at orgin y = 0 , 3, 6, 9, 12, 15 up to size 3 * 2
  if treesize <= 3[
    let x 0.5
    let y 0
    let z 0
   repeat treesize * 2[
     cro 1[
        set size 3
        setxy 0 x
        set istree? True
        set trees lput self trees
        ifelse (remainder y 2) = 0 [set shape "shoottreered"][set shape "shoottreegreen"]

      ]
     ask patch -1 (x - 1)[set color-hit red set corresponding z]
     ask patch -1 (x)[set color-hit red set corresponding z]
     ask patch 1 (x - 1)[set color-hit green set corresponding z]
      ask patch 1 (x)[set color-hit green set corresponding z]
     set x x + 2
     set y y + 1
      set z z + 1
    ]
  ]
end

to-report reporttestangle;done
  let x 0
  ask cannon-turret1[
    set x heading
  ]
  report x
end

to winanimate[left?]
  ask turtles[ht]
  let x (list "p" "l" "a" "y" "e" "r")
  ifelse left?[
    set x lput "1" x
  ]
  [set x lput "2" x]

  letters x 5
  let q (list "w" "i" "n" "s")
  letters q -3

end

to letters[thislist up]
  let current 0
  let moving 0
  foreach thislist [
   y ->

   cro 1[
     set shape y
      set color one-of [7 15 25 35 45 75 85 105 115 125 135] + random-float 2
     set current self
     set ycor up + (random-float 2 - 1)

    ]
   repeat 15[
      ask current[set size size + 0.6
        set xcor xcor - 0.8 + moving]
      tick
       wait 0.05
      ]
    set moving moving + 0.26
    ask current[set heading (random-float 10) - 5]
  ]
end
to win-left[left?]
  ifelse left? [
  ;left wins
  show "left-wins"
  winanimate True
  set ended True
  ]

  [
    ;rightwins
  show "right-wins"
  winanimate False
  set ended True
  ]
end

to testwin
  if ((count (turtles with [shape = "shoottreered"])) = 0)[
   win-left True
    ]
  if ((count (turtles with [shape = "shoottreegreen"])) = 0)[
   win-left False
  ]
end
to-report reporttestangleright;done
  let x 0
  ask cannon-turret2[
    set x heading
  ]
  report x
end
to build-2playerarena
  ;blue sky
  let x-arena 0
  let hold 0.6
  let border-size 30
    let decrease 0.5
  let boarder-color 4
  let awayfromwall 1

  ask patches[ set pcolor sky]
  ask patches with [pycor < 0][set pcolor green]
  ;cone shape - grey on bottom
    ask patches with [pycor < 0][if abs pycor + x-arena > abs pxcor[
    set pcolor 2]
  ]
  let x 1
  repeat 2[
    cro 1[
      setxy ((16 - awayfromwall) * x) -16
      set pen-size border-size
      set color boarder-color
      pd
      facexy 0 (0 - hold)
      while[ycor <= ( 0 - hold)][
      fd 0.5
      set pen-size pen-size - decrease
      ]

      die]
    set x (x * -1)
  ]
  ;yellow strip
    cro 1[
      setxy 0 -16
      set pen-size 20
      set color 47
      pd
      facexy 0 0
      let temp True
      let counter 0
      while[ycor <= ( 0 - hold)][
      ifelse temp[pd][pu]
      fd 0.5
      set pen-size pen-size - 0.5
       set counter counter + 1
       if counter >= 3[
        ifelse temp[set temp False][set temp True]
        set counter 0
        ]
      ]



      die]




  ; maybe add some cloud turtles
end
to build-cannons[hide]
  build-2playerarena
   cro 1[                      ; cannon left
    set color 2
    set shape "cannon-left"
    set cannon-turret1 self
    set size 22
    setxy -15 -14
    set heading 55
    set canshoot "yes"
    set playernum "left"
    set shoot False ; cannons didnt shoot yet
    set loaded True ; cannons are ready to fire
    set raisedirection -1 * risespeed
    if hide = "yes"[ht]
  ]
  cro 1 [
    set shape "cannon base left"
    set size 10
    move-to cannon-turret1
    facexy 0 0
    fd 2
    set cannon-base1 self
    if hide = "yes"[ht]
  ]
     cro 1[                     ;cannon right
    set color 2
    set shape "cannon-right"
    set cannon-turret2 self
    set size 22
    setxy 15 -14
    set heading 305
    set shoot False ; cannons didnt shoot yet
    set loaded True ; cannons are ready to fire
    set playernum "right"
    set canshoot "yes"
    set raisedirection risespeed
    if hide = "yes"[ht]
  ]
  cro 1 [
    set shape "cannon base right"
    set size 10
    move-to cannon-turret2
    facexy 0 0
    fd 2
    set cannon-base1 self
    if hide = "yes"[ht]
  ]

end

to cannon-shoot-left;done
  	ifelse leftbuttonheld[set leftbuttonheld False][set leftbuttonheld True]
end

to choose
	
end
to-report parentheader[whichplayer]
  let x False
  ask whichplayer[
    set x heading
  ]
  report x
end
to actualshoot[whichplayer]
  ifelse whichplayer = "left"
  [;left
    cro 1[
     set shape "ball baseball"
     set color white
     set isball? True
     set canhitwhichcolor? red
     daze cannon-turret1
     move-to cannon-turret1
      set parent cannon-turret1
     set heading parentheader cannon-turret1 + makeup * -1
      fd 9
    ]
  ]

  [;right
       cro 1[
     set shape "ball baseball"
     set color white
      set isball? True
       set canhitwhichcolor? green
      daze cannon-turret2
     move-to cannon-turret2
      set parent cannon-turret2
      set heading parentheader cannon-turret2 + makeup
      fd 9
  ]
  ]
end
to-report swap[thistree tcolor]
  let swapped False
  ask (item thistree trees)[
    if tcolor = red[
       if shape = "shoottreered" [set shape "shoottreegreen" set swapped True]

    ]
    if tcolor = green[
       if shape = "shoottreegreen" [set shape "shoottreered" set swapped True]
    ]
    ]
  report swapped
end

to cannonballmove
   ask turtles[
    if isball? = True[
      ifelse can-move? 0.5 [fd 0.5
      if color-hit = canhitwhichcolor?[

          ;show corresponding
          ;show color-hit
          ;show "i am"
          ;show canhitwhichcolor?
          if (swap corresponding color-hit)[
          die
          ]
        ]

      ][

        die
      ]
  ]]
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
10
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
62
68
125
101
NIL
setup\n\n
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
687
175
758
208
NIL
angling\n
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
130
134
163
Shoot P1
cannon-shoot-left
NIL
1
T
OBSERVER
NIL
Q
NIL
NIL
1

BUTTON
62
26
129
59
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
666
92
778
137
NIL
leftbuttonheld
17
1
11

MONITOR
668
10
768
55
NIL
reporttestangle
17
1
11

MONITOR
798
15
923
60
NIL
reporttestangleright
17
1
11

MONITOR
798
91
907
136
NIL
errorcounterright
17
1
11

TEXTBOX
674
262
1236
389
Player 1 press q to shoot\n\nPlayer 2 click the mouse button to shoot\n\nHave fun !!!!
20
0.0
1

BUTTON
678
414
1064
447
NIL
builddazed cannon-turret1\nask turtles with [isdased? = True][st]
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

1
true
0
Polygon -7500403 true true 120 60 90 120
Polygon -7500403 true true 135 45 105 105 135 105 165 75 165 210 105 210 105 240 225 240 225 210 195 210 195 45 135 45 90 105 90 105

2
true
0
Polygon -7500403 true true 75 60 75 90 165 75 210 90 210 120 195 135 165 165 120 195 75 225 75 225 75 240 75 255 90 255 150 255 195 255 210 255 240 255 240 225 165 225 225 165 255 135 255 105 240 60 225 45 195 45 120 45 75 60

a
true
15
Polygon -16777216 true false 120 60 135 45
Polygon -1 true true 120 30 75 225 120 225 135 165 165 165 180 225 225 225 180 30 120 30

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

ball baseball
false
0
Circle -7500403 true true 30 30 240
Polygon -2674135 true false 247 79 243 86 237 106 232 138 232 167 235 199 239 215 244 225 236 234 229 221 224 196 220 163 221 138 227 102 234 83 240 71
Polygon -2674135 true false 53 79 57 86 63 106 68 138 68 167 65 199 61 215 56 225 64 234 71 221 76 196 80 163 79 138 73 102 66 83 60 71
Line -2674135 false 241 149 210 149
Line -2674135 false 59 149 90 149
Line -2674135 false 241 171 212 176
Line -2674135 false 246 191 218 203
Line -2674135 false 251 207 227 226
Line -2674135 false 251 93 227 74
Line -2674135 false 246 109 218 97
Line -2674135 false 241 129 212 124
Line -2674135 false 59 171 88 176
Line -2674135 false 59 129 88 124
Line -2674135 false 54 109 82 97
Line -2674135 false 49 93 73 74
Line -2674135 false 54 191 82 203
Line -2674135 false 49 207 73 226

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

cannon
true
0
Polygon -7500403 true true 165 0 165 15 180 150 195 165 195 180 180 195 165 225 135 225 120 195 105 180 105 165 120 150 135 15 135 0
Line -16777216 false 120 150 180 150
Line -16777216 false 120 195 180 195
Line -16777216 false 165 15 135 15
Polygon -16777216 false false 165 0 135 0 135 15 120 150 105 165 105 180 120 195 135 225 165 225 180 195 195 180 195 165 180 150 165 15

cannon base left
true
0
Line -7500403 true 165 60 195 210
Polygon -16777216 true false 161 94 185 78 214 183 186 198 163 92
Polygon -16777216 true false 285 195 255 180 195 210 225 225 285 195
Polygon -16777216 true false 255 180 285 195 240 60 207 39 255 180 285 195
Polygon -16777216 true false 208 34 208 34 166 59 196 209 256 179 210 39
Line -7500403 true 207 38 255 180
Line -7500403 true 285 195 255 180
Line -7500403 true 285 195 243 60
Line -7500403 true 240 60 203 37
Line -7500403 true 204 36 165 60
Line -7500403 true 195 210 255 180
Line -7500403 true 195 210 225 225
Line -7500403 true 225 225 285 195
Polygon -7500403 false true 163 90 184 76 214 181 184 196 161 92
Polygon -16777216 true false 185 197 214 182 228 188 205 202 189 195
Line -7500403 true 213 180 224 185
Line -7500403 true 188 196 199 200
Line -7500403 true 226 186 194 83
Line -7500403 true 186 80 194 82

cannon base right
true
0
Line -7500403 true 135 60 105 210
Polygon -16777216 true false 139 94 115 78 86 183 114 198 137 92
Polygon -16777216 true false 15 195 45 180 105 210 75 225 15 195
Polygon -16777216 true false 45 180 15 195 60 60 93 39 45 180 15 195
Polygon -16777216 true false 92 34 92 34 134 59 104 209 44 179 90 39
Line -7500403 true 93 38 45 180
Line -7500403 true 15 195 45 180
Line -7500403 true 15 195 57 60
Line -7500403 true 60 60 97 37
Line -7500403 true 96 36 135 60
Line -7500403 true 105 210 45 180
Line -7500403 true 105 210 75 225
Line -7500403 true 75 225 15 195
Polygon -7500403 false true 137 90 116 76 86 181 116 196 139 92
Polygon -16777216 true false 115 197 86 182 72 188 95 202 111 195
Line -7500403 true 87 180 76 185
Line -7500403 true 112 196 101 200
Line -7500403 true 74 186 106 83
Line -7500403 true 114 80 106 82

cannon carriage
false
0
Circle -7500403 false true 105 105 90
Circle -7500403 false true 90 90 120
Line -7500403 true 180 120 120 180
Line -7500403 true 120 120 180 180
Line -7500403 true 150 105 150 195
Line -7500403 true 105 150 195 150
Polygon -7500403 false true 0 195 0 210 180 150 180 135

cannon-left
true
3
Polygon -16777216 true false 142 197 124 129 164 115 195 180 142 198
Polygon -7500403 true false 176 136
Polygon -7500403 true false 177 149 128 26 113 26 117 163 176 167
Line -16777216 false 126 29 164 137
Line -16777216 false 120 25 150 134
Line -16777216 false 113 34 124 151
Line -16777216 false 114 42 135 151
Polygon -6459832 true true 115 162 119 173 123 174 131 178 140 181 152 181 165 177 175 174 180 161 174 149 166 137 150 135 136 137 124 146 116 165
Polygon -7500403 true false 155 157
Polygon -16777216 true false 189 148

cannon-right
true
3
Polygon -16777216 true false 158 197 176 129 136 115 105 180 158 198
Polygon -7500403 true false 124 136
Polygon -7500403 true false 123 149 172 26 187 26 183 163 124 167
Line -16777216 false 174 29 136 137
Line -16777216 false 180 25 150 134
Line -16777216 false 187 34 176 151
Line -16777216 false 186 42 165 151
Polygon -6459832 true true 185 162 181 173 177 174 169 178 160 181 148 181 135 177 125 174 120 161 126 149 134 137 150 135 164 137 176 146 184 165
Polygon -7500403 true false 145 157
Polygon -16777216 true false 111 148

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

dased
true
0
Polygon -1184463 false false 135 120 92 119 81 156 92 171 119 193 158 199 215 198 240 175 240 137 217 115 162 112 133 127 116 155 128 184 169 181 185 174 200 155 194 134 158 143 163 152
Polygon -1184463 true false 81 100 75 127 54 133 77 141 77 168 90 144 111 147 96 131 111 110 89 118 82 104
Polygon -1184463 true false 231 93 225 120 204 126 227 134 227 161 240 137 261 140 246 124 261 103 239 111 232 97
Polygon -1184463 true false 174 166 168 193 147 199 170 207 170 234 183 210 204 213 189 197 204 176 182 184 175 170

dot
false
0
Circle -7500403 true true 90 90 120

e
true
0
Polygon -7500403 true true 105 60 195 60 195 90 135 90 135 135 195 135 195 135 195 165 135 165 135 195 195 195 195 225 105 225 105 60

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

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

i
true
0
Polygon -7500403 true true 105 60 105 90 135 90 135 180 105 180 105 210 195 210 195 180 165 180 165 90 165 90 195 90 195 60 105 60

l
true
15
Rectangle -1 true true 90 45 135 240
Rectangle -1 true true 90 195 195 240

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

n
true
0
Polygon -7500403 true true 90 210 120 90 150 90 165 165 195 90 225 90 180 210 150 210 135 150 120 210 75 210

p
true
14
Rectangle -16777216 true true 90 60 120 240
Rectangle -16777216 true true 90 60 195 90
Rectangle -16777216 true true 165 60 195 150
Rectangle -16777216 true true 90 135 195 165

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

r
true
0
Polygon -7500403 true true 90 45 90 255 120 255 120 180 180 255 210 225 150 165 150 150 180 150 195 135 210 120 225 105 225 75 210 60 180 45 90 45

s
true
0
Polygon -7500403 true true 149 61 205 66 207 90 224 91 157 89 129 99 130 133 176 147 200 162 216 195 209 226 194 241 179 241 149 241 104 241 104 211 176 212 185 207 173 183 149 181 149 181 117 165 98 136 99 104 108 76 123 66 149 61

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

shoottreegreen
false
0
Rectangle -7500403 true true 120 45 180 255
Circle -10899396 true false 165 90 120

shoottreered
false
0
Rectangle -7500403 true true 120 45 180 255
Circle -2674135 true false 15 90 120

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

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

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

w
true
0
Polygon -7500403 true true 81 75 111 75 126 150 141 105 156 105 171 150 186 75 216 75 186 180 156 180 149 149 141 180 111 180 81 75

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

y
true
15
Polygon -1 true true 90 60 135 60 150 120 165 60 210 60 165 165 165 240 135 240 135 165 90 60
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
