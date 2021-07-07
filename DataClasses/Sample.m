classdef Sample
    %Sample class to store a single RNASeq sample
    properties
        data
        gene_ids
        gene_names
        name
    end
    
    methods
        function obj = Sample(name,data,gene_ids,gene_names)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
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
            
            ids = find(contains(obj.gene_names,namestr));
            for ii = 1:length(ids)
                fprintf('%s\t',obj.gene_names{ids(ii)});
                fprintf('%f\t',obj.data(ids(ii)));
                geneExp(ii) = obj.data(ids(ii));
                fprintf('\n');
            end
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
        end
    end
end

