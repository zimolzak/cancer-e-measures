Rplots.pdf: stage-vs-vamc.R ajz-colon-stg-sta3n.csv ajz-lung-stg-sta3n.csv sta3n-stage-year-colon.tsv sta3n-stage-year-lung.tsv
	Rscript stage-vs-vamc.R

.PHONY: clean

clean:
	rm -f Rplots.pdf
