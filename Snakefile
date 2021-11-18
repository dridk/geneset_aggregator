
#from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
import os
import pandas as pd 

if not os.path.exists('datas'):
    os.makedirs('datas')


rule parse_file:
	input:
		"parsers/{name}.ipynb"
	output:
		"datas/{name}.csv"
	notebook:
		"parsers/{wildcards.name}.ipynb"


rule merge:
	input:
		"datas/omim.csv",
		"datas/cosmic.csv",
		"datas/hpo.csv"
	output:
		"datas/merge.csv"
	run:
		pd.concat([pd.read_csv(file,sep='\t', comment="#", index_col="ensembl_id") for file in input],  axis=1, join='outer').to_csv(output[0],sep=";")
			


