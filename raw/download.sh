#!/bin/bash

echo "Download HPO"
wget -nc http://purl.obolibrary.org/obo/hp/hpoa/phenotype.hpoa

echo "Download Hugo"
wget -nc http://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt

echo "Download omim"
wget -nc https://www.omim.org/static/omim/data/mim2gene.txt
wget -nc https://raw.githubusercontent.com/materechm/plabData/master/yeast_replaceable_genes/OMIM/genemap2.txt

echo "Download Ensembl gene"
wget -nc http://ftp.ensembl.org/pub/release-92/gtf/homo_sapiens/Homo_sapiens.GRCh38.92.gtf.gz

# Compute gene_map 

python create_gene_map.py > gene_map.csv 

zcat Homo_sapiens.GRCh38.92.gtf.gz|
grep -v "#"|
awk 'BEGIN{OFS="\t"; print("ensembl_id", "gene_name","start","end","type")} $3 == "gene"{print $10, $14,$4,$5,$18}'|
sed "s/[\";]//g" > ensembl_gene.tsv



# Compute hash 
sha1sum * >  checksums.sha1

