function expressionData = mapDatasetToDatabase(dataset,database,usenames)

if ~exist('usenames','var')
    usenames = false;
end


%get the gene ids from the database
db = load(database);
ens = db.ensemblData;
switch usenames
    case 1
    g_id_db = {ens.gene_name};
    case 0
    g_id_db = {ens.gene_id};
    case -1
        g_id_db = {ens.gene_id1};
    case -2
        g_id_db = {ens.gene_id2};
end
ngenes = length(g_id_db);
expressionData = cell(length(dataset),1);

%loop over dataets
for dd = 1:length(dataset)
    ds = load(dataset{dd});
    if usenames > 0
        g_id = ds.gene_names;
    else
        g_id = ds.gene_ids;
    end
    conds = ds.conditions;
    expressionData{dd} = zeros(ngenes,length(conds));
    emp = zeros(1,length(conds));
    
    for ii = 1:length(g_id_db) %look for each gene in the database in the dataset
        if ~mod(ii,100)
            disp(ii);
        end
        ind = contains(g_id,g_id_db{ii});
        if any(ind)
            expressionData{dd}(ii,:) = ds.expression_data(ind,:);
        else
            expressionData{dd}(ii,:) = emp;
        end
    end
end


