; os memory map
CLRTEXT = $c050
SETTEXT = $c051
CLRMIXED = $c052
SETMIXED = $c053
TXTPAGE1 = $c054
TXTPAGE2 = $c055
CLRHIRES = $c056
SETHIRES = $c057

; Zero page locations we use (unused by Monitor, Applesoft, or ProDOS)
hgr_ptr = $06
font_ptr = $08
temp_row = $19
temp_col = $1a
text_ptr = $1b
counter = $ce
scratch_0 = $d7
start_char = $fc

    *= $6000

start
    lda #0
    sta start_char
    jsr filltext

loop
    ; copy the normal way
    lda #<slowfont
    sta copytexthgr_dest_smc+1
    lda #>slowfont
    sta copytexthgr_dest_smc+2
    jsr copytexthgr

    ; copy using the fast font traspose
    lda #<FASTFONT_H1
    sta copytexthgr_dest_smc+1
    lda #>FASTFONT_H1
    sta copytexthgr_dest_smc+2
    jsr copytexthgr

    jmp loop


copytexthgr
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
    jsr $ffff
    inx
    cpx #32
    bcc copytexthgr_src_smc
    iny
    cpy #24
    bcc copytexthgr_outer
    rts


filltext
    ldy #0    ; Loop a bit
    sty counter
ib_outer
    lda textrow_h,y
    sta text_ptr+1
    lda textrow_l,y
    sta text_ptr
    ldx start_char
    ldy #0
ib_inner
    txa
    adc #32
    sta (text_ptr),y
    inx
    iny
    cpy #40
    bcc ib_inner
    ldy counter
    iny
    sty counter
    cpy #24
    bcc ib_outer
    inc start_char ; change starting char for next time
    rts

textrow_l
        .byte $00,$80,$00,$80,$00,$80,$00,$80
        .byte $28,$A8,$28,$A8,$28,$A8,$28,$A8
        .byte $50,$D0,$50,$D0,$50,$D0,$50,$D0
textrow_h
        .byte $04,$04,$05,$05,$06,$06,$07,$07
        .byte $04,$04,$05,$05,$06,$06,$07,$07
        .byte $04,$04,$05,$05,$06,$06,$07,$07

.include fatfont.s
.include slowfont.s
.include fonttest-asmgen-driver.s
