function [al, be, mu, sigma] = beta_ab2ms(al, be)

mu = al/(al+be);

try
sigma = sqrt((al*be) ./ ( ((al+be)^2) * (al+be+1) ));
catch 
    a=1;
end
end

