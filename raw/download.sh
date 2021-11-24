#!/bin/bash

HPO_URL=http://purl.obolibrary.org/obo/hp/hpoa/genes_to_phenotype.txt
HUGO_URL=http://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt
MIMGENE_URL=https://www.omim.org/static/omim/data/mim2gene.txt
OMIM_URL=https://raw.githubusercontent.com/materechm/plabData/master/yeast_replaceable_genes/OMIM/genemap2.txt
ENSEMBL_URL=http://ftp.ensembl.org/pub/release-104/gtf/homo_sapiens/Homo_sapiens.GRCh38.104.gtf.gz



# Download Cosmic 
COSMIC_URL=https://cancer.sanger.ac.uk/cosmic/file_download/GRCh38/cosmic/v95/cancer_gene_census.csv
COSMIC_EMAIL=sacha@labsquare.org
COSMIC_PASSWORD=@Descent7
COSMIC_TOKEN=$(echo ${COSMIC_EMAIL}:${COSMIC_PASSWORD}|base64)

curl -H "Authorization: Basic {COSMIC_TOKEN}" https://cancer.sanger.ac.uk/cosmic/file_download/GRCh38/cosmic/v95/cancer_gene_census.csv > cosmic.tmp.json

cat cosmic.tmp.json

exit(0)



echo "Download HPO"
wget -nc $HPO_URL -O genes_to_phenotype.txt

echo "Download Hugo"
wget -nc $HUGO_URL -O hgnc_complete_set.txt

echo "Download omim"
wget -nc $MIMGENE_URL -O mim2gene.txt
wget -nc $OMIM_URL -O genemap2.txt

echo "Download Ensembl gene"
wget -nc $ENSEMBL_URL -O Homo_sapiens.GRCh38.gtf.gz

# Compute gene_map 

python create_gene_map.py > gene_map.csv 


zcat Homo_sapiens.GRCh38.gtf.gz|
grep -v "#"|
awk 'BEGIN{OFS="\t"; print("ensembl_id", "gene_name","start","end","type")} $3 == "gene"{print $10, $14,$4,$5,$18}'|
sed "s/[\";]//g" > ensembl_gene.tsv



# Compute hash 
sha1sum * >  checksums.sha1

