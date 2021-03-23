function [dat, gnames] = getExpression(dataset,genestr)

load(dataset);

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