
===========
AsmGen
===========



Abstract
========

AsmGen - 6502 assembly code generator for sprites, fonts, and images for Apple
][ hi-res and Atari 8-bit computers

This program creates 6502 (or 65c02) code for several tasks, including a high
speed font rendering engine and a sprite compiler. The font rendered can plot
font glyphs (or game tiles) much faster than normal tile drawing routines. The
sprite complier (based on `HiSprite
<https://github.com/blondie7575/HiSprite>`_) hardcodes sprite data in unrolled
loops for each shifted shape. By removing image lookups and loops, sprites can
be drawn much faster than otherwise possible.

Other utilities include generating code for reporting screen damage, screen
clearing, screen scrolling, and generation for all the row/column lookup tables
for each supported bitmap mode.


Installation
============

The autogenerator code is written in Python and should run on any platform
that can use python. It requires:

* python 3.6 (and above)
* numpy
* pypng

the latter two of which will be installed automatically when using the Python
package manager::

    pip install asmgen

Starting with version 2.0, python 2 support has been dropped.


Installing From Source
----------------------

To contribute bug fixes or enhancements, it would be useful to get an account
on github and clone the source to your own account. You can then send me pull
requests for any modifications you would like to see included.

If you just want to clone the source to look at it, use::

    git clone https://github.com/robmcmullen/asmgen.git


Using the Code Generator
==========================

The code generator is a command line tool that creates text files that can be
used as source code for assemblers.  Its general usage is::

    asmgen.py [OPTIONS] -o ROOTNAME

which will create one file called ''ROOTNAME-driver.s'' and one or more files
containing generated code as specified by ''OPTIONS''. This driver file is a
convenience that only exists to include all the other generated files. This
means that your build process only needs to include ``ROOTNAME-driver.s``
instead of needing to be updated if you add aditional code generation options.

Assembler Support
-----------------

Code generation is supported for the following assemblers:

* cc65 (the default)
* MAC/65

Contributors welcome for other assemblers, like Merlin, MADS, dasm, xasm, etc.


Code Generation Capabilities
----------------------------

* Transposed font code generator
* Sprite compiler
* Screen clearing
* Screen vertical scrolling
* Hi-res row lookup table generation

Experimental (and unsupported)
------------------------------

* Font compiler (slower than the transposed font code)
* Run-length encoding of images
* Merge two hi-res images, switching images at specified scan line


Transposed Font
===============

To generate source code for a fast font renderer, you will need a binary font
file. The code generator will embed the binary data as ``.byte`` directives (or equivalent for the chosen assembler) because the transposition requires reordering of the data. The usage is::

    asmgen.py -f FONTFILENAME -o ROOTNAME

It will create two source files, the ``ROOTNAME-driver.s`` file described
above, and the file of interest called ``ROOTNAME-fastfont.s`` which contains
the generated code and data for use of the transposed font.  The entry point
look like this::

    FASTFONT_H1 ; A = character, X = column, Y = row; A is clobbered, X&Y are not
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

``FASTFONT_H1_JMP`` is a jump table, broken into high and low bytes.

The input is described in the comment: the glyph in the accumulator, column
value (0-39) in the X register, and row value (0-23) in the Y register. Note
that no error checking is done here, so it will happily trash data in some
unintended part of RAM if you pass it values that are out of range.

Use it like this::

    lda #65  ; ASCII character 'A'
    ldx #20  ; column 20 (counting from zero)
    ldy #5   ; row 5 (counting from zero)
    jsr FASTFONT_H1



Fork me!
========

The source is free and open, and lives on `github
<https://github.com/robmcmullen/asmgen>`_, so clone and enhance at will!


History
=======

This program started life as a friendly fork of Quinn Dunki's `HiSprite
<https://github.com/blondie7575/HiSprite>`_ that she presented at KansasFest
2017.

Her conclusion was that it was not that practical for the Apple II because of
the limited memory and the number of sprite shifts needed. I wanted to port
this to the Atari because it would require fewer shifted shapes in most of the
graphics modes (e.g. only 4 shifted shapes for the commonly used ANTIC modes 13
and 14) She told me that she was unlikely to continue work on sprite compiling
but encouraged me to continue development.


Additional Credits
==================

The sample font is modified from Michael Pohoreski's `excellent tutorial on
Apple II fonts <https://github.com/Michaelangel007/apple2_hgr_font_tutorial>`_.


License
==========

AsmGen, the 6502 code generator sponsored by the Player/Missile Podcast
Copyright (c) 2017-2018 Rob McMullen

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


Generated Code License
----------------------

While the code for AsmGen itself is licensed under the GPLv3, the code it
produces is licensed under the the Creative Commons Attribution 4.0
International (CC BY 4.0), so you are free to use the generated code for
commercial or non-commercial purposes.
