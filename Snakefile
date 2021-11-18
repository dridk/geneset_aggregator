
#from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
import os

if not os.path.exists('datas'):
    os.makedirs('datas')


rule test:
	input:
		"parsers/{name}.ipynb"
	output:
		"datas/{name}.csv"
	notebook:
		"parsers/hpo.ipynb"