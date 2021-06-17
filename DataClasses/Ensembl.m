classdef Ensembl
    %Ensembl class to store record of a single ensemble id
    %
    
    properties
        id
        name
        version
        source
        biotype
    end
    
    methods
        function obj = Ensembl(dataline)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            id = strfind(dataline,'gene_id');
            dataline = dataline(id:end);
            line_split = strsplit(strtrim(dataline),';');
            for ii = 1:length(line_split)
                inds = strfind(line_split{ii},'"');
                if ~isempty(inds)
                    fieldName  = strtrim(line_split{ii}(1:(inds(1)-1)));
                    fieldVal = strtrim(line_split{ii}((inds(1)+1):(inds(2)-1)));
                    outStruct.(fieldName) = fieldVal;
                end
            end
            obj.id = outStruct.gene_id;
            obj.name = outStruct.gene_name;
            obj.biotype = outStruct.gene_biotype;
            obj.source = outStruct.gene_source;
            obj.version = outStruct.gene_version;
        end
        
%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%         end
    end
end

