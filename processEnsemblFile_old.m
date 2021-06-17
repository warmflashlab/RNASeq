function ensemblData = processEnsemblFile(filename,gene_types,exclude_fields, include_fields)
%reads a file for a species and outputs a structure array of genes

if ~exist('gene_types','var')
    gene_types = {'protein_coding'};
end

if ~exist('exclude_fields','var')
    exclude_fields = {'transcript_id'};
end

if ~exist('include_fields','var')
    include_fields = {'gene_name'};
end

q = 1;
fid = fopen(filename,'r');

line_now = '#';
while line_now(1) == '#'
line_now = fgetl(fid);
end

while line_now ~= -1
    newStruct = processEnsembleLine(line_now);
    if any(strcmpi(newStruct.gene_biotype,gene_types)) && ~any(isfield(newStruct,exclude_fields)) && all(isfield(newStruct,include_fields))
        ensemblData(q) = newStruct;
        q = q + 1;
        disp(q);
    end
    line_now = fgetl(fid);
end



function outStruct =  processEnsembleLine(e_line)
id = strfind(e_line,'gene_id');
e_line = e_line(id:end);
line_split = strsplit(strtrim(e_line),';');
for ii = 1:length(line_split)
    inds = strfind(line_split{ii},'"');
    if ~isempty(inds)
    fieldName  = strtrim(line_split{ii}(1:(inds(1)-1)));
    fieldVal = strtrim(line_split{ii}((inds(1)+1):(inds(2)-1)));
    outStruct.(fieldName) = fieldVal;
    end
end
    