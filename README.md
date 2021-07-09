# RNASeq
Code for storing and analyzing RNASeq data. Developed by Warmflash lab at Rice University.

### Data classes
Sample - store data from one RNASeq sample
MappedSample - subclass of sample. store one sample mapped to a reference database
RNASeqData - store one dataset (typically one experiment)
Emsembl - store  an ensembl database

### Useful analyses
RNASeqData.getExpressionByName get expression of all genes matching a particular string, across dataset
RNASeqData.differentialExpression perform differential expression analysis across samples in a dataset

### data storage functions
MappedSample - constructor maps the data from sample to an ensembl database
Ensembl - constructor converts file downloaded from ensembl to an Ensembl object
