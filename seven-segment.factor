! Copyright (C) 2015 Joseph Moschini
! Copyright (C) 2015 forthnutter
! See http://factorcode.org/license.txt for BSD license.


USING: accessors kernel opengl opengl.demo-support opengl.gl ui ui.gadgets
       ui.gadgets.packs ui.render tools.walker tools.continuations sequences ;

IN: seven-segment

TUPLE: seven-seg-gadget < gadget a b c d e f g dp ;

! main segment shape
CONSTANT: SEGMENT-SHAPE-1 {
    { -0.5 0.5 0.0 } { 0.5 0.5 0.0 } { 1.0 0.0 0.0 }
    { 0.5 -0.5 0.0 } { -0.5 -0.5 0.0 } { -1.0 0.0 0.0 } }


: <seven-seg-gadget> ( -- gadget )
    seven-seg-gadget new
    t >>clipped?
    { 200 200 } >>pref-dim ;


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


    { 5 20 } 
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

    { 15 30 } 
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


: draw-seg ( -- )

    draw-seg-a
    draw-seg-b
    draw-seg-c
    draw-seg-d
    draw-seg-e
!    draw-seg-f
!    draw-seg-g
!    draw-seg-dp
;

M: seg-gadget draw-gadget* ( seg-gadget -- )
   draw-seg drop ;


: start-gadgets ( -- gadget )
    <shelf>
    <seven-seg-gadget>
    add-gadget ;

MAIN-WINDOW: test { { title "TEST" } }
    start-gadgets >>gadgets ;



