To run fastqc on FASTQ files:
Use fastqc -o to "Create all output files in the specified output directory."
fastqc -o directory/ files (as gzip or unzipped)
Ex.
fastqc -o ../2_rnaseq/3_analysis/1_fastqc/ ../2_rnaseq/1_fastq/cd4_rep1_read1.fastq.gz
fastqc -o ../2_rnaseq/3_analysis/1_fastqc/ ../2_rnaseq/1_fastq/cd4_rep1_read2.fastq.gz
(There's a way to do multiple files at the same time, but I wasn't sure how)

Download html files (transfer using filezilla) and open on the web

To run multiqc on html files:
multiqc -o
Create directory to place new reports
Go to directory containing html reports just aquired
Ex.
multiqc . -o ../reports

Again, download html files with filezilla to open on the web
