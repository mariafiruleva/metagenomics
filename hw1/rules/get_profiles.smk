rule gen_contigs_db:
    input: genome="genomes/{genome}.fa"
    output: db="genomes/{genome}.db"
    benchmark: "benchmarks/gen_contigs_db/{genome}.txt"
    log: "logs/gen_contigs_db/{genome}.log"
    conda: "../envs/config.yaml"
    shell: "anvi-gen-contigs-database -f {input.genome} -o {output.db} &> {log}"

rule get_profile:
    input: db=rules.gen_contigs_db.output.db, bam=rules.sort_bam.output.bam, bam_index=rules.index_bam.output.bam_index
    output: out_dir=directory('{name}-{genome}-profile')
    benchmark: "benchmarks/get_profile/{name}-{genome}.txt"
    log: "logs/get_profile/{name}-{genome}.log"
    conda: "../envs/config.yaml"
    shell: "anvi-profile -i {input.bam} -c {input.db} -o {output.out_dir} &> {log}"

rule merge_profiles:
    input: db=expand("genomes/{genome}.db", genome='mystery_genome'),
           profiles=expand("{name}-{genome}-profile/PROFILE.db", name=names, genome='mystery_genome')
    output: out_dir=directory('merged_profiles')
    benchmark: "benchmarks/merge_profiles/merge_profiles.txt"
    log: "logs/merge_profiles/merge_profiles.log"
    conda: "../envs/config.yaml"
    params: profiles=lambda wildcards, input: f'{input.profiles}/PROFILE.db'
    shell: "anvi-merge {params.profiles} -c {input.db} -o {output.out_dir} &> {log}"