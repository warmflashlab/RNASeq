function [dat, names, ids] = differentialExpression(dataset,condition_nums,fcThresh,expressionThresh)

load(dataset);
d1 = mean(expression_data(:,condition_nums{1}),2);
d2 = mean(expression_data(:,condition_nums{2}),2);

fc = d1./d2;

nconds = length(conditions);
goodones = find(fc > fcThresh & d1 > expressionThresh);
fc = fc(goodones);
[~,inds] = sort(fc);
goodones = goodones(inds);
dat = expression_data(goodones,:);
names = gene_names(goodones);
ids = gene_ids(goodones); 





for ii = 1:length(names)
    fprintf('%s\t',names{ii});
    for jj = 1:nconds
        fprintf('%f\t',dat(ii,jj));
    end
    fprintf('\n');
end