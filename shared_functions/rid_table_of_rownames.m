function[tbl] = rid_table_of_rownames(tbl)
d = array2table(table2array(tbl));
p = tbl.Properties.VariableNames;
h = tbl.Properties.RowNames;
header = {'names'};
for i = 1:numel(p)
    header{i+1} = p{i};
end

tbl = [cell2table(h) d];
tbl.Properties.VariableNames = header;