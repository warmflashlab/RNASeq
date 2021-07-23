classdef RNASeqData
    %Dataset class to store one RNASeq experimnt
    
    properties
        samples % MappedSample objects in an array, one per sample
        referenceDatabase % store link to the ref database
        conditionIds % id numbers for conditions, keeps track of replicates
        conditionNames %names of conditions, one entry per id.
    end
    
    methods
        function obj = RNASeqData(varargin)
            % Construct a new object of Dataset class
            
            inputs = varargin2parameter(varargin);
            
            if isfield(inputs,'samples')
                obj.samples = inputs.samples;
            else
                obj.samples =[];
            end
            if isfield(inputs,'referenceDatabase')
                obj.referenceDatabase = inputs.referenceDatabase;
            else
                obj.referenceDatabase = '';
            end
            if isfield(inputs,'conditionIds')
                obj.conditionIds = inputs.conditionIds;
            else
                obj.conditionIds =[];
            end
            if isfield(inputs,'conditionNames')
                obj.conditionNames = inputs.conditionNames;
            else
                obj.conditionNames = {};
            end
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
            %getConditions: returns the conditions of the samples. Will include all
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
        
        function [dat, names, ids] = differentialExpression(obj,condition_nums,fcThresh,expressionThresh,avgOverReplicates)
            %differentialExpression: get differentially expressed genes
            % arguments:
            %condition_nums - true element cell array containing sample numbers to compare.
            % each entry can be a vector of samples which will be averaged
            % over
            % fcThresh: threshold for fold change to be considered
            % differential
            % expressionData: threshold for expression, data value must be
            % at least this high in higher sample
            % avgOverReplicates - if true will average over replicates
            if ~exist('avgOverReplicates','var')
                avgOverReplicates = true;
            end
            
            if avgOverReplicates
                expression_data = obj.getAverageDataMatrix;
                conditions = obj.conditionNames;
            else
                expression_data = obj.getDataMatrix;
                conditions = obj.getConditions;
            end
            
            gene_names = obj.samples(1).gene_names;
            gene_ids = obj.samples(1).gene_ids;
            
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
            
        end
    end
end

