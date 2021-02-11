############################################################################
#
# Makefile for abntex2-DCOMP-UFS
#
# ddantas 22/10/2020
#
############################################################################

bsc:
	make Modelo-TCC-DCOMP

msc:
	make Modelo-Mestrado-DCOMP


%: %.tex
	echo "Running latex..."
	pdflatex $@.tex
	bibtex $@
	pdflatex $@.tex
	pdflatex $@.tex
	evince $@.pdf

$@.dvi: clean $@.tex
	echo "Running latex..."
	latex $@.tex
	echo "Running makeindex..."
	#makeindex $@.idx
	echo "Rerunning latex...."
	latex $@.tex
	latex_count=5 ; \
	while egrep -s 'Rerun (LaTeX|to get cross-references right)' refman.log && [ $$latex_count -gt 0 ] ;\
	    do \
	      echo "Rerunning latex...." ;\
	      latex $(FILENAME).tex ;\
	      latex_count=`expr $$latex_count - 1` ;\
	    done

clean:
	rm -f *.ps *.dvi *.aux *.toc *.idx *.ind *.ilg *.log *.out *.brf *.blg *.bbl *.loa *.loc *.lof *.loq *.lot
