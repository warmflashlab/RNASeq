function ensemblData = processEnsemblFile(filename)
%reads a file for a species and outputs a structure array of genes

% if ~exist('gene_types','var')
%     gene_types = {'protein_coding'};
% end
%
% if ~exist('exclude_fields','var')
%     exclude_fields = {'transcript_id'};
% end
%
% if ~exist('include_fields','var')
%     include_fields = {'gene_name'};
% end

q = 1;
fid = fopen(filename,'r');

line_now = '#';
while line_now(1) == '#'
    line_now = fgetl(fid);
end

while line_now ~= -1
    newRecord = Ensembl(line_now);
    ensemblData(q) = newRecord;
    q = q + 1;
    if mod(q,100) == 0
    disp(q);
    end
    line_now = fgetl(fid);
end




