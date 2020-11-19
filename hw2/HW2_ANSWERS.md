## Description

For this homework, I used prepared snakemake workflow by anvi team.

Firsly, I prepared some config files required for the workflow: see both `config.json` and `fasta.txt` files.

Secondly, I generated the pipeline graph:

```commandline
anvi-run-workflow -w pangenomics -c config.json --save-workflow-graph
```

![](workflow.png)

Thirdly, I run the workflow using this command:

```commandline
anvi-run-workflow -w pangenomics -c config.json
```

Lastly, I run the server:

```commandline
anvi-display-pan -g 03_PAN/hw2_Bifidobacterium-GENOMES.db -p 03_PAN/hw2_Bifidobacterium-PAN.db
```

## Results

#### 1) How many single-copy core genes did you find?

![](figs/sgc_phylo.png)
![](figs/sgc.png)

The answer is 1.

#### 2) When you organize genomes based on gene cluster frequencies, how many main groups do you observe?

![](figs/order_by_gc_freq.png)

The answer is 2.

#### 3) Which species name would you annotate these genomes with?

For this purpose, I extracted AA sequence for the SGC and use blastp.

Bifidobacterium breve, Bifidobacterium longum, Bifidobacterium felsineum, Bifidobacterium rousetti, etc.

#### 4) According to gene clusters, which two species of Bifidobacterium in this mixture are most closely related?

![](figs/close_sp.png)

Let's blast both B14 contigs and B15 contigs, and both B9 and B7 contigs. (see `gene_cluster.fa` file).

B7: *Bifidobacterium longum*

B9: *Bifidobacterium breve*

B14: *Bifidobacterium longum*

B15: *Bifidobacterium longum*

#### 5) What are the most enriched functions for each of the major clades in the final pangenome? (Pro tip: functional enrichment analysis is covered in the tutorial).

