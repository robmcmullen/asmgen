
===========
AsmGen
===========



Abstract
========

AsmGen - code generator for sprites, fonts, and images for Apple ][ hi-res and
Atari 8-bit computers

This program creates 6502 (or 65c02) code for several tasks, including a sprite
complier (based on `HiSprite <https://github.com/blondie7575/HiSprite>`_) that
hardcodes sprite data in unrolled loops for each shifted shape. By removing
image lookups and loops, sprites can be drawn much faster than otherwise
possible.

Other utilities include generating code for reporting screen damage, a fast
bitmap font renderer, and generation for all the row/column lookup tables for
each supported bitmap mode.


Installing From Source
======================

The autogenerator code is written in Python and should run on any platform
that can use python

Prerequisites
-------------

* python 2.7 (but not 3.x yet)
* numpy
* pypng


Fork me!
========

The source is free and open, and lives on `github
<https://github.com/robmcmullen/asmgen>`_, so clone and enhance at will!


Credits
=======

This program started life as a fork of Quinn Dunki's `HiSprite
<https://github.com/blondie7575/HiSprite>`_ that she presented at KansasFest
2017.

The sample font is modified from Michael Pohoreski's `excellent tutorial on
Apple II fonts <https://github.com/Michaelangel007/apple2_hgr_font_tutorial>`_.


Disclaimer
==========

AsmGen, the 6502 code generator sponsored by the Player/Missile Podcast
Copyright (c) 2017 Rob McMullen

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
