classdef MappedSample < Sample
    %MappedSample class to store one RNAseq sample with genes mapped to a
    %reference database
    
    properties
        referenceDatabase %path to reference ensembl database
    end
    
    methods
        function obj = MappedSample(sample,referenceDatabase,refDBName)
            %MappedSample Construct an instance of this class
            obj.referenceDatabase = refDBName;
            obj.name = sample.name;
            g_id_db = {referenceDatabase.id};
            ngenes = length(g_id_db);
            g_id = sample.gene_ids;
            obj.data = zeros(length(g_id_db),1);
            for ii = 1:length(g_id_db) %look for each gene in the database in the dataset
                if ~mod(ii,100)
                    disp(ii);
                end
                ind = contains(g_id,g_id_db{ii});
                if any(ind)
                    obj.data(ii) = sample.data(ind);
                    obj.gene_ids{ii} = sample.gene_ids{ind};
                    obj.gene_names{ii} = sample.gene_names{ind};
                else
                    obj.data(ii) = 0;
                    obj.gene_ids{ii} = '';
                    obj.gene_names{ii} = '';
                end
            end
            
        end
        
   
    end
end

