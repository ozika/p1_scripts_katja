function[doublo] = find_str_in_cell(cello, stringo)
str = strfind(cello, stringo);
doublo =[];
c = 1;
for i = 1:length(str)
    if ~isempty(str{i}) 
        doublo(c) = i;
        c = c +1;
    end
end
