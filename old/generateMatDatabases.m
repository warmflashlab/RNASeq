ensemblData = processEnsemblFile('Homo_sapiens.GRCh38.103.chr');
save('humanEnsemblGenes.mat','ensemblData');
%%
ensemblData = processEnsemblFile('Mus_musculus.GRCm39.103.chr');
save('mouseEnsemblGenes.mat','ensemblData');
%%
ensemblData = processEnsemblFile('Macaca_fascicularis.Macaca_fascicularis_6.0.103.chr');
save('monkeyEnsemblGenes.mat','ensemblData');
%%
d1 = load('humanEnsemblGenes.mat');
d2 = load('mouseEnsemblGenes.mat');
mD = generateMergedDatabase('humanEnsemblGenes.mat','mouseEnsemblGenes.mat');
humanMouse = mD;
human = d1.ensemblData;
mouse = d2.ensemblData;
save('humanMouse.mat','humanMouse','human','mouse');
%%
d2 = load('monkeyEnsemblGenes.mat');
mD = generateMergedDatabase('humanEnsemblGenes.mat','monkeyEnsemblGenes.mat');
humanMonkey = mD;
human = d1.ensemblData;
monkey = d2.ensemblData;
save('humanMonkey.mat','humanMonkey','human','monkey');