function mergedData = generateMergedDatabase(datafile1,datafile2)

d1 = load(datafile1,'ensemblData');
d2 = load(datafile2,'ensemblData');
q = 1;
tic;
for ii = 1:length(d1.ensemblData)

    if mod(q,100) == 0
        disp(ii);
        toc;
    end
    f = @(x) strcmpi(d1.ensemblData(ii).gene_name,x.gene_name);
    cmp = arrayfun(f,d2.ensemblData);
    if any(cmp)
        in1 = d1.ensemblData(ii);
        in2 = d2.ensemblData(cmp);
        mergedData(q).gene_name = in1.gene_name;
        mergedData(q).gene_id1 = in1.gene_id;
        mergedData(q).gene_id2 = in2.gene_id;
        q = q + 1;
        disp(q);
    end
end