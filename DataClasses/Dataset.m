classdef Dataset
    %Dataset class to store one RNASeq experimnt
    
    properties
        samples
        referenceDatabase
        conditionIds
        conditionNames
    end
    
    methods
        function obj = Dataset(samples,referenceDatabase,conditionIds,conditionNames)
            %Dataset Construct an instance of this class
            obj.samples = samples;
            if nargin > 1
                obj.referenceDatabase = referenceDatabase;
            else
                obj.referenceDatabase = '';
            end
            obj.conditionIds = conditionIds;
            obj.conditionNames = conditionNames;
        end
        
        function datamatrix = getDataMatrix(obj)
            %datamatrix export data from all samples as a matrix
            %   Detailed explanation goes here
            datamatrix = zeros(length(obj.samples(1).data),length(obj.samples));
            for ii = 1:length(obj.samples)
                datamatrix(:,ii) = obj.samples(ii).data;
            end
        end
        
        function avgdatamatrix = getAverageDataMatrix(obj)
            dm = obj.getDataMatrix;
            cIds = obj.conditionIds;
            uIds = sort(unique(cIds));
            for ii = cIds
                inds = cIds == cIds(
            end
            
        end
        
        function conds = getConditions(obj)
            conds = {obj.samples.name};
        end
        
        function getExpressionByName(obj,namestr)
            gene_names = obj.samples(1).gene_names;
            inds = find(contains(gene_names,namestr));
            dat = obj.getDataMatrix;
            nconds = size(dat,2);
            
            for ii = 1:length(inds)
                fprintf('%s\t',gene_names{inds(ii)});
                for jj = 1:nconds
                    fprintf('%f\t',dat(inds(ii),jj));
                end
                fprintf('\n');
            end
        end
        %new comment
        
        
    end
end

