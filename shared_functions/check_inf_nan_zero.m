function[data] = check_inf_nan_zero(data, nans, infs, zeroos)
if nans
    data = data(find(~isnan(data)));
    
end

if infs
     data = data(find(~isinf(data)));
end

if zeroos
     data = data(find(data~=0));
end

