    *= $0006

FIRST_CHAR_OF_SCREEN .ds 1
FIRST_CHAR_OF_LINE .ds 1
CURRENT_CHAR .ds 1
FRAME_COUNT .ds 1

    *= $00eb
hgr_ptr .ds 2
font_ptr .ds 2

    *= $00fa
scratch_0 .ds 1
scratch_x .ds 1
scratch_y .ds 1


    *= $5000

start_set
    jsr set_hires
    jsr clrscr
    jsr driver
    jsr set_text
    rts
    brk

driver
    lda #$00
    sta FIRST_CHAR_OF_SCREEN
    lda #64
    sta FRAME_COUNT
page_loop
    jsr page
    dec FRAME_COUNT
    bne page_loop
    rts

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


set_hires bit CLRTEXT     ; start with HGR page 1, full screen
    bit CLRMIXED
    bit TXTPAGE1
    bit SETHIRES
    rts

set_text bit SETTEXT
    bit CLRMIXED
    bit TXTPAGE1
    bit CLRHIRES
    rts

; clear hires page 1 only
clrscr lda #$20
    sta clrscr_smc+2
    lda #0
    ldy #0
clrscr_smc sta $ff00,y
    iny
    bne clrscr_smc
    inc clrscr_smc+2
    ldx clrscr_smc+2
    cpx #$40
    bcc clrscr_smc
    rts

    *= $5074

page 
    inc FIRST_CHAR_OF_SCREEN
    lda FIRST_CHAR_OF_SCREEN
    sta FIRST_CHAR_OF_LINE

    ldy #$00
line_loop
    ldx #$00
    lda FIRST_CHAR_OF_LINE
    sta CURRENT_CHAR
char_loop
    lda CURRENT_CHAR
    jsr font_test
    inc CURRENT_CHAR
    inx
    cpx #40
    bcc char_loop

    inc FIRST_CHAR_OF_LINE
    iny
    cpy #24
    bcc line_loop

    rts



font_test
