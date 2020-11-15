rule bowtie2_index:
    input: genome="genomes/{genome}.fa"
    output:
          'genomes/{genome}.1.bt2', 'genomes/{genome}.2.bt2',
          'genomes/{genome}.3.bt2', 'genomes/{genome}.4.bt2',
           'genomes/{genome}.rev.1.bt2', 'genomes/{genome}.rev.2.bt2'
    conda: "../envs/config.yaml"
    log: "logs/build/{genome}.log"
    benchmark: "benchmarks/build/{genome}.txt"
    params: base_name=lambda wildcards: wildcards.genome
    shell: "bowtie2-build {input.genome} {params.base_name} &> {log}"


rule alignment:
    input: R1='metagenomes/{name}-R1.fastq', R2='metagenomes/{name}-R2.fastq', index=rules.bowtie2_index.output
    output: sam=temp("{name}-{genome}.sam")
    conda: "../envs/config.yaml"
    benchmark: "benchmarks/alignment/{name}-{genome}.txt"
    log: "logs/alignment/{name}-{genome}.log"
    params: index=lambda wildcards: f"genomes/{wildcards.genome}",
    shell: "bowtie2 -x {params.index} -1 {input.R1} -2 {input.R2} -S {output.sam} &> {log}"

rule sort_bam:
    input: sam=rules.alignment.output.sam
    output: bam="bams/{name}-{genome}.sorted.bam"
    benchmark: "benchmarks/sort_bam/{name}-{genome}.txt"
    log: "logs/sort_bam/{name}-{genome}.log"
    conda: "../envs/config.yaml"
    shell: "samtools sort {input.sam} -o {output.bam} &> {log}"

rule index_bam:
    input: bam=rules.sort_bam.output
    output: bam_index="bams/{name}-{genome}.sorted.bam.bai"
    benchmark: "benchmarks/index_bam/{name}-{genome}.txt"
    log: "logs/index_bam/{name}-{genome}.log"
    conda: "../envs/config.yaml"
    shell: "samtools index {input.bam} &> {log}"
