# <img src="../img/pepatac_logo_black.svg" alt="PEPATAC" class="img-fluid" style="max-height:35px; margin-top:-15px; margin-bottom:-10px">  usage reference

`PEPATAC` command-line usage instructions:



`python pipelines/pepatac.py --help`
```{console}
usage: pepatac.py [-h] [-R] [-N] [-D] [-F] [-C CONFIG_FILE] -O
                  PARENT_OUTPUT_FOLDER [-M MEMORY_LIMIT] [-P NUMBER_OF_CORES]
                  -S SAMPLE_NAME -I INPUT_FILES [INPUT_FILES ...]
                  [-I2 [INPUT_FILES2 [INPUT_FILES2 ...]]] -G GENOME_ASSEMBLY
                  [-Q SINGLE_OR_PAIRED] [--peak-caller {fseq,macs2}]
                  [-gs GENOME_SIZE] [--trimmer {trimmomatic,pyadapt,skewer}]
                  [--prealignments PREALIGNMENTS [PREALIGNMENTS ...]]
                  [--deduplicator {picard,samblaster}] [--TSS-name TSS_NAME]
                  [--blacklist BLACKLIST] [--frip-ref-peaks FRIP_REF_PEAKS]
                  [--anno-name ANNO_NAME] [--keep] [--noFIFO] [--lite] [-V]

PEPATAC version 0.8.6

optional arguments:
  -h, --help            show this help message and exit
  -R, --recover         Overwrite locks to recover from previous failed run
  -N, --new-start       Overwrite all results to start a fresh run
  -D, --dirty           Don't auto-delete intermediate files
  -F, --force-follow    Always run 'follow' commands
  -C CONFIG_FILE, --config CONFIG_FILE
                        Pipeline configuration file (YAML). Relative paths are
                        with respect to the pipeline script.
  -M MEMORY_LIMIT, --mem MEMORY_LIMIT
                        Memory limit for processes accepting such. Default
                        units are megabytes unless specified using the suffix
                        [K|M|G|T].
  -P NUMBER_OF_CORES, --cores NUMBER_OF_CORES
                        Number of cores for parallelized processes
  -I2 [INPUT_FILES2 [INPUT_FILES2 ...]], --input2 [INPUT_FILES2 [INPUT_FILES2 ...]]
                        Secondary input files, such as read2
  -Q SINGLE_OR_PAIRED, --single-or-paired SINGLE_OR_PAIRED
                        Single- or paired-end sequencing protocol
  --peak-caller {fseq,macs2}
                        Name of peak caller
  -gs GENOME_SIZE, --genome-size GENOME_SIZE
                        MACS2 genome size
  --trimmer {trimmomatic,pyadapt,skewer}
                        Name of read trimming program
  --prealignments PREALIGNMENTS [PREALIGNMENTS ...]
                        Space-delimited list of reference genomes to align to
                        before primary alignment.
  --deduplicator {picard,samblaster}
                        Name of deduplicator program
  --TSS-name TSS_NAME   Name of TSS annotation file
  --blacklist BLACKLIST
                        Name of peak blacklist file
  --frip-ref-peaks FRIP_REF_PEAKS
                        Reference peak set for calculating FRiP
  --anno-name ANNO_NAME
                        Reference bed file for calculating FRiF
  --keep                Keep prealignment BAM files
  --noFIFO              Do NOT use named pipes during prealignments
  --lite                Only keep minimal, essential output to conserve disk
                        space.
  -V, --version         show program's version number and exit

required named arguments:
  -O PARENT_OUTPUT_FOLDER, --output-parent PARENT_OUTPUT_FOLDER
                        Parent output directory of project
  -S SAMPLE_NAME, --sample-name SAMPLE_NAME
                        Name for sample to run
  -I INPUT_FILES [INPUT_FILES ...], --input INPUT_FILES [INPUT_FILES ...]
                        One or more primary input files
  -G GENOME_ASSEMBLY, --genome GENOME_ASSEMBLY
                        Identifier for genome assembly
```
