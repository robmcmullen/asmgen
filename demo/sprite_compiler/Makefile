COLORSPRITE = ../../sprites/moldy_burger.png
BWSPRITE = ../../sprites/apple-sprite9x11.png
ASMGEN_SRC = ../../asmgen.py
ASMGEN = python $(ASMGEN_SRC) -a mac65 -p 6502

all: cpbg.dsk fonttest.dsk

rowlookup.s: $(ASMGEN_SRC)
	$(ASMGEN) -r > rowlookup.s

collookupbw.s: $(ASMGEN_SRC)
	$(ASMGEN) -s hgrbw -c > collookupbw.s

collookupcolor.s: $(ASMGEN_SRC)
	$(ASMGEN) -c > collookupcolor.s

bwsprite.s: $(ASMGEN_SRC) collookupbw.s rowlookup.s $(BWSPRITE)
	$(ASMGEN) -s hgrbw $(BWSPRITE) -n bwsprite -m -b > bwsprite.s

colorsprite.s: $(ASMGEN_SRC) collookupcolor.s rowlookup.s $(COLORSPRITE)
	$(ASMGEN) -s hgrcolor $(COLORSPRITE) -n colorsprite -m > colorsprite.s

bwtest.dsk: $(ASMGEN_SRC) bwtest.s bwsprite.s
	atasm -obwtest.xex bwtest.s -Lbwtest.var -gbwtest.lst
	atrcopy bwtest.dsk boot -b bwtest.xex --brun 6000 -f

colortest.dsk: $(ASMGEN_SRC) colortest.s bwsprite.s
	atasm -ocolortest.xex colortest.s -Lcolortest.var -gcolortest.lst
	atrcopy colortest.dsk boot -b colortest.xex --brun 6000 -f

cpbg-asmgen-driver.s: $(ASMGEN_SRC) $(BWSPRITE)
	$(ASMGEN) -s hgrbw -m -k -d -g -f ../../fonts/fatfont128.dat -o cpbg $(BWSPRITE) $(COLORSPRITE)

cpbg.xex: cpbg.s cpbg-asmgen-driver.s
	atasm -mae -ocpbg.xex cpbg.s -Lcpbg.var -gcpbg.lst

cpbg.dsk: $(ASMGEN_SRC) cpbg.xex
	atrcopy cpbg.dsk boot -b cpbg.xex --brun 6000 -f

fonttest-asmgen-driver.s: $(ASMGEN_SRC) ../../fonts/fatfont128.dat
	$(ASMGEN) -s hgrbw -f ../../fonts/fatfont128.dat -r -o fonttest

fatfont.s:
	$(ASMGEN) --src ../../fonts/fatfont128.dat > fatfont.s

fonttest.dsk: fonttest.s fatfont.s fonttest-asmgen-driver.s slowfont.s
	atasm -ofonttest.xex fonttest.s -Lfonttest.var -gfonttest.lst
	atrcopy fonttest.dsk boot -b fonttest.xex --brun 6000 -f

clean:
	rm -f rowlookup.s collookupbw.s collookupcolor.s
	rm -f bwtest.dsk bwtest.xex bwtest.var bwtest.lst
	rm -f colortest.dsk colortest.xex colortest.var colortest.lst
	rm -f cpbg.dsk cpbg.xex cpbg.var cpbg.lst cpbg-asmgen-driver.s cpbg-bwsprite.s cpbg-hgrcols-7x1.s cpbg-hgrrows.s
	rm -f fonttest.dsk fonttest.xex fonttest-asmgen-driver.s  fonttest.var fonttest.lst
