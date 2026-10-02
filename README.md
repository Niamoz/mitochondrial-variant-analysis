# mitochondrial-variant-analysis

This project contains a mitochondrial variant analysis workflow using publicly available paired-end sequencing data from the European Nucleotide Archive (ENA).

## Dataset

- Run accession: ERR008118
- Study accession: PRJEB1995
- Sample accession: SAMEA772868
- Organism: Mus musculus castaneus
- Library layout: Paired-end
- Reference genome: NC_005089.1

## Workflow

The analysis workflow included:

- Downloading paired-end FASTQ files from ENA
- Indexing the mitochondrial reference genome with BWA
- Mapping reads with BWA-MEM
- Converting, sorting, and indexing BAM files with SAMtools
- Generating alignment statistics
- Calling mitochondrial variants with BCFtools
- Extracting and reviewing detected variants

## Tools Used

- BWA
- SAMtools
- BCFtools
- ENA
- Linux / Command Line

## Results

- Total reads: 3,296,518
- Mapped reads: 29,810
- Mapping rate: 0.90%
- Total detected variants: 380
- SNPs: 378
- Indels: 2
