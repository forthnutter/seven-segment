! Copyright (C) 2015 Joseph Moschini
! Copyright (C) 2015 forthnutter
! See http://factorcode.org/license.txt for BSD license.


USING: accessors kernel opengl opengl.demo-support opengl.gl opengl.debug
       ui ui.gadgets io models
       ui.gadgets.packs ui.render tools.walker tools.continuations sequences
       vectors prettyprint namespaces ;

IN: seven-segment


! main segment shape
CONSTANT: SEGMENT-SHAPE-1 {
    { -0.5 0.5 0.0 } { 0.5 0.5 0.0 } { 1.0 0.0 0.0 }
    { 0.5 -0.5 0.0 } { -0.5 -0.5 0.0 } { -1.0 0.0 0.0 } }

CONSTANT: DP-SHAPE-1 {
    { -1.0 1.0 0.0 } { -0.5 1.0 0.0 } { 0.0 1.5 0.0 }
    { 0.5 1.0 0.0 } { 1.0 1.0 0.0 } { 1.0 0.5 0.0 }
    { 1.5 0.0 0.0 } { 1.0 -0.5 0.0 } { 1.0 -1.0 0.0 }
    { 0.5 -1.0 0.0 } { 0.0 -1.5 0.0 } { -0.5 -1.0 0.0 }
    { -1.0 -1.0 0.0 } { -1.0 -0.5 0.0 } { -1.5 0.0 0.0 }
    { -1.0 0.5 0.0 } }


CONSTANT: SEGMENT-COLOUR { 0.0 0.0 0.0 0.5 }
CONSTANT: SEGMENT-SCALE { 10.0 10.0 10.0 }
CONSTANT: DP-SCALE { 2.5 2.5 2.5 }

CONSTANT: SEGMENT-A-POS { 18 10 }
CONSTANT: SEGMENT-B-POS { 29 21 }
CONSTANT: SEGMENT-C-POS { 29 41 } 
CONSTANT: SEGMENT-D-POS { 18 51 } 
CONSTANT: SEGMENT-E-POS { 7 41 }
CONSTANT: SEGMENT-F-POS { 7 20 } 
CONSTANT: SEGMENT-G-POS { 18 31 } 
CONSTANT: SEGMENT-DP-POS { 33 55 }

CONSTANT: SEGMENT-A-ROT { 0.0 0.0 0.0 1.0 }
CONSTANT: SEGMENT-B-ROT { 90.0 0.0 0.0 1.0 }
CONSTANT: SEGMENT-C-ROT { 90.0 0.0 0.0 1.0 }
CONSTANT: SEGMENT-D-ROT { 0.0 0.0 0.0 1.0 }
CONSTANT: SEGMENT-E-ROT { 90.0 0.0 0.0 1.0 }
CONSTANT: SEGMENT-F-ROT { 90.0 0.0 0.0 1.0 }
CONSTANT: SEGMENT-G-ROT { 0.0 0.0 0.0 1.0 }
CONSTANT: SEGMENT-DP-ROT { 90.0 0.0 0.0 1.0 }

TUPLE: segment colour pos scale rotation ;
TUPLE: dpoint colour pos scale rotation ;

GENERIC: sdraw ( object -- )

: <segment> ( -- segment )
    segment new ;

M: segment sdraw
    GL_POLYGON
    [
        SEGMENT-SHAPE-1
        [
            first3 glVertex3f
        ] each
    ] do-state
    drop
;

: <dpoint> ( -- dp )
    dpoint new ;

M: dpoint sdraw
    GL_POLYGON
    [
        DP-SHAPE-1
        [
            first3 glVertex3f
        ] each
    ] do-state
    drop
;

TUPLE: seven-seg-gadget < gadget vector ;



: <seven-seg-gadget> ( -- gadget )
    seven-seg-gadget new
    t >>clipped?
    { 35 60 } >>pref-dim
    0 <model> >>model
    8 <vector> >>vector
    dup vector>> 
! setup segment a bit 0
    <segment>
        SEGMENT-COLOUR >>colour
        SEGMENT-A-POS  >>pos
        SEGMENT-SCALE  >>scale
        SEGMENT-A-ROT  >>rotation
        suffix!
! setup segment b
    <segment>
        SEGMENT-COLOUR >>colour
        SEGMENT-B-POS  >>pos
        SEGMENT-SCALE  >>scale
        SEGMENT-B-ROT  >>rotation
        suffix!
! setup segment c
    <segment>
        SEGMENT-COLOUR >>colour
        SEGMENT-C-POS  >>pos
        SEGMENT-SCALE  >>scale
        SEGMENT-C-ROT  >>rotation
        suffix!
! setup segment d
    <segment>
        SEGMENT-COLOUR >>colour
        SEGMENT-D-POS  >>pos
        SEGMENT-SCALE  >>scale
        SEGMENT-D-ROT  >>rotation
        suffix!
! setup segment e
    <segment>
        SEGMENT-COLOUR >>colour
        SEGMENT-E-POS  >>pos
        SEGMENT-SCALE  >>scale
        SEGMENT-E-ROT  >>rotation
        suffix!
! setup segment f
    <segment>
        SEGMENT-COLOUR >>colour
        SEGMENT-F-POS  >>pos
        SEGMENT-SCALE  >>scale
        SEGMENT-F-ROT  >>rotation
        suffix!
! setup segment g
    <segment>
        SEGMENT-COLOUR >>colour
        SEGMENT-G-POS  >>pos
        SEGMENT-SCALE  >>scale
        SEGMENT-G-ROT  >>rotation
        suffix!
! setup dp
    <dpoint>
        SEGMENT-COLOUR >>colour
        SEGMENT-DP-POS  >>pos
        DP-SCALE  >>scale
        SEGMENT-DP-ROT >>rotation
        suffix!

    drop
;


M: seven-seg-gadget ungraft*
    drop ;


: draw-seven-segment ( segment -- )
    [ colour>> first4 glColor4f ] keep
    dup pos>> 
    [
        [ scale>> first3 glScalef ] keep
        [ rotation>> first4 glRotatef ] keep
        [ sdraw ] keep drop

    ] with-translation
;




M: seven-seg-gadget draw-gadget* ( seg-gadget -- )
   vector>>
   [
       draw-seven-segment 
   ] each ;


: start-gadgets ( -- gadget )
    <shelf>
    <seven-seg-gadget>
    add-gadget
    <seven-seg-gadget>
    add-gadget 
    <seven-seg-gadget>
    add-gadget
;

MAIN-WINDOW: seven { { title "TEST" } }
    start-gadgets >>gadgets ;



