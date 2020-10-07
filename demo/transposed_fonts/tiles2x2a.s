; AUTOGENERATED FILE; DO NOT EDIT!
;
; This file was generated by asmgen.py, a 6502 code generator sponsored by
; the Player/Missile Podcast. (The sprite compiler is based on HiSprite by
; Quinn Dunki).
;
; The code produced by asmgen is licensed under the Creative Commons
; Attribution 4.0 International (CC BY 4.0), so you are free to use the code in
; this file for any purpose. (The code generator itself is licensed under the
; GPLv3.)

FASTFONT_H1	; A = character, X = column, Y = row; A is clobbered, X&Y are not
	pha
	lda FASTFONT_H1_JMP_HI,y
	sta FASTFONT_H1_JMP+2
	lda FASTFONT_H1_JMP_LO,y
	sta FASTFONT_H1_JMP+1
	sty scratch_0
	pla
	tay
FASTFONT_H1_JMP
	jmp $ffff


FASTFONT_H1_JMP_HI
	.byte >FASTFONT_H1_0
	.byte >FASTFONT_H1_1
	.byte >FASTFONT_H1_2
	.byte >FASTFONT_H1_3
	.byte >FASTFONT_H1_4
	.byte >FASTFONT_H1_5
	.byte >FASTFONT_H1_6
	.byte >FASTFONT_H1_7
	.byte >FASTFONT_H1_8
	.byte >FASTFONT_H1_9
	.byte >FASTFONT_H1_10
	.byte >FASTFONT_H1_11
FASTFONT_H1_JMP_LO
	.byte <FASTFONT_H1_0
	.byte <FASTFONT_H1_1
	.byte <FASTFONT_H1_2
	.byte <FASTFONT_H1_3
	.byte <FASTFONT_H1_4
	.byte <FASTFONT_H1_5
	.byte <FASTFONT_H1_6
	.byte <FASTFONT_H1_7
	.byte <FASTFONT_H1_8
	.byte <FASTFONT_H1_9
	.byte <FASTFONT_H1_10
	.byte <FASTFONT_H1_11

FASTFONT_H1_0
	lda TransposedFontRow0_0,y
	sta $2000,x
	lda TransposedFontRow0_1,y
	sta $2400,x
	lda TransposedFontRow0_2,y
	sta $2800,x
	lda TransposedFontRow0_3,y
	sta $2c00,x
	lda TransposedFontRow0_4,y
	sta $3000,x
	lda TransposedFontRow0_5,y
	sta $3400,x
	lda TransposedFontRow0_6,y
	sta $3800,x
	lda TransposedFontRow0_7,y
	sta $3c00,x
	lda TransposedFontRow0_8,y
	sta $2080,x
	lda TransposedFontRow0_9,y
	sta $2480,x
	lda TransposedFontRow0_10,y
	sta $2880,x
	lda TransposedFontRow0_11,y
	sta $2c80,x
	lda TransposedFontRow0_12,y
	sta $3080,x
	lda TransposedFontRow0_13,y
	sta $3480,x
	lda TransposedFontRow0_14,y
	sta $3880,x
	lda TransposedFontRow0_15,y
	sta $3c80,x
	lda TransposedFontRow1_0,y
	sta $2001,x
	lda TransposedFontRow1_1,y
	sta $2401,x
	lda TransposedFontRow1_2,y
	sta $2801,x
	lda TransposedFontRow1_3,y
	sta $2c01,x
	lda TransposedFontRow1_4,y
	sta $3001,x
	lda TransposedFontRow1_5,y
	sta $3401,x
	lda TransposedFontRow1_6,y
	sta $3801,x
	lda TransposedFontRow1_7,y
	sta $3c01,x
	lda TransposedFontRow1_8,y
	sta $2081,x
	lda TransposedFontRow1_9,y
	sta $2481,x
	lda TransposedFontRow1_10,y
	sta $2881,x
	lda TransposedFontRow1_11,y
	sta $2c81,x
	lda TransposedFontRow1_12,y
	sta $3081,x
	lda TransposedFontRow1_13,y
	sta $3481,x
	lda TransposedFontRow1_14,y
	sta $3881,x
	lda TransposedFontRow1_15,y
	sta $3c81,x
	ldy scratch_0
	rts
FASTFONT_H1_1
	lda TransposedFontRow0_0,y
	sta $2100,x
	lda TransposedFontRow0_1,y
	sta $2500,x
	lda TransposedFontRow0_2,y
	sta $2900,x
	lda TransposedFontRow0_3,y
	sta $2d00,x
	lda TransposedFontRow0_4,y
	sta $3100,x
	lda TransposedFontRow0_5,y
	sta $3500,x
	lda TransposedFontRow0_6,y
	sta $3900,x
	lda TransposedFontRow0_7,y
	sta $3d00,x
	lda TransposedFontRow0_8,y
	sta $2180,x
	lda TransposedFontRow0_9,y
	sta $2580,x
	lda TransposedFontRow0_10,y
	sta $2980,x
	lda TransposedFontRow0_11,y
	sta $2d80,x
	lda TransposedFontRow0_12,y
	sta $3180,x
	lda TransposedFontRow0_13,y
	sta $3580,x
	lda TransposedFontRow0_14,y
	sta $3980,x
	lda TransposedFontRow0_15,y
	sta $3d80,x
	lda TransposedFontRow1_0,y
	sta $2101,x
	lda TransposedFontRow1_1,y
	sta $2501,x
	lda TransposedFontRow1_2,y
	sta $2901,x
	lda TransposedFontRow1_3,y
	sta $2d01,x
	lda TransposedFontRow1_4,y
	sta $3101,x
	lda TransposedFontRow1_5,y
	sta $3501,x
	lda TransposedFontRow1_6,y
	sta $3901,x
	lda TransposedFontRow1_7,y
	sta $3d01,x
	lda TransposedFontRow1_8,y
	sta $2181,x
	lda TransposedFontRow1_9,y
	sta $2581,x
	lda TransposedFontRow1_10,y
	sta $2981,x
	lda TransposedFontRow1_11,y
	sta $2d81,x
	lda TransposedFontRow1_12,y
	sta $3181,x
	lda TransposedFontRow1_13,y
	sta $3581,x
	lda TransposedFontRow1_14,y
	sta $3981,x
	lda TransposedFontRow1_15,y
	sta $3d81,x
	ldy scratch_0
	rts
FASTFONT_H1_2
	lda TransposedFontRow0_0,y
	sta $2200,x
	lda TransposedFontRow0_1,y
	sta $2600,x
	lda TransposedFontRow0_2,y
	sta $2a00,x
	lda TransposedFontRow0_3,y
	sta $2e00,x
	lda TransposedFontRow0_4,y
	sta $3200,x
	lda TransposedFontRow0_5,y
	sta $3600,x
	lda TransposedFontRow0_6,y
	sta $3a00,x
	lda TransposedFontRow0_7,y
	sta $3e00,x
	lda TransposedFontRow0_8,y
	sta $2280,x
	lda TransposedFontRow0_9,y
	sta $2680,x
	lda TransposedFontRow0_10,y
	sta $2a80,x
	lda TransposedFontRow0_11,y
	sta $2e80,x
	lda TransposedFontRow0_12,y
	sta $3280,x
	lda TransposedFontRow0_13,y
	sta $3680,x
	lda TransposedFontRow0_14,y
	sta $3a80,x
	lda TransposedFontRow0_15,y
	sta $3e80,x
	lda TransposedFontRow1_0,y
	sta $2201,x
	lda TransposedFontRow1_1,y
	sta $2601,x
	lda TransposedFontRow1_2,y
	sta $2a01,x
	lda TransposedFontRow1_3,y
	sta $2e01,x
	lda TransposedFontRow1_4,y
	sta $3201,x
	lda TransposedFontRow1_5,y
	sta $3601,x
	lda TransposedFontRow1_6,y
	sta $3a01,x
	lda TransposedFontRow1_7,y
	sta $3e01,x
	lda TransposedFontRow1_8,y
	sta $2281,x
	lda TransposedFontRow1_9,y
	sta $2681,x
	lda TransposedFontRow1_10,y
	sta $2a81,x
	lda TransposedFontRow1_11,y
	sta $2e81,x
	lda TransposedFontRow1_12,y
	sta $3281,x
	lda TransposedFontRow1_13,y
	sta $3681,x
	lda TransposedFontRow1_14,y
	sta $3a81,x
	lda TransposedFontRow1_15,y
	sta $3e81,x
	ldy scratch_0
	rts
FASTFONT_H1_3
	lda TransposedFontRow0_0,y
	sta $2300,x
	lda TransposedFontRow0_1,y
	sta $2700,x
	lda TransposedFontRow0_2,y
	sta $2b00,x
	lda TransposedFontRow0_3,y
	sta $2f00,x
	lda TransposedFontRow0_4,y
	sta $3300,x
	lda TransposedFontRow0_5,y
	sta $3700,x
	lda TransposedFontRow0_6,y
	sta $3b00,x
	lda TransposedFontRow0_7,y
	sta $3f00,x
	lda TransposedFontRow0_8,y
	sta $2380,x
	lda TransposedFontRow0_9,y
	sta $2780,x
	lda TransposedFontRow0_10,y
	sta $2b80,x
	lda TransposedFontRow0_11,y
	sta $2f80,x
	lda TransposedFontRow0_12,y
	sta $3380,x
	lda TransposedFontRow0_13,y
	sta $3780,x
	lda TransposedFontRow0_14,y
	sta $3b80,x
	lda TransposedFontRow0_15,y
	sta $3f80,x
	lda TransposedFontRow1_0,y
	sta $2301,x
	lda TransposedFontRow1_1,y
	sta $2701,x
	lda TransposedFontRow1_2,y
	sta $2b01,x
	lda TransposedFontRow1_3,y
	sta $2f01,x
	lda TransposedFontRow1_4,y
	sta $3301,x
	lda TransposedFontRow1_5,y
	sta $3701,x
	lda TransposedFontRow1_6,y
	sta $3b01,x
	lda TransposedFontRow1_7,y
	sta $3f01,x
	lda TransposedFontRow1_8,y
	sta $2381,x
	lda TransposedFontRow1_9,y
	sta $2781,x
	lda TransposedFontRow1_10,y
	sta $2b81,x
	lda TransposedFontRow1_11,y
	sta $2f81,x
	lda TransposedFontRow1_12,y
	sta $3381,x
	lda TransposedFontRow1_13,y
	sta $3781,x
	lda TransposedFontRow1_14,y
	sta $3b81,x
	lda TransposedFontRow1_15,y
	sta $3f81,x
	ldy scratch_0
	rts
FASTFONT_H1_4
	lda TransposedFontRow0_0,y
	sta $2028,x
	lda TransposedFontRow0_1,y
	sta $2428,x
	lda TransposedFontRow0_2,y
	sta $2828,x
	lda TransposedFontRow0_3,y
	sta $2c28,x
	lda TransposedFontRow0_4,y
	sta $3028,x
	lda TransposedFontRow0_5,y
	sta $3428,x
	lda TransposedFontRow0_6,y
	sta $3828,x
	lda TransposedFontRow0_7,y
	sta $3c28,x
	lda TransposedFontRow0_8,y
	sta $20a8,x
	lda TransposedFontRow0_9,y
	sta $24a8,x
	lda TransposedFontRow0_10,y
	sta $28a8,x
	lda TransposedFontRow0_11,y
	sta $2ca8,x
	lda TransposedFontRow0_12,y
	sta $30a8,x
	lda TransposedFontRow0_13,y
	sta $34a8,x
	lda TransposedFontRow0_14,y
	sta $38a8,x
	lda TransposedFontRow0_15,y
	sta $3ca8,x
	lda TransposedFontRow1_0,y
	sta $2029,x
	lda TransposedFontRow1_1,y
	sta $2429,x
	lda TransposedFontRow1_2,y
	sta $2829,x
	lda TransposedFontRow1_3,y
	sta $2c29,x
	lda TransposedFontRow1_4,y
	sta $3029,x
	lda TransposedFontRow1_5,y
	sta $3429,x
	lda TransposedFontRow1_6,y
	sta $3829,x
	lda TransposedFontRow1_7,y
	sta $3c29,x
	lda TransposedFontRow1_8,y
	sta $20a9,x
	lda TransposedFontRow1_9,y
	sta $24a9,x
	lda TransposedFontRow1_10,y
	sta $28a9,x
	lda TransposedFontRow1_11,y
	sta $2ca9,x
	lda TransposedFontRow1_12,y
	sta $30a9,x
	lda TransposedFontRow1_13,y
	sta $34a9,x
	lda TransposedFontRow1_14,y
	sta $38a9,x
	lda TransposedFontRow1_15,y
	sta $3ca9,x
	ldy scratch_0
	rts
FASTFONT_H1_5
	lda TransposedFontRow0_0,y
	sta $2128,x
	lda TransposedFontRow0_1,y
	sta $2528,x
	lda TransposedFontRow0_2,y
	sta $2928,x
	lda TransposedFontRow0_3,y
	sta $2d28,x
	lda TransposedFontRow0_4,y
	sta $3128,x
	lda TransposedFontRow0_5,y
	sta $3528,x
	lda TransposedFontRow0_6,y
	sta $3928,x
	lda TransposedFontRow0_7,y
	sta $3d28,x
	lda TransposedFontRow0_8,y
	sta $21a8,x
	lda TransposedFontRow0_9,y
	sta $25a8,x
	lda TransposedFontRow0_10,y
	sta $29a8,x
	lda TransposedFontRow0_11,y
	sta $2da8,x
	lda TransposedFontRow0_12,y
	sta $31a8,x
	lda TransposedFontRow0_13,y
	sta $35a8,x
	lda TransposedFontRow0_14,y
	sta $39a8,x
	lda TransposedFontRow0_15,y
	sta $3da8,x
	lda TransposedFontRow1_0,y
	sta $2129,x
	lda TransposedFontRow1_1,y
	sta $2529,x
	lda TransposedFontRow1_2,y
	sta $2929,x
	lda TransposedFontRow1_3,y
	sta $2d29,x
	lda TransposedFontRow1_4,y
	sta $3129,x
	lda TransposedFontRow1_5,y
	sta $3529,x
	lda TransposedFontRow1_6,y
	sta $3929,x
	lda TransposedFontRow1_7,y
	sta $3d29,x
	lda TransposedFontRow1_8,y
	sta $21a9,x
	lda TransposedFontRow1_9,y
	sta $25a9,x
	lda TransposedFontRow1_10,y
	sta $29a9,x
	lda TransposedFontRow1_11,y
	sta $2da9,x
	lda TransposedFontRow1_12,y
	sta $31a9,x
	lda TransposedFontRow1_13,y
	sta $35a9,x
	lda TransposedFontRow1_14,y
	sta $39a9,x
	lda TransposedFontRow1_15,y
	sta $3da9,x
	ldy scratch_0
	rts
FASTFONT_H1_6
	lda TransposedFontRow0_0,y
	sta $2228,x
	lda TransposedFontRow0_1,y
	sta $2628,x
	lda TransposedFontRow0_2,y
	sta $2a28,x
	lda TransposedFontRow0_3,y
	sta $2e28,x
	lda TransposedFontRow0_4,y
	sta $3228,x
	lda TransposedFontRow0_5,y
	sta $3628,x
	lda TransposedFontRow0_6,y
	sta $3a28,x
	lda TransposedFontRow0_7,y
	sta $3e28,x
	lda TransposedFontRow0_8,y
	sta $22a8,x
	lda TransposedFontRow0_9,y
	sta $26a8,x
	lda TransposedFontRow0_10,y
	sta $2aa8,x
	lda TransposedFontRow0_11,y
	sta $2ea8,x
	lda TransposedFontRow0_12,y
	sta $32a8,x
	lda TransposedFontRow0_13,y
	sta $36a8,x
	lda TransposedFontRow0_14,y
	sta $3aa8,x
	lda TransposedFontRow0_15,y
	sta $3ea8,x
	lda TransposedFontRow1_0,y
	sta $2229,x
	lda TransposedFontRow1_1,y
	sta $2629,x
	lda TransposedFontRow1_2,y
	sta $2a29,x
	lda TransposedFontRow1_3,y
	sta $2e29,x
	lda TransposedFontRow1_4,y
	sta $3229,x
	lda TransposedFontRow1_5,y
	sta $3629,x
	lda TransposedFontRow1_6,y
	sta $3a29,x
	lda TransposedFontRow1_7,y
	sta $3e29,x
	lda TransposedFontRow1_8,y
	sta $22a9,x
	lda TransposedFontRow1_9,y
	sta $26a9,x
	lda TransposedFontRow1_10,y
	sta $2aa9,x
	lda TransposedFontRow1_11,y
	sta $2ea9,x
	lda TransposedFontRow1_12,y
	sta $32a9,x
	lda TransposedFontRow1_13,y
	sta $36a9,x
	lda TransposedFontRow1_14,y
	sta $3aa9,x
	lda TransposedFontRow1_15,y
	sta $3ea9,x
	ldy scratch_0
	rts
FASTFONT_H1_7
	lda TransposedFontRow0_0,y
	sta $2328,x
	lda TransposedFontRow0_1,y
	sta $2728,x
	lda TransposedFontRow0_2,y
	sta $2b28,x
	lda TransposedFontRow0_3,y
	sta $2f28,x
	lda TransposedFontRow0_4,y
	sta $3328,x
	lda TransposedFontRow0_5,y
	sta $3728,x
	lda TransposedFontRow0_6,y
	sta $3b28,x
	lda TransposedFontRow0_7,y
	sta $3f28,x
	lda TransposedFontRow0_8,y
	sta $23a8,x
	lda TransposedFontRow0_9,y
	sta $27a8,x
	lda TransposedFontRow0_10,y
	sta $2ba8,x
	lda TransposedFontRow0_11,y
	sta $2fa8,x
	lda TransposedFontRow0_12,y
	sta $33a8,x
	lda TransposedFontRow0_13,y
	sta $37a8,x
	lda TransposedFontRow0_14,y
	sta $3ba8,x
	lda TransposedFontRow0_15,y
	sta $3fa8,x
	lda TransposedFontRow1_0,y
	sta $2329,x
	lda TransposedFontRow1_1,y
	sta $2729,x
	lda TransposedFontRow1_2,y
	sta $2b29,x
	lda TransposedFontRow1_3,y
	sta $2f29,x
	lda TransposedFontRow1_4,y
	sta $3329,x
	lda TransposedFontRow1_5,y
	sta $3729,x
	lda TransposedFontRow1_6,y
	sta $3b29,x
	lda TransposedFontRow1_7,y
	sta $3f29,x
	lda TransposedFontRow1_8,y
	sta $23a9,x
	lda TransposedFontRow1_9,y
	sta $27a9,x
	lda TransposedFontRow1_10,y
	sta $2ba9,x
	lda TransposedFontRow1_11,y
	sta $2fa9,x
	lda TransposedFontRow1_12,y
	sta $33a9,x
	lda TransposedFontRow1_13,y
	sta $37a9,x
	lda TransposedFontRow1_14,y
	sta $3ba9,x
	lda TransposedFontRow1_15,y
	sta $3fa9,x
	ldy scratch_0
	rts
FASTFONT_H1_8
	lda TransposedFontRow0_0,y
	sta $2050,x
	lda TransposedFontRow0_1,y
	sta $2450,x
	lda TransposedFontRow0_2,y
	sta $2850,x
	lda TransposedFontRow0_3,y
	sta $2c50,x
	lda TransposedFontRow0_4,y
	sta $3050,x
	lda TransposedFontRow0_5,y
	sta $3450,x
	lda TransposedFontRow0_6,y
	sta $3850,x
	lda TransposedFontRow0_7,y
	sta $3c50,x
	lda TransposedFontRow0_8,y
	sta $20d0,x
	lda TransposedFontRow0_9,y
	sta $24d0,x
	lda TransposedFontRow0_10,y
	sta $28d0,x
	lda TransposedFontRow0_11,y
	sta $2cd0,x
	lda TransposedFontRow0_12,y
	sta $30d0,x
	lda TransposedFontRow0_13,y
	sta $34d0,x
	lda TransposedFontRow0_14,y
	sta $38d0,x
	lda TransposedFontRow0_15,y
	sta $3cd0,x
	lda TransposedFontRow1_0,y
	sta $2051,x
	lda TransposedFontRow1_1,y
	sta $2451,x
	lda TransposedFontRow1_2,y
	sta $2851,x
	lda TransposedFontRow1_3,y
	sta $2c51,x
	lda TransposedFontRow1_4,y
	sta $3051,x
	lda TransposedFontRow1_5,y
	sta $3451,x
	lda TransposedFontRow1_6,y
	sta $3851,x
	lda TransposedFontRow1_7,y
	sta $3c51,x
	lda TransposedFontRow1_8,y
	sta $20d1,x
	lda TransposedFontRow1_9,y
	sta $24d1,x
	lda TransposedFontRow1_10,y
	sta $28d1,x
	lda TransposedFontRow1_11,y
	sta $2cd1,x
	lda TransposedFontRow1_12,y
	sta $30d1,x
	lda TransposedFontRow1_13,y
	sta $34d1,x
	lda TransposedFontRow1_14,y
	sta $38d1,x
	lda TransposedFontRow1_15,y
	sta $3cd1,x
	ldy scratch_0
	rts
FASTFONT_H1_9
	lda TransposedFontRow0_0,y
	sta $2150,x
	lda TransposedFontRow0_1,y
	sta $2550,x
	lda TransposedFontRow0_2,y
	sta $2950,x
	lda TransposedFontRow0_3,y
	sta $2d50,x
	lda TransposedFontRow0_4,y
	sta $3150,x
	lda TransposedFontRow0_5,y
	sta $3550,x
	lda TransposedFontRow0_6,y
	sta $3950,x
	lda TransposedFontRow0_7,y
	sta $3d50,x
	lda TransposedFontRow0_8,y
	sta $21d0,x
	lda TransposedFontRow0_9,y
	sta $25d0,x
	lda TransposedFontRow0_10,y
	sta $29d0,x
	lda TransposedFontRow0_11,y
	sta $2dd0,x
	lda TransposedFontRow0_12,y
	sta $31d0,x
	lda TransposedFontRow0_13,y
	sta $35d0,x
	lda TransposedFontRow0_14,y
	sta $39d0,x
	lda TransposedFontRow0_15,y
	sta $3dd0,x
	lda TransposedFontRow1_0,y
	sta $2151,x
	lda TransposedFontRow1_1,y
	sta $2551,x
	lda TransposedFontRow1_2,y
	sta $2951,x
	lda TransposedFontRow1_3,y
	sta $2d51,x
	lda TransposedFontRow1_4,y
	sta $3151,x
	lda TransposedFontRow1_5,y
	sta $3551,x
	lda TransposedFontRow1_6,y
	sta $3951,x
	lda TransposedFontRow1_7,y
	sta $3d51,x
	lda TransposedFontRow1_8,y
	sta $21d1,x
	lda TransposedFontRow1_9,y
	sta $25d1,x
	lda TransposedFontRow1_10,y
	sta $29d1,x
	lda TransposedFontRow1_11,y
	sta $2dd1,x
	lda TransposedFontRow1_12,y
	sta $31d1,x
	lda TransposedFontRow1_13,y
	sta $35d1,x
	lda TransposedFontRow1_14,y
	sta $39d1,x
	lda TransposedFontRow1_15,y
	sta $3dd1,x
	ldy scratch_0
	rts
FASTFONT_H1_10
	lda TransposedFontRow0_0,y
	sta $2250,x
	lda TransposedFontRow0_1,y
	sta $2650,x
	lda TransposedFontRow0_2,y
	sta $2a50,x
	lda TransposedFontRow0_3,y
	sta $2e50,x
	lda TransposedFontRow0_4,y
	sta $3250,x
	lda TransposedFontRow0_5,y
	sta $3650,x
	lda TransposedFontRow0_6,y
	sta $3a50,x
	lda TransposedFontRow0_7,y
	sta $3e50,x
	lda TransposedFontRow0_8,y
	sta $22d0,x
	lda TransposedFontRow0_9,y
	sta $26d0,x
	lda TransposedFontRow0_10,y
	sta $2ad0,x
	lda TransposedFontRow0_11,y
	sta $2ed0,x
	lda TransposedFontRow0_12,y
	sta $32d0,x
	lda TransposedFontRow0_13,y
	sta $36d0,x
	lda TransposedFontRow0_14,y
	sta $3ad0,x
	lda TransposedFontRow0_15,y
	sta $3ed0,x
	lda TransposedFontRow1_0,y
	sta $2251,x
	lda TransposedFontRow1_1,y
	sta $2651,x
	lda TransposedFontRow1_2,y
	sta $2a51,x
	lda TransposedFontRow1_3,y
	sta $2e51,x
	lda TransposedFontRow1_4,y
	sta $3251,x
	lda TransposedFontRow1_5,y
	sta $3651,x
	lda TransposedFontRow1_6,y
	sta $3a51,x
	lda TransposedFontRow1_7,y
	sta $3e51,x
	lda TransposedFontRow1_8,y
	sta $22d1,x
	lda TransposedFontRow1_9,y
	sta $26d1,x
	lda TransposedFontRow1_10,y
	sta $2ad1,x
	lda TransposedFontRow1_11,y
	sta $2ed1,x
	lda TransposedFontRow1_12,y
	sta $32d1,x
	lda TransposedFontRow1_13,y
	sta $36d1,x
	lda TransposedFontRow1_14,y
	sta $3ad1,x
	lda TransposedFontRow1_15,y
	sta $3ed1,x
	ldy scratch_0
	rts
FASTFONT_H1_11
	lda TransposedFontRow0_0,y
	sta $2350,x
	lda TransposedFontRow0_1,y
	sta $2750,x
	lda TransposedFontRow0_2,y
	sta $2b50,x
	lda TransposedFontRow0_3,y
	sta $2f50,x
	lda TransposedFontRow0_4,y
	sta $3350,x
	lda TransposedFontRow0_5,y
	sta $3750,x
	lda TransposedFontRow0_6,y
	sta $3b50,x
	lda TransposedFontRow0_7,y
	sta $3f50,x
	lda TransposedFontRow0_8,y
	sta $23d0,x
	lda TransposedFontRow0_9,y
	sta $27d0,x
	lda TransposedFontRow0_10,y
	sta $2bd0,x
	lda TransposedFontRow0_11,y
	sta $2fd0,x
	lda TransposedFontRow0_12,y
	sta $33d0,x
	lda TransposedFontRow0_13,y
	sta $37d0,x
	lda TransposedFontRow0_14,y
	sta $3bd0,x
	lda TransposedFontRow0_15,y
	sta $3fd0,x
	lda TransposedFontRow1_0,y
	sta $2351,x
	lda TransposedFontRow1_1,y
	sta $2751,x
	lda TransposedFontRow1_2,y
	sta $2b51,x
	lda TransposedFontRow1_3,y
	sta $2f51,x
	lda TransposedFontRow1_4,y
	sta $3351,x
	lda TransposedFontRow1_5,y
	sta $3751,x
	lda TransposedFontRow1_6,y
	sta $3b51,x
	lda TransposedFontRow1_7,y
	sta $3f51,x
	lda TransposedFontRow1_8,y
	sta $23d1,x
	lda TransposedFontRow1_9,y
	sta $27d1,x
	lda TransposedFontRow1_10,y
	sta $2bd1,x
	lda TransposedFontRow1_11,y
	sta $2fd1,x
	lda TransposedFontRow1_12,y
	sta $33d1,x
	lda TransposedFontRow1_13,y
	sta $37d1,x
	lda TransposedFontRow1_14,y
	sta $3bd1,x
	lda TransposedFontRow1_15,y
	sta $3fd1,x
	ldy scratch_0
	rts

TransposedFontRow0_0
	.byte $00, $04, $08, $0c, $10, $14, $18, $1c, $20, $24, $28, $2c, $30, $34, $38, $3c
	.byte $40, $44, $48, $4c, $50, $54, $58, $5c, $60, $64, $68, $6c, $70, $74, $78, $7c
TransposedFontRow1_0
	.byte $00, $04, $08, $0c, $10, $14, $18, $1c, $20, $24, $28, $2c, $30, $34, $38, $3c
	.byte $40, $44, $48, $4c, $50, $54, $58, $5c, $60, $64, $68, $6c, $70, $74, $78, $7c
TransposedFontRow0_1
	.byte $00, $04, $08, $0c, $10, $14, $18, $1c, $20, $24, $28, $2c, $30, $34, $38, $3c
	.byte $40, $44, $48, $4c, $50, $54, $58, $5c, $60, $64, $68, $6c, $70, $74, $78, $7c
TransposedFontRow1_1
	.byte $00, $04, $08, $0c, $10, $14, $18, $1c, $20, $24, $28, $2c, $30, $34, $38, $3c
	.byte $40, $44, $48, $4c, $50, $54, $58, $5c, $60, $64, $68, $6c, $70, $74, $78, $7c
TransposedFontRow0_2
	.byte $00, $04, $08, $0c, $10, $14, $18, $1c, $20, $24, $28, $2c, $30, $34, $38, $3c
	.byte $40, $44, $48, $4c, $50, $54, $58, $5c, $60, $64, $68, $6c, $70, $74, $78, $7c
TransposedFontRow1_2
	.byte $00, $04, $08, $0c, $10, $14, $18, $1c, $20, $24, $28, $2c, $30, $34, $38, $3c
	.byte $40, $44, $48, $4c, $50, $54, $58, $5c, $60, $64, $68, $6c, $70, $74, $78, $7c
TransposedFontRow0_3
	.byte $00, $04, $08, $0c, $10, $14, $18, $1c, $20, $24, $28, $2c, $30, $34, $38, $3c
	.byte $40, $44, $48, $4c, $50, $54, $58, $5c, $60, $64, $68, $6c, $70, $74, $78, $7c
TransposedFontRow1_3
	.byte $00, $04, $08, $0c, $10, $14, $18, $1c, $20, $24, $28, $2c, $30, $34, $38, $3c
	.byte $40, $44, $48, $4c, $50, $54, $58, $5c, $60, $64, $68, $6c, $70, $74, $78, $7c
TransposedFontRow0_4
	.byte $01, $05, $09, $0d, $11, $15, $19, $1d, $21, $25, $29, $2d, $31, $35, $39, $3d
	.byte $41, $45, $49, $4d, $51, $55, $59, $5d, $61, $65, $69, $6d, $71, $75, $79, $7d
TransposedFontRow1_4
	.byte $01, $05, $09, $0d, $11, $15, $19, $1d, $21, $25, $29, $2d, $31, $35, $39, $3d
	.byte $41, $45, $49, $4d, $51, $55, $59, $5d, $61, $65, $69, $6d, $71, $75, $79, $7d
TransposedFontRow0_5
	.byte $01, $05, $09, $0d, $11, $15, $19, $1d, $21, $25, $29, $2d, $31, $35, $39, $3d
	.byte $41, $45, $49, $4d, $51, $55, $59, $5d, $61, $65, $69, $6d, $71, $75, $79, $7d
TransposedFontRow1_5
	.byte $01, $05, $09, $0d, $11, $15, $19, $1d, $21, $25, $29, $2d, $31, $35, $39, $3d
	.byte $41, $45, $49, $4d, $51, $55, $59, $5d, $61, $65, $69, $6d, $71, $75, $79, $7d
TransposedFontRow0_6
	.byte $01, $05, $09, $0d, $11, $15, $19, $1d, $21, $25, $29, $2d, $31, $35, $39, $3d
	.byte $41, $45, $49, $4d, $51, $55, $59, $5d, $61, $65, $69, $6d, $71, $75, $79, $7d
TransposedFontRow1_6
	.byte $01, $05, $09, $0d, $11, $15, $19, $1d, $21, $25, $29, $2d, $31, $35, $39, $3d
	.byte $41, $45, $49, $4d, $51, $55, $59, $5d, $61, $65, $69, $6d, $71, $75, $79, $7d
TransposedFontRow0_7
	.byte $01, $05, $09, $0d, $11, $15, $19, $1d, $21, $25, $29, $2d, $31, $35, $39, $3d
	.byte $41, $45, $49, $4d, $51, $55, $59, $5d, $61, $65, $69, $6d, $71, $75, $79, $7d
TransposedFontRow1_7
	.byte $01, $05, $09, $0d, $11, $15, $19, $1d, $21, $25, $29, $2d, $31, $35, $39, $3d
	.byte $41, $45, $49, $4d, $51, $55, $59, $5d, $61, $65, $69, $6d, $71, $75, $79, $7d
TransposedFontRow0_8
	.byte $02, $06, $0a, $0e, $12, $16, $1a, $1e, $22, $26, $2a, $2e, $32, $36, $3a, $3e
	.byte $42, $46, $4a, $4e, $52, $56, $5a, $5e, $62, $66, $6a, $6e, $72, $76, $7a, $7e
TransposedFontRow1_8
	.byte $02, $06, $0a, $0e, $12, $16, $1a, $1e, $22, $26, $2a, $2e, $32, $36, $3a, $3e
	.byte $42, $46, $4a, $4e, $52, $56, $5a, $5e, $62, $66, $6a, $6e, $72, $76, $7a, $7e
TransposedFontRow0_9
	.byte $02, $06, $0a, $0e, $12, $16, $1a, $1e, $22, $26, $2a, $2e, $32, $36, $3a, $3e
	.byte $42, $46, $4a, $4e, $52, $56, $5a, $5e, $62, $66, $6a, $6e, $72, $76, $7a, $7e
TransposedFontRow1_9
	.byte $02, $06, $0a, $0e, $12, $16, $1a, $1e, $22, $26, $2a, $2e, $32, $36, $3a, $3e
	.byte $42, $46, $4a, $4e, $52, $56, $5a, $5e, $62, $66, $6a, $6e, $72, $76, $7a, $7e
TransposedFontRow0_10
	.byte $02, $06, $0a, $0e, $12, $16, $1a, $1e, $22, $26, $2a, $2e, $32, $36, $3a, $3e
	.byte $42, $46, $4a, $4e, $52, $56, $5a, $5e, $62, $66, $6a, $6e, $72, $76, $7a, $7e
TransposedFontRow1_10
	.byte $02, $06, $0a, $0e, $12, $16, $1a, $1e, $22, $26, $2a, $2e, $32, $36, $3a, $3e
	.byte $42, $46, $4a, $4e, $52, $56, $5a, $5e, $62, $66, $6a, $6e, $72, $76, $7a, $7e
TransposedFontRow0_11
	.byte $02, $06, $0a, $0e, $12, $16, $1a, $1e, $22, $26, $2a, $2e, $32, $36, $3a, $3e
	.byte $42, $46, $4a, $4e, $52, $56, $5a, $5e, $62, $66, $6a, $6e, $72, $76, $7a, $7e
TransposedFontRow1_11
	.byte $02, $06, $0a, $0e, $12, $16, $1a, $1e, $22, $26, $2a, $2e, $32, $36, $3a, $3e
	.byte $42, $46, $4a, $4e, $52, $56, $5a, $5e, $62, $66, $6a, $6e, $72, $76, $7a, $7e
TransposedFontRow0_12
	.byte $03, $07, $0b, $0f, $13, $17, $1b, $1f, $23, $27, $2b, $2f, $33, $37, $3b, $3f
	.byte $43, $47, $4b, $4f, $53, $57, $5b, $5f, $63, $67, $6b, $6f, $73, $77, $7b, $7f
TransposedFontRow1_12
	.byte $03, $07, $0b, $0f, $13, $17, $1b, $1f, $23, $27, $2b, $2f, $33, $37, $3b, $3f
	.byte $43, $47, $4b, $4f, $53, $57, $5b, $5f, $63, $67, $6b, $6f, $73, $77, $7b, $7f
TransposedFontRow0_13
	.byte $03, $07, $0b, $0f, $13, $17, $1b, $1f, $23, $27, $2b, $2f, $33, $37, $3b, $3f
	.byte $43, $47, $4b, $4f, $53, $57, $5b, $5f, $63, $67, $6b, $6f, $73, $77, $7b, $7f
TransposedFontRow1_13
	.byte $03, $07, $0b, $0f, $13, $17, $1b, $1f, $23, $27, $2b, $2f, $33, $37, $3b, $3f
	.byte $43, $47, $4b, $4f, $53, $57, $5b, $5f, $63, $67, $6b, $6f, $73, $77, $7b, $7f
TransposedFontRow0_14
	.byte $03, $07, $0b, $0f, $13, $17, $1b, $1f, $23, $27, $2b, $2f, $33, $37, $3b, $3f
	.byte $43, $47, $4b, $4f, $53, $57, $5b, $5f, $63, $67, $6b, $6f, $73, $77, $7b, $7f
TransposedFontRow1_14
	.byte $03, $07, $0b, $0f, $13, $17, $1b, $1f, $23, $27, $2b, $2f, $33, $37, $3b, $3f
	.byte $43, $47, $4b, $4f, $53, $57, $5b, $5f, $63, $67, $6b, $6f, $73, $77, $7b, $7f
TransposedFontRow0_15
	.byte $03, $07, $0b, $0f, $13, $17, $1b, $1f, $23, $27, $2b, $2f, $33, $37, $3b, $3f
	.byte $43, $47, $4b, $4f, $53, $57, $5b, $5f, $63, $67, $6b, $6f, $73, $77, $7b, $7f
TransposedFontRow1_15
	.byte $03, $07, $0b, $0f, $13, $17, $1b, $1f, $23, $27, $2b, $2f, $33, $37, $3b, $3f
	.byte $43, $47, $4b, $4f, $53, $57, $5b, $5f, $63, $67, $6b, $6f, $73, $77, $7b, $7f
