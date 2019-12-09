function[I] = find_multiple_strings_in_cell(cello, stringo)
 I = 1:numel(cello);
for s = 1:numel(stringo)
   I = intersect(I, find_str_in_cell(cello, stringo{s}));
end