# Pipeline started at 01-08 10:18:24

ln -sf /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/examples/data/tutorial_r1.fastq.gz /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/raw/tutorial_R1.fastq.gz

ln -sf /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/examples/data/tutorial_r2.fastq.gz /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/raw/tutorial_R2.fastq.gz

pigz -p 2 -d -c /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/raw/tutorial_R1.fastq.gz > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R1.fastq

pigz -p 2 -d -c /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/raw/tutorial_R2.fastq.gz > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R2.fastq

skewer -f sanger -t 2 -m pe -x /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/NexteraPE-PE.fa --quiet -o /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R1.fastq /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R2.fastq

mv /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial-trimmed-pair1.fastq /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R1.trim.fastq

mv /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial-trimmed-pair2.fastq /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R2.trim.fastq

fastqc --noextract --outdir /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastqc /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R1.trim.fastq

fastqc --noextract --outdir /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastqc /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R2.trim.fastq

mkfifo /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/rCRSd_bt2

perl /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/filter_paired_fq.pl /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/rCRSd_bt2 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R1.trim.fastq /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R2.trim.fastq /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_rCRSd_unmap_R1.fq /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_rCRSd_unmap_R2.fq

(bowtie2 -p 2 -k 1 -D 20 -R 3 -N 1 -L 20 -i S,1,0.50 -x /nm/t1/genomes/rCRSd/indexed_bowtie2/rCRSd --rg-id tutorial -U /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/fastq/tutorial_R1.trim.fastq --un /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/rCRSd_bt2 > /dev/null) 2>/sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_rCRSd_bt_aln_summary.log

grep 'aligned exactly 1 time' /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_rCRSd_bt_aln_summary.log | awk '{print $1}'

mkfifo /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/human_repeats_bt2

perl /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/filter_paired_fq.pl /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/human_repeats_bt2 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_rCRSd_unmap_R1.fq /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_rCRSd_unmap_R2.fq /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_human_repeats_unmap_R1.fq /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_human_repeats_unmap_R2.fq

(bowtie2 -p 2 -k 1 -D 20 -R 3 -N 1 -L 20 -i S,1,0.50 -x /nm/t1/genomes/human_repeats/indexed_bowtie2/human_repeats --rg-id tutorial -U /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_rCRSd_unmap_R1.fq --un /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/human_repeats_bt2 > /dev/null) 2>/sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_human_repeats_bt_aln_summary.log

grep 'aligned exactly 1 time' /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_human_repeats_bt_aln_summary.log | awk '{print $1}'

bowtie2 -p 2 --very-sensitive -X 2000 --rg-id tutorial -x /nm/t1/genomes/hg38/indexed_bowtie2/hg38 -1 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_human_repeats_unmap_R1.fq -2 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_human_repeats_unmap_R2.fq | samtools view -bS - -@ 1  | samtools sort - -@ 1 -T /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tmptVnmNF -o /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_temp.bam

samtools view -q 10 -b -@ 2 -U /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_fail_qc.bam -f 2 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_temp.bam > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort.bam

gzip /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_rCRSd_unmap_R1.fq

gzip /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_rCRSd_unmap_R2.fq

gzip /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_human_repeats_unmap_R1.fq

gzip /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/prealignments/tutorial_human_repeats_unmap_R2.fq

samtools index /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_temp.bam

samtools index /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort.bam

samtools idxstats /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_temp.bam | grep -we 'chrM' -we 'chrMT' -we 'M' -we 'MT'| cut -f 3

samtools idxstats /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort.bam | cut -f 1 | grep -vwe 'chrM' -vwe 'chrMT' -vwe 'M' -vwe 'MT'| xargs samtools view -b -@ 2 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort.bam > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_noMT.bam

mv /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_noMT.bam /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort.bam

samtools index /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort.bam

/sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/bamQC.py -i /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort.bam -c 2 -o /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_bamQC.tsv

awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "NRF") c=i } getline; print $c }' /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_bamQC.tsv

awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "PBC1") c=i } getline; print $c }' /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_bamQC.tsv

awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "PBC2") c=i } getline; print $c }' /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_bamQC.tsv

samtools view -b -@ 2 -f 12  /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_temp.bam > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_unmap.bam

samtools view -c -f 4 -@ 2 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_temp.bam

samtools sort -n -@ 2 -T /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tmpLrA_r5 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort.bam | samtools view -h - -@ 2 | samblaster -r 2> /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_dedup_metrics_log.txt | samtools view -b - -@ 2 | samtools sort - -@ 2 -T /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tmpLrA_r5 -o /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam

samtools index /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam

grep 'Removed' /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_dedup_metrics_log.txt | cut -f 3 -d ' '

/sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/bamSitesToWig.py -i /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam -c /nm/t1/genomes/hg38/hg38.chromSizes -b /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38_exact/tutorial_shift.bed -o /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38_exact/tutorial_exact.bw -w /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_smooth.bw -p 1

touch /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38_exact/temp/flag_completed

/sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/pyTssEnrichment.py -a /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam -b /nm/t1/genomes/hg38/hg38_TSS.tsv -p ends -c 2 -e 2000 -u -v -s 4 -o /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_TssEnrichment.txt

Rscript /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/PEPATAC_TSSenrichmentPlot.R /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_TssEnrichment.txt pdf

perl /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/fragment_length_dist.pl /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_fragLen.txt

sort -n  /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_fragLen.txt | uniq -c  > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_fragCount.txt

Rscript /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/fragment_length_dist.R /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_fragLen.txt /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_fragCount.txt /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_fragLenDistribution.pdf /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_fragLenDistribution.txt

macs2 callpeak -t /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38_exact/tutorial_shift.bed -f BED -g hs --outdir /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38 -n tutorial -q 0.01 --shift 0 --nomodel

samtools view -@ 4 -c -L /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks.narrowPeak /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam

Rscript /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/narrowPeakToBigBed.R /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks.narrowPeak /nm/t1/genomes/hg38/hg38.chromSizes bedToBigBed /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks.bigBed

cut -f 1-3 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks.narrowPeak > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks.bed

samtools view -H /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam | grep 'SN:' | awk -F':' '{print $2,$3}' | awk -F' ' -v OFS='	' '{print $1,$3}' > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt

bedtools sort -i /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks.bed -faidx /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks_sort.bed

bedtools coverage -sorted -counts -a /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks_sort.bed -b /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam -g /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks_coverage.bed

ln -sf /sfs/lustre/scratch/jps3dp/tools/databio/pepatac/anno/hg38_annotations.bed.gz /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/raw/hg38_annotations.bed.gz

gunzip -c /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/raw/hg38_annotations.bed.gz | cut -f 4 | sort -u

gunzip -c /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/raw/hg38_annotations.bed.gz | awk -F'	' '{print>"/sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/"$4}'

cut -f 1-3 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/3_UTR | bedtools sort -i stdin -faidx /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/3_UTR_sort.bed

bedtools coverage -sorted -counts -a /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/3_UTR_sort.bed -b /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam -g /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_3_UTR_coverage.bed

cut -f 1-3 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/5_UTR | bedtools sort -i stdin -faidx /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/5_UTR_sort.bed

bedtools coverage -sorted -counts -a /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/5_UTR_sort.bed -b /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam -g /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_5_UTR_coverage.bed

cut -f 1-3 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Exon | bedtools sort -i stdin -faidx /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Exon_sort.bed

bedtools coverage -sorted -counts -a /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Exon_sort.bed -b /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam -g /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_Exon_coverage.bed

cut -f 1-3 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Intron | bedtools sort -i stdin -faidx /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Intron_sort.bed

bedtools coverage -sorted -counts -a /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Intron_sort.bed -b /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam -g /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_Intron_coverage.bed

cut -f 1-3 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Promoter | bedtools sort -i stdin -faidx /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Promoter_sort.bed

bedtools coverage -sorted -counts -a /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Promoter_sort.bed -b /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam -g /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_Promoter_coverage.bed

cut -f 1-3 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Promoter_Flanking_Region | bedtools sort -i stdin -faidx /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Promoter_Flanking_Region_sort.bed

bedtools coverage -sorted -counts -a /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/Promoter_Flanking_Region_sort.bed -b /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam -g /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/chr_order.txt > /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_Promoter_Flanking_Region_coverage.bed

samtools view -@ 2 -q 15 -c -F4 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/aligned_hg38/tutorial_sort_dedup.bam

Rscript /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/PEPATAC_frip.R tutorial /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks_coverage.bed 1746450 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_frif.pdf --bed /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_3_UTR_coverage.bed /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_5_UTR_coverage.bed /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_Exon_coverage.bed /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_Intron_coverage.bed /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_Promoter_coverage.bed /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38/tutorial_Promoter_Flanking_Region_coverage.bed

Rscript /sfs/lustre/scratch/jps3dp/tools/databio//pepatac/tools/PEPATAC_annotation.R /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/raw/hg38_annotations.bed.gz /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/peak_calling_hg38/tutorial_peaks.narrowPeak tutorial hg38 /sfs/lustre/allocations/shefflab/processed/tutorial/results_pipeline/tutorial/QC_hg38

