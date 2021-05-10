function [dat, gnames] = getExpressionMapped(dataset,genestr)

ds = load(dataset);

ens = ds.ensemblData;
gene_names = {ens.gene_name};

expression_data = ds.expressionData{1};

inds = find(contains(gene_names,genestr));
dat = expression_data(inds,:);
nconds = size(dat,2);

for ii = 1:length(inds)
    fprintf('%s\t',gene_names{inds(ii)});
    for jj = 1:nconds
        fprintf('%f\t',dat(ii,jj));
    end
    fprintf('\n');
end