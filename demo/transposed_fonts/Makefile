# Currently valid assemblers: mac65 and cc65
ASSEMBLER = "mac65"

ASMGEN = python ../../asmgen.py

TARGETS = TEST1A.BIN TEST1B.BIN TEST1C.BIN TEST1D.BIN TEST2.BIN test3--transposed_font.s TEST3.BIN tiles2x2a.s TILES2X2A.BIN tiles4x4a.s TILES4X4A.BIN

all: $(TARGETS)

asmgen_font_compare.dsk:
	atrcopy asmsgen_font_compare.dsk create dos33.dsk -f
	atrcopy asmsgen_font_compare.dsk add HELLO -t A -f

TEST1A.BIN: driver.s test1a--no_optimization.s
	rm -f $@
	cat $^ > temp.s
	atrcopy . assemble -f -d fatfont128.dat@0x6000 -s temp.s -r 0x5000 -o $@
	atrcopy asmsgen_font_compare.dsk add $@ -f

TEST1B.BIN: driver.s test1b--incrementing_font_pointers.s
	rm -f $@
	cat $^ > temp.s
	atrcopy . assemble -f -d fatfont128.dat@0x6000 -s temp.s -r 0x5000 -o $@
	atrcopy asmsgen_font_compare.dsk add $@ -f

TEST1C.BIN: driver.s test1c--assembly_lines_ch31.s
	rm -f $@
	cat $^ > temp.s
	atrcopy . assemble -f -d fatfont128.dat@0x6000 -s temp.s -r 0x5000 -o $@
	atrcopy asmsgen_font_compare.dsk add $@ -f

TEST1D.BIN: driver.s test1d--self_modifying_code.s
	rm -f $@
	cat $^ > temp.s
	atrcopy . assemble -f -d fatfont128.dat@0x6000 -s temp.s -r 0x5000 -o $@
	atrcopy asmsgen_font_compare.dsk add $@ -f

TEST2.BIN: driver.s test2--compiled_font.s
	rm -f $@
	cat $^ > temp.s
	atrcopy . assemble -f -s temp.s -r 0x5000 -o $@
	atrcopy asmsgen_font_compare.dsk add $@ -f

test3--transposed_font.s:
	$(ASMGEN) -a $(ASSEMBLER) -f fatfont128.dat > test3--transposed_font.s

TEST3.BIN: driver.s test3--transposed_font.s
	rm -f $@
	cat $^ > temp.s
	atrcopy . assemble -f -s temp.s -r 0x5000 -o $@
	atrcopy asmsgen_font_compare.dsk add $@ -f

tiles2x2a.s: ../../tiles/tiles_ramp_2x2.dat
	$(ASMGEN) -a $(ASSEMBLER) -f ../../tiles/tiles_ramp_2x2.dat --fs 2x16 > tiles2x2a.s

TILES2X2A.BIN: driver_2x2_tiles.s tiles2x2a.s
	rm -f $@
	cat $^ > temp.s
	atrcopy . assemble -f -s temp.s -r 0x5000 -o $@
	atrcopy asmsgen_font_compare.dsk add $@ -f

tiles4x4a.s: ../../tiles/tiles_ramp_4x4.dat
	$(ASMGEN) -a $(ASSEMBLER) -f ../../tiles/tiles_ramp_4x4.dat --fs 4x32 > tiles4x4a.s

TILES4X4A.BIN: driver_4x4_tiles.s tiles4x4a.s
	rm -f $@
	cat $^ > temp.s
	atrcopy . assemble -f -s temp.s -r 0x5000 -o $@
	atrcopy asmsgen_font_compare.dsk add $@ -f

clean:
	rm -f asmsgen_font_compare.dsk $(TARGETS) temp.s temp.s.lst temp.s.err
