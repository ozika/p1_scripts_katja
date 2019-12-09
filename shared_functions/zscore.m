function[outarray] = zscore(array)
me = mean(array);
sd = std(array);
outarray = (array - me)./sd;