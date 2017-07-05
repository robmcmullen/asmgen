; os memory map
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
scratch_col   .ds 1

    *= $0020
; required variables for HiSprite
bgstore       .ds 2
damage_w      .ds 1
damage_h      .ds 1
damageptr     .ds 2
damageindex   .ds 1
damageptr1    .ds 2
damageindex1  .ds 1
damageptr2    .ds 2
damageindex2  .ds 1
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


DAMAGEPAGE1 = $bf       ; page number of first byte beyond top of backing store stack
DAMAGEPAGE2 = $be

; constants
MAXPOSX                 = 250
MAXPOSY                 = 192 - 16


    *= $6000

start
    bit CLRTEXT     ; start with HGR page 1, full screen
    bit CLRMIXED
    bit TXTPAGE2
    bit SETHIRES

    jsr clrscr
    jsr initonce
    jsr initsprites
    jsr initbackground

gameloop
    jsr renderstart
    jsr pageflip
    jsr movestart
    dec fasttoggle
    bpl gofast
    jsr wait
gofast
    jsr restorebg_driver
    jmp gameloop

fasttoggle
    .byte 0


initonce
    lda #0
    sta drawpage
    sta damageindex1
    sta damageindex2
    sta damageptr
    sta damageptr1
    sta damageptr2
    lda #damagepage1
    sta damageptr+1
    sta damageptr1+1
    sta damageptr2+1
    rts


initsprites
    jsr restorebg_init
    rts

initbackground
    jsr filltext
    jsr pageflip
    bit TXTPAGE1
    jsr copytexthgr
    jsr copytexthgrslow
    jsr copytexthgr
    jsr copytexthgrslow
    jsr copytexthgr
    jsr pageflip
    jsr copytexthgr
    rts


filltext
    ldy #0    ; Loop a bit
    sty COUNTER1
ib_outer
    lda textrow_h,y
    ora #4
    sta textptr+1
    lda textrow_l,y
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


copytexthgr
    lda HGRSELECT
    beq copytexthgr_page1
    ldx #<FASTFONT_H2
    ldy #>FASTFONT_H2
    bne copytexthgr_store_dest    ; always true: hi byte of subroutine is > 0
copytexthgr_page1    ldx #<FASTFONT_H1
    ldy #>FASTFONT_H1
copytexthgr_store_dest
    stx copytexthgr_dest_smc+1
    sty copytexthgr_dest_smc+2
    ldy #0      ; y is rows
copytexthgr_outer
    lda textrow_h,y
    ora #4
    sta copytexthgr_src_smc+2
    lda textrow_l,y
    sta copytexthgr_src_smc+1
    ldx #0      ; x is columns
copytexthgr_src_smc
    lda $ffff,x
copytexthgr_dest_smc
    jsr FASTFONT_H1
    inx
    cpx #40
    bcc copytexthgr_src_smc
    iny
    cpy #24
    bcc copytexthgr_outer
    rts

copytexthgrslow
     LDA #0
     STA temprow

?1   LDY temprow        ; Y = row
     CPY #24        ; 24 rows is #$18
     BCS ?3         ; Y >= 24
     LDX #0
     STX tempcol        ; X = col
     JSR SetCursorColRow
     and ~10011111
     clc            ; A = HgrHiY[ row ]
     adc #4       ; Convert HgrHiY to TextHiY byte
     STA TEXTPTR+1      ; A -= 0x1C -> TxtHi
     LDA hgrptr     ; A = HgrLoY[ row ]
     STA TEXTPTR    ;           -> TxtLo
     LDY tempcol
?2   LDA (TEXTPTR),Y
     AND #$7F
     JSR DrawCharCol
     CPY #$28       ; 40 cols is #$28
     BCC ?2         ; Y < 40
     INC temprow
     BNE ?1         ; always
?3   RTS

    rts


pageflip
    lda drawpage
    eor #$80
    sta drawpage
    bpl pageflip1   ; pos = show 1, draw 2; neg = show 1, draw 1
    bit TXTPAGE2    ; show page 2, work on page 1
    lda #$00
    sta hgrselect
    lda #$20
    sta hgrhi
    lda damageptr   ; save other page's damage pointer
    sta damageptr2
    lda damageptr1
    sta damageptr
    lda damageptr1+1
    sta damageptr+1
    lda damageindex1
    sta damageindex
    rts
pageflip1
    bit TXTPAGE1    ; show page 1, work on page 2
    lda #$60
    sta hgrselect
    lda #$40
    sta hgrhi
    lda damageptr   ; save other page's damage pointer
    sta damageptr1
    lda damageptr2
    sta damageptr
    lda damageptr2+1
    sta damageptr+1
    lda damageindex2
    sta damageindex
    rts


restorebg_init
    rts

restorebg_driver
    ; copy damaged characters back to screen
    rts



; Draw sprites by looping through the list of sprites
renderstart
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

; put the same info on both screens
clrscr2
    ldy #1
clrouter
    ldx #0
clrloop
    lda HGRROWS_H1,x
    sta scratch_addr+1
    lda HGRROWS_H2,x
    sta scratch_ptr+1
    lda HGRROWS_L,x
    sta scratch_addr
    sta scratch_ptr
    lda tophalf,y
    cpx #96
    bcc clrwrite
    lda bothalf,y
clrwrite
    sta (scratch_addr),y
    sta (scratch_ptr),y
    inx
    cpx #192
    bcc clrloop
    iny
    cpy #40
    bcs clrend
    bne clrouter
clrend
    rts

tophalf
    .byte 0
    .byte $88, ~01010101, ~00101010, ~01010101, ~00101010, ~01010101
    .byte $08, ~00101010, ~01010101, ~00101010, ~01010101, ~00101010
    .byte $10, ~01010101, ~00101010, ~01010101, ~00101010, ~01010101
    .byte $1c, ~00101010, ~01010101, ~00101010, ~01010101, ~00101010
    .byte $88, ~01010101, ~00101010, ~01010101, ~00101010, ~01010101
    .byte $9c, ~01010101, ~00101010, ~01010101, ~00101010, ~01010101
    .byte $9c, ~00101010, ~01010101, ~00101010, ~01010101, ~00101010
    .byte $1c, ~01010101, ~00101010, ~01010101, ~00101010, ~01010101

bothalf
    .byte 0
    .byte $9c, ~11010101, ~10101010, ~11010101, ~10101010, ~11010101
    .byte ~10001000, ~10101010, ~11010101, ~10101010, ~11010101, ~10101010
    .byte ~00010000, ~11010101, ~10101010, ~11010101, ~10101010, ~11010101
    .byte $08, ~10101010, ~11010101, ~10101010, ~11010101, ~10101010
    .byte $9c, ~11010101, ~10101010, ~11010101, ~10101010, ~11010101
    .byte $9c, ~11010101, ~10101010, ~11010101, ~10101010, ~11010101
    .byte $88, ~11010101, ~10101010, ~11010101, ~10101010, ~11010101
    .byte $08, ~10101010, ~11010101, ~10101010, ~11010101, ~10101010



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
    .byte <APPLE_SPRITE9X11, <APPLE_SPRITE9X11, <APPLE_SPRITE9X11, <APPLE_SPRITE9X11, <APPLE_SPRITE9X11, <APPLE_SPRITE9X11, <MOLDY_BURGER, <MOLDY_BURGER

sprite_h
    .byte >APPLE_SPRITE9X11, >APPLE_SPRITE9X11, >APPLE_SPRITE9X11, >APPLE_SPRITE9X11, >APPLE_SPRITE9X11, >APPLE_SPRITE9X11, >MOLDY_BURGER, >MOLDY_BURGER

sprite_x
    .byte 80, 164, 33, 245, 4, 9, 255, 18

sprite_y
    .byte 116, 126, 40, 60, 80, 100, 120, 140

sprite_dx
    .byte 1, 2, 3, 4, 1, 2, 3, 4

sprite_dirx
    .byte -1, -1, -1, -1, 1, 1, 1, 1

sprite_dy
    .byte 4, 3, 2, 1, 4, 3, 2, 1

sprite_diry
    .byte 1, 1, 1, 1, -1, -1, -1, -1



.include cpbg-sprite-driver.s
.include drawfont.s
.include fatfont.s
