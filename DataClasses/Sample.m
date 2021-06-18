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
            obj.name = name;
            obj.data = data;
            if nargin > 2
                obj.gene_ids = gene_ids;
            end
            if nargin > 3
                obj.gene_names = gene_names;
            end
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

