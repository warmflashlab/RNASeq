dataset = {'DataSets/BMP48h.mat'};
database = 'ensembl/humanEnsemblGenes.mat';
expressionData = mapDatasetToDatabase(dataset,database);
load(database);
save('MappedDataSets/ensHumanBMP48h','expressionData','ensemblData');
%%
dataset = {'DataSets/WntRNASeq.mat'};
database = 'ensembl/humanEnsemblGenes.mat';
expressionData = mapDatasetToDatabase(dataset,database);
load(database);
save('MappedDataSets/ensHumanWnt.mat','expressionData','ensemblData');
%%
dataset = {'DataSets/Sox2Micropattern.mat'};
database = 'ensembl/humanEnsemblGenes.mat';
expressionData = mapDatasetToDatabase(dataset,database);
load(database);
save('MappedDataSets/ensHumanSox2Micropattern.mat','expressionData','ensemblData');