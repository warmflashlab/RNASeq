function inds = mapGeneSetToDatabase(samples,referenceDatabase)

g_id_db = {referenceDatabase.id};
ngenes = length(g_id_db);
g_id = samples(1).gene_ids;
inds = zeros(ngenes,1);

for ii = 1:ngenes %look for each gene in the database in the dataset
    if ~mod(ii,100)
        disp(ii);
    end
    ind = contains(g_id,g_id_db{ii});
    if any(ind)
        inds(ii) = find(ind);
    else
        inds(ii) = 0;
    end
end