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
            % Construct a new object of Dataset class
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
            %getDataMatrix: export data from all samples as a matrix
            
            datamatrix = zeros(length(obj.samples(1).data),length(obj.samples));
            for ii = 1:length(obj.samples)
                datamatrix(:,ii) = obj.samples(ii).data;
            end
        end
        
        function avgdatamatrix = getAverageDataMatrix(obj)
            %getAverageDataMatrix: export data from all samples, average
            %over replicates.
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
            %returns the conditions of the samples. Will include all
            %replicates separately. For unique conditions, use property
            %conditionNames
            conds = {obj.samples.name};
        end
        
        function [outdata, geneNames]=getExpressionByName(obj,namestr,avgOverReplicates,onlyExact)
            % getExpressionByName: returns expression of a particular
            % gene/genes by name. 
            % optional arguments: 
            % avgOverReplicates - true to average over replicates (default
            % true)
            % onlyExact - true for only exact matches (default false)
            if ~exist('avgOverReplicates','var')
                avgOverReplicates = true;
            end
            
            if ~exist('onlyExact','var')
                onlyExact = false;
            end
            
            gene_names = obj.samples(1).gene_names;
            if onlyExact
                inds = find(matches(gene_names,namestr));
            else
                inds = find(contains(gene_names,namestr));
            end
            if avgOverReplicates
                dat = obj.getAverageDataMatrix;
            else
                dat = obj.getDataMatrix;
            end
            nconds = size(dat,2);
            outdata = dat(inds,:);
            geneNames = gene_names(inds);
            for ii = 1:length(inds)
                fprintf('%s\t',gene_names{inds(ii)});
                for jj = 1:nconds
                    fprintf('%f\t',dat(inds(ii),jj));
                end
                fprintf('\n');
            end
        end        
        
    end
end

