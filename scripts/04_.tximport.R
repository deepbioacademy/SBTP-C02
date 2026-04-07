# Imports transcript-level quantification from Salmon 
# Summarizes to gene-level counts for DESeq2. 

# Install packages 
pak::pkg_install(c("tidyverse", "tximport", "DESeq2", "EnsDb.Hsapiens.v86", "AnnotationDbi"))

# Load packages 
library(tidyverse)
library(tximport)
library(DESeq2)
library(EnsDb.Hsapiens.v86)


# Get the files and metadata 
# Collect the sample quants files 
samples <- list.dirs("data/salmon_quants/", recursive = FALSE, full.names = FALSE)
samples

# Check quant files 
quant_files <- file.path("data/salmon_quants", samples, "quant.sf")
quant_files

# Samples 
names(quant_files) <- samples 
quant_files

# Ensure each file actually exists 
# All should be TRUE 
file.exists(quant_files)

# Create metadata 
# Metadata for DESeq2: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE52778
col_data <- data.frame(
  condition = factor(rep(c("untreated", "dex"), times = 4)), 
  row.names = samples
)

write.csv(col_data, "data/metdata/GSE52778_metdata.csv")

# Get the mapping from transcript IDs to gene symbol 
# What are the columsn in the database?
columns(EnsDb.Hsapiens.v86)
keys(EnsDb.Hsapiens.v86)

# Get the TXID and SYMBOL columns for all entries in database 
tx2gene <- AnnotationDbi::select(
  EnsDb.Hsapiens.v86, 
  keys = keys(EnsDb.Hsapiens.v86), 
  columns = c("TXID", "SYMBOL")
)

head(tx2gene)

# Remove the GENEID column from tx2gene data 
tx2gene <- dplyr::select(tx2gene, -GENEID)
head(tx2gene)


# Compile the tximport counts object and make DESeq dataset 
# Get the tximport 
txi <- tximport(
  files = quant_files, 
  type = "salmon", 
  tx2gene = tx2gene, 
  ignoreTxVersion = TRUE
)

# Check class of txi 
class(txi)


# explore raw counts 
raw_counts <- txi$counts
write.csv(raw_counts, "data/raw_data/GSE52778_raw_counts.csv", row.names = F)
write_rds(raw_counts, "data/raw_data/GSE52778_raw_counts.rds")

# explore normalized (TPM)
tpm_counts <- txi$abundance
write.csv(tpm_counts, "data/raw_data/GSE52778_tpm_counts.csv", row.names = F)
write_rds(tpm_counts, "data/raw_data/GSE52778_tpm_counts.rds")

# Make DESeq
dds <- DESeqDataSetFromTximport(
  txi = txi, 
  colData = col_data, 
  design = ~condition
)

# PCA Analysis 
rlog_dds <- rlog(dds)
plotPCA(rlog_dds)

# PCA data 
pca_data <- plotPCA(rlog_dds,  intgroup = "condition", returnData = TRUE)
write.csv(pca_data, "data/processed/GSE52778_pca_data.csv", row.names = F)
write_rds(pca_data, "data/processed/GSE52778_pca_data.rds")

# Differential Gene Expression Analysis (DEGs)
dds <- DESeq(dds)

# Explore results 
res_df <- results(dds)
write.csv(res_df, "data/processed/GSE52778_res_df.csv", row.names = F)
write_rds(res_df, "data/processed/GSE52778_res_df.rds")











