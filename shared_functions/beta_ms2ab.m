function [al, be, mu, sigma] = beta_ms2ab(mu, sigma)

if sigma^2 > mu*(1-mu)
    syms als bes
    assume(als,'positive')
    assume(bes,'positive')
    S = vpasolve([als == (( (1-mu)/(sigma^2)) - (1/mu))*(mu^2), bes == als*((1/mu)-1)], [als, bes]);
    S.als;
    S.bes;
    
    %[al, be, mu, sigma] = fit_beta_dist(data);
    %while sigma^2 > mu*(1-mu)
    %    disp(['undefined unique alpha and beta, decreasing sigma from' num2str(sigma) ' to ' num2str(sigma-2)])
    %    sigma = sigma - 0.02;
    %end
    al = S.als;
    be = S.bes;
else
    al = (( (1-mu)/(sigma^2)) - (1/mu))*(mu^2);
    be = al*((1/mu)-1);
end


end

