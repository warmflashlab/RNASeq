T2 = readtable('pbio.3000498.s028.xlsx');
gene_names = table2cell(T2(:,1));
gene_ids = table2cell(T2(:,2));
dat =table2array(T2(:,3:10));
conditions = T2.Properties.VariableNames(3:10);
nconds = length(conditions);

for ii = 1:nconds
    samples(ii) = Sample(conditions{ii},dat(:,ii),gene_ids,gene_names);
end
%%
database = '~/Dropbox (Warmflash Lab)/LabFiles/Aryeh/RNAseq/ensemblDatabases/ProteinCodingHuman.mat';
load(database);
for ii = 1:nconds
    mappedSamples(ii) = MappedSample(samples(ii),ensemblHumanProteinCoding,database);
end
%%
conditionIds = [1 1 2 2 3 3 4 4];
conditionNames = {'Control','BMP','BMP+IWP2','BMP+SB'};
dataset = RNASeqData(mappedSamples,database,conditionIds,conditionNames);
%%
save('BMP48h.mat','dataset');