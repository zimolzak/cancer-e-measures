all: Rplots.pdf mm3-questions.docx

mm3-questions.docx: mm3-questions.txt
	pandoc -o $@ $<

Rplots.pdf: stage-vs-vamc.R ajz-colon-stg-sta3n.csv ajz-lung-stg-sta3n.csv sta3n-stage-year-colon.tsv sta3n-stage-year-lung.tsv
	Rscript stage-vs-vamc.R > Routputs.txt

.PHONY: clean all

clean:
	rm -f Rplots.pdf
