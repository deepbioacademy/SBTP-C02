# Pathway analysis helps us:
# 1. Connect expression changes to known biological mechanisms
# 2. Provide biological context for our experimental findings
# 3. Generate hypotheses for further investigation

# Install packages 
pak::pkg_install(c("tidyverse", "clusterProfiler", "org.Hs.eg.db", 
                   "org.Mm.eg.db", "org.Rn.eg.db", "pathview", 
                   "enrichplot", "DOSE", "ReactomePA"))

# Load packages 
library(tidyverse)
library(clusterProfiler)
library(org.Hs.eg.db)
library(org.Mm.eg.db)
library(org.Rn.eg.db)
library(DOSE)
library(enrichplot)


# Load our data 
deg_table <- read.csv("data/processed/deg_classified_table.csv")

# significance threshold
p_threshold <- 0.05
fc_threshold <- 2

# Gene Set Enrichment Analysis (GSEA)
# GSEA uses a running-sum statistic to analyze gene distribution patterns within ranked lists.
# Force symbols to uppercase before ranking
# 1. Prepare and Rank the list using the native pipe |>
gene_list <- deg_table |>
  # Remove rows with NA in critical columns
  filter(!is.na(log2FoldChange), !is.na(pvalue)) |>
  # Create a composite rank: sign of fold change * -log10 of p-value
  mutate(rank_metric = sign(log2FoldChange) * -log10(pvalue)) |>
  # Standardize symbols: uppercase and no extra spaces
  mutate(gene_symbol = toupper(trimws(gene_symbol))) |>
  # If there are duplicate gene symbols, keep the one with the strongest rank
  group_by(gene_symbol) |>
  slice_max(order_by = abs(rank_metric), n = 1, with_ties = FALSE) |>
  ungroup() |>
  # Sort in descending order
  arrange(desc(rank_metric)) |>
  # Pull the values and names
  (\(df) {
    vec <- df$rank_metric
    names(vec) <- df$gene_symbol
    return(vec)
  })()

gene_list

# 2. Run GSEA with relaxed parameters to identify signals
enrich_go_gsea <- gseGO(
  geneList     = gene_list, 
  OrgDb        = org.Hs.eg.db, 
  ont          = "BP",        # 'BP' is often more biologically meaningful than 'ALL'
  keyType      = "SYMBOL", 
  pvalueCutoff = 0.01,         # Slightly relaxed to see trending pathways
  minGSSize    = 10, 
  maxGSSize    = 500, 
  eps          = 0,           # Critical for newer versions to prevent p-value errors
  verbose      = FALSE
)

# Gene Ontology (GO)
# gene functions, processes, and cellular location
# 1. Molecular Function (MF)
# 2. Biological Process (BP)
# 3. Cellular Component (CC)

# KEGG (Kyoto Encyclopedia of Genes and Genomes)


# Molecular Signatures Database (MSigDB)




