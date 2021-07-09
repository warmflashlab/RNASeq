classdef Dataset
    %Dataset class to store one RNASeq experimnt
    
    properties
        samples % MappedSample objects in an array, one per sample
        referenceDatabase % store link to the ref database
        conditionIds % id numbers for conditions, keeps track of replicates
        conditionNames %names of conditions, one entry per id. 
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
            ngenes = size(dm,1);
            avgdatamatrix = zeros(ngenes,length(uIds));
            for ii = uIds
                inds = cIds == uIds(ii);
                avgdatamatrix(:,ii) = mean(dm(:,inds),2);
            end
            
        end
        
        function conds = getConditions(obj)
            conds = {obj.samples.name};
        end
        
        function getExpressionByName(obj,namestr,avgOverReplicates)
            
            if ~exist('avgOverReplicates','var')
                avgOverReplicates = true;
            end
            
            gene_names = obj.samples(1).gene_names;
            inds = find(contains(gene_names,namestr));
            if avgOverReplicates
                dat = obj.getAverageDataMatrix;
            else
                dat = obj.getDataMatrix;
            end
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

