# Change log
All notable changes to this project will be documented in this file.

## [0.7.0] -- Unreleased



## [0.6.0] -- 2017-12-14

### Added
- Single-end reads are now allowed
- Pipeline can now accommodate `.bam` input files
- Added a single-base bed file output in addition to the smoothed version

### Changed
- Fixed a bug with peak counting for fseq
- Fixed a bug with reporting estimated library sizes
- Fixed issues with TSS enrichment calculation that could lead to stalled jobs or excess CPU use
- Reduced verbosity of error messages for some tools
- Reduced amount of resources requested by default
- Introduced requirement on pypiper v0.7

## [0.5.0] -- 2017-09-13

### Added
- Added rudimentary figure reporting

### Changed
- Changed default trimmer from trimmomatic to skewer
- Made output from several tasks less verbose to make logs cleaner
- Fixed an issue that left behind temporary samtools files if the job was killed

## [0.4.0] -- 2017-07-21

### Added
- Added [fseq](https://github.com/aboyle/F-seq) as a peak caller option
- Peak caller is now specified by a command line argument (defaults to macs2)
- Count of called peaks is now reported as a pipeline result
- Add R and ggplot2 as requirements

### Changed
- Changed TSS plotting to use R instead of python
- TSS plot failures no longer fail the pipeline.
- Changed `Read_type` to `read_type` to prevent duplicate columns
- Read trimmer is now specified in option + argument style rather than as a flag.

## [0.3.0] -- 2017-06-22

### Added
- Added exact cuts calculation
- Added command-line version display
- Added skewer as a trimmer option 
- Uses looper 'implied columns' (from looper v0.6) to derive multiple variables from organism value

### Changed
- Generalizes decoy alignments to pre-alignments, with a new `--prealignment` option
- Simplified unmapped read processing to be output by bowtie directly, improving efficiency
- Fixed bug that hard-coded mouse genome size in for macs, and fixed pipeline interface
- Updated to new looper pipeline interface format
- Pipeline now requires looper v0.6 or greater
- Improved README

## [0.2.0] -- 2017-04-17
### Added
- FRiP can now be calculated based on reference peaks
- Pipeline now reports Picard estimated library size statistic
- Added option for pyadapt trimming
- Added example project using 'gold standard' data
- Added new resource package grades
- Added preliminary 'exact cuts' scripts, but they are not yet used

### Changed
- Improved README
- Changed filename of the TSS file
- Reorganized structure of alignment code

## [0.1.0]
### Added
- First release of ATAC-seq pypiper pipeline