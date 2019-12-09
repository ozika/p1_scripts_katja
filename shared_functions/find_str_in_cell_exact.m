function[doublo] = find_str_in_cell_exact(cello, stringo)
for t = 1:length(cello)
    if strcmp(cello{t}, stringo)
        str(t) = 1;
    else
        str(t) = 0;
    end
end

doublo =[];
c = 1;
for i = 1:length(str)
    if str(i) == 1 
        doublo(c) = i;
        c = c +1;
    end
end
