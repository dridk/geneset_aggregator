#!/bin/bash

echo "Download HPO"
wget -nc http://purl.obolibrary.org/obo/hp/hpoa/phenotype.hpoa

echo "Download Hugo"
wget -nc http://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt

echo "Download omim"
wget -nc https://www.omim.org/static/omim/data/mim2gene.txt
wget -nc https://raw.githubusercontent.com/materechm/plabData/master/yeast_replaceable_genes/OMIM/genemap2.txt


# Compute gene_map 

python create_gene_map.py > gene_map.csv 


# Compute hash 
sha1sum * >  checksums.sha1

