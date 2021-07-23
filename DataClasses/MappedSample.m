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
            
            if isnumeric(referenceDatabase)
                inds = referenceDatabase;
            else
                inds = mapGeneSetToDatabase(sample,referenceDatabase);
            end
            obj.data = zeros(length(inds),1);
            for ii = 1:length(inds)
                if inds(ii) > 0
                    obj.data(ii) = sample.data(inds(ii));
                    obj.gene_ids{ii} = sample.gene_ids{inds(ii)};
                    obj.gene_names{ii} = sample.gene_names{inds(ii)};
                else
                    obj.data(ii) = 0;
                    obj.gene_ids{ii} = '';
                    obj.gene_names{ii} = '';
                end
            end
        end
        
   
    end
end

