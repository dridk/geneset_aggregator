%: 
	snakemake -Fp datas/$@.csv --cores 1

download:
	(cd raw/ ; sh download.sh)