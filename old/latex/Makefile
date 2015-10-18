# Makefile for LaTeX
#
# Arkanon <arkanon@lsd.org.br>
# 2014/03/22 (Sat) 22:07:11 (BRS)
# 2013/02/21 (Qui) 07:52:19 (BRS)
# 2013/02/19 (Ter) 19:07:14 (BRS)
#
# Idea from <http://stuff.mit.edu/people/jcrost/latexmake.html>

# the main file without the extension (.tex)
FILE = fn

VI   = vi
TEX  = latex
VIEW = evince -f

$(FILE).dvi : $(FILE).tex
	echo q | $(TEX) $^

$(FILE).ps  : $(FILE).dvi
	dvips $^

$(FILE).pdf : $(FILE).ps
	ps2pdf $^

$(FILE).svg : $(FILE).pdf
	pdf2svg $^ $(FILE).svg

$(FILE).tar : $(FILE).tex $(FILE).dvi $(FILE).ps $(FILE).pdf
	tar -cvf $(FILE).tar $^

$(FILE).bz2 : $(FILE).tar
	bzip2 -9 -k $^

$(FILE).7z : $(FILE).tar
	7z a -mx=9 -m0=lzma -md=64m -mfb=273 -ms=on $(FILE).tar.7z $^

$(FILE).zip : $(FILE).tex $(FILE).dvi $(FILE).ps $(FILE).pdf
	zip -9 $(FILE).zip $^

edit : $(FILE).tex
	@ [ -e .$(FILE).tex.swp ] && echo "make: Nada a ser feito para 'edit'." || ( echo "$(VI) $^"; $(VI) $^)

view : $(FILE).pdf
	$(VIEW) $^ &> /dev/null &

all : 7z view

clean :
	rm -f $(FILE).{aux,log,out}

cleanpkg :
	rm -f $(FILE).{tar,tar.bz2,tar.7z,zip}

distclean : clean cleanpkg
	rm -f $(FILE).{dvi,pdf,ps}

dvi : $(FILE).dvi
ps  : $(FILE).ps
pdf : $(FILE).pdf
svg : $(FILE).svg
tar : $(FILE).tar
bz2 : $(FILE).bz2
7z  : $(FILE).7z
zip : $(FILE).zip

# EOF
