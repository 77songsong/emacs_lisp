#### Makefile for the Emacs Lisp Introduction manual

# Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2001, 2002, 2003,
#   2004, 2005, 2006, 2007, 2008, 2009, 2010 Free Software Foundation, Inc.

# This file is part of GNU Emacs.

# GNU Emacs is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# GNU Emacs is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.


SHELL = /bin/sh

srcdir = .
VPATH = .

infodir = .
# Directory with the (customized) texinfo.tex file.
texinfodir = .

INFO_SOURCES = ${srcdir}/emacs-lisp-intro.texi
# The file name eintr must fit within 5 characters, to allow for
# -NN extensions to fit into DOS 8+3 limits without clashing
INFO_TARGETS = ${infodir}/eintr
DVI_TARGETS = emacs-lisp-intro.dvi

MAKEINFO = makeinfo
TEXI2DVI = texi2dvi
TEXI2PDF = texi2pdf
DVIPS = dvips

.SUFFIXES: .dvi .ps .texi

info: $(INFO_TARGETS)

dvi: $(DVI_TARGETS)

${infodir}/eintr: ${INFO_SOURCES}
	cd $(srcdir); $(MAKEINFO) emacs-lisp-intro.texi -o $(infodir)/eintr

emacs-lisp-intro.dvi: ${INFO_SOURCES}
	$(TEXI2DVI) -I $(srcdir) -I $(texinfodir) $(srcdir)/emacs-lisp-intro.texi

emacs-lisp-intro.pdf: ${INFO_SOURCES}
	$(TEXI2PDF) -I $(srcdir) -I $(texinfodir) $(srcdir)/emacs-lisp-intro.texi

emacs-lisp-intro.html: $(INFO_SOURCES)
	$(MAKEINFO) --html -o $@ $(srcdir)/emacs-lisp-intro.texi

.dvi.ps:
	$(DVIPS) $< -o $@

mostlyclean:
	rm -f  *.log *.cp *.fn *.ky *.pg *.vr *.tp

clean: mostlyclean
	rm -f *.dvi

distclean: clean

maintainer-clean: distclean
	rm -f *.aux *.cps *.fns *.kys *.pgs *.vrs *.toc
	cd $(infodir); rm -f eintr eintr-[1-9]

# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
