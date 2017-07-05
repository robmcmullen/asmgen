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

; Zero page locations we use (unused by Monitor, Applesoft, or ProDOS)
PARAM0          = $06
PARAM1          = $07
PARAM2          = $08
PARAM3          = $09
SCRATCH0        = $19
SCRATCH1        = $1a
SPRITEPTR_L     = $1b
SPRITEPTR_H     = $1c
RENDERCOUNT     = $ce
DRAWPAGE        = $d7      ; pos = page1, neg = page2
BGSTORE         = $fa
TEMPADDR        = $fc
COUNTER1        = $80
HGRHI           = $82       ; either $20 or $40, the base of each hgr screen
HGRSELECT       = $83       ; either $00 or $60, used as xor mask to turn HGRROWS_H1 into address of either page
TEXTPTR         = $84
HGRPTR          = $86
TEMPROW         = $88
TEMPCOL         = $89
DAMAGE_W        = $8a
DAMAGE_H        = $8b
DAMAGEPTR       = $8c
DAMAGEPTR1      = $8e
DAMAGEINDEX1    = $91
DAMAGEPTR2      = $92
DAMAGEINDEX2    = $94
DAMAGEINDEX     = $95
FASTFONT_SCRATCH0    = $96

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
    sta DRAWPAGE
    sta DAMAGEINDEX1
    sta DAMAGEINDEX2
    sta DAMAGEPTR
    sta DAMAGEPTR1
    sta DAMAGEPTR2
    lda #DAMAGEPAGE1
    sta DAMAGEPTR+1
    sta DAMAGEPTR1+1
    sta DAMAGEPTR2+1
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
    lda DRAWPAGE
    eor #$80
    sta DRAWPAGE
    bpl pageflip1   ; pos = show 1, draw 2; neg = show 1, draw 1
    bit TXTPAGE2    ; show page 2, work on page 1
    lda #$00
    sta HGRSELECT
    lda #$20
    sta HGRHI
    lda DAMAGEPTR   ; save other page's damage pointer
    sta DAMAGEPTR2
    lda DAMAGEPTR1
    sta DAMAGEPTR
    lda DAMAGEPTR1+1
    sta DAMAGEPTR+1
    lda DAMAGEINDEX1
    sta DAMAGEINDEX
    rts
pageflip1
    bit TXTPAGE1    ; show page 1, work on page 2
    lda #$60
    sta HGRSELECT
    lda #$40
    sta HGRHI
    lda DAMAGEPTR   ; save other page's damage pointer
    sta DAMAGEPTR1
    lda DAMAGEPTR2
    sta DAMAGEPTR
    lda DAMAGEPTR2+1
    sta DAMAGEPTR+1
    lda DAMAGEINDEX2
    sta DAMAGEINDEX
    rts


restorebg_init
    rts

restorebg_driver
    ; copy damaged characters back to screen
    rts



; Draw sprites by looping through the list of sprites
renderstart
    lda #sprite_l - sprite_active
    sta RENDERCOUNT
    inc renderroundrobin_smc+1

renderroundrobin_smc
    ldy #0
    sty PARAM3

renderloop
    lda PARAM3
    and #sprite_l - sprite_active - 1
    tay
    lda sprite_active,y
    beq renderskip      ; skip if zero
    lda sprite_l,y
    sta jsrsprite_smc+1
    lda sprite_h,y
    sta jsrsprite_smc+2
    lda sprite_x,y
    sta PARAM0
    lda sprite_y,y
    sta PARAM1
    jmp jsrsprite_smc
jsrsprite_smc
    jsr $ffff           ; wish you could JSR ($nnnn)

    ldy DAMAGEINDEX
    lda PARAM2      ; contains the byte index into the line
    sta (DAMAGEPTR),y
    iny
    clc
    adc DAMAGE_W
    sta (DAMAGEPTR),y
    iny

    ; need to convert HGR y values to char rows
    lda PARAM1
    lsr a
    lsr a
    lsr a
    sta (DAMAGEPTR),y
    iny
    lda PARAM1
    clc
    adc DAMAGE_H
    lsr a
    lsr a
    lsr a
    sta (DAMAGEPTR),y
    iny
    sty DAMAGEINDEX

renderskip
    inc PARAM3
    dec RENDERCOUNT
    bne renderloop

renderend
    rts


movestart
    lda #sprite_l - sprite_active
    sta RENDERCOUNT
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
    dec RENDERCOUNT
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
    sta SCRATCH1
    lda HGRROWS_H2,x
    sta TEMPADDR+1
    lda HGRROWS_L,x
    sta SCRATCH0
    sta TEMPADDR
    lda tophalf,y
    cpx #96
    bcc clrwrite
    lda bothalf,y
clrwrite
    sta (SCRATCH0),y
    sta (TEMPADDR),y
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
