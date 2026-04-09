# Install packages
pak::pkg_install(c("tidyverse", "ggrepel", "ggfortify", "ggprism", "ggpubr", 
                   "ggsci", "tidyplots", "pheatmap", "EnhancedVolcano"))


# Load required packages
library(tidyverse)     # For versatile data manipulation
library(ggrepel)       # For non-overlapping text labels
library(ggfortify)     # For statistical visualizations
library(ggprism)       # For publication-ready styling
library(pheatmap)      # For creating heatmaps
library(EnhancedVolcano) # For volcano plots

# ggplot2 extension 
library(tidyplots)
library(ggpubr)
library(ggsci)

# DEGs table 
deg_table <- read_rds("data/processed/GSE52778_DEGs.rds")
deg_table <- as.data.frame(deg_table)

# some processing 
deg_table$gene_symbol <- rownames(deg_table)
rownames(deg_table) <- NULL 

# Filter for Upregulated Genes
up_regulated <- deg_table |> 
  filter(padj < 0.05 & log2FoldChange > 1)

# Filter for Downregulated Genes
down_regulated <- deg_table |> 
  filter(padj < 0.05 & log2FoldChange > -1)

# classification
deg_classified <- deg_table |> 
  mutate(gene_status = case_when(
    padj < 0.05 & log2FoldChange > 1 ~ "Up", 
    padj < 0.05 & log2FoldChange > -1 ~ "Down", 
    TRUE ~ "NS"
  ))

# Summary of gene status 
table(deg_classified$gene_status)

# export classified gene tables 
write.csv(deg_classified, "data/processed/deg_classified_table.csv", row.names = F)


# Set significance thresholds 
pvalue_threshold <- 0.05 
fc_threshold <- 2 

# Quick Visualization with EnhancedVolcano
volcano_plot <- EnhancedVolcano(
  deg_table, 
  x = "log2FoldChange", 
  y = "padj", 
  lab = deg_table$gene_symbol, 
  pCutoff = pvalue_threshold, 
  FCcutoff = fc_threshold, 
  title = "",
  subtitle = "", 
  gridlines.major = FALSE, 
  gridlines.minor = FALSE, 
  labSize = 3, 
  legendLabSize = 16, 
  legendIconSize = 7,
  captionLabSize = 16, 
  colAlpha = 1, 
  pointSize = 0.3
)

volcano_plot

# save the plot 
ggsave(
  "results/figures/volcano_plot.png", 
  volcano_plot,
  device = "png",
  units = "cm", 
  width = 20, 
  height = 16
)