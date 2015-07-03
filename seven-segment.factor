! Copyright (C) 2015 Joseph Moschini
! Copyright (C) 2015 forthnutter
! See http://factorcode.org/license.txt for BSD license.


USING: accessors kernel opengl opengl.demo-support opengl.gl opengl.debug
       ui ui.gadgets
       ui.gadgets.packs ui.render tools.walker tools.continuations sequences
       vectors prettyprint namespaces ;

IN: seven-segment


! main segment shape
CONSTANT: SEGMENT-SHAPE-1 {
    { -0.5 0.5 0.0 } { 0.5 0.5 0.0 } { 1.0 0.0 0.0 }
    { 0.5 -0.5 0.0 } { -0.5 -0.5 0.0 } { -1.0 0.0 0.0 } }


CONSTANT: SEGMENT-COLOUR { 0.0 0.0 0.0 0.5 }

TUPLE: segment colour ;

: <segment> ( -- segment )
    segment new ;

TUPLE: seven-seg-gadget < gadget vector a b c d e f g dp ;


: <seven-seg-gadget> ( -- gadget )
    seven-seg-gadget new
    t >>clipped?
    { 200 200 } >>pref-dim
    8 <vector> >>vector
    dup vector>>
! setup segment a 
    <segment> SEGMENT-COLOUR >>colour suffix
! setup segment b
    <segment> SEGMENT-COLOUR >>colour suffix
! setup segment c
    <segment> SEGMENT-COLOUR >>colour suffix
! setup segment d
    <segment> SEGMENT-COLOUR >>colour suffix
! setup segment e
    <segment> SEGMENT-COLOUR >>colour suffix
! setup segment f
    <segment> SEGMENT-COLOUR >>colour suffix
! setup segment g
    <segment> SEGMENT-COLOUR >>colour suffix
! setup segment dp
    <segment> SEGMENT-COLOUR >>colour suffix
    drop
;


M: seven-seg-gadget ungraft*
    drop ;


: draw-seg-a ( -- )
    ! A
    0.0 0.0 0.0 0.5 glColor4f
    { 15 10 } 
    [
        10.0 10.0 10.0 glScalef
        GL_POLYGON
        [
            SEGMENT-SHAPE-1
            [
                first3 glVertex3f
            ] each
        ] do-state
    ] with-translation
;

: draw-seg-b ( -- )
    { 26 21 } 
    [
        10.0 10.0 10.0 glScalef
        90.0 0.0 0.0 1.0  glRotatef
        GL_POLYGON
        [
            SEGMENT-SHAPE-1
            [
                first3 glVertex3f
            ] each
        ] do-state
    ] with-translation
;

: draw-seg-c ( -- )
    { 26 41 } 
    [
        10.0 10.0 10.0 glScalef
        90.0 0.0 0.0 1.0  glRotatef
        GL_POLYGON
        [ 
            SEGMENT-SHAPE-1
            [
                first3 glVertex3f
            ] each
        ] do-state
    ] with-translation
;

: draw-seg-d ( -- )
    { 15 51 } 
    [
        10.0 10.0 10.0 glScalef
        GL_POLYGON
        [
            SEGMENT-SHAPE-1
            [
                first3 glVertex3f
            ] each
        ] do-state
    ] with-translation
;

: draw-seg-e ( -- )
    { 4 41 } 
    [
        10.0 10.0 10.0 glScalef
        90.0 0.0 0.0 1.0  glRotatef
        GL_POLYGON
        [ 
            SEGMENT-SHAPE-1
            [
                first3 glVertex3f
            ] each
        ] do-state
    ] with-translation
;


: draw-seg-f ( -- )
    { 4 20 } 
    [
        10.0 10.0 10.0 glScalef
        90.0 0.0 0.0 1.0  glRotatef
        GL_POLYGON
        [ 
            -0.5 0.5 0.0 glVertex3f
            0.5 0.5 0.0  glVertex3f
            1.0 0.0 0.0  glVertex3f
            0.5 -0.5 0.0 glVertex3f
            -0.5 -0.5 0.0 glVertex3f
            -1.0 0.0 0.0 glVertex3f
        ] do-state
    ] with-translation
;


: draw-seg-g ( -- )

    { 15 31 } 
    [
        10.0 10.0 10.0 glScalef
        GL_POLYGON
        [ 
            -0.5 0.5 0.0 glVertex3f
            0.5 0.5 0.0  glVertex3f
            1.0 0.0 0.0  glVertex3f
            0.5 -0.5 0.0 glVertex3f
            -0.5 -0.5 0.0 glVertex3f
            -1.0 0.0 0.0 glVertex3f
        ] do-state
    ] with-translation
;

: draw-seg-dp ( -- )
;

: draw-segment ( segment -- )
    colour>> dup . first4 glColor4f
    { 15 10 } 
    [
        10.0 10.0 10.0 glScalef
        GL_POLYGON
        [
            SEGMENT-SHAPE-1
            [
                first3 glVertex3f
            ] each
        ] do-state
    ] with-translation
;


: draw-seg ( -- )

    

!    draw-seg-a
!    draw-seg-b
!    draw-seg-c
!    draw-seg-d
!    draw-seg-e
!    draw-seg-f
!    draw-seg-g
!    draw-seg-dp
;




M: seven-seg-gadget draw-gadget* ( seg-gadget -- )
   draw-seg-a
   vector>>
   [
       draw-segment 
   ] each ;


: start-gadgets ( -- gadget )
    <shelf>
    <seven-seg-gadget>
    add-gadget ;

MAIN-WINDOW: test { { title "TEST" } }
    start-gadgets >>gadgets [ drop t ] find-window G-world set ;



