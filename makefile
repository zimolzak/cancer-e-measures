Rplots.pdf: stage-vs-vamc.R ajz-colon-stg-sta3n.csv ajz-lung-stg-sta3n.csv
	Rscript stage-vs-vamc.R

.PHONY: clean

clean:
	rm -f Rplots.pdf

