DrawHexByte
        PHA             ; save low nibble
        ROR             ; shift high nibble
        ROR             ; to low nibble
        ROR             ;
        ROR             ;
        JSR DrawHexNib  ; print high nib in hex
        PLA             ; pritn low  nib in hex
DrawHexNib
        AND #$F         ; base 16
        TAX             ;
        LDA NIB2HEX,X   ; nibble to ASCII
;       ORG $0310 ; Listing 5
DrawChar
        JMP DrawCharCol
;       ORG $0313 ; Listing 9
SetCursorRow
        LDA TEXTROW_L,X   ; TEXTROW_L[ row ]
        STA hgrptr
        LDA TEXTROW_H,X   ; TEXTROW_H[ row ]
        ORA HgrHi
        STA hgrptr+1
        RTS
;       ORG $0321 ; Listing 11




SetCursorColRow
        STX hgrptr
        LDA TEXTROW_L,Y    ; TEXTROW_L[ row ]
        CLC
        ADC hgrptr       ; add column
        STA hgrptr
        LDA TEXTROW_H,Y    ; TEXTROW_H[ row ]
        ORA HgrHi
        STA hgrptr+1
        RTS
        NOP             ; pad
;       ORG $0335 ; Listing 6
DrawCharColRow
        PHA
        JSR SetCursorRow
        PLA
;       ORG $033A ; Listing 7
DrawCharCol            ;     A=%PQRstuvw
        ROL            ; C=P A=%QRstuvw?
        ROL            ; C=Q A=%Rstuvw?P
        ROL            ; C=R A=%stuvw?PQ
        TAX            ;     X=%stuvw?PQ push glyph
        AND #$F8       ;     A=%stuvw000
        STA _LoadFont+1; AddressLo = (c*8)
        TXA            ;     A=%stuvw?PQ pop glyph
        AND #3         ; Optimization: s=0 implicit CLC !
        ROL            ; C=s A=%00000PQR and 1 last ROL to get R
        ADC #>FatFont  ; += FontHi; Carry=0 since s=0 from above
        STA _LoadFont+2; AddressHi = FontHi + (c/32)
;       ORG $034C ; Listing 4a
_DrawChar1
        LDX hgrptr+1
        STX scratch_0
;       ORG $0350 ; Listing 1
_DrawChar
        LDX #7
_LoadFont               ; A = font[ offset ]
        LDA FatFont,X
        STA (hgrptr),Y   ; screen[col] = A
        CLC
        LDA hgrptr+1       ;
        ADC #4          ; screen += 0x400
        STA hgrptr+1
        DEX
        BPL _LoadFont
;       ORG $0363 ; Listing 4a
IncCursorCol
        INY
        LDX scratch_0       ; Move cursor back to top of scanline
        STX hgrptr+1
        RTS
;       ORG $0369 ; Listing 10
SetCursorColRowYX
        JSR SetCursorRow
        CLC
        TYA
        ADC hgrptr
        STA hgrptr
        RTS
;       ORG $037E ; Listing 12
DrawString
         STY tempaddr+0
         STX tempaddr+1
         LDY #0
_ds1     LDA (tempaddr),Y
         BEQ _ds2       ; null byte? Done
         SEC
         SBC #$20
         JSR DrawChar   ; or DrawCharCol for speed
         CPY #40        ; col < 40?
         BCC _ds1
_ds2     RTS

;       ORG $0390 ; Listing 8
NIB2HEX
        .byte "0123456789ABCDEF"
;       ORG $03A0 ; Listing 9a
TEXTROW_L
        .byte $00,$80,$00,$80,$00,$80,$00,$80
        .byte $28,$A8,$28,$A8,$28,$A8,$28,$A8
        .byte $50,$D0,$50,$D0,$50,$D0,$50,$D0
TEXTROW_H
        .byte $00,$00,$01,$01,$02,$02,$03,$03
        .byte $00,$00,$01,$01,$02,$02,$03,$03
        .byte $00,$00,$01,$01,$02,$02,$03,$03
