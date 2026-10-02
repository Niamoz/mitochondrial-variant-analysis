# Enter the working directory
cd ~/Desktop/odev

# Build BWA index for the mitochondrial reference genome
bwa index mt.fasta

# Retrieve FASTQ download links and library layout information from ENA
curl "https://www.ebi.ac.uk/ena/portal/api/filereport?accession=ERR008118&result=read_run&fields=run_accession,fastq_ftp,fastq_bytes,library_layout&format=tsv"

# Download paired-end FASTQ files
curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR008/ERR008118/ERR008118_1.fastq.gz
curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR008/ERR008118/ERR008118_2.fastq.gz

# Map reads to the mitochondrial reference genome
bwa mem mt.fasta ERR008118_1.fastq.gz ERR008118_2.fastq.gz > aligned.sam

# Convert SAM to BAM
samtools view -bS aligned.sam > aligned.bam

# Sort BAM
samtools sort aligned.bam -o aligned.sorted.bam

# Index sorted BAM
samtools index aligned.sorted.bam

# Generate alignment statistics
samtools flagstat aligned.sorted.bam > alignment_stats.txt

# Variant calling
bcftools mpileup -f mt.fasta aligned.sorted.bam | \
bcftools call -mv -Ov -o variants.vcf

# Count detected variants
grep -v "^#" variants.vcf | wc -l

# Generate variant statistics
bcftools stats variants.vcf > variant_stats.txt

# Extract the first 20 variants
bcftools query -f '%POS\t%REF\t%ALT\t%DP\t%QUAL\n' variants.vcf | \
head -20 > top20_variants.tsv
