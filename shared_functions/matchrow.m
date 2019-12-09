function[log] = matchrow(M, row)
for i = 1:size(M,1)
    mat_row = M(i,:);
    if sum(mat_row==row) == length(row)
        log(i) = 1;
    else
        log(i) =0;
    end

end