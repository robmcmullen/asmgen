COLORSPRITE = moldy_burger.png
BWSPRITE = apple-sprite9x11.png

all: cpbg.dsk fonttest.dsk

rowlookup.s: asmgen.py
	python asmgen.py -a mac65 -p 6502 -r > rowlookup.s

collookupbw.s: asmgen.py
	python asmgen.py -a mac65 -p 6502 -s hgrbw -c > collookupbw.s

collookupcolor.s: asmgen.py
	python asmgen.py -a mac65 -p 6502 -c > collookupcolor.s

bwsprite.s: asmgen.py collookupbw.s rowlookup.s $(BWSPRITE)
	python asmgen.py -a mac65 -p 6502 -s hgrbw $(BWSPRITE) -n bwsprite -m -b > bwsprite.s

colorsprite.s: asmgen.py collookupcolor.s rowlookup.s $(COLORSPRITE)
	python asmgen.py -a mac65 -p 6502 -s hgrcolor $(COLORSPRITE) -n colorsprite -m > colorsprite.s

bwtest.dsk: asmgen.py bwtest.s bwsprite.s
	atasm -obwtest.xex bwtest.s -Lbwtest.var -gbwtest.lst
	atrcopy bwtest.dsk boot -b bwtest.xex --brun 6000 -f

colortest.dsk: asmgen.py colortest.s bwsprite.s
	atasm -ocolortest.xex colortest.s -Lcolortest.var -gcolortest.lst
	atrcopy colortest.dsk boot -b colortest.xex --brun 6000 -f

cpbg-asmgen-driver.s: asmgen.py $(BWSPRITE)
	python asmgen.py -a mac65 -p 6502 -s hgrbw -m -k -d -g -f fatfont128.dat -o cpbg $(BWSPRITE) $(COLORSPRITE)

cpbg.xex: cpbg.s cpbg-asmgen-driver.s
	atasm -mae -ocpbg.xex cpbg.s -Lcpbg.var -gcpbg.lst

cpbg.dsk: asmgen.py cpbg.xex
	atrcopy cpbg.dsk boot -b cpbg.xex --brun 6000 -f

fonttest-asmgen-driver.s: asmgen.py fatfont128.dat
	python asmgen.py -a mac65 -p 6502 -s hgrbw -f fatfont128.dat -r -o fonttest

fonttest.dsk: fonttest.s fatfont.s fonttest-asmgen-driver.s slowfont.s
	atasm -ofonttest.xex fonttest.s -Lfonttest.var -gfonttest.lst
	atrcopy fonttest.dsk boot -b fonttest.xex --brun 6000 -f

clean:
	rm -f rowlookup.s collookupbw.s collookupcolor.s
	rm -f bwtest.dsk bwtest.xex bwtest.var bwtest.lst
	rm -f colortest.dsk colortest.xex colortest.var colortest.lst
	rm -f cpbg.dsk cpbg.xex cpbg.var cpbg.lst cpbg-asmgen-driver.s cpbg-bwsprite.s cpbg-hgrcols-7x1.s cpbg-hgrrows.s
	rm -f fonttest.dsk fonttest.xex fonttest-asmgen-driver.s  fonttest.var fonttest.lst
