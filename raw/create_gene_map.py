# Create a mapping file between gene name and ensembl_id/entrez_id gene. 
# The output file takes symbol and alias symbol as input 

import pandas as pd 
import sys

HUGO_FILE = "hgnc_complete_set.txt"
hdf = pd.read_csv(HUGO_FILE, sep="\t")

# extract alias symbol gene
alias_df = hdf[["alias_symbol","entrez_id","ensembl_gene_id"]].dropna()
alias_df["alias_symbol"] = alias_df["alias_symbol"].str.split("|")
alias_df= alias_df.explode("alias_symbol").rename({"alias_symbol":"symbol"}, axis=1)

# extract symbol gene
symbol_df = hdf[["symbol","entrez_id","ensembl_gene_id"]]
gene_map_df = pd.concat([symbol_df, alias_df]).dropna().astype({"entrez_id":int, "symbol":str,"ensembl_gene_id":str }).reset_index(drop=True)


gene_map_df.to_csv(sys.stdout,sep="\t", index=False)