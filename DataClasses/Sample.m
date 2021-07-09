classdef Sample
    %Sample class to store a single RNASeq sample
    properties
        data %vector of data, 1 number per gene id
        gene_ids % cell array of ensembl ids
        gene_names % cell array of gene names
        name % name of sample
    end
    
    methods
        function obj = Sample(name,data,gene_ids,gene_names)
            %Sample construct an instance of dataset class
            % can be called by providing input data or without argument to
            % create an empty Sample object
            if nargin > 0
                obj.name = name;
            else
                obj.name = '';
            end
            if nargin > 1
                obj.data = data;
            else
                obj.data = [];
            end
            if nargin > 2
                obj.gene_ids = gene_ids;
            else
                obj.gene_ids ={};
            end
            if nargin > 3
                obj.gene_names = gene_names;
            else
                obj.gene_names = {};
            end
        end
        
        function geneExp = getExpressionByName(obj,namestr)
            %Returns expression of genes matching namestr. prints results.
            ids = find(contains(obj.gene_names,namestr));
            geneExp = zeros(length(ids),1);
            for ii = 1:length(ids)
                fprintf('%s\t',obj.gene_names{ids(ii)});
                fprintf('%f\t',obj.data(ids(ii)));
                geneExp(ii) = obj.data(ids(ii));
                fprintf('\n');
            end
       
            
        end
    end
end

