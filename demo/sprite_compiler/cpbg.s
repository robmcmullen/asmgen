; os memory map
KEYBOARD = $c000
KBDSTROBE = $c010
CLRTEXT = $c050
SETTEXT = $c051
CLRMIXED = $c052
SETMIXED = $c053
TXTPAGE1 = $c054
TXTPAGE2 = $c055
CLRHIRES = $c056
SETHIRES = $c057

; ROM entry points
COUT = $fded
ROMWAIT = $fca8

; Zero page locations. Using the whole thing because we aren't using any
; ROM routines

    *= $0006
; parameters: these should not be changed by child subroutines
param_x   .ds 1
param_y   .ds 1
param_col   .ds 1
param_row   .ds 1
param_index .ds 1
param_count .ds 1

    *= $0010
; scratch areas: these may be modified by child subroutines
scratch_addr  .ds 2
scratch_ptr   .ds 2
scratch_0     .ds 1
scratch_1     .ds 1
scratch_index .ds 1
scratch_count .ds 1
scratch_col   .ds 1

    *= $0020
; required variables for HiSprite
damageindex   .ds 1
damageindex1  .ds 1
damageindex2  .ds 1
bgstore       .ds 2
damage_w      .ds 1
damage_h      .ds 1
damageptr     .ds 2
damageptr1    .ds 2
damageptr2    .ds 2
hgrhi         .ds 1    ; either $20 or $40, the base of each hgr screen
hgrselect     .ds 1    ; either $00 or $60, used as xor mask for HGRROWS_H1

    *= $0030
; global variables for this program
rendercount   .ds 1
drawpage      .ds 1      ; pos = page1, neg = page2
tempaddr      .ds 2
counter1      .ds 1
textptr       .ds 2
hgrptr        .ds 2
temprow       .ds 1
tempcol       .ds 1


; constants

DAMAGEPAGE1 = $bf   ; page number of damage list for screen 1
DAMAGEPAGE2 = $be   ;   "" for screen 2
MAXPOSX     = 220
MAXPOSY     = 192 - 16

; debug flags


    *= $6000

start
    bit CLRTEXT     ; start with HGR page 1, full screen
    bit CLRMIXED
    bit TXTPAGE2
    bit SETHIRES

    jsr initonce
    jsr initsprites
    jsr initbackground

gameloop
    jsr renderstart
    jsr pageflip
    jsr userinput
    jsr movestart
    jsr restorebg_driver
    jsr wait
    jmp gameloop

restorebg_init
    rts

restorebg_driver
    ; copy damaged characters back to screen
    ;jsr copytexthgr
    ldy #0
    sty param_count
restorebg_loop1 ldy param_count
    cpy damageindex
    bcc restorebg_cont  ; possible there's no damage, so have to check first
    ldy #0
    sty damageindex  ; clear damage index for this page
    rts
restorebg_cont lda (damageptr),y ; groups of 4 x1 -> x2, y1 -> y2
    sta param_x
    iny
    lda (damageptr),y
    sta param_col
    iny
    lda (damageptr),y
    sta param_y
    iny
    lda (damageptr),y
    sta param_row
    iny
    sty param_count

    ldy param_y
restorebg_row lda textrows_h,y
    sta restorebg_row_smc+2
    lda textrows_l,y
    sta restorebg_row_smc+1
    ldx param_x
restorebg_row_smc lda $ffff,x
    jsr fastfont
    inx
    cpx param_col
    bcc restorebg_row_smc
    iny
    cpy param_row
    beq restorebg_row
    bcc restorebg_row
    bcs restorebg_loop1

userinput
    lda KEYBOARD
    pha
    ldx #38
    ldy #0
    jsr printhex
    pla
    bmi ?1

    ; stop movement of player if no direction input
    lda #0
    tax
    sta sprite_dx,x
    lda #0
    sta sprite_dy,y

    rts
?1
    ; setting the keyboard strobe causes the key to enter repeat mode if held
    ; down, which causes a pause after the initial movement. Not setting the
    ; strobe allows smooth movement from the start, but there's no way to stop
    ;sta KBDSTROBE
    ldx #0

check_up cmp #$8d  ; up arrow
    beq input_up
    cmp #$c9  ; I
    bne check_down
input_up lda #-1
    sta sprite_diry,x
    lda #0
    sta sprite_dx,x
    lda #1
    sta sprite_dy,y
    rts

check_down cmp #$af  ; down arrow
    beq input_down
    cmp #$d4  ; K
    bne check_left
input_down lda #1
    sta sprite_diry,x
    lda #0
    sta sprite_dx,x
    lda #1
    sta sprite_dy,y
    rts

check_left cmp #$88  ; left arrow
    beq input_left
    cmp #$c8  ; J
    bne check_right
input_left lda #-1
    sta sprite_dirx,x
    lda #1
    sta sprite_dx,x
    lda #0
    sta sprite_dy,y
    rts

check_right cmp #$95  ; right arrow
    beq input_right
    cmp #$ce  ; L
    bne input_not_movement
input_right lda #1
    sta sprite_dirx,x
    lda #1
    sta sprite_dx,x
    lda #0
    sta sprite_dy,y
    rts

input_not_movement lda #0
    sta sprite_dx,x
    lda #0
    sta sprite_dy,y

check_special cmp #$80 + 32
    beq input_space
    cmp #$80 + '.'
    beq input_period
    cmp #$80 + 'P'
    beq input_period
    rts

input_space
    jmp debugflipscreens

input_period
    jsr wait
    lda KEYBOARD
    bpl input_period
    cmp #$80 + 'P'
    beq input_period
    rts

debugflipscreens
    lda #20
    sta scratch_count
debugloop
    jsr pageflip
    jsr wait
    jsr pageflip
    jsr wait
    dec scratch_count
    bne debugloop
    rts

printhex ; A = hex byte, X = column, Y = row; A is clobbered, X&Y are not
    pha
    stx param_x
    lsr
    lsr
    lsr
    lsr
    tax
    lda hexdigit,x
    ldx param_x
    jsr fastfont
    pla
    and #$0f
    tax
    lda hexdigit,x
    ldx param_x
    inx
    jsr fastfont
    rts

hexdigit .byte "0123456789ABCDEF"



initonce
    lda #0
    sta KBDSTROBE
    sta drawpage
    sta damageindex1
    sta damageindex2
    sta damageptr
    sta damageptr1
    sta damageptr2
    lda #damagepage1
    sta damageptr+1
    sta damageptr1+1
    lda #damagepage2
    sta damageptr2+1
    jsr draw_to_page1
    rts


initsprites
    jsr restorebg_init
    rts

initbackground
    jsr show_page1
    jsr filltext
    jsr copytexthgr  ; page2 becomes the source
    jsr wipeclear1
    jsr wipe2to1

;    jsr pageflip
;    jsr copytexthgr
;    jsr pageflip
;    jsr copytexthgr
    rts


filltext
    ldy #0    ; Loop a bit
    sty COUNTER1
ib_outer
    lda textrows_h,y
    sta textptr+1
    lda textrows_l,y
    sta textptr
    tya
    adc #32
    ldx #0
    ldy #0
ib_inner
    sta (textptr),y
    adc #1
    inx
    iny
    cpy #40
    bcc ib_inner
    ldy counter1
    iny
    sty counter1
    cpy #24
    bcc ib_outer
    rts


wipeclear1 ldy #0
    sty param_y
wipeclear1_loop lda HGRROWS_L,y
    sta wipeclear1_save_smc+1
    lda HGRROWS_H1,y
    sta wipeclear1_save_smc+2
    ldx #39
    lda #$ff
wipeclear1_save_smc sta $ffff,x
    dex
    bpl wipeclear1_save_smc
    ldx #0
wipeclear1_wait nop
    nop
    nop
    nop
    nop
    nop
    dex
    bne wipeclear1_wait
    inc param_y
    ldy param_y
    cpy #192
    bcc wipeclear1_loop
    rts

wipe2to1 ldy #0
    sty param_y
wipe2to1_loop lda HGRROWS_H2,y
    sta wipe2to1_load_smc+2
    lda HGRROWS_L,y
    sta wipe2to1_load_smc+1
    sta wipe2to1_save_smc+1
    lda HGRROWS_H1,y
    sta wipe2to1_save_smc+2
    ldx #39
wipe2to1_load_smc lda $ffff,x
wipe2to1_save_smc sta $ffff,x
    dex
    bpl wipe2to1_load_smc
    ldx #0
wipe2to1_wait nop
    nop
    nop
    nop
    nop
    nop
    dex
    bne wipe2to1_wait
    inc param_y
    ldy param_y
    cpy #192
    bcc wipe2to1_loop
    rts



copytexthgr
    ldy #0      ; y is rows
copytexthgr_outer
    lda textrows_h,y
    ora #4
    sta copytexthgr_src_smc+2
    lda textrows_l,y
    sta copytexthgr_src_smc+1
    ldx #0      ; x is columns
copytexthgr_src_smc
    lda $ffff,x
copytexthgr_dest_smc
    jsr $ffff
    inx
    cpx #32
    bcc copytexthgr_src_smc
    iny
    cpy #24
    bcc copytexthgr_outer
    rts

pageflip
    lda drawpage
    eor #$80
    bpl show_page1   ; pos = show 1, draw 2; neg = show 1, draw 1

show_page2 lda #$80
    sta drawpage
    bit TXTPAGE2 ; show page 2, work on page 1
draw_to_page1 lda #$00
    sta hgrselect
    lda #$20
    sta hgrhi
    lda damageindex   ; save other page's damage pointer
    sta damageindex2

    lda #DAMAGEPAGE1  ; point to page 1's damage area
    sta damageptr+1
    lda damageindex1
    sta damageindex

    ; copy addresses for functions that write to one page or the other
    lda #<FASTFONT_H1
    sta fastfont+1
    sta copytexthgr_dest_smc+1
    lda #>FASTFONT_H1
    sta fastfont+2
    sta copytexthgr_dest_smc+2
    rts

show_page1 lda #0
    sta drawpage
    bit TXTPAGE1 ; show page 1, work on page 2
draw_to_page2 lda #$60
    sta hgrselect
    lda #$40
    sta hgrhi
    lda damageindex   ; save other page's damage pointer
    sta damageindex1

    lda #DAMAGEPAGE2  ; point to page 2's damage area
    sta damageptr+1
    lda damageindex2
    sta damageindex
    lda #<FASTFONT_H2
    sta fastfont+1
    sta copytexthgr_dest_smc+1
    lda #>FASTFONT_H2
    sta fastfont+2
    sta copytexthgr_dest_smc+2
    rts

; pageflip jump tables. JSR to one of these jumps and it will jump to the 
; correct version for the page. The rts in there will return to the caller

fastfont jmp $ffff



; Draw sprites by looping through the list of sprites
renderstart
    ldy #0
    sty damageindex

    lda #sprite_l - sprite_active
    sta param_count
    inc renderroundrobin_smc+1

renderroundrobin_smc
    ldy #0
    sty param_index

renderloop
    lda param_index
    and #sprite_l - sprite_active - 1
    tay
    lda sprite_active,y
    beq renderskip      ; skip if zero
    lda sprite_l,y
    sta jsrsprite_smc+1
    lda sprite_h,y
    sta jsrsprite_smc+2
    lda sprite_x,y
    sta param_x
    lda sprite_y,y
    sta param_y
    jmp jsrsprite_smc
jsrsprite_smc
    jsr $ffff           ; wish you could JSR ($nnnn)

    ldy damageindex
    lda scratch_col      ; contains the byte index into the line
    sta (damageptr),y
    iny
    clc
    adc damage_w
    sta (damageptr),y
    iny

    ; need to convert hgr y values to char rows
    lda param_y
    lsr a
    lsr a
    lsr a
    sta (damageptr),y
    iny
    lda param_y
    clc
    adc damage_h
    lsr a
    lsr a
    lsr a
    sta (damageptr),y
    iny
    sty damageindex

renderskip
    inc param_index
    dec param_count
    bne renderloop

renderend
    rts


movestart
    lda #sprite_l - sprite_active
    sta param_count
    ldy #0

moveloop
    lda sprite_active,y
    bmi moveend
    beq movenext

movex
    ; Apply X velocity to X coordinate
    lda sprite_dirx,y
    bpl move_right
    sec
    lda sprite_x,y
    sbc sprite_dx,y
    cmp #MAXPOSX
    bcc movex_end
    lda #1
    sta sprite_dirx,y
    lda #0
    sta sprite_x,y
    bpl movey

move_right
    clc
    lda sprite_x,y
    adc sprite_dx,y
    cmp #MAXPOSX
    bcc movex_end
    lda #-1
    sta sprite_dirx,y
    lda #MAXPOSX

movex_end
    ; Store the new X
    sta sprite_x,y

movey
    ; Apply Y velocity to Y coordinate
    lda sprite_diry,y
    bpl move_down
    sec
    lda sprite_y,y
    sbc sprite_dy,y
    cmp #MAXPOSY        ; checking wraparound
    bcc movey_end       ; less than => not wrapped
    lda #1
    sta sprite_diry,y
    lda #0
    sta sprite_y,y
    bpl movenext

move_down
    clc
    lda sprite_y,y
    adc sprite_dy,y
    cmp #MAXPOSY
    bcc movey_end
    lda #-1
    sta sprite_diry,y
    lda #MAXPOSY

movey_end
    ; Store the new X
    sta sprite_y,y

movenext
    iny
    dec param_count
    bne moveloop

moveend
    rts



wait
    ldy     #$06    ; Loop a bit
wait_outer
    ldx     #$ff
wait_inner
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    dex
    bne     wait_inner
    dey
    bne     wait_outer
    rts


clrscr
    lda #0
    sta clr1+1
    sta clr2+1
    lda #$20
    sta clr1+2
    lda #$40
    sta clr2+2
clr0
    lda #0
    ldy #0
clr1
    sta $ffff,y
clr2
    sta $ffff,y
    iny
    bne clr1
    inc clr1+2
    inc clr2+2
    ldx clr1+2
    cpx #$40
    bcc clr1
    rts


; Sprite data is interleaved so a simple indexed mode can be used. This is not
; convenient to set up but makes faster accessing because you don't have to 
; increment the index register. For example, all the info about sprite #2 can
; be indexed using Y = 2 on the indexed operators, e.g. "lda sprite_active,y",
; "lda sprite_x,y", etc.
;
; Number of sprites must be a power of 2

sprite_active
    .byte 1, 1, 1, 1, 1, 1, 1, 1  ; 1 = active, 0 = skip

sprite_l
    .byte <SPRITES_APPLE_SPRITE9X11, <SPRITES_APPLE_SPRITE9X11, <SPRITES_APPLE_SPRITE9X11, <SPRITES_APPLE_SPRITE9X11, <SPRITES_APPLE_SPRITE9X11, <SPRITES_APPLE_SPRITE9X11, <SPRITES_MOLDY_BURGER, <SPRITES_MOLDY_BURGER

sprite_h
    .byte >SPRITES_APPLE_SPRITE9X11, >SPRITES_APPLE_SPRITE9X11, >SPRITES_APPLE_SPRITE9X11, >SPRITES_APPLE_SPRITE9X11, >SPRITES_APPLE_SPRITE9X11, >SPRITES_APPLE_SPRITE9X11, >SPRITES_MOLDY_BURGER, >SPRITES_MOLDY_BURGER

sprite_x
    .byte 80, 164, 33, 45, 4, 9, 180, 18

sprite_y
    .byte 116, 126, 40, 60, 80, 100, 9, 140

sprite_dx
    .byte 1, 2, 3, 4, 1, 2, 0, 1

sprite_dirx
    .byte -1, -1, -1, -1, 1, 1, 1, 1

sprite_dy
    .byte 4, 3, 2, 1, 4, 3, 1, 0

sprite_diry
    .byte 1, 1, 1, 1, -1, -1, -1, -1


textrows_l
        .byte $00, $80, $00, $80, $00, $80, $00, $80
        .byte $28, $a8, $28, $a8, $28, $a8, $28, $a8
        .byte $50, $d0, $50, $d0, $50, $d0, $50, $d0
textrows_h
        .byte $04, $04, $05, $05, $06, $06, $07, $07
        .byte $04, $04, $05, $05, $06, $06, $07, $07
        .byte $04, $04, $05, $05, $06, $06, $07, $07


.include cpbg-asmgen-driver.s
.include fatfont.s
