classdef Dataset
    %Dataset class to store one RNASeq experimnt
    %   Detailed explanation goes here
    
    properties
        samples
    end
    
    methods
        function obj = Dataset(samples)
            %Dataset Construct an instance of this class
            obj.samples = samples;
        end
        
%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end

