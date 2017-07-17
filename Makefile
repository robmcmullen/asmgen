COLORSPRITE = moldy_burger.png
BWSPRITE = apple-sprite9x11.png

all: cpbg.dsk fonttest.dsk

rowlookup.s: quicksprite.py
	python quicksprite.py -a mac65 -p 6502 -r > rowlookup.s

collookupbw.s: quicksprite.py
	python quicksprite.py -a mac65 -p 6502 -s hgrbw -c > collookupbw.s

collookupcolor.s: quicksprite.py
	python quicksprite.py -a mac65 -p 6502 -c > collookupcolor.s

bwsprite.s: quicksprite.py collookupbw.s rowlookup.s $(BWSPRITE)
	python quicksprite.py -a mac65 -p 6502 -s hgrbw $(BWSPRITE) -n bwsprite -m -b > bwsprite.s

colorsprite.s: quicksprite.py collookupcolor.s rowlookup.s $(COLORSPRITE)
	python quicksprite.py -a mac65 -p 6502 -s hgrcolor $(COLORSPRITE) -n colorsprite -m > colorsprite.s

bwtest.dsk: quicksprite.py bwtest.s bwsprite.s
	atasm -obwtest.xex bwtest.s -Lbwtest.var -gbwtest.lst
	atrcopy bwtest.dsk boot -b bwtest.xex --brun 6000 -f

colortest.dsk: quicksprite.py colortest.s bwsprite.s
	atasm -ocolortest.xex colortest.s -Lcolortest.var -gcolortest.lst
	atrcopy colortest.dsk boot -b colortest.xex --brun 6000 -f

cpbg-sprite-driver.s: quicksprite.py $(BWSPRITE)
	python quicksprite.py -a mac65 -p 6502 -s hgrbw -m -k -d -g -f fatfont128.dat -o cpbg $(BWSPRITE) $(COLORSPRITE)

cpbg.xex: cpbg.s cpbg-sprite-driver.s
	atasm -mae -ocpbg.xex cpbg.s -Lcpbg.var -gcpbg.lst

cpbg.dsk: quicksprite.py cpbg.xex
	atrcopy cpbg.dsk boot -b cpbg.xex --brun 6000 -f

fonttest.dsk: fonttest.s fatfont.s
	atasm -ofonttest.xex fonttest.s -Lfonttest.var -gfonttest.lst
	atrcopy fonttest.dsk boot -b fonttest.xex --brun 6000 -f

clean:
	rm -f rowlookup.s collookupbw.s collookupcolor.s
	rm -f bwtest.dsk bwtest.xex bwtest.var bwtest.lst
	rm -f colortest.dsk colortest.xex colortest.var colortest.lst
	rm -f cpbg.dsk cpbg.xex cpbg.var cpbg.lst cpbg-sprite-driver.s cpbg-bwsprite.s cpbg-hgrcols-7x1.s cpbg-hgrrows.s
	rm -f fonttest.dsk fonttest.xex fonttest.var fonttest.lst
