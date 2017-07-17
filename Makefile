COLORSPRITE = moldy_burger.png
#COLORSPRITE = boxw_mag.png
#COLORSPRITE = apple.png
BWSPRITE = apple-sprite9x11.png

all: cpbg.dsk fonttest.dsk titles.dsk

rowlookup.s: HiSprite.py
	python HiSprite.py -a mac65 -p 6502 -r > rowlookup.s

collookupbw.s: HiSprite.py
	python HiSprite.py -a mac65 -p 6502 -s hgrbw -c > collookupbw.s

collookupcolor.s: HiSprite.py
	python HiSprite.py -a mac65 -p 6502 -c > collookupcolor.s

bwsprite.s: HiSprite.py collookupbw.s rowlookup.s $(BWSPRITE)
	python HiSprite.py -a mac65 -p 6502 -s hgrbw $(BWSPRITE) -n bwsprite -m -b > bwsprite.s

colorsprite.s: HiSprite.py collookupcolor.s rowlookup.s $(COLORSPRITE)
	python HiSprite.py -a mac65 -p 6502 -s hgrcolor $(COLORSPRITE) -n colorsprite -m > colorsprite.s

bwtest.dsk: HiSprite.py bwtest.s bwsprite.s
	atasm -obwtest.xex bwtest.s -Lbwtest.var -gbwtest.lst
	atrcopy bwtest.dsk boot -b bwtest.xex --brun 6000 -f

colortest.dsk: HiSprite.py colortest.s bwsprite.s
	atasm -ocolortest.xex colortest.s -Lcolortest.var -gcolortest.lst
	atrcopy colortest.dsk boot -b colortest.xex --brun 6000 -f

multitest-sprite-driver.s: HiSprite.py $(BWSPRITE)
	python HiSprite.py -a mac65 -p 6502 -s hgrbw -m -b -k -d -o multitest $(BWSPRITE) $(COLORSPRITE)

multitest.dsk: HiSprite.py multitest.s multitest-sprite-driver.s
	atasm -omultitest.xex multitest.s -Lmultitest.var -gmultitest.lst
	atrcopy multitest.dsk boot -b multitest.xex --brun 6000 -f

multitestbg.dsk: HiSprite.py multitestbg.s
	atasm -omultitest.xex multitestbg.s -Lmultitestbg.var -gmultitestbg.lst
	atrcopy multitest.dsk boot -b multitest.xex --brun 6000 -f

cpbg-sprite-driver.s: HiSprite.py $(BWSPRITE)
	python HiSprite.py -a mac65 -p 6502 -s hgrbw -m -k -d -g -f fatfont128.dat -o cpbg $(BWSPRITE) $(COLORSPRITE)

cpbg.xex: cpbg.s cpbg-sprite-driver.s
	atasm -mae -ocpbg.xex cpbg.s -Lcpbg.var -gcpbg.lst

cpbg.dsk: HiSprite.py cpbg.xex
	atrcopy cpbg.dsk boot -b cpbg.xex --brun 6000 -f

player-missile.hgr: HiSprite.py player-missile.png
	python HiSprite.py player-missile.png

kansasfest-disclaimer.hgr: HiSprite.py kansasfest-disclaimer.png
	python HiSprite.py -i bw kansasfest-disclaimer.png

blue-gradient.hgr: blue-gradient-bot.png blue-gradient-top.png
	../tohgr-source/tohgr blue-gradient-bot.png
	python HiSprite.py -i bw blue-gradient-top.png
	python HiSprite.py --merge 96 -o blue-gradient blue-gradient-bot.hgr blue-gradient-top.hgr

partycrasher-software.hgr: HiSprite.py partycrasher-software.png
	../tohgr-source/tohgr partycrasher-software.png
	cp partycrasher-software.hgr partycrasher-software-top.hgr
	python HiSprite.py -i bw partycrasher-software.png
	cp partycrasher-software.hgr partycrasher-software-bot.hgr
	python HiSprite.py --merge 116 -o partycrasher-software partycrasher-software-top.hgr partycrasher-software-bot.hgr

titles.dsk: HiSprite.py cpbg.xex player-missile.hgr kansasfest-disclaimer.hgr partycrasher-software.hgr blue-gradient.hgr
	atrcopy titles.dsk boot -d blue-gradient.hgr@2000 partycrasher-software.hgr@4000 player-missile.hgr@2000 -b cpbg.xex --brun 6000 -f
	#atrcopy titles.dsk boot -d partycrasher-software.bin@2000 kansasfest-disclaimer.bin@4000 player-missile-bg.bin@2000 -b cpbg.xex --brun 6000 -f
	#atrcopy titles.dsk boot -d player-missile.hgr@2000 -b cpbg.xex --brun 6000 -f

fonttest.dsk: fonttest.s fatfont.s
	atasm -ofonttest.xex fonttest.s -Lfonttest.var -gfonttest.lst
	atrcopy fonttest.dsk boot -b fonttest.xex --brun 6000 -f

clean:
	rm -f rowlookup.s collookupbw.s collookupcolor.s
	rm -f bwtest.dsk bwtest.xex bwtest.var bwtest.lst
	rm -f colortest.dsk colortest.xex colortest.var colortest.lst
	rm -f multitest.dsk multitest.xex multitest.var multitest.lst multitest-sprite-driver.s multitest-bwsprite.s multitest-hgrcols-7x1.s multitest-hgrrows.s
	rm -f cpbg.dsk cpbg.xex cpbg.var cpbg.lst cpbg-sprite-driver.s cpbg-bwsprite.s cpbg-hgrcols-7x1.s cpbg-hgrrows.s
	rm -f player-missile.hgr kansasfest-disclaimer.hgr partycrasher-software.hgr blue-gradient.hgr
